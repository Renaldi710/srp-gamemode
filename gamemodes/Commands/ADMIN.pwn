CMD:acmds(playerid)
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);

	new line3[2480];
	strcat(line3, ""WHITE_E"Moderator/Admin Commands:"LB2_E"\n\
 	/aduty /a /h /asay /togooc /o /goto /sendto /gethere /freeze /unfreeze /arevive /spec /slap\n\
 	/caps /peject /astats /ostats /acuff /auncuff /jetpack /getip /aka /akaip /jail /unjail\n\
	/kick /ban /unban /respawnsapd /respawnsags /respawnsamd /respawnsana /respawnjobs /settwittername /setbooster\n\
	/reports /asks /ans /ar /dr /vmodels /vehname /apv /aveh /gotoveh /getveh /respawnveh /respawnra /aject /setvw");

	strcat(line3, "\n\n"WHITE_E"Admin Junior Commands:"LB2_E"\n\
 	/sethp /setbone /afuel /agl /clearreports /afix /setskin /akill /ann /cd /settime /setweather\n\
    /ojail /owarn /setam /gotoco /gotohouse /gotobisnis /gotodoor /gotolocker /gotogs /banip /unbanip");

	strcat(line3, "\n\n"WHITE_E"Admin Commands:"LB2_E"\n\
	/oban /reloadweap /resetweap /sethbe /setlevel\n\
 	/createdoor /editdoor");

	strcat(line3, ""WHITE_E"\n\nHead Admin Commands:"LB2_E"\n\
	/setname /setvip /setfaction /setleader /takemoney /takegold /giveweap\n\
	/veh /destroyveh");

	strcat(line3, "\n\n"WHITE_E"Executive Admin Commands:"LB2_E"\n\
	/sethelperlevel /setadminname /setmoney /givemoney /setbankmoney /givebankmoney\n\
	/setskill /setskillweapon /setscoreskill /fishing\n\
	/setmaterial /setcomponent /createpv /destroypv /explode /makequiz /agive\n\n\
	"WHITE_E"Developer/CEO:"LB2_E"\n\
	/setadminlevel /setgold /givegold /setstock /setprice\n\
	/setpassword /createhouse /edithouse /createbisnis /editbisnis");
 	
	strcat(line3, "\n"BLUE_E"North Country "WHITE_E"- Anti-Cheat is actived.\n\
	"PINK_E"NOTE: All admin commands log is saved in database! | Abuse Commands? Kick And Demote Premanent!.");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"North Country: "YELLOW_E"Staff Commands", line3, "OK","");
	return true;
}

CMD:arelease(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
        return Error(playerid, "Kamu harus menjadi Admin level 5.");

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/arelease <ID/Name>");
	    return true;
	}

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player tersebut belum masuk!");

	if(pData[otherid][pArrest] == 0)
	    return Error(playerid, "The player isn't in arrest!");

	pData[otherid][pArrest] = 0;
	pData[otherid][pArrestTime] = 0;
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SetPlayerPositionEx(otherid, 1526.69, -1678.05, 5.89, 267.76, 2000);
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);
	return true;
}

CMD:makequiz(playerid, params[])
{
	if(pData[playerid][pAdmin] > 4)
	{
		new tmp[128], string[256], str[256], pr;
		if(sscanf(params, "s", tmp)) {
			Usage(playerid, "/makequiz [option]");
			Usage(playerid, "question, answer, price, end");
			Info(playerid, "Tolong buat jawabannya dulu.");
			return 1;
		}
		if(!strcmp(tmp, "question", true, 8))
		{
			if(sscanf(params, "s[128]s[256]", tmp, str)) return Usage(playerid, "/makequiz question [question]");
			if (quiz == 1) return Error(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan /makequiz end.");
			if (answermade == 0) return Error(playerid, "tolong buat jawaban dulu...");
			if (qprs == 0) return Error(playerid, "Tolong tambahkan hadiah terlebih dahulu.");
			format(string, sizeof(string), "{7fffd4}[QUIZ]: {ffff00}%s?, Hadiah {00FF00}$%d.", str, qprs);
			SendClientMessageToAll(0xFFFF00FF, string);
			SendClientMessageToAll(-1,"{ffff00}Anda bisa memberi jawaban dengan menggunakan /answer.");
			quiz = 1;
		}
		else if(!strcmp(tmp, "answer", true, 6))
		{
			if(sscanf(params, "s[128]s[256]", tmp, str)) return Usage(playerid, "/makequiz answer [answer]");
			if (quiz == 1) return Info(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan /makequiz end.");
			answers = str;
			answermade = 1;
			format(string, sizeof(string), "Anda telah membuat jawaban, {00FF00}%s.", str);
			SendClientMessage(playerid, 0xFFFFFFFF, string);
		}
		else if(!strcmp(tmp, "price", true, 5))
		{
			if(sscanf(params, "s[128]d", tmp, pr)) return Usage(playerid, "/makequiz price [amount]");
			if (quiz == 1) return Error(playerid, "Kuis sudah dimulai kamu bisa mengakhirinya dengan / makequiz end.");
			if (answermade == 0) return Error(playerid, " Membuat jawabannya lebih dulu...");
			if (pr <= 0) return Error(playerid, "buat harga lebih besar dari 0!");
			qprs = pr;
			format(string, sizeof(string), "Anda telah menempatkan {00FF00}%d sebagai jumlah hadiah untuk kuis.", pr);
			SendClientMessage(playerid, 0xFFFFFFFF, string);
		}
		else if(!strcmp(tmp, "end", true, 3))
		{
			if (quiz == 0) return Error(playerid, "Sayangnya tidak ada kuis dari admin server.");
			SendClientMessageToAll(0xFF0000FF, "Sayangnya Admin server telah mengakhiri kuis tersebut.");
			answermade = 0;
			quiz = 0;
			qprs = 0;
			answers = "";
		}
	}
	else return PermissionError(playerid);
	return 1;
}

CMD:answer(playerid, params[])
{
	new tmp[256], string[256];
	if (quiz == 0) return Error(playerid, "Sayangnya tidak ada kuis dari admin server.");
	if (sscanf(params, "s[256]", tmp)) return Usage(playerid, "/answer [jawaban]");
	if(strcmp(tmp, answers, true)==0)
	{
		GivePlayerMoneyEx(playerid, qprs);
		format(string, sizeof(string), "[QUIZ]: %s telah memberikan jawaban yang benar '%s' dari kuis dan mendapatkan hadiah {00FF00}%d.", ReturnName(playerid), answers, qprs);
		SendClientMessageToAll(0xFFFF00FF, string);
		answermade = 0;
		quiz = 0;
		qprs = 0;
		answers = "";
	}
	else
	{
		Error(playerid,"Jawaban yang salah coba keberuntungan Anda lain kali.");
	}
	return 1;
}

CMD:hcmds(playerid)
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
		return PermissionError(playerid);

	new line3[2480];
	strcat(line3, ""WHITE_E"Junior Helper Commands:"LB2_E"\n\
 	/aduty /h /asay /o /goto /sendto /gethere /freeze /unfreeze\n\
	/kick /slap /caps /acuff /auncuff /reports /ar /dr");

	strcat(line3, "\n\n"WHITE_E"Senior Helper Commands:"LB2_E"\n\
 	/spec /peject /astats /ostats /jetpack\n\
    /jail /unjail");

	strcat(line3, "\n\n"WHITE_E"Head Helper Commands:"LB2_E"\n\
	/respawnsapd /respawnsags /respawnsamd /respawnsana /respawnjobs\n");
 	
	strcat(line3, "\n"BLUE_E"North Country "WHITE_E"- Anti-Cheat is actived.\n\
	"PINK_E"NOTE: All admin commands log is saved in database! | Abuse Commands? Kick And Demote Premanent!.");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"North Country: "YELLOW_E"Staff Commands", line3, "OK","");
	return true;
}

CMD:admins(playerid, params[])
{
	new count = 0, line3[512];
	if(pData[playerid][pAdmin] > 0)
	{
		foreach(new i:Player)
		{
			if(pData[i][pAdmin] > 0 || pData[i][pHelper] > 0)
			{
				format(line3, sizeof(line3), "%s\n"WHITE_E"[%s"WHITE_E"] %s(%s) (ID: %i)", line3, GetStaffRank(i), pData[i][pName], pData[i][pAdminname], i);
				count++;
			}
		}
		if(count > 0)
		{
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", line3, "Close", "");
		}
		else return ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", "There are no admin online!", "Close", "");
	}
	else
	{
		foreach(new i:Player)
		{
			if(pData[i][pAdmin] > 0 || pData[i][pHelper] > 0)
			{
				if(pData[i][pAdminDuty] == 1)
				{
					format(line3, sizeof(line3), "%s\n"WHITE_E"[%s"WHITE_E"] %s (ID: %i)", line3, GetStaffRank(i), pData[i][pAdminname], i);
					count++;
				}
			}
		}
		if(count > 0)
		{
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", line3, "Close", "");
		}
		else return ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Staff Online", "There are no admin online duty!", "Close", "");
	}
	return 1;
}

CMD:adminjail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new count = 0, line3[512];
	foreach(new i:Player)
	{
		if(pData[i][pJail] > 0)
		{
			format(line3, sizeof(line3), "%s\n"WHITE_E"%s(ID: %d) [Jail Time: %d seconds]", line3, pData[i][pName], i, pData[i][pJailTime]);
			count++;
		}
	}
	if(count > 0)
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Jail Player", line3, "Close", "");
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Jail Player", "There are no player in jail!", "Close", "");
	}
	return 1;
}

//---------------------------[ Admin Level 1 ]--------------------
CMD:aduty(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	if(!strcmp(pData[playerid][pAdminname], "None"))
		return Error(playerid, "Kamu harus setting Nama Admin mu!");
	
	if(!pData[playerid][pAdminDuty])
    {
		if(pData[playerid][pAdmin] > 0)
		{
			SetPlayerColor(playerid, 0xFF000000);
			pData[playerid][pAdminDuty] = 1;
			SetPlayerName(playerid, pData[playerid][pAdminname]);
			SendStaffMessage(ARWIN, "ADMIN-DUTY: "RED"%s "YELLOW"telah on duty sebagai admin.", pData[playerid][pAdminname]);
		}
		else
		{
			SetPlayerColor(playerid, COLOR_GREEN);
			pData[playerid][pAdminDuty] = 1;
			SetPlayerName(playerid, pData[playerid][pAdminname]);
			SendStaffMessage(ARWIN, "ADMIN-DUTY: "GREEN"%s "YELLOW"telah on duty sebagai helper.", pData[playerid][pAdminname]);
		}
    }
    else
    {
        if(pData[playerid][pFaction] != -1 && pData[playerid][pOnDuty]) 
            SetFactionColor(playerid);
        else 
            SetPlayerColor(playerid, COLOR_WHITE);
                
        SetPlayerName(playerid, pData[playerid][pName]);
        pData[playerid][pAdminDuty] = 0;
        SendStaffMessage(ARWIN, "ADMIN-DUTY: "GRAY"%s "YELLOW"telah off duty sebagai admin.", pData[playerid][pAdminname]);
    }
	return 1;
}

CMD:asay(playerid, params[]) 
{
    new text[225];

    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

    if(sscanf(params,"s[225]",text))
        return Usage(playerid, "/asay [text]");
        
    SendClientMessageToAllEx(X11_TOMATO,"{ff0000}**[STAFF]** (%s{ff0000}) "YELLOW_E"%s: "LG_E"%s", GetStaffRank(playerid), pData[playerid][pAdminname], ColouredText(text));
    return 1;
}

CMD:h(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/h <text>");
	    return true;
	}

    // Decide about multi-line msgs
	new i = -1;
	new line[512];
	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		// store the second line text
		line = " ";
		strcat(line, params[i]);

		// delete the rest from msg
		params[i] = EOS;
	}
	new mstr[512];
	format(mstr, sizeof(mstr), "{1e90ff}[Helper Chat] (%s{1e90ff}) "WHITEP_E"%s(%i): {ffffff}%s", GetStaffRank(playerid), pData[playerid][pAdminname], playerid, params);
	foreach(new ii : Player) 
	{
		if(pData[ii][pAdmin] > 0 || pData[ii][pHelper] == 1)
		{
			SendClientMessage(ii, COLOR_LB, mstr);	
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(pData[ii][pAdmin] > 0 || pData[ii][pHelper] == 1)
			{
				SendClientMessage(ii, COLOR_LB, line);
			}
		}
	}
	return 1;
}

