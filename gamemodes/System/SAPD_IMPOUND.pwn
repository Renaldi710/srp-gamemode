CMD:impound(playerid, params[])
{
	if(pData[playerid][pFaction] != 1) return Error(playerid, "Anda bukan petugas kepolisian.");
	if(pData[playerid][pOnDuty] != 1) return Error(playerid, "Anda harus on duty.");
	new reason[212];
	if(sscanf(params, "s[212]", reason)) return Usage(playerid, "/impound [reason impound]");
	new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
	if(vehicleid == INVALID_VEHICLE_ID)
		return Vehicle(playerid, "You not in near any vehicles.");
	
	foreach(new ii : PVehicles)
	{
        if(GetVehicleType(ii) == VEHICLE_TYPE_PLAYER)
        {
            if(vehicleid == pvData[ii][cVeh])
            {
                foreach(new pid : Player) if (pvData[ii][cExtraID] == pData[pid][pID])
                {
                    Custom(pid, "[IMPOUND", "Your "YELLOW_E"%s "WHITE_E"has been impounded by {2641FE}SAPD "WHITE_E"for "GREEN_E"%s "WHITE_E"reason "YELLOW_E"%s", GetVehicleName(vehicleid), FormatMoney(pvData[ii][cPrice]/80), reason);
                    SendFactionMessage(1, COLOR_RADIO, "HQ: %s has impounded %s's %s.", ReturnName2(playerid),  ReturnName2(pid), GetVehicleName(vehicleid));		
                    pvData[ii][cImpound] = 1;	
                    pvData[ii][cimpoundTake] = -1;

                    if(IsValidVehicle(pvData[ii][cVeh])) 
                        DestroyVehicle(pvData[ii][cVeh]);

                    pvData[ii][cVeh] = INVALID_VEHICLE_ID;
                    format(pvData[ii][cImpoundReason], 212, "%s", reason);
                }
            }
        }
	}
	return 1;
}

CMD:unimpound(playerid, params[])
{		
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2820.2354, -1475.2073, 16.2500)) 
        return Error(playerid, "You must be at the impound center");

	new found = false, msg2[512];
	format(msg2, sizeof(msg2), "Vehicle\tFine\tReason\n");
	foreach(new i : PVehicles)
	{
        if(GetVehicleType(i) == VEHICLE_TYPE_PLAYER)
        {
            if(pvData[i][cExtraID] == pData[playerid][pID])
            {
                if(pvData[i][cImpound] > 0)
                {
                    new price = pvData[i][cPrice]/55;
                    gListedItems[playerid][found] = i;
                    found++;
                    format(msg2, sizeof(msg2), "%s"LIGHTGREEN"%s\t"GREEN_E"%s\t%s\n", msg2, GetVehicleModelName(pvData[i][cModel]), FormatMoney(price), pvData[i][cImpoundReason]);
                }
            }	
        }
	}
	if(found) Dialog_Show(playerid, VehicleImpound, DIALOG_STYLE_TABLIST_HEADERS, "Claim Impound", msg2, "Claim", "Close");
	else Error(playerid, "Vehicle is not ready to bey claimed");
	return 1;
}

Dialog:VehicleImpound(playerid, response, listitem, inputtext[]) {
    if(response) 
	{
		new vehicleid = gListedItems[playerid][listitem];
		new price = pvData[vehicleid][cPrice]/55;
		if(GetPlayerMoney(playerid) < price) return Error(playerid, "You don't have enough money to pay the fine");
		if(pvData[vehicleid][cExtraID] == pData[playerid][pID] && pvData[vehicleid][cImpound] == 1)
		{
			pvData[vehicleid][cPosX] = 2813.1353;
			pvData[vehicleid][cPosY] = -1473.6005;
			pvData[vehicleid][cPosZ] = 16.1020;
			pvData[vehicleid][cImpound] = 0;
			GivePlayerMoneyEx(playerid, -price);

			if(!IsValidVehicle(pvData[vehicleid][cVeh]))  
                OnPlayerVehicleRespawn(vehicleid); 

			PutPlayerInVehicle(playerid, pvData[vehicleid][cVeh], 0);
			//InsertFactionManage(1, "Vehicle Pay Impound", FormatMoney(price));
			//BalanceSAPD += price;
			SendClientMessageEx(playerid, ARWIN, "IMPOUND: "WHITE"You've unimpound your "LIGHTGREEN"%s "WHITE"from the impound center for "GREEN_E"%s", GetVehicleModelName(pvData[vehicleid][cModel]), FormatMoney(price));
		}	
	}
    return 1;
}