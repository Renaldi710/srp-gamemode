/*#define MAX_SALARY 15

enum E_SALARY
{
	salOwner,
	salInfo[16],
	salMoney,
	salDate[30]
};
new SalData[MAX_SALARY][E_SALARY];*/

AddPlayerSalary(playerid, info[], money)
{
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO salary(owner, info, money, date) VALUES ('%d', '%s', '%d', CURRENT_TIMESTAMP())", pData[playerid][pID], info, money);
	mysql_tquery(g_SQL, query);
	return true;
}

alias:salary("mysalary")

CMD:salary(playerid, params[])
{
	DisplaySalary(playerid);
	return 1;
}


DisplaySalary(playerid)
{
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM salary WHERE owner='%d' ORDER BY id ASC LIMIT 30", pData[playerid][pID]);
	mysql_query(g_SQL, query);
	new rows = cache_num_rows();
	if(rows) 
	{
		new list[2000], date[30], info[46], money, totalduty, gajiduty, totalsal, total;
		
		totalduty = pData[playerid][pOnDutyTime] + pData[playerid][pTaxiTime];
		if(totalduty > 600)
		{
			gajiduty = 600;
		}
		else
		{
			gajiduty = totalduty;
		}
		format(list, sizeof(list), ""WHITE_E"Date\tInfo\tAmmount\n");
		if(pData[playerid][pFaction] >= 1)
		{
			format(list, sizeof(list), "%sCurrent Time\tFaction\t"LG_E"%s\n", list, FormatMoney(gajiduty));
		}
		if(pData[playerid][pJob] == 1 || pData[playerid][pJob2] == 1)
		{
			format(list, sizeof(list), "%s"WHITE_E"Current Time\tTaxi Duty\t"LG_E"%s\n", list, FormatMoney(gajiduty));
		}
		for(new i; i < rows; ++i)
	    {
			cache_get_value_name(i, "info", info);
			cache_get_value_name(i, "date", date);
			cache_get_value_name_int(i, "money", money);
			
			format(list, sizeof(list), "%s"WHITE_E"%s\t%s\t"LG_E"%s\n", list, date, info, FormatMoney(money));
			totalsal += money;
		}
		total = gajiduty + totalsal;
		format(list, sizeof(list), "%s"WHITE_E"     \tTotal:\t"LG_E"%s\n", list, FormatMoney(total));
		
		new title[48];
		format(title, sizeof(title), "Salary: %s", pData[playerid][pName]);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Close", "");
	}
	else
	{
		new list[2000], totalduty, gajiduty;
		
		totalduty = pData[playerid][pOnDutyTime] + pData[playerid][pTaxiTime];
		if(totalduty > 500)
		{
			gajiduty = 500;
		}
		else
		{
			gajiduty = totalduty;
		}
		format(list, sizeof(list), ""WHITE_E"Date\tInfo\tAmmount\n");
		if(pData[playerid][pFaction] >= 1)
		{
			format(list, sizeof(list), "%sCurrent Time\tFaction\t"LG_E"%s\n", list, FormatMoney(gajiduty));
		}
		if(pData[playerid][pJob] == 1 || pData[playerid][pJob2] == 1)
		{
			format(list, sizeof(list), "%s"WHITE_E"Current Time\tTaxi Duty\t"LG_E"%s\n", list, FormatMoney(gajiduty));
		}
		format(list, sizeof(list), "%s"WHITE_E"     \tTotal:\t"LG_E"%s\n", list, FormatMoney(gajiduty));
		
		new title[48];
		format(title, sizeof(title), "Salary: %s", pData[playerid][pName]);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Close", "");
	}
	return 1;
}


