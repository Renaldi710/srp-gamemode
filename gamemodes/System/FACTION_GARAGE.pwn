#include <YSI_Coding\y_hooks>

#define             MAX_FACTION_GARAGE              15

enum E_FACTION_GARAGE {
    fgID,
    fgFaction,
    Float:fgPos[3],
    Float:fgSpawnPos[4],
    STREAMER_TAG_PICKUP:fgCP,
    STREAMER_TAG_3D_TEXT_LABEL:fgLabel,
    fgWorld,
    fgInt
};
new
    FactionGarage[MAX_FACTION_GARAGE][E_FACTION_GARAGE],
    Iterator:FactionGarages<MAX_FACTION_GARAGE>;


FactionGarage_Create(faction_id, Float:x, Float:y, Float:z) {

    new id = ITER_NONE;

    if((id = Iter_Alloc(FactionGarages)) != ITER_NONE) {

        FactionGarage[id][fgFaction] = faction_id;
        FactionGarage[id][fgPos][0] = x;
        FactionGarage[id][fgPos][1] = y;
        FactionGarage[id][fgPos][2] = z;

        for(new i = 0; i < 4; i++) {
            FactionGarage[id][fgSpawnPos][i] = 0.0;
        }
        FactionGarage_Sync(id);

        mysql_tquery(g_SQL, "INSERT INTO `factiongarage` (`Faction`) VALUES('0')", "OnFactionGarageCreated", "d", id);
    }
    return id;
}

function OnFactionGarageCreated(id) {
    if(Iter_Contains(FactionGarages, id)) {
        FactionGarage[id][fgID] = cache_insert_id();
        FactionGarage_Save(id);
    }
    return 1;
}

FactionGarage_Save(id) {
    if(Iter_Contains(FactionGarages, id)) {
        new query[512];
        mysql_format(g_SQL, query, 512, "UPDATE `factiongarage` SET `Faction` = '%d', `PosX` = '%.4f', `PosY` = '%.4f', `PosZ` = '%.4f', `SpawnX` = '%.4f', `SpawnY` = '%.4f', `SpawnZ` = '%.4f', `SpawnA` = '%.4f', `World` = '%d', `Int` = '%d' WHERE `ID` = '%d'",
            FactionGarage[id][fgFaction],
            FactionGarage[id][fgPos][0],
            FactionGarage[id][fgPos][1],
            FactionGarage[id][fgPos][2],
            FactionGarage[id][fgSpawnPos][0],
            FactionGarage[id][fgSpawnPos][1],
            FactionGarage[id][fgSpawnPos][2],
            FactionGarage[id][fgSpawnPos][3],
            FactionGarage[id][fgWorld],
            FactionGarage[id][fgInt],
            FactionGarage[id][fgID]
        );
        mysql_tquery(g_SQL, query);
    }
    return 1;
}

FactionGarage_Sync(id) {
    static 
        str[420]
    ;
    
    format(str, sizeof str, "[ID: %d]\n"SLATEBLUE"%s\n"GRAY"Faction Vehicle Garage\n"YELLOW"/spawn "WHITE"- spawn vehicle\n"YELLOW"/despawn "WHITE"- despawn vehicle", id, GetFactionName2(FactionGarage[id][fgFaction]));

    if(Iter_Contains(FactionGarages, id)) 
    {
        if(IsValidDynamic3DTextLabel(FactionGarage[id][fgLabel])) 
        {
            Streamer_SetItemPos(STREAMER_TYPE_3D_TEXT_LABEL, FactionGarage[id][fgLabel], FactionGarage[id][fgPos][0], FactionGarage[id][fgPos][1], FactionGarage[id][fgPos][2]+0.5);
            Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, FactionGarage[id][fgLabel], E_STREAMER_WORLD_ID, FactionGarage[id][fgWorld]);
		    Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, FactionGarage[id][fgLabel], E_STREAMER_INTERIOR_ID, FactionGarage[id][fgInt]);
        }
        else FactionGarage[id][fgLabel] = CreateDynamic3DTextLabel(str, -1, FactionGarage[id][fgPos][0], FactionGarage[id][fgPos][1], FactionGarage[id][fgPos][2]+0.5, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, FactionGarage[id][fgWorld], FactionGarage[id][fgInt], -1, 10.0, -1, 0);
    
        if(IsValidDynamicPickup(FactionGarage[id][fgCP])) 
        {
            Streamer_SetItemPos(STREAMER_TYPE_PICKUP, FactionGarage[id][fgCP], FactionGarage[id][fgPos][0], FactionGarage[id][fgPos][1], FactionGarage[id][fgPos][2]+0.2);
            Streamer_SetIntData(STREAMER_TYPE_PICKUP, FactionGarage[id][fgCP], E_STREAMER_WORLD_ID, FactionGarage[id][fgWorld]);
		    Streamer_SetIntData(STREAMER_TYPE_PICKUP, FactionGarage[id][fgCP], E_STREAMER_INTERIOR_ID, FactionGarage[id][fgInt]);
        }
        else FactionGarage[id][fgCP] = CreateDynamicPickup(1239, 23, FactionGarage[id][fgPos][0], FactionGarage[id][fgPos][1], FactionGarage[id][fgPos][2]+0.2, FactionGarage[id][fgWorld], FactionGarage[id][fgInt], _, 10.0);
    }
    return 1;
}

