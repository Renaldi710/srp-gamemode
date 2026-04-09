/*


         TASK OPTIMIZED LUNARPRIDE
 
*/

task onlineTimer[1000]()
{	
    /*foreach (new i : Player) 
	{
		SetPlayerTime(i, hours, minutes);
		if(pData[i][pInDoor] <= -1 || pData[i][pInHouse] <= -1 || pData[i][pInBiz] <= -1)
        {
			SetPlayerWeather(i, GetGVarInt("g_Weather"));
		}
	}*/
	//Date and Time Textdraw
	new datestring[64];
	new hours,
	minutes,
	seconds,
	days,
	months,
	years;
	new MonthName[12][] =
	{
		"January", "February", "March", "April", "May", "June",
		"July",	"August", "September", "October", "November", "December"
	};
	getdate(years, months, days);
 	gettime(hours, minutes, seconds);
	format(datestring, sizeof datestring, "%s%d %s %s%d", ((days < 10) ? ("0") : ("")), days, MonthName[months-1], (years < 10) ? ("0") : (""), years);
	TextDrawSetString(TextDate, datestring);
	format(datestring, sizeof datestring, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
	TextDrawSetString(TextTime, datestring);

	// Increase server uptime
	up_seconds ++;
	if(up_seconds == 60)
	{
	    up_seconds = 0, up_minutes ++;
	    if(up_minutes == 60)
	    {
	        up_minutes = 0, up_hours ++;
	        if(up_hours == 24) up_hours = 0, up_days ++;
			new tstr[128], rand = RandomEx(0, 20);
			format(tstr, sizeof(tstr), ""BLUE_E"UPTIME: "WHITE_E"The server has been online for %s.", Uptime());
			SendClientMessageToAll(COLOR_WHITE, tstr);
			if(hours > 18)
			{
				SetWorldTime(0);
				WorldTime = 0;
			}
			else
			{
				SetWorldTime(hours);
				WorldTime = hours;
			}
			SetWeather(rand);
			WorldWeather = rand;

			// Sync Server
			mysql_tquery(g_SQL, "OPTIMIZE TABLE `bisnis`,`houses`,`toys`,`vehicle`");
			//SetTimer("changeWeather", 10000, false);
		}
	}
	return 1;
}

ptask PlayerDelay[1000](playerid)
{
	if(pData[playerid][IsLoggedIn] == false) return 0;

	/* time server update */
	//new date[56], year, month, day, hour, minute, second;

	//getdate(year, month, day);
	//gettime(hour, minute, second);

	//%02d:%02d:%02d
	//PlayerTextDrawSetString(playerid, TIMETD[playerid][1], sprintf("%02d/%02d/%i", day, month, year, hour, minute, second));

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsEngineVehicle(GetPlayerVehicleID(playerid)))
    {
        new id = -1;
        new vehicleid = GetPlayerVehicleID(playerid);

        if((id = Speed_Nearest(playerid)) != -1 && GetVehicleSpeed(vehicleid) > SpeedData[id][speedLimit] && !pData[playerid][pSpeedTime])
        {
            if(!IsABoat(vehicleid) || !IsAPlane(vehicleid) || !IsAHelicopter(vehicleid))
            {
                new Float:x, Float:y, Float:z, direction[12], plate[24];
                pData[playerid][pSpeedTime] = 5;

                GetPlayerPos(playerid, x, y, z);
                GetVehicleDirection(vehicleid, direction);
                GetVehicleNumberPlate(vehicleid, plate);
                SendSpeedCamMessageEx(1, COLOR_BLUE, "SPEEDCAM: "LIGHTBLUE"%s "BLUE"["YELLOW"%s"BLUE"] reached maximum speed cam.", GetVehicleNameByVehicle(vehicleid), plate);
                SendSpeedCamMessageEx(1, COLOR_BLUE, "Speed: ["YELLOW"%.0f mph"BLUE"] Max speed: ["YELLOW"%.0f mph"BLUE"] Location: ["YELLOW"%s"BLUE_E"] Heading: ["YELLOW"%s"BLUE"]", GetVehicleSpeed(vehicleid), SpeedData[id][speedLimit], GetLocation(x, y, z), direction);

                Speed_UpdateSuspect(id, vehicleid);
            }
        }
	}
	// Booster Expired Checking
	if(pData[playerid][pBooster] > 0)
	{
		if(pData[playerid][pBoostTime] != 0 && pData[playerid][pBoostTime] <= gettime())
		{
			Info(playerid, "Maaf, Booster player anda sudah habis! sekarang anda adalah player biasa!");
			pData[playerid][pBooster] = 0;
			pData[playerid][pBoostTime] = 0;
		}
	}
		//VIP Expired Checking
	if(pData[playerid][pVip] > 0)
	{
		if(pData[playerid][pVipTime] != 0 && pData[playerid][pVipTime] <= gettime())
		{
			Info(playerid, "Maaf, Level VIP player anda sudah habis! sekarang anda adalah player biasa!");
			pData[playerid][pVip] = 0;
			pData[playerid][pVipTime] = 0;
		}
	}
		//ID Card Expired Checking
	if(pData[playerid][pIDCard] > 0)
	{
		if(pData[playerid][pIDCardTime] != 0 && pData[playerid][pIDCardTime] <= gettime())
		{
			Info(playerid, "Masa berlaku ID Card anda telah habis, silahkan perpanjang kembali!");
			pData[playerid][pIDCard] = 0;
			pData[playerid][pIDCardTime] = 0;
		}
	}

	if(pData[playerid][pExitJob] != 0 && pData[playerid][pExitJob] <= gettime())
	{
		Info(playerid, "Now you can exit from your current job!");
		pData[playerid][pExitJob] = 0;
	}
	if(pData[playerid][pAdvertiseTime] > 0)
	{
		if(--pData[playerid][pAdvertiseTime] == 1)
		{
			pData[playerid][pAdvertiseTime] = 0;
			Info(playerid, "Sekarang kamu dapat melakukan "YELLOW"Advertisement "WHITE"kembali");
		}
	}
	if(pData[playerid][pTruckerCrateTime] > 0 && pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		if(--pData[playerid][pTruckerCrateTime] == 1)
		{
			pData[playerid][pTruckerCrateTime] = 0;
			Info(playerid, "Sekarang kamu dapat bekerja sebagai "YELLOW"Trucker Crate "WHITE"kembali");
		}
	}
	if(pData[playerid][pTruckerHaulingTime] > 0 && pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		if(--pData[playerid][pTruckerHaulingTime] == 1)
		{
			pData[playerid][pTruckerHaulingTime] = 0;
			Info(playerid, "Sekarang kamu dapat bekerja sebagai "YELLOW"Trucker Hauling "WHITE"kembali");
		}
	}
	if(pData[playerid][pTrainingTime] > 0)
	{
		if(--pData[playerid][pTrainingTime] == 1)
		{
			pData[playerid][pTrainingTime] = 0;
			Info(playerid, "Sekarang kamu dapat melakukan "YELLOW"Weapon Training "WHITE"kembali");
		}
	}
	/*
	if(--pData[playerid][pTruckerProductTime] <= 0)
	{
		pData[playerid][pTruckerProductTime] = 0;
	}
	if(--pData[playerid][pTruckerHaulingTime] <= 0)
	{
		pData[playerid][pTruckerHaulingTime] = 0;
	}
	if(--pData[playerid][pProductTime] <= 0)
	{
		pData[playerid][pProductTime] = 0;
	}*/
	if(pData[playerid][pMinerTime] > 0 && pData[playerid][pJob] == 5 || pData[playerid][pJob2] == 5)
	{
		if(--pData[playerid][pMinerTime] == 1)
		{
			pData[playerid][pMinerTime] = 0;
			Info(playerid, "Sekarang kamu dapat bekerja sebagai "YELLOW"Miner "WHITE"kembali");
		}
	}
	if(pData[playerid][pLumberTime] > 0 && pData[playerid][pJob] == 3 || pData[playerid][pJob2] == 3)
	{
		if(--pData[playerid][pLumberTime] == 1)
		{
			pData[playerid][pLumberTime] = 0;
			Info(playerid, "Sekarang kamu dapat mulai bekerja "YELLOW"Lumber "WHITE"kembali");
		}
	}
	if(pData[playerid][pFishTime] > 0)
	{
		if(--pData[playerid][pFishTime] == 1)
		{
			pData[playerid][pFishTime] = 0;
			Info(playerid, "Sekarang kamu dapat mulai melakukan "YELLOW"Mancing "WHITE"kembali");
		}
	}
	if(pData[playerid][pBusTime] > 0)
	{
		if(--pData[playerid][pBusTime] == 1)
		{
			pData[playerid][pBusTime] = 0;
			Info(playerid, "Sekarang kamu dapat bekerja "YELLOW"Supir Bus "WHITE"kembali");
		}
	}
	if(pData[playerid][pForkliftTime] > 0)
	{
		if(--pData[playerid][pForkliftTime] == 1)
		{
			pData[playerid][pForkliftTime] = 0;
			Info(playerid, "Sekarang kamu dapat bekerja "YELLOW"Forklift "WHITE"kembali");
		}
	}
	if(pData[playerid][pSweeperTime] > 0)
	{
		if(--pData[playerid][pSweeperTime] == 1)
		{
			pData[playerid][pSweeperTime] = 0;
			Info(playerid, "Sekarang kamu dapat bekerja sebagai "YELLOW"Sweeper "WHITE"kembali");
		}
	}
	if(pData[playerid][pCourierTime] > 0)
	{
		if(--pData[playerid][pCourierTime] == 1)
		{
			pData[playerid][pCourierTime] = 0;
			Info(playerid, "Sekarang kamu dapat bekerja sebagai "YELLOW"Courier "WHITE"kembali");
		}
	}
		//Player JobTime Delay
		/*
	if(pData[playerid][pJobTime] > 0)
	{
		pData[playerid][pJobTime]--;
	}
	if(pData[playerid][pSideJobTime] > 0)
	{
		pData[playerid][pSideJobTime]--;
	}*/
		// Duty Delay
	if(pData[playerid][pDutyHour] > 0)
	{
		pData[playerid][pDutyHour]--;
		if(pData[playerid][pDutyHour] <= 0)
		{
			pData[playerid][pDutyHour] = 0;
		}
	}
		// Rob Delay
	if(pData[playerid][pRobTime] > 0)
	{
		pData[playerid][pRobTime]--;
		if(pData[playerid][pRobTime] <= 0)
		{
			pData[playerid][pRobTime] = 0;
		}
	}
		// Get Loc timer
	if(pData[playerid][pSuspectTimer] > 0)
	{
		pData[playerid][pSuspectTimer]--;
		if(pData[playerid][pSuspectTimer] <= 0)
		{
			pData[playerid][pSuspectTimer] = 0;
		}
	}
		//Warn Player Check
	if(pData[playerid][pWarn] >= 20)
	{
		new ban_time = gettime() + (5 * 86400), query[512], PlayerIP[16], giveplayer[24];
		GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
		GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
		pData[playerid][pWarn] = 0;
			//SetPlayerPosition(playerid, 227.46, 110.0, 999.02, 360.0000, 10);
		BanPlayerMSG(playerid, playerid, "20 Total Warning", true);
		SendClientMessageToAllEx(COLOR_RED, "Server: "GREY2_E"Player %s(%d) telah otomatis dibanned permanent dari server. [Reason: 20 Total Warning]", giveplayer, playerid);

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', 'Server Ban', '20 Total Warning', %i, %d)", giveplayer, PlayerIP, gettime(), ban_time);
		mysql_tquery(g_SQL, query);
		KickEx(playerid);
	}
	return 1;
}

