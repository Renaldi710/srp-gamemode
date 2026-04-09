//-------------[ Player Commands ]-------------//
CMD:help(playerid, params[])
{
	new str[512], info[512];
	format(str, sizeof(str), "Pengguna Akun\nGeneral\nSistem Kendaraan\nPekerjaan\nFaction/Family\nAuto RP\nBusiness System\nHouse System\nWorkshop System\nDonate\nServer Credits\n");
	strcat(info, str);
	if(pData[playerid][pRobLeader] > 1 || pData[playerid][pMemberRob] > 1)
	{
		format(str, sizeof(str), "Robbery Help");
		strcat(info, str);	
	}
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Basic Help Menu", info, "Select", "Close");
	return 1;
}

CMD:destroycp(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(pData[playerid][pSideJob] > 1 || pData[playerid][pCP] > 1)
		return Error(playerid, "Harap selesaikan Pekerjaan mu terlebih dahulu");

	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	Servers(playerid, "Menghapus Checkpoint Sukses");
	return 1;
}

CMD:credits(playerid)
{
	new line1[1200], line2[300], line3[500];
	strcat(line3, ""LB_E"Coder: "YELLOW_E"Dandy overall , Pateeer for Update\n");
	strcat(line3, ""LB_E"Helped by: "YELLOW_E"Pajaar\n");
	strcat(line3, ""LB_E"Managed by: "YELLOW_E"Ian (Silence)\n");
	strcat(line3, ""LB_E"Support Mapper: "YELLOW_E"Dandy and his Friends, Pateer, Pajaar\n");
	strcat(line3, ""LB_E"Support Website: "YELLOW_E"Pateeer\n");
	format(line2, sizeof(line2), ""LB_E"Server Support: "YELLOW_E"%s & All SA-MP Team\n\n\
	"GREEN_E"Terima kasih telah bergabung dengan kami! Copyright © 2020 | Pateeer.", pData[playerid][pName]);
	format(line1, sizeof(line1), "%s%s", line3, line2);
   	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"North Country: "WHITE_E"Server Credits", line1, "OK", "");
	return 1;
}

CMD:vip(playerid)
{
	new longstr2[3500];
	strcat(longstr2, ""YELLOW_E"Looking for bonus features and commands? Get premium status today!\n\n"RED_E"Premium features:\n\
	"dot""GREEN_E"Regular(1) "PINK_E"Rp.30.000/month"RED_E"|| "PINK_E"Features:\n\
	"YELLOW_E"1) "WHITE_E"Gratis "LB_E"20 "WHITE_E"VIP Gold.\n");
	strcat(longstr2, ""YELLOW_E"2) "WHITE_E"Mendapat "GREEN_E"2 "WHITE_E"slot job.\n");

	strcat(longstr2, ""YELLOW_E"3) "WHITE_E"Akses custom VIP room dan VIP locker.\n\
	"YELLOW_E"4) "WHITE_E"Mempunya "LB_E"4 "WHITE_E"slot untuk kendaraan pribadi.\n\
	"YELLOW_E"5) "WHITE_E"Mempunya "LB_E"2 "WHITE_E"Slot untuk rumah.\n");
	strcat(longstr2, ""YELLOW_E"6) "WHITE_E"Mempunyai "LB_E"2 "WHITE_E"slot untuk bisnis.\n\
	"YELLOW_E"7) "WHITE_E"Akses VIP chat dan VIP status "LB_E"/vips"WHITE_E".\n");
	strcat(longstr2, ""YELLOW_E"8) "WHITE_E"Waktu Paycheck/Payday "LB_E"5% "WHITE_E"lebih cepat.\n\
	"YELLOW_E"9) "WHITE_E"Mendapatkan "LB_E"10% "WHITE_E"bunga bank setiap kali paycheck.");


	strcat(longstr2, "\n\n"dot""YELLOW_E"Premium(2) "PINK_E"Rp.50,000/month "RED_E"|| "PINK_E"Features:\n\
	"YELLOW_E"1) "WHITE_E"Gratis "LB_E"30"WHITE_E" VIP Gold.\n\
	"YELLOW_E"2) "WHITE_E"Mendapat "GREEN_E"2 "WHITE_E"slot job.\n");
	strcat(longstr2, ""YELLOW_E"3) "WHITE_E"Akses custom VIP room dan VIP locker.\n\
	"YELLOW_E"4) "WHITE_E"Mempunyai "LB_E"5 "WHITE_E"slot untuk kendaraan pribadi.");

	strcat(longstr2, "\n"YELLOW_E"5) "WHITE_E"Mempunyai "LB_E"3 "WHITE_E"Slot untuk rumah.\n\
	"YELLOW_E"6) "WHITE_E"Mempunyai "LB_E"3 "WHITE_E"slot untuk bisnis.\n\
	"YELLOW_E"7) "WHITE_E"Akses VIP chat dan VIP status "LB_E"/vips"WHITE_E".\n");
	strcat(longstr2, ""YELLOW_E"8) "WHITE_E"Waktu Paycheck/Payday "LB_E"10% "WHITE_E"lebih cepat\n\
	"YELLOW_E"9) "WHITE_E"Mendapatkan "LB_E"15% "WHITE_E"bunga bank setiap kali paycheck.");

	strcat(longstr2, "\n\n"dot""PURPLE_E"VIP Player(3) "PINK_E"Rp.80,000/month "RED_E"|| "PINK_E"Features:\n\
	"YELLOW_E"1) "WHITE_E"Gratis "LB_E"40 "WHITE_E"VIP Gold.\n\
	"YELLOW_E"2) "WHITE_E"Mendapat "GREEN_E"2 "WHITE_E"slot job.\n\
	"YELLOW_E"3) "WHITE_E"Akses custom VIP room dan VIP locker.");
	strcat(longstr2, "\n"YELLOW_E"4) "WHITE_E"Mempunyai "LB_E"6 "WHITE_E"slot untuk kendaraan pribadi.\n\
	"YELLOW_E"5) "WHITE_E"Mempunyai "LB_E"4 "WHITE_E"Slot untuk rumah.\n\
	"YELLOW_E"6) "WHITE_E"Mempunyai "LB_E"4 "WHITE_E"slot untuk bisnis.\n\
	"YELLOW_E"7) "WHITE_E"Akses VIP chat dan VIP status "LB_E"/vips"WHITE_E".");
	strcat(longstr2, "\n"YELLOW_E"8) "WHITE_E"Waktu Paycheck/Payday "LB_E"15% "WHITE_E"lebih cepat.\n\
	"YELLOW_E"9) "WHITE_E"Mendapatkan "LB_E"20% "WHITE_E"bunga bank setiap kali paycheck.");

	strcat(longstr2, "\n\n"LB_E"Pembayaran Via Pulsa/Paypal/Bank BRI/Unipin. "LB2_E"Harga VIP Gold "LB_E"Rp.1,000/gold.\n\
	"YELLOW_E"Untuk informasi selengkapnya hubungi Dandy_Prasetyo(Server Owner & Founder)!");
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"North Country "PINK_E"VIP SYSTEM", longstr2, "Close", "");
	return 1;
}

CMD:donate(playerid)
{
    new line3[3500];
    strcat(line3, ""RED_E"...:::... "DOOM_"Donate List Basic Roleplay "RED_E"...:::...\n");
    strcat(line3, ""RED_E"..:.. "DOOM_"GOLD(OOC) "RED_E"..:..\n\n");

    strcat(line3, ""DOOM_"1. 250 Gold >> "RED_E"Rp 15.000\n");
    strcat(line3, ""DOOM_"2. 525 Gold >> "RED_E"Rp 25.000\n");
	strcat(line3, ""DOOM_"3. 1125 Gold >> "RED_E"Rp 50.000\n");
    strcat(line3, ""DOOM_"4. 2150 Gold >> "RED_E"Rp 100.000\n");
	strcat(line3, ""DOOM_"5. 3125 Gold >> "RED_E"Rp 150.000\n");
    strcat(line3, ""DOOM_"6. 4200 Gold >> "RED_E"Rp 200.000\n\n");

    strcat(line3, ""RED_E"..:.. "PINK_E"RP BOOSTER "RED_E"..:..\n\n");

    strcat(line3, ""DOOM_"1. 7 Days >> "RED_E"Rp 15.000\n");
    strcat(line3, ""DOOM_"2. 14 Days >> "RED_E"Rp 25.000\n");
	strcat(line3, ""DOOM_"3. 30 Days >> "RED_E"Rp 50.000/Boost Discord\n");
    strcat(line3, ""DOOM_"4. 60 Days >> "RED_E"Rp 100.000/Boost Discord\n");
	strcat(line3, ""DOOM_"5. 80 Days >> "RED_E"Rp 150.000/Boost Discord\n");
    strcat(line3, ""DOOM_"6. 130 Days >> "RED_E"Rp 200.000/Boost Discord\n\n");

	strcat(line3, ""RED_E"..::.. "DOOM_"VIP PLAYER "RED_E"..::..\n\n");
	
    strcat(line3, ""DOOM_"1. VIP Regular(1 Month) >> "RED_E"500 Gold\n");
    strcat(line3, ""DOOM_"2. VIP Premium(1 Month) >> "RED_E"900 Gold\n");
    strcat(line3, ""DOOM_"3. VIP Platinum(1 Month) >> "RED_E"1200 Gold\n\n");

	strcat(line3, ""RED_E"..:::.. "DOOM_"SERVER FEATURE "RED_E"..:::..\n\n");
    strcat(line3, ""DOOM_"1. Mapping(per object) >> "RED_E"60 Gold\n");
	strcat(line3, ""DOOM_"2. Private Door >> "RED_E"100 Gold\n");
	strcat(line3, ""DOOM_"3. Private Gate >> "RED_E"200 Gold\n");
	strcat(line3, ""DOOM_"4. Bisnis >> "RED_E"(Tergantung Lokasi)\n");
	strcat(line3, ""DOOM_"5. House >> "RED_E"(Tergantung Lokasi dan Type)\n");
	strcat(line3, ""DOOM_"6. Custom House Interior >> "RED_E"(Tergantung Interior)\n\n");
	
	strcat(line3, ""RED_E"..::::.. "DOOM_"SERVER VEHICLE "RED_E"..:::::..\n\n");
    strcat(line3, ""DOOM_"1. VEHICLE IN DEALER >> "RED_E"1200 Gold\n");
	strcat(line3, ""DOOM_"2. VEHICLE NON DEALER >> "RED_E"1800 Gold\n");
	strcat(line3, ""DOOM_"3. BOAT / HELI >> "RED_E"2300 Gold\n\n");

    strcat(line3, ""RED_E"..::.. "WHITE_E"CONTACT INFO "RED_E"..::..\n");
    strcat(line3, ""WHITE_E"1. NAMA : "RED_E"Pajaar\n");
    strcat(line3, ""WHITE_E"-  INSTAGRAM: "RED_E"@fajaar_riz1\n\n");
	
    strcat(line3, ""WHITE_E"2. NAMA : "RED_E"Patir(Pateeer)\n");
    strcat(line3, ""WHITE_E"-  WA : "RED_E"089637007084\n\n");

    strcat(line3, ""RED_E"..::.. "WHITE_E"NOTE "RED_E"..::..\n");
    strcat(line3, ""WHITE_E"Note: "RED_E"Pembayaran Via Rekening Bank BRI, PayPal, Gopay, Dana, Saweria!\n\n");

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Basic: "WHITE_E"DONATE LIST", line3, "Okay", "");
	return 1;
}

CMD:togphone(playerid)
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(Inventory_Count(playerid, "Phone") == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	if(pData[playerid][pUsePhone] == 1)
	{
		pData[playerid][pUsePhone] = 0;
		pData[playerid][pTogPhone] = 0;
		Servers(playerid, "Berhasil mematikan Handphone");
		return 0;
	}
	if(pData[playerid][pUsePhone] == 0)
	{
		pData[playerid][pUsePhone] = 1;
		Servers(playerid, "Berhasil menyalakan Handphone");
		return 0;
	}
	return 1;
}

CMD:email(playerid)
{
    if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu harus login!");

	ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, ""WHITE_E"Set Email", ""WHITE_E"Masukkan Email.\nIni akan digunakan sebagai ganti kata sandi.\n\n"RED_E"* "WHITE_E"Email mu tidak akan termunculkan untuk Publik\n"RED_E"* "WHITE_E"Email hanya berguna untuk verifikasi Password yang terlupakan dan berita lainnya\n\
	"RED_E"* "WHITE_E"Be sure to double-check and enter a valid email address!", "Enter", "Exit");
	return 1;
}

CMD:changepass(playerid)
{
    if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu harus login sebelum menggantinya!");

	ShowPlayerDialog(playerid, DIALOG_PASSWORD, DIALOG_STYLE_INPUT, ""WHITE_E"Change your password", "Masukkan Password untuk menggantinya!", "Change", "Exit");
	InfoTD_MSG(playerid, 3000, "~g~~h~Masukkan password yang sebelum nya anda pakai!");
	return 1;
}

CMD:savestats(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu belum login!");
		
	UpdatePlayerData(playerid);
	Servers(playerid, "Statistik Anda sukses disimpan kedalam Database!");
	return 1;
}

CMD:gshop(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new Dstring[512];
	format(Dstring, sizeof(Dstring), "Gold Shop\tPrice\n\
	Instant Change Name\t500 Gold\n");
	format(Dstring, sizeof(Dstring), "%sClear Warning\t1000 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 1(7 Days)\t150 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 2(7 Days)\t250 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 3(7 Days)\t500 Gold\n", Dstring);
	ShowPlayerDialog(playerid, DIALOG_GOLDSHOP, DIALOG_STYLE_TABLIST_HEADERS, "Gold Shop", Dstring, "Buy", "Cancel");
	return 1;
}

CMD:mypos(playerid, params[])
{
	new int, Float:px,Float:py,Float:pz, Float:a;
	GetPlayerPos(playerid, px, py, pz);
	GetPlayerFacingAngle(playerid, a);
	int = GetPlayerInterior(playerid);
	new zone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, zone, sizeof(zone));
	SendClientMessageEx(playerid, COLOR_WHITE, "Lokasi Anda Saat Ini: %s (%0.2f, %0.2f, %0.2f, %0.2f) Int = %d", zone, px, py, pz, a, int);
	return 1;
}

CMD:gps(playerid, params[])
{
	if(Inventory_Count(playerid, "GPS") < 1) return Error(playerid, "Anda tidak memiliki GPS.");
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Disable GPS\nPublic GPS\nFind Business\nFind Workshop\nFind Gas Station\nFind Public Parking\nFind Furniture Store\nFind Tree\nMy Property\nJobs", "Select", "Close");
	return 1;
}