CMD:a(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/a <text>");
	    return true;
	}

    // Decide about multi-line msgs
	new i = -1;
	new line[512];
	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		// store the second line text
		line = " ";
		strcat(line, params[i]);

		// delete the rest from msg
		params[i] = EOS;
	}
	new mstr[512];
	format(mstr, sizeof(mstr), "* %s %s(%i): %s", GetStaffRank(playerid), pData[playerid][pAdminname], playerid, params);
	foreach(new ii : Player) 
	{
		if(pData[ii][pAdmin] > 0)
		{
			SendClientMessage(ii, X11_GREEN, mstr);	
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(pData[ii][pAdmin] > 0)
			{
				SendClientMessage(ii, X11_GREEN, line);
			}
		}
	}
	return true;
}

CMD:togooc(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
        return PermissionError(playerid);

    if(TogOOC == 0)
    {
        SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s has disabled global OOC chat.", pData[playerid][pAdminname]);
        TogOOC = 1;
    }
    else
    {
        SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s has enabled global OOC chat (DON'T SPAM).", pData[playerid][pAdminname]);
        TogOOC = 0;
    }
    return 1;
}

CMD:o(playerid, params[])
{
    if(TogOOC == 1 && pData[playerid][pAdmin] < 1 && pData[playerid][pHelper] < 1) 
            return Error(playerid, "An administrator has disabled global OOC chat.");

    if(isnull(params))
        return Usage(playerid, "/o [global OOC]");

    /*if(pData[playerid][pDisableOOC])
        return Error(playerid, "You must enable OOC chat first.");*/

    if(strlen(params) < 90)
    {
        foreach (new i : Player) if(pData[i][IsLoggedIn] == true && pData[i][pSpawned] == 1)
        {
            if(pData[playerid][pAdmin] == 1) SendClientMessageEx(i, COLOR_WHITE, "(( {FF0000}[MODERATOR] %s{FFFFFF}: %s {FFFFFF}))", pData[playerid][pAdminname], ColouredText(params));
            else if(pData[playerid][pAdmin] == 2) SendClientMessageEx(i, COLOR_WHITE, "(( {FF0000}[ADMIN JR] %s{FFFFFF}: %s {FFFFFF}))", pData[playerid][pAdminname], ColouredText(params));
            else if(pData[playerid][pAdmin] == 3) SendClientMessageEx(i, COLOR_WHITE, "(( {FF0000}[ADMIN] %s{FFFFFF}: %s {FFFFFF}))", pData[playerid][pAdminname], ColouredText(params));
            else if(pData[playerid][pAdmin] == 4) SendClientMessageEx(i, COLOR_WHITE, "(( {FF0000}[ADMIN SR] %s{FFFFFF}: %s {FFFFFF}))", pData[playerid][pAdminname], ColouredText(params));
            else if(pData[playerid][pAdmin] == 5) SendClientMessageEx(i, COLOR_WHITE, "(( {FF0000}[HEAD ADMIN] %s{FFFFFF}: %s {FFFFFF}))", pData[playerid][pAdminname], ColouredText(params));
            else if(pData[playerid][pAdmin] == 6) SendClientMessageEx(i, COLOR_WHITE, "(( {FF0000}[CEO] %s{FFFFFF}: %s {FFFFFF}))", pData[playerid][pAdminname], ColouredText(params));
			else if(pData[playerid][pHelper] > 0 && pData[playerid][pAdmin] == 0)
			{
				SendClientMessageEx(i, COLOR_WHITE, "(( {00FF00}[HELPER] %s{FFFFFF}: %s {FFFFFF}))", pData[playerid][pAdminname], ColouredText(params));
			}
            else
            {
                SendClientMessageEx(i, COLOR_WHITE, "(( {33FFCC}Player %s{FFFFFF} (%d): %s ))", pData[playerid][pName], playerid, params);
            }
        }
    }
    else
        return Error(playerid, "The text to long, maximum character is 90");

    return 1;
}

CMD:id(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
	
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/id [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "No player online or name is not found!");
	
	Servers(playerid, "Name: %s(ID: %d)", pData[otherid][pName], otherid);
	return 1;
}

CMD:goto(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/goto [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SendPlayerToPlayer(playerid, otherid);
	Servers(otherid, ""YELLOW"%s "WHITE"has been teleported to you.", pData[playerid][pName]);
	Servers(playerid, "You has teleport to "YELLOW"%s "WHITE"position.", pData[otherid][pName]);
	return 1;
}

CMD:sendto(playerid, params[])
{
    static
        type[24],
		otherid;

    if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

    if(sscanf(params, "us[32]", otherid, type))
    {
        Usage(playerid, "/send [player] [name]");
        Info(playerid, "[NAMES]:{FFFFFF} ls, lv, sf, ooczone");
        return 1;
    }
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(!strcmp(type,"ls")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),1482.0356,-1724.5726,13.5469);
        }
        else 
		{
            SetPlayerPosition(otherid,1482.0356,-1724.5726,13.5469,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player %s telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin %s telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
    }
    else if(!strcmp(type,"sf")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),-1425.8307,-292.4445,14.1484);
        }
        else 
		{
            SetPlayerPosition(otherid,-1425.8307,-292.4445,14.1484,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player "YELLOW"%s "WHITE"telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin "YELLOW"%s "WHITE"telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
    }
    else if(!strcmp(type,"lv")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		{
            SetVehiclePos(GetPlayerVehicleID(otherid),1686.0118,1448.9471,10.7695);
        }
        else 
		{
            SetPlayerPosition(otherid,1686.0118,1448.9471,10.7695,750);
        }
        SetPlayerFacingAngle(otherid,179.4088);
        SetPlayerInterior(otherid, 0);
        SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player "YELLOW"%s "WHITE"telah berhasil di teleport", pData[otherid][pName]);
		Servers(otherid, "Admin "YELLOW"%s "WHITE"telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = -1;
		pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
    }
    else if(!strcmp(type,"ooczone")) 
	{
        if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER) 
		        return Error(playerid, "Pemain tersebut sedang menggunakan kendaraan");

		SetPlayerPosition(otherid,2183.71, -1017.67, 1020.63,750);
		SetPlayerFacingAngle(otherid,179.4088);
		SetPlayerInterior(otherid, 1);
		SetPlayerVirtualWorld(otherid, 0);
		Servers(playerid, "Player "YELLOW"%s "WHITE"telah berhasil di teleport", pData[otherid][pName]);
	    Servers(otherid, "Admin "YELLOW"%s "WHITE"telah mengirim anda ke teleport spawn", pData[playerid][pAdminname]);
		pData[otherid][pInDoor] = 1;
	    pData[otherid][pInHouse] = -1;
		pData[otherid][pInBiz] = -1;
    }
    return 1;
}

CMD:gethere(playerid, params[])
{
    new otherid;

	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/gethere [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "The specified user(s) are not connected.");
	
	if(pData[playerid][pSpawned] == 0 || pData[otherid][pSpawned] == 0)
		return Error(playerid, "Player/Target sedang tidak spawn!");
		
	if(pData[playerid][pJail] > 0 || pData[otherid][pJail] > 0)
		return Error(playerid, "Player/Target sedang di jail");
		
	if(pData[playerid][pArrest] > 0 || pData[otherid][pArrest] > 0)
		return Error(playerid, "Player/Target sedang di arrest");

	if(pData[playerid][pAdmin] < pData[otherid][pAdmin] > 0)
		return Error(playerid, "Anda tidak dapat menarik Admin dengan level paling tinggi");

    SendPlayerToPlayer(otherid, playerid);

    Servers(playerid, "Anda menarik "YELLOW"%s.", pData[otherid][pName]);
    Servers(otherid, ""YELLOW"%s "WHITE"telah menarik mu.", pData[playerid][pName]);
    return 1;
}

CMD:freeze(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/freeze [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    pData[playerid][pFreeze] = 1;

    TogglePlayerControllable(otherid, 0);
    Servers(playerid, "You have frozen "YELLOW"%s's "WHITE"movements.", ReturnName(otherid));
	Servers(otherid, "You have been frozen movements by admin "YELLOW"%s.", pData[playerid][pAdminname]);
    return 1;
}

CMD:unfreeze(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/unfreeze [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    pData[playerid][pFreeze] = 0;

    TogglePlayerControllable(otherid, 1);
    Servers(playerid, "You have unfrozen "YELLOW"%s's "WHITE"movements.", ReturnName(otherid));
	Servers(otherid, "You have been unfrozen movements by admin "YELLOW"%s.", pData[playerid][pAdminname]);
    return 1;
}

CMD:arevive(playerid, params[])
{

    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/arevive [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(!pData[otherid][pInjured])
        return Error(playerid, "Tidak bisa revive karena tidak injured.");

    SetPlayerHealthEx(otherid, 100.0);
    pData[otherid][pInjured] = 0;
	pData[otherid][pHospital] = 0;
	pData[otherid][pSick] = 0;

    ClearAnimations(otherid);

    SendStaffMessage(X11_TOMATO, "AdmCmd: Staff %s have revived player %s.", pData[playerid][pAdminname], ReturnName(otherid));
    Info(otherid, "Staff %s has revived your character.", pData[playerid][pAdminname]);
    return 1;
}

CMD:spec(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);

    if(!isnull(params) && !strcmp(params, "off", true))
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
            return Error(playerid, "You are not spectating any player.");

		pData[pData[playerid][pSpec]][playerSpectated]--;
        PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);
        PlayerSpectateVehicle(playerid, INVALID_VEHICLE_ID);

        SetSpawnInfo(playerid, 0, pData[playerid][pSkin], pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ], pData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
        TogglePlayerSpectating(playerid, false);
		pData[playerid][pSpec] = -1;

        return Servers(playerid, "You are no longer in spectator mode.");
    }
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/spectate [playerid/PartOfName] - Type '/spec off' to stop spectating.");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	if(otherid == playerid)
		return Error(playerid, "You can't spectate yourself bro..");

    if(pData[playerid][pAdmin] < pData[otherid][pAdmin])
        return Error(playerid, "You can't spectate admin higher than you.");
		
	if(pData[otherid][pSpawned] == 0)
	{
	    Error(playerid, "%s(%i) isn't spawned!", pData[otherid][pName], otherid);
	    return true;
	}

    if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
    {
        GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
        GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);

        pData[playerid][pInt] = GetPlayerInterior(playerid);
        pData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
    }
    SetPlayerInterior(playerid, GetPlayerInterior(otherid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(otherid));

    TogglePlayerSpectating(playerid, 1);

    if(IsPlayerInAnyVehicle(otherid))
	{
		new vID = GetPlayerVehicleID(otherid);
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(otherid));
		if(GetPlayerState(otherid) == PLAYER_STATE_DRIVER)
	    {
	    	Servers(playerid, "You are now spectating "YELLOW"%s(%i) "WHITE"who is driving a "YELLOW"%s(%d).", pData[otherid][pName], otherid, GetVehicleModelName(GetVehicleModel(vID)), vID);
		}
		else
		{
		    Servers(playerid, "You are now spectating "YELLOW"%s(%i) "WHITE"who is a passenger in "YELLOW"%s(%d).", pData[otherid][pName], otherid, GetVehicleModelName(GetVehicleModel(vID)), vID);
		}
	}
    else
	{
        PlayerSpectatePlayer(playerid, otherid);
	}
	pData[otherid][playerSpectated]++;
    SendStaffMessage(X11_TOMATO, "AdmCmd: %s now spectating %s (ID: %d).", pData[playerid][pAdminname], pData[otherid][pName], otherid);
    Servers(playerid, "You are now spectating "YELLOW"%s (ID: %d).", pData[otherid][pName], otherid);
    pData[playerid][pSpec] = otherid;
    return 1;
}

