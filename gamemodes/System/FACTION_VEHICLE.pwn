#include <YSI_Coding\y_hooks>

#define MAX_FACTION_VEHICLE			200

enum e_faction_vehicle
{
	fvID,
	bool:fvExists,
	fvModel,
	Float:fvPos[4],
	fvColor[2],
	fvFaction,
	fvVehicle,
    fvGarage,
	fvState
};
new FactionVehicle[MAX_FACTION_VEHICLE][e_faction_vehicle];

enum
{
	FACTION_STATE_SPAWN = 0,
	FACTION_STATE_DESPAWN
};

stock FactionVehicle_Create(factionid, fac_garage, model, Float:x, Float:y, Float:z, Float:a, color1, color2)
{
	forex(i, MAX_FACTION_VEHICLE) if(!FactionVehicle[i][fvExists])
	{
		FactionVehicle[i][fvPos][0] = x;
		FactionVehicle[i][fvPos][1] = y;
		FactionVehicle[i][fvPos][2] = z;
		FactionVehicle[i][fvPos][3] = a;
		FactionVehicle[i][fvColor][0] = color1;
		FactionVehicle[i][fvColor][1] = color2;
		FactionVehicle[i][fvModel] = model;
		FactionVehicle[i][fvExists] = true;
		FactionVehicle[i][fvFaction] = factionid;
        FactionVehicle[i][fvGarage] = fac_garage;
		FactionVehicle[i][fvState] = FACTION_STATE_SPAWN;

		FactionVehicle[i][fvVehicle] = CreateVehicle(model, x, y, z, a, color1, color2, 60000);
		SetVehicleFuel(FactionVehicle[i][fvVehicle], 100);
		
		mysql_tquery(g_SQL, "INSERT INTO `factionvehicle` (`Model`) VALUES(0)", "OnFactionVehicleCreated", "d", i);
		return 1;
	}
	return -1;
}

stock FactionVehicle_GetID(vehicleid)
{
	forex(i, MAX_FACTION_VEHICLE) if(FactionVehicle[i][fvExists] && FactionVehicle[i][fvVehicle] == vehicleid)
	{
	    return i;
	}
	return -1;
}

function OnFactionVehicleCreated(id)
{
	FactionVehicle[id][fvID] = cache_insert_id();
	FactionVehicle_Save(id);
}

stock FactionVehicle_Save(id)
{

	if(!FactionVehicle[id][fvExists])
		return 0;

	new query[1012];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE `factionvehicle` SET ");
	mysql_format(g_SQL, query, sizeof(query), "%s`Model` = '%d', ", query,FactionVehicle[id][fvModel]);
	mysql_format(g_SQL, query, sizeof(query), "%s`PosX` = '%f', ", query, FactionVehicle[id][fvPos][0]);
	mysql_format(g_SQL, query, sizeof(query), "%s`PosY` = '%f', ", query,FactionVehicle[id][fvPos][1]);
	mysql_format(g_SQL, query, sizeof(query), "%s`PosZ` = '%f', ", query,FactionVehicle[id][fvPos][2]);
	mysql_format(g_SQL, query, sizeof(query), "%s`PosA` = '%f', ", query,FactionVehicle[id][fvPos][3]);
	mysql_format(g_SQL, query, sizeof(query), "%s`Color1` = '%d', ", query,FactionVehicle[id][fvColor][0]);
	mysql_format(g_SQL, query, sizeof(query), "%s`Color2` = '%d', ", query,FactionVehicle[id][fvColor][1]);
	mysql_format(g_SQL, query, sizeof(query), "%s`Faction` = '%d' ", query,FactionVehicle[id][fvFaction]);
    mysql_format(g_SQL, query, sizeof(query), "%s`Garage` = '%d' ", query,FactionVehicle[id][fvGarage]);
	mysql_format(g_SQL, query, sizeof(query), "%s`State` = '%d' ", query,FactionVehicle[id][fvState]);
	mysql_format(g_SQL, query, sizeof(query), "%sWHERE `ID` = '%d'", query, FactionVehicle[id][fvID]);
	mysql_tquery(g_SQL, query);
	return 1;
}

