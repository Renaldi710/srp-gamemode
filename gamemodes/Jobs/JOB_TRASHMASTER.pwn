new TimerTrashmaster[MAX_PLAYERS] = -1, TrashmasterDynCP[MAX_PLAYERS][11], TrashmasterIcon[MAX_PLAYERS][11];
new Float: TrashmasterPlayerX[MAX_PLAYERS][25];
new Float: TrashmasterPlayerY[MAX_PLAYERS][25];
new Float: TrashmasterPlayerZ[MAX_PLAYERS][25];
new bool:TrashStatus[MAX_PLAYERS][11], TrashmasterCrate[MAX_PLAYERS] = 0;
new VehicleTrashmaster[4];

new Float: TrashmasterCP[][3] = {
    {1809.0026, -1804.9397, 13.54650},
    {1789.8159, -1883.3229, 13.56840},
    {1871.1851, -1627.0081, 13.36930},
    {2001.1465, -1550.3231, 13.64730},
    {1985.2653, -1781.0939, 13.55120},
    {2173.0061, -1787.7135, 13.5215},    
    {2277.2932, -1672.1891, 15.1442},    
    {2307.1309, -1630.4855, 14.45960},
    {2417.6409, -1696.1266, 13.80610},
    {2440.1418, -1900.7098, 13.54690},
    {2365.7229, -1939.5677, 13.5469},    
    {2341.8357, -1891.6252, 13.6241},
    {2441.5244, -1973.6356, 13.5469},    
    {2538.5154, -2010.2054, 13.54690},
    {2659.9102, -2056.8606, 13.55000},
    {2592.5217, -2205.9204, 13.5469},    
    {2613.1609, -2425.0059, 13.6338},    
    {2411.1960, -2620.4434, 13.66410},
    {2205.8130, -2632.1299, 13.54690},
    {2241.8938, -2158.8701, 13.55380},
    {2340.8311, -2070.9648, 13.54690},
    {2284.5413, -2028.2296, 13.54690},
    {1920.1262, -2123.1318, 13.58490},
    {1919.7515, -2088.2029, 13.58040},
    {1660.5251, -2113.0540, 13.5469}
    
};

Near_TrashmasterCP(playerid)
{
    new closest_id = -1, Float: dist = 9.0, Float: tempdist;
    for(new i; i < 10; i++)
    {
        tempdist = GetPlayerDistanceFromPoint(playerid, TrashmasterPlayerX[playerid][i], TrashmasterPlayerY[playerid][i], TrashmasterPlayerZ[playerid][i]);
        if(tempdist > 5.0) continue;
        if(tempdist <= dist)
        {
            dist = tempdist;
            closest_id = i;
        }
    }

    return closest_id;
}

IsVehicleTrashmaster(vehicleid)
{
    for (new i = 0; i != 4; i ++) if(VehicleTrashmaster[i] == vehicleid) {
        return 1;
    }
    return 0;
}

Dialog:StartTrashmaster(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        Custom(playerid, "SIDEJOB", ""RED_E"Icon merah "WHITE_E"di map adalah lokasi tong sampah");
        Custom(playerid, "SIDEJOB", "Keluar dari kendaraan untuk mengangkut sampah dari tong sampah ke truk pengangkut sampah");
        Custom(playerid, "SIDEJOB", "Jika truk sampah sudah penuh, maka kamu akan di arahkan ke pembuangan sampah");
        Custom(playerid, "SIDEJOB", "Meninggalkan truk sampah lebih dari 60 detik artinya berhenti bekerja");
        new rand[10];
        for(new id = 0; id < 10; id++){
            rand[id] = random(25); // 0 to 24
            // Tidak perlu ++rand[id] lalu reset ke 0 jika lebih dari 25, cukup random(25)

            TrashmasterPlayerX[playerid][id] = TrashmasterCP[rand[id]][0];
            TrashmasterPlayerY[playerid][id] = TrashmasterCP[rand[id]][1];
            TrashmasterPlayerZ[playerid][id] = TrashmasterCP[rand[id]][2];

            TrashmasterDynCP[playerid][id] = CreateDynamicCP(
                TrashmasterPlayerX[playerid][id],
                TrashmasterPlayerY[playerid][id],
                TrashmasterPlayerZ[playerid][id],
                10.0, -1, -1, playerid, 3.0
            );

            TrashmasterIcon[playerid][id] = CreateDynamicMapIcon(
                TrashmasterPlayerX[playerid][id],
                TrashmasterPlayerY[playerid][id],
                TrashmasterPlayerZ[playerid][id],
                0, COLOR_RED, 0, 0, playerid
            );
        }

        pData[playerid][pTrashmasterJob] = 1;
    }
    else RemovePlayerFromVehicle(playerid);
    return 1;
}

