#include <YSI_Coding\y_hooks>

#define	MAX_BASEMENT	500

enum bbsmt
{
	bmName[128],
	bmPass[32],
	bmIcon,
	bmLocked,
	bmAdmin,
	bmVip,
	bmFaction,
	bmFamily,
	bmExtvw,
	bmExtint,
	Float:bmExtposX,
	Float:bmExtposY,
	Float:bmExtposZ,
	Float:bmExtposA,
	bmIntvw,
	bmIntint,
	Float:bmIntposX,
	Float:bmIntposY,
	Float:bmIntposZ,
	Float:bmIntposA,

	Float:bmInexitX,
	Float:bmInexitY,
	Float:bmInexitZ,

	Float:bmOutexitX,
	Float:bmOutexitY,
	Float:bmOutexitZ,
	Float:bmOutexitA,

	//NotSave
	STREAMER_TAG_3D_TEXT_LABEL:bmLabelext,
	STREAMER_TAG_PICKUP: bmPickupext,
	STREAMER_TAG_3D_TEXT_LABEL:bmLabelexit,
	STREAMER_TAG_PICKUP: bmPickupexit,
	bmEntranceCP,
	bmExitCP
};

new BasementData[MAX_BASEMENT][bbsmt],
	Iterator: Basement<MAX_BASEMENT>;

Basement_Save(bmid)
{
	new dquery[2048];
	mysql_format(g_SQL, dquery, sizeof(dquery), "UPDATE `basement` SET `name`='%e', `password`='%e', `icon`=%d, `locked`=%d, `admin`=%d, `vip`=%d, `faction`=%d, `family`=%d, `extvw`=%d, `extint`=%d, `extposx`='%f', `extposy`='%f', `extposz`='%f', `extposa`='%f', `intvw`=%d, `intint`=%d, `intposx`='%f', `intposy`='%f', `intposz`='%f', `intposa`='%f', `inexitx`='%f', `inexity`='%f', `inexitz`='%f', `outexitx`='%f', `outexity`='%f', `outexitz`='%f', `outexita`='%f' WHERE ID=%d",
	BasementData[bmid][bmName], BasementData[bmid][bmPass], BasementData[bmid][bmIcon], BasementData[bmid][bmLocked], BasementData[bmid][bmAdmin], BasementData[bmid][bmVip], BasementData[bmid][bmFaction], BasementData[bmid][bmFamily], BasementData[bmid][bmExtvw], BasementData[bmid][bmExtint], BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ], BasementData[bmid][bmExtposA], BasementData[bmid][bmIntvw], BasementData[bmid][bmIntint],
	BasementData[bmid][bmIntposX], BasementData[bmid][bmIntposY], BasementData[bmid][bmIntposZ], BasementData[bmid][bmIntposA], BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ], BasementData[bmid][bmOutexitX], BasementData[bmid][bmOutexitY], BasementData[bmid][bmOutexitZ], BasementData[bmid][bmOutexitA], bmid);
	mysql_pquery(g_SQL, dquery);
	return 1;
}

Basement_Rebuild(bmid)
{
	if(bmid != -1)
	{
		new mstr[512];
		format(mstr,sizeof(mstr),"[ID: %d]\n"GRAY"Basement Enter\n{FFFFFF}%s", bmid, BasementData[bmid][bmName]);
		BasementData[bmid][bmPickupext] = CreateDynamicPickup(BasementData[bmid][bmIcon], 23, BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ], BasementData[bmid][bmExtvw], BasementData[bmid][bmExtint], -1, 30.0, -1, 0);		
		BasementData[bmid][bmLabelext] = CreateDynamic3DTextLabel(mstr, COLOR_GREY, BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ]+0.80, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, BasementData[bmid][bmExtvw], BasementData[bmid][bmExtint], -1, 10.0, -1, 0);

    	format(mstr,sizeof(mstr),"[ID: %d]\n"GRAY"Basement Enter\n{FFFFFF}%s", bmid, BasementData[bmid][bmName]);
		BasementData[bmid][bmPickupexit] = CreateDynamicPickup(BasementData[bmid][bmIcon], 23, BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ], BasementData[bmid][bmIntvw], BasementData[bmid][bmIntint], -1, 30.0, -1, 0);
		BasementData[bmid][bmLabelexit] = CreateDynamic3DTextLabel(mstr, COLOR_GREY, BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ]+0.80, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, BasementData[bmid][bmIntvw], BasementData[bmid][bmIntint], -1, 10.0, -1, 0);

		BasementData[bmid][bmEntranceCP] = CreateDynamicCP(BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ], 3.0, BasementData[bmid][bmExtvw], BasementData[bmid][bmExtint], -1, 15.0, -1, 0);
		BasementData[bmid][bmExitCP] = CreateDynamicCP(BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ], 3.0, BasementData[bmid][bmIntvw], BasementData[bmid][bmIntint], -1, 15.0, -1, 0);
	}
}

