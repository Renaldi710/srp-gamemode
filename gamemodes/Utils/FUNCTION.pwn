
//----------[ Function Login Register]----------

function CheckAccount(playerid) 
{
	SetPlayerPos(playerid, 1309.7660,753.3946,1062.3527);

	SetPlayerCameraPos(playerid, CAMERA1_DIEM);
    SetPlayerCameraLookAt(playerid, CAMERA2_DIEM);

    new query[256];
    format(query, sizeof(query), "SELECT * FROM `ucp` WHERE `username` = '%s' LIMIT 1;", GetName(playerid));
    mysql_tquery(g_SQL, query, "OnUCPLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
    return 1;
}

function OnUCPLoaded(playerid, race_check) 
{
    if (race_check != g_MysqlRaceCheck[playerid]) 
      return KickEx(playerid);

    new rows = cache_num_rows(), feda[250];
    if (rows)
	{
        GetPlayerName(playerid, UcpData[playerid][uUsername], MAX_PLAYER_NAME + 1);

        cache_get_value_name_int(0, "id", UcpData[playerid][uID]);
        cache_get_value_name_int(0, "admin", UcpData[playerid][uAdmin]);
        cache_get_value_name(0, "username", UcpData[playerid][uUsername], 64);
        cache_get_value_name(0, "password", UcpData[playerid][uPassword], 128);
        cache_get_value_name(0, "salt", UcpData[playerid][uSalt], 128);
        cache_get_value_name(0, "ip", UcpData[playerid][uIP], 16);
        cache_get_value_name_int(0, "registerdate", UcpData[playerid][uRegisterDate]);
		cache_get_value_name_int(0, "register", UcpData[playerid][uRegistered]);
		cache_get_value_name_int(0, "pin_code", UcpData[playerid][uVerifyCode]);
		
		//format(feda, sizeof feda, ""WHITE_E"Selamat datang kembali "YELLOW_E"%s"WHITE_E", silahkan masukkan password Anda dibawah:", GetName(playerid));
        //ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Masuk", feda, "Masuk", "Batal");
		
		if(UcpData[playerid][uRegistered] != 0)
		{
			format(feda, sizeof feda, ""WHITE_E"Selamat datang kembali "YELLOW_E"%s"WHITE_E", silahkan masukkan password Anda dibawah:", GetName(playerid));
        	ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Masuk", feda, "Masuk", "Batal");
		}
		else
		{
			format(feda, sizeof feda, ""WHITE_E"Selamat datang kembali "YELLOW_E"%s"WHITE_E", silahkan masukkan pin code yang di kirim bot dibawah:", GetName(playerid));
        	Dialog_Show(playerid, DIALOG_PIN, DIALOG_STYLE_PASSWORD, "Masuk", feda, "Masuk", "Batal");
		}
    }
    else
    {
        UcpData[playerid][uPassword] = UcpData[playerid][uSalt] = EOS;
        //new str[250];
        //format(str, sizeof(str), ""WHITE_E"Selamat datang"YELLOW_E"%s"WHITE_E".\n\nMasukkan password untuk mendaftarkan akun: (password minimal 8 sampai dengan 32 karakter).", GetName(playerid));
        //ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Mendaftarkan akun", str, "Daftarkan", "Keluar");
		format(feda, sizeof feda, ""WHITE_E"Akun dengan nama "YELLOW_E"%s "WHITE_E"tidak terdaftar. Silahkan daftarkan ucp anda di discord", GetName(playerid));
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Daftar", feda, "Tutup", "");
		KickEx(playerid);
    }
    new query[248], PlayerIP[16];
    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `banneds` WHERE `name` = '%s' OR `ip` = '%s' OR (`longip` != 0 AND (`longip` & %i) = %i) LIMIT 1", pData[playerid][pUCP], pData[playerid][pIP], BAN_MASK, (Ban_GetLongIP(PlayerIP) & BAN_MASK));
	mysql_tquery(g_SQL, query, "CheckBanUCP", "i", playerid);
    return 1;
}
function CheckBanUCP(playerid)
{
	if(cache_num_rows() > 0)
	{
		new Reason[40], PlayerName[24], BannedName[24];
	    new banTime_Int, banDate, banIP[16];
		cache_get_value_name(0, "name", BannedName);
		cache_get_value_name(0, "admin", PlayerName);
		cache_get_value_name(0, "reason", Reason);
		cache_get_value_name(0, "ip", banIP);
		cache_get_value_name_int(0, "ban_expire", banTime_Int);
		cache_get_value_name_int(0, "ban_date", banDate);

		new currentTime = gettime();
        if(banTime_Int != 0 && banTime_Int <= currentTime) // Unban the player.
		{
			new query[248];
			mysql_format(g_SQL, query, sizeof(query), "DELETE FROM banneds WHERE name = '%s'", UcpData[playerid][uUsername]);
			mysql_tquery(g_SQL, query);
				
			Servers(playerid, "Welcome back to server, its been %s since your ban was lifted.", ReturnTimelapse(banTime_Int, gettime()));
		}
		else
		{
			foreach(new pid : Player)
			{
				if(pData[pid][pTogLog] == 0)
				{
					SendClientMessageEx(pid, COLOR_RED, "[SERVER]: "GREY2_E"%s(%i) has been auto-kicked for ban evading.", UcpData[playerid][uUsername], playerid);
				}
			}
			new query[248], PlayerIP[16];
  			mysql_format(g_SQL, query, sizeof query, "UPDATE `banneds` SET `last_activity_timestamp` = '%d' WHERE `name` = '%s'", gettime(), UcpData[playerid][uUsername]);
			mysql_tquery(g_SQL, query);
				
			pData[playerid][IsLoggedIn] = false;
			printf("[BANNED INFO]: Ban Getting Called on %s", pData[playerid][pUCP]);
			GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
			
			InfoTD_MSG(playerid, 5000, "~r~~h~You are banned from this server!");
			//for(new l; l < 20; l++) SendClientMessage(playerid, COLOR_DARK, "\n");
			SendClientMessage(playerid, COLOR_RED, "You are banned from this server!");
			if(banTime_Int == 0)
			{
				new lstr[512];
				format(lstr, sizeof(lstr), "{FF0000}You are banned from this server!\n\n"LB2_E"Ban Info:\n{FF0000}Name UCP: {778899}%s\n{FF0000}IP: {778899}%s\n{FF0000}Admin: {778899}%s\n{FF0000}Ban Date: {778899}%s\n{FF0000}Ban Reason: {778899}%s\n{FF0000}Ban Time: {778899}Permanent\n\n{FFFFFF}Merasa tidak bersalah terkena banned? Appeal di village", BannedName, PlayerIP, PlayerName, ReturnDate(banDate), Reason);
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"BANNED", lstr, "Exit", "");
			}
			else
			{
				new lstr[512];
				format(lstr, sizeof(lstr), "{FF0000}You are banned from this server!\n\n"LB2_E"Ban Info:\n{FF0000}Name UCP: {778899}%s\n{FF0000}IP: {778899}%s\n{FF0000}Admin: {778899}%s\n{FF0000}Ban Date: {778899}%s\n{FF0000}Ban Reason: {778899}%s\n\n{FFFFFF}Merasa tidak bersalah terkena banned? Appeal di village", BannedName, PlayerIP, PlayerName, ReturnDate(banDate), Reason);
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"BANNED", lstr, "Exit", "");
			}
			KickEx(playerid);
			return 1;
  		}
	}
	return 1;
}