#include <YSI\y_hooks>
hook OnGameModeInit()
{
    VehicleTrashmaster[0] = CreateVehicle(408,2118.483,-2078.253,13.546,141.301,1,1,-1);
    VehicleTrashmaster[1] = CreateVehicle(408,2126.990,-2084.031,13.546,136.226,1,1,-1);
    VehicleTrashmaster[2] = CreateVehicle(408,2134.713,-2090.880,13.546,134.353,1,1,-1);
}

hook OnPlayerStateChange(playerid, newstate, oldstate) {
    new engine, lights, alarm, doors, bonnet, boot, objective;
    if(newstate == PLAYER_STATE_DRIVER && newstate != PLAYER_STATE_PASSENGER) {
        if(IsVehicleTrashmaster(GetPlayerVehicleID(playerid)) && !pData[playerid][pTrashmasterJob])
        {
            if(!pData[playerid][pTrashMasterTime])
            {
                SetCameraBehindPlayer(playerid);
                Dialog_Show(playerid, StartTrashmaster, DIALOG_STYLE_MSGBOX, "Sidejob: Trash Collector", ""WHITE_E"Apakah anda siap bekerja menjadi trash collector?", "Yes", "Cancel"
                );
            }
            else
            {
                RemovePlayerFromVehicle(playerid);
                Servers(playerid, "Anda masih menunggu waktu %d menit untuk melakukan pekerjaan ini lagi.", pData[playerid][pTrashMasterTime]/60);
            }
        }
        if(IsVehicleTrashmaster(GetPlayerVehicleID(playerid)) && pData[playerid][pTrashmasterJob]) {
			GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, 0); // ONLY the engine param was changed to VEHICLE_PARAMS_ON (1)
			return 1;
		}
    }
    if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER) {
        if(pData[playerid][pTrashmasterJob]) {
			TimerTrashmaster[playerid] = 61;
			SetVehicleParamsForPlayer(pData[playerid][pLastCar],playerid,1,0);
			return 1;
		}
    }
    return 1;
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid) {
	for(new id = 0; id < 10; id++){
		if(checkpointid == TrashmasterDynCP[playerid][id] && TrashStatus[playerid][id] == false) {
			ApplyAnimation(playerid,"CARRY","LIFTUP",4.0,0 ,0,0,0,0,1);
			SetPlayerAttachedObject(playerid, 9, 1265, 6, 0.1029, 0.0000, 0.0000, 0.0000, -110.2000, 0.8289, 0.7819, 0.9830);
			if(IsValidDynamicPickup(TrashmasterDynCP[playerid][id])) DestroyDynamicPickup(TrashmasterDynCP[playerid][id]);
			TrashStatus[playerid][id] = true;
			if(IsValidDynamicMapIcon(TrashmasterIcon[playerid][id])) DestroyDynamicMapIcon(TrashmasterIcon[playerid][id]);
			new Float:x1, Float:y1, Float:z1;
			GetVehiclePartPos(pData[playerid][pLastCar], VEHICLE_PART_TRUNK, x1, y1, z1);
			SetPlayerRaceCheckpoint(playerid, 1, x1, y1, z1, x1, y1, z1, 2);
			TrashmasterCrate[playerid] = 1;
		}
	}
	return 1;
}

