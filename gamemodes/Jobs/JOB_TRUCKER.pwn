CreateJoinTruckPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, -77.38, -1136.52, 1.07, -1);
	format(strings, sizeof(strings), "[TRUCKER JOBS]\n{ffffff}Jadilah Pekerja Trucker disini\n{7fffd4}/getjob /accept job");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -77.38, -1136.52, 1.07, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // truck
}

//Mission
GetRestockBisnis()
{
	new tmpcount;
	foreach(new id : Bisnis)
	{
	    if(bData[id][bRestock] == 1)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockBisnisID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_BISNIS) return -1;
	foreach(new id : Bisnis)
	{
	    if(bData[id][bRestock] == 1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

//Hauling
GetRestockGStation()
{
	new tmpcount;
	foreach(new id : GStation)
	{
	    if(gsData[id][gsStock] < 7000)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockGStationID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_GSTATION) return -1;
	foreach(new id : GStation)
	{
	    if(gsData[id][gsStock] < 7000)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

CMD:missions(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new fmt[688];
		strcat(fmt, "Type\tTrucking Skills\n");
		strcat(fmt, "Hauling\tLevel 5\n");
		strcat(fmt, "Crate Delivery\tLevel 1\n");
		Dialog_Show(playerid, DIALOG_MISSIONS, DIALOG_STYLE_TABLIST_HEADERS, "Missions Trucker", fmt, "Select", "Close");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}

CMD:warehouse(playerid, params[])
{
	new fmt[688];
	format(fmt,688, "Name\tType\tStock\n\
	Component\tTake Crates\t%d\n\
	"GRAY"Component\t"GRAY"Unload Crates\t-\n\
	Lumber\tTake Crates\t%d\n\
	"GRAY"Lumber\t"GRAY"Unload Crates\t-\n\
	Fish\tTake Crates\t%d\n\
	"GRAY"Fish\t"GRAY"Unload Crates\t-\n\
	Plant\tTake Crates\t%d\n\
	"GRAY"Plant\t"GRAY"Unload Crates\n",
	StockCrateCompo, StockCrateLumber, StockCrateFish, StockCratePlant);

	Dialog_Show(playerid, DIALOG_CRATELOC, DIALOG_STYLE_TABLIST_HEADERS, "Missions Trucker", fmt, "Select", "Close");
	return 1;
}

/*
//Mission Commands
CMD:mission(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		if(GetRestockBisnis() <= 0) return Error(playerid, "Mission sedang kosong.");
		new id, count = GetRestockBisnis(), mission[128], type[32], lstr[512];
		
		strcat(mission,"No\tBusID\tBusType\tBusName\n",sizeof(mission));
		Loop(itt, (count + 1), 1)
		{
			id = ReturnRestockBisnisID(itt);
			if(bData[id][bType] == 1)
			{
				type= "Fast Food";
			}
			else if(bData[id][bType] == 2)
			{
				type= "Market";
			}
			else if(bData[id][bType] == 3)
			{
				type= "Clothes";
			}
			else if(bData[id][bType] == 4)
			{
				type= "Ammunation";
			}
			else
			{
				type= "Unknow";
			}
			if(itt == count)
			{
				format(lstr,sizeof(lstr), "%d\t%d\t%s\t%s\n", itt, id, type, bData[id][bName]);	
			}
			else format(lstr,sizeof(lstr), "%d\t%d\t%s\t%s\n", itt, id, type, bData[id][bName]);
			strcat(mission,lstr,sizeof(mission));
		}
		ShowPlayerDialog(playerid, DIALOG_RESTOCK, DIALOG_STYLE_TABLIST_HEADERS,"Mission",mission,"Start","Cancel");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}*/

/*
CMD:storeproduct(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new bid = pData[playerid][pMission], vehicleid = GetPlayerVehicleID(playerid), carid = -1, total, Float:percent, pay, convert;
		if(bid == -1) return Error(playerid, "You dont have mission.");
		if(IsPlayerInRangeOfPoint(playerid, 4.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsATruck(vehicleid)) return Error(playerid, "Anda harus mengendarai truck.");
			if(VehProduct[vehicleid] < 1) return Error(playerid, "Product is empty in this vehicle.");
			total = VehProduct[vehicleid] * ProductPrice;
			percent = (total / 100) * 50;
			convert = floatround(percent, floatround_floor);
			pay = total + convert;
			bData[bid][bProd] += VehProduct[vehicleid];
			bData[bid][bMoney] -= pay;
			Info(playerid, "Anda menjual "RED_E"%d "WHITE_E"product dengan seharga "GREEN_E"%s", VehProduct[vehicleid], FormatMoney(pay));
			GivePlayerMoneyEx(playerid, pay);
			if((carid = Vehicle_Nearest(playerid)) != -1)
			{
				pvData[carid][cProduct] = 0;
				Info(playerid, "Anda mendapatkan uang 20 percent dari hasil stock product anda.");
			}
			VehProduct[vehicleid] = 0;
			pData[playerid][pMission] = -1;
			pData[playerid][pTruckerProductTime] = 600;
		}
		else return Error(playerid, "Anda harus berada didekat dengan bisnis mission anda.");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}*/

/*
//Hauling Commands
CMD:hauling(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		if(GetRestockGStation() <= 0) return Error(playerid, "Hauling sedang kosong.");
		new id, count = GetRestockGStation(), hauling[128], lstr[512];
		
		strcat(hauling,"No\tGas Station ID\tLocation\n",sizeof(hauling));
		Loop(itt, (count + 1), 1)
		{
			id = ReturnRestockGStationID(itt);
			if(itt == count)
			{
				format(lstr,sizeof(lstr), "%d\t%d\t%s\n", itt, id, GetLocation(gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]));	
			}
			else format(lstr,sizeof(lstr), "%d\t%d\t%s\n", itt, id, GetLocation(gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]));
			strcat(hauling,lstr,sizeof(hauling));
		}
		ShowPlayerDialog(playerid, DIALOG_HAULING, DIALOG_STYLE_TABLIST_HEADERS,"Hauling",hauling,"Start","Cancel");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}

CMD:storegas(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new id = pData[playerid][pHauling], vehicleid = GetPlayerVehicleID(playerid), carid = -1, total, Float:percent, pay, convert;
		if(id == -1) return Error(playerid, "You dont have hauling.");
		if(IsPlayerInRangeOfPoint(playerid, 5.5, gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsAHaulTruck(vehicleid)) return Error(playerid, "Anda harus mengendarai truck.");
			if(!IsTrailerAttachedToVehicle(vehicleid)) return Error(playerid, "Your Vehicle Trailer is not even attached");
			DetachTrailerFromVehicle(vehicleid);

			DestroyVehicle(GetVehicleTrailer(vehicleid));
			pData[playerid][pTrailer] = INVALID_VEHICLE_ID;

			if(VehGasOil[vehicleid] < 1) return Error(playerid, "GasOil is empty in this vehicle.");
			total = VehGasOil[vehicleid] * GasOilPrice;
			percent = (total / 100) * 20;
			convert = floatround(percent, floatround_ceil);
			pay = total + convert;
			gsData[id][gsStock] += VehGasOil[vehicleid];
			Server_MinMoney(pay);
			Info(playerid, "Anda menjual "RED_E"%d "WHITE_E"liters gas oil dengan seharga "GREEN_E"%s", VehGasOil[vehicleid], FormatMoney(pay));
			GivePlayerMoneyEx(playerid, pay);
			if((carid = Vehicle_Nearest2(playerid)) != -1)
			{
				pvData[carid][cGasOil] = 0;
				Info(playerid, "Anda mendapatkan uang 20 percent dari hasil stock liters gas oil anda.");
			}
			VehGasOil[vehicleid] = 0;
			pData[playerid][pHauling] = -1;
			pData[playerid][pTruckerHaulingTime] = 600;
			GStation_Refresh(id);
			GStation_Save(id);
		}
		else return Error(playerid, "Anda harus berada didekat dengan gas oil hauling anda.");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}
*/
CMD:takecrate(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		if(pData[playerid][pCrateType] > 0)
			return Error(playerid, "Anda sedang membawa crate!");

		if(pData[playerid][pTruckerCrateTime] > 0)	
			return Error(playerid, "Anda masih memiliki delay!");

		if(IsPlayerInRangeOfPoint(playerid, 2.5, 323.6411, 904.5583, 21.5862))
        {
			new fish[212];
			Custom(playerid, "JOB", "You've picked up "LIGHTGREEN"1 box component crate");    
			pData[playerid][pCrateType] = 1;
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
            SetPlayerAttachedObject(playerid, 9, 2912, 1, 0.233, 0.359, -0.198, 1.400, 0.000, 0.000, 0.640, 0.625, 0.654);
			StockCrateCompo--;
			format(fish, sizeof(fish), "[Component Crate]\n"WHITE"Available Crates: "YELLOW"%d/100\n"WHITE_E"Use "YELLOW_E"'/takecrate' "WHITE_E"to pickup crate", StockCrateCompo);
			UpdateDynamic3DTextLabelText(CompoCrateText, COLOR_GREY, fish);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2836.3945,-1541.1984,11.0991))
		{
			if(StockCrateFish > 0)
			{
				new fish[212];
				Custom(playerid, "JOB", "You've picked up "LIGHTGREEN"1 box component crate");    
				pData[playerid][pCrateType] = 2;
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
            	SetPlayerAttachedObject(playerid, 9, 2912, 1, 0.233, 0.359, -0.198, 1.400, 0.000, 0.000, 0.640, 0.625, 0.654);
				StockCrateFish--;
				format(fish, sizeof(fish), "Canned Fish Crates\nFish Available: "YELLOW"%d/100\n"WHITE_E"Use "YELLOW_E"'/takecrate' "WHITE_E"to pickup crate", StockCrateFish);
				UpdateDynamic3DTextLabelText(FishCrateText, COLOR_GREY, fish);
			} 
			else return Error(playerid, "wait a moment"); 
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, -366.3686,-1419.0941,25.7266))
		{
			if(StockCratePlant > 0)
			{
				new strings[525];
				Custom(playerid, "JOB", "You've picked up "LIGHTGREEN"1 box component crate");    
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
				SetPlayerAttachedObject(playerid, 9, 2912, 1, 0.233, 0.359, -0.198, 1.400, 0.000, 0.000, 0.640, 0.625, 0.654);
				pData[playerid][pCrateType] = 3;
				StockCratePlant--;
				format(strings, sizeof(strings), "[Plant Crate]\n"WHITE_E"Available crates: "YELLOW"%d/100\n"WHITE_E"Use "YELLOW_E"'/takecrate' "WHITE_E"to pickup a crate", StockCratePlant);
				UpdateDynamic3DTextLabelText(PlantText, COLOR_GREY, strings);
			}
			else return Error(playerid, "wait a moment"); 
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, -1446.6145,-1544.0745,101.7935))
		{
			if(StockCrateLumber > 0)
			{
				new strings[525];
				Custom(playerid, "JOB", "You've picked up "LIGHTGREEN"1 box component crate");    
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
				SetPlayerAttachedObject(playerid, 9, 2912, 1, 0.233, 0.359, -0.198, 1.400, 0.000, 0.000, 0.640, 0.625, 0.654);
				pData[playerid][pCrateType] = 4;
				StockCrateLumber--;
				format(strings, sizeof(strings), "[Lumber Crate]\n"WHITE_E"Available crates: "YELLOW"%d/100\n"WHITE_E"Use "YELLOW_E"'/takecrate' "WHITE_E"to pickup a crate", StockCrateLumber);
				UpdateDynamic3DTextLabelText(LumberjackText, COLOR_GREY, strings);
			}
			else return Error(playerid, "wait a moment"); 
		}
	}
	return 1;
}

CMD:loadcrate(playerid, params[])
{
    if(pData[playerid][pCrateType] < 1) return Error(playerid, "You didn't bring the crate");
    new Float: x, Float: y, Float: z;
    new vehicleid = GetPVarInt(playerid, "LastVehicleID");
    GetVehicleBoot(GetPVarInt(playerid, "LastVehicleID"), x, y, z);
    if(GetPlayerDistanceFromPoint(playerid, x, y, z) > 3.0) return Error(playerid, "Your last vehicle is too far away.");  
    if(Vehicle_CrateComponentTotal(vehicleid) >= 10) return Error(playerid, "You can't load any more crate to this vehicle.");    
    if(Vehicle_CratePlantTotal(vehicleid) >= 10) return Error(playerid, "You can't load any more crate to this vehicle.");    
    if(Vehicle_CrateLumberTotal(vehicleid) >= 10) return Error(playerid, "You can't load any more crate to this vehicle.");    
    if(Vehicle_CrateFishTotal(vehicleid) >= 10) return Error(playerid, "You can't load any more crate to this vehicle.");    
    if(!IsATruckCrate(vehicleid)) return Error(playerid, "You must use a crate type car");
    if(pData[playerid][pCrateType] == 1)
    {
        foreach(new pv : PVehicles)
        {
            if(vehicleid == pvData[pv][cVeh])
            {
                pvData[pv][cCompCrate]++;
				pData[playerid][pCrateType] = 0;
                Custom(playerid, "JOB", "You've loaded 1 crate, Total crates stored "YELLOW_E"%d/10", pvData[pv][cCompCrate]); 
                SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                RemovePlayerAttachedObject(playerid, 9);
            }
        }   
    }
    else if(pData[playerid][pCrateType] == 2)
    {
        foreach(new pv : PVehicles)
        {
            if(vehicleid == pvData[pv][cVeh])
            {
                pvData[pv][cFishCrate]++;
				pData[playerid][pCrateType] = 0;
                Custom(playerid, "JOB", "You've loaded 1 crate, Total crates stored "YELLOW_E"%d/10", pvData[pv][cFishCrate]); 
                SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                RemovePlayerAttachedObject(playerid, 9);
            }
        }   
    }
    else if(pData[playerid][pCrateType] == 3)
    {
        foreach(new pv : PVehicles)
        {
            if(vehicleid == pvData[pv][cVeh])
            {
                pvData[pv][cPlantCrate]++;
				pData[playerid][pCrateType] = 0;
                Custom(playerid, "JOB", "You've loaded 1 crate, Total crates stored "YELLOW_E"%d/10", pvData[pv][cPlantCrate]); 
                SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                RemovePlayerAttachedObject(playerid, 9);
            }
        }   
    }
    else if(pData[playerid][pCrateType] == 4)
    {
        foreach(new pv : PVehicles)
        {
            if(vehicleid == pvData[pv][cVeh])
            {
                pvData[pv][cLumCrate]++;
				pData[playerid][pCrateType] = 0;
                Custom(playerid, "JOB", "You've loaded 1 crate, Total crates stored "YELLOW_E"%d/10", pvData[pv][cLumCrate]); 
                SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                RemovePlayerAttachedObject(playerid, 9);
            }
        }   
    }
    return 1;
}

CMD:unloadcrate(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return Error(playerid, "You are not driver in crate truck.");
    if(!IsValidVehicle(vehicleid)) return Error(playerid, "You're not in any vehicle.");
    if(IsPlayerInRangeOfPoint(playerid, 4.0, 797.7953,-616.8799,16.3359))
    {
        foreach(new pv : PVehicles)
        {
            if(vehicleid == pvData[pv][cVeh])
            {
                if(pvData[pv][cCompCrate] > 0)
                {
                    if(Component > 50000) return Error(playerid, "Stock components in the warehouse exceed capacity");
                    new cash = pvData[pv][cCompCrate] * 70;
                    if(cash < 1) return Error(playerid, "This vehicle crate is empty!");
                    Component += pvData[pv][cCompCrate] + 10;
					new strings[212];
					format(strings, sizeof(strings), "[Component Storage]\n"WHITE_E"Component Stock: "LG_E"%d\n\n"WHITE_E"Component Price: "LG_E"%s /item\n"LB_E"/buycomponent", Component, FormatMoney(ComponentPrice));
					UpdateDynamic3DTextLabelText(CompText, COLOR_GREY, strings);
                    //new list[212];
                    //format(list, sizeof(list), "Delivered %d component crates", pvData[pv][cCrateComponent]);
                    //AddPlayerSalary(playerid, "Trucking Co.", list, cash);
					AddPlayerSalary(playerid, sprintf("(Trucker) Delivered %d component crates", pvData[pv][cCompCrate]), cash);
                    SendClientMessage(playerid, ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/salary'");
                    pvData[pv][cCompCrate] = 0;
                    pData[playerid][pTruckerCrateTime] = 600;
                    pData[playerid][pScoreTrucker] += 10;
					UpdateTruckingSkill(playerid);
                }  
            }
        }       
          
    }
    else if(IsPlayerInRangeOfPoint(playerid, 4.0, -577.1335,-503.6530,25.5107))
    {
        foreach(new pv : PVehicles)
        {
            if(vehicleid == pvData[pv][cVeh])
            {
                if(pvData[pv][cFishCrate] > 0)
                {
                    new cash = pvData[pv][cFishCrate] * 70;
                    if(cash < 1) return Error(playerid, "This vehicle crate is empty!");
                    //StockComponent += pvData[pv][cFishCrate] + 10;
                    //new list[212];
                    //format(list, sizeof(list), "Delivered %d fish crates", pvData[pv][cCrateFish]);
                    //AddPlayerSalary(playerid, "Trucking Co.", list, cash);
					AddPlayerSalary(playerid, sprintf("(Trucker) Delivered %d fish crates", pvData[pv][cFishCrate]), cash);
                    SendClientMessage(playerid, ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/salary'");
                    pvData[pv][cFishCrate] = 0;
                    pData[playerid][pTruckerCrateTime] = 600;
					pData[playerid][pScoreTrucker] += 10;
					UpdateTruckingSkill(playerid);
                }  
				if(pvData[pv][cLumCrate] > 0)
				{
					new cash = pvData[pv][cLumCrate] * 70;
					if(cash < 1) return Error(playerid, "This vehicle crate is empty!");
					Material += pvData[pv][cLumCrate] + 10;
					new strings[212];
					format(strings, sizeof(strings), "[Material]\n"WHITE_E"Material Stock: "LG_E"%d\n\n"WHITE_E"Material Price: "LG_E"%s /item\n"LB_E"/buy", Material, FormatMoney(MaterialPrice));
					UpdateDynamic3DTextLabelText(MatText, COLOR_YELLOW, strings);
					//new list[212];
					// format(list, sizeof(list), "Delivered %d lumber crates", pvData[pv][cCrateLumber]);
					//AddPlayerSalary(playerid, "Trucking Co.", list, cash);
					AddPlayerSalary(playerid, sprintf("(Trucker) Delivered %d lumber crates", pvData[pv][cLumCrate]), cash);
					SendClientMessage(playerid, ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/salary'");
					pvData[pv][cLumCrate] = 0;
					pData[playerid][pTruckerCrateTime] = 600;
					pData[playerid][pScoreTrucker] += 10;
					UpdateTruckingSkill(playerid);
				} 
            }
        }       
                
    } 
    else if(IsPlayerInRangeOfPoint(playerid, 4.0, 2792.4355,-2456.1199,13.6325))
    {
        foreach(new pv : PVehicles)
        {
            if(vehicleid == pvData[pv][cVeh])
            {
                if(pvData[pv][cPlantCrate] > 0)
                {
                    new cash = pvData[pv][cPlantCrate] * 75;
                    if(cash < 1) return Error(playerid, "This vehicle crate is empty!");
                    //StockComponent += pvData[pv][cPlantCrate] + 10;
                    //new list[212];
                    //format(list, sizeof(list), "Delivered %d plant crates", pvData[pv][cCratePlant]);
                    //AddPlayerSalary(playerid, "Trucking Co.", list, cash);
                    Food += pvData[pv][cPlantCrate] + 10;
					new strings[212];
					format(strings, sizeof(strings), "[Food]\n"WHITE_E"Food Stock: "LG_E"%d\n"WHITE_E"Food Price: "LG_E"%s /item\n\n"YELLOW"/buyfood "WHITE"untuk membeli food",
					Food, FormatMoney(FoodPrice));
					UpdateDynamic3DTextLabelText(FoodText, COLOR_YELLOW, strings);
					AddPlayerSalary(playerid, sprintf("(Trucker) Delivered %d plant crates", pvData[pv][cPlantCrate]), cash);
					SendClientMessage(playerid, ARWIN, "SALARY: "WHITE_E"Your salary statement has been update, please check command "YELLOW_E"'/salary'");
                    pvData[pv][cPlantCrate] = 0;
                    pData[playerid][pTruckerCrateTime] = 600;
					pData[playerid][pScoreTrucker] += 10;
					UpdateTruckingSkill(playerid);
                } 
            }
        }       
                
    } 
    return 1;
}

CMD:dropcrate(playerid, params[])
{
    if(pData[playerid][pCrateType] > 0)
    {
        pData[playerid][pCrateType] = 0;
        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
        RemovePlayerAttachedObject(playerid, 9);
        SendClientMessageEx(playerid, COLOR_YELLOW, "[JOB]: You have dropped the crate");    
    }
    return 1;
}