function CheckBanAccount(playerid, namachar[])
{
	if(cache_num_rows() > 0)
	{
		new Reason[40], PlayerName[24], BannedName[24];
	    new banTime_Int, banDate, banIP[16];
		cache_get_value_name(0, "name", BannedName);
		cache_get_value_name(0, "admin", PlayerName);
		cache_get_value_name(0, "reason", Reason);
		cache_get_value_name(0, "ip", banIP);
		cache_get_value_name_int(0, "ban_expire", banTime_Int);
		cache_get_value_name_int(0, "ban_date", banDate);

		new currentTime = gettime();
        if(banTime_Int != 0 && banTime_Int <= currentTime) // Unban the player.
		{
			new query[248];
			mysql_format(g_SQL, query, sizeof(query), "DELETE FROM banneds WHERE name = '%s'", NormalName(playerid));
			mysql_tquery(g_SQL, query);
				
			Servers(playerid, "Welcome back to server, its been %s since your ban was lifted.", ReturnTimelapse(banTime_Int, gettime()));
		}
		else
		{
			foreach(new pid : Player)
			{
				if(pData[pid][pTogLog] == 0)
				{
					SendClientMessageEx(pid, COLOR_RED, "[SERVER]: "GREY2_E"%s(%i) has been auto-kicked for ban evading.", NormalName(playerid), playerid);
				}
			}
			new query[248], PlayerIP[16];
  			mysql_format(g_SQL, query, sizeof query, "UPDATE `banneds` SET `last_activity_timestamp` = '%d' WHERE `name` = '%s'", gettime(), NormalName(playerid));
			mysql_tquery(g_SQL, query);
				
			pData[playerid][IsLoggedIn] = false;
			printf("[BANNED INFO]: Ban Getting Called on %s", NormalName(playerid));
			GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
			
			InfoTD_MSG(playerid, 5000, "~r~~h~You are account banned from this server!");
			//for(new l; l < 20; l++) SendClientMessage(playerid, COLOR_DARK, "\n");
			SendClientMessage(playerid, COLOR_RED, "You are account banned from this server!");
			if(banTime_Int == 0)
			{
				new lstr[512];
				format(lstr, sizeof(lstr), "{FF0000}You are account banned from this server!\n\n"LB2_E"Ban Info:\n{FF0000}Name : {778899}%s\n{FF0000}IP: {778899}%s\n{FF0000}Admin: {778899}%s\n{FF0000}Ban Date: {778899}%s\n{FF0000}Ban Reason: {778899}%s\n{FF0000}Ban Time: {778899}Permanent\n\n{FFFFFF}Merasa tidak bersalah terkena banned? Appeal di village", BannedName, PlayerIP, PlayerName, ReturnDate(banDate), Reason);
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"BANNED", lstr, "Exit", "");
			}
			else
			{
				new lstr[512];
				format(lstr, sizeof(lstr), "{FF0000}You are account banned from this server!\n\n"LB2_E"Ban Info:\n{FF0000}Name : {778899}%s\n{FF0000}IP: {778899}%s\n{FF0000}Admin: {778899}%s\n{FF0000}Ban Date: {778899}%s\n{FF0000}Ban Reason: {778899}%s\n\n{FFFFFF}Merasa tidak bersalah terkena banned? Appeal di village", BannedName, PlayerIP, PlayerName, ReturnDate(banDate), Reason);
				ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"BANNED", lstr, "Exit", "");
			}
			KickEx(playerid);
			return 1;
  		}
	}
	return 1;
}

function OnCharacterCheck(playerid, name[])
{
  new rows = cache_num_rows();
  if(rows > 0)
  {
    ShowPlayerDialog(playerid, DIALOG_CREATECHAR, DIALOG_STYLE_INPUT, "Create Character", ""WHITE_E"Masukkan nama karakter, maksimal 24 karakter\n\nContoh: "YELLOW_E"Sean_Rutledge, Eddison_Murphy dan lainnya.", "Create", "Back");
  }
  else 
  {
    new characterQuery[178];
    mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "INSERT INTO players ( username, ucp, reg_date ) VALUES ('%s', '%s', CURRENT_TIMESTAMP())", name, GetName(playerid));
    mysql_tquery(g_SQL, characterQuery, "OnPlayerRegister", "d", playerid);

    SetPlayerName(playerid, name);
    format(pData[playerid][pName], MAX_PLAYER_NAME, name);
  }
}