hook OnPlayerEnterRaceCP(playerid) {
    if(pData[playerid][pTrashmasterJob] && VehCore[pData[playerid][pLastCar]][vTrash] == 10 && TrashmasterCrate[playerid] == 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
		new cash = VehCore[pData[playerid][pLastCar]][vTrash]*100;
		AddPlayerSalary(playerid, sprintf("Cleared %d trash dumps (Trashmaster)", VehCore[pData[playerid][pLastCar]][vTrash]), cash);
		Custom(playerid, "TRASH", "Trashmaster sidejob completed, "GREEN"$%s "WHITE_E"has been issued for your next paycheck", FormatMoney(cash));
		SendClientMessageEx(playerid, ARWIN, "SALARY: {ffffff}Your salary statement has been updated, please check command {ffff00}'/mysalary'");

		VehCore[pData[playerid][pLastCar]][vTrash] = 0;
		pData[playerid][pTrashmasterJob] = 0;
		pData[playerid][pTrashMasterTime] = 1800;
		PlayerPlaySound(playerid, 183, 0.0, 0.0, 0.0);
		TimerTrashmaster[playerid] = -1;
		SetVehicleToRespawn(pData[playerid][pLastCar]);
		RemovePlayerFromVehicle(playerid);
	}
	if(pData[playerid][pTrashmasterJob] && TrashmasterCrate[playerid] == 1 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		ApplyAnimation(playerid,"BASEBALL","BAT_M",4.0,0 ,0,0,0,0,1);
		TrashmasterCrate[playerid] = 0;
		RemovePlayerAttachedObject(playerid, 9);
		VehCore[pData[playerid][pLastCar]][vTrash]++;
        DisablePlayerRaceCheckpoint(playerid);
        Custom(playerid, "TRASH", "You have loaded trash into your trashmaster from the gerbage dump, trash loaded "YELLOW_E"%d/10", VehCore[pData[playerid][pLastCar]][vTrash]);
		if(VehCore[pData[playerid][pLastCar]][vTrash] == 10)
		{
			Custom(playerid, "TRASH", "You have loaded trash into your trashmaster from the gerbage dump, "GREEN"your trashmaster is now full");
			Custom(playerid, "TRASH", "Your trashmaster is "GREEN"already full"WHITE_E", return to the trash dump to finish sidejob!");
			SetPlayerRaceCheckpoint(playerid, 1, 2101.2063,-2032.8599,14.0905, 0.0, 0.0, 0.0, 5.0);
			for(new i; i < 10; i++) DestroyDynamicMapIcon(TrashmasterIcon[playerid][i]);
			return 1;
		}
	}
    return 1;
}

ptask TrashmasterTimer[1000](playerid) 
{
    if(!IsPlayerInAnyVehicle(playerid) && TimerTrashmaster[playerid] != -1)
    {
        TimerTrashmaster[playerid]--;
        new str[256];
        format(str, sizeof(str), "~w~Return To Vehicle ~n~in ~y~%d seconds", TimerTrashmaster[playerid]);
        GameTextForPlayer(playerid, str, 1000, 6);
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        if(TimerTrashmaster[playerid] <= 0)
        {
            new rada = 50, vehicleid = GetPVarInt(playerid, "LastVehicleID");
            new cash = VehCore[vehicleid][vTrash]*15000;
            for(new i; i < 10; i++) {
                RemovePlayerMapIcon(playerid, rada+i);
            }
            SetVehicleToRespawn(vehicleid);
            AddPlayerSalary(playerid, sprintf("Cleared %d trash dumps (Trashmaster)", VehCore[vehicleid][vTrash]), cash);
            SendClientMessageEx(playerid, ARWIN, "SIDEJOB: {ffffff}Trashmaster sidejob failed, {3BBD44}$%s {ffffff}has been issued for your next paycheck", FormatMoney(cash));
            SendClientMessageEx(playerid, ARWIN, "SALARY: {ffffff}Your salary statement has been updated, please check command {ffff00}'/mysalary'");
            VehCore[vehicleid][vTrash] = 0;
            pData[playerid][pTrashmasterJob] = 0;
            pData[playerid][pTrashMasterTime] = 1800;
            TimerTrashmaster[playerid] = -1;
        }
    }
    return 1;
}