FactionGarage_Nearest(playerid) {
    new index = -1;
    foreach(new id : FactionGarages) if(IsPlayerInRangeOfPoint(playerid, 3.0, FactionGarage[id][fgPos][0], FactionGarage[id][fgPos][1], FactionGarage[id][fgPos][2]) && GetPlayerInterior(playerid) == FactionGarage[id][fgInt] && GetPlayerVirtualWorld(playerid) == FactionGarage[id][fgWorld]) {
        index = id;
        break;
    }
    return index;
}
function FactionGarage_Load() {
    if(cache_num_rows()) {
        for(new i = 0; i < cache_num_rows(); i++) {

            Iter_Add(FactionGarages, i);

            cache_get_value_name_int(i, "ID", FactionGarage[i][fgID]);
            cache_get_value_name_int(i, "Faction", FactionGarage[i][fgFaction]);
            cache_get_value_name_float(i, "SpawnX", FactionGarage[i][fgSpawnPos][0]);
            cache_get_value_name_float(i, "SpawnY", FactionGarage[i][fgSpawnPos][1]);
            cache_get_value_name_float(i,"SpawnZ", FactionGarage[i][fgSpawnPos][2]);
            cache_get_value_name_float(i,"SpawnA", FactionGarage[i][fgSpawnPos][3]);
            cache_get_value_name_float(i,"PosX", FactionGarage[i][fgPos][0]);
            cache_get_value_name_float(i,"PosY", FactionGarage[i][fgPos][1]);
            cache_get_value_name_float(i,"PosZ", FactionGarage[i][fgPos][2]);
            cache_get_value_name_int(i, "World", FactionGarage[i][fgWorld]);
            cache_get_value_name_int(i, "Int", FactionGarage[i][fgInt]);

            FactionGarage_Sync(i);
        }
        printf("[FACTIONGARAGE] Loaded %d faction garage from database.", cache_num_rows());
    }
    return 1;
}
CMD:createfgarage(playerid, params[]) {
    if (pData[playerid][pAdmin] < 5)
        return Error(playerid, "You don't have permission to use this command.");

    new faction_id = -1, faction_garage = ITER_NONE;

    if(sscanf(params, "d", faction_id))
        return Usage(playerid, "/createfgarage [faction id]");

    if(faction_id < 0 || faction_id > 4)
        return Error(playerid, "You have specified an invalid faction ID 0 - 4.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    faction_garage = FactionGarage_Create(faction_id, x, y, z);

    if(faction_garage == ITER_NONE)
        return Error(playerid, "Server cannot create more faction garage.");

    SendAdminMessage(X11_TOMATO, "%s have successfully created faction garage ID:%d for faction %s", pData[playerid][pAdminname], faction_garage, GetFactionName(faction_id));
    return 1;
}

CMD:editfgarage(playerid, params[]) {

    if (pData[playerid][pAdmin] < 5)
        return Error(playerid, "You don't have permission to use this command.");

    new garage_id, string[128], type[24];
    if(sscanf(params, "ds[24]S()[128]", garage_id, type, string))
        return Usage(playerid, "/editfgarage [garage id] [location/spawnpos/destroy]");

    if(!strcmp(type, "location", true)) {

        GetPlayerPos(playerid, FactionGarage[garage_id][fgPos][0], FactionGarage[garage_id][fgPos][1], FactionGarage[garage_id][fgPos][2]);
        FactionGarage[garage_id][fgWorld] = GetPlayerVirtualWorld(playerid);
        FactionGarage[garage_id][fgInt] = GetPlayerInterior(playerid);

        SendAdminMessage(X11_TOMATO, "%s have adjusted location of Faction Garage ID: %d.", pData[playerid][pAdminname], garage_id);
        FactionGarage_Sync(garage_id);

        FactionGarage_Save(garage_id);
    }
    else if(!strcmp(type, "spawnpos", true)) {

        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            return Error(playerid, "You must driving a vehicle.");

        GetVehiclePos(GetPlayerVehicleID(playerid), FactionGarage[garage_id][fgSpawnPos][0], FactionGarage[garage_id][fgSpawnPos][1], FactionGarage[garage_id][fgSpawnPos][2]);
        GetVehicleZAngle(GetPlayerVehicleID(playerid), FactionGarage[garage_id][fgSpawnPos][3]);

        FactionGarage_Save(garage_id);

        SendAdminMessage(X11_TOMATO, "%s have adjusted vehicle spawn position Garage ID:%d", pData[playerid][pAdminname], garage_id);
    }
    else if(!strcmp(type, "destroy", true)) {

        if(IsValidDynamicPickup(FactionGarage[garage_id][fgCP]))
            DestroyDynamicPickup(FactionGarage[garage_id][fgCP]);

        if(IsValidDynamic3DTextLabel(FactionGarage[garage_id][fgLabel]))
            DestroyDynamic3DTextLabel(FactionGarage[garage_id][fgLabel]);

        FactionGarage[garage_id][fgCP] = STREAMER_TAG_PICKUP: INVALID_STREAMER_ID;
        FactionGarage[garage_id][fgLabel] = STREAMER_TAG_3D_TEXT_LABEL: INVALID_STREAMER_ID;

        SendAdminMessage(X11_TOMATO, "%s have destroyed Faction Garage ID: %d", pData[playerid][pAdminname], garage_id);
        mysql_tquery(g_SQL, sprintf("DELETE FROM `factiongarage` WHERE `ID` = '%d'", FactionGarage[garage_id][fgID]));
        
        Iter_Remove(FactionGarages, garage_id);
    }
    return 1;
}

CMD:spawn(playerid, params[])
{
    new id = FactionGarage_Nearest(playerid);
    if(id == -1) return Error(playerid, "Anda tidak berada di dekat garasi faction");
    if(pData[playerid][pFaction] != FactionGarage[id][fgFaction]) return Error(playerid, "Garasi ini bukan bagian faction anda");

    new str[2048], line[128], count = 0;
    format(str, sizeof(str), "ID\tModel\tUnit\tStatus\n");

    foreach(new i : PVehicles)
    {
        if(GetVehicleType(i) == VEHICLE_TYPE_FACTION && pvData[i][cExtraID] == pData[playerid][pFaction])
        {
            ListedVehicles[playerid][count++] = i;

            if(IsValidVehicle(pvData[i][cVeh]))
                format(line, sizeof(line), "%d\t%s\t%s\t"YELLOW"Used\n", pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate]);
            else
                format(line, sizeof(line), "-\t%s\t%s\t"GREEN"Ready\n", GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate]);

            strcat(str, line);
        }
    }

    if(count == 0) return Error(playerid, "Tidak ada kendaraan faction yang tersedia.");
    
    SetPVarInt(playerid, "FGarage_ID", id);
    Dialog_Show(playerid, FactionVehicleSpawn, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle List", str, "Select", "Close");
    return 1;
}


