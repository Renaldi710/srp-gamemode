#define MAX_CAR_STORAGE                 (5)

enum carStorage {
    cItemID,
    cItemName[32 char],
    cItemModel,
    cItemQuantity
};

new CarStorage[MAX_PRIVATE_VEHICLE][MAX_CAR_STORAGE][carStorage],
    Iterator:CarsStorage[MAX_PRIVATE_VEHICLE]<MAX_CAR_STORAGE>;

function OnLoadCarStorage(carid)
{
    new
        rows = cache_num_rows(),
        slot = cellmin,
        str[32];

    Iter_Init(CarsStorage);
    for (new i = 0; i != rows; i ++) if ((slot = Iter_Free(CarsStorage[carid])) != cellmin) {
        Iter_Add(CarsStorage[carid], slot);

        cache_get_value_int(i, "itemID", CarStorage[carid][slot][cItemID]);
        cache_get_value_int(i, "itemModel", CarStorage[carid][slot][cItemModel]);
        cache_get_value_int(i, "itemQuantity", CarStorage[carid][slot][cItemQuantity]);

        cache_get_value(i, "itemName", str, sizeof(str));
        strpack(CarStorage[carid][slot][cItemName], str, 32 char);
    }
    return 1;
}

Car_ShowTrunk(playerid)
{
    Dialog_Show(playerid, CarStorage, DIALOG_STYLE_LIST, "Car Storage", "Item Storage\nWeapon Storage", "Select", "Cancel");
    return 1;
}

stock Car_GetFreeID(carid)
{
    if(!Iter_Contains(PVehicles, carid))
        return 0;
    
    new freeid = cellmin;
    if ((freeid = Iter_Free(CarsStorage[carid])) != cellmin) {
        return freeid;
    }
    return cellmin;
}

stock Car_StoreItem(itemid, carid, quantity = 1) {
    if(!Iter_Contains(PVehicles, carid))
        return 0;
    
    if (itemid != -1) {
        if (CarStorage[carid][itemid][cItemQuantity] >= Inventory_MaxCount(CarStorage[carid][itemid][cItemName]))
            return -1;

        mysql_tquery(g_SQL, sprintf("UPDATE `carstorage` SET `itemQuantity` = `itemQuantity` + %d WHERE `ID` = '%d' AND `itemID` = '%d'", quantity, pvData[carid][cID], CarStorage[carid][itemid][cItemID]));

        CarStorage[carid][itemid][cItemQuantity] += quantity;
    }
    return itemid;
}

stock Car_AddItem(carid, item[], model, quantity = 1, slotid = -1)
{
    if(!Iter_Contains(PVehicles, carid))
        return 0;

    new
        itemid = Car_GetFreeID(carid);

    if(itemid != cellmin)
    {
        if(slotid != -1)
            itemid = slotid;

        Iter_Add(CarsStorage[carid], itemid);
        CarStorage[carid][itemid][cItemModel] = model;
        CarStorage[carid][itemid][cItemQuantity] = quantity;

        strpack(CarStorage[carid][itemid][cItemName], item, 32 char);

        mysql_tquery(g_SQL, sprintf("INSERT INTO `carstorage` (`ID`, `itemName`, `itemModel`, `itemQuantity`) VALUES('%d', '%s', '%d', '%d')", pvData[carid][cID], item, model, quantity), "OnCarStorageAdd", "dd", carid, itemid);
        return itemid;
    }
    return cellmin;
}

Car_RemoveItem(itemid, carid, quantity = 1)
{
    if(!Iter_Contains(PVehicles, carid))
        return 0;

    if(Iter_Contains(CarsStorage[carid], itemid))
    {
        if(CarStorage[carid][itemid][cItemQuantity] > 0)
        {
            CarStorage[carid][itemid][cItemQuantity] -= quantity;
        }
        if(quantity == -1 || CarStorage[carid][itemid][cItemQuantity] < 1)
        {
            CarStorage[carid][itemid][cItemModel] = 0;
            CarStorage[carid][itemid][cItemQuantity] = 0;

            mysql_tquery(g_SQL, sprintf("DELETE FROM `carstorage` WHERE `ID` = '%d' AND `itemID` = '%d'", pvData[carid][cID], CarStorage[carid][itemid][cItemID]));

            Iter_Remove(CarsStorage[carid], itemid);
        }
        else if(quantity != -1 && CarStorage[carid][itemid][cItemQuantity] > 0)
        {
            mysql_tquery(g_SQL, sprintf("UPDATE `carstorage` SET `itemQuantity` = `itemQuantity` - %d WHERE `ID` = '%d' AND `itemID` = '%d'", quantity, pvData[carid][cID], CarStorage[carid][itemid][cItemID]));
        }
        return 1;
    }
    return 0;
}

