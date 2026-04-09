


CreateArmsPoint()
{
	//JOBS
	new strings[400], strings2[214];
	CreateDynamicPickup(1239, 23, 321.5652,1121.2504,1083.8828, -1);
	format(strings, sizeof(strings), ""RED_E"[ARMS DEALER]\n"YELLOW_E"'/getjob' "WHITE_E"to be an Arms Dealer\n"YELLOW_E"'/buyschematic' "WHITE_E"to buy gun schematicn\n"YELLOW_E"'/buypacket' "WHITE_E"buy material packet\nAvailable packages: "GREEN_E"%d", Material);
	MatText = CreateDynamic3DTextLabel(strings, ARWIN, 321.5652,1121.2504,1083.8828+0.5, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //

	CreateDynamicPickup(1239, 23, 2345.4207,-1184.7029,1027.9766, -1, -1, -1, 5.0);
	format(strings2, sizeof(strings2), ""RED_E"[DRUG DEALER]\n"YELLOW_E"'/getjob' "WHITE_E"to be an Drug Dealer\n"YELLOW_E"'/buypacket' "WHITE_E"to buy drugs package\nAvailable packages: "GREEN_E"%d", Marijuana);
	Crack = CreateDynamic3DTextLabel(strings2, ARWIN, 2345.4207,-1184.7029,1027.9766+0.5, 5.0); // product

	CreateDynamicPickup(1239, 23, 1273.3732,392.2403,19.5614, -1, -1, -1, 5.0);
	format(strings2, sizeof(strings2), ""RED_E"[SMUGGLE JOB]\n"YELLOW_E"'/getjob' "WHITE_E"to be an Smuggle Dealer");
	CreateDynamic3DTextLabel(strings2, ARWIN, 1273.3732,392.2403,19.5614+0.5, 5.0); // product
}

SchematicRequire(playerid, type)
{
    static
        str[212];

    switch (type)
    {
        case 0: 
		{
			if(Inventory_Count(playerid, "SG_Schematic") == 0) str = ""RED_E"Not Have"WHITE_E"";
			else str = ""GREEN_E"Have"WHITE_E"";
		}
        case 1: 
		{
			if(Inventory_Count(playerid, "DE_Schematic") == 0) str = ""RED_E"Not Have"WHITE_E"";
			else str = ""GREEN_E"Have"WHITE_E"";
		}
		case 2: 
		{
			if(Inventory_Count(playerid, "MP5_Schematic") == 0) str = ""RED_E"Not Have"WHITE_E"";
			else str = ""GREEN_E"Have"WHITE_E"";
		}
		case 3: 
		{
			if(Inventory_Count(playerid, "AK47_Schematic") == 0) str = ""RED_E"Not Have"WHITE_E"";
			else str = ""GREEN_E"Have"WHITE_E"";
		}
    }
    return str;
}

Dialog:PacketMaterial(playerid, response, listitem, inputtext[]) {
    if(response)
	{
		new strings[214];
		if(GetPlayerMoney(playerid) < 5703) return Error(playerid, "You don't have enough cash");
		GivePlayerMoneyEx(playerid, -5703);
		Inventory_Add(playerid, "Material", -1, 2500);
		Material -= 1;
		format(strings, sizeof(strings), ""RED_E"[ARMS DEALER]\n"YELLOW_E"'/getjob' "WHITE_E"to be an Arms Dealer\n"YELLOW_E"'/buyschematic' "WHITE_E"to buy gun schematicn\n"YELLOW_E"'/buypacket' "WHITE_E"buy material packet\nAvailable packages: "GREEN"%d", Material);
		UpdateDynamic3DTextLabelText(MatText, ARWIN, strings);
		SendClientMessageEx(playerid, ARWIN, "DEALER: "WHITE_E"You've purchase a material package that contains "YELLOW_E"2500 units "WHITE_E"of material for "GREEN_E"$5,703");
	}
	return 1;
}

Dialog:BuyPot(playerid, response, listitem, inputtext[]) {
    if(response)
	{
		new strings2[214];
		if(pData[playerid][pMoney] < 304) return Error(playerid, "You don't have enough cash");
		GivePlayerMoneyEx(playerid, -304);
		Inventory_Add(playerid, "Pot", -1);
		Marijuana -= 1;
		format(strings2, sizeof(strings2), ""RED_E"[DRUG DEALER]\n"YELLOW_E"'/getjob' "WHITE_E"to be an Drug Dealer\n"YELLOW_E"'/buypacket' "WHITE_E"to buy drugs package\nAvailable packages: "GREEN"%d", Marijuana);
		UpdateDynamic3DTextLabelText(Crack, ARWIN, strings2);
		SendClientMessageEx(playerid, ARWIN, "[DEALER]: "WHITE_E"You've purchase a drug package that contains "YELLOW_E"100 grams "WHITE_E"of pot for "GREEN_E"$304.36");
	}
	return 1;
}

Dialog:BuyCrack(playerid, response, listitem, inputtext[]) {
    if(response)
	{
		new strings2[214];
		if(pData[playerid][pMoney] < 304) return Error(playerid, "You don't have enough cash");
		GivePlayerMoneyEx(playerid, -304);
		Inventory_Add(playerid, "Crack", -1);
		Marijuana -= 50;
		format(strings2, sizeof(strings2), ""RED_E"[DRUG DEALER]\n"YELLOW_E"'/getjob' "WHITE_E"to be an Drug Dealer\n"YELLOW_E"'/buypacket' "WHITE_E"to buy drugs package\nAvailable packages: "GREEN_E"%d", Marijuana);
		UpdateDynamic3DTextLabelText(Crack, ARWIN, strings2);
		SendClientMessageEx(playerid, ARWIN, "DEALER: "WHITE_E"You've purchase a drug package that contains "YELLOW_E"50 grams "WHITE_E"of crack for "GREEN_E"$304.36");
	}
	return 1;
}


Dialog:CreateGun(playerid, response, listitem, inputtext[]) {
    if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				if(Inventory_Count(playerid, "Material") >= 2000)
				{
					if(Inventory_Count(playerid, "SG_Schematic") < 0) return Error(playerid, "You don't have the schematic of the weapon");
					if(PlayerHasWeapon(playerid, 25))
						return Error(playerid, "You already have %s, /buyammo to add more ammo.", ReturnWeaponName(25));

					if(PlayerHasWeaponInSlot(playerid, 25))
						return Error(playerid, "You already have weapon in the same slot.");
					GivePlayerWeaponEx(playerid, 25, 1);
					Inventory_Remove(playerid, "Material", 2000);
					pData[playerid][pWeaponCreateTime] = 600;
					SendClientMessageEx(playerid, ARWIN, "CRAFTING: "WHITE_E"You've crafted "YELLOW_E"Shotgun "WHITE_E"Using "LIGHTGREEN"2000 materials");
				}
				else
				{
					Error(playerid, "You don't have enough materials.");
				}
			}
			case 1:
			{
				if(pData[playerid][pFamily] < 0) return Error(playerid, "You're not in a family.");
				if(Inventory_Count(playerid, "Material") >= 2500)
				{
					if(Inventory_Count(playerid, "DE_Schematic") < 0) return Error(playerid, "You don't have the schematic of the weapon");
					if(PlayerHasWeapon(playerid, 24))
						return Error(playerid, "You already have %s, /buyammo to add more ammo.", ReturnWeaponName(24));

					if(PlayerHasWeaponInSlot(playerid, 24))
						return Error(playerid, "You already have weapon in the same slot.");
					GivePlayerWeaponEx(playerid, 24, 1);
					Inventory_Remove(playerid, "Material", 2500);
					pData[playerid][pWeaponCreateTime] = 600;
					SendClientMessageEx(playerid, ARWIN, "CRAFTING: "WHITE_E"You've crafted "YELLOW_E"Desert Eagle "WHITE_E"Using "LIGHTGREEN"2500 materials");
				}
				else
				{
					Error(playerid, "You don't have enough materials.");
				}
			}
			case 2:
			{
				if(pData[playerid][pFamily] < 0) return Error(playerid, "You're not in a family.");
				if(Inventory_Count(playerid, "Material") >= 5000)
				{
					if(Inventory_Count(playerid, "MP5_Schematic") < 0) return Error(playerid, "You don't have the schematic of the weapon");
					if(PlayerHasWeapon(playerid, 29))
						return Error(playerid, "You already have %s, /buyammo to add more ammo.", ReturnWeaponName(29));

					if(PlayerHasWeaponInSlot(playerid, 29))
						return Error(playerid, "You already have weapon in the same slot.");
					GivePlayerWeaponEx(playerid, 29, 1);
					Inventory_Remove(playerid, "Material", 5000);
					pData[playerid][pWeaponCreateTime] = 600;
					SendClientMessageEx(playerid, ARWIN, "CRAFTING: "WHITE_E"You've crafted "YELLOW_E"MP5 "WHITE_E"Using "LIGHTGREEN"5000 materials");
				}
				else
				{
					Error(playerid, "You don't have enough materials.");
				}
			}
			case 3:
			{
				if(pData[playerid][pFamily] < 0) return Error(playerid, "You're not in a family.");
				if(Inventory_Count(playerid, "Material") >= 7000)
				{
					if(Inventory_Count(playerid, "AK47_Schematic") < 0) return Error(playerid, "You don't have the schematic of the weapon");
					if(PlayerHasWeapon(playerid, 30))
						return Error(playerid, "You already have %s, /buyammo to add more ammo.", ReturnWeaponName(30));

					if(PlayerHasWeaponInSlot(playerid, 30))
						return Error(playerid, "You already have weapon in the same slot.");
					GivePlayerWeaponEx(playerid, 30, 1);
					Inventory_Remove(playerid, "Material", 7000);
					pData[playerid][pWeaponCreateTime] = 600;
					SendClientMessageEx(playerid, ARWIN, "CRAFTING: "WHITE_E"You've crafted "YELLOW_E"AK47 "WHITE_E" Using "LIGHTGREEN"7000 materials");
				}
				else
				{
					Error(playerid, "You don't have enough materials.");
				}
			}
		}
	}
	return 1;
}

