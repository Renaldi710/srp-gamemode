
//variables
new FishName[MAX_PLAYERS][5][32];
new Float:FishWeight[MAX_PLAYERS][5];

IsAtFishArea(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(IsPlayerInRangeOfPoint(playerid,1.0,403.8266,-2088.7598,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,398.7553,-2088.7490,7.8359)) return 1;
		else if(IsPlayerInRangeOfPoint(playerid,1.0,396.2197,-2088.6692,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,391.1094,-2088.7976,7.8359)) return 1;
		else if(IsPlayerInRangeOfPoint(playerid,1.0,383.4157,-2088.7849,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,374.9598,-2088.7979,7.8359)) return 1;
		else if(IsPlayerInRangeOfPoint(playerid,1.0,369.8107,-2088.7927,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,367.3637,-2088.7925,7.8359)) return 1;
		else if(IsPlayerInRangeOfPoint(playerid,1.0,362.2244,-2088.7981,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,354.5382,-2088.7979,7.8359)) return 1;
        else if(IsPlayerInRangeOfPoint(playerid,1.0,349.8621, -2052.0488, 7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,349.8976, -2059.6501, 7.8359)) return 1;
        else if(IsPlayerInRangeOfPoint(playerid,1.0,349.9232, -2064.9419, 7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,349.9330, -2067.3057, 7.8359)) return 1;
        else if(IsPlayerInRangeOfPoint(playerid,1.0,349.9572, -2072.4199, 7.8359)) return 1;
	}
	return 0;
}

timer getFish[30000](playerid)
{
    if(!pData[playerid][pInFish]) return 0;
    Custom(playerid, "FISHING", "{FFFF00}You caught something on the pole, press {FF0000}mouse left click {FFFF00}to pull the fishing rod");
    SetPVarInt(playerid, "Fishing", 1);
    return 1;
}

AddFish(playerid, Float:weight)
{
    for(new i = 0; i < 5; i++) {
        if(!FishWeight[playerid][i]) {
            FishWeight[playerid][i] = weight;
            new total = floatround(weight*15.0);
            // format(FishName[playerid][i], 32, name);
            Custom(playerid, "FISHING", "{FFFF00}Ocean fish caught!, weight: %doz", total);
            if(Inventory_Count(playerid, "Fish Tool") == 0) return Info(playerid, "Fish tools anda rusak silahkan beli lagi");
            return 1;
        }
    }
    return 1;
}