function AssignPlayerData(playerid)
{
	new name[MAX_PLAYER_NAME], twname[MAX_PLAYER_NAME], email[40], age[128], ip[128], regdate[50], lastlogin[50], str[24];
	cache_get_value_name_int(0, "reg_id", pData[playerid][pID]);
	if(pData[playerid][pID] < 1)
	{
		Error(playerid, "Database player not found!");
		KickEx(playerid);
		return 1;
	}	
	cache_get_value_name(0, "username", name);
	format(pData[playerid][pName], MAX_PLAYER_NAME, "%s", name);
	//cache_get_value_name(0, "adminname", aname);
	format(pData[playerid][pAdminname], MAX_PLAYER_NAME, "%s", UcpData[playerid][uUsername]);
	cache_get_value_name(0, "twittername", twname);
	format(pData[playerid][pTwittername], MAX_PLAYER_NAME, "%s", twname);
	cache_get_value_name(0, "ip", ip);
	format(pData[playerid][pIP], 128, "%s", ip);
	cache_get_value_name(0, "email", email);
	format(pData[playerid][pEmail], 40, "%s", email);
	cache_get_value_name_int(0, "admin", pData[playerid][pAdmin]);
	cache_get_value_name_int(0, "helper", pData[playerid][pHelper]);
	cache_get_value_name_int(0, "level", pData[playerid][pLevel]);
	cache_get_value_name_int(0, "levelup", pData[playerid][pLevelUp]);
	cache_get_value_name_int(0, "vip", pData[playerid][pVip]);
	cache_get_value_name_int(0, "vip_time", pData[playerid][pVipTime]);
	//cache_get_value_name_int(0, "gold", pData[playerid][pGold]);
	cache_get_value_name(0, "reg_date", regdate);
	format(pData[playerid][pRegDate], 128, "%s", regdate);
	cache_get_value_name(0, "last_login", lastlogin);
	format(pData[playerid][pLastLogin], 128, "%s", lastlogin);
	cache_get_value_name_int(0, "money", pData[playerid][pMoney]);
	cache_get_value_name_int(0, "bmoney", pData[playerid][pBankMoney]);
	cache_get_value_name_int(0, "brek", pData[playerid][pBankRek]);
	cache_get_value_name_int(0, "phone", pData[playerid][pPhone]);
	cache_get_value_name_int(0, "phonecredit", pData[playerid][pPhoneCredit]);
	cache_get_value_name_int(0, "phonebook", pData[playerid][pPhoneBook]);
	cache_get_value_name_int(0, "wt", pData[playerid][pWT]);
	cache_get_value_name_int(0, "hours", pData[playerid][pHours]);
	cache_get_value_name_int(0, "minutes", pData[playerid][pMinutes]);
	cache_get_value_name_int(0, "seconds", pData[playerid][pSeconds]);
	cache_get_value_name_int(0, "paycheck", pData[playerid][pPaycheck]);
	cache_get_value_name_int(0, "skin", pData[playerid][pSkin]);
	cache_get_value_name_int(0, "facskin", pData[playerid][pFacSkin]);
	cache_get_value_name_int(0, "gender", pData[playerid][pGender]);
	cache_get_value_name(0, "age", age);
	format(pData[playerid][pAge], 128, "%s", age);
	cache_get_value_name_int(0, "indoor", pData[playerid][pInDoor]);
	cache_get_value_name_int(0, "inhouse", pData[playerid][pInHouse]);
	cache_get_value_name_int(0, "inbiz", pData[playerid][pInBiz]);
	cache_get_value_name_float(0, "posx", pData[playerid][pPosX]);
	cache_get_value_name_float(0, "posy", pData[playerid][pPosY]);
	cache_get_value_name_float(0, "posz", pData[playerid][pPosZ]);
	cache_get_value_name_float(0, "posa", pData[playerid][pPosA]);
	cache_get_value_name_int(0, "interior", pData[playerid][pInt]);
	cache_get_value_name_int(0, "world", pData[playerid][pWorld]);
	cache_get_value_name_float(0, "health", pData[playerid][pHealth]);
	cache_get_value_name_float(0, "armour", pData[playerid][pArmour]);
	cache_get_value_name_int(0, "hunger", pData[playerid][pHunger]);
	cache_get_value_name_int(0, "bladder", pData[playerid][pBladder]);
	cache_get_value_name_int(0, "energy", pData[playerid][pEnergy]);
	cache_get_value_name_int(0, "sick", pData[playerid][pSick]);
	cache_get_value_name_int(0, "hospital", pData[playerid][pHospital]);
	cache_get_value_name_int(0, "injured", pData[playerid][pInjured]);
	cache_get_value_name_int(0, "duty", pData[playerid][pOnDuty]);
	cache_get_value_name_int(0, "dutytime", pData[playerid][pOnDutyTime]);
	cache_get_value_name_int(0, "faction", pData[playerid][pFaction]);
	cache_get_value_name_int(0, "factionrank", pData[playerid][pFactionRank]);
	cache_get_value_name_int(0, "factionlead", pData[playerid][pFactionLead]);
	cache_get_value_name_int(0, "family", pData[playerid][pFamily]);
	cache_get_value_name_int(0, "familyrank", pData[playerid][pFamilyRank]);
	cache_get_value_name_int(0, "jail", pData[playerid][pJail]);
	cache_get_value_name_int(0, "jail_time", pData[playerid][pJailTime]);
	cache_get_value_name_int(0, "arrest", pData[playerid][pArrest]);
	cache_get_value_name_int(0, "arrest_time", pData[playerid][pArrestTime]);
	cache_get_value_name_int(0, "warn", pData[playerid][pWarn]);
	cache_get_value_name_int(0, "job", pData[playerid][pJob]);
	cache_get_value_name_int(0, "job2", pData[playerid][pJob2]);
	cache_get_value_name_int(0, "jobtime", pData[playerid][pJobTime]);
	cache_get_value_name_int(0, "sidejobtime", pData[playerid][pSideJobTime]);

	cache_get_value_name_int(0, "truckercratetime", pData[playerid][pTruckerCrateTime]);
	//cache_get_value_name_int(0, "truckerproducttime", pData[playerid][pTruckerProductTime]);
	//cache_get_value_name_int(0, "truckerhaulingtime", pData[playerid][pTruckerHaulingTime]);

	cache_get_value_name_int(0, "minertime", pData[playerid][pMinerTime]);
	//cache_get_value_name_int(0, "producttime", pData[playerid][pProductTime]);
	cache_get_value_name_int(0, "lumbertime", pData[playerid][pLumberTime]);
	cache_get_value_name_int(0, "fishtime", pData[playerid][pFishTime]);
	cache_get_value_name_int(0, "forklifttime", pData[playerid][pForkliftTime]);
	cache_get_value_name_int(0, "bustime", pData[playerid][pBusTime]);
	cache_get_value_name_int(0, "sweepertime", pData[playerid][pSweeperTime]);
	cache_get_value_name_int(0, "couriertime", pData[playerid][pCourierTime]);
	cache_get_value_name_int(0, "advertisetime", pData[playerid][pAdvertiseTime]);
	cache_get_value_name_int(0, "smugglertime", pData[playerid][pSmugglerTime]);

	cache_get_value_name_int(0, "exitjob", pData[playerid][pExitJob]);
	cache_get_value_name_int(0, "taxitime", pData[playerid][pTaxiTime]);
	//cache_get_value_name_int(0, "medicine", pData[playerid][pMedicine]);
	//cache_get_value_name_int(0, "medkit", pData[playerid][pMedkit]);
	cache_get_value_name_int(0, "mask", pData[playerid][pMask]);
	cache_get_value_name_int(0, "helmet", pData[playerid][pHelmet]);
	//cache_get_value_name_int(0, "snack", pData[playerid][pSnack]);
	//cache_get_value_name_int(0, "sprunk", pData[playerid][pSprunk]);
	cache_get_value_name_int(0, "gas", pData[playerid][pGas]);
	cache_get_value_name_int(0, "bandage", pData[playerid][pBandage]);
	//cache_get_value_name_int(0, "gps", pData[playerid][pGPS]);
	cache_get_value_name_int(0, "material", pData[playerid][pMaterial]);
	cache_get_value_name_int(0, "component", pData[playerid][pComponent]);
	//cache_get_value_name_int(0, "food", pData[playerid][pFood]);
	//cache_get_value_name_int(0, "seed", pData[playerid][pSeed]);
	//cache_get_value_name_int(0, "potato", pData[playerid][pPotato]);
	//cache_get_value_name_int(0, "wheat", pData[playerid][pWheat]);
	//cache_get_value_name_int(0, "orange", pData[playerid][pOrange]);
	cache_get_value_name_int(0, "price1", pData[playerid][pPrice1]);
	cache_get_value_name_int(0, "price2", pData[playerid][pPrice2]);
	cache_get_value_name_int(0, "price3", pData[playerid][pPrice3]);
	cache_get_value_name_int(0, "price4", pData[playerid][pPrice4]);
	cache_get_value_name_int(0, "marijuana", pData[playerid][pMarijuana]);
	cache_get_value_name_int(0, "plant", pData[playerid][pPlant]);
	cache_get_value_name_int(0, "plant_time", pData[playerid][pPlantTime]);
	//fish
	//cache_get_value_name_int(0, "fishtool", pData[playerid][pFishTool]);
	//cache_get_value_name_int(0, "fish", pData[playerid][pFish]);
	//cache_get_value_name_int(0, "worm", pData[playerid][pWorm]);
	cache_get_value(0, "fish0", str, 24);
	sscanf(str, "p<|>f", FishWeight[playerid][0]);
	cache_get_value(0, "fish1", str, 24);
	sscanf(str, "p<|>f", FishWeight[playerid][1]);
	cache_get_value(0, "fish2", str, 24);
	sscanf(str, "p<|>f", FishWeight[playerid][2]);
	cache_get_value(0, "fish3", str, 24);
	sscanf(str, "p<|>f", FishWeight[playerid][3]);
	cache_get_value(0, "fish4", str, 24);
	sscanf(str, "p<|>f", FishWeight[playerid][4]);

	cache_get_value_name(0, "scoreskill", str);
	sscanf(str, "p<|>dddd", pData[playerid][pScoreTrucker], pData[playerid][pScoreFishing], pData[playerid][pScoreMecha], pData[playerid][pScoreFarmer]);
	
	cache_get_value_name(0, "skilljob", str);
	sscanf(str, "p<|>dddd", pData[playerid][pSkillTrucker], pData[playerid][pSkillFishing], pData[playerid][pSkillMecha], pData[playerid][pSkillFarmer]);

	cache_get_value_name(0, "skillweapon", str);
	sscanf(str, "p<|>ddddd", pData[playerid][pSkillWeapon][0], pData[playerid][pSkillWeapon][1], pData[playerid][pSkillWeapon][2], pData[playerid][pSkillWeapon][3], pData[playerid][pSkillWeapon][4]);

	cache_get_value_name_int(0, "idcard", pData[playerid][pIDCard]);
	cache_get_value_name_int(0, "idcard_time", pData[playerid][pIDCardTime]);
	cache_get_value_name_int(0, "drivelic", pData[playerid][pDriveLic]);
	cache_get_value_name_int(0, "drivelic_time", pData[playerid][pDriveLicTime]);
	cache_get_value_name_int(0, "hbemode", pData[playerid][pHBEMode]);
	cache_get_value_name_int(0, "togpm", pData[playerid][pTogPM]);
	cache_get_value_name_int(0, "toglog", pData[playerid][pTogLog]);
	cache_get_value_name_int(0, "togads", pData[playerid][pTogAds]);
	cache_get_value_name_int(0, "togwt", pData[playerid][pTogWT]);
	
	cache_get_value_name_int(0, "Gun1", pData[playerid][pGuns][0]);
	cache_get_value_name_int(0, "Gun2", pData[playerid][pGuns][1]);
	cache_get_value_name_int(0, "Gun3", pData[playerid][pGuns][2]);
	cache_get_value_name_int(0, "Gun4", pData[playerid][pGuns][3]);
	cache_get_value_name_int(0, "Gun5", pData[playerid][pGuns][4]);
	cache_get_value_name_int(0, "Gun6", pData[playerid][pGuns][5]);
	cache_get_value_name_int(0, "Gun7", pData[playerid][pGuns][6]);
	cache_get_value_name_int(0, "Gun8", pData[playerid][pGuns][7]);
	cache_get_value_name_int(0, "Gun9", pData[playerid][pGuns][8]);
	cache_get_value_name_int(0, "Gun10", pData[playerid][pGuns][9]);
	cache_get_value_name_int(0, "Gun11", pData[playerid][pGuns][10]);
	cache_get_value_name_int(0, "Gun12", pData[playerid][pGuns][11]);
	cache_get_value_name_int(0, "Gun13", pData[playerid][pGuns][12]);
	
	cache_get_value_name_int(0, "Ammo1", pData[playerid][pAmmo][0]);
	cache_get_value_name_int(0, "Ammo2", pData[playerid][pAmmo][1]);
	cache_get_value_name_int(0, "Ammo3", pData[playerid][pAmmo][2]);
	cache_get_value_name_int(0, "Ammo4", pData[playerid][pAmmo][3]);
	cache_get_value_name_int(0, "Ammo5", pData[playerid][pAmmo][4]);
	cache_get_value_name_int(0, "Ammo6", pData[playerid][pAmmo][5]);
	cache_get_value_name_int(0, "Ammo7", pData[playerid][pAmmo][6]);
	cache_get_value_name_int(0, "Ammo8", pData[playerid][pAmmo][7]);
	cache_get_value_name_int(0, "Ammo9", pData[playerid][pAmmo][8]);
	cache_get_value_name_int(0, "Ammo10", pData[playerid][pAmmo][9]);
	cache_get_value_name_int(0, "Ammo11", pData[playerid][pAmmo][10]);
	cache_get_value_name_int(0, "Ammo12", pData[playerid][pAmmo][11]);
	cache_get_value_name_int(0, "Ammo13", pData[playerid][pAmmo][12]);

	/*
	cache_get_value_name(0, "AmmoType", str);
	sscanf(str, "p<|>ddddddddddddd", pData[playerid][pAmmoSurplus][0], pData[playerid][pAmmoSurplus][1], pData[playerid][pAmmoSurplus][2],
	pData[playerid][pAmmoSurplus][3], pData[playerid][pAmmoSurplus][4], pData[playerid][pAmmoSurplus][5],
	pData[playerid][pAmmoSurplus][6], pData[playerid][pAmmoSurplus][7], pData[playerid][pAmmoSurplus][8],
	pData[playerid][pAmmoSurplus][9], pData[playerid][pAmmoSurplus][10], pData[playerid][pAmmoSurplus][11],
	pData[playerid][pAmmoSurplus][12]);*/

	cache_get_value_name_int(0, "claimsp", pData[playerid][pClaimSP]);

	cache_get_value_name_int(0, "flylic", pData[playerid][pFlyLic]);
	cache_get_value_name_int(0, "flylic_time", pData[playerid][pFlyLicTime]);
	cache_get_value_name_int(0, "boatlic", pData[playerid][pBoatLic]);
	cache_get_value_name_int(0, "boatlic_time", pData[playerid][pBoatLicTime]);
	cache_get_value_name_int(0, "gunlic", pData[playerid][pGunLic]);
	cache_get_value_name_int(0, "gunlic_time", pData[playerid][pGunLicTime]);
	cache_get_value_name_int(0, "trucker", pData[playerid][pTruckerLic]);
	cache_get_value_name_int(0, "trucker_time", pData[playerid][pTruckerLicTime]);
	cache_get_value_name_int(0, "lumber", pData[playerid][pLumberLic]);
	cache_get_value_name_int(0, "lumber_time", pData[playerid][pLumberLicTime]);
	cache_get_value_name_int(0, "training_time", pData[playerid][pTrainingTime]);
	//cache_get_value_name_int(0, "lastlogin", pData[playerid][pLastLogin]);
	
	//pData[playerid][pAdmin] = UcpData[playerid][uAdmin];

	if(pData[playerid][pMinerTime] <= -1) {
		pData[playerid][pMinerTime] = 0;
	}
	if(pData[playerid][pLumberTime] <= -1) {
		pData[playerid][pLumberTime] = 0;
	}
	if(pData[playerid][pFishTime] <= -1) {
		pData[playerid][pFishTime] = 0;
	}
	if(pData[playerid][pBusTime] <= -1) {
		pData[playerid][pBusTime] = 0;
	}
	if(pData[playerid][pSweeperTime] <= -1) {
		pData[playerid][pSweeperTime] = 0;
	}
	if(pData[playerid][pForkliftTime] <= -1) {
		pData[playerid][pForkliftTime] = 0;
	}
	if(pData[playerid][pCourierTime] <= -1) {
		pData[playerid][pCourierTime] = 0;
	}
	if(pData[playerid][pAdvertiseTime] <= -1) {
		pData[playerid][pAdvertiseTime] = 0;
	}
	if(pData[playerid][pTrashMasterTime] <= -1) {
		pData[playerid][pTrashMasterTime] = 0;
	}
	if(pData[playerid][pTrainingTime] <= -1) {
		pData[playerid][pTrainingTime] = 0;
	}
	
	for (new i; i < 17; i++)
	{
		WeaponSettings[playerid][i][Position][0] = -0.116;
		WeaponSettings[playerid][i][Position][1] = 0.189;
		WeaponSettings[playerid][i][Position][2] = 0.088;
		WeaponSettings[playerid][i][Position][3] = 0.0;
		WeaponSettings[playerid][i][Position][4] = 44.5;
		WeaponSettings[playerid][i][Position][5] = 0.0;
		WeaponSettings[playerid][i][Bone] = 1;
		WeaponSettings[playerid][i][Hidden] = false;
	}
	WeaponTick[playerid] = 0;
	EditingWeapon[playerid] = 0;
	new string[128];
	mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM weaponsettings WHERE Owner = '%d'", pData[playerid][pID]);
	mysql_tquery(g_SQL, string, "OnWeaponsLoaded", "d", playerid);

	mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM `inventory` WHERE `ID` = '%d'", pData[playerid][pID]);
	mysql_tquery(g_SQL, string, "LoadPlayerItems", "d", playerid);

	mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM contacts WHERE ID = '%d'", pData[playerid][pID]);
	mysql_tquery(g_SQL, string, "OnContactsLoad", "d", playerid);	

	mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM baju WHERE Owner='%s' LIMIT 1", pData[playerid][pName]);
	mysql_tquery(g_SQL, string, "LoadPlayerBajus", "i", playerid);
	
	KillTimer(pData[playerid][LoginTimer]);
	pData[playerid][LoginTimer] = 0;
	pData[playerid][IsLoggedIn] = true;

	SetSpawnInfo(playerid, NO_TEAM, pData[playerid][pSkin], pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ], pData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	
	MySQL_LoadPlayerToys(playerid);

	SendClientMessageEx(playerid, X11_LIGHTGREEN, "SERVER: "WHITE"Selamat datang "YELLOW"%s", ReturnName(playerid));
	SendClientMessageEx(playerid, X11_LIGHTGREEN, "SERVER: "WHITE"Jangan lupa patuhi & ikuti semua rules yang tersedia di "LIGHTBLUE"Discord");
	Info(playerid, "Today is "YELLOW"%s", ReturnTime());
	Custom(playerid, "LAST-LOGIN", "Your last login is "LIGHTGREEN"%s", pData[playerid][pLastLogin]);
	Info(playerid, "Loaded your Character database in {FFFF00}%d ms", GetPlayerPing(playerid));
	
	InfoTD_MSG(playerid, 3000, "Character ~g~Loaded");

	foreach(new ii : Player)
	{
		if(pData[ii][IsLoggedIn] == true)
		{
			if(pData[ii][pTogLog] == 0) SendClientMessageEx(ii, COLOR_GREY, "* %s(%d) Telah bergabung ke dalam server", pData[playerid][pName], playerid);
		}
	}
	return 1;
}