Basement_Refresh(bmid)
{
	if(bmid != -1)
	{
		Streamer_SetItemPos(STREAMER_TYPE_PICKUP, BasementData[bmid][bmPickupext], BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ]);
		Streamer_SetIntData(STREAMER_TYPE_PICKUP, BasementData[bmid][bmPickupext], E_STREAMER_WORLD_ID, BasementData[bmid][bmExtvw]);
		Streamer_SetIntData(STREAMER_TYPE_PICKUP, BasementData[bmid][bmPickupext], E_STREAMER_INTERIOR_ID, BasementData[bmid][bmExtint]);

		Streamer_SetItemPos(STREAMER_TYPE_PICKUP, BasementData[bmid][bmPickupexit], BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ]);
		Streamer_SetIntData(STREAMER_TYPE_PICKUP, BasementData[bmid][bmPickupexit], E_STREAMER_WORLD_ID, BasementData[bmid][bmIntvw]);
		Streamer_SetIntData(STREAMER_TYPE_PICKUP, BasementData[bmid][bmPickupexit], E_STREAMER_INTERIOR_ID, BasementData[bmid][bmIntint]);

		Streamer_SetItemPos(STREAMER_TYPE_3D_TEXT_LABEL, BasementData[bmid][bmLabelext], BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ]+0.80);
		Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, BasementData[bmid][bmLabelext], E_STREAMER_WORLD_ID, BasementData[bmid][bmExtvw]);
		Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, BasementData[bmid][bmLabelext], E_STREAMER_INTERIOR_ID, BasementData[bmid][bmExtint]);

		new updtbmtext[512];
		format(updtbmtext,sizeof(updtbmtext),"[ID: %d]\n"GRAY"Basement Enter\n{FFFFFF}%s", bmid, BasementData[bmid][bmName]);
		UpdateDynamic3DTextLabelText(BasementData[bmid][bmLabelext], COLOR_GREY, updtbmtext);

		Streamer_SetItemPos(STREAMER_TYPE_3D_TEXT_LABEL, BasementData[bmid][bmLabelexit], BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ]+0.80);
		Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, BasementData[bmid][bmLabelexit], E_STREAMER_WORLD_ID, BasementData[bmid][bmIntvw]);
		Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, BasementData[bmid][bmLabelexit], E_STREAMER_INTERIOR_ID, BasementData[bmid][bmIntint]);
		
		new updexitbmt[512];
		format(updexitbmt,sizeof(updexitbmt),"[ID: %d]\n"GRAY"Basement Exit\n{FFFFFF}%s", bmid, BasementData[bmid][bmName]);
		UpdateDynamic3DTextLabelText(BasementData[bmid][bmLabelexit], COLOR_GREY, updexitbmt);

		Streamer_SetIntData(STREAMER_TYPE_PICKUP, BasementData[bmid][bmPickupext], E_STREAMER_MODEL_ID, BasementData[bmid][bmIcon]);
		Streamer_SetIntData(STREAMER_TYPE_PICKUP, BasementData[bmid][bmPickupexit], E_STREAMER_MODEL_ID, BasementData[bmid][bmIcon]);
	}
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	foreach(new bmid : Basement)
    {
        if(checkpointid == BasementData[bmid][bmEntranceCP])
        {
            if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
            {
                GameTextForPlayer(playerid, "~p~Basement~n~~w~Gunakan ~y~~k~~VEHICLE_HORN~~n~~w~Untuk Masuk", 3000, 4);
            }
            else
            {
                GameTextForPlayer(playerid, "~p~Basement~n~~w~Gunakan ~y~~k~~VEHICLE_ENTER_EXIT~~n~~w~Untuk Masuk", 3000, 4);
            }
        }
        else if(checkpointid == BasementData[bmid][bmExitCP])
        {
            if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
            {
                GameTextForPlayer(playerid, "~p~Basement~n~~w~Gunakan ~y~~k~~VEHICLE_HORN~~n~~w~Untuk Masuk", 3000, 4);
            }
            else
            {
                GameTextForPlayer(playerid, "~p~Basement~n~~w~Gunakan ~y~~k~~VEHICLE_ENTER_EXIT~~n~~w~Untuk Masuk", 3000, 4);
            }
        }
    }
	return 1;
}