function FactionVehicle_Load(id)
{
	if(cache_num_rows())
	{
		forex(i, cache_num_rows())
		{
			FactionVehicle[i][fvExists] = true;
			cache_get_value_name_int(i, "ID", FactionVehicle[i][fvID]);
			cache_get_value_name_int(i, "Model", FactionVehicle[i][fvModel]);
			cache_get_value_name_float(i, "PosX", FactionVehicle[i][fvPos][0]);
			cache_get_value_name_float(i, "PosY", FactionVehicle[i][fvPos][1]);
			cache_get_value_name_float(i, "PosZ", FactionVehicle[i][fvPos][2]);
			cache_get_value_name_float(i, "PosA", FactionVehicle[i][fvPos][3]);
			cache_get_value_name_int(i, "Color1", FactionVehicle[i][fvColor][0]);
			cache_get_value_name_int(i, "Color2", FactionVehicle[i][fvColor][1]);
			cache_get_value_name_int(i, "Faction", FactionVehicle[i][fvFaction]);
            cache_get_value_name_int(i, "Garage", FactionVehicle[i][fvGarage]);
			cache_get_value_name_int(i, "State", FactionVehicle[i][fvState]);

			//FactionVehicle[i][fvVehicle] = INVALID_VEHICLE_ID;

			if(FactionVehicle[i][fvState] == FACTION_STATE_SPAWN)
			{
				FactionVehicle[i][fvVehicle] = CreateVehicle(FactionVehicle[i][fvModel], FactionVehicle[i][fvPos][0], FactionVehicle[i][fvPos][1], FactionVehicle[i][fvPos][2], FactionVehicle[i][fvPos][3], FactionVehicle[i][fvColor][0], FactionVehicle[i][fvColor][1], 60000);
				SetVehicleFuel(FactionVehicle[i][fvVehicle], 100);
			}
		}
		printf("[FACTION VEHICLE] Loaded %d faction vehicle from database", cache_num_rows());
	}
	return 1;
}

FactionVehicle_Delete(id, bool:sync = false)
{
	if(sync == false)
	{
		new query[128];
		mysql_format(g_SQL, query, 128, "DELETE FROM `factionvehicle` WHERE `ID` = '%d'", FactionVehicle[id][fvID]);
		mysql_tquery(g_SQL, query);

		if(IsValidVehicle(FactionVehicle[id][fvVehicle]))
			DestroyVehicle(FactionVehicle[id][fvVehicle]);

		FactionVehicle[id][fvVehicle] = INVALID_VEHICLE_ID;
		FactionVehicle[id][fvState] = FACTION_STATE_DESPAWN;
		FactionVehicle[id][fvFaction] = 0;
		FactionVehicle[id][fvExists] = false;
		FactionVehicle[id][fvModel] = 0;
	}
	else
	{
		if(IsValidVehicle(FactionVehicle[id][fvVehicle]))
			DestroyVehicle(FactionVehicle[id][fvVehicle]);

		FactionVehicle[id][fvState] = FACTION_STATE_DESPAWN;
	}
	return 1;
}

stock IsFactionVehicle(vehicleid)
{
	forex(i, MAX_FACTION_VEHICLE) if(FactionVehicle[i][fvExists] && FactionVehicle[i][fvVehicle] == vehicleid)
		return i;

	return -1;
}

CMD:createfactionveh(playerid, params[])
{
	new
	    model[32],
		color1,
		color2,
		factid,
        fac_garage;

	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	if (sscanf(params, "dds[32]I(-1)I(-1)", factid, fac_garage, model, color1, color2))
	    return Usage(playerid, "/createfactionveh [factionid] [faction garage] [model id/name] <color 1> <color 2>");

	if(factid < 0 || factid > 4)
        return Error(playerid, "You have specified an invalid faction ID 0 - 4.");

	if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return Error(playerid, "Invalid model ID.");

	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:a;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

	new id = FactionVehicle_Create(factid, fac_garage, model[0], x, y, z, a, color1, color2);

	if(id == -1)
		return Error(playerid, "You cannot create more faction vehicle!");

	Servers(playerid, "You have successfully create vehicle for faction id %d", factid);
	return 1;
}