function OnPlayerRegister(playerid)
{
	if(pData[playerid][IsLoggedIn] == true)
		return Error(playerid, "You already logged in!");
		
	pData[playerid][pID] = cache_insert_id();
	pData[playerid][IsLoggedIn] = true;

	//pData[playerid][pPosX] = DEFAULT_POS_X;
	//pData[playerid][pPosY] = DEFAULT_POS_Y;
	//pData[playerid][pPosZ] = DEFAULT_POS_Z;
	//pData[playerid][pPosA] = DEFAULT_POS_A;
	pData[playerid][pInt] = 0;
	pData[playerid][pWorld] = 0;
	//pData[playerid][pGender] = 0;
	
	format(pData[playerid][pAdminname], MAX_PLAYER_NAME, "None");
	format(pData[playerid][pEmail], 40, "None");
	pData[playerid][pHealth] = 100.0;
	pData[playerid][pArmour] = 0.0;
	pData[playerid][pLevel] = 1;
	pData[playerid][pHunger] = 100;
	pData[playerid][pBladder] = 100;
	pData[playerid][pEnergy] = 100;
	pData[playerid][pMoney] = 250;
	pData[playerid][pBankMoney] = 200;
	/*new rand = RandomEx(111111, 999999);
	new rek = rand+pData[playerid][pID];
	pData[playerid][pBankRek] = rek;*/
	
	new query[128], rand = RandomEx(111111, 999999);
	new rek = rand+pData[playerid][pID];
	mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
	mysql_tquery(g_SQL, query, "BankRek", "id", playerid, rek);
	
	Custom(playerid, "REGISTER", "Berhasil mendaftarkan nama character anda");
	PlayerTextDrawSetString(playerid, RegisterChar[playerid][4], sprintf("%s", pData[playerid][pName]));
	pData[playerid][pTempCreateChar] = true;
	//SetSpawnInfo(playerid, NO_TEAM, 0, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ], pData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
	//SpawnPlayer(playerid);
	return 1;
}