Dialog:CreateAmmo(playerid, response, listitem, inputtext[]) {
    if(response)
	{
		new weaponid = GetWeapon(playerid);
		new amount = (MaxGunAmmo[weaponid]-ReturnWeaponAmmo(playerid, weaponid));

        if(Inventory_Count(playerid, "Material") < floatround(amount/2))
			return Error(playerid, "Jumlah material tidak mencukupi.");

		if(weaponid > 22 || weaponid < 38)
		{
			pData[playerid][pAmmo][g_aWeaponSlots[weaponid]] += amount;
            Inventory_Remove(playerid, "Material", floatround((amount/2)));
			SendClientMessageEx(playerid, ARWIN, "CRAFTING: "WHITE_E"Crafted "YELLOW_E"%d Ammo "WHITE_E"Using "YELLOW_E"%d materials", amount, floatround((amount/2)));
		}
	}
	return 1;
}

Dialog:BuySchematic(playerid, response, listitem, inputtext[]) {
    if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				if(Inventory_Count(playerid, "SG_Schematic") > 0) return Error(playerid, "You already have the schematic of the weapon");
				if(pData[playerid][pMoney] < 125) return Error(playerid, "You don't have money");
				Inventory_Add(playerid, "SG_Schematic", 3111);
				GivePlayerMoneyEx(playerid, -125);
				Custom(playerid, "SCHEMATIC", "You've purchased the "RED_E"Shotgun Schematic "WHITE_E"for "GREEN_E"$125.00");
			}
			case 1:
			{
				if(Inventory_Count(playerid, "DE_Schematic") > 0) return Error(playerid, "You already have the schematic of the weapon");
				if(pData[playerid][pMoney] < 125) return Error(playerid, "You don't have money");
				Inventory_Add(playerid, "DE_Schematic", 3111);
				GivePlayerMoneyEx(playerid, -125);
				Custom(playerid, "SCHEMATIC", "You've purchased the "RED_E"Desert Eagle Schematic "WHITE_E"for "GREEN_E"$125.00");
			}
			case 2:
			{
				if(Inventory_Count(playerid, "MP5_Schematic") > 0) return Error(playerid, "You already have the schematic of the weapon");
				if(pData[playerid][pMoney] < 200) return Error(playerid, "You don't have money");
				Inventory_Add(playerid, "MP5_Schematic", 3111);
				GivePlayerMoneyEx(playerid, -200);
				Custom(playerid, "SCHEMATIC", "You've purchased the "RED_E"MP5 Schematic "WHITE_E"for "GREEN_E"$200.00");
			}
			case 3:
			{
				if(Inventory_Count(playerid, "AK47_Schematic") > 0) return Error(playerid, "You already have the schematic of the weapon");
				if(pData[playerid][pMoney] < 250) return Error(playerid, "You don't have money");
				Inventory_Add(playerid, "AK47_Schematic", 3111);
				GivePlayerMoneyEx(playerid, -250);
				Custom(playerid, "SCHEMATIC", "You've purchased the "RED_E"AK47 Schematic "WHITE_E"for "GREEN_E"$250.00");
			}
		}
	}
	return 1;
}


