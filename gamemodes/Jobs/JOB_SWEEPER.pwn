//header

#define MAX_SWEEPER_VEHICLES 3
new SweepVeh[MAX_SWEEPER_VEHICLES];
new DmvVeh;

new SweeperSteps[MAX_PLAYERS][4];
new bool:DialogSweeper[4];

enum sweeperrute {
	sweeper_rute,
    sweeper_finish,
	Float:sweeper_posx,
    Float:sweeper_posy,
    Float:sweeper_posz
};

stock const SweeperRute[][sweeperrute] = {
    {0, 0, 1622.9823, -1874.5065, 13.3828}, // sweep1
    {0, 0, 1684.0851, -1862.1783, 13.3906}, // sweep1
    {0, 0, 1691.5923, -1814.8231, 13.3906}, // sweep1
    {0, 0, 1757.4238, -1825.7561, 13.3828}, // sweep1
    {0, 0, 1819.1027, -1833.7788, 13.4141}, // sweep1
    {0, 0, 1820.5232, -1933.5840, 13.3765}, // sweep1
    {0, 0, 1964.2240, -1934.6567, 13.3828}, // sweep1
    {0, 0, 1963.4967, -1815.0699, 13.3828}, // sweep1
    {0, 0, 2084.0859, -1814.0085, 13.3828}, // sweep1
    {0, 0, 2095.8376, -1751.1949, 13.4049}, // sweep1
    {0, 0, 2004.1858, -1750.1440, 13.3828}, // sweep1
    {0, 0, 2004.3691, -1674.7657, 13.3828}, // sweep1
    {0, 0, 2084.4236, -1673.9967, 13.3906}, // sweep1
    {0, 0, 2082.0891, -1610.0432, 13.3741}, // sweep1
    {0, 0, 1999.3877, -1620.8037, 13.3828}, // sweep1
    {0, 0, 1998.6718, -1674.6627, 13.3828}, // sweep1
    {0, 0, 2079.4985, -1674.4875, 13.3906}, // sweep1
    {0, 0, 2078.9856, -1749.7859, 13.3850}, // sweep1
    {0, 0, 1930.6132, -1749.8800, 13.3828}, // sweep1
    {0, 0, 1824.0762, -1749.8427, 13.3828}, // sweep1
    {0, 0, 1810.4059, -1730.3085, 13.3906}, // sweep1
    {0, 0, 1687.5903, -1732.0858, 13.3885}, // sweep1
    {0, 0, 1676.3724, -1863.6143, 13.3906}, // sweep1
    {0, 0, 1617.1429, -1869.6276, 13.3828}, // sweep1
    {0, 1, 1619.7025, -1886.6642, 13.5469}, // sweep1finish
    {1, 0, 1613.8969, -1869.8781, 13.3906}, // sweep2
    {1, 0, 1572.3860, -1870.2836, 13.3828}, // sweep2
    {1, 0, 1571.0090, -1730.1151, 13.3828}, // sweep2
    {1, 0, 1531.7090, -1673.0830, 13.3828}, // sweep2
    {1, 0, 1530.9745, -1589.7405, 13.3828}, // sweep2
    {1, 0, 1431.7688, -1589.8594, 13.3906}, // sweep2
    {1, 0, 1445.3412, -1514.0228, 13.3828}, // sweep2
    {1, 0, 1456.9916, -1443.5680, 13.3906}, // sweep2
    {1, 0, 1655.5461, -1443.2982, 13.3828}, // sweep2
    {1, 0, 1655.8278, -1590.1992, 13.3875}, // sweep2
    {1, 0, 1427.5593, -1589.6802, 13.3906}, // sweep2
    {1, 0, 1427.8912, -1734.6753, 13.3828}, // sweep2
    {1, 0, 1566.9884, -1735.2317, 13.3906}, // sweep2
    {1, 0, 1568.7493, -1874.8082, 13.3828}, // sweep2
    {1, 0, 1616.8572, -1875.2130, 13.3828}, // sweep2
    {1, 1, 1620.0684, -1885.7354, 13.5469}, // sweep2finish
    {2, 0, 1616.4851, -1869.7388, 13.3828}, // sweep3
    {2, 0, 1400.8666, -1870.2457, 13.3828}, // sweep3
    {2, 0, 1361.1682, -1865.2168, 13.3828}, // sweep3
    {2, 0, 1284.9537, -1849.8140, 13.3906}, // sweep3
    {2, 0, 1070.5078, -1849.9125, 13.3914}, // sweep3
    {2, 0, 1034.0977, -1800.8552, 13.6590}, // sweep3
    {2, 0, 1040.3412, -1714.7712, 13.3828}, // sweep3
    {2, 0, 1153.0132, -1714.7698, 13.7813}, // sweep3
    {2, 0, 1151.7991, -1574.2233, 13.2734}, // sweep3
    {2, 0, 1295.0590, -1574.8931, 13.3828}, // sweep3
    {2, 0, 1295.3536, -1724.0153, 13.3828}, // sweep3
    {2, 0, 1296.9441, -1854.4377, 13.3828}, // sweep3
    {2, 0, 1381.7336, -1874.6818, 13.3828}, // sweep3
    {2, 0, 1617.2274, -1874.5538, 13.3828}, // sweep3
    {2, 1, 1619.9412, -1886.1356, 13.5469}  // sweep3finish
};

