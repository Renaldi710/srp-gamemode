
CMD:setskill(playerid, params[])
{
   if(pData[playerid][pAdmin] < 6)
      return PermissionError(playerid);

   new name[64], string[128], otherid;
   if(sscanf(params, "ds[64]S()[128]",otherid, name, string))
   {
      Usage(playerid, "/setskill [playerid] [name] [score/experience]");
      SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [mech], [fishing], [trucker] [farmer]");
      return 1;
   }
   if(!strcmp(name, "mech", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [mech] [score/experience]");

      if(stok < 0 || stok > 5000)
            return Error(playerid, "You must specify at least 0 or 5000");

      pData[otherid][pScoreMecha] = stok;
      UpdateTruckingSkill(playerid);
      Info(otherid, "Score Mechanic Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set score mechanic player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   else if(!strcmp(name, "fishing", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [fishing] [score/experience]");

      if(stok < 0 || stok > 500)
            return Error(playerid, "You must specify at least 0 or 500");

      pData[otherid][pScoreFishing] = stok;
      UpdateTruckingSkill(playerid);
      Info(otherid, "Score Fishing Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set score Fishing player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   else if(!strcmp(name, "trucker", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [trucker] [score/experience]");

      if(stok < 0 || stok > 150)
            return Error(playerid, "You must specify at least 0 or 150");

      pData[otherid][pScoreTrucker] = stok;
      UpdateTruckingSkill(playerid);
      Info(otherid, "Score Trucker Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set score Trucker player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   else if(!strcmp(name, "farmer", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [Farmer] [score/experience]");

      if(stok < 0 || stok > 1500)
            return Error(playerid, "You must specify at least 0 or 1500");

      pData[otherid][pScoreFarmer] = stok;
      UpdateTruckingSkill(playerid);
      Info(otherid, "Score Farmer Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set score Farmer player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   return 1;
}

CMD:setskillweapon(playerid, params[])
{
   if(pData[playerid][pAdmin] < 6)
      return PermissionError(playerid);

   new name[64], string[128], otherid;
   if(sscanf(params, "ds[64]S()[128]",otherid, name, string))
   {
      Usage(playerid, "/setskillweapon [playerid] [name] [score]");
      SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [deagle], [shotgun], [mp5], [ak47], [rifle]");
      return 1;
   }
   if(!strcmp(name, "deagle", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [deagle] [skill]");

      pData[playerid][pSkillWeapon][2] = stok;
      Info(otherid, "Skill deagle Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set skill deagle player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   else if(!strcmp(name, "shotgun", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [shotgun] [skill]");

      pData[playerid][pSkillWeapon][1] = stok;
      Info(otherid, "Skill shotgun Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set skill shotgun player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   else if(!strcmp(name, "mp5", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [mp5] [skill]");

      pData[playerid][pSkillWeapon][3] = stok;
      Info(otherid, "Skill mp5 Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set skill mp5 player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   else if(!strcmp(name, "ak47", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [ak47] [skill]");

      pData[playerid][pSkillWeapon][4] = stok;
      Info(otherid, "Skill ak47 Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set skill ak47 player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   else if(!strcmp(name, "rifle", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [rifle] [skill]");

      pData[playerid][pSkillWeapon][0] = stok;
      Info(otherid, "Skill rifle Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set skill rifle player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   return 1;
}

CMD:setscoreskill(playerid, params[])
{
   if(pData[playerid][pAdmin] < 6)
      return PermissionError(playerid);

   new name[64], string[128], otherid;
   if(sscanf(params, "ds[64]S()[128]",otherid, name, string))
   {
      Usage(playerid, "/setscoreskill [playerid] [name] [score]");
      SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} [mechanic], [fishing], [trucker]");
      return 1;
   }
   if(!strcmp(name, "mechanic", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [mechanic] [skill]");

      pData[otherid][pScoreMecha] = stok;
      Info(otherid, "Skill Mechanic Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set skill mechanic player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   else if(!strcmp(name, "fishing", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [fishing] [skill]");

      pData[otherid][pScoreFishing] = stok;
      Info(otherid, "Skill Fishing Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set skill Fishing player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   else if(!strcmp(name, "trucker", true))
   {
      new stok;
      if(sscanf(string, "d", stok))
            return Usage(playerid, "/setskill [playerid] [trucker] [skill]");

      pData[otherid][pScoreTrucker] = stok;
      Info(otherid, "Skill Trucker Anda Telah di set oleh admin %s", pData[playerid][pAdminname]);
      SendAdminMessage(X11_TOMATO, "%s set skill Trucker player %s.", pData[playerid][pAdminname], ReturnName(otherid));
   }
   return 1;
}

CMD:skills(playerid)
{
   if(pData[playerid][IsLoggedIn] == false)
      return Error(playerid, "You must logged in!");
   new string[1000];
   format(string, sizeof(string), "Name Skills\tExperience\tLevel\n");

   if(pData[playerid][pScoreTrucker] != -1)
   {
      if(pData[playerid][pScoreTrucker] <= 50) 
      {
         format(string, sizeof(string), "%sTrucker\t%d/50\t"WHITE_E"1\n", string, pData[playerid][pScoreTrucker]);
      }
      else if(pData[playerid][pScoreTrucker] <= 150)
      {
         format(string, sizeof(string), "%sTrucker\t%d/150\t"WHITE_E"2\n", string, pData[playerid][pScoreTrucker]);
      }
      else if(pData[playerid][pScoreTrucker] <= 200)
      {
         format(string, sizeof(string), "%sTrucker\t%d/200\t"WHITE_E"3\n", string, pData[playerid][pScoreTrucker]);
      }
      else if(pData[playerid][pScoreTrucker] <= 300)
      {
         format(string, sizeof(string), "%sTrucker\t%d/300\t"WHITE_E"4\n", string, pData[playerid][pScoreTrucker]);
      }
      else if(pData[playerid][pScoreTrucker] >= 300)
      {
         format(string, sizeof(string), "%sTrucker\t%d/350\t"WHITE_E"5\n", string, pData[playerid][pScoreTrucker]);
      }
   }
   if(pData[playerid][pScoreFishing] != -1)
   {
      if(pData[playerid][pScoreFishing] <= 99)
      {
         format(string, sizeof(string), "%sFish\t%d/100\t"WHITE_E"1\n", string, pData[playerid][pScoreFishing]);
      }
      if(pData[playerid][pScoreFishing] >= 99)
      {
         format(string, sizeof(string), "%sFish\t%d/200\t"WHITE_E"2\n", string, pData[playerid][pScoreFishing]);
      }
   }
   if(pData[playerid][pScoreMecha] != -1)
   {
      if(pData[playerid][pScoreMecha] <= 1500)
      {
         format(string, sizeof(string), "%sMechanic\t%d/1500\t"WHITE_E"1\n", string, pData[playerid][pScoreMecha]);
      }
      else if(pData[playerid][pScoreMecha] <= 2500)
      {
         format(string, sizeof(string), "%sMechanic\t%d/2500\t"WHITE_E"2\n", string, pData[playerid][pScoreMecha]);
      }
      else if(pData[playerid][pScoreMecha] <= 3500)
      {
         format(string, sizeof(string), "%sMechanic\t%d/3500\t"WHITE_E"3\n", string, pData[playerid][pScoreMecha]);
      }
      else if(pData[playerid][pScoreMecha] <= 4500)
      {
         format(string, sizeof(string), "%sMechanic\t%d/4500\t"WHITE_E"4\n", string, pData[playerid][pScoreMecha]);
      }
      else if(pData[playerid][pScoreMecha] >= 4500)
      {
         format(string, sizeof(string), "%sMechanic\t%d/4500\t"WHITE_E"5\n", string, pData[playerid][pScoreMecha]);
      }
   }
   if(pData[playerid][pScoreFarmer] != -1)
   {
      if(pData[playerid][pScoreFarmer] <= 1500)
      {
         format(string, sizeof(string), "%sFarmer\t%d/1500\t"WHITE_E"1\n", string, pData[playerid][pScoreFarmer]);
      }
      else if(pData[playerid][pScoreFarmer] <= 3500)
      {
         format(string, sizeof(string), "%sFarmer\t%d/3500\t"WHITE_E"2\n", string, pData[playerid][pScoreFarmer]);
      }
      else if(pData[playerid][pScoreFarmer] <= 6500)
      {
         format(string, sizeof(string), "%sFarmer\t%d/6500\t"WHITE_E"3\n", string, pData[playerid][pScoreFarmer]);
      }
      else if(pData[playerid][pScoreFarmer] <= 8500)
      {
         format(string, sizeof(string), "%sFarmer\t%d/8500\t"WHITE_E"4\n", string, pData[playerid][pScoreFarmer]);
      }
      else if(pData[playerid][pScoreFarmer] >= 8500)
      {
         format(string, sizeof(string), "%sFarmer\t%d/8500\t"WHITE_E"5\n", string, pData[playerid][pScoreFarmer]);
      }
   }
   //format(string, sizeof(string), "%sFight Style\t%s"WHITE_E"\n", string, GetFightStyleName(playerid));
   format(string, sizeof(string), "%sCountry Rifle\t%d"WHITE_E"\t%s\n", string, pData[playerid][pSkillWeapon][0], GetWeaponSkillName(playerid, 0));
   format(string, sizeof(string), "%sShotgun\t%d"WHITE_E"\t%s\n", string, pData[playerid][pSkillWeapon][1], GetWeaponSkillName(playerid, 1));
   format(string, sizeof(string), "%sDesert Eagle\t%d"WHITE_E"\t%s\n", string, pData[playerid][pSkillWeapon][2], GetWeaponSkillName(playerid, 2));
   format(string, sizeof(string), "%sMP5\t%d"WHITE_E"\t%s\n", string, pData[playerid][pSkillWeapon][3], GetWeaponSkillName(playerid, 3));
   format(string, sizeof(string), "%sAK47\t%d"WHITE_E"\t%s\n", string, pData[playerid][pSkillWeapon][4], GetWeaponSkillName(playerid, 4));
   Dialog_Show(playerid, SkillPlayer, DIALOG_STYLE_TABLIST_HEADERS, "Skills Player", string, "Pilih", "Close");
   return 1;
}

stock GetWeaponSkillName(playerid, index)
{
   new str[64];

   if(pData[playerid][pSkillWeapon][index] >= 0 && pData[playerid][pSkillWeapon][index] <= 300)
   {
      str = "Beginner";
   }
   else if(pData[playerid][pSkillWeapon][index] >= 300 && pData[playerid][pSkillWeapon][index] < 500)
   {
      str = "Novice";
   }
   else if(pData[playerid][pSkillWeapon][index] >= 500 && pData[playerid][pSkillWeapon][index] < 700)
   {
      str = "Gangster";
   }
   else if(pData[playerid][pSkillWeapon][index] >= 700 && pData[playerid][pSkillWeapon][index] < 999)
   {
      str = "Professional";
   }
   else if(pData[playerid][pSkillWeapon][index] == 999)
   {
      str = "Hitman";
   }
   return str;
}

Dialog:SkillPlayer(playerid, response, listitem, inputtext[])
{
   if(response)
   {
      switch (listitem)
      {
         case 0:
         {
            new tstr[500];
            format(tstr, sizeof(tstr), "Kegunaan Skil Player\n- {00FFFF}Level "YELLOW_E"2 {00FFFF}Mendapatkan Bonus "YELLOW_E"5\n- {00FFFF}Level "YELLOW_E"3 {00FFFF}Mendapatkan Bonus "YELLOW_E"10\n- {00FFFF}Level "YELLOW_E"4 {00FFFF}Mendapatkan Bonus "YELLOW_E"15\n- {00FFFF}Level "YELLOW_E"5 {00FFFF}Mendapatkan Bonus "YELLOW_E"20");
            ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Skill Player Trucker:", tstr, "Close", "");
         }
         case 1:
         {
            new tstr[500];
            format(tstr, sizeof(tstr), "Kegunaan Skil Player\n- {00FFFF}Level "YELLOW_E"1 {00FFFF}Hanya bisa mancing di pemancingan\n- {00FFFF}Level "YELLOW_E"2 {00FFFF}Bisa mancing di tengah laut dan di pemancingan");
            ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Skill Player Fishing:", tstr, "Close", "");
         }
         case 2:
         {
            new tstr[500];
            format(tstr, sizeof(tstr), "Kegunaan Skil Player\n- {00FFFF}Level "YELLOW_E"1 {00FFFF}Hanya bisa merepair kendaraan\n- {00FFFF}Level "YELLOW_E"2 {00FFFF}Bisa merespray/ganti warna kendaraan\n- {00FFFF}Level "YELLOW_E"3 {00FFFF}Bisa memodif beberapa part\n- {00FFFF}Level "YELLOW_E"4 {00FFFF}Bisa memodif semua part");
            ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Skill Player Mechanic:", tstr, "Close", "");
         }
      }
   }
   return 1;
}

UpdateTruckingSkill(playerid)
{
    //Trucker
	if(pData[playerid][pScoreTrucker] >= 50 && pData[playerid][pSkillTrucker] == 1)
	{
		pData[playerid][pSkillTrucker] = 2;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your trucker skills rising to 2");
	}
	else if(pData[playerid][pScoreTrucker] >= 150 && pData[playerid][pSkillTrucker] == 2)
	{
		pData[playerid][pSkillTrucker] = 3;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your trucker skills rising to 3");
	}
	else if(pData[playerid][pScoreTrucker] >= 200 && pData[playerid][pSkillTrucker] == 3)
	{
		pData[playerid][pSkillTrucker] = 4;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your trucker skills rising to 4");
	}
	else if(pData[playerid][pScoreTrucker] >= 300 && pData[playerid][pSkillTrucker] == 4)
	{
		pData[playerid][pSkillTrucker] = 5;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your trucker skills rising to 5");
	}
    return 1;
}

UpdateFishingSkill(playerid)
{
    //Fishing
    if(pData[playerid][pScoreFishing] >= 100 && pData[playerid][pSkillFishing] == 1)
	{
		pData[playerid][pSkillFishing] = 2;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your fishing skills rising to 2");
	}
    return 1;
}

UpdateMechSkill(playerid)
{
    //Mechanic
	if(pData[playerid][pScoreMecha] >= 500 && pData[playerid][pSkillMecha] == 1)
	{
		pData[playerid][pSkillMecha] = 2;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your mechanic skills rising to 2");
	}
	else if(pData[playerid][pScoreMecha] >= 1500 && pData[playerid][pSkillMecha] == 2)
	{
		pData[playerid][pSkillMecha] = 3;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your mechanic skills rising to 3");
	}
	else if(pData[playerid][pScoreMecha] >= 2500 && pData[playerid][pSkillMecha] == 3)
	{
		pData[playerid][pSkillMecha] = 4;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your mechanic skills rising to 4");
	}
	else if(pData[playerid][pScoreMecha] >= 3500 && pData[playerid][pSkillMecha] == 4)
	{
		pData[playerid][pSkillMecha] = 5;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your mechanic skills rising to 5");
	}
    return 1;
}

UpdateFarmerSkill(playerid)
{
    //Farmer
	if(pData[playerid][pScoreFarmer] >= 1500 && pData[playerid][pSkillFarmer] == 1)
	{
		pData[playerid][pSkillFarmer] = 2;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your farmer skills rising to 2");
	}
	else if(pData[playerid][pScoreFarmer] >= 3500 && pData[playerid][pSkillFarmer] == 2)
	{
		pData[playerid][pSkillFarmer] = 3;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your farmer skills rising to 3");
	}
	else if(pData[playerid][pScoreFarmer] >= 6500 && pData[playerid][pSkillFarmer] == 3)
	{
		pData[playerid][pSkillFarmer] = 4;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your farmer skills rising to 4");
	}
	else if(pData[playerid][pScoreFarmer] >= 8500 && pData[playerid][pSkillFarmer] == 4)
	{
		pData[playerid][pSkillFarmer] = 5;
		Custom(playerid, "SKILL", ""YELLOW_E"Congratulations on your farmer skills rising to 5");
	}
    return 1;
}

ptask UpdateSKillPlayer[1000](playerid)
{
    if(pData[playerid][IsLoggedIn] == true)
    {
        UpdateMechSkill(playerid);
    }
	return 1;
}