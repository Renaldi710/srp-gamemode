//NEW DMV SYSTEM

new BoatLic; 
new TakeLicense[MAX_PLAYERS] = 0, DmvSteps[MAX_PLAYERS];
new TakeTestBoat[MAX_PLAYERS] = 0, BoatStep[MAX_PLAYERS];

enum boatlic {
    step,
	Float:boat_posx,
    Float:boat_posy,
    Float:boat_posz
};

stock const BoatLicense[][boatlic] = {
    {0, 2949.9888, -1618.9714, -0.3362},
    {0, 2933.6333, -1878.0604, -0.4223},
    {0, 2991.2759, -1873.3938, -0.2791},
    {0, 2932.7473, -1877.2120, -0.2972},
    {0, 3014.3789, -2022.1655, -0.4773},
    {0, 2819.9680, -2350.5815, -0.6470},
    {0, 2814.5676, -2584.2222, -0.4862},
    {0, 2499.0261, -2754.7043, -0.6937},
    {0, 2335.9321, -2692.3645, -0.4203},
    {0, 2561.7908, -2299.9319, -0.3658},
    {0, 2980.9324, -2129.0520, -0.8107},
    {0, 2977.3337, -1966.6511, -0.4574},
    {0, 2931.4436, -1869.3143, -0.6436},
    {1, 2955.5850, -1498.9686, -0.6003}
};

#include <YSI\y_hooks>

hook OnGameModeInit(){

    new strings[212];
    DmvVeh = AddStaticVehicleEx(426, 2062.4031,-1904.4381,13.3260,179.6736, 1, 1, VEHICLE_RESPAWN);
	BoatLic = AddStaticVehicleEx(452, 2954.4072, -1497.4480, -0.2639, 176.9170, 1, 1, VEHICLE_RESPAWN); // speeder

    //DMV
	CreateDynamicPickup(1239, 23, 1491.14, 1306.33, 1093.28, -1);
	format(strings, sizeof(strings), "[Car License]\n"YELLOW_E"/taketest "WHITE_E"- cost "GREEN"$50.00\n"YELLOW_E"/renewlic - "WHITE_E"Cost $25.00 for renew licenses");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 1491.14, 1306.33, 1093.28+0.5, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance

	//DMV
	CreateDynamicPickup(1239, 23, -2032.7240,-117.5565,1035.1719, -1);
	format(strings, sizeof(strings), "[Boat License]\n"YELLOW_E"/taketest "WHITE_E"- cost "GREEN"$100.00\n"YELLOW_E"/renewlic - "WHITE_E"Cost $50.00 for renew licenses");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, -2032.7240,-117.5565,1035.1719+0.5, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance
}

hook OnPlayerConnect(playerid) {
	TakeLicense[playerid] = -1;
	TakeTestBoat[playerid] = -1;
	return 1;
}