forward OnBasementCreated(bmid);
public OnBasementCreated(bmid)
{
	Basement_Save(bmid);
	return 1;
}

forward LoadBasement();
public LoadBasement()
{
    new rows = cache_num_rows();
 	if(rows)
  	{
   		new bmid;

		for(new i; i < rows; i++)
		{
  			cache_get_value_name_int(i, "ID", bmid);
	    	cache_get_value_name(i, "name", BasementData[bmid][bmName]);
		    cache_get_value_name(i, "password", BasementData[bmid][bmPass]);

		    cache_get_value_name_int(i, "icon", BasementData[bmid][bmIcon]);
		    cache_get_value_name_int(i, "locked", BasementData[bmid][bmLocked]);
		    cache_get_value_name_int(i, "admin", BasementData[bmid][bmAdmin]);
		    cache_get_value_name_int(i, "vip", BasementData[bmid][bmVip]);
		    cache_get_value_name_int(i, "faction", BasementData[bmid][bmFaction]);
		    cache_get_value_name_int(i, "family", BasementData[bmid][bmFamily]);
		    cache_get_value_name_int(i, "extvw", BasementData[bmid][bmExtvw]);
		    cache_get_value_name_int(i, "extint", BasementData[bmid][bmExtint]);
		    cache_get_value_name_float(i, "extposx", BasementData[bmid][bmExtposX]);
			cache_get_value_name_float(i, "extposy", BasementData[bmid][bmExtposY]);
			cache_get_value_name_float(i, "extposz", BasementData[bmid][bmExtposZ]);
			cache_get_value_name_float(i, "extposa", BasementData[bmid][bmExtposA]);
			cache_get_value_name_int(i, "intvw", BasementData[bmid][bmIntvw]);
			cache_get_value_name_int(i, "intint", BasementData[bmid][bmIntint]);
			cache_get_value_name_float(i, "intposx", BasementData[bmid][bmIntposX]);
			cache_get_value_name_float(i, "intposy", BasementData[bmid][bmIntposY]);
			cache_get_value_name_float(i, "intposz", BasementData[bmid][bmIntposZ]);
			cache_get_value_name_float(i, "intposa", BasementData[bmid][bmIntposA]);

			cache_get_value_name_float(i, "inexitx", BasementData[bmid][bmInexitX]);
			cache_get_value_name_float(i, "inexity", BasementData[bmid][bmInexitY]);
			cache_get_value_name_float(i, "inexitz", BasementData[bmid][bmInexitZ]);

			cache_get_value_name_float(i, "outexitx", BasementData[bmid][bmOutexitX]);
			cache_get_value_name_float(i, "outexity", BasementData[bmid][bmOutexitY]);
			cache_get_value_name_float(i, "outexitz", BasementData[bmid][bmOutexitZ]);
			cache_get_value_name_float(i, "outexita", BasementData[bmid][bmOutexitA]);
			
			Iter_Add(Basement, bmid);
			Basement_Rebuild(bmid);
			Basement_Refresh(bmid);
	    }
	    printf("[Dynamic Basement] Jumlah total basement yang dimuat: %d.", rows);
	}
}