CMD:buypacket(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.5, 321.5652,1121.2504,1083.8828))
	{
		if(pData[playerid][pJob] == 8 || pData[playerid][pJob2] == 8)
		{
			Dialog_Show(playerid, PacketMaterial, DIALOG_STYLE_MSGBOX, "Buying Material","Price per packet: "GREEN"$5,703\nAmmount: "YELLOW_E"2500 units\nConfirm purchase?", "Yes", "No" );
		}
		else
		{
			Error(playerid, "Anda bukan pekerja arms dealer");
		}
	}
	else if(IsPlayerInRangeOfPoint(playerid, 3.5, 2345.4207,-1184.7029,1027.9766))
	{
		if(pData[playerid][pJob] == 9 || pData[playerid][pJob2] == 9)
		{
			if(isnull(params)) 
			{
				Usage(playerid, "/buypacket [pot/crack]");
				return 1;
			}
			if(strcmp(params,"pot",true) == 0) 
			{
				Dialog_Show(playerid,BuyPot,DIALOG_STYLE_MSGBOX,"Buying Drug: Pot","Price per packet: "GREEN_E"$304.36\n"GREEN_E"Weight: "YELLOW_E"100 grams\nConfirm purchase?", "Yes", "No" );
			}
			if(strcmp(params,"crack",true) == 0) 
			{
				if(pData[playerid][pFamily] == -1)
					return Error(playerid, "You are not in family!");
				Dialog_Show(playerid,BuyCrack,DIALOG_STYLE_MSGBOX,"Buying Drug: Crack","Price per packet: "GREEN_E"$304.36\n"GREEN_E"Weight: "YELLOW_E"50 grams\nConfirm purchase?", "Yes", "No" );
			}
		}
		else
		{
			Error(playerid, "Anda bukan pekerja drugs dealer");
		}	
	}
	return 1;	
}