CMD:death(playerid, params[])
{
    if(pData[playerid][pInjured] == 0)
        return Error(playerid, "Kamu belum injured.");
		
	if(pData[playerid][pJail] > 0)
		return Error(playerid, "Kamu tidak bisa menggunakan ini saat diJail!");
		
	if(pData[playerid][pArrest] > 0)
		return Error(playerid, "Kamu tidak bisa melakukan ini saat tertangkap polisi!");

    if((gettime()-GetPVarInt(playerid, "GiveUptime")) < 100)
        return Error(playerid, "Kamu harus menunggu 3 menit untuk kembali kerumah sakit");
        
	/*if(pMatiPukul[playerid] == 1)
	{
	    SetPlayerHealthEx(playerid, 50.0);
	    ClearAnimations(playerid);
	    pData[playerid][pInjured] = 0;
	    pMatiPukul[playerid] = 0;
    	Servers(playerid, "You have wake up and accepted death in your position.");
    	return 1;
	}*/
    Servers(playerid, "Kamu telah terbangun dari pingsan.");
	pData[playerid][pHospitalTime] = 0;
	pData[playerid][pHospital] = 1;
    return 1;
}

CMD:piss(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

    if(pData[playerid][pInjured] == 1)
        return Error(playerid, "Kamu tidak bisa melakukan ini disaat yang tidak tepat!");
        
	new time = (100 - pData[playerid][pBladder]) * (300);
    SetTimerEx("UnfreezePee", time, 0, "i", playerid);
    SetPlayerSpecialAction(playerid, 68);
    return 1;
}

CMD:health(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new hstring[512], info[512];
	new hh = pData[playerid][pHead];
	new hp = pData[playerid][pPerut];
	new htk = pData[playerid][pRHand];
	new htka = pData[playerid][pLHand];
	new hkk = pData[playerid][pRFoot];
	new hkka = pData[playerid][pLFoot];
	format(hstring, sizeof(hstring),"Bagian Tubuh\tKondisi\n{ffffff}Kepala\t{7fffd4}%d.0%\n{ffffff}Perut\t{7fffd4}%d.0%\n{ffffff}Tangan Kanan\t{7fffd4}%d.0%\n{ffffff}Tangan Kiri\t{7fffd4}%d.0%\n",hh,hp,htk,htka);
	strcat(info, hstring);
    format(hstring, sizeof(hstring),"{ffffff}Kaki Kanan\t{7fffd4}%d.0%\n{ffffff}Kaki Kiri\t{7fffd4}%d.0%\n",hkk,hkka);
    strcat(info, hstring);
    ShowPlayerDialog(playerid, DIALOG_HEALTH, DIALOG_STYLE_TABLIST_HEADERS,"Health Condition",info,"Oke","");
    return 1;
}

CMD:sleep(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(pData[playerid][pInjured] == 1)
        return Error(playerid, "Kamu tidak bisa melakukan ini disaat yang tidak tepat!");
	
	if(pData[playerid][pInHouse] == -1)
		return Error(playerid, "Kamu tidak berada didalam rumah.");
	
	InfoTD_MSG(playerid, 10000, "Sleeping... Harap Tunggu");
	TogglePlayerControllable(playerid, 0);
	new time = (100 - pData[playerid][pEnergy]) * (400);
    SetTimerEx("UnfreezeSleep", time, 0, "i", playerid);
	switch(random(6))
	{
		case 0: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_L",4.1,0,0,0,1,1);
		case 1: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_R",4.1,0,0,0,1,1);
		case 2: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_L",4.1,1,0,0,1,1);
		case 3: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_R",4.1,1,0,0,1,1);
		case 4: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_L",4.1,0,1,1,0,0);
		case 5: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_R",4.1,0,1,1,0,0);
	}
	return 1;
}

/*CMD:salary(playerid, params[])
{
	new query[256], count;
	format(query, sizeof(query), "SELECT * FROM salary WHERE owner='%d'", pData[playerid][pID]);
	new Cache:result = mysql_query(g_SQL, query);
	new rows = cache_num_rows();
	if(rows) 
	{
		new str[2048];
		for(new i; i < rows; i++)
		{
			new info[64];
			cache_get_value_int(i, "id", pSalary[playerid][i][salaryId]);
			cache_get_value_int(i, "money", pSalary[playerid][i][salaryMoney]);
			cache_get_value(i, "info", info);
			format(pSalary[playerid][i][salaryInfo], 64, "%s", info);
			cache_get_value_int(i, "date", pSalary[playerid][i][salaryDate]);
			
			format(str, sizeof(str), "%s%s\t%s\t%s\n", str, ReturnDate(pSalary[playerid][i][salaryDate]), pSalary[playerid][i][salaryInfo], FormatMoney(pSalary[playerid][i][salaryMoney]));
			count++;
			if(count >= 10) break;
		}
		format(str, sizeof(str), "Date\tInfo\tCash\n", str);
		if(count >= 10)
		{
			format(str, sizeof(str), "%s\nNext >>>", str);
		}
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Salary Details", str, "Close", "");
	}
	else 
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Notice", "Kamu tidak memiliki salary saat ini!", "Ok", "");
	}
	cache_delete(result);
	return 1;
}*/

CMD:time(playerid)
{
	if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu harus login!");
		
	new line2[1200];
	new paycheck = 3600 - pData[playerid][pPaycheck];
	if(paycheck < 1)
	{
		paycheck = 0;
	}
	
	format(line2, sizeof(line2), ""WHITE_E"Paycheck Time: "YELLOW_E"%d remaining\n"WHITE_E"Delay Job: "RED_E"%d Detik\n"WHITE_E"Delay Side Job: "RED_E"%d Detik\n"WHITE_E"Plant Time(Farmer): "RED_E"%d Detik\n"WHITE_E"Arrest Time: "RED_E"%d Detik\n"WHITE_E"Jail Time: "RED_E"%d Detik\n", paycheck, pData[playerid][pJobTime], pData[playerid][pSideJobTime], pData[playerid][pPlantTime], pData[playerid][pArrestTime], pData[playerid][pJailTime]);
   	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"North Country: "WHITE_E"Time", line2, "Oke", "");
	return 1;
}

CMD:delays(playerid)
{
	if(pData[playerid][IsLoggedIn] == false) 
		return Error(playerid, "You must logged in!");
	
	new 
		string[700],
		minutes
	;

	minutes = (pData[playerid][pExitJob] - gettime()) / 60;

  	format(string, sizeof(string), "Delay type\tTime (minutes)\n");
    format(string, sizeof(string), "%sTrucker Crate\t%d\nMiner\t%d\nLumberjack\t%d\nFishing\t%d\nBus Driver\t%d\nSweeper Driver\t%d\nForklift Driver\t%d\nCourier\t%d\nAdvertisement\t%d\nExit Job\t%d", 
    string, 
    pData[playerid][pTruckerCrateTime]/60,
    pData[playerid][pMinerTime]/60,
    pData[playerid][pLumberTime]/60,
    pData[playerid][pFishTime]/60,
    pData[playerid][pBusTime]/60,
    pData[playerid][pSweeperTime]/60,
    pData[playerid][pForkliftTime]/60,
	pData[playerid][pCourierTime]/60,
	pData[playerid][pAdvertiseTime]/60,
	minutes);

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Delays", string, "Close", "");
	return 1;
}

CMD:idcard(playerid, params[])
{
	if(pData[playerid][pIDCard] == 0) return Error(playerid, "Anda tidak memiliki id card!");
	new sext[40];
	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	SendNearbyMessage(playerid, 20.0, COLOR_GREEN, "[ID-Card] "GREY3_E"Name: %s | Gender: %s | Brithday: %s | Expire: %s.", pData[playerid][pName], sext, pData[playerid][pAge], ReturnTimelapse(gettime(), pData[playerid][pIDCardTime]));
	return 1;
}

CMD:drivelic(playerid, params[])
{
	if(pData[playerid][pDriveLic] == 0) return Error(playerid, "Anda tidak memiliki Driving License/SIM!");
	new sext[40];
	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	SendNearbyMessage(playerid, 20.0, COLOR_GREEN, "[Drive-Lic] "GREY3_E"Name: %s | Gender: %s | Brithday: %s | Expire: %s.", pData[playerid][pName], sext, pData[playerid][pAge], ReturnTimelapse(gettime(), pData[playerid][pDriveLicTime]));
	return 1;
}

CMD:newidcard(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1395.9802,-29.4111,1013.9901)) return Error(playerid, "Anda harus berada di City Hall!");
	if(pData[playerid][pIDCard] != 0) return Error(playerid, "Anda sudah memiliki ID Card!");
	if(GetPlayerMoney(playerid) < 50) return Error(playerid, "Anda butuh $50 untuk membuat ID Card");
	new sext[40], mstr[128];
	if(pData[playerid][pGender] == 1) { sext = "Laki-Laki"; } else { sext = "Perempuan"; }
	format(mstr, sizeof(mstr), "{FFFFFF}Nama: %s\nNegara: San Andreas\nTgl Lahir: %s\nJenis Kelamin: %s\nBerlaku hingga 14 hari!", pData[playerid][pName], pData[playerid][pAge], sext);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "ID-Card", mstr, "Tutup", "");
	pData[playerid][pIDCard] = 1;
	pData[playerid][pIDCardTime] = gettime() + (15 * 86400);
	GivePlayerMoneyEx(playerid, -50);
	Server_AddMoney(25);
	return 1;
}

CMD:newage(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1395.9802,-29.4111,1013.9901)) return Error(playerid, "Anda harus berada di City Hall!");
	//if(pData[playerid][pIDCard] != 0) return Error(playerid, "Anda sudah memiliki ID Card!");
	if(GetPlayerMoney(playerid) < 300) return Error(playerid, "Anda butuh $300 untuk mengganti tgl lahir anda!");
	if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Anda harus login terlebih dahulu!");
	ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Change", "Cancel");
	return 1;
}

CMD:newdrivelic(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 252.22, 117.43, 1003.21)) return Error(playerid, "Anda harus berada di SAPD!");
	if(pData[playerid][pDriveLic] != 0) return Error(playerid, "Anda sudah memiliki Driving License!");
	if(GetPlayerMoney(playerid) < 200) return Error(playerid, "Anda butuh $200 untuk membuat Driving License.");
	new sext[40], mstr[128];
	if(pData[playerid][pGender] == 1) { sext = "Laki-Laki"; } else { sext = "Perempuan"; }
	format(mstr, sizeof(mstr), "{FFFFFF}Nama: %s\nNegara: San Andreas\nTgl Lahir: %s\nJenis Kelamin: %s\nBerlaku hingga 14 hari!", pData[playerid][pName], pData[playerid][pAge], sext);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Driving License", mstr, "Tutup", "");
	pData[playerid][pDriveLic] = 1;
	pData[playerid][pDriveLicTime] = gettime() + (15 * 86400);
	GivePlayerMoneyEx(playerid, -200);
	Server_AddMoney(200);
	return 1;
}

/*CMD:buyplate(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1389.5691,-23.1329,1000.9911)) return Error(playerid, "Anda harus berada di SAPD!");
	
	new bool:found = false, msg2[512], Float:fx, Float:fy, Float:fz;
	format(msg2, sizeof(msg2), "ID\tModel\tPlate\tPlate Time\n");
	foreach(new i : PVehicles)
	{
		if(pvData[i][cExtraID] == pData[playerid][pID])
		{
			if(strcmp(pvData[i][cPlate], "NoHave"))
			{
				GetVehiclePos(pvData[i][cVeh], fx, fy, fz);
				format(msg2, sizeof(msg2), "%s%d\t%s\t%s\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));
				found = true;
			}
			else
			{
				GetVehiclePos(pvData[i][cVeh], fx, fy, fz);
				format(msg2, sizeof(msg2), "%s%d\t%s\t%s\tNone\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate]);
				found = true;
			}
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_BUYPLATE, DIALOG_STYLE_TABLIST_HEADERS, "Vehicles Plate", msg2, "Buy", "Close");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles Plate", "Anda tidak memeliki kendaraan", "Close", "");
			
	return 1;
}*/

CMD:payticket(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1386.8989,-23.1341,1000.9911)) return Error(playerid, "Anda harus berada di kantor SAPD!");
	
	new vehid;
	if(sscanf(params, "d", vehid))
		return Usage(playerid, "/payticket [vehid] | (/mypv) - for find vehid");
		
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return Error(playerid, "Invalid id");
		
	foreach(new i : PVehicles)
	{
		if(GetVehicleType(i) == VEHICLE_TYPE_PLAYER)
		{
			if(vehid == pvData[i][cVeh])
			{
				if(pvData[i][cExtraID] == pData[playerid][pID])
				{
					new ticket = pvData[i][cTicket];
					
					if(ticket > GetPlayerMoney(playerid))
						return Error(playerid, "Not enough money! check your ticket in /v insu.");
						
					if(ticket > 0)
					{
						GivePlayerMoneyEx(playerid, -ticket);
						pvData[i][cTicket] = 0;
						Info(playerid, "Anda telah berhasil membayar ticket tilang kendaraan "YELLOW"%s(id: %d) "WHITE"sebesar "GREEN"%s", GetVehicleName(vehid), vehid, FormatMoney(ticket));
						return 1;
					}
				}
				else return Error(playerid, "Kendaraan ini bukan milik anda! (/mypv) - for find vehid");
			}
		}
	}
	return 1;
}

CMD:buyplate(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1389.5691,-23.1329,1000.9911)) return Error(playerid, "Anda harus berada di SAPD!");
		
	new vehid;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/buyplate [vehid] | (/mypv) - for find vehid");
	
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return Error(playerid, "Invalid id");
			
	foreach(new i : PVehicles)
	{
		if(GetVehicleType(i) == VEHICLE_TYPE_PLAYER)
		{
			if(vehid == pvData[i][cVeh])
			{
				if(pvData[i][cExtraID] == pData[playerid][pID])
				{
					if(GetPlayerMoney(playerid) < 500) return Error(playerid, "Anda butuh $500 untuk membeli Plate baru.");
					GivePlayerMoneyEx(playerid, -500);
					new rand = RandomEx(1111, 9999);
					format(pvData[i][cPlate], 32, "LP-%d", rand);
					SetVehicleNumberPlate(pvData[i][cVeh], pvData[i][cPlate]);
					pvData[i][cPlateTime] = gettime() + (15 * 86400);
					Info(playerid, "Model: %s || New plate: %s || Plate Time: %s || Plate Price: $500", GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));
				}
				else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan (/mypv) untuk mencari ID.");
			}
		}
	}
	return 1;
}

