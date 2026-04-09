#define MAX_RENT 50

//core
enum rentveh
{
    rID,
    Float:rX,
    Float:rY,
    Float:rZ,
    Float:rRX,
    Float:rRY,
    Float:rRZ,
    Float:rRA,
    rType,
    rPickup,
	Text3D:rLabelPoint
};
new rentData[MAX_RENT][rentveh],
    Iterator:Rents<MAX_RENT>;


forward Rent_Load();
public Rent_Load()
{
	new rows = cache_num_rows(), id;
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
            cache_get_value_name_int(i, "rID", id);
		    cache_get_value_name_float(i, "rX", rentData[id][rX]);
		    cache_get_value_name_float(i, "rY", rentData[id][rY]);
		    cache_get_value_name_float(i, "rZ", rentData[id][rZ]);
		    
		    cache_get_value_name_float(i, "rRX", rentData[id][rRX]);
		    cache_get_value_name_float(i, "rRY", rentData[id][rRY]);
		    cache_get_value_name_float(i, "rRZ", rentData[id][rRZ]);
            cache_get_value_name_float(i, "rRA", rentData[id][rRA]);
            cache_get_value_name_int(i, "rType", rentData[id][rType]);	

			Iter_Add(Rents, id);
			Rent_Refresh(id);
		}
	}
	printf("*** [Database: Loaded] rent data (%d count).", rows);
	return 1;
}

stock Rent_Save(id)
{
	new
	    query[512];

	format(query, sizeof(query), "UPDATE `rentplayer` SET `rX` = '%f', `rY` = '%f', `rZ` = '%f', `rRX` = '%f', `rRY` = '%f', `rRZ` = '%f', `rRA` = '%f', `rType` = '%d' WHERE `rID` = '%d'",
		rentData[id][rX],
        rentData[id][rY],
        rentData[id][rZ],
        rentData[id][rRX],
        rentData[id][rRY],
        rentData[id][rRZ],
        rentData[id][rRA],
        rentData[id][rType],
        id
	);
	return mysql_tquery(g_SQL, query);
}

stock Rent_Refresh(id)
{
	if(id != -1)
	{
        if(IsValidDynamicPickup(rentData[id][rPickup]))
            DestroyDynamicPickup(rentData[id][rPickup]);

        if(IsValidDynamic3DTextLabel(rentData[id][rLabelPoint]))
            DestroyDynamic3DTextLabel(rentData[id][rLabelPoint]);

		new string[212];
        format(string, sizeof(string), "[ID: %d]\n"WHITE"Rental Type: "GRAY"%s\n"WHITE_E"Use "YELLOW_E"'/rentpv' "WHITE_E"to rent a vehicle\n"WHITE_E"Use "YELLOW_E"'/unrentpv' "WHITE_E"to return any rented vehicle", id, RentType(rentData[id][rType]));
        rentData[id][rPickup] = CreateDynamicPickup(1239, 23, rentData[id][rX], rentData[id][rY], rentData[id][rZ]+0.2, 0, 0, _, 15.0);
        rentData[id][rLabelPoint] = CreateDynamic3DTextLabel(string, -1, rentData[id][rX], rentData[id][rY], rentData[id][rZ]+0.5, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
	}
}

function RentCreate(id)
{
	Rent_Save(id);
	Rent_Refresh(id);
	return 1;
}

RentType(type) {
    new types[235];
    if(type == 1) {
        types = "Type Bikes";
    }
    else if(type == 2) {
        types = "Type Jobs";
    }
    else if(type == 3) {
        types = "Type Boat";
    }
    return types;
}

//dialog

Dialog:RentVehicleBoat(playerid, response, listitem, inputtext[]) {
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                new modelid = 473;
                new tstr[128];
                pData[playerid][pBuyPvModel] = modelid;
                format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$75 / hours", GetVehicleModelName(modelid));
                Dialog_Show(playerid, RentVehicleConfirm, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
                
            }
            case 1:
            {
                new modelid = 453;
                new tstr[128];
                pData[playerid][pBuyPvModel] = modelid;
                format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50 / hours", GetVehicleModelName(modelid));
                Dialog_Show(playerid, RentVehicleConfirm, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
            }
        }
    }
    return 1;
}

