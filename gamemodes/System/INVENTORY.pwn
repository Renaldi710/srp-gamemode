
#include <YSI\y_hooks>

new PlayerText: inv_select[MAX_PLAYERS][16],
    PlayerText: inv_name[MAX_PLAYERS][16],
    PlayerText: inv_amount[MAX_PLAYERS][16],
    PlayerText: inv_model[MAX_PLAYERS][16],
    PlayerText: inv_gui[MAX_PLAYERS][15],
    invPage[MAX_PLAYERS];

enum inventoryData
{
	invExists,
	invID,
	invItem[32 char],
	invModel,
	invQuantity
};

new InventoryData[MAX_PLAYERS][MAX_INVENTORY][inventoryData];

enum e_InventoryItems
{
	e_InventoryItem[32],
	e_InventoryModel,
    e_InventoryMax,
    bool:e_InventoryDrop
};

new const g_aInventoryItems[][e_InventoryItems] =
{
	{"Rolling Paper", 19873, 50, true},
	{"Rolled Weed", 3027, 50, true},
	{"Weed", 1578, 50, true},
	{"Weed Seed", 1279, 1000, true},
	{"9mm Luger", 19995, 50, true},
	{"12 Gauge", 19995, 50, true},
	{"9mm Silenced Schematic", 3111, 50, true},
	{"Shotgun Schematic", 3111, 50, true},
	{"9mm Silenced Material", 3052, 50, true},
	{"Shotgun Material", 3052, 50, true},
	{"Axe", 19631, 50, true},
	{"Bait", 19566, 1000, true},
    //bawaan lrp
    {"Gold", 19941, 10000, true},
    {"Walkie Talkie", 19942, 1, true},
    {"Medicine", 1575, 50, true},
    {"Medkit", 1575, 50, true},
    {"Mask", 19036, 1, true},
    {"GPS", 18875, 1, true},
	{"Phone", 18867, 1, true},
	{"Snack", 2768, 100, true},
	{"Sprunk", 2958, 100, true},
    {"Gas", 1650, 50, true},
    {"Bandage", 11747, 100, true},
    {"Material", 17051, 1000, true},
    {"Component", 19627, 1000, true},
    {"Food", 19568, 1000, true},
    {"Seed", 11745, 1000, true},
    {"Potato", 19577, 1000, true},
    {"Wheat", 2247, 1000, true},
    {"Orange", 19574, 1000, true},
    {"Marijuana", 1578, 1000, true},
    {"Fish Tool", 18632, 1, true},
    {"Bait", 19566, 1000, true},
    {"Fish", 1599, 1000, true},
    {"Obat", 1580, 50, true},
    {"SG_Schematic", 3111, 50, true},
    {"DE_Schematic", 3111, 50, true},
    {"MP5_Schematic", 3111, 50, true},
    {"AK47_Schematic", 3111, 50, true},
    {"Pot", 1578, 500, true},
    {"Crack", 1575, 500, true}
};

Inventory_Clear(playerid)
{
	static
	    string[64];

	forex(i, MAX_INVENTORY)
	{
	    if (InventoryData[playerid][i][invExists])
	    {
	        InventoryData[playerid][i][invExists] = 0;
	        InventoryData[playerid][i][invModel] = 0;
	        InventoryData[playerid][i][invQuantity] = 0;
		}
	}
	mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d'", pData[playerid][pID]);
	return mysql_tquery(g_SQL, string);
}

Inventory_GetItemID(playerid, const item[])
{
	forex(i, MAX_INVENTORY)
	{
	    if (!InventoryData[playerid][i][invExists])
	        continue;

		if (!strcmp(InventoryData[playerid][i][invItem], item)) return i;
	}
	return -1;
}

Inventory_GetFreeID(playerid)
{
	if (Inventory_Items(playerid) >= 20)
		return -1;

	forex(i, MAX_INVENTORY)
	{
	    if (!InventoryData[playerid][i][invExists])
	        return i;
	}
	return -1;
}

Inventory_Items(playerid)
{
    new count;

    forex(i, MAX_INVENTORY) if (InventoryData[playerid][i][invExists]) {
        count++;
	}
	return count;
}

Inventory_Count(playerid, const item[])
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	    return InventoryData[playerid][itemid][invQuantity];

	return 0;
}

PlayerHasItem(playerid, const item[])
{
	return (Inventory_GetItemID(playerid, item) != -1);
}

stock Inventory_Set(playerid, const item[], model, amount)
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1 && amount > 0)
		Inventory_Add(playerid, item, model, amount);

	else if (amount > 0 && itemid != -1)
	    Inventory_SetQuantity(playerid, item, amount);

	else if (amount < 1 && itemid != -1)
	    Inventory_Remove(playerid, item, -1);

	return 1;
}

stock Inventory_MaxCount(item[])
{
    for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if(!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true)) {
        return g_aInventoryItems[i][e_InventoryMax];
    }
    return 0;
}