//dialog


Dialog:DialogSweeper(playerid, response, listitem, inputtext[]) {
    if(response)
	{
		switch(listitem)
		{
			case 0:
            {
                if(DialogSweeper[0] == false) // Kalau False atau tidak dipilih
                {
                    DialogSweeper[0] = true; // Dialog 0 telah di pilih
                    DialogSaya[playerid][0] = true;
                    SweeperSteps[playerid][0] = 1;
                    pData[playerid][pSideJob] = SIDEJOB_SWEEPER;
                    Custom(playerid, "SIDEJOB", "Ikutilah checkpoint yang tersedia pada Radar");
                    if(SweeperRute[SweeperSteps[playerid][0]][sweeper_rute] == 0) SetPlayerRaceCheckpoint(playerid, 0, SweeperRute[SweeperSteps[playerid][0]][sweeper_posx], SweeperRute[SweeperSteps[playerid][0]][sweeper_posy], SweeperRute[SweeperSteps[playerid][0]][sweeper_posz], SweeperRute[SweeperSteps[playerid][0]+1][sweeper_posx], SweeperRute[SweeperSteps[playerid][0]+1][sweeper_posy], SweeperRute[SweeperSteps[playerid][0]+1][sweeper_posz], 5);
                }
                else Error(playerid, "Route already taken by Someone");
            }
            case 1:
            {
                if(DialogSweeper[1] == false) // Kalau False atau tidak dipilih
                {
                    DialogSweeper[1] = true; // Dialog 1 telah di pilih
                    DialogSaya[playerid][1] = true;
                    SweeperSteps[playerid][1] = 25;
                    pData[playerid][pSideJob] = SIDEJOB_SWEEPER;
                    if(SweeperRute[SweeperSteps[playerid][1]][sweeper_rute] == 1) SetPlayerRaceCheckpoint(playerid, 0, SweeperRute[SweeperSteps[playerid][1]][sweeper_posx], SweeperRute[SweeperSteps[playerid][1]][sweeper_posy], SweeperRute[SweeperSteps[playerid][1]][sweeper_posz], SweeperRute[SweeperSteps[playerid][1]+1][sweeper_posx], SweeperRute[SweeperSteps[playerid][1]+1][sweeper_posy], SweeperRute[SweeperSteps[playerid][1]+1][sweeper_posz], 5);
                    Custom(playerid, "SIDEJOB", "Ikutilah checkpoint yang tersedia pada Radar");
                }
                else Error(playerid, "Route already taken by Someone");
            }
            case 2:
            {
                if(DialogSweeper[2] == false) // Kalau False atau tidak dipilih
                {
                    DialogSweeper[2] = true; // Dialog 1 telah di pilih
                    DialogSaya[playerid][2] = true;
                    SweeperSteps[playerid][2] = 41;
                    pData[playerid][pSideJob] = SIDEJOB_SWEEPER;
                    if(SweeperRute[SweeperSteps[playerid][2]][sweeper_rute] == 2) SetPlayerRaceCheckpoint(playerid, 0, SweeperRute[SweeperSteps[playerid][2]][sweeper_posx], SweeperRute[SweeperSteps[playerid][2]][sweeper_posy], SweeperRute[SweeperSteps[playerid][2]][sweeper_posz], SweeperRute[SweeperSteps[playerid][2]+1][sweeper_posx], SweeperRute[SweeperSteps[playerid][2]+1][sweeper_posy], SweeperRute[SweeperSteps[playerid][2]+1][sweeper_posz], 5);
                    Custom(playerid, "SIDEJOB", "Ikutilah checkpoint yang tersedia pada Radar");
                }
                else Error(playerid, "Route already taken by Someone");
            }
		}
	}
	else RemovePlayerFromVehicle(playerid);
    return 1;
}