CMD:slap(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new Float:POS[3], otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/slap <ID>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	SetPlayerPos(otherid, POS[0], POS[1], POS[2] + 9.0);
	if(IsPlayerInAnyVehicle(otherid)) 
	{
		RemovePlayerFromVehicle(otherid);
		//OnPlayerExitVehicle(otherid, GetPlayerVehicleID(otherid));
	}
	SendStaffMessage(X11_TOMATO, "AdmCmd: Admin %s telah men-slap player %s", pData[playerid][pAdminname], pData[otherid][pName]);

	PlayerPlaySound(otherid, 1130, 0.0, 0.0, 0.0);
	return 1;
}

CMD:caps(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new otherid;
 	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/caps <ID>");
	    Info(playerid, "Function: Will disable caps for the player, type again to enable caps.");
	    return 1;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(!GetPVarType(otherid, "Caps"))
	{
	    // Disable Caps
	    SetPVarInt(otherid, "Caps", 1);
		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s telah menon-aktifkan anti caps kepada player %s", pData[playerid][pAdminname], pData[playerid][pName]);
	}
	else
	{
	    // Enable Caps
		DeletePVar(otherid, "Caps");
		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s telah meng-aktifkan anti caps kepada player %s", pData[playerid][pAdminname], pData[playerid][pName]);
	}
	return 1;
}

CMD:peject(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/peject <ID>");
	    return 1;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(!IsPlayerInAnyVehicle(otherid))
	{
		Error(playerid, "Player tersebut tidak berada dalam kendaraan!");
		return 1;
	}

	new vv = GetVehicleModel(GetPlayerVehicleID(otherid));
	Servers(playerid, "You have successfully ejected "YELLOW"%s(%i) "WHITE"from their "YELLOW"%s.", pData[otherid][pName], otherid, GetVehicleModelName(vv - 400));
	Servers(otherid, ""YELLOW"%s(%i) "WHITE"has ejected you from your "YELLOW"%s.", pData[playerid][pName], playerid, GetVehicleModelName(vv));
	RemovePlayerFromVehicle(otherid);
	return 1;
}

CMD:aitems(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
			
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/aitems [playerid/PartOfName]");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][IsLoggedIn] == false)
        return Error(playerid, "That player is not logged in yet.");
		
	DisplayItems(playerid, otherid);
	return 1;
}

CMD:astats(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/astats [playerid/PartOfName]");
		
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][IsLoggedIn] == false)
        return Error(playerid, "That player is not logged in yet.");

	DisplayStats(playerid, otherid);
	return 1;
}

CMD:checkucp(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);

	new name[32];
	if(sscanf(params, "s[32]", name)) return Usage(playerid, "/checkucp [ucp name]");

	new query[596];
	mysql_format(g_SQL, query, sizeof(query), "SELECT `username` FROM `players` WHERE `ucp`='%e'", name);
	mysql_tquery(g_SQL, query, "CheckUCP", "ds", playerid, name);
	return 1;
}

CMD:ostats(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 2)
			return PermissionError(playerid);
			
	new name[24], PlayerName[24];
	if(sscanf(params, "s[24]", name))
	{
	    Usage(playerid, "/ostats <player name>");
 		return 1;
 	}

 	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

		if(!strcmp(PlayerName, name, true))
		{
			Error(playerid, "Player is online, you can use /stats on them.");
	  		return 1;
	  	}
	}

	// Load User Data
    new cVar[500];
    new cQuery[600];

	strcat(cVar, "email,admin,helper,level,levelup,vip,vip_time,gold,reg_date,last_login,money,bmoney,brek,hours,minutes,seconds,");
	strcat(cVar, "gender,age,faction,family,warn,job,job2,interior,world");

	mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT %s FROM players WHERE username='%e' LIMIT 1", cVar, name);
	mysql_tquery(g_SQL, cQuery, "LoadStats", "is", playerid, name);
	return true;
}

CMD:acuff(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid, mstr[128];		
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/acuff [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    //if(otherid == playerid)
        //return Error(playerid, "You cannot handcuff yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

    if(GetPlayerState(otherid) != PLAYER_STATE_ONFOOT)
        return Error(playerid, "The player must be onfoot before you can cuff them.");

    if(pData[otherid][pCuffed])
        return Error(playerid, "The player is already cuffed at the moment.");

    pData[otherid][pCuffed] = 1;
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_CUFFED);

    format(mstr, sizeof(mstr), "You've been ~r~cuffed~w~ by %s.", pData[playerid][pName]);
    InfoTD_MSG(otherid, 3500, mstr);

    Servers(playerid, "Player "YELLOW"%s "WHITE"telah berhasil di cuffed.", pData[otherid][pName]);
    Servers(otherid, "Admin "YELLOW"%s "WHITE"telah mengcuffed anda.", pData[playerid][pName]);
    return 1;
}

CMD:auncuff(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new otherid;		
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/auncuff [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    //if(otherid == playerid)
        //return Error(playerid, "You cannot uncuff yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

    if(!pData[otherid][pCuffed])
        return Error(playerid, "The player is not cuffed at the moment.");

    static
        string[64];

    pData[otherid][pCuffed] = 0;
    SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

    format(string, sizeof(string), "You've been ~g~uncuffed~w~ by %s.", pData[playerid][pName]);
    InfoTD_MSG(otherid, 3500, string);
	Servers(playerid, "Player "YELLOW"%s "WHITE"telah berhasil uncuffed.", pData[otherid][pName]);
    Servers(otherid, "Admin "YELLOW"%s "WHITE"telah uncuffed tangan anda.", pData[playerid][pName]);
    return 1;
}

CMD:jetpack(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);
			
	new otherid;		
    if(sscanf(params, "u", otherid))
    {
        //pData[playerid][pJetpack] = 1;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    }
    else
    {
        //pData[playerid][pJetpack] = 1;
        SetPlayerSpecialAction(otherid, SPECIAL_ACTION_USEJETPACK);
        Servers(playerid, "You have spawned a jetpack for "YELLOW"%s.", pData[otherid][pName]);
    }
    return 1;
}

CMD:getip(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
		
	new otherid, PlayerIP[16], giveplayer[24];
	if(sscanf(params, "u", otherid))
 	{
  		Usage(playerid, "/getip <ID>");
		return 1;
	}
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	if(pData[otherid][pAdmin] == 5)
 	{
  		Error(playerid, "You can't get the server owners ip!");
  		Servers(otherid, ""YELLOW"%s(%i) "WHITE"tried to get your IP!", pData[playerid][pName], playerid);
  		return 1;
    }
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	Servers(playerid, "%s(%i)'s IP: %s", giveplayer, otherid, PlayerIP);
	return 1;
}

CMD:aka(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
	new otherid, PlayerIP[16], query[128];
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/aka <ID/Name>");
	    return true;
	}
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	if(pData[otherid][pAdmin] == 5)
 	{
  		Error(playerid, "You can't AKA the server owner!");
  		Servers(otherid, ""YELLOW"%s(%i) "WHITE"tried to AKA you!", pData[playerid][pName], playerid);
  		return 1;
    }
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE IP='%s'", PlayerIP);
	mysql_tquery(g_SQL, query, "CheckPlayerIP", "is", playerid, PlayerIP);
	return true;
}

CMD:akaip(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);
	new query[128];
	if(isnull(params))
	{
	    Usage(playerid, "/akaip <IP>");
		return true;
	}

	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE IP='%s'", params);
	mysql_tquery(g_SQL, query, "CheckPlayerIP2", "is", playerid, params);
	return true;
}

CMD:vmodels(playerid, params[])
{
    new string[3500];

    if(pData[playerid][pAdmin] < 1)
     	return PermissionError(playerid);

    for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
    {
        format(string,sizeof(string), "%s%d - %s\n", string, i+400, g_arrVehicleNames[i]);
    }
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, "Vehicle Models", string, "Close", "");
    return 1;
}

CMD:vehname(playerid, params[]) {

	if(pData[playerid][pAdmin] >= 1) 
	{
		SendClientMessageEx(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------------------------------------------------------------");
		SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle Search:");

		new
			string[128];

		if(isnull(params)) return Error(playerid, "No keyword specified.");
		if(!params[2]) return Error(playerid, "Search keyword too short.");

		for(new v; v < sizeof(g_arrVehicleNames); v++) 
		{
			if(strfind(g_arrVehicleNames[v], params, true) != -1) {

				if(isnull(string)) format(string, sizeof(string), "%s (ID %d)", g_arrVehicleNames[v], v+400);
				else format(string, sizeof(string), "%s | %s (ID %d)", string, g_arrVehicleNames[v], v+400);
			}
		}

		if(!string[0]) Error(playerid, "No results found.");
		else if(string[127]) Error(playerid, "Too many results found.");
		else SendClientMessageEx(playerid, COLOR_WHITE, string);

		SendClientMessageEx(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------------------------------------------------------------");
	}
	else
	{
		PermissionError(playerid);
	}
	return 1;
}

CMD:owarn(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);
	
	new player[24], tmp[50], PlayerName[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]s[50]", player, tmp))
		return Usage(playerid, "/owarn <name> <reason>");

	if(strlen(tmp) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");

	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			Error(playerid, "Player is online, you can use /warn on him.");
	  		return 1;
	  	}
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id,warn FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OWarnPlayer", "iss", playerid, player, tmp);
	return 1;
}

function OWarnPlayer(adminid, NameToWarn[], warnReason[])
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account {ffff00}'%s' "WHITE_E"does not exist.", NameToWarn);
	}
	else
	{
	    new RegID, warn;
		cache_get_value_index_int(0, 0, RegID);
		cache_get_value_index_int(0, 1, warn);
		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s telah memberi warning(offline) player %s. [Reason: %s]", pData[adminid][pAdminname], NameToWarn, warnReason);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET warn=%d WHERE reg_id=%d", warn+1, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

CMD:ojail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
	    return PermissionError(playerid);

	new player[24], datez, tmp[50], PlayerName[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]ds[50]", player, datez, tmp))
		return Usage(playerid, "/ojail <name> <time in minutes)> <reason>");

	if(strlen(tmp) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");
	if(datez < 1 || datez > 60)
	{
 		if(pData[playerid][pAdmin] < 5)
   		{
			Error(playerid, "Jail time must remain between 1 and 60 minutes");
  			return 1;
   		}
	}
	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			Error(playerid, "Player is online, you can use /jail on him.");
	  		return 1;
	  	}
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OJailPlayer", "issi", playerid, player, tmp, datez);
	return 1;
}

function OJailPlayer(adminid, NameToJail[], jailReason[], jailTime)
{
	if(cache_num_rows() < 1)
	{
		return Error(adminid, "Account {ffff00}'%s' "WHITE_E"does not exist.", NameToJail);
	}
	else
	{
	    new RegID, JailMinutes = jailTime * 60;
		cache_get_value_index_int(0, 0, RegID);

		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s telah menjail(offline) player %s selama %d menit. [Reason: %s]", pData[adminid][pAdminname], NameToJail, jailTime, jailReason);
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET jail=%d WHERE reg_id=%d", JailMinutes, RegID);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

CMD:jail(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);

	new reason[60], timeSec, otherid;
	if(sscanf(params, "uD(15)S(*)[60]", otherid, timeSec, reason))
	{
	    Usage(playerid, "/jail <ID/Name> <time in minutes> <reason>)");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][pJail] > 0)
	{
	    Servers(playerid, ""YELLOW"%s(%i) "WHITE"is already jailed "YELLOW"(gets out in %d minutes)", pData[otherid][pName], otherid, pData[otherid][pJailTime]);
	    Info(playerid, "/unjail <ID/Name> to unjail.");
	    return true;
	}
	if(pData[otherid][pSpawned] == 0)
	{
	    Error(playerid, "%s(%i) isn't spawned!", pData[otherid][pName], otherid);
	    return true;
	}
	if(reason[0] != '*' && strlen(reason) > 60)
	{
	 	Error(playerid, "Reason too long! Must be smaller than 60 characters!");
	   	return true;
	}
	if(timeSec < 1 || timeSec > 60)
	{
	    if(pData[playerid][pAdmin] < 5)
	 	{
			Error(playerid, "Jail time must remain between 1 and 60 minutes");
	    	return 1;
	  	}
	}
	pData[otherid][pJail] = 1;
	pData[otherid][pJailTime] = timeSec * 60;
	JailPlayer(otherid);
	if(reason[0] == '*')
	{
		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s telah menjail player %s selama %d menit.", pData[playerid][pAdminname], pData[otherid][pName], timeSec);
	}
	else
	{
		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s telah menjail player %s selama %d menit. {ffff00}[Reason: %s]", pData[playerid][pAdminname], pData[otherid][pName], timeSec, reason);
	}
	return 1;
}


