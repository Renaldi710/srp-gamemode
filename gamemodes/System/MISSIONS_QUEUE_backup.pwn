#define MAX_QUEUE 100
#define MAX_TRUCKER_MISSIONS 10

new g_MissionQueue[MAX_QUEUE];
new bool:DialogMissions[MAX_TRUCKER_MISSIONS];
new TrailerMission[MAX_PLAYERS];
new PlayerMissions[MAX_PLAYERS];
new bool:PlayerTakeMissions[MAX_PLAYERS];
new g_QueueSize = 0;
new bool:InMissionQueue[MAX_PLAYERS];

enum truckerMissions {
  issuerName[32],
  salaryCost,
  Float:takeTrailerX,
  Float:takeTrailerY,
  Float:takeTrailerZ,
  Float:trailerAngle,
  Float:sendTrailerX,
  Float:sendTrailerY,
  Float:sendTrailerZ
};

new const TruckerMissions[MAX_TRUCKER_MISSIONS][truckerMissions] = {
  {"Ocean Docks Import", 600, 2791.4016, -2494.5452, 14.2522, 89.5366, -2471.2942, 783.0248, 35.1719},
  {"Ocean Docks Import", 500, 2784.3132, -2456.6299, 14.2415, 89.4938, -576.2687, 2569.0842, 53.5156},
  {"Angel Pine Export", 300, -1963.0142, -2436.3079, 31.2311, 226.1548, 1424.8624, 2333.4939, 10.8203},
  {"Angel Pine Export", 350, -1966.5603, -2439.9380, 31.2306, 225.5799, 1198.7153, 165.4331, 20.5056},
  {"Chilliad Deport", 550, -1863.1541, -1720.5603, 22.3558, 122.1463, 1201.5385, 171.6184, 20.5035},
  {"Chilliad Deport", 200, -1855.7255, -1726.0389, 22.3566, 124.4187, 2786.8313, -2417.9558, 13.6339},
  {"Easter Import", 550, -1053.6145, -658.6473, 32.6319, 260.6392, 1613.7815, 2236.2046, 10.3787},
  {"Blueberry Export", 580, -459.3511, -48.3457, 60.5507, 182.7280, 2415.7803, -2470.1309, 13.6300},
  {"Las Venturas Deport", 450, 847.0450, 921.0422, 13.9579, 201.2555, -980.1684, -713.3505, 32.0078},
  {"Las Venturas Fuel & Gas", 250, 249.6713, 1395.7150, 11.1923, 269.0699, -2226.1292, -2315.1055, 30.6045}
};

stock AddToMissionQueue(playerid)
{
    if (InMissionQueue[playerid] || g_QueueSize >= MAX_QUEUE)
        return 0;

    g_MissionQueue[g_QueueSize++] = playerid;
    InMissionQueue[playerid] = true;
    return 1;
}

stock IsInMissionQueue(playerid)
{
    for (new i = 0; i < g_QueueSize; i++)
    {
        if (g_MissionQueue[i] == playerid)
            return 1;
    }
    return 0;
}
stock GetQueuePosition(playerid)
{
    for (new i = 0; i < g_QueueSize; i++)
        if (g_MissionQueue[i] == playerid)
            return i + 1;

    return -1;
}

stock RemoveFromMissionQueue(playerid)
{
    for (new i = 0; i < g_QueueSize; i++)
    {
        if (g_MissionQueue[i] == playerid)
        {
            for (new j = i; j < g_QueueSize - 1; j++)
                g_MissionQueue[j] = g_MissionQueue[j + 1];

            g_QueueSize--;
            InMissionQueue[playerid] = false;
            return 1;
        }
    }
    return 0;
}

#include <YSI\y_hooks>

hook OnPlayerEnterRaceCP(playerid) 
{
    if (pData[playerid][pMissions] && !pData[playerid][pTrailer]) 
    {
        new index = PlayerMissions[playerid];

        DisablePlayerRaceCheckpoint(playerid);
        Custom(playerid, "TRUCKING]","Attach the trailer to your vehicle to order");

        pData[playerid][pTrailer] = 1;

        SetPlayerRaceCheckpoint(playerid, 1,
            TruckerMissions[index][sendTrailerX],
            TruckerMissions[index][sendTrailerY],
            TruckerMissions[index][sendTrailerZ],
            0.0, 0.0, 0.0, 10.0
        );
        return 1;
    }


    //misi selesai
    if (pData[playerid][pTrailer] && pData[playerid][pMissions]) 
    {
        if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) 
        {
            new index = PlayerMissions[playerid];

            DisablePlayerRaceCheckpoint(playerid);
            if (IsValidVehicle(TrailerMission[playerid]))
                DestroyVehicle(TrailerMission[playerid]);

            TrailerMission[playerid] = INVALID_VEHICLE_ID;
            pData[playerid][pTrailer] = 0;
            pData[playerid][pMissions] = 0;
            pData[playerid][pTruckerHaulingTime] = 600;

            DialogMissions[index] = false;

            AddPlayerSalary(playerid, "Trucker Missions", 
            TruckerMissions[index][salaryCost]);

            Custom(playerid, "TRUCKING", "Misi selesai: "YELLOW"%s. "WHITE"Dapat: "GREEN"%s", TruckerMissions[index][issuerName], FormatMoney(TruckerMissions[index][salaryCost]));

            PlayerMissions[playerid] = -1;
            PlayerTakeMissions[playerid] = false;

            for (new i = 0; i < g_QueueSize; i++)
            {
                new pid = g_MissionQueue[i];

                if (IsPlayerConnected(pid))
                {
                    GivePlayerMission(pid);
                    RemoveFromMissionQueue(pid);
                    break;
                }
                else
                {
                    RemoveFromMissionQueue(pid);
                    i--;
                }
            }
        }
    }
    return 1;
}