CMD:addbasement(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	new bmid = Iter_Free(Basement), query[512];
	if(bmid == -1)  return Error(playerid, "Jumlah dynamic basement telah mencapai batas maksimum!");
	
    new bmtype, name[128];
	if(sscanf(params, "ds[128]", bmtype, name)) return Usage(playerid, "/addbasement [type] [name]");
	
    switch(bmtype)
    {
        case 1: //basement 1
        {
            BasementData[bmid][bmIntposX] = -1746.1633;
            BasementData[bmid][bmIntposY] = 981.9204;
            BasementData[bmid][bmIntposZ] = 17.4730;
            BasementData[bmid][bmIntposA] = 270.5701;

            BasementData[bmid][bmInexitX] = -1746.0602;
            BasementData[bmid][bmInexitY] = 987.4948;
            BasementData[bmid][bmInexitZ] = 17.9581;
        }
        case 2: //basement 2
        {
            BasementData[bmid][bmIntposX] = 2486.1899;
            BasementData[bmid][bmIntposY] = 2374.8669;
            BasementData[bmid][bmIntposZ] = 6.9827;
            BasementData[bmid][bmIntposA] = 270.4950;

            BasementData[bmid][bmInexitX] = 2486.1829;
            BasementData[bmid][bmInexitY] = 2379.4070;
            BasementData[bmid][bmInexitZ] = 6.9822;
        }
    }
    strcpy(BasementData[bmid][bmName], name);
	GetPlayerPos(playerid, BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ]);
	GetPlayerFacingAngle(playerid, BasementData[bmid][bmExtposA]);
	BasementData[bmid][bmExtvw] = GetPlayerVirtualWorld(playerid);
	BasementData[bmid][bmExtint] = GetPlayerInterior(playerid);

	BasementData[bmid][bmPass][0] = EOS;
	BasementData[bmid][bmIcon] = 19130;
	BasementData[bmid][bmLocked] = 0;
	BasementData[bmid][bmAdmin] = 0;
	BasementData[bmid][bmVip] = 0;
	BasementData[bmid][bmFaction] = 0;
	BasementData[bmid][bmFamily] = 0;

    BasementData[bmid][bmOutexitX] = 0.0;
    BasementData[bmid][bmOutexitY] = 0.0;
    BasementData[bmid][bmOutexitZ] = 0.0;

	BasementData[bmid][bmIntvw] = bmid+1;
	BasementData[bmid][bmIntint] = 0;
    
    Basement_Rebuild(bmid);
    Basement_Refresh(bmid);
	Iter_Add(Basement, bmid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `basement` SET `ID`=%d, `extvw`=%d, `extint`=%d, `extposx`='%f', `extposy`='%f', `extposz`='%f', `extposa`='%f', `inexitx`='%f', `inexity`='%f', `inexitz`='%f', `name`='%e'", bmid, BasementData[bmid][bmExtvw], BasementData[bmid][bmExtint], BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ], BasementData[bmid][bmExtposA], BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ], name);
	mysql_pquery(g_SQL, query, "OnBasementCreated", "i", bmid);
	return 1;
}

YCMD:gotobasement(playerid, params[], help)
{
	new bmid;
	if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
		
	if(sscanf(params, "d", bmid))
		return Usage(playerid, "/gotobasement [id]");
	if(!Iter_Contains(Basement, bmid)) return Error(playerid, "ID Basement tersebut tidak valid!");
	SetPlayerPositionEx(playerid, BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ], BasementData[bmid][bmExtposA]);
    SetPlayerInterior(playerid, BasementData[bmid][bmExtint]);
    SetPlayerVirtualWorld(playerid, BasementData[bmid][bmExtvw]);

    pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInBiz] = -1;
	return 1;
}