//callback
#include <YSI\y_hooks>

hook OnGameModeInit()
{
    new strings[212];
    //SIDE JOB SWEEPER VEHICLE
	SweepVeh[0] = AddStaticVehicle(574, 1615.5201, -1896.2864, 13.2474, 0.0000, 1, 1);
	SweepVeh[1] = AddStaticVehicle(574, 1622.4797, -1896.2864, 13.2474, 0.0000, 1, 1);
	SweepVeh[2] = AddStaticVehicle(574, 1619.0095, -1896.2864, 13.2474, 0.0000, 1, 1);
	for(new x;x<MAX_SWEEPER_VEHICLES; x++)
	{
	    format(strings, sizeof(strings), ""GREEN_E"SWEPEER-%d", SweepVeh[x]);
	    SetVehicleNumberPlate(SweepVeh[x], strings);
	    SetVehicleToRespawn(SweepVeh[x]);
	}
}

hook OnPlayerStateChange(playerid, newstate, oldstate) {
    if(oldstate == PLAYER_STATE_DRIVER)
    {
        if(pData[playerid][pSideJob] == SIDEJOB_SWEEPER)
		{
			pData[playerid][pSideJob] = SIDEJOB_NONE;
			for(new i = 0; i < 3; i++)
			{
				if(DialogSaya[playerid][i] == true) // Cari apakah dia punya salah satu diantara 10 dialog tersebut
				{
					DialogSaya[playerid][i] = false; // Ubah Jadi Dia ga punya dialog lagi Kalau Udah Disconnect (Bukan dia lagi pemilik)
					DialogSweeper[i] = false; // Jadi ga ada yang punya nih dialog
					SetVehicleToRespawn(GetPVarInt(playerid, "LastVehicleID"));
				}
			}
			DisablePlayerRaceCheckpoint(playerid);
		}
    }
    if(newstate == PLAYER_STATE_DRIVER && newstate != PLAYER_STATE_PASSENGER)
	{
        if(IsASweeperVeh(GetPlayerVehicleID(playerid)))
		{
			new String[212];
			if(pData[playerid][pSweeperTime] == 0)
			{
				format(String, sizeof(String), "Route\tPrice\n");
				format(String, sizeof(String), "%sRoute A: Idlewood\t$500\n", String);
				format(String, sizeof(String), "%sRoute B: Pershing Square\t$550\n", String);
				format(String, sizeof(String), "%sRoute C: Verona Beach\t$750\n", String);
				Dialog_Show(playerid, DialogSweeper, DIALOG_STYLE_TABLIST_HEADERS, "Sweeper Sidejob", String, "Select", "Cancel");
			}
			else
			{
				Error(playerid, "Kamu harus menunggu %d Menit untuk menjadi Street Cleaner", pData[playerid][pSweeperTime]/60);
				RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			}
		}
    }
    return 1;
}