DisplayPaycheck(playerid)
{
	if(pData[playerid][pPaycheck] <= 3600) return Error(playerid, "Sekarang belum waktunya anda mengambil paycheck.");
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM salary WHERE owner='%d' ORDER BY id ASC LIMIT 100", pData[playerid][pID]);
	mysql_query(g_SQL, query);
	new rows = cache_num_rows();
	if(rows) 
	{
		new money, total, pajak, taxvehicle, taxhouse, taxbisnis, hasil, jumlahkendaraan, jumlahbisnis, jumlahrumah;
		for(new i; i < rows; ++i)
		{
			cache_get_value_name_int(i, "money", money);
			total += money;
		}
		foreach(new vehicleid : PVehicles) if(GetVehicleType(vehicleid) == VEHICLE_TYPE_PLAYER && pvData[vehicleid][cExtraID] == pData[playerid][pID]) jumlahkendaraan++;
		taxvehicle = jumlahkendaraan*50;
		foreach (new i : Houses) if(Player_OwnsHouse(playerid, i)) jumlahrumah++;
		taxhouse = jumlahrumah*70;
		foreach(new i : Bisnis) if(Player_OwnsBisnis(playerid, i)) jumlahbisnis++;
		foreach(new i : Workshop) if(IsWorkshopOwner(playerid, i)) jumlahbisnis++;

		taxbisnis = jumlahbisnis*50;
		pajak = taxbisnis+taxhouse+taxvehicle;
		hasil = total - pajak;
		SendClientMessageEx(playerid, ARWIN, "{7fffd4}<====================< "WHITE_E"Paycheck {7fffd4}>====================>");
		SendClientMessageEx(playerid, ARWIN, "{7fffd4}=> "WHITE_E"Bank interest: {00FF00}%s", FormatMoney(total));
		SendClientMessageEx(playerid, ARWIN, "{7fffd4}=> "WHITE_E"Income Tax: {FF0000}%s", FormatMoney(pajak));
		pData[playerid][pBankMoney] += hasil;
		SendClientMessageEx(playerid, ARWIN, "{7fffd4}=> "WHITE_E"New Balance: {00FF00}%s", FormatMoney(pData[playerid][pBankMoney]));
		SendClientMessageEx(playerid, ARWIN, "{7fffd4}<====================================================>");
		Server_MinMoney(hasil);
		pData[playerid][pPaycheck] = 0;
		pData[playerid][pOnDutyTime] = 0;
		pData[playerid][pTaxiTime] = 0;
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM salary WHERE owner='%d'", pData[playerid][pID]);
		mysql_query(g_SQL, query);
	}
	else
	{
		new total, pajak, taxvehicle, taxhouse, taxbisnis, hasil, jumlahkendaraan, jumlahbisnis, jumlahrumah;
		foreach(new vehicleid : PVehicles) if(GetVehicleType(vehicleid) == VEHICLE_TYPE_PLAYER && pvData[vehicleid][cExtraID] == pData[playerid][pID]) jumlahkendaraan++;
		taxvehicle = jumlahkendaraan*50;
		foreach (new i : Houses) if(Player_OwnsHouse(playerid, i)) jumlahrumah++;
		taxhouse = jumlahrumah*70;
		foreach(new i : Bisnis) if(Player_OwnsBisnis(playerid, i)) jumlahbisnis++;
		foreach(new i : Workshop) if(IsWorkshopOwner(playerid, i)) jumlahbisnis++;

		taxbisnis = jumlahbisnis*70;
		pajak = taxbisnis+taxhouse+taxvehicle;
		hasil = total - pajak;
		SendClientMessageEx(playerid, ARWIN, "{7fffd4}<====================< "WHITE_E"Paycheck {7fffd4}>====================>");
		SendClientMessageEx(playerid, ARWIN, "{7fffd4}=> "WHITE_E"Bank interest: {00FF00}%s", FormatMoney(total));
		SendClientMessageEx(playerid, ARWIN, "{7fffd4}=> "WHITE_E"Income Tax: {FF0000}%s", FormatMoney(pajak));
		pData[playerid][pBankMoney] += hasil;
		SendClientMessageEx(playerid, ARWIN, "{7fffd4}=> "WHITE_E"New Balance: {00FF00}%s", FormatMoney(pData[playerid][pBankMoney]));
		SendClientMessageEx(playerid, ARWIN, "{7fffd4}<====================================================>");
		Server_MinMoney(hasil);
		pData[playerid][pPaycheck] = 0;
		pData[playerid][pOnDutyTime] = 0;
		pData[playerid][pTaxiTime] = 0;
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM salary WHERE owner='%d'", pData[playerid][pID]);
		mysql_query(g_SQL, query);
	}
	return 1;
}