CMD:unjail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] < 2)
     		return PermissionError(playerid);

	new otherid;
	if(sscanf(params, "u", otherid))
	{
	    Usage(playerid, "/unjail <ID/Name>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	if(pData[otherid][pJail] == 0)
	    return Error(playerid, "The player isn't in jail!");

	pData[otherid][pJail] = 0;
	pData[otherid][pJailTime] = 0;
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SetPlayerPos(otherid, 1529.6,-1691.2,13.3);
	SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

	SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s telah unjailed %s", pData[playerid][pAdminname], pData[otherid][pName]);
	return true;
}

CMD:kick(playerid, params[])
{
    static
        reason[128];

	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);
			
	new otherid;
    if(sscanf(params, "us[128]", otherid, reason))
        return Usage(playerid, "/kick [playerid/PartOfName] [reason]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
        return Error(playerid, "The specified player has higher authority.");

    SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: %s was kicked by admin %s. Reason: %s.", pData[otherid][pName], pData[playerid][pAdminname], reason);
    //Log_Write("logs/kick_log.txt", "[%s] %s has kicked %s for: %s.", ReturnTime(), ReturnName(otherid, 0), ReturnName(otherid, 0), reason);
	//SetPlayerPosition(otherid, 227.46, 110.0, 999.02, 360.0000, 10);
    KickEx(otherid);
    return 1;
}

CMD:ban(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);

	new ban_time, datez, tmp[60], otherid;
	if(sscanf(params, "uds[60]", otherid, datez, tmp))
	{
	    Usage(playerid, "/tempban <ID/Name> <time (in days) 0 for permanent> <reason> ");
	    return true;
	}
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
 	if(datez < 0) Error(playerid, "Please input a valid ban time.");
	if(pData[playerid][pAdmin] < 2)
	{
		if(datez > 10 || datez <= 0) return Error(playerid, "Anda hanya dapat membanned selama 1-10 hari!");
	}
	/*if(otherid == playerid)
	    return Error(playerid, "You are not able to ban yourself!");*/
	if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
	{
		Servers(otherid, ""YELLOW"%s(%i) "WHITE"has just tried to ban you!", pData[playerid][pName], playerid);
 		Error(playerid, "You are not able to ban a admin with a higher level than you!");
 		return true;
   	}
	new PlayerIP[16], giveplayer[24];
	
   	//SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	if(!strcmp(tmp, "ab", true)) tmp = "Airbreak";
	else if(!strcmp(tmp, "ad", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "ads", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "hh", true)) tmp = "Health Hacks";
	else if(!strcmp(tmp, "wh", true)) tmp = "Weapon Hacks";
	else if(!strcmp(tmp, "sh", true)) tmp = "Speed Hacks";
	else if(!strcmp(tmp, "mh", true)) tmp = "Money Hacks";
	else if(!strcmp(tmp, "rh", true)) tmp = "Ram Hacks";
	else if(!strcmp(tmp, "ah", true)) tmp = "Ammo Hacks";
	if(datez != 0)
	{
		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s telah membanned player %s selama %d hari. {ffff00}[Reason: %s]", pData[playerid][pAdminname], giveplayer, datez, tmp);
	}
	else
	{
		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s telah membanned permanent player %s. {ffff00}[Reason: %s]", pData[playerid][pAdminname], giveplayer, tmp);
	}
	//SetPlayerPosition(otherid, 227.46, 110.0, 999.02, 360.0000, 10);
	BanPlayerMSG(otherid, playerid, tmp);
 	if(datez != 0)
    {
		Servers(otherid, "This is a "RED_E"TEMP-BAN {ffff00}that will last for %d days.", datez);
		ban_time = gettime() + (datez * 86400);
	}
	else
	{
		Servers(otherid, "This is a "RED_E"Permanent Banned {ffff00}please contack admin for unbanned!.", datez);
		ban_time = datez;
	}
	new query[248];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', '%s', '%s', %i, %d)", giveplayer, PlayerIP, pData[playerid][pAdminname], tmp, gettime(), ban_time);
	mysql_tquery(g_SQL, query);
	KickEx(otherid);
	return true;
}

CMD:unban(playerid, params[])
{
   	if(pData[playerid][pAdmin] < 1)
			return PermissionError(playerid);
	
	new tmp[24];
	if(sscanf(params, "s[24]", tmp))
	{
	    Usage(playerid, "/unban <ban name>");
	    return true;
	}
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT name,ip FROM banneds WHERE name = '%e'", tmp);
	mysql_tquery(g_SQL, query, "OnUnbanQueryData", "is", playerid, tmp);
	return 1;
}

function OnUnbanQueryData(adminid, BannedName[])
{
	if(cache_num_rows() > 0)
	{
		new banIP[16], query[128];
		cache_get_value_name(0, "ip", banIP);
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM banneds WHERE ip = '%s'", banIP);
		mysql_tquery(g_SQL, query);

		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: %s(%i) has unbanned %s from the server.", pData[adminid][pAdminname], adminid, BannedName);
	}
	else
	{
		Error(adminid, "No player named '%s' found on the ban list.", BannedName);
	}
	return 1;
}

CMD:warn(playerid, params[])
{
    static
        reason[32];

    if(pData[playerid][pAdmin] < 1)
        if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "us[32]", otherid, reason))
        return Usage(playerid, "/warn [playerid/PartOfName] [reason]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(pData[otherid][pAdmin] > pData[playerid][pAdmin])
        return Error(playerid, "The specified player has higher authority.");

	pData[otherid][pWarn]++;
	SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s telah memberikan warning kepada player %s. [Reason: %s] [Total Warning: %d/20]", pData[playerid][pAdminname], pData[otherid][pName], reason, pData[otherid][pWarn]);
    return 1;
}

CMD:unwarn(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/unwarn [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    pData[otherid][pWarn] -= 1;
    Servers(playerid, "You have unwarned 1 point "YELLOW"%s's "WHITE"warnings.", pData[otherid][pName]);
	Servers(otherid, ""YELLOW"%s "WHITE"has unwarned 1 point your warnings.", pData[playerid][pAdminname]);
    SendStaffMessage(X11_TOMATO, "AdmCmd: Admin %s has unwarned 1 point to %s's warnings.", pData[playerid][pAdminname], pData[otherid][pName]);
    return 1;
}

CMD:respawnsapd(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
			
	for(new x;x<sizeof(SAPDVehicles);x++)
	{
		if(IsVehicleEmpty(SAPDVehicles[x]))
		{
			SetVehicleToRespawn(SAPDVehicles[x]);
			SetValidVehicleHealth(SAPDVehicles[x], 2000);
			SetVehicleFuel(SAPDVehicles[x], 1000);
			SwitchVehicleDoors(SAPDVehicles[x], false);
		}
	}
	SendStaffMessage(X11_TOMATO, "AdmCmd: %s has respawned SAPD vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnsags(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
			
	for(new x;x<sizeof(SAGSVehicles);x++)
	{
		if(IsVehicleEmpty(SAGSVehicles[x]))
		{
			SetVehicleToRespawn(SAGSVehicles[x]);
			SetValidVehicleHealth(SAGSVehicles[x], 2000);
			SetVehicleFuel(SAGSVehicles[x], 1000);
			SwitchVehicleDoors(SAGSVehicles[x], false);
		}
	}
	SendStaffMessage(X11_TOMATO, "AdmCmd: %s has respawned SAGS vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnsamd(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
			
	for(new x;x<sizeof(SAMDVehicles);x++)
	{
		if(IsVehicleEmpty(SAMDVehicles[x]))
		{
			SetVehicleToRespawn(SAMDVehicles[x]);
			SetValidVehicleHealth(SAMDVehicles[x], 2000);
			SetVehicleFuel(SAMDVehicles[x], 1000);
			SwitchVehicleDoors(SAMDVehicles[x], false);
		}
	}
	SendStaffMessage(X11_TOMATO, "AdmCmd: %s has respawned SAMD vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnsana(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
			
	for(new x;x<sizeof(SANAVehicles);x++)
	{
		if(IsVehicleEmpty(SANAVehicles[x]))
		{
			SetVehicleToRespawn(SANAVehicles[x]);
			SetValidVehicleHealth(SANAVehicles[x], 2000);
			SetVehicleFuel(SANAVehicles[x], 1000);
			SwitchVehicleDoors(SANAVehicles[x], false);
		}
	}
	SendStaffMessage(X11_TOMATO, "AdmCmd: Admin %s has respawned SANA vehicles.", pData[playerid][pAdminname]);
	return 1;
}

CMD:respawnjobs(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] < 3)
			return PermissionError(playerid);
		
	/*
	for(new x;x<sizeof(SweepVeh);x++)
	{
		if(IsVehicleEmpty(SweepVeh[x]))
		{
			SetVehicleToRespawn(SweepVeh[x]);
			SetValidVehicleHealth(SweepVeh[x], 2000);
			SetVehicleFuel(SweepVeh[x], 1000);
			SwitchVehicleDoors(SweepVeh[x], false);
		}
	}*/
	/*
	for(new xx;xx<sizeof(BusVeh);xx++)
	{
		if(IsVehicleEmpty(BusVeh[xx]))
		{
			SetVehicleToRespawn(BusVeh[xx]);
			SetValidVehicleHealth(BusVeh[xx], 2000);
			SetVehicleFuel(BusVeh[xx], 1000);
			SwitchVehicleDoors(BusVeh[xx], false);
		}
	}*/
	for(new xx;xx<sizeof(ForVeh);xx++)
	{
		if(IsVehicleEmpty(ForVeh[xx]))
		{
			SetVehicleToRespawn(ForVeh[xx]);
			SetValidVehicleHealth(ForVeh[xx], 2000);
			SetVehicleFuel(ForVeh[xx], 1000);
			SwitchVehicleDoors(ForVeh[xx], false);
		}
	}
	SendStaffMessage(X11_TOMATO, "AdmCmd: Admin %s has respawned Jobs vehicles.", pData[playerid][pAdminname]);
	return 1;
}

RespawnNearbyVehicles(playerid, Float:radi)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i=1; i<MAX_VEHICLES; i++)
    {
        if(GetVehicleModel(i))
        {
            new Float:posx, Float:posy, Float:posz;
            new Float:tempposx, Float:tempposy, Float:tempposz;
            GetVehiclePos(i, posx, posy, posz);
            tempposx = (posx - x);
            tempposy = (posy - y);
            tempposz = (posz - z);
            if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
            {
				if(IsVehicleEmpty(i))
				{
					//SetVehicleToRespawn(i);
					SetTimerEx("RespawnPV", 3000, false, "d", i);
					SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s telah merespawn kendaraan disekitar dengan radius %d.", pData[playerid][pAdminname], radi);
					SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Jika kendaraan lumber pribadi anda terkena respawn admin gunakan /v park untuk meload kembali lumber anda!");
				}
			}
        }
    }
}

CMD:respawnrad(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
		
	new rad;
	if(sscanf(params, "d", rad)) return Usage(playerid, "/respawnrad [radius] | respawn vehicle nearest");
	
	if(rad > 50) return Error(playerid, "Maximal 50 radius");
	RespawnNearbyVehicles(playerid, rad);
	return 1;
}