CMD:buyschematic(playerid)
{
	//Ubah Sendiri
	if(pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8) return Error(playerid, "Kamu tidak bekerja sebagai arms dealer.");
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, 321.5652,1121.2504,1083.8828)) return Error(playerid, "You're not near schematic buy point");
	new str[518];
	format(str, sizeof(str), "Schematic\tCost\nShotgun\t$125\nDesert Eagle\t$200\nMP5\t$250\nAK47\t$450");
	Dialog_Show(playerid, BuySchematic, DIALOG_STYLE_TABLIST_HEADERS, "Buying Schematic", str, "Buy", "Cancel");
	return 1;
}

CMD:creategun(playerid, params[]) 
{
	if(pData[playerid][pOnDuty]) 
        return Error(playerid, "Kamu sedang duty faction.");

    if(pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8)
    	return Error(playerid, "Kamu tidak bekerja sebagai arms dealer.");

	//if (!pData[playerid][pCS])
		//return Error(playerid, "You must have accepted character story for creating a gun.");
	if(pData[playerid][pWeaponCreateTime] != 0) return Error(playerid, "Anda harus menunggu %d untuk mengakses perintah ini", pData[playerid][pWeaponCreateTime]/60);
    new String[512];

	if(pData[playerid][pFamily] > -1)
	{
		format(String, sizeof(String), "Weapons Name\tMaterial Cost\tRequire Schematic\n");
		format(String, sizeof(String),"%sShotgun\t2000\t%s\nDesert Eagle\t2500\t%s\nMP5\t5000\t%s\nAK47\t7000\t%s",String, SchematicRequire(playerid, 0), SchematicRequire(playerid, 1), SchematicRequire(playerid, 2),SchematicRequire(playerid, 3));
	}
	else
	{
		format(String, sizeof(String), "Weapons Name\tMaterial Cost\tRequire Schematic\n");
		format(String, sizeof(String),"%sShotgun\t2000\t%s",String, SchematicRequire(playerid, 0));
	}
    Dialog_Show(playerid, CreateGun, DIALOG_STYLE_TABLIST_HEADERS, "Weapon Crafting", String, "Create", "Cancel");
	return 1;
}