CMD:buyinsu(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1395.82, -20.65, 1000.97)) return Error(playerid, "Anda harus berada di Insurance Center!");
		
	new vehid;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/buyinsu [vehid] | (mypv) - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
			
	foreach(new i : PVehicles)
	{
		if(GetVehicleType(i) == VEHICLE_TYPE_PLAYER)
		{
			if(vehid == pvData[i][cVeh])
			{
				if(pvData[i][cExtraID] == pData[playerid][pID] && pvData[i][cClaim] == 0)
				{
					if(GetPlayerMoney(playerid) < 500) return Error(playerid, "Anda butuh $500 untuk membeli Insurance.");
					GivePlayerMoneyEx(playerid, -500);
					pvData[i][cInsu]++;
					Info(playerid, "Model: %s || Total Insurance: %d || Insurance Price: $500", GetVehicleModelName(pvData[i][cModel]), pvData[i][cInsu]);
				}
				else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan (/mypv) untuk mencari ID.");
			}
		}
	}
	return 1;
}
/*
CMD:claimpv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1667.9655,-1408.8066,13.5497)) return Error(playerid, "Anda harus berada di City Hall!");
	new found = 0;
	foreach(new i : PVehicles)
	{
		if(pvData[i][cClaim] == 1 && pvData[i][cClaimTime] == 0)
		{
			if(pvData[i][cExtraID] == pData[playerid][pID])
			{
				pvData[i][cClaim] = 0;
				
				OnPlayerVehicleRespawn(i);
				pvData[i][cPosX] = 1657.0167;
				pvData[i][cPosY] = -1428.1921;
				pvData[i][cPosZ] = 13.2738;
				pvData[i][cPosA] = 178.2211;
				SetValidVehicleHealth(pvData[i][cVeh], 1500);
				SetVehiclePos(pvData[i][cVeh], 1657.0167,-1428.1921,13.2738);
				SetVehicleZAngle(pvData[i][cVeh], 178.2211);
				SetVehicleFuel(pvData[i][cVeh], 1000);
				found++;
				Info(playerid, "Anda telah mengclaim kendaraan %s anda.", GetVehicleModelName(pvData[i][cModel]));
			}
			//else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan (/mypv) untuk mencari ID.");
		}
	}
	if(found == 0)
	{
		Info(playerid, "Sekarang belum saatnya anda mengclaim kendaraan anda!");
	}
	else
	{
		Info(playerid, "Anda berhasil mengclaim %d kendaraan anda!", found);
	}
	return 1;
}*/
CMD:claimpv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1667.9655,-1408.8066,13.5497))
		return Error(playerid, "Anda harus berada di Asuransi!");

	if(GetVehiclesInsurance(playerid) == 0)
		return Error(playerid, "Belum saat nya anda mengambil kendaraan /myinsu");

	new vehid, _tmpstring[128], count = GetVehiclesInsurance(playerid), CMDSString[1024];
	CMDSString = "";
	
	Loop(itt, (count + 1), 1)
	{
	    vehid = ReturnPVehiclesInsuID(playerid, itt);
		if(itt == count)
		{
		    format(_tmpstring, sizeof(_tmpstring), "%d\t%s\tClaimed\n", itt, GetVehicleModelName(pvData[vehid][cModel]));
		}
		else format(_tmpstring, sizeof(_tmpstring), "%d\t%s\tClaimed\n", itt, GetVehicleModelName(pvData[vehid][cModel]));
		strcat(CMDSString, _tmpstring);
	}
	Dialog_Show(playerid, VEHICLE_INSURANCE, DIALOG_STYLE_LIST, "Claim Vehicles Insurance", CMDSString, "Select", "Cancel");
	return 1;
}

CMD:sellpv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1395.82, -20.65, 1000.97)) return Error(playerid, "Anda harus berada di City Hall!");
	
	new vehid;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/sellpv [vehid] | (mypv) - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
			
	foreach(new i : PVehicles)
	{
		if(GetVehicleType(i) == VEHICLE_TYPE_PLAYER)
		{
			if(vehid == pvData[i][cVeh])
			{
				if(pvData[i][cExtraID] == pData[playerid][pID])
				{
					if(!IsValidVehicle(pvData[i][cVeh])) return Error(playerid, "Your vehicle is not spanwed!");
					if(pvData[i][cRent] != 0) return Error(playerid, "You can't sell rental vehicle!");
					new pay = pvData[i][cPrice] / 2;
					GivePlayerMoneyEx(playerid, pay);
					
					Info(playerid, "Anda menjual kendaraan model "YELLOW"%s(%d) "WHITE"dengan seharga "GREEN"%s", GetVehicleName(vehid), GetVehicleModel(vehid), FormatMoney(pay));
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[i][cID]);
					mysql_tquery(g_SQL, query);
					if(IsValidVehicle(pvData[i][cVeh])) DestroyVehicle(pvData[i][cVeh]);
					pvData[i][cVeh] = INVALID_VEHICLE_ID;

					Car_RemoveAllItems(i);

					Iter_SafeRemove(PVehicles, i, i);
				}
				else return Error(playerid, "ID kendaraan ini bukan punya mu! gunakan (/mypv) untuk mencari ID.");
			}
		}
	}
	return 1;
}

CMD:newrek(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2246.55, -1750.25, 1014.77)) return Error(playerid, "Anda harus berada di Bank!");
	if(GetPlayerMoney(playerid) < 50) return Error(playerid, "Not enough money!");
	new query[128], rand = RandomEx(111111, 999999);
	new rek = rand+pData[playerid][pID];
	mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
	mysql_tquery(g_SQL, query, "BankRek", "id", playerid, rek);
	Info(playerid, "New rekening bank!");
	GivePlayerMoneyEx(playerid, -50);
	Server_AddMoney(50);
	return 1;
}

CMD:bank(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2246.55, -1750.25, 1014.77)) return Error(playerid, "Anda harus berada di bank point!");
	new tstr[128];
	format(tstr, sizeof(tstr), ""ORANGE_E"No Rek: "LB_E"%d", pData[playerid][pBankRek]);
	ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, tstr, "Deposit Money\nWithdraw Money\nCheck Balance\nTransfer Money\nSign Paycheck", "Select", "Cancel");
	return 1;
}

CMD:pay(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new money, otherid, mstr[128];
	if(sscanf(params, "ud", otherid, money))
	{
	    Usage(playerid, "/pay <ID/Name> <amount>");
	    return true;
	}
	
	if(pData[playerid][pLevel] < 2)
		return Error(playerid, "You must level 2 to pay!");

	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");

 	if(otherid == playerid)
		return Error(playerid, "You can't send yourself money!");
	if(pData[playerid][pMoney] < money)
		return Error(playerid, "You don't have enough money to send!");
	if(money > 1000000 && pData[playerid][pAdmin] == 0)
		return Error(playerid, "You can't send more than $1,000,000 at once!");
	if(money < 1)
		return Error(playerid, "You can't send anyone less than $1!");
		
	/*GivePlayerMoneyEx(otherid, money);
	GivePlayerMoneyEx(playerid, -money);

	format(mstr, sizeof(mstr), "Server: "YELLOW_E"You have sent %s(%i) "GREEN_E"%s", pName[otherid], otherid, FormatMoney(money));
	SendClientMessage(playerid, COLOR_GREY, mstr);
	format(mstr, sizeof(mstr), "Server: "YELLOW_E"%s(%i) has sent you "GREEN_E"%s", pName[playerid], playerid, FormatMoney(money));
	SendClientMessage(otherid, COLOR_GREY, mstr);
	InfoTD_MSG(playerid, 3500, "~g~~h~Money Sent!");
	InfoTD_MSG(otherid, 3500, "~g~~h~Money received!");
	ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
	ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
	
	new OtherIP[16];
	GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
	GetPlayerIp(otherid, OtherIP, sizeof(OtherIP));
	SendStaffMessage(COLOR_RED, "[PAYINFO] "WHITE_E"%s(%d)[IP: %d] pay to %s(%d)[IP: %d] ammount "GREEN_E"%s", pName[playerid], playerid, PlayerIP, pName[otherid], otherid, OtherIP, FormatMoney(money));*/
	format(mstr, sizeof(mstr), ""WHITEP_E"Are you sure you want to send %s(%d) "GREEN_E"%s?", ReturnName(otherid), otherid, FormatMoney(money));
	ShowPlayerDialog(playerid, DIALOG_PAY, DIALOG_STYLE_MSGBOX, ""GREEN_E"Send Money", mstr, "Send", "Cancel");

	SetPVarInt(playerid, "gcAmount", money);
	SetPVarInt(playerid, "gcPlayer", otherid);
	return 1;
}

CMD:togtw(playerid, params[])
{
	if(Inventory_Count(playerid, "Phone") == 0)
		return Error(playerid, "Anda belum memiliki Ponsel");

	if(pData[playerid][pUsePhone] < 1)
		return Error(playerid, "Anda belum menyalakan Ponsel");

	if(pData[playerid][pTwitter] < 1)
		return Error(playerid, "Anda belum memiliki Twitter, harap download!");

	if(pData[playerid][pTogPhone] == 1)
	{
		pData[playerid][pTogPhone] = 0;
		Servers(playerid, "Berhasil menutup Twitter");
	}
	else if(pData[playerid][pTogPhone] == 0)
	{
		if(pData[playerid][pKuota] < 20)
			return Error(playerid, "Kuota anda sisa %d, harap isi ulang", pData[playerid][pKuota]);

		pData[playerid][pTogPhone] = 1;
		Servers(playerid, "Berhasil membuka Twitter");
	}
	return 1;
}

CMD:tw(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Sistem Ini tidak dapat digunakan di OOC Zone");

	if(Inventory_Count(playerid, "Phone") == 0)
		return Error(playerid, "Anda belum memiliki Ponsel");

	if(pData[playerid][pUsePhone] < 1)
		return Error(playerid, "Ponsel anda sedang mati");

	if(pData[playerid][pTwitter] < 1)
		return Error(playerid, "Anda belum memiliki Twitter, harap download!");

	if(pData[playerid][pTogPhone] < 1)
		return Error(playerid, "Anda belum membuka twitter [/togtw]");

    if(!strcmp(pData[playerid][pTwittername], "None"))
		return Error(playerid, "Kamu harus setting Nama oleh Admin mu!");

	if(isnull(params))
	{
	    Usage(playerid, "/tw <text>");
	    return true;
	}

    // Decide about multi-line msgs
	new i = -1;
	new line[512];
	new payout = strlen(params) * 7;
	new kuotamb = pData[playerid][pKuota]/1000;
	if(pData[playerid][pKuota] < payout)
		return Error(playerid, "Kuota anda sisa %dmb untuk mengirim %d Character", kuotamb, strlen(params));

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
	format(mstr, sizeof(mstr), "{1e90ff}[TWITTER] {7fffd4}@%s :{ffffff}%s", pData[playerid][pTwittername], params);
	pData[playerid][pKuota] -= payout;
	foreach(new ii : Player) 
	{
		if(pData[ii][pTogPhone] > 0)
		{
			SendClientMessage(ii, COLOR_LB, mstr);	
		}
	}
	if(i != -1)
	{
		foreach(new ii : Player)
		{
			if(pData[ii][pTogPhone] > 0)
			{
				SendClientMessage(ii, COLOR_LB, line);
			}
		}
	}
	if(pData[playerid][pKuota] < 20)
    {
    	pData[playerid][pTogPhone] = 0;
    }
	return true;
}

CMD:stats(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	DisplayStats(playerid, playerid);
	return 1;
}

CMD:settings(playerid)
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	new str[1024], hbemode[64], togpm[64], toglog[64], togads[64], togwt[64];
	if(pData[playerid][pHBEMode] == 1)
	{
		hbemode = ""LG_E"Simple";
	}
	else if(pData[playerid][pHBEMode] == 2)
	{
		hbemode = ""LG_E"Modern";
	}
	else
	{
		hbemode = ""RED_E"Disable";
	}
	
	if(pData[playerid][pTogPM] == 0)
	{
		togpm = ""RED_E"Disable";
	}
	else
	{
		togpm = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogLog] == 0)
	{
		toglog = ""RED_E"Disable";
	}
	else
	{
		toglog = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogAds] == 0)
	{
		togads = ""RED_E"Disable";
	}
	else
	{
		togads = ""LG_E"Enable";
	}
	
	if(pData[playerid][pTogWT] == 0)
	{
		togwt = ""RED_E"Disable";
	}
	else
	{
		togwt = ""LG_E"Enable";
	}
	
	format(str, sizeof(str), "Settings\tStatus\n"WHITEP_E"Email:\t"GREY3_E"%s\n"WHITEP_E"Change Password\n"WHITEP_E"HUD HBE Mode:\t%s\n"WHITEP_E"Toggle PM:\t%s\n"WHITEP_E"Toggle Log Server:\t%s\n"WHITEP_E"Toggle Ads:\t%s\n"WHITEP_E"Toggle WT:\t%s",
	pData[playerid][pEmail], 
	hbemode, 
	togpm,
	toglog,
	togads,
	togwt
	);
	
	ShowPlayerDialog(playerid, DIALOG_SETTINGS, DIALOG_STYLE_TABLIST_HEADERS, "Settings", str, "Set", "Close");
	return 1;
}

/*
CMD:items(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check items!");
	    return true;
	}
	DisplayItems(playerid, playerid);
	return 1;
}*/