stock Inventory_SetQuantity(playerid, const item[], quantity)
{
	new
	    itemid = Inventory_GetItemID(playerid, item),
	    string[128];

	if (itemid != -1)
	{
	    format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, pData[playerid][pID], InventoryData[playerid][itemid][invID]);
	    mysql_tquery(g_SQL, string);

	    InventoryData[playerid][itemid][invQuantity] = quantity;
	}
	return 1;
}

stock Inventory_Remove(playerid, const item[], quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid != -1)
	{
	    if (InventoryData[playerid][itemid][invQuantity] > 0)
	    {
	        InventoryData[playerid][itemid][invQuantity] -= quantity;
		}
		if (quantity == -1 || InventoryData[playerid][itemid][invQuantity] < 1)
		{
		    InventoryData[playerid][itemid][invExists] = false;
		    InventoryData[playerid][itemid][invModel] = 0;
		    InventoryData[playerid][itemid][invQuantity] = 0;
		    strpack(InventoryData[playerid][itemid][invItem], "", 32 char);

		    mysql_format(g_SQL, string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d' AND `invID` = '%d'", pData[playerid][pID], InventoryData[playerid][itemid][invID]);
	        mysql_tquery(g_SQL, string);

			/*forex(i, MAX_INVENTORY)
			{
			    InventoryData[playerid][i][invExists] = false;
			    InventoryData[playerid][i][invModel] = 0;
			    InventoryData[playerid][i][invQuantity] = 0;
			}
			new invQuery[256];

		    mysql_format(g_SQL,invQuery, sizeof(invQuery), "SELECT * FROM `inventory` WHERE `ID` = '%d'", pData[playerid][pID]);
			mysql_tquery(g_SQL, invQuery, "LoadPlayerItems", "d", playerid);*/
		}
		else if (quantity != -1 && InventoryData[playerid][itemid][invQuantity] > 0)
		{
			mysql_format(g_SQL, string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` - %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, pData[playerid][pID], InventoryData[playerid][itemid][invID]);
            mysql_tquery(g_SQL, string);
		}
		return 1;
	}
	return 0;
}

stock Inventory_Add(playerid, const item[], model, quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
	        InventoryData[playerid][itemid][invExists] = true;
	       // InventoryData[playerid][itemid][invModel] = model;
	        InventoryData[playerid][itemid][invQuantity] = quantity;

	        strpack(InventoryData[playerid][itemid][invItem], item, 32 char);

            if(model == -1)
            {
                for (new id = 0; id < sizeof(g_aInventoryItems); id ++) if(!strcmp(g_aInventoryItems[id][e_InventoryItem], item, true))
                {
                    InventoryData[playerid][itemid][invModel] = g_aInventoryItems[id][e_InventoryModel];
                }
            }
            else
            {
                InventoryData[playerid][itemid][invModel] = model;
            }

			format(string, sizeof(string), "INSERT INTO `inventory` (`ID`, `invItem`, `invModel`, `invQuantity`) VALUES('%d', '%s', '%d', '%d')", pData[playerid][pID], item, model, quantity);
			mysql_tquery(g_SQL, string, "OnInventoryAdd", "dd", playerid, itemid);
	        return itemid;
		}
		return -1;
	}
	else
	{
	    format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, pData[playerid][pID], InventoryData[playerid][itemid][invID]);
	    mysql_tquery(g_SQL, string);

	    InventoryData[playerid][itemid][invQuantity] += quantity;
	}
	return itemid;
}

function OnInventoryAdd(playerid, itemid)
{
	InventoryData[playerid][itemid][invID] = cache_insert_id();
	return 1;
}


function OnPlayerUseItem(playerid, itemid, const name[])
{
    if(!strcmp(name, "Bandage"))
    {   
        if(Inventory_Count(playerid, "Bandage") < 1)
			return Error(playerid, "Anda tidak memiliki perban.");

        new Float:darah;
        GetPlayerHealth(playerid, darah);
        Inventory_Remove(playerid, "Bandage", 1);
        SetPlayerHealthEx(playerid, darah+5);
        Info(playerid, "Anda telah berhasil menggunakan perban.");
        InfoTD_MSG(playerid, 3000, "Restore +5 Health");
        CloseInventory(playerid);
    }
    else if(!strcmp(name, "Snack"))
    {
        if(Inventory_Count(playerid, "Snack") < 1)
			return Error(playerid, "Anda tidak memiliki snack.");

        Inventory_Remove(playerid, "Snack", 1);
        pData[playerid][pHunger] += 15;
        Info(playerid, "Anda telah berhasil menggunakan snack.");
        InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
        ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
        CloseInventory(playerid);
    }
    else if(!strcmp(name, "Sprunk"))
    {
        if(Inventory_Count(playerid, "Sprunk") < 1)
			return Error(playerid, "Anda tidak memiliki sprunk.");

        Inventory_Remove(playerid, "Sprunk", 1);
        pData[playerid][pEnergy] += 15;
        Info(playerid, "Anda telah berhasil meminum sprunk.");
        InfoTD_MSG(playerid, 3000, "Restore +15 Energy");
        ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
        CloseInventory(playerid);
    }
    else if(!strcmp(name, "Gas"))
    {
        if(Inventory_Count(playerid, "Gas") < 1)
			return Error(playerid, "Anda tidak memiliki gas.");
            
        if(IsPlayerInAnyVehicle(playerid))
            return Error(playerid, "Anda harus berada diluar kendaraan!");
        
        if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
        
        new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
        if(IsValidVehicle(vehicleid))
        {
            new fuel = GetVehicleFuel(vehicleid);
        
            if(GetEngineStatus(vehicleid))
                return Error(playerid, "Turn off vehicle engine.");
        
            if(fuel >= 999.0)
                return Error(playerid, "This vehicle gas is full.");
        
            if(!IsEngineVehicle(vehicleid))
                return Error(playerid, "This vehicle can't be refull.");

            if(!GetHoodStatus(vehicleid))
                return Error(playerid, "The hood must be opened before refull the vehicle.");

            Inventory_Remove(playerid, "Gas", 1);
            Info(playerid, "Don't move from your position or you will failed to refulling this vehicle.");
            ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
            pData[playerid][pActivity] = SetTimerEx("RefullCar", 1000, true, "id", playerid, vehicleid);
            PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Refulling...");
            PlayerTextDrawShow(playerid, ActiveTD[playerid]);
            ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
            CloseInventory(playerid);
            /*InfoTD_MSG(playerid, 10000, "Refulling...");
            //SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s starts to refulling the vehicle.", ReturnName(playerid));*/
        }
    }
    else if(!strcmp(name, "Medicine"))
    {
        if(Inventory_Count(playerid, "Medicine") < 1)
            return Error(playerid, "Anda tidak memiliki medicine");
        
        Inventory_Remove(playerid, "Medicine", 1);
        pData[playerid][pSick] = 0;
        pData[playerid][pSickTime] = 0;
        SetPlayerDrunkLevel(playerid, 0);
        Info(playerid, "Anda menggunakan medicine.");
        
        //InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
        ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
        CloseInventory(playerid);
    }
    else if(!strcmp(name, "Obat"))
    {
        if(Inventory_Count(playerid, "Obat") < 1)
            return Error(playerid, "Anda tidak memiliki Obat Myricous.");
        
        Inventory_Remove(playerid, "Obat", 1);
        pData[playerid][pSick] = 0;
        pData[playerid][pSickTime] = 0;
        pData[playerid][pHead] = 100;
        pData[playerid][pPerut] = 100;
        pData[playerid][pRHand] = 100;
        pData[playerid][pLHand] = 100;
        pData[playerid][pRFoot] = 100;
        pData[playerid][pLFoot] = 100;
        SetPlayerDrunkLevel(playerid, 0);
        Info(playerid, "Anda menggunakan Obat Myricous.");
        
        //InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
        ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
        CloseInventory(playerid);
    }
    else if(!strcmp(name, "Marijuana"))
    {
        if(Inventory_Count(playerid, "Marijuana") < 1)
            return Error(playerid, "Anda tidak memiliki Marijuana.");
        
        new Float:armor;
        GetPlayerArmour(playerid, armor);
        if(armor+10 > 90) return Error(playerid, "Over dosis!");
        
        Inventory_Remove(playerid, "Marijuana", 1);
        SetPlayerArmourEx(playerid, armor+10);
        SetPlayerDrunkLevel(playerid, 4000);
        ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
        CloseInventory(playerid);
    }
    else if(!strcmp(name, "GPS"))
    {
        callcmd::gps(playerid, "");
        CloseInventory(playerid);
    }
	return 1;
}

function LoadPlayerItems(playerid)
{
	new name[128];
	new count = cache_num_rows();
	if(count > 0)
	{
	    forex(i, count)
	    {
	        InventoryData[playerid][i][invExists] = true;

	        cache_get_value_name_int(i, "invID", InventoryData[playerid][i][invID]);
	        cache_get_value_name_int(i, "invModel", InventoryData[playerid][i][invModel]);
	        cache_get_value_name_int(i, "invQuantity", InventoryData[playerid][i][invQuantity]);

	        cache_get_value_name(i, "invItem", name);

			strpack(InventoryData[playerid][i][invItem], name, 32 char);
		}
	}
	return 1;
}

CMD:setitem(playerid, params[])
{
	new
	    userid,
		item[32],
		amount;

	if (pData[playerid][pAdmin] < 6)
	    return Error(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "uds[32]", userid, amount, item))
	    return Usage(playerid, "/setitem [playerid/PartOfName] [amount] [item name]");

	for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if (!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true))
	{
        Inventory_Set(userid, g_aInventoryItems[i][e_InventoryItem], g_aInventoryItems[i][e_InventoryModel], amount);

		return Servers(playerid, "You have set %s's \"%s\" to %d.", ReturnName(userid), item, amount);
	}
	Error(playerid, "Invalid item name (use /itemlist for a list).");
	return 1;
}

CMD:itemlist(playerid, params[])
{
	new
	    string[1024];

	if (!strlen(string)) {
		for (new i = 0; i < sizeof(g_aInventoryItems); i ++) {
			format(string, sizeof(string), "%s%s\n", string, g_aInventoryItems[i][e_InventoryItem]);
		}
	}
	return Dialog_Show(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "List of Items", string, "Select", "Cancel");
}

/* inv gui */
hook OnPlayerConnect(playerid)
{
    inv_gui[playerid][0] = CreatePlayerTextDraw(playerid, 242.000, 134.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_gui[playerid][0], 159.000, 203.000);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][0], 1);
    PlayerTextDrawColor(playerid, inv_gui[playerid][0], 215);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][0], 255);
    PlayerTextDrawFont(playerid, inv_gui[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][0], 1);

    inv_select[playerid][0] = CreatePlayerTextDraw(playerid, 246.000, 167.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][0], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][0], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][0], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][0], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][0], 1);

    inv_select[playerid][1] = CreatePlayerTextDraw(playerid, 284.000, 167.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][1], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][1], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][1], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][1], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][1], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][1], 1);

    inv_select[playerid][2] = CreatePlayerTextDraw(playerid, 322.000, 167.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][2], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][2], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][2], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][2], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][2], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][2], 1);

    inv_select[playerid][3] = CreatePlayerTextDraw(playerid, 360.000, 167.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][3], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][3], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][3], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][3], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][3], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][3], 1);

    inv_select[playerid][4] = CreatePlayerTextDraw(playerid, 246.000, 208.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][4], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][4], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][4], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][4], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][4], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][4], 1);

    inv_select[playerid][5] = CreatePlayerTextDraw(playerid, 284.000, 208.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][5], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][5], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][5], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][5], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][5], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][5], 1);

    inv_select[playerid][6] = CreatePlayerTextDraw(playerid, 322.000, 208.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][6], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][6], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][6], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][6], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][6], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][6], 1);

    inv_select[playerid][7] = CreatePlayerTextDraw(playerid, 360.000, 208.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][7], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][7], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][7], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][7], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][7], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][7], 1);

    inv_select[playerid][8] = CreatePlayerTextDraw(playerid, 246.000, 249.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][8], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][8], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][8], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][8], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][8], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][8], 1);

    inv_select[playerid][9] = CreatePlayerTextDraw(playerid, 284.000, 249.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][9], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][9], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][9], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][9], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][9], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][9], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][9], 1);

    inv_select[playerid][10] = CreatePlayerTextDraw(playerid, 322.000, 249.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][10], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][10], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][10], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][10], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][10], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][10], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][10], 1);

    inv_select[playerid][11] = CreatePlayerTextDraw(playerid, 360.000, 249.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][11], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][11], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][11], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][11], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][11], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][11], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][11], 1);

    inv_select[playerid][12] = CreatePlayerTextDraw(playerid, 246.000, 290.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][12], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][12], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][12], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][12], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][12], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][12], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][12], 1);

    inv_select[playerid][13] = CreatePlayerTextDraw(playerid, 284.000, 290.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][13], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][13], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][13], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][13], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][13], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][13], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][13], 1);

    inv_select[playerid][14] = CreatePlayerTextDraw(playerid, 322.000, 290.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][14], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][14], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][14], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][14], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][14], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][14], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][14], 1);

    inv_select[playerid][15] = CreatePlayerTextDraw(playerid, 360.000, 290.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_select[playerid][15], 36.000, 39.000);
    PlayerTextDrawAlignment(playerid, inv_select[playerid][15], 1);
    PlayerTextDrawColor(playerid, inv_select[playerid][15], -156);
    PlayerTextDrawSetShadow(playerid, inv_select[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, inv_select[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_select[playerid][15], 255);
    PlayerTextDrawFont(playerid, inv_select[playerid][15], 4);
    PlayerTextDrawSetProportional(playerid, inv_select[playerid][15], 1);
    PlayerTextDrawSetSelectable(playerid, inv_select[playerid][15], 1);

    inv_gui[playerid][1] = CreatePlayerTextDraw(playerid, 242.000, 357.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_gui[playerid][1], 159.000, 17.000);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][1], 1);
    PlayerTextDrawColor(playerid, inv_gui[playerid][1], 215);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][1], 255);
    PlayerTextDrawFont(playerid, inv_gui[playerid][1], 4);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][1], 1);

    inv_gui[playerid][2] = CreatePlayerTextDraw(playerid, 246.000, 359.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_gui[playerid][2], 47.000, 13.000);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][2], 1);
    PlayerTextDrawColor(playerid, inv_gui[playerid][2], 215);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][2], 255);
    PlayerTextDrawFont(playerid, inv_gui[playerid][2], 4);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, inv_gui[playerid][2], 1);

    inv_gui[playerid][3] = CreatePlayerTextDraw(playerid, 299.000, 359.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_gui[playerid][3], 47.000, 13.000);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][3], 1);
    PlayerTextDrawColor(playerid, inv_gui[playerid][3], 215);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][3], 255);
    PlayerTextDrawFont(playerid, inv_gui[playerid][3], 4);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, inv_gui[playerid][3], 1);

    inv_gui[playerid][4] = CreatePlayerTextDraw(playerid, 352.000, 359.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_gui[playerid][4], 47.000, 13.000);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][4], 1);
    PlayerTextDrawColor(playerid, inv_gui[playerid][4], 215);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][4], 255);
    PlayerTextDrawFont(playerid, inv_gui[playerid][4], 4);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, inv_gui[playerid][4], 1);

    inv_gui[playerid][5] = CreatePlayerTextDraw(playerid, 268.000, 359.000, "Amount");
    PlayerTextDrawLetterSize(playerid, inv_gui[playerid][5], 0.128, 1.098);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][5], 2);
    PlayerTextDrawColor(playerid, inv_gui[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][5], 150);
    PlayerTextDrawFont(playerid, inv_gui[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][5], 1);

    inv_gui[playerid][6] = CreatePlayerTextDraw(playerid, 322.000, 360.000, "Use");
    PlayerTextDrawLetterSize(playerid, inv_gui[playerid][6], 0.128, 1.098);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][6], 2);
    PlayerTextDrawColor(playerid, inv_gui[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][6], 150);
    PlayerTextDrawFont(playerid, inv_gui[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][6], 1);

    inv_gui[playerid][7] = CreatePlayerTextDraw(playerid, 376.000, 360.000, "Give's");
    PlayerTextDrawLetterSize(playerid, inv_gui[playerid][7], 0.128, 1.098);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][7], 2);
    PlayerTextDrawColor(playerid, inv_gui[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][7], 150);
    PlayerTextDrawFont(playerid, inv_gui[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][7], 1);

    inv_model[playerid][0] = CreatePlayerTextDraw(playerid, 250.000, 172.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][0], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][0], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][0], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][0], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][0], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][0], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][0], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][0], 0, 0);

    inv_model[playerid][1] = CreatePlayerTextDraw(playerid, 288.000, 172.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][1], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][1], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][1], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][1], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][1], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][1], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][1], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][1], 0, 0);

    inv_model[playerid][2] = CreatePlayerTextDraw(playerid, 326.000, 172.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][2], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][2], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][2], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][2], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][2], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][2], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][2], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][2], 0, 0);

    inv_model[playerid][3] = CreatePlayerTextDraw(playerid, 364.000, 172.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][3], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][3], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][3], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][3], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][3], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][3], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][3], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][3], 0, 0);

    inv_model[playerid][4] = CreatePlayerTextDraw(playerid, 250.000, 211.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][4], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][4], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][4], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][4], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][4], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][4], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][4], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][4], 0, 0);

    inv_model[playerid][5] = CreatePlayerTextDraw(playerid, 288.000, 211.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][5], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][5], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][5], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][5], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][5], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][5], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][5], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][5], 0, 0);

    inv_model[playerid][6] = CreatePlayerTextDraw(playerid, 326.000, 211.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][6], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][6], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][6], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][6], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][6], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][6], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][6], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][6], 0, 0);

    inv_model[playerid][7] = CreatePlayerTextDraw(playerid, 364.000, 212.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][7], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][7], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][7], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][7], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][7], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][7], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][7], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][7], 0, 0);

    inv_model[playerid][8] = CreatePlayerTextDraw(playerid, 249.000, 253.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][8], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][8], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][8], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][8], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][8], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][8], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][8], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][8], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][8], 0, 0);

    inv_model[playerid][9] = CreatePlayerTextDraw(playerid, 288.000, 253.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][9], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][9], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][9], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][9], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][9], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][9], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][9], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][9], 0, 0);

    inv_model[playerid][10] = CreatePlayerTextDraw(playerid, 326.000, 253.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][10], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][10], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][10], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][10], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][10], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][10], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][10], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][10], 0, 0);

    inv_model[playerid][11] = CreatePlayerTextDraw(playerid, 365.000, 253.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][11], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][11], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][11], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][11], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][11], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][11], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][11], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][11], 0, 0);

    inv_model[playerid][12] = CreatePlayerTextDraw(playerid, 250.000, 295.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][12], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][12], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][12], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][12], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][12], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][12], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][12], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][12], 0, 0);

    inv_model[playerid][13] = CreatePlayerTextDraw(playerid, 287.000, 295.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][13], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][13], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][13], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][13], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][13], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][13], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][13], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][13], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][13], 0, 0);

    inv_model[playerid][14] = CreatePlayerTextDraw(playerid, 326.000, 295.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][14], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][14], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][14], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][14], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][14], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][14], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][14], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][14], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][14], 0, 0);

    inv_model[playerid][15] = CreatePlayerTextDraw(playerid, 365.000, 295.000, "_");
    PlayerTextDrawTextSize(playerid, inv_model[playerid][15], 27.000, 29.000);
    PlayerTextDrawAlignment(playerid, inv_model[playerid][15], 1);
    PlayerTextDrawColor(playerid, inv_model[playerid][15], -1);
    PlayerTextDrawSetShadow(playerid, inv_model[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, inv_model[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_model[playerid][15], 0);
    PlayerTextDrawFont(playerid, inv_model[playerid][15], 5);
    PlayerTextDrawSetProportional(playerid, inv_model[playerid][15], 0);
    PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][15], 908);
    PlayerTextDrawSetPreviewRot(playerid, inv_model[playerid][15], 0.000, 0.000, 0.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, inv_model[playerid][15], 0, 0);

    inv_name[playerid][0] = CreatePlayerTextDraw(playerid, 263.000, 197.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][0], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][0], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][0], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][0], 1);

    inv_name[playerid][1] = CreatePlayerTextDraw(playerid, 301.000, 197.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][1], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][1], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][1], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][1], 1);

    inv_name[playerid][2] = CreatePlayerTextDraw(playerid, 339.000, 197.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][2], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][2], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][2], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][2], 1);

    inv_name[playerid][3] = CreatePlayerTextDraw(playerid, 377.000, 197.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][3], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][3], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][3], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][3], 1);

    inv_name[playerid][4] = CreatePlayerTextDraw(playerid, 263.000, 238.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][4], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][4], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][4], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][4], 1);

    inv_name[playerid][5] = CreatePlayerTextDraw(playerid, 301.000, 238.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][5], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][5], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][5], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][5], 1);

    inv_name[playerid][6] = CreatePlayerTextDraw(playerid, 339.000, 238.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][6], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][6], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][6], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][6], 1);

    inv_name[playerid][7] = CreatePlayerTextDraw(playerid, 377.000, 238.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][7], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][7], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][7], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][7], 1);

    inv_name[playerid][8] = CreatePlayerTextDraw(playerid, 263.000, 279.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][8], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][8], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][8], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][8], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][8], 1);

    inv_name[playerid][9] = CreatePlayerTextDraw(playerid, 301.000, 279.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][9], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][9], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][9], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][9], 1);

    inv_name[playerid][10] = CreatePlayerTextDraw(playerid, 340.000, 279.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][10], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][10], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][10], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][10], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][10], 1);

    inv_name[playerid][11] = CreatePlayerTextDraw(playerid, 378.000, 279.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][11], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][11], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][11], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][11], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][11], 1);

    inv_name[playerid][12] = CreatePlayerTextDraw(playerid, 263.000, 320.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][12], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][12], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][12], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][12], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][12], 1);

    inv_name[playerid][13] = CreatePlayerTextDraw(playerid, 301.000, 320.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][13], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][13], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][13], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][13], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][13], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][13], 1);

    inv_name[playerid][14] = CreatePlayerTextDraw(playerid, 339.000, 320.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][14], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][14], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][14], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][14], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][14], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][14], 1);

    inv_name[playerid][15] = CreatePlayerTextDraw(playerid, 379.000, 318.000, "Gak_Tau");
    PlayerTextDrawLetterSize(playerid, inv_name[playerid][15], 0.119, 0.898);
    PlayerTextDrawAlignment(playerid, inv_name[playerid][15], 2);
    PlayerTextDrawColor(playerid, inv_name[playerid][15], -1);
    PlayerTextDrawSetShadow(playerid, inv_name[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, inv_name[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_name[playerid][15], 150);
    PlayerTextDrawFont(playerid, inv_name[playerid][15], 1);
    PlayerTextDrawSetProportional(playerid, inv_name[playerid][15], 1);

    inv_amount[playerid][0] = CreatePlayerTextDraw(playerid, 273.000, 168.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][0], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][0], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][0], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][0], 1);

    inv_amount[playerid][1] = CreatePlayerTextDraw(playerid, 311.000, 168.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][1], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][1], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][1], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][1], 1);

    inv_amount[playerid][2] = CreatePlayerTextDraw(playerid, 349.000, 168.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][2], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][2], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][2], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][2], 1);

    inv_amount[playerid][3] = CreatePlayerTextDraw(playerid, 386.000, 168.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][3], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][3], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][3], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][3], 1);

    inv_amount[playerid][4] = CreatePlayerTextDraw(playerid, 273.000, 208.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][4], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][4], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][4], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][4], 1);

    inv_amount[playerid][5] = CreatePlayerTextDraw(playerid, 311.000, 208.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][5], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][5], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][5], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][5], 1);

    inv_amount[playerid][6] = CreatePlayerTextDraw(playerid, 349.000, 208.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][6], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][6], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][6], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][6], 1);

    inv_amount[playerid][7] = CreatePlayerTextDraw(playerid, 387.000, 208.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][7], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][7], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][7], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][7], 1);

    inv_amount[playerid][8] = CreatePlayerTextDraw(playerid, 273.000, 250.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][8], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][8], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][8], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][8], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][8], 1);

    inv_amount[playerid][9] = CreatePlayerTextDraw(playerid, 311.000, 250.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][9], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][9], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][9], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][9], 1);

    inv_amount[playerid][10] = CreatePlayerTextDraw(playerid, 349.000, 250.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][10], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][10], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][10], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][10], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][10], 1);

    inv_amount[playerid][11] = CreatePlayerTextDraw(playerid, 387.000, 250.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][11], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][11], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][11], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][11], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][11], 1);

    inv_amount[playerid][12] = CreatePlayerTextDraw(playerid, 274.000, 291.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][12], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][12], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][12], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][12], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][12], 1);

    inv_amount[playerid][13] = CreatePlayerTextDraw(playerid, 311.000, 291.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][13], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][13], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][13], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][13], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][13], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][13], 1);

    inv_amount[playerid][14] = CreatePlayerTextDraw(playerid, 349.000, 291.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][14], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][14], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][14], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][14], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][14], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][14], 1);

    inv_amount[playerid][15] = CreatePlayerTextDraw(playerid, 387.000, 291.000, "0,100x");
    PlayerTextDrawLetterSize(playerid, inv_amount[playerid][15], 0.119, 0.899);
    PlayerTextDrawAlignment(playerid, inv_amount[playerid][15], 2);
    PlayerTextDrawColor(playerid, inv_amount[playerid][15], -1);
    PlayerTextDrawSetShadow(playerid, inv_amount[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, inv_amount[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_amount[playerid][15], 150);
    PlayerTextDrawFont(playerid, inv_amount[playerid][15], 1);
    PlayerTextDrawSetProportional(playerid, inv_amount[playerid][15], 1);

    inv_gui[playerid][8] = CreatePlayerTextDraw(playerid, 382.000, 138.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_gui[playerid][8], 15.000, 15.000);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][8], 1);
    PlayerTextDrawColor(playerid, inv_gui[playerid][8], -1962934017);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][8], 255);
    PlayerTextDrawFont(playerid, inv_gui[playerid][8], 4);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, inv_gui[playerid][8], 1);

    inv_gui[playerid][9] = CreatePlayerTextDraw(playerid, 390.000, 139.000, "X");
    PlayerTextDrawLetterSize(playerid, inv_gui[playerid][9], 0.260, 1.199);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][9], 2);
    PlayerTextDrawColor(playerid, inv_gui[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][9], 150);
    PlayerTextDrawFont(playerid, inv_gui[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][9], 1);

    inv_gui[playerid][10] = CreatePlayerTextDraw(playerid, 242.000, 338.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_gui[playerid][10], 159.000, 17.000);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][10], 1);
    PlayerTextDrawColor(playerid, inv_gui[playerid][10], 215);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][10], 255);
    PlayerTextDrawFont(playerid, inv_gui[playerid][10], 4);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][10], 1);

    inv_gui[playerid][11] = CreatePlayerTextDraw(playerid, 256.000, 340.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_gui[playerid][11], 47.000, 13.000);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][11], 1);
    PlayerTextDrawColor(playerid, inv_gui[playerid][11], 215);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][11], 255);
    PlayerTextDrawFont(playerid, inv_gui[playerid][11], 4);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][11], 1);
    PlayerTextDrawSetSelectable(playerid, inv_gui[playerid][11], 1);

    inv_gui[playerid][12] = CreatePlayerTextDraw(playerid, 342.000, 340.000, "LD_BUM:blkdot");
    PlayerTextDrawTextSize(playerid, inv_gui[playerid][12], 47.000, 13.000);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][12], 1);
    PlayerTextDrawColor(playerid, inv_gui[playerid][12], 215);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][12], 255);
    PlayerTextDrawFont(playerid, inv_gui[playerid][12], 4);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][12], 1);
    PlayerTextDrawSetSelectable(playerid, inv_gui[playerid][12], 1);

    inv_gui[playerid][13] = CreatePlayerTextDraw(playerid, 277.000, 341.000, "Prev");
    PlayerTextDrawLetterSize(playerid, inv_gui[playerid][13], 0.128, 1.098);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][13], 2);
    PlayerTextDrawColor(playerid, inv_gui[playerid][13], -1);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][13], 150);
    PlayerTextDrawFont(playerid, inv_gui[playerid][13], 1);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][13], 1);

    inv_gui[playerid][14] = CreatePlayerTextDraw(playerid, 366.000, 341.000, "Next");
    PlayerTextDrawLetterSize(playerid, inv_gui[playerid][14], 0.128, 1.098);
    PlayerTextDrawAlignment(playerid, inv_gui[playerid][14], 2);
    PlayerTextDrawColor(playerid, inv_gui[playerid][14], -1);
    PlayerTextDrawSetShadow(playerid, inv_gui[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, inv_gui[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, inv_gui[playerid][14], 150);
    PlayerTextDrawFont(playerid, inv_gui[playerid][14], 1);
    PlayerTextDrawSetProportional(playerid, inv_gui[playerid][14], 1);
}


OpenInventory(playerid) {
    static str[480], string[32];
    SelectTextDraw(playerid, -1);

    for(new index; index < 16; index ++) {
        PlayerTextDrawShow(playerid, inv_select[playerid][index]);

        forex(i, 15) {
            PlayerTextDrawShow(playerid, inv_gui[playerid][i]);
        }

        if(InventoryData[playerid][index][invExists]) {

            strunpack(string, InventoryData[playerid][index][invItem]);

            format(str, sizeof(str), "%s", string);
            PlayerTextDrawSetString(playerid, inv_name[playerid][index], str);
            PlayerTextDrawShow(playerid, inv_name[playerid][index]);

            format(str, sizeof(str), "%dx", InventoryData[playerid][index][invQuantity]);
            PlayerTextDrawSetString(playerid, inv_amount[playerid][index], str);
            PlayerTextDrawShow(playerid, inv_amount[playerid][index]);

            PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][index], InventoryData[playerid][index][invModel]);
            PlayerTextDrawShow(playerid, inv_model[playerid][index]);

            PlayerPlaySound(playerid, 1039, 0.0, 0.0, 0.0);
        }
    }
    return 1;
}

SyncInventoryPage(playerid) {

    new idx = invPage[playerid],
        string[64],
        str[64];

    new tempidx = idx * 16;

    for(new i = 0; i < 16; i++) {
        PlayerTextDrawColor(playerid, inv_select[playerid][i], -156);
        PlayerTextDrawShow(playerid, inv_select[playerid][i]);
        PlayerTextDrawHide(playerid, inv_name[playerid][i]);
        PlayerTextDrawHide(playerid, inv_amount[playerid][i]);
        PlayerTextDrawHide(playerid, inv_model[playerid][i]);

        PlayerTextDrawShow(playerid, inv_select[playerid][i]);
        
    }
    for(new index = 0; index < 16; index++) if(InventoryData[playerid][tempidx + index][invExists]) {

        strunpack(string, InventoryData[playerid][index][invItem]);

        format(str, sizeof(str), "%s", string);
        PlayerTextDrawSetString(playerid, inv_name[playerid][index], str);
        PlayerTextDrawShow(playerid, inv_name[playerid][index]);

        format(str, sizeof(str), "%dx", InventoryData[playerid][index][invQuantity]);
        PlayerTextDrawSetString(playerid, inv_amount[playerid][index], str);
        PlayerTextDrawShow(playerid, inv_amount[playerid][index]);

        PlayerTextDrawSetPreviewModel(playerid, inv_model[playerid][index], InventoryData[playerid][index][invModel]);
        PlayerTextDrawShow(playerid, inv_model[playerid][index]);
    }
}

CloseInventory(playerid) {
    for(new index; index < 16; index ++) {
        PlayerTextDrawHide(playerid, inv_name[playerid][index]);
        PlayerTextDrawHide(playerid, inv_amount[playerid][index]);
        PlayerTextDrawHide(playerid, inv_model[playerid][index]);
        PlayerTextDrawHide(playerid, inv_select[playerid][index]);
    }
    forex(i, 15) {
        PlayerTextDrawHide(playerid, inv_gui[playerid][i]);
    }
    CancelSelectTextDraw(playerid);
    return 1;
}


function OpenInventory2(playerid)
{
    if(!IsPlayerConnected(playerid))
        return 0;

    new
        inv[1024],
        name[48],
        count = 0;

    strcat(inv, "Name\tQuantity\n");
    for (new i = 0; i < MAX_INVENTORY; i ++) if(InventoryData[playerid][i][invExists]) {
        strunpack(name, InventoryData[playerid][i][invItem]);
        strcat(inv, sprintf("%s\t%d\n", name, InventoryData[playerid][i][invQuantity]));
        ListedInventory[playerid][count++] = i;
    }
    if(count) {
        pData[playerid][pStorageSelect] = 0;
        Dialog_Show(playerid, MyInventory, DIALOG_STYLE_TABLIST_HEADERS, "My Inventory", inv, "Select", "Close");
        return 1;
    }
    Error(playerid, "There are no one item in your inventory.");
    return 1;
    //return ShowModelSelectionMenu(playerid, "Inventory", MODEL_SELECTION_INVENTORY, items, sizeof(items), 0.0, 0.0, 0.0, 1.0, -1, true, amounts);
}

CMD:inv(playerid)
{
    OpenInventory(playerid);
    return 1;
}