GivePlayerMission(playerid)
{
    PlayerTakeMissions[playerid] = true;
    InMissionQueue[playerid] = false; // jaga-jaga
    RemoveFromMissionQueue(playerid);

    Custom(playerid, "TRUCKING", "Anda mendapatkan giliran pertama. Gunakan "YELLOW"/takemissions");
}

hook OnPlayerConnect(playerid)
{
    pData[playerid][pTrailer] = 0;
    pData[playerid][pMissions] = 0;
    PlayerMissions[playerid] = -1;
    PlayerTakeMissions[playerid] = false;
    InMissionQueue[playerid] = false;
    TrailerMission[playerid] = INVALID_VEHICLE_ID;
    return 1;
}


hook OnPlayerDisconnect(playerid)
{
    if (pData[playerid][pMissions])
    {
        if (IsValidVehicle(TrailerMission[playerid]))
            DestroyVehicle(TrailerMission[playerid]);

        DialogMissions[PlayerMissions[playerid]] = false;
    }

    // Reset
    pData[playerid][pTrailer] = 0;
    pData[playerid][pMissions] = 0;
    PlayerMissions[playerid] = -1;
    PlayerTakeMissions[playerid] = false;
    InMissionQueue[playerid] = false;
    RemoveFromMissionQueue(playerid);

    return 1;
}

CMD:takemissions(playerid, params[])
{
    if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
    {
        if(PlayerTakeMissions[playerid] == false)
            return Error(playerid, "Anda tidak dapat take missions");

        new str[640];

        format(str, sizeof(str), "Order\tPrice\n");
        for (new i = 0; i < MAX_TRUCKER_MISSIONS; i ++) {
            format(str, sizeof(str), "%s%s\t"GREEN"%s\n", str, TruckerMissions[i][issuerName], (DialogMissions[i] == true) ? (RED"TAKEN") : (FormatMoney(TruckerMissions[i][salaryCost])));
        }
        Dialog_Show(playerid, TruckMissions, DIALOG_STYLE_TABLIST_HEADERS, "Missions", str, "Take", "Close");
    }
    else return Error(playerid, "You are not trucker job.");
    return 1;
}

SetPlayerMissionsCP(playerid) 
{
    if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4  && pData[playerid][pMissions]) {
        new index = PlayerMissions[playerid];

        SetPlayerRaceCheckpoint(playerid, 1, TruckerMissions[index][takeTrailerX], TruckerMissions[index][takeTrailerY], TruckerMissions[index][takeTrailerZ], 0.0, 0.0, 0.0, 10.0);
        TrailerMission[playerid] = CreateVehicle(435, TruckerMissions[index][takeTrailerX], TruckerMissions[index][takeTrailerY], TruckerMissions[index][takeTrailerZ], TruckerMissions[index][trailerAngle], 1, 1, -1);
    }
    return 1;
}

CMD:attachtrailer(playerid, params[]) 
{
    if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
    {
        if (!pData[playerid][pMissions]) return Error(playerid, "Kamu tidak sedang melakukan truck missions!");
        new vehicleid = TrailerMission[playerid], Float:vPos[3];
        GetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
        if (!IsPlayerInRangeOfPoint(playerid, 10.0, vPos[0], vPos[1], vPos[2])) return Error(playerid, "Trailer truck kamu tidak berada didekatmu!");
        if (!IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu harus di kendaraan untuk menggunakan perintah ini!");

        AttachTrailerToVehicle(vehicleid, GetPlayerVehicleID(playerid));
        Custom(playerid, "TRAILER", "You has successfully attach your trailer!");
    }
    return 1;
}

CMD:findtrailer(playerid) 
{
    if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
    {
        if (!pData[playerid][pMissions]) return Error(playerid, "Kamu tidak sedang melakukan truck missions!");

        new vehicleid = TrailerMission[playerid], Float:vPos[3];

        if (IsValidVehicle(vehicleid)) {
            if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
            return Error(playerid, "Your Trailer has already attached to your truck");

            GetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
            SetPlayerRaceCheckpoint(playerid, 0, vPos[0], vPos[1], vPos[2], 0.0, 0.0, 0.0, 5.0);
            Custom(playerid, "FINDTRAILER", "Your trailer is on marked location");
        }
    }
    return 1;
}

public OnTrailerHooked(playerid,vehicleid,trailerid)
{
    if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4 && pData[playerid][pMissions])
    {
        if (TrailerMission[playerid] == trailerid) {
            new index = PlayerMissions[playerid];

            DisablePlayerRaceCheckpoint(playerid);
            Custom(playerid, "MISSIONS]","Please send the trailer to order");
            SetPlayerRaceCheckpoint(playerid, 1, TruckerMissions[index][sendTrailerX], TruckerMissions[index][sendTrailerY], TruckerMissions[index][sendTrailerZ], 0.0, 0.0, 0.0, 10.0);
        }
    }
    return 1;
}

Dialog:TruckMissions(playerid, response, listitem, inputtext[]) {
  if (response && listitem != -1) {
    if (DialogMissions[listitem] == true)
      return Error(playerid, "This Trucking Missions has already taken by someone!");

    DialogMissions[listitem] = true;
    PlayerMissions[playerid] = listitem;
    pData[playerid][pMissions] = 1;

    SetPlayerMissionsCP(playerid);
    Custom(playerid, "MISSIONS", "Go to marked checkpoint on your map");
  }
  return 1;
}