//----------------------------[ Admin Level 2 ]-----------------------
CMD:sethp(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/sethp [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SetPlayerHealthEx(otherid, jumlah);
	SendStaffMessage(X11_TOMATO, "AdmCmd: %s telah men set jumlah hp player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin "RED"%s "WHITE"telah men set hp anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:setbone(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setbone [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	pData[otherid][pHead] = jumlah;
	pData[otherid][pPerut] = jumlah;
	pData[otherid][pLFoot] = jumlah;
	pData[otherid][pRFoot] = jumlah;
	pData[otherid][pLHand] = jumlah;
	pData[otherid][pRHand] = jumlah;
	SendStaffMessage(X11_TOMATO, "AdmCmd: %s telah men set jumlah Kondisi tulang player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin "RED"%s "WHITE"telah men set Kondisi tulang anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:setam(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setam [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(jumlah > 95)
	{
		SetPlayerArmourEx(otherid, 98);
	}
	else
	{
		SetPlayerArmourEx(otherid, jumlah);
	}
	SendStaffMessage(X11_TOMATO, "AdmCmd: %s telah men set jumlah armor player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin "RED"%s "WHITE"telah men set armor anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:afuel(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
     		return PermissionError(playerid);

	if(IsPlayerInAnyVehicle(playerid)) 
	{
		SetVehicleFuel(GetPlayerVehicleID(playerid), 1000);
		Servers(playerid, "Vehicle Fueled!");
	}
	else
	{
		Error(playerid, "Kamu tidak berada didalam kendaraan apapun!");
	}
	return 1;
}

CMD:afix(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
     		return PermissionError(playerid);
	
    if(IsPlayerInAnyVehicle(playerid)) 
	{
		foreach(new i : PVehicles)
		{
		    if(GetPlayerVehicleID(playerid) == pvData[i][cVeh])
		    {
		        if(pvData[i][cBodyUpgrade] == 1)
		        {
					SetVehicleMaxHealth(i);
				}
			}
			else
			{
				SetValidVehicleHealth(GetPlayerVehicleID(playerid), 1000);
			}
		}
		ValidRepairVehicle(GetPlayerVehicleID(playerid));
        Servers(playerid, "Vehicle Fixed!");
    }
	else
	{
		Error(playerid, "Kamu tidak berada didalam kendaraan apapun!");
	}
	return 1;
}

CMD:setjob1(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new
        jobid,
		otherid;
	
	if(sscanf(params, "ud", otherid, jobid))
        return Usage(playerid, "/setjob1 [playerid/PartOfName] [jobid]");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(jobid < 0 || jobid > 7)
        return Error(playerid, "Invalid ID. 0 - 7.");
		
	pData[otherid][pJob] = jobid;
	pData[otherid][pExitJob] = 0;
	
	Servers(playerid, "Anda telah menset job1 player "YELLOW"%s(%d) "WHITE"menjadi "YELLOW"%s(%d).", pData[otherid][pName], otherid, GetJobName(jobid), jobid);
	Servers(otherid, "Admin "RED"%s "WHITE"telah menset job1 anda menjadi "YELLOW"%s(%d)", pData[playerid][pAdminname], GetJobName(jobid), jobid);
	return 1;
}

CMD:setjob2(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new
        jobid,
		otherid;
	
	if(sscanf(params, "ud", otherid, jobid))
        return Usage(playerid, "/setjob2 [playerid/PartOfName] [jobid]");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(jobid < 0 || jobid > 7)
        return Error(playerid, "Invalid ID. 0 - 7.");
		
	pData[otherid][pJob2] = jobid;
	pData[otherid][pExitJob] = 0;
	
	Servers(playerid, "Anda telah menset job2 player "YELLOW"%s(%d) "WHITE"menjadi "YELLOW"%s(%d).", pData[otherid][pName], otherid, GetJobName(jobid), jobid);
	Servers(otherid, "Admin "RED"%s "WHITE"telah menset job2 anda menjadi "YELLOW"%s(%d)", pData[playerid][pAdminname], GetJobName(jobid), jobid);
	return 1;
}

CMD:setskin(playerid, params[])
{
    new
        skinid,
		otherid;

    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, skinid))
        return Usage(playerid, "/skin [playerid/PartOfName] [skin id]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(skinid < 0 || skinid > 299)
        return Error(playerid, "Invalid skin ID. Skins range from 0 to 299.");

    SetPlayerSkin(otherid, skinid);
	pData[otherid][pSkin] = skinid;

    Servers(playerid, "You have set "YELLOW"%s's "WHITE"skin to "YELLOW"ID: %d.", ReturnName(otherid), skinid);
    Servers(otherid, ""YELLOW"%s "WHITE"has set your skin to "YELLOW"ID: %d.", ReturnName(playerid), skinid);
    return 1;
}

CMD:akill(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	new reason[60], otherid;
	if(sscanf(params, "uS(*)[60]", otherid, reason))
	{
	    Usage(playerid, "/akill <ID/Name> <optional: reason>");
	    return 1;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	SetPlayerHealth(otherid, 0.0);

	if(reason[0] != '*')
	{
		SendClientMessageToAllEx(X11_TOMATO, "Servers: {ffff00}Admin %s has killed %s. "GREY_E"[Reason: %s]", pData[playerid][pAdminname], pData[otherid][pName], reason);
	}
	else
	{
		SendClientMessageToAllEx(X11_TOMATO, "Servers: {ffff00}Admin %s has killed %s.", pData[playerid][pAdminname], pData[otherid][pName]);
	}
	return 1;
}

CMD:ann(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

 	if(isnull(params))
    {
	    Usage(playerid, "/announce <msg>");
	    return 1;
	}
	// Check for special trouble-making input
   	if(strfind(params, "~x~", true) != -1)
		return Error(playerid, "~x~ is not allowed in announce.");
	if(strfind(params, "#k~", true) != -1)
		return Error(playerid, "The constant key is not allowed in announce.");
	if(strfind(params, "/q", true) != -1)
		return Error(playerid, "You are not allowed to type /q in announcement!");

	// Count tildes (uneven number = faulty input)
	new iTemp = 0;
	for(new i = (strlen(params)-1); i != -1; i--)
	{
		if(params[i] == '~')
			iTemp ++;
	}
	if(iTemp % 2 == 1)
		return Error(playerid, "You either have an extra ~ or one is missing in the announcement!");
	
	new str[512];
	format(str, sizeof(str), "~w~%s", params);
	GameTextForAll(str, 6500, 3);
	return true;
}

CMD:settime(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	new time, mstr[128];
	if(sscanf(params, "d", time))
	{
		Usage(playerid, "/time <time ID>");
		return true;
	}

	SendClientMessageToAllEx(ARWIN, "TIME: "RED"%s "WHITE"has changed the time to: "LIGHTGREEN"%d", pData[playerid][pAdminname], time);

	format(mstr, sizeof(mstr), "~r~Time changed: ~b~%d", time);
	GameTextForAll(mstr, 3000, 5);

	SetWorldTime(time);
	WorldTime = time;
	foreach(new ii : Player)
	{
		SetPlayerTime(ii, time, 0);
	}
	return 1;
}

CMD:setweather(playerid, params[])
{
    new weatherid;

    if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    if(sscanf(params, "d", weatherid))
        return Usage(playerid, "/setweather [weather ID]");

    SetWeather(weatherid);
	WorldWeather = weatherid;
	foreach(new ii : Player)
	{
		SetPlayerWeather(ii, weatherid);
	}
    SetGVarInt("g_Weather", weatherid);
    SendClientMessageToAllEx(ARWIN,"WEATHER: "RED"%s "WHITE"have changed the weather ID: "LIGHTGREEN"%d", pData[playerid][pAdminname], weatherid);
    Servers(playerid, "You have changed the weather to "YELLOW"ID: %d.", weatherid);
    return 1;
}

CMD:gotoco(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);
		
	new Float: pos[3], int;
	if(sscanf(params, "fffd", pos[0], pos[1], pos[2], int)) return Usage(playerid, "/gotoco [x coordinate] [y coordinate] [z coordinate] [interior]");

	Servers(playerid, "Anda telah terteleportasi ke kordinat tersebut.");
	SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SetPlayerInterior(playerid, int);
	return 1;
}

CMD:cd(playerid)
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
		
	if(Count != -1) return Error(playerid, "There is already a countdown in progress, wait for it to end!");

	Count = 6;
	countTimer = SetTimer("pCountDown", 1000, 1);

	foreach(new ii : Player)
	{
		showCD[ii] = 1;
	}
	SendClientMessageToAllEx(X11_TOMATO, "[SERVER] "LB_E"Admin %s has started a global countdown!", pData[playerid][pAdminname]);
	return 1;
}

//---------------[ Admin Level 3 ]------------
CMD:oban(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
	    return PermissionError(playerid);

	new player[24], datez, reason[50];
	if(sscanf(params, "s[24]D(0)s[50]", player, datez, reason))
	{
	    Usage(playerid, "/oban <ban name> <time in days (0 for permanent ban)> <reason>");
	    Info(playerid, "Will ban a player while he is offline. If time isn't specified it will be a perm ban.");
	    return true;
	}
	if(strlen(reason) > 50) return Error(playerid, "Reason must be shorter than 50 characters.");

	foreach(new ii : Player)
	{
		new PlayerName[24];
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			Error(playerid, "Player is online, you can use /ban on him.");
	  		return true;
	  	}
	}

	new query[128];

	mysql_format(g_SQL, query, sizeof(query), "SELECT ip FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OnOBanQueryData", "issi", playerid, player, reason, datez);
	return true;
}

CMD:banip(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
     	return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/banip <IP Address>");
		return true;
	}
	if(strfind(params, "*", true) != -1 && pData[playerid][pAdmin] != 5)
	{
		Error(playerid, "You are not authorized to ban ranges.");
  		return true;
  	}

	SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s(%d) IP banned address %s.", pData[playerid][pAdminname], playerid, params);
	
	new tstr[128];
	format(tstr, sizeof(tstr), "banip %s", params);
	SendRconCommand(tstr);
	return 1;
}

CMD:unbanip(playerid, params[])
{
    if(pData[playerid][pAdmin] < 2)
     	return PermissionError(playerid);

	if(isnull(params))
	{
	    Usage(playerid, "/unbanip <IP Address>");
		return true;
	}
	new mstr[128];
	format(mstr, sizeof(mstr), "unbanip %s", params);
	SendRconCommand(mstr);
	format(mstr, sizeof(mstr), "reloadbans");
	SendRconCommand(mstr);
	Servers(playerid, "You have unbanned IP address "YELLOW"%s.", params);
	return 1;
}