function BankRek(playerid, brek)
{
	if(cache_num_rows() > 0)
	{
		//Rekening Exist
		new query[128], rand = RandomEx(11111, 99999);
		new rek = rand+pData[playerid][pID];
		mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
		mysql_tquery(g_SQL, query, "BankRek", "is", playerid, rek);
		Info(playerid, "Your Bank rekening number is same with someone. We will research new.");
	}
	else
	{
		new query[128];
	    mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET brek='%d' WHERE reg_id=%d", brek, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		pData[playerid][pBankRek] = brek;
	}
    return true;
}

function PhoneNumber(playerid, phone)
{
	if(cache_num_rows() > 0)
	{
		//Rekening Exist
		new query[128], rand = RandomEx(1111, 9888);
		new phones = rand+pData[playerid][pID];
		mysql_format(g_SQL, query, sizeof(query), "SELECT phone FROM players WHERE phone='%d'", phones);
		mysql_tquery(g_SQL, query, "PhoneNumber", "is", playerid, phones);
		Info(playerid, "Your Phone number is same with someone. We will research new.");
	}
	else
	{
		new query[128];
	    mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET phone='%d' WHERE reg_id=%d", phone, pData[playerid][pID]);
		mysql_tquery(g_SQL, query);
		Inventory_Add(playerid, "Phone", 18867);
		pData[playerid][pPhone] = phone;
	}
    return true;
}

function OnLoginTimeout(playerid)
{
	pData[playerid][LoginTimer] = 0;

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have been kicked for taking too long to login successfully to your account.", "Okay", "");
	KickEx(playerid);
	return 1;
}


function _KickPlayerDelayed(playerid)
{
	Kick(playerid);
	return 1;
}

function SafeLogin(playerid)
{

	// Main Menu Features.
	SetPlayerVirtualWorld(playerid, 0);
	
	// if(!IsValidRoleplayName(pData[playerid][pName]))
    // {
    //     Error(playerid, "Nama tidak sesuai format untuk server mode roleplay.");
    //     Error(playerid, "Penggunaan nama harus mengikuti format Firstname_Lastname.");
    //     Error(playerid, "Sebagai contoh, Steven_Dreschler, Nick_Raymond, dll.");
    //     KickEx(playerid);
    // }
}

//---------[ Textdraw ]----------

// Info textdraw timer for hiding the textdraw
function InfoTD_MSG(playerid, ms_time, text[])
{
	if(GetPVarInt(playerid, "InfoTDshown") != -1)
	{
	    PlayerTextDrawHide(playerid, InfoTD[playerid]);
	    KillTimer(GetPVarInt(playerid, "InfoTDshown"));
	}

    PlayerTextDrawSetString(playerid, InfoTD[playerid], text);
    PlayerTextDrawShow(playerid, InfoTD[playerid]);
	SetPVarInt(playerid, "InfoTDshown", SetTimerEx("InfoTD_Hide", ms_time, false, "i", playerid));
	return 1;
}

function InfoTD_Hide(playerid)
{
	SetPVarInt(playerid, "InfoTDshown", -1);
	PlayerTextDrawHide(playerid, InfoTD[playerid]);
}

//---------[ Twitter Function ]---------
function a_ChangeTwitterName(otherplayer, playerid, twname[])
{
	if(cache_num_rows() > 0)
	{
		// Name Exists
		Error(playerid, "Akun "DARK_E"'%s' "GREY_E"Telah ada! Harap gunakan yang lain", twname);
	}
	else
	{
		new query[512];
	    format(query, sizeof(query), "UPDATE players SET twittername='%e' WHERE reg_id=%d", twname, pData[otherplayer][pID]);
		mysql_tquery(g_SQL, query);
		format(pData[otherplayer][pTwittername], MAX_PLAYER_NAME, "%s", twname);
		Servers(playerid, "You has set twitter name player %s to %s", pData[otherplayer][pName], twname);
	}
    return true;
}