CMD:editbasement(playerid, params[])
{
    static
        bmid,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", bmid, type, string))
    {
        Usage(playerid, "/editbasement [id] [name]");
        SendClientMessage(playerid, X11_GRAY, "OPTION: location, interior, inexit, outexit, password, name, locked, admin, vip, faction, family, virtual");
		SendClientMessage(playerid, X11_GRAY, "OPTION: pickup, delete");
        return 1;
    }
    if((bmid < 0 || bmid >= MAX_BASEMENT))
        return Error(playerid, "ID Basement tersebut tidak valid!");
	
    if(!Iter_Contains(Basement, bmid))  return Error(playerid, "ID Basement tersebut tidak valid!");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ]);
		GetPlayerFacingAngle(playerid, BasementData[bmid][bmExtposA]);

        BasementData[bmid][bmExtvw] = GetPlayerVirtualWorld(playerid);
		BasementData[bmid][bmExtint] = GetPlayerInterior(playerid);

        Streamer_SetItemPos(STREAMER_TYPE_CP, BasementData[bmid][bmEntranceCP], BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ]);
        Streamer_SetIntData(STREAMER_TYPE_CP, BasementData[bmid][bmEntranceCP], E_STREAMER_WORLD_ID, BasementData[bmid][bmExtvw]);
		Streamer_SetIntData(STREAMER_TYPE_CP, BasementData[bmid][bmEntranceCP], E_STREAMER_INTERIOR_ID, BasementData[bmid][bmIntint]);
        
        Basement_Save(bmid);
		Basement_Refresh(bmid);

        SendStaffMessage(X11_TOMATO, "AdmCmd: %s menetapkan lokasi eksterior untuk basement ID: %d.", pData[playerid][pAdminname], bmid);
    }
    else if(!strcmp(type, "interior", true))
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            GetVehiclePos(playerid, BasementData[bmid][bmIntposX], BasementData[bmid][bmIntposY], BasementData[bmid][bmIntposZ]);
		    GetVehicleZAngle(playerid, BasementData[bmid][bmIntposA]);
        }
        else
        {
            GetPlayerPos(playerid, BasementData[bmid][bmIntposX], BasementData[bmid][bmIntposY], BasementData[bmid][bmIntposZ]);
		    GetPlayerFacingAngle(playerid, BasementData[bmid][bmIntposA]);
        }

        BasementData[bmid][bmIntvw] = bmid+1;
		BasementData[bmid][bmIntint] = GetPlayerInterior(playerid);

        Basement_Save(bmid);
		Basement_Refresh(bmid);

        SendStaffMessage(X11_TOMATO, "AdmCmd: %s menetapkan lokasi interior untuk basement ID: %d.", pData[playerid][pAdminname], bmid);
    }
    else if(!strcmp(type, "inexit", true))
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            GetVehiclePos(pData[playerid][pLastCar], BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ]);
        }
        else
        {
            GetPlayerPos(playerid, BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ]);
        }

        BasementData[bmid][bmIntvw] = bmid+1;
		BasementData[bmid][bmIntint] = GetPlayerInterior(playerid);

        Streamer_SetItemPos(STREAMER_TYPE_CP, BasementData[bmid][bmExitCP], BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ]);
        
        Basement_Save(bmid);
		Basement_Refresh(bmid);

        SendStaffMessage(X11_TOMATO, "AdmCmd: %s menetapkan lokasi in-exit untuk basement ID: %d.", pData[playerid][pAdminname], bmid);
    }
    else if(!strcmp(type, "outexit", true))
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            GetVehiclePos(pData[playerid][pLastCar], BasementData[bmid][bmOutexitX], BasementData[bmid][bmOutexitY], BasementData[bmid][bmOutexitZ]);
            GetVehicleZAngle(pData[playerid][pLastCar], BasementData[bmid][bmOutexitA]);
        }
        else
        {
            GetPlayerPos(playerid, BasementData[bmid][bmOutexitX], BasementData[bmid][bmOutexitY], BasementData[bmid][bmOutexitZ]);
            GetPlayerFacingAngle(playerid, BasementData[bmid][bmOutexitA]);
        }

        Basement_Save(bmid);
		Basement_Refresh(bmid);

        SendStaffMessage(X11_TOMATO, "AdmCmd: %s menetapkan lokasi out-exit untuk basement ID: %d.", pData[playerid][pAdminname], bmid);
    }
	else if(!strcmp(type, "password", true))
    {
        new password[32];

        if(sscanf(string, "s[32]", password))
        {
			Usage(playerid, "/editbasement [id] [password] [entrance pass]");
			SendClientMessage(playerid, X11_GRAY, "Masukkan 'none' untuk menonaktifkan kata sandi pada pintu!");
			return 1;
		}

        if(!strcmp(password, "none", true)) 
        {
            BasementData[bmid][bmPass][0] = EOS;
        }
        else 
        {
            strcpy(BasementData[bmid][bmPass], password);
        }
        Basement_Save(bmid);
		Basement_Refresh(bmid);
        SendStaffMessage(X11_TOMATO, "AdmCmd: %s membuat kata sandi untuk basement ID: %d yaitu (%s)", pData[playerid][pAdminname], bmid, password);
    }
	else if(!strcmp(type, "name", true))
    {
        new name[128];

        if(sscanf(string, "s[128]", name))
            return Usage(playerid, "/editbasement [id] [name] [new name]");

        strcpy(BasementData[bmid][bmName], name);

        Basement_Save(bmid);
		Basement_Refresh(bmid);

        SendStaffMessage(X11_TOMATO, "AdmCmd: %s menetapkan nama untuk basement ID: %d yaitu \"%s\".", pData[playerid][pAdminname], bmid, name);
    }
	else if(!strcmp(type, "locked", true))
    {
        new locked;

        if(sscanf(string, "d", locked))
            return Usage(playerid, "/editbasement [id] [locked] [locked 0/1]");

        if(locked < 0 || locked > 1){
            Error(playerid, "Masukkan 0 atau 1!");
            return SendClientMessage(playerid, X11_GRAY, "0 untuk membuka, 1 untuk mengunci!");}

        BasementData[bmid][bmLocked] = locked;
        Basement_Save(bmid);
		Basement_Refresh(bmid);

        if(locked) {
            SendStaffMessage(X11_TOMATO, "AdmCmd: %s mengunci exterior basement ID: %d.", pData[playerid][pAdminname], bmid);
        } else {
            SendStaffMessage(X11_TOMATO, "AdmCmd: %s membuka exterior basement ID: %d.", pData[playerid][pAdminname], bmid);
        }
    }
	else if(!strcmp(type, "admin", true))
    {
        new level;

        if(sscanf(string, "d", level))
            return Usage(playerid, "/editbasement [id] [admin] [level]");

        if(level < 0 || level > 6)
            return Error(playerid, "Masukkan 0 - 6 untuk level admin minimal!");

        BasementData[bmid][bmAdmin] = level;
        Basement_Save(bmid);
		Basement_Refresh(bmid);

        SendStaffMessage(X11_TOMATO, "AdmCmd: %s menetapkan basement ID: %d hanya untuk admin level %d.", pData[playerid][pAdminname], bmid, level);
    }
	else if(!strcmp(type, "vip", true))
    {
        new level;

        if(sscanf(string, "d", level))
            return Usage(playerid, "/editbasement [id] [VIP] [level]");

        if(level < 0 || level > 3)
            return Error(playerid, "Masukkan 0 - 3 untuk level VIP minimal!");

        BasementData[bmid][bmVip] = level;
        Basement_Save(bmid);
		Basement_Refresh(bmid);

        SendStaffMessage(X11_TOMATO, "AdmCmd: %s menetapkan basement ID: %d hanya untuk VIP level %d.", pData[playerid][pAdminname], bmid, level);
    }
	else if(!strcmp(type, "faction", true))
    {
        new fid;

        if(sscanf(string, "d", fid))
            return Usage(playerid, "/editbasement [id] [faction] [faction id]");

        if(fid < 0 || fid > 11)
            return Error(playerid, "Masukkan 0 - 11 untuk ID faction!");

        BasementData[bmid][bmFaction] = fid;
        Basement_Save(bmid);
		Basement_Refresh(bmid);

        SendStaffMessage(X11_TOMATO, "AdmCmd: %s menetapkan basement ID: %d hanya untuk faction ID: %d.", pData[playerid][pAdminname], bmid, fid);
    }
	else if(!strcmp(type, "family", true))
    {
        new fid;

        if(sscanf(string, "d", fid))
            return Usage(playerid, "/editbasement [id] [family] [family id]");

        if(fid < 0 || fid > 9)
            return Error(playerid, "Masukkan 0 - 9 untuk ID family!");

        BasementData[bmid][bmFamily] = fid;
        Basement_Save(bmid);
		Basement_Refresh(bmid);

        SendStaffMessage(X11_TOMATO, "AdmCmd: %s menetapkan basement ID: %d hanya untuk family ID %d.", pData[playerid][pAdminname], bmid, fid);
    }
    else if(!strcmp(type, "virtual", true))
    {
        new worlbmid;

        if(sscanf(string, "d", worlbmid))
            return Usage(playerid, "/editbasement [id] [virtual] [interior world]");

        BasementData[bmid][bmExtvw] = worlbmid;

        Basement_Save(bmid);
		Basement_Refresh(bmid);
        SendStaffMessage(X11_TOMATO, "AdmCmd: %s menetapkan virtual world untuk interior basement ID: %d menjadi %d.", pData[playerid][pAdminname], bmid, worlbmid);
    }
	else if(!strcmp(type, "pickup", true))
    {
        new pckbmt;

        if(sscanf(string, "d", pckbmt))
            return Usage(playerid, "/editbasement [id] [pickup] [pickupid]");

        BasementData[bmid][bmIcon] = pckbmt;

        Basement_Save(bmid);
		Basement_Refresh(bmid);

        SendStaffMessage(X11_TOMATO, "AdmCmd: %s mengubah bentuk pickup dari basement ID: %d menjadi \"%d\".", pData[playerid][pAdminname], bmid, pckbmt);
    }
	else if(!strcmp(type, "delete", true))
    {
		if(DestroyDynamic3DTextLabel(BasementData[bmid][bmLabelext]))
            BasementData[bmid][bmLabelext] = STREAMER_TAG_3D_TEXT_LABEL: INVALID_STREAMER_ID;
		if(DestroyDynamicPickup(BasementData[bmid][bmPickupext]))
            BasementData[bmid][bmPickupext] = STREAMER_TAG_PICKUP: INVALID_STREAMER_ID;
		if(DestroyDynamic3DTextLabel(BasementData[bmid][bmLabelexit]))
            BasementData[bmid][bmLabelexit] = STREAMER_TAG_3D_TEXT_LABEL: INVALID_STREAMER_ID;
		if(DestroyDynamicPickup(BasementData[bmid][bmPickupexit]))
            BasementData[bmid][bmPickupexit] = STREAMER_TAG_PICKUP: INVALID_STREAMER_ID;
        if(DestroyDynamicCP(BasementData[bmid][bmEntranceCP]))
            BasementData[bmid][bmEntranceCP] = STREAMER_TAG_CP: INVALID_STREAMER_ID;
        if(DestroyDynamicCP(BasementData[bmid][bmExitCP]))
            BasementData[bmid][bmExitCP] = STREAMER_TAG_CP: INVALID_STREAMER_ID;
			
		BasementData[bmid][bmExtposX] = 0;
		BasementData[bmid][bmExtposY] = 0;
		BasementData[bmid][bmExtposZ] = 0;
		BasementData[bmid][bmExtposA] = 0;
		BasementData[bmid][bmExtvw] = 0;
		BasementData[bmid][bmExtint] = 0;
        BasementData[bmid][bmName][0] = EOS;
        BasementData[bmid][bmPass][0] = EOS;
		BasementData[bmid][bmIcon] = 0;
		BasementData[bmid][bmLocked] = 0;
		BasementData[bmid][bmAdmin] = 0;
		BasementData[bmid][bmVip] = 0;
		BasementData[bmid][bmFaction] = 0;
		BasementData[bmid][bmFamily] = -1;

		BasementData[bmid][bmIntvw] = 0;
		BasementData[bmid][bmIntint] = 0;

		BasementData[bmid][bmIntposX] = 0;
		BasementData[bmid][bmIntposY] = 0;
		BasementData[bmid][bmIntposZ] = 0;
		BasementData[bmid][bmIntposA] = 0;

        BasementData[bmid][bmInexitX] = 0;
		BasementData[bmid][bmInexitY] = 0;
		BasementData[bmid][bmInexitZ] = 0;

        BasementData[bmid][bmOutexitX] = 0;
		BasementData[bmid][bmOutexitY] = 0;
		BasementData[bmid][bmOutexitZ] = 0;
		BasementData[bmid][bmOutexitA] = 0;
		
		Iter_Remove(Basement, bmid);
		new query[144];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM `basement` WHERE `ID`=%d", bmid);
		mysql_pquery(g_SQL, query);
        SendStaffMessage(X11_TOMATO, "AdmCmd: %s telah menghapus basement ID: %d.", pData[playerid][pAdminname], bmid);
	}
    return 1;
}