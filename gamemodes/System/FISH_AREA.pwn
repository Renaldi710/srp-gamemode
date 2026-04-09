//header
#define MAX_FISHING_AREA 50
enum fishingarea {
    ID,
    Float:Pos[3],
    Type,
    Zone
}
new FishingData[MAX_FISHING_AREA][fishingarea],
    Iterator:FishingArea<MAX_FISHING_AREA>;
new mapiconfishing[MAX_PLAYERS][MAX_FISHING_AREA];

//querys

function FishingAreaLoad()
{
    new rows = cache_num_rows();
 	if(rows)
  	{
   		new fishing;
		for(new i; i < rows; i++)
		{
  			cache_get_value_name_int(i, "ID", fishing);
			cache_get_value_name_float(i, "PosX", FishingData[fishing][Pos][0]);
            cache_get_value_name_float(i, "PosY", FishingData[fishing][Pos][1]);
            cache_get_value_name_float(i, "PosZ", FishingData[fishing][Pos][2]);
			FishingData[fishing][ID] = fishing;
            FishingData[fishing][Type] = random(3);
			FishingData[fishing][Zone] = CreateDynamicSphere(FishingData[fishing][Pos][0], FishingData[fishing][Pos][1], FishingData[fishing][Pos][2], 70.0);
			Iter_Add(FishingArea, fishing);
	    }
	    printf("*** [Database: Loaded] Fishing Area data (%d count).", rows);
	}
}

FishingAreaSave(fishing)
{
	new dquery[2048];
	mysql_format(g_SQL, dquery, sizeof(dquery), "UPDATE fishingarea SET `PosX` = '%f', `PosY` = '%f', `PosZ` = '%f' WHERE ID='%d'",
	FishingData[fishing][Pos][0],
	FishingData[fishing][Pos][1],
	FishingData[fishing][Pos][2],
    fishing);
	return mysql_tquery(g_SQL, dquery);
}

//task
ptask Update_Zone_Fish[1000](playerid)
{
    if(IsPlayerInAnyVehicle(playerid) && IsABoat(GetPlayerVehicleID(playerid))) 
    {
        foreach(new fishing : FishingArea) 
        {
            if(IsPlayerInDynamicArea(playerid, FishingData[fishing][Zone]))
            {
                new zone[52];
                switch(FishingData[fishing][Type]) 
                {
                    case 0: zone = "~r~Low";
                    case 1: zone = "~y~Medium";
                    case 2: zone = "~g~High";
                }

                GameTextForPlayer(playerid, sprintf("~w~Boat signal~n~~r~~h~%s", zone), 1000, 4);
            }
        }
    }
    return 1;
}

//cmds

CMD:fishing(playerid, params[])
{
    static 
        type[24], 
        string[128]
    ;

    if(pData[playerid][pAdmin] < 6) return PermissionError(playerid);
    if(sscanf(params, "s[24]S()[128]", type, string)) return Usage(playerid, "/fishing [create/pos/random/goto/delete]");
    if(!strcmp(type, "create", true))
    {
        new fishing = Iter_Free(FishingArea);
        if(fishing == -1) return Error(playerid, "Anda tidak bisa membuat area mancing lagi!");
        GetPlayerPos(playerid, FishingData[fishing][Pos][0], FishingData[fishing][Pos][1], FishingData[fishing][Pos][2]);
        FishingData[fishing][Zone] = CreateDynamicSphere(FishingData[fishing][Pos][0], FishingData[fishing][Pos][1], FishingData[fishing][Pos][2], 70.0);
        FishingData[fishing][Type] = random(3);
        Custom(playerid, "FISHINGAREA", "Anda berhasil membuat area mancing ID:%d", fishing);
        Iter_Add(FishingArea, fishing);
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO fishingarea SET ID=%d, PosX='%f', PosY='%f', PosZ='%f'", fishing, FishingData[fishing][Pos][0], FishingData[fishing][Pos][1], FishingData[fishing][Pos][2]);
        mysql_tquery(g_SQL, query);
    }
    else if(!strcmp(type, "pos", true))
    {
        new fishing;
        if(sscanf(string, "d", fishing)) return Usage(playerid, "/fishing [pos] [id]");
		if(!Iter_Contains(FishingArea, fishing)) return Error(playerid, "The you specified ID of doesn't exist.");
        GetPlayerPos(playerid, FishingData[fishing][Pos][0], FishingData[fishing][Pos][1], FishingData[fishing][Pos][2]);
        Custom(playerid, "FISHINGAREA", "Anda telah mengganti posisi area mancing ID:%d", fishing);
        FishingAreaSave(fishing);
    }
    else if(!strcmp(type, "random", true))
    {
        foreach(new fishing : FishingArea) {
            FishingData[fishing][Type] = random(3);
            if(IsValidDynamicMapIcon(mapiconfishing[playerid][fishing])) DestroyDynamicMapIcon(mapiconfishing[playerid][fishing]);
            if(IsABoat(GetPlayerVehicleID(playerid)))
            {
                switch(FishingData[fishing][Type]) {
                    case 0: mapiconfishing[playerid][fishing] = CreateDynamicMapIcon(FishingData[fishing][Pos][0], FishingData[fishing][Pos][1], FishingData[fishing][Pos][2], 0, COLOR_RED, 0, 0, playerid, 1000, MAPICON_LOCAL);
                    case 1: mapiconfishing[playerid][fishing] = CreateDynamicMapIcon(FishingData[fishing][Pos][0], FishingData[fishing][Pos][1], FishingData[fishing][Pos][2], 0, 0xFFFF0000, 0, 0, playerid, 1000, MAPICON_LOCAL);
                    case 2: mapiconfishing[playerid][fishing] = CreateDynamicMapIcon(FishingData[fishing][Pos][0], FishingData[fishing][Pos][1], FishingData[fishing][Pos][2], 0, 0x00FF0000, 0, 0, playerid, 1000, MAPICON_LOCAL);
                }
            }
        }
    }
    else if(!strcmp(type, "goto", true))
    {
        new fishing;
        if(sscanf(string, "d", fishing)) return Usage(playerid, "/fishing [goto] [id]");
		if(!Iter_Contains(FishingArea, fishing)) return Error(playerid, "The you specified ID of doesn't exist.");
        SetPlayerPos(playerid, FishingData[fishing][Pos][0], FishingData[fishing][Pos][1], FishingData[fishing][Pos][2]);
    }
    else if(!strcmp(type, "delete", true))
    {
        new fishing;
        if(sscanf(string, "d", fishing)) return Usage(playerid, "/fishing [pos] [id]");
		if(!Iter_Contains(FishingArea, fishing)) return Error(playerid, "The you specified ID of doesn't exist.");
        Custom(playerid, "FISHINGAREA", "Anda telah menghapus area mancing ID:%d", fishing);
        Iter_Remove(FishingArea, fishing);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM fishingarea WHERE ID=%d", fishing);
		mysql_tquery(g_SQL, query);
    }
    return 1;
}