//---------[Admin Function ]----------

function a_ChangeAdminName(otherplayer, playerid, nname[])
{
	if(cache_num_rows() > 0)
	{
		// Name Exists
		Error(playerid, "Akun "DARK_E"'%s' "GREY_E"Telah ada! Harap gunakan yang lain", nname);
	}
	else
	{
		new query[512];
	    format(query, sizeof(query), "UPDATE players SET adminname='%e' WHERE reg_id=%d", nname, pData[otherplayer][pID]);
		mysql_tquery(g_SQL, query);
		format(pData[otherplayer][pAdminname], MAX_PLAYER_NAME, "%s", nname);
		Servers(playerid, "You has set admin name player %s to %s", pData[otherplayer][pName], nname);
	}
    return true;
}

function LoadStats(playerid, PlayersName[])
{
	if(!cache_num_rows())
	{
		Error(playerid, "Account '%s' does not exist.", PlayersName);
	}
	else
	{
		new email[40], admin, helper, level, levelup, vip, viptime, coin, regdate[40], lastlogin[40], money, bmoney, brek,
			jam, menit, detik, gender, age[40], faction, family, warn, job, job2, int, world;
		cache_get_value_index(0, 0, email);
		cache_get_value_index_int(0, 1, admin);
		cache_get_value_index_int(0, 2, helper);
		cache_get_value_index_int(0, 3, level);
		cache_get_value_index_int(0, 4, levelup);
		cache_get_value_index_int(0, 5, vip);
		cache_get_value_index_int(0, 6, viptime);
		cache_get_value_index_int(0, 7, coin);
		cache_get_value_index(0, 8, regdate);
		cache_get_value_index(0, 9, lastlogin);
		cache_get_value_index_int(0, 10, money);
		cache_get_value_index_int(0, 11, bmoney);
		cache_get_value_index_int(0, 12, brek);
		cache_get_value_index_int(0, 13, jam);
		cache_get_value_index_int(0, 14, menit);
		cache_get_value_index_int(0, 15, detik);
		cache_get_value_index_int(0, 16, gender);
		cache_get_value_index(0, 17, age);
		cache_get_value_index_int(0, 18, faction);
		cache_get_value_index_int(0, 19, family);
		cache_get_value_index_int(0, 20, warn);
		cache_get_value_index_int(0, 21, job);
		cache_get_value_index_int(0, 22, job2);
		cache_get_value_index_int(0, 23, int);
		cache_get_value_index_int(0, 24, world);
		
		new header[248], scoremath = ((level)*5), fac[24], Cache:checkfamily, gstr[2468], query[128];
	
		if(faction == 1)
		{
			fac = "San Andreas Police";
		}
		else if(faction == 2)
		{
			fac = "San Andreas Goverment";
		}
		else if(faction == 3)
		{
			fac = "San Andreas Medic";
		}
		else if(faction == 4)
		{
			fac = "San Andreas News";
		}
		else
		{
			fac = "None";
		}
		
		new name[40];
		if(admin == 1)
		{
			name = ""RED_E"Administrator(1)";
		}
		else if(admin == 2)
		{
			name = ""RED_E"Senior Admin(2)";
		}
		else if(admin == 3)
		{
			name = ""RED_E"Lead Admin(3)";
		}
		else if(admin == 4)
		{
			name = ""RED_E"Head Admin(4)";
		}
		else if(admin== 5)
		{
			name = ""RED_E"Server Owner(5)";
		}
		else if(helper >= 1 && admin == 0)
		{
			name = ""GREEN_E"Helper";
		}
		else
		{
			name = "None";
		}
		
		new name1[30];
		if(vip == 1)
		{
			name1 = ""LG_E"Regular(1)";
		}
		else if(vip == 2)
		{
			name1 = ""YELLOW_E"Premium(2)";
		}
		else if(vip == 3)
		{
			name1 = ""PURPLE_E"VIP Player(3)";
		}
		else
		{
			name1 = "None";
		}
		
		format(query, sizeof(query), "SELECT * FROM `familys` WHERE `ID`='%d'", family);
		checkfamily = mysql_query(g_SQL, query);

		new atext[512];

		new boost = pData[playerid][pBooster];
		new boosttime = pData[playerid][pBoostTime];
		if(boost == 1)
		{
			atext = "{7fff00}Yes";
		}
		else 
		{
			atext = "{ff0000}No";
		}
		
		new rows = cache_num_rows(), fname[128];
		
		if(rows)
		{
			new fam[128];
			cache_get_value_name(0, "name", fam);
			format(fname, 128, fam);
		}
		else
		{
			format(fname, 128, "None");
		}
		
		format(header,sizeof(header),"Stats:"YELLOW_E"%s"WHITE_E" ("BLUE_E"%s"WHITE_E")", PlayersName, ReturnTime());
		format(gstr,sizeof(gstr),""RED_E"In Character"WHITE_E"\n");
		format(gstr,sizeof(gstr),"%sGender: [%s] | Money: ["GREEN_E"%s"WHITE_E"] | Bank: ["GREEN_E"%s"WHITE_E"] | Rekening Bank: [%d] | Phone Number: [None]\n", gstr,(gender == 2) ? ("Female") : ("Male") , FormatMoney(money), FormatMoney(bmoney), brek);
		format(gstr,sizeof(gstr),"%sBirdthdate: [%s] | Job: [None] | Job2: [None] | Faction: [%s] | Family: [%s]\n\n", gstr, age, fac, fname);
		format(gstr,sizeof(gstr),"%s"RED_E"Out of Character"WHITE_E"\n",gstr);
		format(gstr,sizeof(gstr),"%sLevel score: [%d/%d] | Email: [%s] | Warning:[%d/10] | Last Login: [%s]\n", gstr, levelup, scoremath, email, warn, lastlogin);
		format(gstr,sizeof(gstr),"%sStaff: [%s"WHITE_E"] | Time Played: [%d hour(s) %d minute(s) %02d second(s)] | Gold Coin: [%d]\n", gstr, name, jam, menit, detik, coin);
		if(vip != 0)
		{
			format(gstr,sizeof(gstr),"%sInterior: [%d] | Virtual World: [%d] | Register Date: [%s] | VIP Level: [%s"WHITE_E"] | VIP Time: [%s] | Roleplay Booster: [%s"WHITE_E"] | Boost Time: [%s]", gstr, int, world, regdate, name1, ReturnTimelapse(gettime(), viptime), boost, ReturnTimelapse(gettime(), boosttime));
		}
		else
		{
			format(gstr,sizeof(gstr),"%sInterior: [%d] | Virtual World: [%d] | Register Date: [%s] | VIP Level: [%s"WHITE_E"] | VIP Time: [None] | Roleplay Booster: [%s"WHITE_E"] | Boost Time: [%s]", gstr, int, world, regdate, name1, boost, ReturnTimelapse(gettime(), boosttime));
		}
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, header, gstr, "Close", "");
		
		cache_delete(checkfamily);
	}
	return true;
}