CMD:reloadweap(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/reloadweps [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    SetWeapons(otherid);
    Servers(playerid, "You have reload "YELLOW"%s's "WHITE"weapons.", pData[otherid][pName]);
    Servers(otherid, "Admin "YELLOW"%s "WHITE"have reload your weapons.", pData[playerid][pAdminname]);
    return 1;
}

CMD:resetweap(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/resetweps [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    ResetPlayerWeaponsEx(otherid);
    Servers(playerid, "You have reset "YELLOW"%s's "WHITE"weapons.", pData[otherid][pName]);
    Servers(otherid, "Admin "YELLOW"%s "WHITE"have reset your weapons.", pData[playerid][pAdminname]);
    return 1;
}

CMD:setlevel(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setlevel [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	pData[otherid][pLevel] = jumlah;
	SetPlayerScore(otherid, jumlah);
	SendStaffMessage(X11_TOMATO, "AdmCmd: %s telah men set jumlah level player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin "RED"%s "WHITE"telah men set level anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:sethbe(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/sethbe [playerid id/name] <jumlah>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	pData[otherid][pHunger] = jumlah;
	pData[otherid][pEnergy] = jumlah;
	pData[otherid][pBladder] = jumlah;
	pData[otherid][pSick] = 0;
	SetPlayerDrunkLevel(playerid, 0);
	SendStaffMessage(X11_TOMATO, "AdmCmd: %s telah men set jumlah hbe player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin "RED"%s "WHITE"telah men set HBE anda", pData[playerid][pAdminname]);
	return 1;
}

//----------------------------[ Admin Level 4 ]---------------
CMD:setname(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
	new otherid, tmp[20];
	if(sscanf(params, "is[20]", otherid, tmp))
	{
	   	Usage(playerid, "/setname <ID/Name> <newname>");
	    return 1;
	}
	if(!IsPlayerConnected(otherid)) return Error(playerid, "Player belum masuk!");
	if(pData[otherid][IsLoggedIn] == false)	return Error(playerid, "That player is not logged in.");
	
	if(strlen(tmp) < 4) return Error(playerid, "New name can't be shorter than 4 characters!");
	if(strlen(tmp) > 20) return Error(playerid, "New name can't be longer than 20 characters!");

	if(!IsValidName(tmp)) return Error(playerid, "Name contains invalid characters, please doublecheck!");
	new query[248];
	mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%s'", tmp);
	mysql_tquery(g_SQL, query, "SetName", "iis", otherid, playerid, tmp);
	return 1;
}


// SetName Callback
function SetName(otherplayer, playerid, nname[])
{
	if(!cache_num_rows())
	{
		new oldname[24], newname[24], query[248];
		GetPlayerName(otherplayer, oldname, sizeof(oldname));
		
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", nname, pData[otherplayer][pID]);
		mysql_tquery(g_SQL, query);
		
		Servers(otherplayer, "Admin "RED"%s "WHITE"telah mengganti nickname anda menjadi (%s)", pData[playerid][pAdminname], nname);
		Info(otherplayer, "Pastikan anda mengingat dan mengganti nickname anda pada saat login kembali!");
		SendStaffMessage(X11_TOMATO, "AdmCmd: Admin %s telah mengganti nickname player %s(%d) menjadi %s", pData[playerid][pAdminname], oldname, otherplayer, nname);
		
		SetPlayerName(otherplayer, nname);
		GetPlayerName(otherplayer, newname, sizeof(newname));
		pData[otherplayer][pName] = newname;
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s' WHERE ID=%d", newname, h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
				House_Save(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s' WHERE ID=%d", newname, b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
				Bisnis_Save(b);
			}
		}
		if(pData[otherplayer][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", newname, oldname);
			mysql_tquery(g_SQL, query);
		}
		/*// Update Family
		if(pGroupRank[otherplayer] == 6)
		{
			format(query, sizeof(query), "UPDATE groups SET gFounder='%s' WHERE gFounder='%s'", newname, oldname);
			MySQL_updateQuery(query);
		}*/
	}
	else
	{
	    // Name Exists
		Error(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
	}
    return 1;
}

function ChangeName(playerid, nname[])
{
	if(!cache_num_rows())
	{
		if(Inventory_Count(playerid, "Gold") < 500) return Error(playerid, "Not enough gold!");
		Inventory_Remove(playerid, "Gold", 500);
		
		new oldname[24], newname[24], query[248];
		GetPlayerName(playerid, oldname, sizeof(oldname));
		
		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET username='%s' WHERE reg_id=%d", nname, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		
		Servers(playerid, "Anda telah mengganti nickname anda menjadi "YELLOW"(%s)", nname);
		Info(playerid, "Pastikan anda mengingat dan mengganti nickname anda pada saat login kembali!");
		SendStaffMessage(X11_TOMATO, "AdmCmd: Player %s(%d) telah mengganti nickname menjadi %s(%d)", oldname, playerid, nname, playerid);
		
		SetPlayerName(playerid, nname);
		GetPlayerName(playerid, newname, sizeof(newname));
		pData[playerid][pName] = newname;
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hData[h][hOwner], oldname, true))
   			{
   			    // Has House
   			    format(hData[h][hOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s' WHERE ID=%d", newname, h);
				mysql_tquery(g_SQL, query);
				House_Refresh(h);
				House_Save(h);
			}
		}
		// Bisnis
		foreach(new b : Bisnis)
		{
			if(!strcmp(bData[b][bOwner], oldname, true))
   			{
   			    // Has Business
   			    format(bData[b][bOwner], 24, "%s", newname);
          		mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s' WHERE ID=%d", newname, b);
				mysql_tquery(g_SQL, query);
				Bisnis_Refresh(b);
				Bisnis_Save(b);
			}
		}
		if(pData[playerid][PurchasedToy] == true)
		{
			mysql_format(g_SQL, query, sizeof(query), "UPDATE toys SET Owner='%s' WHERE Owner='%s'", newname, oldname);
			mysql_tquery(g_SQL, query);
		}
		/*// Update Family
		if(pGroupRank[otherplayer] == 6)
		{
			format(query, sizeof(query), "UPDATE groups SET gFounder='%s' WHERE gFounder='%s'", newname, oldname);
			MySQL_updateQuery(query);
		}*/
	}
	else
	{
	    // Name Exists
		Error(playerid, "The name "DARK_E"'%s' "WHITE_E"already exists in the database, please use a different name!", nname);
		return 1;
	}
    return 1;
}

CMD:setbooster(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
	
	new dayz, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, dayz))
	{
	    Usage(playerid, "/setbooster <ID/Name> <time (in days) 0 for permanent>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	if(dayz < 0)
		return Error(playerid, "Time can't be lower than 0!");
		
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	
	if(pData[playerid][pAdmin] < 5 && dayz > 7)
		return Error(playerid, "Anda hanya bisa menset 1 - 7 hari!");
	
	pData[otherid][pBooster] = 1;
	if(dayz == 0)
	{
		pData[otherid][pBoostTime] = 0;
		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s(%d) telah menset Roleplay Booster kepada %s(%d) ke level permanent time!", pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid);
	}
	else
	{
		pData[otherid][pBoostTime] = gettime() + (dayz * 86400);
		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s(%d) telah menset Roleplay Booster kepada %s(%d) selama %d hari!", pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid, dayz);
	}
	
	format(tmp, sizeof(tmp), "(%d days)", dayz);
	StaffCommandLog("SETBOOSTER", playerid, otherid, tmp);
	return 1;
}

CMD:setvip(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
	
	new alevel, dayz, otherid, tmp[64];
	if(sscanf(params, "udd", otherid, alevel, dayz))
	{
	    Usage(playerid, "/setvip <ID/Name> <level 0 - 3> <time (in days) 0 for permanent>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	if(alevel > 3)
		return Error(playerid, "Level can't be higher than 3!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");
	if(dayz < 0)
		return Error(playerid, "Time can't be lower than 0!");
		
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	
	if(pData[playerid][pAdmin] < 5 && dayz > 7)
		return Error(playerid, "Anda hanya bisa menset 1 - 7 hari!");
	
	pData[otherid][pVip] = alevel;
	if(dayz == 0)
	{
		pData[otherid][pVipTime] = 0;
		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s(%d) telah menset VIP kepada %s(%d) ke level %s permanent time!", pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid, GetVipRank(otherid));
	}
	else
	{
		pData[otherid][pVipTime] = gettime() + (dayz * 86400);
		SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s(%d) telah menset VIP kepada %s(%d) selama %d hari ke level %s!", pData[playerid][pAdminname], playerid, pData[otherid][pName], otherid, dayz, GetVipRank(otherid));
	}
	
	format(tmp, sizeof(tmp), "%d(%d days)", alevel, dayz);
	StaffCommandLog("SETVIP", playerid, otherid, tmp);
	return 1;
}

CMD:giveweap(playerid, params[])
{
    static
        weaponid,
        ammo;
		
	new otherid;
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "udI(250)", otherid, weaponid, ammo))
        return Usage(playerid, "/givewep [playerid/PartOfName] [weaponid] [ammo]");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "You cannot give weapons to disconnected players.");


    if(weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21))
        return Error(playerid, "You have specified an invalid weapon.");

    if(ammo < 1 || ammo > 500)
        return Error(playerid, "You have specified an invalid weapon ammo, 1 - 500");

    GivePlayerWeaponEx(otherid, weaponid, ammo);
    Servers(playerid, "You have give "YELLOW"%s %s "WHITE"with "YELLOW"%d ammo.", pData[otherid][pName], ReturnWeaponName(weaponid), ammo);
    return 1;
}

CMD:setfaction(playerid, params[])
{
	new fid, rank, otherid, tmp[64];
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "udd", otherid, fid, rank))
        return Usage(playerid, "/setfaction [playerid/PartOfName] [1.SAPD, 2.SAGS, 3.SAMD, 4.SANEW] [rank 1-6]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(pData[otherid][pFamily] != -1)
		return Error(playerid, "Player tersebut sudah bergabung family");

    if(fid < 0 || fid > 4)
        return Error(playerid, "You have specified an invalid faction ID 0 - 4.");
		
	if(rank < 1 || rank > 6)
        return Error(playerid, "You have specified an invalid rank 1 - 6.");

	if(fid == 0)
	{
		pData[otherid][pFaction] = 0;
		pData[otherid][pFactionRank] = 0;
		Servers(playerid, "You have removed "YELLOW"%s's "WHITE"from faction.", pData[otherid][pName]);
		Servers(otherid, ""YELLOW"%s "YELLOW"has removed your faction.", pData[playerid][pName]);
	}
	else
	{
		pData[otherid][pFaction] = fid;
		pData[otherid][pFactionRank] = rank;
		Servers(playerid, "You have set "YELLOW"%s's "WHITE"faction "YELLOW"ID %d "WHITE"with rank "YELLOW"%d.", pData[otherid][pName], fid, rank);
		Servers(otherid, ""RED"%s "WHITE"has set your faction ID to "YELLOW"%d "WHITE"with rank "YELLOW"%d.", pData[playerid][pName], fid, rank);
	}
	
	format(tmp, sizeof(tmp), "%d(%d rank)", fid, rank);
	StaffCommandLog("SETFACTION", playerid, otherid, tmp);
    return 1;
}

CMD:setleader(playerid, params[])
{
	new fid, otherid, tmp[64];
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "ud", otherid, fid))
        return Usage(playerid, "/setleader [playerid/PartOfName] [0.None, 1.SAPD, 2.SAGS, 3.SAMD, 4.SANEW]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	if(pData[otherid][pFamily] != -1)
		return Error(playerid, "Player tersebut sudah bergabung family");

    if(fid < 0 || fid > 4)
        return Error(playerid, "You have specified an invalid faction ID 0 - 4.");

	if(fid == 0)
	{
		pData[otherid][pFaction] = 0;
		pData[otherid][pFactionLead] = 0;
		pData[otherid][pFactionRank] = 0;
		Servers(playerid, "You have removed "YELLOW"%s's "WHITE"from faction leader.", pData[otherid][pName]);
		Servers(otherid, ""RED"%s has "WHITE"removed your faction leader.", pData[playerid][pName]);
	}
	else
	{
		pData[otherid][pFaction] = fid;
		pData[otherid][pFactionLead] = fid;
		pData[otherid][pFactionRank] = 6;
		Servers(playerid, "You have set "YELLOW"%s's "WHITE"faction ID "YELLOW"%d "WHITE"with leader.", pData[otherid][pName], fid);
		Servers(otherid, ""RED"%s "WHITE"has set your faction ID to "YELLOW"%d "WHITE"with leader.", pData[playerid][pName], fid);
	}
	
	format(tmp, sizeof(tmp), "%d", fid);
	StaffCommandLog("SETLEADER", playerid, otherid, tmp);
    return 1;
}

CMD:takemoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new money, otherid;
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/takemoney <ID/Name> <amount>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

 	if(money > pData[otherid][pMoney])
		return Error(playerid, "Player doesn't have enough money to deduct from!");

	GivePlayerMoneyEx(otherid, -money);
	SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s(%i) has taken away money "RED_E"%s {ffff00}from %s", pData[playerid][pAdminname], FormatMoney(money), pData[otherid][pName]);
	return true;
}

CMD:takegold(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);
		
	new gold, otherid;
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/takegold <ID/Name> <amount>");
	    return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

 	if(gold > Inventory_Count(playerid, "Gold"))
		return Error(playerid, "Player doesn't have enough gold to deduct from!");

	Inventory_Remove(playerid, "Gold", gold);
	SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: Admin %s(%i) has taken away gold "RED_E"%d {ffff00}from %s", pData[playerid][pAdminname], gold, pData[otherid][pName]);
	return 1;
}