//callbacks
#include <YSI\y_hooks>
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_FIRE) {
		if(pData[playerid][pInFish] == 1 && !GetPVarInt(playerid, "Fishing")) {
			TogglePlayerControllable(playerid, 1);
			ClearAnimations(playerid);
			StopLoopingAnim(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemovePlayerAttachedObject(playerid, 9);
			pData[playerid][pInFish] = 0;
			DeletePVar(playerid, "Fishing");
			stop getFish(playerid);
			return 1;
		}
		else if(GetPVarInt(playerid, "Fishing") && pData[playerid][pInFish] == 1) {
			TogglePlayerControllable(playerid, 1);
			foreach(new fishing : FishingArea) if(IsPlayerInDynamicArea(playerid, FishingData[fishing][Zone])) {
				new rand = random(8);
				switch(FishingData[fishing][Type])
				{
					case 0: {
						switch(rand)
						{
							case 0: Custom(playerid, "FISHING", "You caught only junk");
							case 1: Custom(playerid, "FISHING", "You caught only junk");
							case 2: AddFish(playerid, RandomFloat(1.0,3.5));
							case 3: AddFish(playerid, RandomFloat(1.0,3.5));
							case 4: Custom(playerid, "FISHING", "You caught only junk");
							case 5: AddFish(playerid, RandomFloat(1.0,3.5));
							case 6: AddFish(playerid, RandomFloat(1.0,3.5));
							case 7: Custom(playerid, "FISHING", "You caught only junk");
						}
					}
					case 1: {
						switch(rand)
						{
							case 0: AddFish(playerid, RandomFloat(1.9,4.5));
							case 1: Custom(playerid, "FISHING", "You caught only junk");
							case 2: AddFish(playerid, RandomFloat(1.9,4.5));
							case 3: AddFish(playerid, RandomFloat(1.9,4.5));
							case 4: Custom(playerid, "FISHING", "You caught only junk");
							case 5: AddFish(playerid, RandomFloat(1.9,4.5));
							case 6: AddFish(playerid, RandomFloat(1.9,4.5));
							case 7: Custom(playerid, "FISHING", "You caught only junk");
						}
					}
					case 2: {
						switch(rand)
						{
							case 0: AddFish(playerid, RandomFloat(2.5,6.5));
							case 1: AddFish(playerid, RandomFloat(2.5,6.5));
							case 2: Custom(playerid, "FISHING", "You caught only junk");
							case 3: AddFish(playerid, RandomFloat(2.5,6.5));
							case 4: AddFish(playerid, RandomFloat(2.5,6.5));
							case 5: AddFish(playerid, RandomFloat(2.5,6.5));
							case 6: AddFish(playerid, RandomFloat(2.5,6.5));
							case 7: Custom(playerid, "FISHING", "You caught only junk");
						}
					}
				} 
			}
			stop getFish(playerid);
			ClearAnimations(playerid);
			StopLoopingAnim(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemovePlayerAttachedObject(playerid, 9);
			pData[playerid][pInFish] = 0;
			DeletePVar(playerid, "Fishing");
			return 1;
		}
	}
	return 1;
}

//dialog

Dialog:SellFish(playerid, response, listitem, inputtext[]) 
{
    if(response)
	{
		new Float:count = 0.0, total;
		for(new i = 0; i < 5; i++) if(FishWeight[playerid][i] > 0.0) count += FishWeight[playerid][i];
		for(new i = 0; i < 5; i++) {
			FishWeight[playerid][i] = 0.0;
			FishName[playerid][i][0] = EOS;
		}
		StockCrateFish += count / 90;
		if(StockCrateFish >= 100) StockCrateFish = 100;

		new fish[212];
		format(fish, sizeof(fish), "Canned Fish Crates\nFish Available: "YELLOW"%d/100\n"WHITE_E"Use "YELLOW_E"'/takecrate' "WHITE_E"to pickup crate", StockCrateFish);
		UpdateDynamic3DTextLabelText(FishCrateText, COLOR_GREY, fish);
		
		total = floatround(count*FishPrice);
		GivePlayerMoneyEx(playerid, total);
		SendClientMessageEx(playerid, ARWIN, "FISHING: {FFFFFF}You've sold {FFFF00}%.1f lbs {FFFFFF}of fish for {FFFF00}$%s", count, FormatMoney(total));
		pData[playerid][pFishTime] += 600;
		new random2 = RandomEx(1, 20);
		pData[playerid][pScoreFishing] += random2;
		UpdateFishingSkill(playerid);
	}
    return 1;
}

Dialog:BuyBait(playerid, response, listitem, inputtext[]) {
    if(response)
	{
		new tbait = strval(inputtext);
		new String[212];
		if(!response)
		{
			format(String, sizeof(String), "Bait Price: $5");
			Dialog_Show( playerid, BuyBait, DIALOG_STYLE_INPUT, "Buy Bait",String, "Buy", "Cancel" );
		}
		else
		{
		    if(GetPlayerMoney(playerid) < tbait * 5) { Error(playerid, "Uang anda tidak cukup !"); return 1; }
            if(Inventory_Count(playerid, "Bait") > 100) { Info(playerid, "Kamu telah memiliki banyak umpan."); return 1; }
            if(tbait < 1) { Error(playerid, "Minimal membeli 1 Umpan."); return 1; }
            new harga = tbait * 5;
			GivePlayerMoneyEx(playerid, -harga);
			format(String, sizeof(String), "FISH: Anda telah membeli %d Bait Umpan dengan harga %s",tbait, FormatMoney(harga));
			SendClientMessageEx(playerid,ARWIN,String);
			Inventory_Add(playerid, "Bait", 19566, tbait);
		}
	}
    return 1;
}


CMD:fish(playerid,params[])
{
	new vehicleid = GetNearestVehicleToPlayer(playerid, 5.0, false);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) return Error(playerid, "Anda tidak bisa menggunakan command ini disaat mengendarai!");
	if(pData[playerid][pFishTime] > 0) return Error(playerid, "Tidak bisa /fish gunakan /delay untuk mengecek");
	if(pData[playerid][pEnergy] <= 20)   Error(playerid, "Anda terlalu lelah untuk memancing lagi.");
	if(Inventory_Count(playerid, "Fish Tool") < 1) return Error(playerid, "Anda tidak mempunyai fishing tool/pancingan.");
	if(Inventory_Count(playerid, "Bait") < 1) return Error(playerid, "Anda tidak mempunyai umpan.");
	if(pData[playerid][pInFish] == 1) return Error(playerid, "Tunggu beberapa saat lagi.");
	if(FishWeight[playerid][4]) return Error(playerid, "You already have 5 fish, go to the fish factory to sell it!");
	foreach(new fishing : FishingArea) if(IsPlayerInDynamicArea(playerid, FishingData[fishing][Zone])) {
		if(IsAtFishArea(playerid)) {
			pData[playerid][pFishingTime] = defer getFish(playerid);
			Fishing[playerid][0] = -1;
			Fishing[playerid][1] = random(4);
			Fishing[playerid][2] = FishingData[fishing][Type];
			pData[playerid][pInFish] = 1;
			pData[playerid][pWorm]--;
			pData[playerid][pFishTool]--;
			
			Custom(playerid, "FISHING", "You've started fishing, you can cancel anytime using {FFFF00}left mouse click / '/stopfishing'");
			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid,"SWORD","sword_block",50.0 ,0,1,0,1,1);
			SetPlayerAttachedObject(playerid, 9,18632,6,0.079376,0.037070,0.007706,181.482910,0.000000,0.000000,1.000000,1.000000,1.000000);
		}
		else if(IsABoat(vehicleid) && pData[playerid][pSkillFishing] == 2) {
			pData[playerid][pFishingTime] = defer getFish(playerid);
			Fishing[playerid][0] = -1;
			Fishing[playerid][1] = random(4);
			Fishing[playerid][2] = FishingData[fishing][Type];
			pData[playerid][pInFish] = 1;
			pData[playerid][pWorm]--;
			pData[playerid][pFishTool]--;
			Custom(playerid, "FISHING", "You've started fishing, you can cancel anytime using {FFFF00}left mouse click / '/stopfishing'");
			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid,"SWORD","sword_block",50.0 ,0,1,0,1,1);
			SetPlayerAttachedObject(playerid, 9,18632,6,0.079376,0.037070,0.007706,181.482910,0.000000,0.000000,1.000000,1.000000,1.000000);
		}
	}
	return 1;
}