CMD:createammo(playerid, params[])
{
    if(pData[playerid][pOnDuty]) 
        return Error(playerid, "Kamu sedang duty faction.");

    if(pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8)
    	return Error(playerid, "Kamu tidak bekerja sebagai arms dealer.");

	//if (!pData[playerid][pCS])
       // return Error(playerid, "You must have accepted character story for creating ammo.");

    if(Inventory_Count(playerid, "Material") < 1)
        return Error(playerid, "Kamu tidak memiliki material.");

    new
        weaponid,
		String[212];

    if((weaponid = GetWeapon(playerid)) == 0) 
        return Error(playerid, "Kamu tidak memegang senjata apapun.");

    if(g_aWeaponSlots[weaponid] == 1)
    	return Error(playerid, "Senjata ini tidak dapat diisi amunisi.");

	if (ReturnWeaponAmmo(playerid, weaponid) >= MaxGunAmmo[weaponid])
		return Error(playerid, "Senjata ini tidak memerlukan amunisi lagi.");
	if(!weaponid) return SendClientMessageEx(playerid, X11_GRAY, "ERROR: You are not holding a weapon.");
	new category[32], string[32];

	if(sscanf(params, "s[32]S()[32]", category, string)) {
		format(String,sizeof(String),"Weapon: "LIGHTGREEN"%s\n"GREEN_E"Creating ammo: %d/%d\n"YELLOW_E"Material Cost: %d unit(s)", ReturnWeaponName(weaponid), (MaxGunAmmo[weaponid]-ReturnWeaponAmmo(playerid, weaponid)), MaxGunAmmo[weaponid], floatround(((MaxGunAmmo[weaponid]-ReturnWeaponAmmo(playerid, weaponid))/2)));
		Dialog_Show(playerid,CreateAmmo,DIALOG_STYLE_MSGBOX,"Ammo Crafting",String,"Create", "Cancel");
	}
    /*
	if(!strcmp(category, "surplus")) {
		new ammount;
		if(pData[playerid][pFamily] < 0) return Error(playerid, "You're not in a family.");
		if(sscanf(string, "d", ammount))
			return Usage(playerid, "/createammo [surplus] [ammount]");

        if(Inventory_Count(playerid, "Material") < floatround(ammount/2*5))
			return Error(playerid, "Jumlah material tidak mencukupi.");

		if(weaponid > 22 || weaponid < 38)
		{
			pData[playerid][pAmmo][g_aWeaponSlots[weaponid]] += ammount;
            Inventory_Remove(playerid, "Material", floatround((ammount/2*5)));
			pData[playerid][pAmmoSurplus][g_aWeaponSlots[weaponid]] = 1;
			SendClientMessageEx(playerid, ARWIN, "[CRAFTING]: "WHITE_E"Crafted "YELLOW_E"%d Ammo Surplus "WHITE_E"Using "YELLOW_E"%d materials", ammount, floatround((ammount/2*5)));
		}
	}*/
    return 1;
}
