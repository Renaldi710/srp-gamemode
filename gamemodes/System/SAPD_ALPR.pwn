/* ----copyright north country----- */

#include <YSI_Coding\y_hooks>

new bool:Player_RadarToggle[MAX_PLAYERS];
new bool:Vehicle_RadarToggle[MAX_PRIVATE_VEHICLE];
new Timer:Vehicle_CheckingSpeed[MAX_PRIVATE_VEHICLE];
new Player_OldVehicleID[MAX_PLAYERS];

CMD:alpr(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid) && pData[playerid][pFaction] == 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid),
			Float: x, Float: y, Float: z, Float: a, index;

        if((index = Vehicle_GetID(vehicleid)) != -1)
        {
	    	if(GetVehicleType(index) != VEHICLE_TYPE_FACTION)
                return Error(playerid, "This is not faction vehicle!");

            if(pvData[index][cExtraID] != pData[playerid][pFaction])
                return Error(playerid, "This is not your faction vehicle!");

            if(!IsFourWheelVehicle(vehicleid))
                return Error(playerid, "You need to be inside a car to use speed radar!");

            if(!Vehicle_RadarToggle[vehicleid]) 
            {
                Vehicle_RadarToggle[vehicleid] = true;
                Player_RadarToggle[playerid] = true;
                
                GetVehiclePos (vehicleid, x, y, z);
                GetVehicleZAngle (vehicleid, a);
                Vehicle(playerid, "ALPR "GREEN"ON");
                Vehicle_CheckingSpeed[vehicleid] = repeat Vehicle_CheckSpeed(vehicleid);
            
                foreach(new i : Player) if (IsPlayerInVehicle(i, vehicleid))
                {
                    EnableSpeedRadar(i);
                }
            }
            else
            {
                Vehicle_RadarToggle[vehicleid] = false;
                Player_RadarToggle[playerid] = false;
                stop Vehicle_CheckingSpeed[vehicleid];

                Vehicle(playerid, "ALPR "RED"OFF");
                foreach(new i : Player) if (IsPlayerInVehicle (i, vehicleid))
                {
                    DisableSpeedRadar(i);
                }
            }
		}
	}
	else Error(playerid, "You are not a police officer that inside a vehicle!");
	return 1;
}

Vehicle_GetFrontID(vehid)
{
    new Float: temp = 7.0;
	new j = 0;
	foreach(new i : Vehicle)
	{
	    new Float: a, Float: x1, Float: y1, Float: z1, Float: x2, Float: y2, Float: z2;
    	GetVehiclePos (vehid, x1, y1, z1);
    	GetVehicleZAngle (vehid, a);
 		if (i != vehid)
 		{
	 		if (GetVehiclePos (i, x2, y2, z2))
			{
				new Float: distance = floatsqroot (floatpower ((x1 - x2), 2) + floatpower ((y1 - y2), 2) + floatpower ((z1 - z2), 2));
				GetVehicleZAngle (vehid, a);
				
				if (distance < 300.0)
				{
    				x1 = x1 + (distance * floatsin(-a, degrees));
					y1 = y1 + (distance * floatcos(-a, degrees));

					distance = floatsqroot ((floatpower ((x1 - x2), 2)) + (floatpower ((y1 - y2), 2)));

					if (temp > distance)
					{
						temp = distance;
						j = i;
					}
				}
			}
		}
	}
	if (temp < 7.0) return j;
	return -1;
}

timer Vehicle_CheckSpeed[1000](vehicleid)
{
	if(Vehicle_RadarToggle[vehicleid])
	{
		new vehid = Vehicle_GetFrontID(vehicleid);
        new index = Vehicle_GetID(vehid);
		if (vehid == -1)
		{
			foreach(new i : Player) if(IsPlayerInVehicle (i, vehicleid))
			{
				PlayerTextDrawSetString(i, ALPR[i][6], "N/A");
				PlayerTextDrawSetString(i, ALPR[i][7], "N/A");
				PlayerTextDrawSetString(i, ALPR[i][8], "N/A");
			}
		}
		else
		{
			foreach(new i : Player) if(IsPlayerInVehicle (i, vehicleid))
			{
				new speed = floatround(GetVehicleSpeed(vehid));
				PlayerTextDrawSetString(i, ALPR[i][7], sprintf("%s", GetVehicleNameByVehicle(vehid)));
				PlayerTextDrawSetString(i, ALPR[i][8], sprintf("%d KMH", speed));
				PlayerTextDrawSetString(i, ALPR[i][6], sprintf("%s", pvData[index][cPlate]));
			}
		}
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if((oldstate == PLAYER_STATE_ONFOOT) && (newstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_DRIVER))
	{
	    Player_OldVehicleID[playerid] = GetPlayerVehicleID(playerid);
		new vehicleid = Player_OldVehicleID[playerid];
		if(vehicleid != -1)
		{
			if(Vehicle_RadarToggle[vehicleid])
			{
                Vehicle(playerid, "ALPR "GREEN"ON");
				EnableSpeedRadar(playerid);
			}
		}
	}

	if((oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER) && (newstate == PLAYER_STATE_ONFOOT))
	{
	    new vehicleid = Player_OldVehicleID[playerid];
		if(vehicleid != -1)
		{
			if(Vehicle_RadarToggle[vehicleid])
			{
                Vehicle(playerid, "ALPR "RED"OFF");
				DisableSpeedRadar(playerid);
			}
		}
	}
}

hook OnVehicleDeath(vehicleid)
{
	if(Vehicle_RadarToggle[vehicleid])
	{
		stop Vehicle_CheckingSpeed[vehicleid];
		Vehicle_RadarToggle[vehicleid] = false;
		foreach(new i : Player)
		{
			if (IsPlayerInVehicle (i, vehicleid))
			{
				DisableSpeedRadar(i);
			}
		}
	}
}

EnableSpeedRadar(playerid)
{
    forex(i, 9)
    {
        PlayerTextDrawShow(playerid, ALPR[playerid][i]);
    }
    Player_RadarToggle[playerid] = true;
    return 1;
}

DisableSpeedRadar(playerid)
{
    forex(i, 9)
    {
        PlayerTextDrawHide(playerid, ALPR[playerid][i]);
    }
    Player_RadarToggle[playerid] = false;
    return 1;
}