Dialog:RentVehicleJobs(playerid, response, listitem, inputtext[]) {
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                new modelid = 438;
                new tstr[128];
                pData[playerid][pBuyPvModel] = modelid;
                format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$75 / hours", GetVehicleModelName(modelid));
                Dialog_Show(playerid, RentVehicleConfirm, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
            }
            case 1:
            {
                new modelid = 420;
                new tstr[128];
                pData[playerid][pBuyPvModel] = modelid;
                format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50 / hours", GetVehicleModelName(modelid));
                Dialog_Show(playerid, RentVehicleConfirm, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
            }
            case 2:
            {
                new modelid = 422;
                new tstr[128];
                pData[playerid][pBuyPvModel] = modelid;
                format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50 / hours", GetVehicleModelName(modelid));
                Dialog_Show(playerid, RentVehicleConfirm, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
            }
            case 3:
            {
                new modelid = 543;
                new tstr[128];
                pData[playerid][pBuyPvModel] = modelid;
                format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50 / hours", GetVehicleModelName(modelid));
                Dialog_Show(playerid, RentVehicleConfirm, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
            }
            case 4:
            {
                new modelid = 499;
                new tstr[128];
                pData[playerid][pBuyPvModel] = modelid;
                format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50 / hours", GetVehicleModelName(modelid));
                Dialog_Show(playerid, RentVehicleConfirm, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
            }
        }
    }
    return 1;
}

Dialog:RentVehicle(playerid, response, listitem, inputtext[]) {
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                new modelid = 462;
                new tstr[128];
                pData[playerid][pBuyPvModel] = modelid;
                format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$75 / hours", GetVehicleModelName(modelid));
                Dialog_Show(playerid, RentVehicleConfirm, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
            }
            case 1:
            {
                new modelid = 481;
                new tstr[128];
                pData[playerid][pBuyPvModel] = modelid;
                format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50 / hours", GetVehicleModelName(modelid));
                Dialog_Show(playerid, RentVehicleConfirm, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
            }
            case 2:
            {
                new modelid = 509;
                new tstr[128];
                pData[playerid][pBuyPvModel] = modelid;
                format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$50 / hours", GetVehicleModelName(modelid));
                Dialog_Show(playerid, RentVehicleConfirm, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
            }
        }
    }
    return 1;
}

Dialog:RentVehicleConfirm(playerid, response, listitem, inputtext[]) {
    if(response)
    {
        new modelid = pData[playerid][pBuyPvModel];
		new id = pData[playerid][pRentData];
		if(response)
		{
			if(rentData[id][rRX] != 0.0)
	    	{
				if(modelid <= 0) return Error(playerid, "Invalid model id.");
				new cost = 0;
				if(modelid == 462)
				{
					cost = 75;
				}
				else if(modelid == 481)
				{
					cost = 50;
				}
				else if(modelid == 509)
				{
					cost = 50;
				}
				else if(modelid == 483)
				{
					cost = 50;
				}
				else if(modelid == 420)
				{
					cost = 75;
				}
				else if(modelid == 422)
				{
					cost = 70;
				}
				else if(modelid == 543)
				{
					cost = 70;
				}
				else if(modelid == 499)
				{
					cost = 75;
				}
				else if(modelid == 473)
				{
					cost = 45;
				}
				else if(modelid == 453)
				{
					cost = 50;
				}
				if(pData[playerid][pMoney] < cost)
				{
					Error(playerid, "Uang anda tidak mencukupi.!");
					return 1;
				}
				new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
				foreach(new ii : PVehicles)
				{
                    if(GetVehicleType(ii) == VEHICLE_TYPE_PLAYER)
		            {
                        if(pvData[ii][cExtraID] == pData[playerid][pID])
                            count++;
                    }
				}
				if(count >= limit)
				{
					Error(playerid, "Slot kendaraan anda sudah penuh, silahkan jual beberapa kendaraan anda terlebih dahulu!");
					return 1;
				}
				GivePlayerMoneyEx(playerid, -cost);
				new cQuery[1024];
				new Float:x,Float:y,Float:z, Float:a;
				new model, color1, color2, rental;
				color1 = 0;
				color2 = 0;
				model = modelid;
				x = rentData[id][rRX];
				y = rentData[id][rRY];
				z = rentData[id][rRZ];
				a = rentData[id][rRA];
				rental = gettime() + (1 * 86400);
				mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`extraid`, `model`, `color1`, `color2`, `price`, `x`, `y`, `z`, `a`, `rental`) VALUES (%d, %d, %d, %d, %d, '%f', '%f', '%f', '%f', '%d')", pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
				mysql_tquery(g_SQL, cQuery, "OnVehRentPV", "ddddddffffd", playerid, pData[playerid][pID], model, color1, color2, cost, x, y, z, a, rental);
				return 1;
			}
			else return Error(playerid, "Titik spawn belum di buat");	
		}
		else
		{
			pData[playerid][pBuyPvModel] = 0;
		}
    }
    return 1;
}

CMD:createrent(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new id = Iter_Free(Rents);
	if(id == -1) return Error(playerid, "You cant create more pickup rent slot empty!");
	new name, query[128];
	if(sscanf(params, "d", name)) 
    {
        Usage(playerid, "/createrent [type]");
        Info(playerid, "type 1 Bike, Type 2 Jobs Vehicle, Type 3 Boat Vehicle");
        return 1;
    }
    if(name < 1 || name > 3) return Error(playerid, "Tidak bisa di bawah 0 atau di atas 3");
	rentData[id][rType] = name;
	GetPlayerPos(playerid, rentData[id][rX], rentData[id][rY], rentData[id][rZ]);
	rentData[id][rX] = rentData[id][rX];
	rentData[id][rY] = rentData[id][rY];
	rentData[id][rZ] = rentData[id][rZ];
    rentData[id][rRX] = 0.0;
	rentData[id][rRY] = 0.0;
	rentData[id][rRZ] = 0.0;
    rentData[id][rRA] = 0.0;

	SendStaffMessage(X11_TOMATO, "AdmCmd: %s telah membuat pickup rent", pData[playerid][pAdminname]);

	Iter_Add(Rents, id);
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO rentplayer SET rID=%d, rX='%f', rY='%f', rZ='%f', rType='%d'", id, rentData[id][rX], rentData[id][rY], rentData[id][rZ], name);
	mysql_tquery(g_SQL, query, "RentCreate", "i", id);
	return 1;
}

CMD:rentedit(playerid, params[])
{
    static
        id,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", id, type, string))
    {
        Usage(playerid, "/rentedit [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} spawn, delete");
        return 1;
    }
    if((id < 0 || id >= MAX_RENT))
        return Error(playerid, "You have specified an invalid ID.");
    if(!rentData[id][rX]) return Error(playerid, "The you specified ID of doesn't exist.");
    if(!strcmp(type, "spawn", true))
    {
		GetPlayerPos(playerid, rentData[id][rRX], rentData[id][rRY], rentData[id][rRZ]);
        GetPlayerFacingAngle(playerid, rentData[id][rRA]);
        Rent_Save(id);
        Rent_Refresh(id);
        SendStaffMessage(X11_TOMATO, "AdmCmd: %s set spawn pickup point id", pData[playerid][pAdminname], id);
    }
    else if(!strcmp(type, "delete", true))
    {
        new query[128];
        
        if(IsValidDynamicPickup(rentData[id][rPickup]))
            DestroyDynamicPickup(rentData[id][rPickup]);

        if(IsValidDynamic3DTextLabel(rentData[id][rLabelPoint]))
            DestroyDynamic3DTextLabel(rentData[id][rLabelPoint]);

        rentData[id][rX] = 0;
        rentData[id][rY] = 0;
        rentData[id][rZ] = 0;
        rentData[id][rRX] = 0;
        rentData[id][rRY] = 0;
        rentData[id][rRZ] = 0;
        rentData[id][rRA] = 0;
        rentData[id][rType] = 0;
        Iter_Remove(Rents, id);
        mysql_format(g_SQL, query, sizeof(query), "DELETE FROM rentplayer WHERE rID=%d", id);
	    mysql_tquery(g_SQL, query);
        
        SendStaffMessage(X11_TOMATO, "AdmCmd: %s remove pickup point id", pData[playerid][pAdminname], id);
    }		
    return 1;
}

CMD:rentpv(playerid, params[])
{
    if(pData[playerid][pRents] > 0) return Error(playerid, "Anda sudah menyewa kendaraan");
    for(new id = 0 ; id < MAX_RENT; id++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, rentData[id][rX], rentData[id][rY], rentData[id][rZ]))
        {
            if(rentData[id][rType] == 1)
            {
                pData[playerid][pRentData] = id;
                new String[212], S3MP4K[212];
                strcat(S3MP4K, "Vehicle\tRent Price\n");
                format(String, sizeof(String),"%s\t$75/hours\n", GetVehicleModelName(462));
                strcat(S3MP4K, String);
                format(String, sizeof(String),""GRAY"%s\t"GRAY"$50/hours\n", GetVehicleModelName(481));
                strcat(S3MP4K, String);
                format(String, sizeof(String),"%s\t$50/hours\n", GetVehicleModelName(509));
                strcat(S3MP4K, String);
                Dialog_Show(playerid, RentVehicle, DIALOG_STYLE_TABLIST_HEADERS, "Renting Vehicle", S3MP4K, "Select", "Cancel");
            }
            if(rentData[id][rType] == 2)
            {
                pData[playerid][pRentData] = id;
                new String[212], S3MP4K[212];
                strcat(S3MP4K, "Vehicle\tRent Price\n");
                format(String, sizeof(String),"%s\t$50/hours\n", GetVehicleModelName(438));
                strcat(S3MP4K, String);
                format(String, sizeof(String),""GRAY"%s\t"GRAY"$75/hours\n", GetVehicleModelName(420));
                strcat(S3MP4K, String);
                format(String, sizeof(String),"%s\t$70/hours\n", GetVehicleModelName(422));
                strcat(S3MP4K, String);
                format(String, sizeof(String),""GRAY"%s\t"GRAY"$70/hours\n", GetVehicleModelName(543));
                strcat(S3MP4K, String);
                format(String, sizeof(String),"%s\t$75/hours\n", GetVehicleModelName(499));
                strcat(S3MP4K, String);
                Dialog_Show(playerid, RentVehicleJobs, DIALOG_STYLE_TABLIST_HEADERS, "Renting Vehicle", S3MP4K, "Select", "Cancel");
            }
            if(rentData[id][rType] == 3)
            {
                pData[playerid][pRentData] = id;
                new String[212], S3MP4K[212];
                strcat(S3MP4K, "Vehicle\tRent Price\n");
                format(String, sizeof(String),"%s\t$45/hours\n", GetVehicleModelName(473));
                strcat(S3MP4K, String);
                format(String, sizeof(String),""GRAY"%s\t"GRAY"$50/hours\n", GetVehicleModelName(453));
                strcat(S3MP4K, String);
                Dialog_Show(playerid, RentVehicleBoat, DIALOG_STYLE_TABLIST_HEADERS, "Renting Vehicle", S3MP4K, "Select", "Cancel");
            }
        }
    }
    return 1;
}