CMD:stopfishing(playerid, params[]) {
	if(pData[playerid][pInFish] == 1 && Fishing[playerid][0] == -1) {
		TogglePlayerControllable(playerid, 1);
		Custom(playerid, "FISHING", "You've cancel fishing");
		ClearAnimations(playerid);
		StopLoopingAnim(playerid);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		RemovePlayerAttachedObject(playerid, 9);
		pData[playerid][pInFish] = 0;
		Fishing[playerid][0] = -1;
		Fishing[playerid][1] = -1;
		Fishing[playerid][2] = -1;
		stop pData[playerid][pFishingTime];
	}
	if(Fishing[playerid][0] == 1 && pData[playerid][pInFish] == 1) {
		TogglePlayerControllable(playerid, 1);
		switch(Fishing[playerid][2])
		{
			case 0: {
				switch(Fishing[playerid][1])
				{
					case 0: AddFish(playerid, RandomFloat(1.0,3.5));
					case 1: Custom(playerid, "FISHING", "You caught only junk");
					case 2: AddFish(playerid, RandomFloat(1.0,3.5));
					case 3: Custom(playerid, "FISHING", "You caught only junk");
				}
			}
			case 1: {
				switch(Fishing[playerid][1])
				{
					case 0: AddFish(playerid, RandomFloat(1.9,4.5));
					case 1: Custom(playerid, "FISHING", "You caught only junk");
					case 2: AddFish(playerid, RandomFloat(1.9,4.5));
					case 3: AddFish(playerid, RandomFloat(1.9,4.5));
				}
			}
			case 2: {
				switch(Fishing[playerid][1])
				{
					case 0: AddFish(playerid, RandomFloat(2.5,6.5));
					case 1: AddFish(playerid, RandomFloat(2.5,6.5));
					case 2: AddFish(playerid, RandomFloat(2.5,6.5));
					case 3: AddFish(playerid, RandomFloat(2.5,6.5));
				}
			}
		} 
		stop pData[playerid][pFishingTime];
		ClearAnimations(playerid);
		StopLoopingAnim(playerid);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		RemovePlayerAttachedObject(playerid, 9);
		pData[playerid][pInFish] = 0;
		Fishing[playerid][0] = -1;
		Fishing[playerid][1] = -1;
		Fishing[playerid][2] = -1;
	}
	return 1;
}

CMD:sellallfish(playerid,params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3, 2844.0684,-1516.6871,11.3002)) 	
		return Error(playerid, "Anda harus berada di fish factory");
	
	if(StockCrateFish >= 40) 
		return Error(playerid, "You can't sell fish, there is still a lot of stock in the warehouse");

	new String[412], Float:count;
	format(String, sizeof(String), "Fish\tWeight\tPrice\n");

	for(new i = 0; i < 5; i++) if(FishWeight[playerid][i] > 0.0) 
	{
		new total = floatround(FishWeight[playerid][i]*FishPrice);
		count += FishWeight[playerid][i];
		format(String, sizeof(String), "%s"WHITE_E"Ocean Fish\t"WHITE_E"%.1f lbs\t"GREEN_E"$%s\n", String, FishWeight[playerid][i], FormatMoney(total));
    }

	new totalanjing = floatround(count*FishPrice);
	format(String, sizeof(String), "%s"WHITE"Total:\t%.1f lbs\t"GREEN"%s",String, count, FormatMoney(totalanjing));
	Dialog_Show(playerid,SellFish,DIALOG_STYLE_TABLIST_HEADERS,"Selling Fish",String,"Sell","Cancel");
	return 1;
}
