GetLicenseDriver(playerid) 
{
	new str[512];
	if(pData[playerid][pDriveLic] == 1) 
	{
		format(str, sizeof(str), ""WHITE_E"["GREEN"Valid until %s"WHITE_E"]", ConvertTimestamp(Timestamp:pData[playerid][pDriveLicTime]));
	}
	else if(pData[playerid][pDriveLic] == 0)
	{ 
		format(str, sizeof(str), ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"); 
	} 
	else if(pData[playerid][pDriveLic] == 2)
	{ 
		format(str, sizeof(str), ""WHITE_E"["RED_E"Experied %s"WHITE_E"]", ConvertTimestamp(Timestamp:pData[playerid][pDriveLicTime])); 
	}
	
	return str;
}

GetLicenseFly(playerid) 
{
	new str[500];
	if(pData[playerid][pFlyLic] == 1) 
	{ 
		format(str, sizeof(str), ""WHITE_E"["GREEN"Valid until %s"WHITE_E"]", ConvertTimestamp(Timestamp:pData[playerid][pFlyLicTime])); 
	}
	else if(pData[playerid][pFlyLic] == 0)
	{ 
		format(str, sizeof(str), ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"); 
	} 
	else if(pData[playerid][pFlyLic] == 2)
	{ 
		format(str, sizeof(str), ""WHITE_E"["RED_E"Experied %s"WHITE_E"]", ConvertTimestamp(Timestamp:pData[playerid][pFlyLicTime])); 
	}
	
	return str;
}

GetLicenseBoat(playerid) 
{
	new str[500];
	if(pData[playerid][pBoatLic] == 1) 
	{ 
		format(str, sizeof(str), ""WHITE_E"["GREEN"Valid until %s"WHITE_E"]", ConvertTimestamp(Timestamp:pData[playerid][pBoatLicTime])); 
	}
	else if(pData[playerid][pBoatLic] == 0)
	{ 
		format(str, sizeof(str), ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"); 
	} 
	else if(pData[playerid][pBoatLic] == 2)
	{ 
		format(str, sizeof(str), ""WHITE_E"["RED_E"Experied %s"WHITE_E"]",  ConvertTimestamp(Timestamp:pData[playerid][pBoatLicTime])); 
	}
	return str;
}

GetLicenseGun(playerid) 
{
	new str[500];
	if(pData[playerid][pGunLic] == 1) 
	{ 
		format(str, sizeof(str), ""WHITE_E"["GREEN"Valid until %s"WHITE_E"]", ConvertTimestamp(Timestamp:pData[playerid][pGunLicTime])); 
	}
	else if(pData[playerid][pGunLic] == 0)
	{ 
		format(str, sizeof(str), ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"); 
	} 
	else if(pData[playerid][pGunLic] == 2)
	{ 
		format(str, sizeof(str), ""WHITE_E"["RED_E"Experied %s"WHITE_E"]", ConvertTimestamp(Timestamp:pData[playerid][pGunLicTime])); 
	}
	
	return str;
}

GetLicenseTrucker(playerid) 
{
	new str[500];
	if(pData[playerid][pTruckerLic] == 1) 
	{ 
		format(str, sizeof(str), ""WHITE_E"["GREEN"Valid until %s"WHITE_E"]", ConvertTimestamp(Timestamp:pData[playerid][pTruckerLicTime])); 
	}
	else if(pData[playerid][pTruckerLic] == 0)
	{ 
		format(str, sizeof(str), ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"); 
	} 
	else if(pData[playerid][pTruckerLic] == 2)
	{ 
		format(str, sizeof(str), ""WHITE_E"["RED_E"Experied %s"WHITE_E"]", ConvertTimestamp(Timestamp:pData[playerid][pTruckerLicTime])); 
	}
	
	return str;
}

GetLicenseLumber(playerid) 
{
	new str[500];
	if(pData[playerid][pLumberLic] == 1) 
	{ 
		format(str, sizeof(str), ""WHITE_E"["GREEN"Valid until %s"WHITE_E"]", ConvertTimestamp(Timestamp:pData[playerid][pLumberLicTime])); 
	}
	else if(pData[playerid][pLumberLic] == 0)
	{ 
		format(str, sizeof(str), ""WHITE_E"[{FF0000}Not passed"WHITE_E"]"); 
	} 
	else if(pData[playerid][pLumberLic] == 2)
	{ 
		format(str, sizeof(str), ""WHITE_E"["RED_E"Experied %s"WHITE_E"]", ConvertTimestamp(Timestamp:pData[playerid][pLumberLicTime])); 
	}
	
	return str;
}

CMD:license(playerid, params[])
{
	new giveplayerid, str[512];
	if(sscanf(params, "u", giveplayerid))
	{
		format(str, sizeof(str), "LICENSE: "WHITE_E"Your license\n\
		1. "LIGHTGREEN"Driver license: %s\n\
		2. "LIGHTGREEN"Flying license: %s\n\
		3. "LIGHTGREEN"Boating license: %s\n\
		4. "LIGHTGREEN"Heavy Truck license: %s\n\
		5. "LIGHTGREEN"Lumberjack license: %s\n\
		6. "LIGHTGREEN"Weapon license: %s\n\
		NOTE: Gunakan '/license [playerid]' untuk memperlihatkan lisensi anda",
		GetLicenseDriver(playerid),
		GetLicenseFly(playerid),
		GetLicenseBoat(playerid),
		GetLicenseTrucker(playerid),
		GetLicenseLumber(playerid),
		GetLicenseGun(playerid));
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "License", str, "Close", "");
		return 1;
	}
	if(!IsPlayerConnected(giveplayerid) || !NearPlayer(playerid, giveplayerid, 4.0))
		return Error(playerid, "The specified player is disconnected or not near you.");
	format(str, sizeof(str), "LICENSE: "WHITE_E"Your license\n\
		1. "LIGHTGREEN"Driver license: %s\n\
		2. "LIGHTGREEN"Flying license: %s\n\
		3. "LIGHTGREEN"Boating license: %s\n\
		4. "LIGHTGREEN"Heavy Truck license: %s\n\
		5. "LIGHTGREEN"Lumberjack license: %s\n\
		6. "LIGHTGREEN"Weapon license: %s",
		GetLicenseDriver(playerid),
		GetLicenseFly(playerid),
		GetLicenseBoat(playerid),
		GetLicenseTrucker(playerid),
		GetLicenseLumber(playerid),
		GetLicenseGun(playerid));
	ShowPlayerDialog(giveplayerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "License", str, "Close", "");
	return 1;
}

ptask LicenseTask[1000](playerid)
{
    if(pData[playerid][pDriveLic] > 0)
	{
		if(pData[playerid][pDriveLicTime] != 0 && pData[playerid][pDriveLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, ARWIN, "LISENCE: "YELLOW_E"The validity period of your vehicle license has expired!");
			pData[playerid][pDriveLic] = 2;
			pData[playerid][pDriveLicTime] = 0;
		}
	}
    if(pData[playerid][pTruckerLic] > 0)
	{
		if(pData[playerid][pTruckerLicTime] != 0 && pData[playerid][pTruckerLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_RED, "LISENCE: "YELLOW_E"The validity period of your trucker license has expired!");
			pData[playerid][pTruckerLic] = 2;
			pData[playerid][pTruckerLicTime] = 0;
		}
	}
	if(pData[playerid][pLumberLic] > 0)
	{
		if(pData[playerid][pLumberLicTime] != 0 && pData[playerid][pLumberLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_RED, "LISENCE: "YELLOW_E"The validity period of your lumberjack license has expired!");
			pData[playerid][pLumberLic] = 2;
			pData[playerid][pLumberLicTime] = 0;
		}
	}
	if(pData[playerid][pGunLic] > 0)
	{
		if(pData[playerid][pGunLicTime] != 0 && pData[playerid][pGunLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_RED, "LISENCE: "YELLOW_E"The validity period of your weapon license has expired!");
			pData[playerid][pGunLic] = 2;
			pData[playerid][pGunLicTime] = 0;
		}
	}
	if(pData[playerid][pFlyLic] > 0)
	{
		if(pData[playerid][pFlyLicTime] != 0 && pData[playerid][pFlyLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_RED, "LISENCE: "YELLOW_E"The validity period of your flying license has expired!");
			pData[playerid][pFlyLic] = 2;
			pData[playerid][pFlyLicTime] = 0;
		}
	}
	if(pData[playerid][pBoatLic] > 0)
	{
		if(pData[playerid][pBoatLicTime] != 0 && pData[playerid][pBoatLicTime] <= gettime())
		{
			SendClientMessageEx(playerid, COLOR_RED, "LISENCE: "YELLOW_E"The validity period of your boating license has expired!");
			pData[playerid][pBoatLic] = 2;
			pData[playerid][pBoatLicTime] = 0;
		}
	}
    return 1;
}