CMD:editfactionveh(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (pData[playerid][pAdmin] < 6)
	    return Error(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	Usage(playerid, "/editfactionveh [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "Names:{FFFFFF} pos");
		return 1;
	}
	if(!strcmp(type, "pos", true))
	{
		if(!IsPlayerInVehicle(playerid, FactionVehicle[id][fvVehicle]))
			return Error(playerid, "You must inside the faction vehicle!");

		GetVehiclePos(GetPlayerVehicleID(playerid), FactionVehicle[id][fvPos][0], FactionVehicle[id][fvPos][1], FactionVehicle[id][fvPos][2]);
		GetVehicleZAngle(GetPlayerVehicleID(playerid), FactionVehicle[id][fvPos][3]);

		Servers(playerid, "You have adjusted position for faction vehicle id %d", id);
		FactionVehicle_Save(id);
	}

	return 1;
}

CMD:gotofactionveh(playerid, params[])
{
	if (pData[playerid][pAdmin] < 6)
	    return Error(playerid, "You don't have permission to use this command.");

	if(isnull(params))
		return Usage(playerid, "/gotofactionveh [id]");

	if(!IsNumeric(params))
		return Error(playerid, "Invalid faction vehicle ID!");

	if(!FactionVehicle[strval(params)][fvExists])
		return Error(playerid, "Invalid faction vehicle ID!");

	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetVehiclePos(FactionVehicle[strval(params)][fvVehicle], x, y, z);
	SetPlayerPos(playerid, x, y - 2, z + 2);
	return 1;
}

CMD:destroyfactionveh(playerid, params[])
{
	if (pData[playerid][pAdmin] < 6)
	    return Error(playerid, "You don't have permission to use this command.");
	
	if(isnull(params))
		return Usage(playerid, "/destroyfactionveh [vehicleid]");

	if(!IsNumeric(params))
		return Error(playerid, "Invalid vehicle ID");

	if(!IsValidVehicle(strval(params)))
		return Error(playerid, "Invalid vehicle ID");

	if(IsFactionVehicle(strval(params)) == -1)
		return Error(playerid, "That vehicle is not faction vehicle!");	

	FactionVehicle_Delete(IsFactionVehicle(strval(params)));
	Servers(playerid, "You have removed faction vehicle id", IsFactionVehicle(strval(params)));
	return 1;
}

hook OnGameModeExit()
{
    forex(id, MAX_FACTION_VEHICLE) if(IsValidVehicle(FactionVehicle[id][fvVehicle]))
    {
        GetVehiclePos(FactionVehicle[id][fvVehicle], FactionVehicle[id][fvPos][0], FactionVehicle[id][fvPos][1], FactionVehicle[id][fvPos][2]);
        GetVehicleZAngle(FactionVehicle[id][fvVehicle], FactionVehicle[id][fvPos][3]);

		FactionVehicle[id][fvState] = FACTION_STATE_SPAWN;
        FactionVehicle_Save(id);
    }
}

/*
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_YES)
	{
		new id = GetFactionByID(pData[playerid][pFactionID]);

		if(id != -1)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, FactionData[id][factionVehicleAcces][0], FactionData[id][factionVehicleAcces][1], FactionData[id][factionVehicleAcces][2]))
			{
				ShowPlayerDialog(playerid, DIALOG_FACTION_VEHICLE, DIALOG_STYLE_LIST, "Static Vehicle", "Spawn Vehicle\nDespawn Vehicle", "Select", "Close");
			}
		}
	}
	return 1;
}*/