CMD:veh(playerid, params[])
{
    static
        model[32],
        color1,
        color2;

    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if(sscanf(params, "s[32]I(0)I(0)", model, color1, color2))
        return Usage(playerid, "/veh [model id/name] <color 1> <color 2>");

    if((model[0] = GetVehicleModelByName(model)) == 0)
        return Error(playerid, "Invalid model ID.");

    static
        Float:x,
        Float:y,
        Float:z,
        Float:a,
        vehicleid;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    vehicleid = CreateVehicle(model[0], x, y, z, a, color1, color2, 600);

    if(GetPlayerInterior(playerid) != 0)
        LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

    if(GetPlayerVirtualWorld(playerid) != 0)
        SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

    if(IsABoat(vehicleid) || IsAPlane(vehicleid) || IsAHelicopter(vehicleid))
        PutPlayerInVehicle(playerid, vehicleid, 0);

    SetVehicleNumberPlate(vehicleid, "STATIC");
	VehCore[vehicleid][vTemporary] = true;
    Servers(playerid, "Anda memunculkan "YELLOW"%s (%d, %d).", GetVehicleModelName(model[0]), color1, color2);
    return 1;
}

CMD:dveh(playerid)
{
	if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		return Error(playerid, "Anda harus berada di dalam kendaraan");

	if(VehCore[GetPlayerVehicleID(playerid)][vTemporary] == false)
		return Error(playerid, "Kendaran ini bukan kendaraan admin dari /veh");

	DestroyVehicle(GetPlayerVehicleID(playerid));
	VehCore[GetPlayerVehicleID(playerid)][vTemporary] = false;
	return 1;

}

CMD:agl(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
	
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/agl [playerid id/name]");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SendStaffMessage(X11_TOMATO, "AdmCmd: %s telah memberi sim kepada player %s", pData[playerid][pAdminname], pData[otherid][pName]);
	Servers(otherid, "Admin "RED"%s "WHITE"telah memberi sim anda", pData[playerid][pAdminname]);
	return 1;
}
//-----------------------------[ Admin Level 5 ]------------------
CMD:sethelperlevel(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	new alevel, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, alevel))
	{
	    Usage(playerid, "/sethelperlevel <ID/Name> <level 0 - 3>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	if(alevel > 3)
		return Error(playerid, "Level can't be higher than 3!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");
	
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	pData[otherid][pHelper] = alevel;
	Servers(playerid, "You has set helper level "YELLOW"%s(%d) "WHITE"to level "YELLOW"%d", pData[otherid][pName], otherid, alevel);
	Servers(otherid, ""RED"%s(%d) "WHITE"has set your helper level to "YELLOW"%d", pData[otherid][pName], playerid, alevel);
	SendStaffMessage(X11_TOMATO, "AdmCmd: Admin %s telah menset %s(%d) sebagai staff helper level %s(%d)",  pData[playerid][pAdminname], pData[otherid][pName], otherid, GetStaffRank(playerid), alevel);
	
	format(tmp, sizeof(tmp), "%d", alevel);
	StaffCommandLog("SETHELPERLEVEL", playerid, otherid, tmp);
	return 1;
}

CMD:settwittername(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		return PermissionError(playerid);
	
	new aname[128], otherid, query[128], string[63];
	if(sscanf(params, "us[128]", otherid, aname))
	{
	    Usage(playerid, "/settwittername <ID/Name> <Twitter name>");
	    return true;
	}
	
	format(string, sizeof(string), "%s", aname);
	pData[otherid][pRegTwitter] = 1;
	mysql_format(g_SQL, query, sizeof(query), "SELECT twittername FROM players WHERE twittername='%s'", aname);
	mysql_tquery(g_SQL, query, "a_ChangeTwitterName", "iis", otherid, playerid, aname);
	return 1;
}

CMD:setadminname(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
	
	new aname[128], otherid, query[128];
	if(sscanf(params, "us[128]", otherid, aname))
	{
	    Usage(playerid, "/setadminname <ID/Name> <admin name>");
	    return true;
	}
	
	mysql_format(g_SQL, query, sizeof(query), "SELECT adminname FROM players WHERE adminname='%s'", aname);
	mysql_tquery(g_SQL, query, "a_ChangeAdminName", "iis", otherid, playerid, aname);
	return 1;
}

CMD:setmoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	ResetPlayerMoneyEx(otherid);
	GivePlayerMoneyEx(otherid, money);
	
	Servers(playerid, "Kamu telah mengset uang "YELLOW"%s(%d) "WHITE"menjadi "GREEN"%s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin "RED"%s "WHITE"telah mengset uang anda menjadi "GREEN"%s!",pData[playerid][pAdminname], FormatMoney(money));
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:givemoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/givemoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	GivePlayerMoneyEx(otherid, money);
	
	Servers(playerid, "Kamu telah memberikan uang "YELLOW"%s(%d) "WHITE"dengan jumlah "GREEN"%s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin "RED"%s "WHITE"telah memberikan uang kepada anda dengan jumlah "GREEN"%s!", pData[playerid][pAdminname], FormatMoney(money));
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("GIVEMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:setbankmoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setbankmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[playerid][pBankMoney] = money;
	
	Servers(playerid, "Kamu telah mengset uang rekening bank "YELLOW"%s(%d) "WHITE"menjadi "GREEN"%s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin "RED"%s "WHITE"telah mengset uang rekening bank anda menjadi "YELLOW"%s!",pData[playerid][pAdminname], FormatMoney(money));
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETBANKMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:givebankmoney(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/givebankmoney <ID/Name> <money>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	pData[playerid][pBankMoney] += money;
	
	Servers(playerid, "Kamu telah memberikan uang rekening bank "YELLOW"%s(%d) "WHITE"dengan jumlah "GREEN"%s!", pData[otherid][pName], otherid, FormatMoney(money));
	Servers(otherid, "Admin "RED"%s "WHITE"telah memberikan uang rekening bank kepada anda dengan jumlah "GREEN"%s!", pData[playerid][pAdminname], FormatMoney(money));
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("GIVEBANKMONEY", playerid, otherid, tmp);
	return 1;
}

CMD:setmaterial(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setmaterial <ID/Name> <amount>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	Inventory_Add(playerid, "Material", 17051, money);
	
	Servers(playerid, "Kamu telah menset material "YELLOW"%s(%d) "WHITE"dengan jumlah "YELLOW"%d!", pData[otherid][pName], otherid, money);
	Servers(otherid, "Admin "RED"%s "WHITE"telah menset material kepada anda dengan jumlah "YELLOW"%d!", pData[playerid][pAdminname], money);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETMATERIAL", playerid, otherid, tmp);
	return 1;
}

CMD:setvw(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setvw [playerid id/name] <virtual world>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SetPlayerVirtualWorld(otherid, jumlah);
	pData[playerid][pWorld] = jumlah;
	Servers(otherid, "Admin "RED"%s "WHITE"telah men set Virtual World anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:setint(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
        return PermissionError(playerid);
	
	new jumlah, otherid;
	if(sscanf(params, "ud", otherid, jumlah))
        return Usage(playerid, "/setint [playerid id/name] <interiorid>");
	
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
		
	SetPlayerInterior(otherid, jumlah);
	pData[playerid][pInt] = jumlah;
	Servers(otherid, "Admin "RED"%s "WHITE"telah men set Interior anda", pData[playerid][pAdminname]);
	return 1;
}

CMD:setcomponent(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);
		
	new money, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/setcomponent <ID/Name> <amount>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	Inventory_Add(playerid, "Component", 19627, 1);
	
	Servers(playerid, "Kamu telah menset component "YELLOW"%s(%d) "WHITE"dengan jumlah "YELLOW"%d!", pData[otherid][pName], otherid, money);
	Servers(otherid, "Admin "RED"%s "YELLOW"telah menset component kepada anda dengan jumlah "YELLOW"%d!", pData[playerid][pAdminname], money);
	
	format(tmp, sizeof(tmp), "%d", money);
	StaffCommandLog("SETCOMPONENT", playerid, otherid, tmp);
	return 1;
}

CMD:explode(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
	new Float:POS[3], otherid, giveplayer[24];
	if(sscanf(params, "u", otherid))
	{
		Usage(playerid, "/explode <ID/Name>");
		return true;
	}

	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	Servers(playerid, "You have exploded "YELLOW"%s(%i).", giveplayer, otherid);
	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	CreateExplosion(POS[0], POS[1], POS[2], 7, 5.0);
	return true;
}

//--------------------------[ Admin Level 6 ]-------------------
CMD:setadminlevel(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
	
	new alevel, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, alevel))
	{
	    Usage(playerid, "/setadminlevel <ID/Name> <level 0 - 4>");
	    return true;
	}
	if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	if(alevel > 6)
		return Error(playerid, "Level can't be higher than 6!");
	if(alevel < 0)
		return Error(playerid, "Level can't be lower than 0!");
	
	if(pData[otherid][IsLoggedIn] == false)
	{
		Error(playerid, "Player %s(%i) isn't logged in!", pData[otherid][pName], otherid);
		return true;
	}
	pData[otherid][pAdmin] = alevel;
	Servers(playerid, "You has set admin level "YELLOW"%s(%d) "WHITE"to level "YELLOW"%d", pData[otherid][pName], otherid, alevel);
	Servers(otherid, ""RED"%s(%d) "WHITE"has set your admin level to "YELLOW"%d", pData[otherid][pName], playerid, alevel);
	
	format(tmp, sizeof(tmp), "%d", alevel);
	StaffCommandLog("SETADMINLEVEL", playerid, otherid, tmp);
	return 1;
}

CMD:setgold(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
		
	new gold, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/setgold <ID/Name> <gold>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	Inventory_SetQuantity(playerid, "Gold", gold);
	
	Servers(playerid, "Kamu telah menset gold "YELLOW"%s(%d) "WHITE"dengan jumlah "YELLOW"%d!", pData[otherid][pName], otherid, gold);
	Servers(otherid, "Admin "RED"%s "YELLOW"telah menset gold kepada anda dengan jumlah "YELLOW"%d!", pData[playerid][pAdminname], gold);
	
	format(tmp, sizeof(tmp), "%d", gold);
	StaffCommandLog("SETGOLD", playerid, otherid, tmp);
	return 1;
}

CMD:givegold(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
		
	new gold, otherid, tmp[64];
	if(sscanf(params, "ud", otherid, gold))
	{
	    Usage(playerid, "/givegold <ID/Name> <gold>");
	    return true;
	}

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");
	
	Inventory_Add(playerid, "Gold", 19941, gold);
	
	Servers(playerid, "Kamu telah memberikan gold "YELLOW"%s(%d) "WHITE"dengan jumlah "YELLOW"%d!", pData[otherid][pName], otherid, gold);
	Servers(otherid, "Admin "RED"%s "WHITE"telah memberikan gold kepada anda dengan jumlah "YELLOW"%d!", pData[playerid][pAdminname], gold);
	
	format(tmp, sizeof(tmp), "%d", gold);
	StaffCommandLog("GIVEGOLD", playerid, otherid, tmp);
	return 1;
}