function CheckPlayerIP(playerid, zplayerIP[])
{
	new count = cache_num_rows(), datez, line[248], tstr[64], lstr[128];
	if(count)
	{
		datez = 0;
 		line = "";
 		format(line, sizeof(line), "Names matching IP: %s:\n\n", zplayerIP);
 		for(new i = 0; i != count; i++)
		{
			// Get the name  ache and append it to the dialog content
			cache_get_value_index(i, 0, lstr);
			strcat(line, lstr);
			datez ++;

			if(datez == 5)
				strcat(line, "\n"), datez = 0;
			else
				strcat(line, "\t\t");
		}

		tstr = "{ACB5BA}Aliases for {70CAFA}", strcat(tstr, zplayerIP);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, tstr, line, "Close", "");
	}
	else
 	{
		Error(playerid, "No other accounts from this IP!");
	}
	return 1;
}

function CheckPlayerIP2(playerid, zplayerIP[])
{
	new rows = cache_num_rows(), datez, line[248], tstr[64], lstr[128];
	if(!rows)
	{
		Error(playerid, "No other accounts from this IP!");
	}
	else
 	{
 		datez = 0;
 		line = "";
 		format(line, sizeof(line), "Names matching IP: %s:\n\n", zplayerIP);
 		for(new i = 0; i != rows; i++)
		{
			// Get the name from the cache and append it to the dialog content
			cache_get_value_index(i, 0, lstr);
			strcat(line, lstr);
			datez ++;

			if(datez == 5)
				strcat(line, "\n"), datez = 0;
			else
				strcat(line, "\t\t");
		}

		tstr = "{ACB5BA}Aliases for {70CAFA}", strcat(tstr, zplayerIP);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, tstr, line, "Close", "");
	}
	return 1;
}

function JailPlayer(playerid)
{
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	SetPlayerPositionEx(playerid, -310.64, 1894.41, 34.05, 178.17, 2000);
	SetPlayerInterior(playerid, 10);
	SetPlayerVirtualWorld(playerid, 100);
	SetPlayerWantedLevel(playerid, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	//ResetPlayerWeaponsEx(playerid);
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInBasement] = -1;
	pData[playerid][pInDoor] = -1;
	pData[playerid][pCuffed] = 0;
	PlayerPlaySound(playerid, 1186, 0, 0, 0);
	return true;
}

//-----------[ Banneds Function ]----------

function OnOBanQueryData(adminid, NameToBan[], banReason[], banTime)
{
	new mstr[512];
	mstr = "";
	if(!cache_num_rows())
	{
		Error(adminid, "Account '%s' does not exist.", NameToBan);
	}
	else
	{
		new datez, PlayerIP[16];
		cache_get_value_index(0, 0, PlayerIP);
		if(banTime != 0)
	    {
			datez = gettime() + (banTime * 86400);
            Servers(adminid, "You have temp-banned %s (IP: %s) from the server.", NameToBan, PlayerIP);
			SendClientMessageToAllEx(COLOR_RED, "Server: "GREY2_E"Admin %s telah membanned offline player %s selama %d hari. [Reason: %s]", pData[adminid][pAdminname], NameToBan, banTime, banReason);
		}
		else
		{
			Servers(adminid, "You have permanent-banned %s (IP: %s) from the server.", NameToBan, PlayerIP);
			SendClientMessageToAllEx(COLOR_RED, "Server: "GREY2_E"Admin %s telah membanned offline player %s secara permanent. [Reason: %s]", pData[adminid][pAdminname], NameToBan, banReason);
		}
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', '%s', '%s', UNIX_TIMESTAMP(), %d)", NameToBan, PlayerIP, pData[adminid][pAdminname], banReason, datez);
		mysql_tquery(g_SQL, query);
	}
	return true;
}


//-------------[ Player Update Function ]----------
stock GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
 	GetPlayerName(playerid,name,sizeof(name));
	return name;
}

function DragUpdate(playerid, targetid)
{
    if(pData[targetid][pDragged] && pData[targetid][pDraggedBy] == playerid)
    {
        static
        Float:fX,
        Float:fY,
        Float:fZ,
        Float:fAngle;

        GetPlayerPos(playerid, fX, fY, fZ);
        GetPlayerFacingAngle(playerid, fAngle);

        fX -= 3.0 * floatsin(-fAngle, degrees);
        fY -= 3.0 * floatcos(-fAngle, degrees);

        SetPlayerPos(targetid, fX, fY, fZ);
        SetPlayerInterior(targetid, GetPlayerInterior(playerid));
        SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
		//ApplyAnimation(targetid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
		ApplyAnimation(targetid,"PED","WALK_civi",4.1,1,1,1,1,1);
    }
    return 1;
}