function Car_RemoveAllItems(carid)
{
    foreach (new i : CarsStorage[carid]) {
        CarStorage[carid][i][cItemModel] = 0;
        CarStorage[carid][i][cItemQuantity] = 0;
    }
    mysql_tquery(g_SQL, sprintf("DELETE FROM `carstorage` WHERE `ID` = '%d'", pvData[carid][cID]));

    Iter_Clear(CarsStorage[carid]);

    for (new i = 0; i < 5; i ++) {
        pvData[carid][cWeapons][i] = 0;
        pvData[carid][cAmmo][i] = 0;
    }
    return 1;
}

function Car_RemoveData(carid)
{
    foreach (new i : CarsStorage[carid]) {
        CarStorage[carid][i][cItemModel] = 0;
        CarStorage[carid][i][cItemQuantity] = 0;
    }
    return 1;
}

Car_WeaponStorage(playerid, carid)
{
    if(!Iter_Contains(PVehicles, carid))
        return 0;

    static
        string[164];

    string[0] = 0;

    strcat(string, "Weapon\tAmmo\n");
    for (new i = 0; i < 3; i ++)
    {
        if(22 <= pvData[carid][cWeapons][i] <= 38) {
            strcat(string, sprintf("%s\t%d\n", ReturnWeaponName(pvData[carid][cWeapons][i]), pvData[carid][cAmmo][i]));
        }
        else {
            strcat(string, sprintf("{%s}%s\t \n", (pvData[carid][cWeapons][i]) ? ("C0C0C0") : ("FFFFFF"), (pvData[carid][cWeapons][i]) ? (ReturnWeaponName(pvData[carid][cWeapons][i])) : (""WHITE"Empty Slot")));
        }
    }
    Dialog_Show(playerid, Trunk_WeaponStorage, DIALOG_STYLE_TABLIST_HEADERS, "Car Trunk", string, "Select", "Cancel");
    return 1;
}

function OnCarStorageAdd(carid, itemid)
{
    CarStorage[carid][itemid][cItemID] = cache_insert_id();
    return 1;
}