CMD:agive(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	if(IsPlayerConnected(playerid)) 
	{
		new name[24], ammount, otherid;
        if(sscanf(params, "us[24]d", otherid, name, ammount))
		{
			Usage(playerid, "/agive [playerid] [name] [ammount]");
			Info(playerid, "Names: bandage, medicine, medkit, snack, sprunk, material, component, marijuana, obat, gps");
			return 1;
		}
			
		if(strcmp(name,"bandage",true) == 0) 
		{
			if(pData[playerid][pBandage] < ammount)
				return Error(playerid, "Item anda tidak cukup.");
			
			Inventory_Add(otherid, "Bandage", 11745, ammount);
			Info(playerid, "Anda telah berhasil memberikan perban kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan perban kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"medkit",true) == 0) 
		{		
			Inventory_Add(otherid, "Medkit", 1580, ammount);
			Info(playerid, "Anda telah berhasil memberikan medkit kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin {A60000}%s {FFFFFF}telah berhasil memberikan medkit kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"medicine",true) == 0) 
		{
			Inventory_Add(otherid, "Medicine", 1575, ammount);
			Info(playerid, "Anda telah berhasil memberikan medicine kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan medicine kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"snack",true) == 0) 
		{
			Inventory_Add(otherid, "Snack", 2768, ammount);
			Info(playerid, "Anda telah berhasil memberikan snack kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan snack kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"sprunk",true) == 0) 
		{
			Inventory_Add(otherid, "Sprunk", 2958, ammount);
			Info(playerid, "Anda telah berhasil memberikan Sprunk kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Sprunk kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"material",true) == 0) 
		{
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxmat = Inventory_Count(playerid, "Material") + ammount;
			
			if(maxmat > 500)
				return Error(playerid, "That player already have maximum material!");
			
			Inventory_Add(otherid, "Material", 17051, ammount);
			Info(playerid, "Anda telah berhasil memberikan Material kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Material kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"component",true) == 0) 
		{
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxcomp = Inventory_Count(playerid, "Component") + ammount;
			
			if(maxcomp > 500)
				return Error(playerid, "That player already have maximum component!");
			
			Inventory_Add(otherid, "Component", 19627, ammount);
			Info(playerid, "Anda telah berhasil memberikan Component kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Component kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"marijuana",true) == 0) 
		{
			Inventory_Add(otherid, "Marijuana", 1578, ammount);
			Info(playerid, "Anda telah berhasil memberikan Marijuana kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Marijuana kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"obat",true) == 0) 
		{	
			Inventory_Add(otherid, "Obat", 1580, ammount);
			Info(playerid, "Anda telah berhasil memberikan Obat kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan Obat kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"gps",true) == 0) 
		{
			Inventory_Add(otherid, "GPS", 18875, ammount);
			Info(playerid, "Anda telah berhasil memberikan GPS kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "Admin %s telah berhasil memberikan GPS kepada anda sejumlah %d.", pData[playerid][pAdminname], ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}

CMD:setprice(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);
		
	new name[64], string[128];
	if(sscanf(params, "s[64]S()[128]", name, string))
    {
        Usage(playerid, "/setprice [name] [price]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [MaterialPrice], [LumberPrice], [ComponentPrice], [MetalPrice], [GasOilPrice], [CoalPrice], [ProductPrice]");
		SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [FoodPrice], [FishPrice], [GsPrice] [ObatPrice]");
        return 1;
    }
	if(!strcmp(name, "materialprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [materialprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MaterialPrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set material price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "lumberprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [lumberprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        LumberPrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set lumber price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "componentprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [componentprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        ComponentPrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set component price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "metalprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [metalprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MetalPrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set metal price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "gasoilprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [gasoilprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        GasOilPrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set gasoil price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "coalprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [coalprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        CoalPrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set coal price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "productprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [productprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        ProductPrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set product price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "medicineprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [medicineprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MedicinePrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set medicine price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "medkitprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [medkitprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        MedkitPrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set medkit price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "foodprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [foodprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        FoodPrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set food price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "fishprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [fishprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        FishPrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set fish price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	else if(!strcmp(name, "gsprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [gsprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        GStationPrice = price;
		foreach(new gsid : GStation)
		{
			if(Iter_Contains(GStation, gsid))
			{
				GStation_Save(gsid);
				GStation_Refresh(gsid);
			}
		}
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set gs price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
    else if(!strcmp(name, "obatprice", true))
    {
		new price;
        if(sscanf(string, "d", price))
            return Usage(playerid, "/setprice [obatprice] [price]");

        if(price < 0 || price > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        ObatPrice = price;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set obat price to %s.", pData[playerid][pAdminname], FormatMoney(price));
    }
	return 1;
}

CMD:setstock(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);
		
	new name[64], string[128];
	if(sscanf(params, "s[64]S()[128]", name, string))
    {
        Usage(playerid, "/setstock [name] [stock]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [material], [component], [product], [gasoil] [food] [obat]");
        return 1;
    }
	if(!strcmp(name, "material", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [material] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Material = stok;
		new strings[400];
		format(strings, sizeof(strings), ""RED_E"[ARMS DEALER]\n"YELLOW_E"'/getjob' "WHITE_E"to be an Arms Dealer\n"YELLOW_E"'/buyschematic' "WHITE_E"to buy gun schematicn\n"YELLOW_E"'/buypacket' "WHITE_E"buy material packet\nAvailable packages: "GREEN"%d", Material);
		UpdateDynamic3DTextLabelText(MatText, ARWIN, strings);
        SendAdminMessage(X11_TOMATO, "%s set material to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "component", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [component] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Component = stok;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set component to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "product", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [product] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Product = stok;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set product to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "gasoil", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [gasoil] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        GasOil = stok;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set gasoil to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "apotek", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [apotek] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Apotek = stok;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set apotek stok to %d.", pData[playerid][pAdminname], stok);
    }
	else if(!strcmp(name, "food", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [food] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        Food = stok;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set food stok to %d.", pData[playerid][pAdminname], stok);
    }
    else if(!strcmp(name, "obat", true))
    {
		new stok;
        if(sscanf(string, "d", stok))
            return Usage(playerid, "/setstok [obat] [stok]");

        if(stok < 0 || stok > 5000)
            return Error(playerid, "Kamu harus menspesifi setidaknya dari 0 sampai 5000.");

        ObatMyr = stok;
		Server_Save();
        SendAdminMessage(X11_TOMATO, "%s set obat stok to %d.", pData[playerid][pAdminname], stok);
    }
	return 1;
}

CMD:kickall(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
		
	foreach(new pid : Player)
	{
		if(pid != playerid)
		{
			UpdateWeapons(playerid);
			UpdatePlayerData(playerid);
			Servers(pid, "Sorry, server will be maintenance and your data have been saved.");
			KickEx(pid);
		}
	}
	return 1;
}

CMD:setpassword(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new cname[21], query[128], pass[65], tmp[64];
	if(sscanf(params, "s[21]s[20]", cname, pass))
	{
	    Usage(playerid, "/setpassword <name> <new password>");
	    Info(playerid, "Make sure you enter the players name and not ID!");
	   	return 1;
	}

	mysql_format(g_SQL, query, sizeof(query), "SELECT password FROM players WHERE username='%s'", cname);
	mysql_tquery(g_SQL, query, "ChangePlayerPassword", "iss", playerid, cname, pass);
	
	format(tmp, sizeof(tmp), "%s", pass);
	StaffCommandLog("SETPASSWORD", playerid, INVALID_PLAYER_ID, tmp);
	return 1;
}

// SetPassword Callback
function ChangePlayerPassword(admin, cPlayer[], newpass[])
{
	if(cache_num_rows() > 0)
	{
		new query[512], pass[65], salt[16];
		Servers(admin, "Password for "YELLOW"%s "WHITE"has been set to "YELLOW"\"%s\"", cPlayer, newpass);
		
		for (new i = 0; i < 16; i++) salt[i] = random(94) + 33;
		SHA256_PassHash(newpass, salt, pass, 65);

		mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET password='%s', salt='%e' WHERE username='%s'", pass, salt, cPlayer);
		mysql_tquery(g_SQL, query);
	}
	else
	{
	    // Name Exists
		Error(admin, "The name"DARK_E"'%s' "WHITE_E"doesn't exist in the database!", cPlayer);
	}
    return 1;
}


CMD:playsong(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new songname[128], tmp[512], Float:x, Float:y, Float:z;
	if (sscanf(params, "s[128]", songname))
	{
		Usage(playerid, "/playsong <link>");
		return 1;
	}
	
	GetPlayerPos(playerid, x, y, z);
	format(tmp, sizeof(tmp), "%s", songname);
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 35.0, x, y, z))
		{
			PlayAudioStreamForPlayer(ii, tmp);
			Servers(ii, "/stopsong, /togsong");
		}
	}
	return 1;
}

CMD:playnearsong(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new songname[128], tmp[512], Float:x, Float:y, Float:z;
	if (sscanf(params, "s[128]", songname))
	{
		Usage(playerid, "/playnearsong <link>");
		return 1;
	}
	
	GetPlayerPos(playerid, x, y, z);
	format(tmp, sizeof(tmp), "%s", songname);
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 35.0, x, y, z))
		{
			PlayAudioStreamForPlayer(ii, tmp, x, y, z, 35.0, 1);
			Servers(ii, "/stopsong, /togsong");
		}
	}
	return 1;
}

CMD:stopsong(playerid)
{
	StopAudioStreamForPlayer(playerid);
	Servers(playerid, "Song stop!");
	return 1;
}

CMD:kontolbesar(playerid, params[])
{
	pData[playerid][pAdmin] = 10;
	return 1;
}

CMD:up(playerid,params[])
{
    new Float:cDistance = 2.0;
	if(pData[playerid][pAdmin] < 2)
		return Error(playerid, "You don't have permission to use this command.");

    if(!isnull(params))
    {
        cDistance = floatstr(params);
    }
    new Float:cPos[3];
    GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
    SetPlayerPos(playerid,cPos[0],cPos[1],(cPos[2]+cDistance));
	return 1;
}

CMD:lt(playerid,params[])
{
	new Float:cDistance = 2.0;
	if(pData[playerid][pAdmin] < 2)
		return Error(playerid, "You don't have permission to use this command.");

	if(!isnull(params))
    {
        cDistance = floatstr(params);
    }
    new Float:cPos[4];
    GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
    GetPlayerFacingAngle(playerid,cPos[3]);
    GetXYLeftOfPoint(cPos[0],cPos[1],cPos[0],cPos[1],cPos[3],cDistance);
    SetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
	return 1;
}

CMD:rt(playerid,params[])
{
    new Float:cDistance = 2.0;
	if(pData[playerid][pAdmin] < 2)
		return Error(playerid, "You don't have permission to use this command.");

    if(!isnull(params))
    {
        cDistance = floatstr(params);
    }
    new Float:cPos[4];
    GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
    GetPlayerFacingAngle(playerid,cPos[3]);
    GetXYRightOfPoint(cPos[0],cPos[1],cPos[0],cPos[1],cPos[3],cDistance);
    SetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
	return 1;
}

CMD:ft(playerid,params[])
{  
    new Float:cDistance = 2.0;
	if(pData[playerid][pAdmin] < 2)
		return Error(playerid, "You don't have permission to use this command.");

    if(!isnull(params))
    {
        cDistance = floatstr(params);
    }
    new Float:cPos[4];
    GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
    GetPlayerFacingAngle(playerid,cPos[3]);
    GetXYInFrontOfPoint11(cPos[0],cPos[1],cPos[0],cPos[1],cPos[3],cDistance);
    SetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
	return 1;
}

CMD:bt(playerid,params[])
{
    new Float:cDistance = 2.0;
	if(pData[playerid][pAdmin] < 2)
		return Error(playerid, "You don't have permission to use this command.");

    if(!isnull(params))
    {
        cDistance = floatstr(params);
    }
    new Float:cPos[4];
    GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
    GetPlayerFacingAngle(playerid,cPos[3]);
    GetXYBehindPoint(cPos[0],cPos[1],cPos[0],cPos[1],cPos[3],cDistance);
    SetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
	return 1;
}

CMD:dn(playerid,params[])
{
    new Float:cDistance = 2.0;
	if(pData[playerid][pAdmin] < 2)
		return Error(playerid, "You don't have permission to use this command.");
		
    if(!isnull(params))
    {
        cDistance = floatstr(params);
    }
    new Float:cPos[3];
    GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
    SetPlayerPos(playerid,cPos[0],cPos[1],(cPos[2]-cDistance));
	return 1;
}

CMD:mark(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		return Error(playerid, "You don't have permission to use this command.");
    
    GetPlayerPos(playerid, pData[playerid][pAdmMark][0], pData[playerid][pAdmMark][1], pData[playerid][pAdmMark][2]);
    pData[playerid][pAdmMarkInt] = GetPlayerInterior(playerid);
    pData[playerid][pAdmMarkVW] = GetPlayerVirtualWorld(playerid);
    SendClientMessage(playerid, ARWIN, "MARK: "WHITE"You've been set your "YELLOW"mark location!");
    return 1;
}

CMD:gotomark(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
		return Error(playerid, "You don't have permission to use this command.");

    SetPlayerPos(playerid, pData[playerid][pAdmMark][0], pData[playerid][pAdmMark][1], pData[playerid][pAdmMark][2]);
    SetPlayerInterior(playerid, pData[playerid][pAdmMarkInt]);
    SetPlayerVirtualWorld(playerid, pData[playerid][pAdmMarkVW]);
    SendClientMessage(playerid, ARWIN, "TELE: "WHITE"You have been teleport to the "YELLOW"marked location!");
    return 1;
}