function UnfreezePee(playerid)
{
    TogglePlayerControllable(playerid, 1);
    pData[playerid][pBladder] = 100;
    ClearAnimations(playerid);
	StopLoopingAnim(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}

function UnfreezeSleep(playerid)
{
    TogglePlayerControllable(playerid, 1);
    pData[playerid][pEnergy] = 100;
	pData[playerid][pHunger] -= 3;
    ClearAnimations(playerid);
	StopLoopingAnim(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	InfoTD_MSG(playerid, 3000, "Sleeping Done!");
	return 1;
}

function RefullCar(playerid, vehicleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	//if(!IsValidVehicle(vehicleid)) return 0;
	if(!pData[playerid][pActivity]) return 0;
	if(GetNearestVehicleToPlayer(playerid, 3.8, false) == vehicleid)
    {
		if(pData[playerid][pActivityTime] >= 100 && IsValidVehicle(vehicleid))
		{
			new fuels = GetVehicleFuel(vehicleid);
		
			SetVehicleFuel(vehicleid, fuels+30);
			InfoTD_MSG(playerid, 8000, "Refulling done!");
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has successfully refulling the vehicle.", ReturnName(playerid));
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		}
		else if(pData[playerid][pActivityTime] < 100 && IsValidVehicle(vehicleid))
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
		else
		{
			Error(playerid, "Refulling fail! Anda tidak berada didekat kendaraan tersebut!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		}
	}
	else
	{
		Error(playerid, "Refulling fail! Anda tidak berada didekat kendaraan tersebut!");
		KillTimer(pData[playerid][pActivity]);
		pData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		return 1;
	}
	return 1;
}

//Bank
function SearchRek(playerid, rek)
{
	if(!cache_num_rows())
	{
		// Rekening tidak ada
		Error(playerid, "Rekening bank "YELLOW_E"'%d' "WHITE_E"tidak terdaftar!", rek);
		pData[playerid][pTransfer] = 0;
	    
	}
	else
	{
	    // Proceed
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT username,brek FROM players WHERE brek='%d'", rek);
		mysql_tquery(g_SQL, query, "SearchRek2", "id", playerid, rek);
	}
}

function SearchRek2(playerid, rek)
{
	if(cache_num_rows())
	{
		new name[128], brek, mstr[128];
		cache_get_value_index(0, 0, name);
		cache_get_value_index_int(0, 1, brek);
		
		//format(pData[playerid][pTransferName], 128, "%s" name);
		pData[playerid][pTransferName] = name;
		pData[playerid][pTransferRek] = brek;
		format(mstr, sizeof(mstr), ""WHITE_E"No Rek Target: "YELLOW_E"%d\n"WHITE_E"Nama Target: "YELLOW_E"%s\n"WHITE_E"Jumlah: "GREEN_E"%s\n\n"WHITE_E"Anda yakin akan melanjutkan mentransfer?", brek, name, FormatMoney(pData[playerid][pTransfer]));
		ShowPlayerDialog(playerid, DIALOG_BANKCONFIRM, DIALOG_STYLE_MSGBOX, ""LB_E"Bank", mstr, "Transfer", "Cancel");
	}
	return true;
}

//----------[ JOB FUNCTION ]-------------

//Server Timer
function pCountDown()
{
	Count--;
	if(0 >= Count)
	{
		Count = -1;
		KillTimer(countTimer);
		foreach(new ii : Player)
		{
 			if(showCD[ii] == 1)
   			{
   				GameTextForPlayer(ii, "~w~GO~r~!~g~!~b~!", 2500, 6);
   				PlayerPlaySound(ii, 1057, 0, 0, 0);
   				showCD[ii] = 0;
   				if(IsAtEvent[ii] == 1)
   				{
   					TogglePlayerControllable(ii, 1);
   				}
			}
		}
	}
	else
	{
		foreach(new ii : Player)
		{
 			if(showCD[ii] == 1)
   			{
				GameTextForPlayer(ii, CountText[Count-1], 2500, 6);
				PlayerPlaySound(ii, 1056, 0, 0, 0);
   			}
		}
	}
	return 1;
}


//----------[ Other Function ]-----------

function SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z, Float:a)
{
    if(!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
        return 0;

    pData[playerid][pFreeze] = 0;
    SetPlayerPos(playerid, x, y, z);
	SetPlayerFacingAngle(playerid, a);
    TogglePlayerControllable(playerid, 1);
    return 1;
}

function SetVehicleToUnfreeze(playerid, vehicleid, Float:x, Float:y, Float:z, Float:a)
{
    if(!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
        return 0;

    pData[playerid][pFreeze] = 0;
    SetVehiclePos(vehicleid, x, y, z);
	SetVehicleZAngle(vehicleid, a);
    TogglePlayerControllable(playerid, 1);
    return 1;
}

forward CheckUCP(playerid, nameucp[]);
public CheckUCP(playerid, nameucp[])
{
	new count = cache_num_rows(), datez, line[248], tstr[64], lstr[128];
	if(count)
	{
		datez = 0;
 		line = "";
 		format(line, sizeof(line), "List Karakter Yang Dimiliki:\n\n", nameucp);
 		for(new i = 0; i != count; i++)
		{
			// Get the name  ache and append it to the dialog content
			cache_get_value_index(i, 0, lstr);
			strcat(line, lstr);
			datez ++;

			if(datez == 5)
				strcat(line, "\n"), datez = 0;
			else
				strcat(line, "\n");
		}

		tstr = "UCP: {FFFF00}", strcat(tstr, nameucp);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, tstr, line, "Tutup", "");
	}
	else
 	{
		Error(playerid, "UCP %s tidak di temukan", nameucp);
	}
	return 1;
}

GetVehicleNumberPlate(vehicleid, dest[], len = sizeof(dest)) {
    new id = -1;
    if ((id = Vehicle_GetID(vehicleid)) != -1) {
        format(dest,len,"%s",pvData[id][cPlate]);
    } else format(dest,len,"STATIC");
}

GetVehicleNameByModel(model)
{
    new
        name[32] = "None";

    if(model < 400 || model > 611)
        return name;

    format(name, sizeof(name), g_arrVehicleNames[model - 400]);
    return name;
}


GetVehicleNameByVehicle(vehicleid)
{
    new
        model = GetVehicleModel(vehicleid),
        name[32] = "None";

    if(model < 400 || model > 611)
        return name;

    format(name, sizeof(name), g_arrVehicleNames[model - 400]);
    return name;
}

GetPlayerCity(playerid)
{
    new Float:x;
    new Float:y;
    new Float:z;
    GetPlayerPos(playerid, x, y, z);

    new cities[3][ZoneInfoEnum] =
    {
        {-2997.47, -1213.91, -1115.58, 1659.68, -242.99, 900.0, "San Fierro"},
        {869.461, 2997.06, 596.349, 2993.87, -242.99, 900.0, "Las Venturas"},
        {44.6147, 2997.06, -2892.97, -768.027, -242.99, 900.0, "Los Santos"}
    };

    new cityName[64];
    for(new i=0; i<3; i++)
    {
        if(cities[i][zonePosx1] < x && cities[i][zonePosx2] > x)
        {
            if(cities[i][zonePosy1] < y && cities[i][zonePosy2] > y)
            {
                format(cityName,64,"%s",cities[i][ZoneName]);
            }
        }
    }
    return cityName;
}

stock GetWeekDay(day=0, month=0, year=0)
{
	if(!day)
			getdate(year, month, day);
	new
		szWeekDay[17],
		j,
		e;

	if(month <= 2)
	{
		month += 12;
		--year;
	}

	j = year % 100;
	e = year / 100;

	switch((day + (month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7)
	{
		case 0: szWeekDay = "Sat";
		case 1: szWeekDay = "Sun";
		case 2: szWeekDay = "Mon";
		case 3: szWeekDay = "Tue";
		case 4: szWeekDay = "Wed";
		case 5: szWeekDay = "Thu";
		case 6: szWeekDay = "Fri";
	}
	return szWeekDay;
}

stock GetMonthName(Month)
{
	new MonthName[12];

	switch(Month)
	{
		case 1: MonthName = "Jan";
		case 2: MonthName = "Febr";
		case 3: MonthName = "Mar";
		case 4: MonthName = "Apr";
		case 5: MonthName = "May";
		case 6: MonthName = "Jun";
		case 7: MonthName = "Jul";
		case 8: MonthName = "Aug";
		case 9: MonthName = "Sept";
		case 10: MonthName = "Oct";
		case 11: MonthName = "Nov";
		case 12: MonthName = "Dec";
	}

	return MonthName;
}

stock GetDay(Day)
{
	new str[12];
	switch(Day)
	{
		case 1: str = "1";
		case 2: str = "2";
		case 3: str = "3";
		case 4: str = "4";
		case 5: str = "5";
		case 6: str = "6";
		case 7: str = "7";
		case 8: str = "8";
		case 9: str = "9";
		case 10: str = "10";
		case 11: str = "11";
		case 12: str = "12";
		case 13: str = "13";
		case 14: str = "14";
		case 15: str = "15";
		case 16: str = "16";
		case 17: str = "17";
		case 18: str = "18";
		case 19: str = "19";
		case 20: str = "20";
		case 21: str = "21";
		case 22: str = "22";
		case 23: str = "23";
		case 24: str = "24";
		case 25: str = "25";
		case 26: str = "26";
		case 27: str = "27";
		case 28: str = "28";
		case 29: str = "29";
		case 30: str = "30";
		case 31: str = "31";
	}
	return str;
}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance) // By Y_Less
{
    new Float:a;
    GetPlayerPos(playerid, x, y, a);
    GetPlayerFacingAngle(playerid, a);

    if(GetPlayerVehicleID(playerid))
        GetVehicleZAngle(GetPlayerVehicleID(playerid), a);

    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
}

RotateDynamicObject(objectid, Float:rotX, Float:rotY, Float:rotZ, Float:Speed)
{
	new Float:X, Float:Y, Float:Z;
	new Float:SpeedConverted = floatmul(Speed, 0.01);
	GetDynamicObjectPos(objectid, X, Y, Z);
	SetDynamicObjectPos(objectid, X, Y, floatadd(Z, 0.01));
	MoveDynamicObject(objectid, X, Y, Z, SpeedConverted, rotX, rotY, rotZ);
	return 1;
}

House_Inside(playerid)
{
    if(pData[playerid][pInHouse] != -1)
    {
        foreach (new i : Houses) if(i == pData[playerid][pInHouse] && GetPlayerInterior(playerid) == hData[i][hInt] && GetPlayerVirtualWorld(playerid) > 0) {
            return i;
        }
    }
    return -1;
}