CMD:aunrentveh(playerid, params[])
{
    new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/aunrentveh [playerid/PartOfName]");

	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");

	foreach(new i : PVehicles)			
    {
        if(GetVehicleType(i) == VEHICLE_TYPE_PLAYER)
		{
            if(pvData[i][cExtraID] == pData[otherid][pID])
            {
                if(pvData[i][cRent] != 0)
                {
                    SendClientMessageEx(otherid, ARWIN, "RENT: "WHITE_E"You have withdrawn the player's rental vehicle %s", ReturnName(otherid));
                    SendClientMessageEx(otherid, ARWIN, "RENT: "WHITE_E"Admin %s has forcibly withdrawn your rental vehicle", pData[playerid][pAdminname]);
                    new query[128];
                    mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
                    mysql_tquery(g_SQL, query);
                    if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
                    pvData[i][cVeh] = INVALID_VEHICLE_ID;
                    Iter_SafeRemove(PVehicles, i, i);
                    pData[otherid][pRents] = -1;
                }
            }
        }
    }
    return 1;
}


CMD:unrentpv(playerid, params[])
{
	for(new id = 0 ; id < MAX_RENT; id++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, rentData[id][rX], rentData[id][rY], rentData[id][rZ]))
        {
            foreach(new i : PVehicles)			
            {
                if(GetVehicleType(i) == VEHICLE_TYPE_PLAYER)
		        {
                    if(pvData[i][cExtraID] == pData[playerid][pID])
                    {
                        if(pvData[i][cRent] != 0)
                        {
                            SendClientMessageEx(playerid, ARWIN, "VEHICLE: "WHITE_E"You has unrental the vehicle id %d (database id: %d).", i, pvData[i][cID]);
                            new query[128];
                            mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
                            mysql_tquery(g_SQL, query);
                            if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
                            pvData[i][cVeh] = INVALID_VEHICLE_ID;
                            Iter_SafeRemove(PVehicles, i, i);
                            pData[playerid][pRents] = -1;
                        }
                    }
                }
            }
        }
    }        
	return 1;
}