hook OnPlayerEnterRaceCP(playerid) 
{
    if(pData[playerid][pSideJob] == SIDEJOB_SWEEPER) 
    {
        if(SweeperSteps[playerid][0] != -1) {
            if(SweeperRute[SweeperSteps[playerid][0]][sweeper_rute] == 0 && SweeperRute[SweeperSteps[playerid][0]][sweeper_finish] == 0)
            {
                PlayerPlaySound(playerid, 1056, 0, 0, 0);
                SweeperSteps[playerid][0]++;
                switch(SweeperRute[SweeperSteps[playerid][0]][sweeper_finish]) 
                {
                    case 0: {
                        SetPlayerRaceCheckpoint(playerid, 0, SweeperRute[SweeperSteps[playerid][0]][sweeper_posx], SweeperRute[SweeperSteps[playerid][0]][sweeper_posy], SweeperRute[SweeperSteps[playerid][0]][sweeper_posz], SweeperRute[SweeperSteps[playerid][0]+1][sweeper_posx], SweeperRute[SweeperSteps[playerid][0]+1][sweeper_posy], SweeperRute[SweeperSteps[playerid][0]+1][sweeper_posz], 5);
                    }
                    case 1: {
                        SetPlayerRaceCheckpoint(playerid, 1, SweeperRute[SweeperSteps[playerid][0]][sweeper_posx], SweeperRute[SweeperSteps[playerid][0]][sweeper_posy], SweeperRute[SweeperSteps[playerid][0]][sweeper_posz], SweeperRute[SweeperSteps[playerid][0]+1][sweeper_posx], SweeperRute[SweeperSteps[playerid][0]+1][sweeper_posy], SweeperRute[SweeperSteps[playerid][0]+1][sweeper_posz], 5);
                    }
                }
                return 1;
            }
            else if(SweeperRute[SweeperSteps[playerid][0]][sweeper_rute] == 0 && SweeperRute[SweeperSteps[playerid][0]][sweeper_finish] == 1) {
                DialogSweeper[0] = false; // Dialog 0 telah di pilih
                DialogSaya[playerid][0] = false;
                GivePlayerMoneyEx(playerid, 5000);
                Custom(playerid, "SIDEJOB", "You've earned "GREEN"$500 "WHITE_E"for finishing sweeper sidejob");
                pData[playerid][pSweeperTime] = 900;
                pData[playerid][pSideJob] = SIDEJOB_NONE;
                SweeperSteps[playerid][0] = -1;
                SetVehicleToRespawn(GetPlayerVehicleID(playerid));
            }
        }
        if(SweeperSteps[playerid][1]) {
            if(SweeperRute[SweeperSteps[playerid][1]][sweeper_rute] == 1 && SweeperRute[SweeperSteps[playerid][1]][sweeper_finish] == 0)
            {
                PlayerPlaySound(playerid, 1056, 0, 0, 0);
                SweeperSteps[playerid][1]++;
                switch(SweeperRute[SweeperSteps[playerid][1]][sweeper_finish]) {
                    case 0: SetPlayerRaceCheckpoint(playerid, 0, SweeperRute[SweeperSteps[playerid][1]][sweeper_posx], SweeperRute[SweeperSteps[playerid][1]][sweeper_posy], SweeperRute[SweeperSteps[playerid][1]][sweeper_posz], SweeperRute[SweeperSteps[playerid][1]+1][sweeper_posx], SweeperRute[SweeperSteps[playerid][1]+1][sweeper_posy], SweeperRute[SweeperSteps[playerid][1]+1][sweeper_posz], 5);
                    case 1: SetPlayerRaceCheckpoint(playerid, 1, SweeperRute[SweeperSteps[playerid][1]][sweeper_posx], SweeperRute[SweeperSteps[playerid][1]][sweeper_posy], SweeperRute[SweeperSteps[playerid][1]][sweeper_posz], SweeperRute[SweeperSteps[playerid][1]+1][sweeper_posx], SweeperRute[SweeperSteps[playerid][1]+1][sweeper_posy], SweeperRute[SweeperSteps[playerid][1]+1][sweeper_posz], 5);
                }
                return 1;
            }
            else if(SweeperRute[SweeperSteps[playerid][1]][sweeper_rute] == 1 && SweeperRute[SweeperSteps[playerid][1]][sweeper_finish] == 1) {
                DialogSweeper[0] = false; // Dialog 0 telah di pilih
                DialogSaya[playerid][0] = false;
                GivePlayerMoneyEx(playerid, 5500);
                Custom(playerid, "SIDEJOB", "You've earned "GREEN"$550 "WHITE_E"for finishing sweeper sidejob");
                pData[playerid][pSweeperTime] = 900;
                pData[playerid][pSideJob] = SIDEJOB_NONE;
                SweeperSteps[playerid][1] = -1;
                SetVehicleToRespawn(GetPlayerVehicleID(playerid));
            }
        }
        if(SweeperSteps[playerid][2]) {
            if(SweeperRute[SweeperSteps[playerid][2]][sweeper_rute] == 2 && SweeperRute[SweeperSteps[playerid][2]][sweeper_finish] == 0)
            {
                PlayerPlaySound(playerid, 1056, 0, 0, 0);
                SweeperSteps[playerid][2]++;
                switch(SweeperRute[SweeperSteps[playerid][2]][sweeper_finish]) {
                    case 0: SetPlayerRaceCheckpoint(playerid, 0, SweeperRute[SweeperSteps[playerid][2]][sweeper_posx], SweeperRute[SweeperSteps[playerid][2]][sweeper_posy], SweeperRute[SweeperSteps[playerid][2]][sweeper_posz], SweeperRute[SweeperSteps[playerid][2]+1][sweeper_posx], SweeperRute[SweeperSteps[playerid][2]+1][sweeper_posy], SweeperRute[SweeperSteps[playerid][2]+1][sweeper_posz], 5);
                    case 1: SetPlayerRaceCheckpoint(playerid, 1, SweeperRute[SweeperSteps[playerid][2]][sweeper_posx], SweeperRute[SweeperSteps[playerid][2]][sweeper_posy], SweeperRute[SweeperSteps[playerid][2]][sweeper_posz], SweeperRute[SweeperSteps[playerid][2]+1][sweeper_posx], SweeperRute[SweeperSteps[playerid][2]+1][sweeper_posy], SweeperRute[SweeperSteps[playerid][2]+1][sweeper_posz], 5);
                }
                return 1;
            }
            else if(SweeperRute[SweeperSteps[playerid][2]][sweeper_rute] == 2 && SweeperRute[SweeperSteps[playerid][2]][sweeper_finish] == 1) {
                DialogSweeper[0] = false; // Dialog 0 telah di pilih
                DialogSaya[playerid][0] = false;
                GivePlayerMoneyEx(playerid, 7500);
                Custom(playerid, "SIDEJOB", "You've earned "GREEN"$750 "WHITE_E"for finishing sweeper sidejob");
                pData[playerid][pSweeperTime] = 900;
                pData[playerid][pSideJob] = SIDEJOB_NONE;
                SweeperSteps[playerid][2] = -1;
                SetVehicleToRespawn(GetPlayerVehicleID(playerid));
            }
        }
    }
    return 1;
}

IsASweeperVeh(carid)
{
	for(new v = 0; v < MAX_SWEEPER_VEHICLES; v++) {
	    if(carid == SweepVeh[v]) return 1;
	}
	return 0;
}