hook OnPlayerEnterRaceCP(playerid) {
    if(TakeTestBoat[playerid] > 0) {
        if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 452)
        {
            if(IsPlayerInAnyVehicle(playerid))
            {
				if(BoatStep[playerid]) {
                    if(BoatLicense[BoatStep[playerid]][step] == 0)
					{
						PlayerPlaySound(playerid, 1056, 0, 0, 0);
						BoatStep[playerid]++;
                        switch(BoatLicense[BoatStep[playerid]][step]) {
                            case 0: SetPlayerRaceCheckpoint(playerid, 0, BoatLicense[BoatStep[playerid]][boat_posx], BoatLicense[BoatStep[playerid]][boat_posy], BoatLicense[BoatStep[playerid]][boat_posz], BoatLicense[BoatStep[playerid]+1][boat_posx], BoatLicense[BoatStep[playerid]+1][boat_posy], BoatLicense[BoatStep[playerid]+1][boat_posz], 5);
                            case 1: SetPlayerRaceCheckpoint(playerid, 1, BoatLicense[BoatStep[playerid]][boat_posx], BoatLicense[BoatStep[playerid]][boat_posy], BoatLicense[BoatStep[playerid]][boat_posz], BoatLicense[BoatStep[playerid]][boat_posx], BoatLicense[BoatStep[playerid]][boat_posy], BoatLicense[BoatStep[playerid]][boat_posz], 5);
                        }
                    }
					else if(BoatLicense[BoatStep[playerid]][step] == 1)
					{
						DisablePlayerRaceCheckpoint(playerid);				        
				        BoatStep[playerid] = 0;
				        TakeTestBoat[playerid] = 0;
				        pData[playerid][pBoatLic] = 1;
	                    pData[playerid][pBoatLicTime] = gettime() + (91 * 86400);
	                    Custom(playerid, "LICENSE", ""WHITE_E"You have successfully passed the test and received your license");     
	                    Custom(playerid, "LICENSE", ""WHITE_E"Your "LIGHTGREEN"Boat license "WHITE_E"is active for "YELLOW_E"3 months");   
						SetVehicleToRespawn(GetPlayerVehicleID(playerid));
						PlayerPlaySound(playerid, 183, 0.0, 0.0, 0.0);
                        GivePlayerMoneyEx(playerid, -10000);
						return 1;
					}
				}
            }
        }
    }
    if(TakeLicense[playerid] == 1)
	{
	   if(DmvSteps[playerid] > 0)
		{
		 if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 426)
		    {
			 	if(IsPlayerInAnyVehicle(playerid))
				{
				    if(DmvSteps[playerid] == 2)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 3;
				        SetPlayerRaceCheckpoint(playerid, 0, 1968.0247,-1930.1829,13.0882,1824.0208,-1917.7654,13.0856, 5);
				        return 1;
				    }
				    else if(DmvSteps[playerid] == 3)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 4;
				        SetPlayerRaceCheckpoint(playerid, 0, 1824.0208,-1917.7654,13.0856,1787.3108,-1827.8440,13.0876, 5);
				        return 1;
				    }
				    else if(DmvSteps[playerid] == 4)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 5;
				        SetPlayerRaceCheckpoint(playerid, 0, 1787.3108,-1827.8440,13.0876,1688.0021,-1840.3541,13.0876, 5);
				        return 1;
				    }
				    else if(DmvSteps[playerid] == 5)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 6;
				        SetPlayerRaceCheckpoint(playerid, 0, 1688.0021,-1840.3541,13.0876,1625.1812,-1870.2305,13.0882, 5);
				        return 1;
				    }
				    else if(DmvSteps[playerid] == 6)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 7;
				        SetPlayerRaceCheckpoint(playerid, 0, 1625.1812,-1870.2305,13.0882,1571.7096,-1852.4192,13.0876, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 7)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 8;
				        SetPlayerRaceCheckpoint(playerid, 0, 1571.7096,-1852.4192,13.0876,1556.1931,-1730.5265,13.0875, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 8)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 9;
				        SetPlayerRaceCheckpoint(playerid, 0, 1556.1931,-1730.5265,13.0875,1531.9980,-1715.3065,13.0876, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 9)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 10;
				        SetPlayerRaceCheckpoint(playerid, 0, 1531.9980,-1715.3065,13.0876,1542.4998,-1594.5765,13.0876, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 10)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 11;
				        SetPlayerRaceCheckpoint(playerid, 0, 1542.4998,-1594.5765,13.0876,1680.8341,-1595.0997,13.0914, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 11)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 12;
				        SetPlayerRaceCheckpoint(playerid, 0, 1680.8341,-1595.0997,13.0914,1844.6248,-1614.3239,13.0882, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 12)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 13;
				        SetPlayerRaceCheckpoint(playerid, 0, 1844.6248,-1614.3239,13.0882,1939.3665,-1631.7688,13.0875, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 14;
				        SetPlayerRaceCheckpoint(playerid, 0, 1939.3665,-1631.7688,13.0875,1958.7997,-1769.8575,13.0876, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 14)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 15;
				        SetPlayerRaceCheckpoint(playerid, 0, 1958.7997,-1769.8575,13.0876,1980.0818,-1814.7788,13.0877, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 15)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 16;
				        SetPlayerRaceCheckpoint(playerid, 0, 1980.0818,-1814.7788,13.0877,2079.0569,-1824.9231,13.0873, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 16)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 17;
				        SetPlayerRaceCheckpoint(playerid, 0, 2079.0569,-1824.9231,13.0873,2061.8386,-1913.1362,13.2507, 5);
				        return 1;
				    }
					else if(DmvSteps[playerid] == 17)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 18;
				        SetPlayerRaceCheckpoint(playerid, 1, 2061.8386,-1913.1362,13.2507,2061.8386,-1913.1362,13.2507, 5);
				        return 1;
				    }
				    else if(DmvSteps[playerid] == 18)
				    {
				        DisablePlayerRaceCheckpoint(playerid);				        
				        DmvSteps[playerid] = 0;
				        TakeLicense[playerid] = 0;
				        pData[playerid][pTaketest] = 1;
				        pData[playerid][pDriveLic] = 1;
	                    pData[playerid][pDriveLicTime] = gettime() + (91 * 86400);
	                    Custom(playerid, "LICENSE", ""WHITE_E"You have successfully passed the test and received your license");     
	                    Custom(playerid, "LICENSE", ""WHITE_E"Your "LIGHTGREEN"Drive license "WHITE_E"is active for "YELLOW_E"3 months");   
						SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
				    }
				}
			}
		}
	}
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && TakeLicense[playerid] > 0)
	{
		TakeLicense[playerid] = 0;
        DmvSteps[playerid] = 0;
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && TakeTestBoat[playerid] > 0)
	{
		TakeTestBoat[playerid] = 0;
        BoatStep[playerid] = 0;
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER)
    {
		if(IsADmvVeh(GetPlayerVehicleID(playerid)))
		{
			DisablePlayerRaceCheckpoint(playerid);
			TakeLicense[playerid] = 0;
            DmvSteps[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			Servers(playerid, "Test Mengemudi gagal karena anda turun dari kendaraan");
			DisablePlayerCheckpoint(playerid);
			return 1;
		}
        if(IsABoatLicense(GetPlayerVehicleID(playerid)))
		{
			DisablePlayerRaceCheckpoint(playerid);
			TakeTestBoat[playerid] = 0;
            BoatStep[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			Servers(playerid, "Test Mengemudi gagal karena anda turun dari kendaraan");
			DisablePlayerCheckpoint(playerid);
			return 1;
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(IsADmvVeh(GetPlayerVehicleID(playerid)))
		{
			if(TakeLicense[playerid] > 0)
			{
				DmvSteps[playerid] = 2;
				SetPlayerRaceCheckpoint(playerid, 0, 2047.1849,-1930.2665,13.0876,1968.0247,-1930.1829,13.0882, 5.0);
				InfoTD_MSG(playerid, 3000, "Ikuti Checkpoint!");
			}
			else
			{
				RemovePlayerFromVehicle(playerid);
				Error(playerid, "Anda tidak memiliki izin!");
			}
			return 1;
		}
        if(IsABoatLicense(GetPlayerVehicleID(playerid)))
		{
			if(TakeTestBoat[playerid] > 0) SetPlayerRaceCheckpoint(playerid, 0, BoatLicense[BoatStep[playerid]][boat_posx], BoatLicense[BoatStep[playerid]][boat_posy], BoatLicense[BoatStep[playerid]][boat_posz], BoatLicense[BoatStep[playerid]+1][boat_posx], BoatLicense[BoatStep[playerid]+1][boat_posy], BoatLicense[BoatStep[playerid]+1][boat_posz], 5);
			else {
				RemovePlayerFromVehicle(playerid);
				Error(playerid, "Anda tidak memiliki izin!");
			}
			return 1;
		}
	}
    return 1;
}

IsABoatLicense(carid)
{
    if(carid == BoatLic) return 1;
	return 0;
}

IsADmvVeh(carid)
{
	if(carid == DmvVeh) return 1;
	return 0;
}


CMD:taketest(playerid, params[])
{
    if(pData[playerid][pTaketest] > 0)
    return Error(playerid, "You haven't had the test yet");
    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1491.14, 1306.33, 1093.28)) {
        new cost = 5000;
        if(pData[playerid][pMoney] < cost) return Error(playerid, "Your money is not enough");
        GivePlayerMoneyEx(playerid, -cost);
        TakeLicense[playerid] = 1;
        Servers(playerid, ""YELLOW_E"Silahkan keluar dari ruangan ini dan masuk ke mobil premier, ikuti langkah selanjutnya");
    }
    else if(IsPlayerInRangeOfPoint(playerid, 3.0, -2032.7240,-117.5565,1035.1719)) {
        TakeTestBoat[playerid] = 1;
        BoatStep[playerid] = 1;
        Servers(playerid, ""YELLOW_E"Silahkan keluar dari ruangan ini dan naiki boat speeder dibawah, ikuti langkah selanjutnya");
    }
    return 1;
}

CMD:renewlic(playerid, params[])
{
    if(pData[playerid][pTaketest] < 1)
    return Error(playerid, "You haven't had the test yet");
    if(pData[playerid][pDriveLic] > 0)
    return Error(playerid, "You still have an active license");
    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1491.14, 1306.33, 1093.28)) {
        new cost = 2500;
        if(pData[playerid][pMoney] < cost) return Error(playerid, "Your money is not enough");
        pData[playerid][pDriveLic] = 1;
        pData[playerid][pDriveLicTime] = gettime() + (15 * 86400);
        Custom(playerid, "LICENSE", " "WHITE_E"You have renewed your driver's license");     
        GivePlayerMoneyEx(playerid, -cost);
    }
    else if(IsPlayerInRangeOfPoint(playerid, 3.0, -2032.7240,-117.5565,1035.1719)) {
        new cost = 5000;
        if(pData[playerid][pMoney] < cost) return Error(playerid, "Your money is not enough");
        pData[playerid][pBoatLic] = 1;
        pData[playerid][pBoatLicTime] = gettime() + (15 * 86400);
        Custom(playerid, "LICENSE", " "WHITE_E"You have renewed your boat license");     
        GivePlayerMoneyEx(playerid, -cost);
    }
    return 1;
}