CMD:getjob(playerid, params[])
{
	if(pData[playerid][pIDCard] <= 0)
		return Error(playerid, "Anda tidak memiliki ID-Card.");
		
	if(pData[playerid][pVip] > 0)
	{
		if(pData[playerid][pJob] == 0 || pData[playerid][pJob2] == 0)
		{
			if(pData[playerid][pJob] == 0)
			{
				if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1685.3975,-1464.5696,13.6719))
				{
					pData[playerid][pGetJob] = 1;
					Info(playerid, "Anda telah berhasil mendaftarkan job Taxi. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2329.8792,-2315.4001,13.5469))
				{
					pData[playerid][pGetJob] = 2;
					Info(playerid, "Anda telah berhasil mendaftarkan job mechanic. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -1438.6384,-1544.8308,102.2578))
				{
					pData[playerid][pGetJob] = 3;
					Info(playerid, "Anda telah berhasil mendaftarkan job lumber jack. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07))
				{
					pData[playerid][pGetJob] = 4;
					Info(playerid, "Anda telah berhasil mendaftarkan job trucker. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 319.94, 874.77, 20.39))
				{
					pData[playerid][pGetJob] = 5;
					Info(playerid, "Anda telah berhasil mendaftarkan job miner. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -283.02, -2174.36, 28.66))
				{
					pData[playerid][pGetJob] = 6;
					Info(playerid, "Anda telah berhasil mendaftarkan job production. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -383.67, -1438.90, 26.32))
				{
					pData[playerid][pGetJob] = 7;
					Info(playerid, "Anda telah berhasil mendaftarkan job farmer. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				//arms dealer
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 321.5652,1121.2504,1083.8828))
				{
					if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
					pData[playerid][pGetJob] = 8;
					Info(playerid, "Anda telah berhasil mendaftarkan job arms dealer. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				//drug dealer
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2345.4207,-1184.7029,1027.9766))
				{
					if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
					pData[playerid][pGetJob] = 9;
					Info(playerid, "Anda telah berhasil mendaftarkan job drugs dealer. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, 1273.3732,392.2403,19.5614))
				{
					if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
					pData[playerid][pGetJob] = 12;
					Info(playerid, "Anda telah berhasil mendaftarkan job Smuggler. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else return Error(playerid, "Anda sudah memiliki job atau tidak berada di dekat pendaftaran job.");
			}
			else if(pData[playerid][pJob2] == 0)
			{
				if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1685.3975,-1464.5696,13.6719))
				{
					pData[playerid][pGetJob] = 1;
					Info(playerid, "Anda telah berhasil mendaftarkan job Taxi. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2329.8792,-2315.4001,13.5469))
				{
					pData[playerid][pGetJob] = 2;
					Info(playerid, "Anda telah berhasil mendaftarkan job mechanic. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -1438.6384,-1544.8308,102.2578))
				{
					pData[playerid][pGetJob2] = 3;
					Info(playerid, "Anda telah berhasil mendaftarkan job lumber jack. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07))
				{
					pData[playerid][pGetJob2] = 4;
					Info(playerid, "Anda telah berhasil mendaftarkan job trucker. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 319.94, 874.77, 20.39))
				{
					pData[playerid][pGetJob2] = 5;
					Info(playerid, "Anda telah berhasil mendaftarkan job miner. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -283.02, -2174.36, 28.66))
				{
					pData[playerid][pGetJob2] = 6;
					Info(playerid, "Anda telah berhasil mendaftarkan job production. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -383.67, -1438.90, 26.32))
				{
					pData[playerid][pGetJob2] = 7;
					Info(playerid, "Anda telah berhasil mendaftarkan job farmer. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				//arms dealer
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 321.5652,1121.2504,1083.8828))
				{
					if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
					pData[playerid][pGetJob] = 8;
					Info(playerid, "Anda telah berhasil mendaftarkan job arms dealer. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				//drug dealer
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2345.4207,-1184.7029,1027.9766))
				{
					if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
					pData[playerid][pGetJob] = 9;
					Info(playerid, "Anda telah berhasil mendaftarkan job drugs dealer. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}
				else if(pData[playerid][pJob2] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, 1273.3732,392.2403,19.5614))
				{
					if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
					pData[playerid][pGetJob2] = 12;
					Info(playerid, "Anda telah berhasil mendaftarkan job Smuggler. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
				}				
				else return Error(playerid, "Anda sudah memiliki job atau tidak berada di dekat pendaftaran job.");
			}
			else return Error(playerid, "Anda sudah memiliki 2 pekerjaan!");
		}
		else return Error(playerid, "Anda sudah memiliki 2 pekerjaan!");
	}
	else
	{
		if(pData[playerid][pJob] > 0)
			return Error(playerid, "Anda hanya bisa memiliki 1 pekerjaan!");
			
		if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1685.3975,-1464.5696,13.6719))
		{
			pData[playerid][pGetJob] = 1;
			Info(playerid, "Anda telah berhasil mendaftarkan job Taxi. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2329.8792,-2315.4001,13.5469))
		{
			pData[playerid][pGetJob] = 2;
			Info(playerid, "Anda telah berhasil mendaftarkan job mechanic. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -1438.6384,-1544.8308,102.2578))
		{
			pData[playerid][pGetJob] = 3;
			Info(playerid, "Anda telah berhasil mendaftarkan job lumber jack. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07))
		{
			pData[playerid][pGetJob] = 4;
			Info(playerid, "Anda telah berhasil mendaftarkan job trucker. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 319.94, 874.77, 20.39))
		{
			pData[playerid][pGetJob] = 5;
			Info(playerid, "Anda telah berhasil mendaftarkan job miner. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -283.02, -2174.36, 28.66))
		{
			pData[playerid][pGetJob] = 6;
			Info(playerid, "Anda telah berhasil mendaftarkan job production. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -383.67, -1438.90, 26.32))
		{
			pData[playerid][pGetJob] = 7;
			Info(playerid, "Anda telah berhasil mendaftarkan job farmer. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
		}
		//arms dealer
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 321.5652,1121.2504,1083.8828))
		{
			if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
			pData[playerid][pGetJob] = 8;
			Info(playerid, "Anda telah berhasil mendaftarkan job arms dealer. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
		}
		//drug dealer
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2345.4207,-1184.7029,1027.9766))
		{
			if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
			pData[playerid][pGetJob] = 9;
			Info(playerid, "Anda telah berhasil mendaftarkan job drugs dealer. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
		}
		else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, 1273.3732,392.2403,19.5614))
		{
			if(pData[playerid][pLevel] < 5) return Error(playerid, "Anda harus menjadi lv5 untuk memasuki job ini");
			pData[playerid][pGetJob] = 12;
			Info(playerid, "Anda telah berhasil mendaftarkan job Smuggler. "YELLOW"/accept job "WHITE"untuk konfirmasi.");
		}
		else return Error(playerid, "Anda sudah memiliki job atau tidak berada di dekat pendaftaran job.");
	}
	return 1;
}

CMD:frisk(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/frisk [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa memeriksa dirimu sendiri.");

    pData[otherid][pFriskOffer] = playerid;

    Info(otherid, ""LIGHTGREEN"%s "WHITE"has offered to frisk you "YELLOW"(type \"/accept frisk or /deny frisk\").", ReturnName(playerid));
    Info(playerid, "You have offered to frisk "YELLOW"%s.", ReturnName(otherid));
	return 1;
}

CMD:inspect(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/inspect [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa memeriksa dirimu sendiri.");

    pData[otherid][pInsOffer] = playerid;

    Info(otherid, ""LIGHTGREEN"%s "WHITE"has offered to inspect you "YELLOW"(type \"/accept inspect or /deny inspect\").", ReturnName(playerid));
    Info(playerid, "You have offered to inspect "YELLOW"%s.", ReturnName(otherid));
	return 1;
}

CMD:reqloc(playerid, params[])
{
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/reqloc [playerid/PartOfName]");

    if(Inventory_Count(playerid, "Phone") == 0)
    	return Error(playerid, "Anda tidak memiliki Handphone");

    if(pData[playerid][pUsePhone] == 0)
    	return Error(playerid, "Ponsel anda masih offline");

    if(Inventory_Count(playerid, "Phone") == 0)
    	return Error(playerid, "Tujuan tidak memiliki Handphone");

    if(pData[otherid][pUsePhone] == 0)
    	return Error(playerid, "Ponsel yang anda tuju masih offline");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa meminta lokasi kepada anda sendiri.");

    pData[otherid][pLocOffer] = playerid;

    Info(otherid, ""LIGHTGREEN"%s "WHITE"has offered to request share his location "YELLOW"(type \"/accept reqloc or /deny reqloc\").", ReturnName(playerid));
    Info(playerid, "You have offered to share your location "YELLOW"%s.", ReturnName(otherid));
	return 1;
}

CMD:accept(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /accept [name]");
            Info(playerid, "Names: faction, family, drag, frisk, inspect, job, reqloc, rob");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(IsPlayerConnected(pData[playerid][pFacOffer])) 
			{
                if(pData[playerid][pFacInvite] > 0) 
				{
                    pData[playerid][pFaction] = pData[playerid][pFacInvite];
					pData[playerid][pFactionRank] = 1;
					Info(playerid, "Anda telah menerima invite faction dari "LIGHTGREEN"%s", pData[pData[playerid][pFacOffer]][pName]);
					Info(pData[playerid][pFacOffer], ""YELLOW"%s "WHITE"telah menerima invite faction yang anda tawari", pData[playerid][pName]);
					pData[playerid][pFacInvite] = 0;
					pData[playerid][pFacOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		if(strcmp(params,"family",true) == 0) 
		{
            if(IsPlayerConnected(pData[playerid][pFamOffer])) 
			{
                if(pData[playerid][pFamInvite] > -1) 
				{
                    pData[playerid][pFamily] = pData[playerid][pFamInvite];
					pData[playerid][pFamilyRank] = 1;
					Info(playerid, "Anda telah menerima invite family dari "LIGHTGREEN"%s", pData[pData[playerid][pFamOffer]][pName]);
					Info(pData[playerid][pFamOffer], ""LIGHTGREEN"%s "WHITE"telah menerima invite family yang anda tawari", pData[playerid][pName]);
					pData[playerid][pFamInvite] = 0;
					pData[playerid][pFamOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid family id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "Player itu Disconnect.");
        
			if(!NearPlayer(playerid, dragby, 5.0))
				return Error(playerid, "Kamu harus didekat Player.");
        
			pData[playerid][pDragged] = 1;
			pData[playerid][pDraggedBy] = dragby;

			pData[playerid][pDragTimer] = SetTimerEx("DragUpdate", 1000, true, "ii", dragby, playerid);
			SendNearbyMessage(dragby, 30.0, COLOR_PURPLE, "* %s grabs %s and starts dragging them, (/undrag).", ReturnName(dragby), ReturnName(playerid));
			return true;
		}
		else if(strcmp(params,"frisk",true) == 0)
		{
			if(pData[playerid][pFriskOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			if(!NearPlayer(playerid, pData[playerid][pFriskOffer], 5.0))
				return Error(playerid, "Kamu harus didekat Player.");
				
			DisplayItems(pData[playerid][pFriskOffer], playerid);
			Servers(playerid, "Anda telah berhasil menaccept tawaran frisk kepada "LIGHTGREEN"%s.", ReturnName(pData[playerid][pFriskOffer]));
			pData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"inspect",true) == 0)
		{
			if(pData[playerid][pInsOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			if(!NearPlayer(playerid, pData[playerid][pInsOffer], 5.0))
				return Error(playerid, "Kamu harus didekat Player.");
				
			new hstring[512], info[512];
			new hh = pData[playerid][pHead];
			new hp = pData[playerid][pPerut];
			new htk = pData[playerid][pRHand];
			new htka = pData[playerid][pLHand];
			new hkk = pData[playerid][pRFoot];
			new hkka = pData[playerid][pLFoot];
			format(hstring, sizeof(hstring),"Bagian Tubuh\tKondisi\n{ffffff}Kepala\t{7fffd4}%d.0%\n{ffffff}Perut\t{7fffd4}%d.0%\n{ffffff}Tangan Kanan\t{7fffd4}%d.0%\n{ffffff}Tangan Kiri\t{7fffd4}%d.0%\n",hh,hp,htk,htka);
			strcat(info, hstring);
			format(hstring, sizeof(hstring),"{ffffff}Kaki Kanan\t{7fffd4}%d.0%\n{ffffff}Kaki Kiri\t{7fffd4}%d.0%\n",hkk,hkka);
			strcat(info, hstring);
			ShowPlayerDialog(pData[playerid][pInsOffer],DIALOG_HEALTH,DIALOG_STYLE_TABLIST_HEADERS,"Health Condition",info,"Oke","");
			Servers(playerid, "Anda telah berhasil menaccept tawaran Inspect kepada "LIGHTGREEN"%s.", ReturnName(pData[playerid][pInsOffer]));
			pData[playerid][pInsOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"job",true) == 0) 
		{
			if(pData[playerid][pGetJob] > 0)
			{
				pData[playerid][pJob] = pData[playerid][pGetJob];
				Info(playerid, "Anda telah berhasil mendapatkan pekerjaan baru. gunakan "YELLOW"/help "WHITE"untuk informasi.");
				pData[playerid][pGetJob] = 0;
				pData[playerid][pExitJob] = gettime() + (1 * 86400);
			}
			else if(pData[playerid][pGetJob2] > 0)
			{
				pData[playerid][pJob2] = pData[playerid][pGetJob2];
				Info(playerid, "Anda telah berhasil mendapatkan pekerjaan baru. gunakan "YELLOW"/help "WHITE"untuk informasi.");
				pData[playerid][pGetJob2] = 0;
				pData[playerid][pExitJob] = gettime() + (1 * 86400);
			}
		}
		else if(strcmp(params,"reqloc",true) == 0)
		{
			if(pData[playerid][pLocOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pLocOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
				
			new Float:sX, Float:sY, Float:sZ;
			GetPlayerPos(playerid, sX, sY, sZ);
			SetPlayerCheckpoint(pData[playerid][pLocOffer], sX, sY, sZ, 5.0);
			Servers(playerid, "Anda telah berhasil menaccept tawaran Share Lokasi kepada "LIGHTGREEN"%s.", ReturnName(pData[playerid][pLocOffer]));
			Servers(pData[playerid][pLocOffer], "Lokasi "LIGHTGREEN"%s "WHITE"telah tertandai.", ReturnName(playerid));
			pData[playerid][pLocOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"rob",true) == 0)
		{
			if(pData[playerid][pRobOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pRobOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Servers(playerid, "Anda telah berhasil menaccept tawaran bergabung kedalam Robbery "LIGHTGREEN"%s.", ReturnName(pData[playerid][pRobOffer]));
			Servers(pData[playerid][pRobOffer], ""LIGHTGREEN"%s "WHITE"Menerima ajakan Robbing anda.", ReturnName(playerid));
			pData[playerid][pRobOffer] = INVALID_PLAYER_ID;
			pData[playerid][pMemberRob] = 1;
			pData[pData[playerid][pRobOffer]][pRobMember] += 1;
			RobMember += 1;
		}
	}
	return 1;
}

CMD:deny(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /deny [name]");
            Info(playerid, "Names: faction, drag, frisk, inspect, job1, job2, reqloc, rob");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(pData[playerid][pFacOffer] > -1) 
			{
                if(pData[playerid][pFacInvite] > 0) 
				{
					Info(playerid, "Anda telah menolak faction dari "YELLOW"%s", ReturnName(pData[playerid][pFacOffer]));
					Info(pData[playerid][pFacOffer], ""YELLOW"%s "WHITE"telah menolak invite faction yang anda tawari", ReturnName(playerid));
					pData[playerid][pFacInvite] = 0;
					pData[playerid][pFacOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "Tidak ada player yang menawari anda!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "Player itu Disconnect.");

			Info(playerid, "Anda telah menolak drag.");
			Info(dragby, "Player telah menolak drag yang anda tawari.");
			
			DeletePVar(playerid, "DragBy");
			pData[playerid][pDragged] = 0;
			pData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"frisk",true) == 0)
		{
			if(pData[playerid][pFriskOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran frisk kepada "YELLOW"%s.", ReturnName(pData[playerid][pFriskOffer]));
			pData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"inspect",true) == 0)
		{
			if(pData[playerid][pInsOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pInsOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran Inspect kepada "YELLOW"%s.", ReturnName(pData[playerid][pInsOffer]));
			pData[playerid][pInsOffer] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"job1",true) == 0) 
		{
			if(pData[playerid][pJob] == 0) return Error(playerid, "Anda tidak memiliki job apapun.");
			if(pData[playerid][pJob] != 0)
			{
				pData[playerid][pJob] = 0;
				Info(playerid, "Anda berhasil keluar dari pekerjaan anda.");
				return 1;
			}
		}
		else if(strcmp(params,"job2",true) == 0) 
		{
			if(pData[playerid][pJob2] == 0) return Error(playerid, "Anda tidak memiliki job apapun.");
			if(pData[playerid][pJob2] != 0)
			{
				pData[playerid][pJob2] = 0;
				Info(playerid, "Anda berhasil keluar dari pekerjaan anda.");
				return 1;
			}
		}
		else if(strcmp(params,"reqloc",true) == 0) 
		{
			if(pData[playerid][pLocOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pLocOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran Share Lokasi kepada %s.", ReturnName(pData[playerid][pLocOffer]));
			pData[playerid][pLocOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"rob",true) == 0) 
		{
			if(pData[playerid][pRobOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pRobOffer]))
				return Error(playerid, "Player tersebut belum masuk!");
			
			Info(playerid, "Anda telah menolak tawaran Rob kepada "YELLOW"%s.", ReturnName(pData[playerid][pRobOffer]));
			pData[playerid][pRobOffer] = INVALID_PLAYER_ID;
		}
	}
	return 1;
}

/*
CMD:give(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
		new name[24], ammount, otherid;
        if(sscanf(params, "us[24]d", otherid, name, ammount))
		{
			Usage(playerid, "/give [playerid] [name] [ammount]");
			Info(playerid, "Names: bandage, medicine, snack, sprunk, material, component, marijuana, obat, gps");
			return 1;
		}
		if(otherid == INVALID_PLAYER_ID || otherid == playerid || !NearPlayer(playerid, otherid, 3.0))
			return Error(playerid, "Invalid playerid!");
			
		if(strcmp(name,"bandage",true) == 0) 
		{
			if(pData[playerid][pBandage] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pBandage] -= ammount;
			pData[otherid][pBandage] += ammount;
			Info(playerid, "Anda telah berhasil memberikan perban kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan perban kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"medicine",true) == 0) 
		{
			if(pData[playerid][pMedicine] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pMedicine] -= ammount;
			pData[otherid][pMedicine] += ammount;
			Info(playerid, "Anda telah berhasil memberikan medicine kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan medicine kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"snack",true) == 0) 
		{
			if(pData[playerid][pSnack] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pSnack] -= ammount;
			pData[otherid][pSnack] += ammount;
			Info(playerid, "Anda telah berhasil memberikan snack kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan snack kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"sprunk",true) == 0) 
		{
			if(pData[playerid][pSprunk] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pSprunk] -= ammount;
			pData[otherid][pSprunk] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Sprunk kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Sprunk kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"material",true) == 0) 
		{
			if(pData[playerid][pMaterial] < ammount)
				return Error(playerid, "Item anda tidak cukup.");
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxmat = pData[otherid][pMaterial] + ammount;
			
			if(maxmat > 500)
				return Error(playerid, "That player already have maximum material!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pMaterial] -= ammount;
			pData[otherid][pMaterial] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Material kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Material kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"component",true) == 0) 
		{
			if(Inventory_Count(playerid, "Material") < ammount)
				return Error(playerid, "Item anda tidak cukup.");
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxcomp = pData[otherid][pComponent] + ammount;
			
			if(maxcomp > 500)
				return Error(playerid, "That player already have maximum component!");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pComponent] -= ammount;
			pData[otherid][pComponent] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Component kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Component kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"marijuana",true) == 0) 
		{
			if(pData[playerid][pMarijuana] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pMarijuana] -= ammount;
			pData[otherid][pMarijuana] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Marijuana kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Marijuana kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"obat",true) == 0) 
		{
			if(pData[playerid][pObat] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pObat] -= ammount;
			pData[otherid][pObat] += ammount;
			Info(playerid, "Anda telah berhasil memberikan Obat kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan Obat kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"gps",true) == 0) 
		{
			if(pData[playerid][pGPS] < ammount)
				return Error(playerid, "Item anda tidak cukup.");

			if(ammount < 1) return Error(playerid, "Can't Give below 1");
			
			pData[playerid][pGPS] -= ammount;
			pData[otherid][pGPS] += ammount;
			Info(playerid, "Anda telah berhasil memberikan GPS kepada %s sejumlah %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s telah berhasil memberikan GPS kepada anda sejumlah %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}*/

CMD:use(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /use [name]");
            Info(playerid, "Names: bandage, snack, sprunk, gas, medicine, marijuana, obat");
            return 1;
        }
		if(strcmp(params,"bandage",true) == 0) 
		{
			if(Inventory_Count(playerid, "Bandage") < 1)
				return Error(playerid, "Anda tidak memiliki perban.");
			
			new Float:darah;
			GetPlayerHealth(playerid, darah);
			Inventory_Remove(playerid, "Bandage", 1);
			SetPlayerHealthEx(playerid, darah+5);
			Info(playerid, "Anda telah berhasil menggunakan "YELLOW"perban.");
			InfoTD_MSG(playerid, 3000, "Restore +5 Health");
		}
		else if(strcmp(params,"snack",true) == 0) 
		{
			if(Inventory_Count(playerid, "Snack") < 1)
				return Error(playerid, "Anda tidak memiliki snack.");
			
			pData[playerid][pSnack]--;
			pData[playerid][pHunger] += 15;
			Info(playerid, "Anda telah berhasil menggunakan "YELLOW"snack.");
			InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"sprunk",true) == 0) 
		{
			if(Inventory_Count(playerid, "Sprunk") < 1)
				return Error(playerid, "Anda tidak memiliki sprunk.");
			
			pData[playerid][pSprunk]--;
			pData[playerid][pEnergy] += 15;
			Info(playerid, "Anda telah berhasil meminum "YELLOW"sprunk.");
			InfoTD_MSG(playerid, 3000, "Restore +15 Energy");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		/*else if(strcmp(params,"sprunk",true) == 0) 
		{
			if(pData[playerid][pSprunk] < 1)
				return Error(playerid, "Anda tidak memiliki snack.");
			
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_SPRUNK);
			//SendNearbyMessage(playerid, 10.0, COLOR_PURPLE,"* %s opens a can of sprunk.", ReturnName(playerid));
			SetPVarInt(playerid, "UsingSprunk", 1);
			pData[playerid][pSprunk]--;
		}*/
		else if(strcmp(params,"gas",true) == 0) 
		{
			if(Inventory_Count(playerid, "Gas") < 1)
				return Error(playerid, "Anda tidak memiliki gas.");
				
			if(IsPlayerInAnyVehicle(playerid))
				return Error(playerid, "Anda harus berada diluar kendaraan!");
			
			if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
			
			new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
			if(IsValidVehicle(vehicleid))
			{
				new fuel = GetVehicleFuel(vehicleid);
			
				if(GetEngineStatus(vehicleid))
					return Error(playerid, "Turn off vehicle engine.");
			
				if(fuel >= 999.0)
					return Error(playerid, "This vehicle gas is full.");
			
				if(!IsEngineVehicle(vehicleid))
					return Error(playerid, "This vehicle can't be refull.");

				if(!GetHoodStatus(vehicleid))
					return Error(playerid, "The hood must be opened before refull the vehicle.");

				pData[playerid][pGas]--;
				Info(playerid, "Don't move from your position or you will failed to refulling this vehicle.");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
				pData[playerid][pActivity] = SetTimerEx("RefullCar", 1000, true, "id", playerid, vehicleid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Refulling...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				/*InfoTD_MSG(playerid, 10000, "Refulling...");
				//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s starts to refulling the vehicle.", ReturnName(playerid));*/
				return 1;
			}
		}
		else if(strcmp(params,"medicine",true) == 0) 
		{
			if(Inventory_Count(playerid, "Medicine") < 1)
				return Error(playerid, "Anda tidak memiliki medicine.");
			
			pData[playerid][pMedicine]--;
			pData[playerid][pSick] = 0;
			pData[playerid][pSickTime] = 0;
			SetPlayerDrunkLevel(playerid, 0);
			Info(playerid, "Anda menggunakan "YELLOW"medicine.");
			
			//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"obat",true) == 0) 
		{
			if(Inventory_Count(playerid, "Obat") < 1)
				return Error(playerid, "Anda tidak memiliki Obat Myricous.");
			
			Inventory_Remove(playerid, "Obat", 1);
			pData[playerid][pSick] = 0;
			pData[playerid][pSickTime] = 0;
			pData[playerid][pHead] = 100;
			pData[playerid][pPerut] = 100;
			pData[playerid][pRHand] = 100;
			pData[playerid][pLHand] = 100;
			pData[playerid][pRFoot] = 100;
			pData[playerid][pLFoot] = 100;
			SetPlayerDrunkLevel(playerid, 0);
			Info(playerid, "Anda menggunakan Obat "YELLOW"Myricous.");
			
			//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"marijuana",true) == 0) 
		{
			if(Inventory_Count(playerid, "Marijuana") < 1)
				return Error(playerid, "You dont have marijuana.");
			
			new Float:armor;
			GetPlayerArmour(playerid, armor);
			if(armor+10 > 90) return Error(playerid, "Over dosis!");
			
			pData[playerid][pMarijuana]--;
			SetPlayerArmourEx(playerid, armor+10);
			SetPlayerDrunkLevel(playerid, 4000);
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
	}
	return 1;
}

CMD:revive(playerid, params[])
{
			
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/revive [playerid/PartOfName]");

    if(!IsPlayerConnected(otherid))
        return Error(playerid, "Player belum masuk!");

    if(!pData[otherid][pInjured])
        return Error(playerid, "Tidak bisa revive karena tidak injured.");

    if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "Player disconnect atau tidak berada didekat anda.");

    if(Inventory_Count(playerid, "Obat") < 1)
    	return Error(playerid, "Tidak dapat Revive karena anda tidak memiliki Obat");

    SetTimerEx("Reviving", 5000, 0, "i", playerid);
    TogglePlayerControllable(playerid, 0);
    GameTextForPlayer(playerid, "~w~REVIVING...", 5000, 3);
    Inventory_Remove(playerid, "Obat", 1);
    pData[otherid][pInjured] = 0;
    pData[otherid][pHospital] = 0;
    pData[otherid][pSick] = 0;
    pData[otherid][pHead] = 100;
    pData[otherid][pPerut] = 100;
    pData[otherid][pRHand] = 100;
    pData[otherid][pLHand] = 100;
    pData[otherid][pRFoot] = 100;
    pData[otherid][pLFoot] = 100;
    SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);
    ClearAnimations(otherid);
    TogglePlayerControllable(otherid, 1);
    SetPVarInt(playerid, "gcPlayer", otherid);
    ApplyAnimation(playerid,"MEDIC","CPR",4.1, 0, 1, 1, 1, 1, 1);
    SetPlayerHealthEx(otherid, 100.0);
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s menyembuhkan segala luka %s.", ReturnName(playerid), ReturnName(otherid));
    Info(otherid, ""YELLOW"%s "WHITE"has revived you.", pData[playerid][pAdminname]);
    return 1;
}


CMD:enter(playerid, params[])
{
	if(pData[playerid][pInjured] == 0)
    {
		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

					if(dData[did][dLocked])
						return Error(playerid, "Bangunan ini di Kunci untuk sementara.");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk fraksi.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != pData[playerid][pFamily])
							return Error(playerid, "Pintu ini hanya untuk Family.");
					}
					
					if(dData[did][dVip] > pData[playerid][pVip])
						return Error(playerid, "VIP Level mu tidak cukup.");
					
					if(dData[did][dAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Admin level mu tidak cukup.");
						
					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return Error(playerid, "Password Salah.");
						
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
				else
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

					if(dData[did][dLocked])
						return Error(playerid, "Pintu ini ditutup sementara");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk faction.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != pData[playerid][pFamily])
							return Error(playerid, "Pintu ini hanya untuk family.");
					}
					
					if(dData[did][dVip] > pData[playerid][pVip])
						return Error(playerid, "Your VIP level not enough to enter this door.");
					
					if(dData[did][dAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Your admin level not enough to enter this door.");

					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
						
						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk faction.");
					}
				
					if(dData[did][dCustom])
					{
						SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					}
					else
					{
						SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					}
					pData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
				else
				{
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "Pintu ini hanya untuk faction.");
					}
					
					if(dData[did][dCustom])
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);

					else
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					
					pData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
			}
        }
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return Error(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return Error(playerid, "Rumah ini terkunci!");
				
				pData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inhouseid = pData[playerid][pInHouse];
		if(pData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);

			pData[playerid][pInHouse] = -1;
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return Error(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return Error(playerid, "Bisnis ini Terkunci!");
					
				pData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);
				
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inbisnisid = pData[playerid][pInBiz];
		if(pData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			pData[playerid][pInBiz] = -1;
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return Error(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(pData[playerid][pFaction] == 0)
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have registered for this door!");
					
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				//pData[playerid][pInBiz] = fid;
				SetPlayerWeather(playerid, 0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ]))
			{
				SetPlayerPositionEx(playerid, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ], fData[fid][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
				//pData[playerid][pInBiz] = -1;
			}
        }
	}
	return 1;
}

CMD:drag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/drag [playerid/PartOfName] || /undrag [playerid]");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player itu Disconnect.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa menarik diri mu sendiri.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Kamu harus didekat Player.");

    if(!pData[otherid][pInjured])
        return Error(playerid, "kamu tidak bisa drag orang yang tidak mati.");

    SetPVarInt(otherid, "DragBy", playerid);
    Info(otherid, ""LIGHTGREEN"%s "WHITE"Telah menawari drag kepada anda, "YELLOW"/accept drag untuk menerimanya /deny drag untuk membatalkannya.", ReturnName(playerid));
	Info(playerid, "Anda berhasil menawari drag kepada player "YELLOW"%s", ReturnName(otherid));
    return 1;
}

CMD:undrag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid)) return Usage(playerid, "/undrag [playerid]");
	if(pData[otherid][pDragged])
    {
        DeletePVar(playerid, "DragBy");
        DeletePVar(otherid, "DragBy");
        pData[otherid][pDragged] = 0;
        pData[otherid][pDraggedBy] = INVALID_PLAYER_ID;

        KillTimer(pData[otherid][pDragTimer]);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s releases %s from their grip.", ReturnName(playerid), ReturnName(otherid));
    }
    return 1;
}

CMD:mask(playerid, params[])
{
	if(Inventory_Count(playerid, "Mask") == 0)
		return Error(playerid, "Anda tidak memiliki topeng!");
		
	switch (pData[playerid][pMaskOn])
    {
        case 0:
        {
        	new sstring[64];
        	new Float:pX, Float:pY, Float:pZ;
        	GetPlayerPos(playerid, pX, pY, pZ);
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out a mask and puts it on.", ReturnName(playerid));
            pData[playerid][pMaskOn] = 1;
            format(sstring, sizeof(sstring), "%s", ReturnName(playerid));
		    pData[playerid][pMaskLabel] = Create3DTextLabel(sstring, -1, 0, 0, -0.25, 25, playerid, 10);
		    Attach3DTextLabelToPlayer(pData[playerid][pMaskLabel], playerid, 0, 0, 0.39);
			for(new i = GetPlayerPoolSize(); i != -1; --i)
			{
				ShowPlayerNameTagForPlayer(i, playerid, 0);
			}
			//SetPlayerAttachedObject(playerid, 9, 18911, 2,0.078534, 0.041857, -0.001727, 268.970458, 1.533374, 269.223754);
        }
        case 1:
        {
        	Delete3DTextLabel(pData[playerid][pMaskLabel]);
            pData[playerid][pMaskOn] = 0;
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes their mask off and puts it away.", ReturnName(playerid));
			for(new i = GetPlayerPoolSize(); i != -1; --i)
			{
				ShowPlayerNameTagForPlayer(i, playerid, 1);
			}
			//RemovePlayerAttachedObject(playerid, 9);
        }
    }
	return 1;
}

CMD:stuck(playerid)
{
	if(pData[playerid][pFreeze] == 1)
		return Error(playerid, "Anda sedang di Freeze oleh staff, tidak dapat menggunakan ini");

	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	ShowPlayerDialog(playerid, DIALOG_STUCK, DIALOG_STYLE_LIST,"Stuck Options","Tersangkut DiGedung\nTersangkut setelah masuk/keluar Interior\nTersangkut diKendaraan","Pilih","Batal");
	return 1;
}
//Text and Chat Commands
CMD:try(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/try [action]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s, %s", params[64], (random(2) == 0) ? ("and success") : ("but fail"));
    }
    else {
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s, %s", ReturnName(playerid), params, (random(2) == 0) ? ("and success") : ("but fail"));
    }
	printf("[TRY] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ado(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        Usage(playerid, "/ado [text]");
		Info(playerid, "Use /ado off to disable or delete the ado tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return Error(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!pData[playerid][pAdoActive])
            return Error(playerid, "You're not actived your 'ado' text.");

        if (IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pAdoTag]);

        Servers(playerid, "You're removed your ado text.");
        pData[playerid][pAdoActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n(( %s ))", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(pData[playerid][pAdoActive])
    {
        if (IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            UpdateDynamic3DTextLabelText(pData[playerid][pAdoTag], COLOR_PURPLE, flyingtext);
        else
            pData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        pData[playerid][pAdoActive] = true;
        pData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[ADO] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ab(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        Usage(playerid, "/ab [text]");
		Info(playerid, "Use /ab off to disable or delete the ado tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return Error(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!pData[playerid][pBActive])
            return Error(playerid, "You're not actived your 'ab' text.");

        if (IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pBTag]);

        Servers(playerid, "You're removed your ab text.");
        pData[playerid][pBActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n(( OOC : %s ))", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AB]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AB]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(pData[playerid][pBActive])
    {
        if (IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            UpdateDynamic3DTextLabelText(pData[playerid][pBTag], COLOR_PURPLE, flyingtext);
        else
            pData[playerid][pBTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        pData[playerid][pBActive] = true;
        pData[playerid][pBTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[AB] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ame(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164];

    if(isnull(params))
        return Usage(playerid, "/ame [action]");

    if(strlen(params) > 128)
        return Error(playerid, "Max action can only maximmum 128 characters.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    format(flyingtext, sizeof(flyingtext), "* %s %s*", ReturnName(playerid), params);
    SetPlayerChatBubble(playerid, flyingtext, COLOR_PURPLE, 10.0, 10000);
	printf("[AME] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:me(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/me [action]");
	
	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid), params);
    }
	printf("[ME] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:do(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/do [description]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s (( %s ))", params[64], ReturnName(playerid));
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnName(playerid));
    }
	printf("[DO] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:toglog(playerid)
{
	if(!pData[playerid][pTogLog])
	{
		pData[playerid][pTogLog] = 1;
		Info(playerid, "Anda telah menonaktifkan log server.");
	}
	else
	{
		pData[playerid][pTogLog] = 0;
		Info(playerid, "Anda telah mengaktifkan log server.");
	}
	return 1;
}

CMD:togpm(playerid)
{
	if(!pData[playerid][pTogPM])
	{
		pData[playerid][pTogPM] = 1;
		Info(playerid, "Anda telah menonaktifkan PM");
	}
	else
	{
		pData[playerid][pTogPM] = 0;
		Info(playerid, "Anda telah mengaktifkan PM");
	}
	return 1;
}

CMD:togads(playerid)
{
	if(!pData[playerid][pTogAds])
	{
		pData[playerid][pTogAds] = 1;
		Info(playerid, "Anda telah menonaktifkan Ads/Iklan.");
	}
	else
	{
		pData[playerid][pTogAds] = 0;
		Info(playerid, "Anda telah mengaktifkan Ads/Iklan.");
	}
	return 1;
}

CMD:togwt(playerid)
{
	if(!pData[playerid][pTogWT])
	{
		pData[playerid][pTogWT] = 1;
		Info(playerid, "Anda telah menonaktifkan Walkie Talkie.");
	}
	else
	{
		pData[playerid][pTogWT] = 0;
		Info(playerid, "Anda telah mengaktifkan Walkie Talkie.");
	}
	return 1;
}

CMD:pm(playerid, params[])
{
    static text[128], otherid;
    if(sscanf(params, "us[128]", otherid, text))
        return Usage(playerid, "/pm [playerid/PartOfName] [message]");

    /*if(pData[playerid][pTogPM])
        return Error(playerid, "You must enable private messaging first.");*/

    /*if(pData[otherid][pAdminDuty])
        return Error(playerid, "You can't pm'ing admin duty now!");*/
		
	if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Player yang anda tuju tidak valid.");

    if(otherid == playerid)
        return Error(playerid, "Tidak dapan PM diri sendiri.");

    if(pData[otherid][pTogPM] && pData[playerid][pAdmin] < 1)
        return Error(playerid, "Player tersebut menonaktifkan pm.");

    if(IsPlayerInRangeOfPoint(otherid, 50, 2184.32, -1023.32, 1018.68))
				return Error(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

    //GameTextForPlayer(otherid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~y~New message!", 3000, 3);
    PlayerPlaySound(otherid, 1085, 0.0, 0.0, 0.0);

    SendClientMessageEx(otherid, COLOR_YELLOW, "(( PM from %s (%d): %s ))", pData[playerid][pName], playerid, text);
    SendClientMessageEx(playerid, COLOR_YELLOW, "(( PM to %s (%d): %s ))", pData[otherid][pName], otherid, text);
	//Info(otherid, "/togpm for tog enable/disable PM");

    foreach(new i : Player) if((pData[i][pAdmin]) && pData[playerid][pSPY] > 0)
    {
        SendClientMessageEx(i, COLOR_LIGHTGREEN, "[SPY PM] %s (%d) to %s (%d): %s", pData[playerid][pName], playerid, pData[otherid][pName], otherid, text);
    }
    return 1;
}

CMD:whisper(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new text[128], otherid;
    if(sscanf(params, "us[128]", otherid, text))
        return Usage(playerid, "/(w)hisper [playerid/PartOfName] [text]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player itu Disconnect or not near you.");

    if(otherid == playerid)
        return Error(playerid, "You can't whisper yourself.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(text) > 64) 
	{
        SendClientMessageEx(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %.64s", ReturnName(playerid), playerid, text);
        SendClientMessageEx(otherid, COLOR_YELLOW, "...%s **", text[64]);

        SendClientMessageEx(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %.64s", ReturnName(otherid), otherid, text);
        SendClientMessageEx(playerid, COLOR_YELLOW, "...%s **", text[64]);
    }
    else 
	{
        SendClientMessageEx(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %s **", ReturnName(playerid), playerid, text);
        SendClientMessageEx(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %s **", ReturnName(otherid), otherid, text);
    }
    SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %s mutters something in %s's ear.", ReturnName(playerid), ReturnName(otherid));
	
	foreach(new i : Player) if((pData[i][pAdmin]) && pData[i][pSPY] > 0)
    {
        SendClientMessageEx(i, COLOR_YELLOW2, "[SPY Whisper] %s (%d) to %s (%d): %s", pData[playerid][pName], playerid, pData[otherid][pName], otherid, text);
    }
    return 1;
}

CMD:l(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/(l)ow [low text]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
	if(IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i : Player)
		{
			if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
			{
				if(strlen(params) > 64) 
				{
					SendClientMessageEx(i, COLOR_WHITE, "[car] %s says: %.64s ..", ReturnName(playerid), params);
					SendClientMessageEx(i, COLOR_WHITE, "...%s", params[64]);
				}
				else 
				{
					SendClientMessageEx(i, COLOR_WHITE, "[car] %s says: %s", ReturnName(playerid), params);
				}
				printf("[CAR] %s(%d) : %s", pData[playerid][pName], playerid, params);
			}
		}
	}
	else
	{
		if(strlen(params) > 64) 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %.64s ..", ReturnName(playerid), params);
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "...%s", params[64]);
		}
		else 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %s", ReturnName(playerid), params);
		}
		printf("[LOW] %s(%d) : %s", pData[playerid][pName], playerid, params);
	}
    return 1;
}

CMD:s(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/(s)hout [shout text] /ds for in the door");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 40.0, COLOR_WHITE, "%s shouts: %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 40.0, COLOR_WHITE, "...%s!", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s shouts: %s!", ReturnName(playerid), params);
    }
	new flyingtext[128];
	format(flyingtext, sizeof(flyingtext), "%s!", params);
    SetPlayerChatBubble(playerid, flyingtext, COLOR_WHITE, 10.0, 10000);
	printf("[SHOUTS] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:b(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "OOC Zone, Ketik biasa saja");

    if(isnull(params))
        return Usage(playerid, "/b [local OOC]");
		
	if(pData[playerid][pAdminDuty] == 1)
    {
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %.64s ..", ReturnName(playerid), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %s ))", ReturnName(playerid), params);
            return 1;
        }
	}
	else
	{
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %.64s ..", ReturnName(playerid), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %s ))", ReturnName(playerid), params);
            return 1;
        }
	}
	//printf("[OOC] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:t(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(isnull(params))
		return Usage(playerid, "/t [typo text]");

	if(strlen(params) < 10)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s : %.10s*", ReturnName(playerid), params);
	}
	//printf("[OOC] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

/*
CMD:phone(playerid, params[])
{
	if(Inventory_Count(playerid, "Phone") == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	if(pData[playerid][pUsePhone] == 0) return Error(playerid, "Handphone anda sedang dimatikan");

	new string[512];
	format(string, sizeof(string),"App Store\nIsi Kuota");
	ShowPlayerDialog(playerid, DIALOG_ISIKUOTA, DIALOG_STYLE_LIST,"Phone",string,"Pilih","Batal");
	return 1;
}

CMD:call(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new ph;
	if(Inventory_Count(playerid, "Phone") == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	if(pData[playerid][pUsePhone] == 0) return Error(playerid, "Handphone anda sedang dimatikan");
	if(pData[playerid][pPhoneCredit] <= 0) return Error(playerid, "Anda tidak memiliki Ponsel credits!");
	
	if(sscanf(params, "d", ph))
	{
		Usage(playerid, "/call [phone number] 933 - Taxi Call | 911 - SAPD Crime Call | 922 - SAMD Medic Call");
		foreach(new ii : Player)
		{	
			if(pData[ii][pMechDuty] == 1)
			{
				SendClientMessageEx(playerid, COLOR_GREEN, "Mekanik Duty: %s | PH: [%d]", ReturnName(ii), pData[ii][pPhone]);
			}
		}
		return 1;
	}
	if(ph == 911)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());
		
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		Info(playerid, "Warning: This number for emergency crime only! please wait for SAPD respon!");
		SendFactionMessage(1, COLOR_BLUE, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency crime! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
	
		pData[playerid][pCallTime] = gettime() + 60;
	}
	if(ph == 922)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());
		
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		Info(playerid, "Warning: This number for emergency medical only! please wait for SAMD respon!");
		SendFactionMessage(3, COLOR_PINK2, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency medical! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
	
		pData[playerid][pCallTime] = gettime() + 60;
	}
	if(ph == 933)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());
		
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		Info(playerid, "Your calling has sent to the taxi driver. please wait for respon!");
		pData[playerid][pCallTime] = gettime() + 60;
		foreach(new tx : Player)
		{
			if(pData[tx][pJob] == 1 || pData[tx][pJob2] == 1)
			{
				SendClientMessageEx(tx, COLOR_YELLOW, "[TAXI CALL] "WHITE_E"%s calling the taxi for order! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
			}
		}
	}
	if(ph == pData[playerid][pPhone]) return Error(playerid, "Nomor sedang sibuk!");
	foreach(new ii : Player)
	{
		if(pData[ii][pPhone] == ph)
		{
			if(pData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");
			if(pData[ii][pUsePhone] == 0) return Error(playerid, "Tidak dapat menelepon, Ponsel tersebut yang dituju sedang Offline");
			if(IsPlayerInRangeOfPoint(ii, 20, 2179.9531,-1009.7586,1021.6880))
				return Error(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

			if(pData[ii][pCall] == INVALID_PLAYER_ID)
			{
				pData[playerid][pCall] = ii;
				
				SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE to %d] "WHITE_E"phone begins to ring, please wait for answer!", ph);
				SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE form %d] "WHITE_E"Your phonecell is ringing, type '/p' to answer it!", pData[playerid][pPhone]);
				PlayerPlaySound(playerid, 3600, 0,0,0);
				PlayerPlaySound(ii, 6003, 0,0,0);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out a cellphone and calling someone.", ReturnName(playerid));
				return 1;
			}
			else
			{
				Error(playerid, "Nomor ini sedang sibuk.");
				return 1;
			}
		}
	}
	return 1;
}

CMD:p(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(pData[playerid][pCall] != INVALID_PLAYER_ID)
		return Error(playerid, "Anda sudah sedang menelpon seseorang!");
		
	if(pData[playerid][pInjured] != 0)
		return Error(playerid, "You cant do that in this time.");
		
	foreach(new ii : Player)
	{
		if(playerid == pData[ii][pCall])
		{
			pData[ii][pPhoneCredit]--;
			
			pData[playerid][pCall] = ii;
			SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");
			SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s answers their cellphone.", ReturnName(playerid));
			return 1;
		}
	}
	return 1;
}

CMD:hu(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new caller = pData[playerid][pCall];
	if(IsPlayerConnected(caller) && caller != INVALID_PLAYER_ID)
	{
		pData[caller][pCall] = INVALID_PLAYER_ID;
		SetPlayerSpecialAction(caller, SPECIAL_ACTION_STOPUSECELLPHONE);
		SendNearbyMessage(caller, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(caller));
		
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(playerid));
		pData[playerid][pCall] = INVALID_PLAYER_ID;
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	}
	return 1;
}

CMD:sms(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new ph, text[50];
	if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	if(pData[playerid][pPhoneCredit] <= 0) return Error(playerid, "Anda tidak memiliki Ponsel credits!");
	if(pData[playerid][pInjured] != 0) return Error(playerid, "You cant do at this time.");
	
	if(sscanf(params, "ds[50]", ph, text))
        return Usage(playerid, "/sms [phone number] [message max 50 text]");
	
	foreach(new ii : Player)
	{
		if(pData[ii][pPhone] == ph)
		{
			if(pData[ii][pUsePhone] == 0) return Error(playerid, "Tidak dapat SMS, Ponsel tersebut yang dituju sedang Offline");
			if(IsPlayerInRangeOfPoint(ii, 20, 2179.9531,-1009.7586,1021.6880))
				return Error(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

			if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");
			SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS to %d]"WHITE_E" %s", ph, text);
			SendClientMessageEx(ii, COLOR_YELLOW, "[SMS from %d]"WHITE_E" %s", pData[playerid][pPhone], text);
			Info(ii, "Gunakan "LB_E"'@<text>' "WHITE_E"untuk membalas SMS!");
			PlayerPlaySound(ii, 6003, 0,0,0);
			pData[ii][pSMS] = pData[playerid][pPhone];
			
			pData[playerid][pPhoneCredit] -= 1;
			return 1;
		}
	}
	return 1;
}

CMD:number(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(pData[playerid][pPhoneBook] == 0)
		return Error(playerid, "You dont have a phone book.");
	
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/number [playerid]");
	
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "That player is not listed in phone book.");
		
	if(pData[otherid][pPhone] == 0)
		return Error(playerid, "That player is not listed in phone book.");
	
	SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE] Name: %s | Ph: %d.", ReturnName(otherid), pData[otherid][pPhone]);
	return 1;
}
*/

CMD:setfreq(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(Inventory_Count(playerid, "Walkie Talkie") == 0)
		return Error(playerid, "You dont have walkie talkie!");
	
	new channel;
	if(sscanf(params, "d", channel))
		return Usage(playerid, "/setfreq [channel 1 - 1000]");
	
	if(pData[playerid][pTogWT] == 1) return Error(playerid, "Your walkie talkie is turned off.");
	if(channel == pData[playerid][pWT]) return Error(playerid, "You are already in this channel.");
	
	if(channel > 0 && channel <= 1000)
	{
		foreach(new i : Player)
		{
		    if(pData[i][pWT] == channel)
		    {
				SendClientMessageEx(i, COLOR_LIME, "[WT] "WHITE_E"%s has joined in to this channel!", ReturnName(playerid));
		    }
		}
		Info(playerid, "You have set your walkie talkie channel to "LIME_E"%d", channel);
		pData[playerid][pWT] = channel;
	}
	else
	{
		Error(playerid, "Invalid channel id! 1 - 1000");
	}
	return 1;
}

CMD:wt(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(Inventory_Count(playerid, "Walkie Talkie") == 0)
		return Error(playerid, "You dont have walkie talkie!");
		
	if(pData[playerid][pTogWT] == 1)
		return Error(playerid, "Your walkie talkie is turned off!");
	
	new msg[128];
	if(sscanf(params, "s[128]", msg)) return Usage(playerid, "/wt [message]");
	foreach(new i : Player)
	{
	    if(pData[i][pTogWT] == 0)
	    {
	        if(pData[i][pWT] == pData[playerid][pWT])
	        {
				SendClientMessageEx(i, COLOR_LIME, "[WT] "WHITE_E"%s: %s", ReturnName(playerid), msg);
	        }
	    }
	}
	return 1;
}

/*CMD:savestats(playerid, params[])
{
	UpdateWeapons(playerid);
	UpdatePlayerData(playerid);
	Info(playerid, "Your data have been saved!");
	return 1;
}*/

/*
CMD:ads(playerid, params[])
{
	if(pData[playerid][pUsePhone] == 0) return Error(playerid, "Tidak dapat iklan, Ponsel anda sedang Offline");

	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2461.21, 2270.42, 91.67)) return Error(playerid, "You must in SANA Station!");
	if(pData[playerid][pPhone] == 0) return Error(playerid, "Anda tidak memiliki Ponsel!");
	
	if(isnull(params))
	{
		Usage(playerid, "/ads [text] | 1 character pay $2");
		return 1;
	}
	if(strlen(params) >= 100 ) return Error(playerid, "Maximum character is 100 text." );
	new payout = strlen(params) * 2;
	if(GetPlayerMoney(playerid) < payout) return Error(playerid, "Not enough money.");
	
	GivePlayerMoneyEx(playerid, -payout);
	Server_AddMoney(payout);
	foreach(new ii : Player)
	{
		if(pData[ii][pTogAds] == 0)
		{
			SendClientMessageEx(ii, COLOR_ORANGE2, "[IKLAN] "GREEN_E"%s.", params);
			SendClientMessageEx(ii, COLOR_ORANGE2, "Contact Info: ["GREEN_E"%s"ORANGE_E2"] Ph: ["GREEN_E"%d"ORANGE_E2"] Bank Rek: ["GREEN_E"%d"ORANGE_E2"]", pData[playerid][pName], pData[playerid][pPhone], pData[playerid][pBankRek]);
		}
	}
	//SendClientMessageToAllEx(COLOR_ORANGE2, "[ADS] "GREEN_E"%s.", params);
	//SendClientMessageToAllEx(COLOR_ORANGE2, "Contact Info: ["GREEN_E"%s"ORANGE_E2"] Ph: ["GREEN_E"%d"ORANGE_E2"] Bank Rek: ["GREEN_E"%d"ORANGE_E2"]", pData[playerid][pName], pData[playerid][pPhone], pData[playerid][pBankRek]);
	return 1;
}*/

CMD:buyseed(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, -373.5426,-1427.1572,25.7266))
		return Error(playerid, "Anda harus berada di farmer storage");

	if(pData[playerid][pJob] == 7 || pData[playerid][pJob2] == 7)
	{
		new amount;
		if(sscanf(params, "d", amount)) 
		{
			Usage(playerid, "/buyseed [amount]");
			Custom(playerid, "NOTE", "Harga seed "GREEN"%s/seed", FormatMoney(SeedPrice));
			return 1;
		}

		new total = Inventory_Count(playerid, "Seed") + amount;
		new value = amount * SeedPrice;
		if(amount < 0 || amount > 100) return Error(playerid, "amount maximal 0 - 100.");
		if(total > 100) return Error(playerid, "Seed terlalu penuh di Inventory! Maximal 100.");
		if(GetPlayerMoney(playerid) < value) return Error(playerid, "Uang anda kurang.");

		GivePlayerMoneyEx(playerid, -value);
		Inventory_Add(playerid, "Seed", 11745, amount);
		Server_AddMoney(value);
		Custom(playerid, "FARMER", "Anda berhasil membeli "YELLOW"%d "WHITE_E"Seed seharga "GREEN"%s.", amount, FormatMoney(value));
	}	
	else
	{
		Error(playerid, "Anda harus bekerja sebagai farmer");
	}
	return 1;
}

CMD:buyfood(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, 2729.6711,-2451.4734,17.5937))
		return Error(playerid, "Anda harus berada di Tempat pembelian food");

	new amount;
	if(sscanf(params, "d", amount)) 
	{
		Usage(playerid, "/buyfood [amount]");
		Custom(playerid, "NOTE", "Harga Food "GREEN"%s/food", FormatMoney(FoodPrice));
		return 1;
	}

	new total = Inventory_Count(playerid, "Food") + amount;
	new value = amount * FoodPrice;
	if(amount < 0 || amount > 500) return Error(playerid, "amount maximal 0 - 500.");
	if(total > 500) return Error(playerid, "Food terlalu penuh di Inventory! Maximal 500.");
	if(GetPlayerMoney(playerid) < value) return Error(playerid, "Uang anda kurang.");
	if(Food < amount) return Error(playerid, "Food stock tidak mencukupi.");
	GivePlayerMoneyEx(playerid, -value);
	Inventory_Add(playerid, "Food", 19568, amount);
	Food -= amount;
	Server_AddMoney(value);
	Custom(playerid, "FOOD", "Anda berhasil membeli "YELLOW"%d "WHITE_E"Food seharga "GREEN"%s.", amount, FormatMoney(value));
	return 1;
}

CMD:buycomponent(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 854.6860,-604.8564,18.4219))
		return Error(playerid, "Anda tidak berada di component shop");

	if(Inventory_Count(playerid, "Component") >= 500) return Error(playerid, "Anda sudah membawa 500 Component!");

	new amount;
	if(sscanf(params, "d", amount)) 
	{
		Usage(playerid, "/buycomponent [amount]");
		Custom(playerid, "NOTE", "Harga Component "GREEN"%s/component", FormatMoney(ComponentPrice));
		return 1;
	}

	new total = Inventory_Count(playerid, "Component") + amount;
	new value = amount * ComponentPrice;
	if(amount < 0 || amount > 500) return Error(playerid, "amount maximal 0 - 500.");
	if(total > 500) return Error(playerid, "Component terlalu penuh di Inventory! Maximal 500.");
	if(GetPlayerMoney(playerid) < value) return Error(playerid, "Uang anda kurang.");
	if(Component < amount) return Error(playerid, "Component stock tidak mencukupi.");
	GivePlayerMoneyEx(playerid, -value);
	Inventory_Add(playerid, "Component", 19627, amount);
	Component -= amount;
	Server_AddMoney(value);
	Custom(playerid, "COMPONENT", "Anda berhasil membeli "YELLOW"%d "WHITE_E"component seharga "GREEN"%s.", amount, FormatMoney(value));
	return 1;
}

//------------------[ Bisnis and Buy Commands ]-------
CMD:buy(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
	/*
	//trucker product
	if(IsPlayerInRangeOfPoint(playerid, 3.5, -279.67, -2148.42, 28.54))
	{
		if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				new mstr[128];
				format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah product:\nProduct Stock: "GREEN_E"%d\n"WHITE_E"Product Price"GREEN_E"%s / item", Product, FormatMoney(ProductPrice));
				ShowPlayerDialog(playerid, DIALOG_PRODUCT, DIALOG_STYLE_INPUT, "Buy Product", mstr, "Buy", "Cancel");
			}
			else return Error(playerid, "You are not in vehicle trucker.");
		}
		else return Error(playerid, "You are not trucker job.");
	}*/
	/*
	if(IsPlayerInRangeOfPoint(playerid, 3.5, 375.6953,869.5052,20.4063))
	{
		if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				new mstr[128];
				format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah liter gasoil:\nGasOil Stock: "GREEN_E"%d\n"WHITE_E"GasOil Price"GREEN_E"%s / liters", GasOil, FormatMoney(GasOilPrice));
				ShowPlayerDialog(playerid, DIALOG_GASOIL, DIALOG_STYLE_INPUT, "Buy GasOil", mstr, "Buy", "Cancel");
			}
			else return Error(playerid, "You are not in vehicle trucker.");
		}
		else return Error(playerid, "You are not trucker job.");
	}*/
	//Material
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -258.54, -2189.92, 28.97))
	{
		if(Inventory_Count(playerid, "Material") >= 500) return Error(playerid, "Anda sudah membawa 500 Material!");
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah material:\nMaterial Stock: "GREEN_E"%d\n"WHITE_E"Material Price"GREEN_E"%s / item", Material, FormatMoney(MaterialPrice));
		ShowPlayerDialog(playerid, DIALOG_MATERIAL, DIALOG_STYLE_INPUT, "Buy Material", mstr, "Buy", "Cancel");
	}
	//Component
	/*
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 3115.07, 926.53, 20.46))
	{
		if(pData[playerid][pComponent] >= 500) return Error(playerid, "Anda sudah membawa 500 Component!");
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah component:\nComponent Stock: "GREEN_E"%d\n"WHITE_E"Component Price"GREEN_E"%s / item", Component, FormatMoney(ComponentPrice));
		ShowPlayerDialog(playerid, DIALOG_COMPONENT, DIALOG_STYLE_INPUT, "Buy Component", mstr, "Buy", "Cancel");
	}*/
	//Apotek
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -1265.5786,-417.8357,14.1784))
	{
		if(pData[playerid][pFaction] != 3)
			return Error(playerid, "Medical only!");
			
		new mstr[128];
		format(mstr, sizeof(mstr), "Product\tPrice\n\
		Medicine\t"GREEN_E"%s\n\
		Medkit\t"GREEN_E"%s\n\
		Bandage\t"GREEN_E"$100\n\
		", FormatMoney(MedicinePrice), FormatMoney(MedkitPrice));
		ShowPlayerDialog(playerid, DIALOG_APOTEK, DIALOG_STYLE_TABLIST_HEADERS, "Apotek", mstr, "Buy", "Cancel");
	}
	//Food and Seed
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -381.44, -1426.13, 25.93))
	{
		new mstr[128];
		format(mstr, sizeof(mstr), "Product\tPrice\n\
		Food\t"GREEN_E"%s\n\
		Seed\t"GREEN_E"%s\n\
		", FormatMoney(FoodPrice), FormatMoney(SeedPrice));
		ShowPlayerDialog(playerid, DIALOG_FOOD, DIALOG_STYLE_TABLIST_HEADERS, "Food", mstr, "Buy", "Cancel");
	}
	//Drugs
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 333.6938,1124.4623,1083.8903))
	{
		if(pData[playerid][pMarijuana] >= 100) return Error(playerid, "Anda sudah membawa 100 kg Marijuana!");
		
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah marijuana:\nMarijuana Stock: "GREEN_E"%d\n"WHITE_E"Marijuana Price"GREEN_E"%s / item", Marijuana, FormatMoney(MarijuanaPrice));
		ShowPlayerDialog(playerid, DIALOG_DRUGS, DIALOG_STYLE_INPUT, "Buy Drugs", mstr, "Buy", "Cancel");
	}
	// Obat Myr
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -1274.8046,-423.5040,14.1784))
	{
		if(Inventory_Count(playerid, "Obat") >= 5) return Error(playerid, "Anda sudah membawa 5 Obat Myr!");
		
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Masukan jumlah Obat:\nObat Stock: "GREEN_E"%d\n"WHITE_E"Obat Price"GREEN_E"%s / item", ObatMyr, FormatMoney(ObatPrice));
		ShowPlayerDialog(playerid, DIALOG_OBAT, DIALOG_STYLE_INPUT, "Buy Obat", mstr, "Buy", "Cancel");
	}
	//Buy House
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
		{
			if(hData[hid][hPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this houses.");
			if(strcmp(hData[hid][hOwner], "-")) return Error(playerid, "Someone already owns this house.");
			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 2) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 3) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 4) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 1) return Error(playerid, "Kamu tidak dapat membeli rumah lebih.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -hData[hid][hPrice]);
			Server_AddMoney(hData[hid][hPrice]);
			GetPlayerName(playerid, hData[hid][hOwner], MAX_PLAYER_NAME);
			hData[hid][hVisit] = gettime();
			
			House_Refresh(hid);
			House_Save(hid);
		}
	}
	//Buy Bisnis
	foreach(new bid : Bisnis)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
		{
			if(bData[bid][bPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this bisnis.");
			if(strcmp(bData[bid][bOwner], "-")) return Error(playerid, "Someone already owns this bisnis.");
			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 2) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 3) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 4) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 1) return Error(playerid, "Anda tidak dapat membeli bisnis lagi.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -bData[bid][bPrice]);
			Server_AddMoney(-bData[bid][bPrice]);
			GetPlayerName(playerid, bData[bid][bOwner], MAX_PLAYER_NAME);
			bData[bid][bVisit] = gettime();
			
			Bisnis_Refresh(bid);
			Bisnis_Save(bid);
		}
	}
	//Buy Workshop
	foreach(new wid : Workshop)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]))
		{
			if(wsData[wid][wPrice] > GetPlayerMoney(playerid))
				return Error(playerid, "Not enough money, you can't afford this workshop.");
			if(wsData[wid][wOwnerID] != 0 || strcmp(wsData[wid][wOwner], "-")) 
				return Error(playerid, "Someone already owns this workshop.");

			#if LIMIT_PER_PLAYER > 0
			if(Player_WorkshopCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more workshop.");
			#endif

			GivePlayerMoneyEx(playerid, -wsData[wid][wPrice]);
			Server_AddMoney(wsData[wid][wPrice]);
			GetPlayerName(playerid, wsData[wid][wOwner], MAX_PLAYER_NAME);
			wsData[wid][wOwnerID] = pData[playerid][pID];
			new str[150];
			format(str,sizeof(str),"[WS]: %s membeli workshop id %d seharga %s!", NormalName(playerid), wid, FormatMoney(wsData[wid][wPrice]));

			Workshop_Refresh(wid);
			Workshop_Save(wid);
		}
	}
	foreach(new id : FurnStore)
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.0, storeData[id][storePos][0], storeData[id][storePos][1], storeData[id][storePos][2])) 
		{
			if (FurnStore_GetCount(playerid))
				return Error(playerid, "You've already have furniture store!");

			if(GetMoney(playerid) < storeData[id][storePrice])
				return Error(playerid, "Uang kamu tidak mencukupi.");

			if (storeData[id][storeOwner])
				return Error(playerid, "This furniture store is already owned by other players.");

			#if LIMIT_PER_PLAYER > 0
			if(FurnStore_GetCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more workshop.");
			#endif

			storeData[id][storeOwner] = pData[playerid][pID];
			format(storeData[id][storeOwnerName], MAX_PLAYER_NAME, ReturnName(playerid));

			FurnStore_Refresh(id);
			FurnStore_Save(id);

			GivePlayerMoneyEx(playerid, -storeData[id][storePrice]);
			Info(playerid, "Kamu telah membeli furniture store baru!.");
		}
	}
	//Buy Bisnis menu
	if(pData[playerid][pInBiz] >= 0 && IsPlayerInRangeOfPoint(playerid, 2.5, bData[pData[playerid][pInBiz]][bPointX], bData[pData[playerid][pInBiz]][bPointY], bData[pData[playerid][pInBiz]][bPointZ]))
	{
		Bisnis_BuyMenu(playerid, pData[playerid][pInBiz]);
	}
	return 1;
}

forward Revive(playerid);
public Revive(playerid)
{
	new otherid = GetPVarInt(playerid, "gcPlayer");
	TogglePlayerControllable(playerid,1);
	Servers(playerid, "Sukses revive");
	Inventory_Remove(playerid, "Obat", 1);
    pData[otherid][pInjured] = 0;
    pData[otherid][pHospital] = 0;
    pData[otherid][pSick] = 0;
    pData[otherid][pHead] = 100;
    pData[otherid][pPerut] = 100;
    pData[otherid][pRHand] = 100;
    pData[otherid][pLHand] = 100;
    pData[otherid][pRFoot] = 100;
    pData[otherid][pLFoot] = 100;
}

forward DownloadTwitter(playerid);
public DownloadTwitter(playerid)
{
	pData[playerid][pTwitter] = 1;
	pData[playerid][pKuota] -= 38000;
	Servers(playerid, "Twitter berhasil di Download");
}

/*
CMD:storages(playerid, params[])
{
	if(GetPlayerState(playerid) ==  PLAYER_STATE_ONFOOT)
		return Error(playerid, "Anda harus di dalam kendaraan");

	new vehid = GetPlayerVehicleID(playerid),
		str[900];

	foreach(new i : PVehicles) if(vehid == pvData[i][cVeh])
	{
    	format(str, 900, ""NIWRA"======= [Storage Lumberjack] =======\n\
    	"WHITE"Lumber: "LIGHTGREEN"%d\n\n\
		"NIWRA"======= [Storage Miner] =======\n\
		"WHITE"Metal: "LIGHTGREEN"%d\n\
		"WHITE"Coal: "LIGHTGREEN"%d\n\n\
		"NIWRA"======= [Storage Trucker] =======\n\
		"WHITE"Product: "LIGHTGREEN"%d\n\
		"WHITE"Gas Oil: "LIGHTGREEN"%d\n\
		"WHITE"Component Crate: "LIGHTGREEN"%d\n\
		"WHITE"Plant Crate: "LIGHTGREEN"%d\n\
		"WHITE"Fish Crate: "LIGHTGREEN"%d\n\
		"WHITE"Lumber Crate: "LIGHTGREEN"%d",
		pvData[i][cLumber], pvData[i][cMetal], pvData[i][cCoal], pvData[i][cProduct], pvData[i][cGasOil], pvData[i][cCompCrate], pvData[i][cPlantCrate], pvData[i][cFishCrate], pvData[i][cLumCrate]);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Storages", str, "Tutup", "");
	}
	return 1;
}*/

CMD:buypv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1775.7257,-1790.5582,13.8916))
		return Error(playerid, "Anda tidak berada di dekat showroom");

	if(pData[playerid][pInjured] && !pData[playerid][IsLoggedIn])
		return Error(playerid, "Anda tidak dapat menggunakan perintah ini");

	ShowPlayerDialog(playerid, DIALOG_BUYPVCP, DIALOG_STYLE_LIST, "{7fffd4}Basic Showroom", "Motorcycle\nMobil\nKendaraan Unik\nKendaraan Job", "Select", "Cancel");
	return 1;
}

CMD:claimsp(playerid, params[])
{
	if(pData[playerid][pInjured] == 1) 
		return Error(playerid, "Anda tidak dapat menggunakan ini");

	if(pData[playerid][pClaimSP] == 1)
		return Error(playerid, "Anda telah klaim starterpack");

	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1673.4685,-2310.3572,13.5431))
		return Error(playerid, "Anda harus berada di tempat claim starterpack");

	new count = 0, limit = MAX_PLAYER_VEHICLE + pData[playerid][pVip];
	foreach(new ii : PVehicles)
	{
		if(GetVehicleType(ii) == VEHICLE_TYPE_PLAYER)
		{
			if(pvData[ii][cExtraID] == pData[playerid][pID])
				count++;
		}
	}
	if(count >= limit)
	{
		Error(playerid, "This player have too many vehicles, sell a vehicle first!");
		return 1;
	}
	new cQuery[1024];
	new Float:x,Float:y,Float:z, Float:a;

	x = 1688.2261;
	y = -2319.0564;
	z = 13.3828;
	a = 91.9736;

	GivePlayerMoneyEx(playerid, 5000);
	Inventory_Add(playerid, "Snack", 2768, 5);
	Inventory_Add(playerid, "Sprunk", 2958, 5);
	pData[playerid][pClaimSP] = 1;

	mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`extraid`, `model`, `color1`, `color2`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], 468, 0, 0, x, y, z, a);
	mysql_tquery(g_SQL, cQuery, "OnVehCreated", "ddddddffff", playerid, playerid, pData[playerid][pID], 468, 0, 0, x, y, z, a);
	
	return 1;
}

CMD:cc(playerid, params[]) return callcmd::clearchat(playerid, "");
CMD:clearchat(playerid, params[])
{
	for (new i = 0; i < 100; i ++)
	{
	    SendClientMessage(playerid, -1, "");
	}
	return 1;
}

CMD:sw(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return Error(playerid, "You must inside a vehicle!");

	if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)
		return Error(playerid, "You must be passenger!");

	new str[512];
	format(str, sizeof(str), "Weapon\tAmmo\n");
	for(new i = 0; i < 13; i++)
	{
		if(pData[playerid][pGuns][i] != 0)
		{
			format(str, sizeof(str), "%s%s\t%d Left\n", str, ReturnWeaponName(pData[playerid][pGuns][i]), pData[playerid][pAmmo][i]);
		}
		else
		{
			format(str, sizeof(str), "%sEmpty slot\n", str);
		}
	}
	Dialog_Show(playerid, DIALOG_DRIVEBY, DIALOG_STYLE_TABLIST_HEADERS, "Switch Weapon (on vehicle)", str, "Switch", "Close");
	return 1;
}

CMD:cancelbox(playerid)
{
	if(pData[playerid][pSideJob] == SIDEJOB_NONE)
		return Error(playerid, "Anda sedang tidak bekerja sidejob");

	if(pData[playerid][pSideJob] == SIDEJOB_PIZZA)
	{
		if(pizzaHoldingBox[playerid])
		{
			if(pizzaDelivered[playerid] == 10) return 1;

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemovePlayerAttachedObject(playerid, 9);
			pizzaHoldingBox[playerid] = false;

			PlayerPlaySound(playerid, 40405, 0.0, 0.0, 0.0);
			ApplyAnimation(playerid, "CARRY", "putdwn105", 4.1, false, false, false, false, 0, true);
		}
	}
	if(pData[playerid][pSideJob] == SIDEJOB_COURIER)
	{
		if(CourierCrate[playerid] == 2)
		{
			RemovePlayerAttachedObject(playerid, 9);
			DisablePlayerRaceCheckpoint(playerid);
			CourierCrate[playerid] = 0;
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);

			PlayerPlaySound(playerid, 40405, 0.0, 0.0, 0.0);
			ApplyAnimation(playerid, "CARRY", "putdwn105", 4.1, false, false, false, false, 0, true);
		}
	}
	return 1;
}

CMD:myproperty(playerid, params[])
{
	new Dstring[950];
    format(Dstring, sizeof(Dstring), "%s"GREEN_E"1.\t(%s)\tResidential Properties:\n", Dstring, PropertiesResidential_GetCount(playerid));
    foreach (new i : Houses) if(Player_OwnsHouse(playerid, i)) {
		new type[128];
		if(hData[i][hType] == 1) type= "Small";
		else if(hData[i][hType] == 2) type= "Medium";
		else if(hData[i][hType] == 3) type= "Large";
		else type= "Unknow";
        format(Dstring, sizeof(Dstring), "%sH:%d\t"NIWRA"House"GREEN_E"[Owner]\t"WHITE_E"%s\n",Dstring, i, type);
    }
	format(Dstring, sizeof(Dstring), "%s"GREEN_E"2.\t(%s)\tCommercial Properties:\n",Dstring, PropertiesCommercial_GetCount(playerid));
    foreach(new i : Bisnis) if(Player_OwnsBisnis(playerid, i)) {
		format(Dstring, sizeof(Dstring), "%sB:%d\t"NIWRA"%s (Bisnis)"GREEN_E"[Owner]\t"WHITE_E"%s\n",Dstring, i, ReplaceString(bData[i][bName]), GetLocation(bData[i][bExtposX], bData[i][bExtposY], bData[i][bExtposZ]));
    }
    foreach(new i : Workshop) if(IsWorkshopOwner(playerid, i)) {
	 	format(Dstring, sizeof(Dstring), "%sW:%d\t"NIWRA"%s (Workshop)"GREEN_E"[Owner]\t"WHITE_E"%s\n",Dstring, i, ReplaceString(wsData[i][wName]), GetLocation(wsData[i][wX], wsData[i][wY], wsData[i][wZ]));
    }
	foreach (new i : FurnStore) if (FurnStore_IsOwner(playerid, i)) {
		format(Dstring, sizeof(Dstring), "%sFS:%d\t"NIWRA"%s (Furniture)"GREEN_E"[Owner]\t"WHITE_E"%s\n\n",Dstring, i, storeData[i][storeName], GetLocation(storeData[i][storePos][0], storeData[i][storePos][1], storeData[i][storePos][2]));
	}
	Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST, "Owned Property", Dstring, "Close", "");
	return 1;
}