CMD:despawn(playerid, params[])
{
    static 
        count = 0
    ;

    if(pData[playerid][pFaction] == 0) 
        return Error(playerid, "Anda tidak bergabung di faction mana pun");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return Error(playerid, "You must driving a vehicle.");

    foreach(new garage_id : PVehicles) 
    {
        if(GetVehicleType(garage_id) == VEHICLE_TYPE_FACTION)
        {
            if(GetPlayerVehicleID(playerid) == pvData[garage_id][cVeh])
            {
                foreach(new id : FactionGarages) if(IsPlayerInRangeOfPoint(playerid, 3.0, FactionGarage[id][fgPos][0], FactionGarage[id][fgPos][1], FactionGarage[id][fgPos][2])) 
                {
                    count++;
                    Vehicle(playerid, "Anda berhasil mendespawn kendaraan "LIGHTGREEN"%s (%s)", GetVehicleModelName(pvData[garage_id][cModel]), pvData[garage_id][cPlate]);
                    DestroyVehicle(pvData[garage_id][cVeh]);
                    pvData[garage_id][cVeh] = INVALID_VEHICLE_ID;
                    pvData[garage_id][cClaim] = 1;
                    DisablePlayerRaceCheckpoint(playerid);
                }
            }
        }
    }

    if(count == 0)
        return Error(playerid, "Kendaraan ini bukan kendaraan faction/tidak berada di faction garage");

    return 1;
}

Dialog:FactionVehicleSpawn(playerid, response, listitem, inputtext[]) {	
	if(!response) {
        SetPVarInt(playerid, "FGarage_ID", -1);
        return 1;
    }

    new i = ListedVehicles[playerid][listitem],
        gid = GetPVarInt(playerid, "FGarage_ID");

    if(IsValidVehicle(pvData[i][cVeh]))
        return Error(playerid, "Kendaraan static ini sedang terpakai/telah terspawn");

    pvData[i][cPosX] = FactionGarage[gid][fgSpawnPos][0];
    pvData[i][cPosY] = FactionGarage[gid][fgSpawnPos][1];
    pvData[i][cPosZ] = FactionGarage[gid][fgSpawnPos][2];
    pvData[i][cPosA] = FactionGarage[gid][fgSpawnPos][3];
    pvData[i][cVw] = FactionGarage[gid][fgWorld];
    pvData[i][cInt] = FactionGarage[gid][fgInt];

    pvData[i][cClaim] = 0; //cClaim adalah status kendaraan nya, spawn/despawn
    OnFactionVehicleRespawn(i);
    ListedVehicles[playerid][listitem] = -1;
    SetPVarInt(playerid, "FGarage_ID", -1);
    return 1;
}