Dialog:CarDeposit(playerid, response, listitem, inputtext[])
{
    static
        carid = -1,
        string[32],
        itemid = -1;

    if((carid = Vehicle_GetID(GetNearestVehicleToPlayer(playerid,4.0,false))) != -1)
    {
        strunpack(string, InventoryData[playerid][pData[playerid][pInventoryItem]][invItem]);
        itemid = pData[playerid][pStorageItem];

        if(response)
        {
            new amount = strval(inputtext);

            if(amount < 1 || amount > InventoryData[playerid][pData[playerid][pInventoryItem]][invQuantity])
                return Dialog_Show(playerid, CarDeposit, DIALOG_STYLE_INPUT, "Car Deposit", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to store for this item:", "Store", "Back", string, InventoryData[playerid][pData[playerid][pInventoryItem]][invQuantity]);
            
            if (Iter_Contains(CarsStorage[carid], itemid)) Car_StoreItem(itemid, carid, amount);
            else Car_AddItem(carid, string, InventoryData[playerid][pData[playerid][pInventoryItem]][invModel], amount);

            Inventory_Remove(playerid, string, amount);

            Servers(playerid, "You have deposit a "YELLOW"\"%s\""WHITE" to your trunk.", string);

            Car_ShowTrunk(playerid);
        }
        else Car_ShowTrunk(playerid);
    }
    return 1;
}

Dialog:CarTake(playerid, response, listitem, inputtext[])
{
    static
        carid = -1,
        string[32];

    if((carid = Vehicle_GetID(GetNearestVehicleToPlayer(playerid,4.0,false))) != -1)
    {
        strunpack(string, CarStorage[carid][pData[playerid][pStorageItem]][cItemName]);

        if(response)
        {
            new amount = strval(inputtext);

            if(amount < 1 || amount > CarStorage[carid][pData[playerid][pStorageItem]][cItemQuantity])
                return Dialog_Show(playerid, CarTake, DIALOG_STYLE_INPUT, "Car Take", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to take for this item:", "Take", "Back", string, CarStorage[carid][pData[playerid][pInventoryItem]][cItemQuantity]);

            for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if(!strcmp(g_aInventoryItems[i][e_InventoryItem], string, true)) {
                if((Inventory_Count(playerid, g_aInventoryItems[i][e_InventoryItem])+amount) > g_aInventoryItems[i][e_InventoryMax])
                    return Error(playerid, "You're limited %d for %s.", g_aInventoryItems[i][e_InventoryMax], string);
            }

            new id = Inventory_Add(playerid, string, CarStorage[carid][pData[playerid][pStorageItem]][cItemModel], amount);

            if(id == -1)
                return Error(playerid, "You don't have any inventory slots left.");

            Car_RemoveItem(pData[playerid][pStorageItem], carid, amount);

            Servers(playerid, "You have taken a "YELLOW"\"%s\""WHITE" from the trunk.", string);

            Car_ShowTrunk(playerid);
        }
        else Car_ShowTrunk(playerid);
    }
    return 1;
}

Dialog:CarStorage(playerid, response, listitem, inputtext[])
{
    new
        carid = -1;

    if((carid = Vehicle_GetID(GetNearestVehicleToPlayer(playerid,4.0,false))) != -1)
    {
        if(response)
        {
            switch (listitem) {
                case 0: {
                    new
                        string[MAX_CAR_STORAGE * 32],
                        name[32];

                    string[0] = 0;

                    for (new i = 0; i != MAX_CAR_STORAGE; i ++)
                    {
                        if(!Iter_Contains(CarsStorage[carid], i)) format(string, sizeof(string), "%sEmpty Slot\n", string);
                        else {
                            strunpack(name, CarStorage[carid][i][cItemName]);

                            format(string, sizeof(string), "%s%s (%d)\n", string, name, CarStorage[carid][i][cItemQuantity]);
                        }
                    }
                    pData[playerid][pStorageSelect] = 0;
                    Dialog_Show(playerid, Car_ItemStorage, DIALOG_STYLE_LIST, "Car Item Storage", string, "Select", "Close");
                }
                case 1: {
                    if(pData[playerid][pLevel] < 2)
                        return Error(playerid, "You're not allowed to accese this vehicle weapon storage if you're not level 2.");

                    Car_WeaponStorage(playerid, carid);
                }
            }
        }
        else
        {
            SwitchVehicleBoot(pvData[carid][cVeh], false);
        }
    }
    return 1;
}

Dialog:Car_ItemStorage(playerid, response, listitem, inputtext[]) {
    new
        carid = -1,
        string[64];

    if ((carid = Vehicle_GetID(GetNearestVehicleToPlayer(playerid,4.0,false))) != -1)
    {
        if (response) {
            pData[playerid][pStorageItem] = listitem;

            if(Iter_Contains(CarsStorage[carid], listitem))
            {
                if (!Vehicle_IsOwner(playerid, carid))
                    return Error(playerid, "You don't have permission to take/store item to this vehicle!");
                
                pData[playerid][pInventoryItem] = listitem;
                strunpack(string, CarStorage[carid][listitem][cItemName]);

                if (CarStorage[carid][listitem][cItemQuantity] >= Inventory_MaxCount(string)) {
                    format(string, sizeof(string), "%s (Quantity: %d)", string, CarStorage[carid][listitem][cItemQuantity]);
                    Dialog_Show(playerid, TrunkOptions, DIALOG_STYLE_LIST, string, "Take Item", "Select", "Back");
                } else {
                    format(string, sizeof(string), "%s (Quantity: %d)", string, CarStorage[carid][listitem][cItemQuantity]);
                    Dialog_Show(playerid, TrunkOptions, DIALOG_STYLE_LIST, string, "Take Item\nStore Item", "Select", "Back");
                }
            } else {
                if (!Vehicle_IsOwner(playerid, carid))
                    return Error(playerid, "You don't have permission to take/store item to this vehicle!");

                OpenInventory2(playerid);

                pData[playerid][pStorageSelect] = 2;
            }
        } else Car_ShowTrunk(playerid);
    }
    return 1;
}

Dialog:TrunkOptions(playerid, response, listitem, inputtext[])
{
    static
        carid = -1,
        itemid = -1,
        string[32];

    if((carid = Vehicle_GetID(GetNearestVehicleToPlayer(playerid,4.0,false))) != -1)
    {
        itemid = pData[playerid][pStorageItem];

        strunpack(string, CarStorage[carid][itemid][cItemName]);

        if(response)
        {
            switch (listitem)
            {
                case 0:
                {
                    if(CarStorage[carid][itemid][cItemQuantity] == 1)
                    {
                        for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if(!strcmp(g_aInventoryItems[i][e_InventoryItem], string, true)) {
                            if((Inventory_Count(playerid, g_aInventoryItems[i][e_InventoryItem])+1) > g_aInventoryItems[i][e_InventoryMax])
                                return Error(playerid, "You're limited %d for %s.", g_aInventoryItems[i][e_InventoryMax], string);
                        }

                        new id = Inventory_Add(playerid, string, CarStorage[carid][itemid][cItemModel], 1);

                        if(id == -1)
                            return Error(playerid, "You don't have any inventory slots left.");

                        Car_RemoveItem(itemid, carid);

                        Servers(playerid, "You have taken a "YELLOW"\"%s\""WHITE" from the trunk.", string);
                        Car_ShowTrunk(playerid);
                    }
                    else
                    {
                        Dialog_Show(playerid, CarTake, DIALOG_STYLE_INPUT, "Car Take", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to take for this item:", "Take", "Back", string, CarStorage[carid][itemid][cItemQuantity]);
                    }
                }
                case 1:
                {
                    new id = Inventory_GetItemID(playerid, string);
                    
                    if(id == -1) {
                        Car_ShowTrunk(playerid);

                        return Error(playerid, "You don't have anymore of this item to store!");
                    }
                    else if(InventoryData[playerid][id][invQuantity] == 1)
                    {
                        if (CarStorage[carid][itemid][cItemQuantity] >= Inventory_MaxCount(string))
                            return Error(playerid, "Cannot store more %s on this slot. (Max: %d)", string, Inventory_MaxCount(string));

                        if (Iter_Contains(CarsStorage[carid], itemid)) Car_StoreItem(itemid, carid, 1);
                        else Car_AddItem(carid, string, InventoryData[playerid][pData[playerid][pInventoryItem]][invModel], 1);
                        Inventory_Remove(playerid, string);

                        Servers(playerid, "You have store a "YELLOW"\"%s\""WHITE" to your trunk.", string);
                        Car_ShowTrunk(playerid);
                    }
                    else if(InventoryData[playerid][id][invQuantity] > 1) {
                        if (CarStorage[carid][itemid][cItemQuantity] >= Inventory_MaxCount(string))
                            return Error(playerid, "Cannot store more %s on this slot. (Max: %d)", string, Inventory_MaxCount(string));

                        pData[playerid][pInventoryItem] = id;

                        Dialog_Show(playerid, CarDeposit, DIALOG_STYLE_INPUT, "Car Deposit", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to store for this item:", "Store", "Back", string, InventoryData[playerid][id][invQuantity]);
                    }
                }
            }
        }
        else
        {
            Car_ShowTrunk(playerid);
        }
    }
    return 1;
}

Dialog:Trunk_WeaponStorage(playerid, response, listitem, inputtext[])
{
    new carid = Vehicle_GetID(GetNearestVehicleToPlayer(playerid,4.0,false));

    if(carid != -1)
    {
        if(response)
        {
            if(!pvData[carid][cWeapons][listitem])
            {
                new
                    weaponid = 0
                ;

                if(!Vehicle_IsOwner(playerid, carid)) 
                    return Error(playerid, "This is not your vehicle.");
                    
                if((weaponid = GetWeapon(playerid)) == 0) 
                    return Error(playerid, "You aren't holding any weapon.");
               
                pvData[carid][cWeapons][listitem]      = weaponid;
                pvData[carid][cAmmo][listitem]         = ReturnWeaponAmmo(playerid, weaponid);

                ResetWeapon(playerid, pvData[carid][cWeapons][listitem]);

                Servers(playerid, "You have store a "YELLOW"\"%s\""WHITE" to your trunk.", ReturnWeaponName(weaponid));

                Car_WeaponStorage(playerid, carid);
            }
            else
            {
                if(pData[playerid][pOnDuty] == 1) 
                    return Error(playerid, "Can't access weapon trunk while faction on duty.");

                if (!Vehicle_IsOwner(playerid, carid))
                    return Error(playerid, "You don't have permission to take/store weapon to this vehicle!");

                if(PlayerHasWeaponInSlot(playerid, pvData[carid][cWeapons][listitem]))
                    return Error(playerid, "You have weapon on that slot!.");

                GivePlayerWeaponEx(playerid, pvData[carid][cWeapons][listitem], pvData[carid][cAmmo][listitem]);
                Servers(playerid, "You have taken a "YELLOW"\"%s\""WHITE" from the trunk.", ReturnWeaponName(pvData[carid][cWeapons][listitem]));
                
                pvData[carid][cWeapons][listitem] = pvData[carid][cAmmo][listitem] = 0;

                Car_WeaponStorage(playerid, carid);
            }
        }
        else Car_ShowTrunk(playerid);
    }
    return 1;
}