ptask FarmDetect[1000](playerid)
{
	if(pData[playerid][IsLoggedIn] == true)
	{
		if(pData[playerid][pPlant] >= 20)
		{
			pData[playerid][pPlant] = 0;
			pData[playerid][pPlantTime] = 600;
		}
		if(pData[playerid][pPlantTime] > 0)
		{
			pData[playerid][pPlantTime]--;
			if(pData[playerid][pPlantTime] < 1)
			{
				pData[playerid][pPlantTime] = 0;
				pData[playerid][pPlant] = 0;
			}
		}
	}
	return 1;
}

ptask playerTimer[1000](playerid)
{
	if(pData[playerid][IsLoggedIn] == true)
	{
		pData[playerid][pPaycheck] ++;

		pData[playerid][pSeconds] ++, pData[playerid][pCurrSeconds] ++;
		if(pData[playerid][pOnDuty] >= 1)
		{
			pData[playerid][pOnDutyTime]++;
		}
		if(pData[playerid][pTaxiDuty] >= 1)
		{
			pData[playerid][pTaxiTime]++;
		}
		if(pData[playerid][pSeconds] == 60)
		{
			new scoremath = ((pData[playerid][pLevel])*5);

			pData[playerid][pMinutes]++, pData[playerid][pCurrMinutes] ++;
			pData[playerid][pSeconds] = 0, pData[playerid][pCurrSeconds] = 0;

			switch(pData[playerid][pMinutes])
			{
				case 20:
				{
					if(pData[playerid][pBooster] == 1)
					{
						AddPlayerSalary(playerid, "Bonus Boost ( RP Booster )", 200);
					}
				}
				case 40:
				{
					if(pData[playerid][pBooster] == 1)
					{
						pData[playerid][pPaycheck] = 3601;
					}
					if(pData[playerid][pPaycheck] >= 3600)
					{
						PlayerPlaySound(playerid, 1186, 0, 0, 0);
						DisplayPaycheck(playerid);
						//Custom(playerid,"PAYCHECK: "WHITE_E"Pergilah ke bank lalu "YELLOW_E"'/bank' "WHITE_E"untuk mendapat kan paycheck anda.");
					}
				}
				case 60:
				{
					if(pData[playerid][pPaycheck] >= 3600)
					{
						PlayerPlaySound(playerid, 1186, 0, 0, 0);
						DisplayPaycheck(playerid);
						//Custom(playerid,"PAYCHECK: "WHITE_E"Pergilah ke bank lalu "YELLOW_E"'/bank' "WHITE_E"untuk mendapat kan paycheck anda.");
					}

					pData[playerid][pHours] ++;
					pData[playerid][pLevelUp] += 1;
					pData[playerid][pMinutes] = 0;
					UpdatePlayerData(playerid);

					if(pData[playerid][pLevelUp] >= scoremath)
					{
						new mstr[128];
						pData[playerid][pLevel] += 1;
						pData[playerid][pHours] ++;
						SetPlayerScore(playerid, pData[playerid][pLevel]);
						format(mstr,sizeof(mstr),"~g~Level Up!~n~~w~Sekarang anda level ~r~%d", pData[playerid][pLevel]);
						GameTextForPlayer(playerid, mstr, 6000, 1);
					}
				}
			}
			if(pData[playerid][pCurrMinutes] == 60)
			{
				pData[playerid][pCurrMinutes] = 0;
				pData[playerid][pCurrHours] ++;
			}
		}
	}
	return 1;
}

ptask Player_VehicleSpeedUpgraded[1000](playerid)
{
    if(!pData[playerid][IsLoggedIn])
        return 0;

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
    {
        new 
            index = -1,
            i = GetPlayerVehicleID(playerid)
        ;
        if((index = Vehicle_GetID(i)) != -1)
        {
			if(GetVehicleSpeed(i) > 100 && GetVehicleSpeed(i) < 250 && pvData[index][cEngineUpgrade])//&& !DisableTurbo[i]
			{
				if(GetVehicleSpeed(i) > 110 && GetVehicleSpeed(i) < 145)
				{
					SetVehicleSpeedEx(i, GetVehicleSpeed(i)+30, true, false);
				}
			}
        }
	}
	return 1;
}