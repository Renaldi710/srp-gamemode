#define MAX_DOOR_FACTION 200

enum doorfaction {
	dfID,
	dfObj,
    dfObjDInt,
    dfObjDExt,
	dfStatus,
	dfModel,
	dfFaction,
	Float:dfPos[6],
	Float:dfMove[6],
    Float:dfPosInt[6],
	Float:dfPosExt[6]
};
new DoorFaction[MAX_DOOR_FACTION][doorfaction], 
    Iterator:DoorsFaction<MAX_DOOR_FACTION>;

new DoorFaction_Timer[MAX_DOOR_FACTION];
new editDoorFactionID[MAX_PLAYERS];
new editDoorFactioMode[MAX_PLAYERS];

function DoorFaction_Load() {
	new rows = cache_num_rows();

	for (new i = 0; i < rows; i ++) {
		cache_get_value_int(i, "ID", DoorFaction[i][dfID]);
		cache_get_value_int(i, "Model", DoorFaction[i][dfModel]);
        cache_get_value_int(i, "Faction", DoorFaction[i][dfFaction]);
		DoorFaction[i][dfStatus] = 0;
		cache_get_value_float(i, "PosX", DoorFaction[i][dfPos][0]);
		cache_get_value_float(i, "PosY", DoorFaction[i][dfPos][1]);
		cache_get_value_float(i, "PosZ", DoorFaction[i][dfPos][2]);
		cache_get_value_float(i, "RotX", DoorFaction[i][dfPos][3]);
		cache_get_value_float(i, "RotY", DoorFaction[i][dfPos][4]);
		cache_get_value_float(i, "RotZ", DoorFaction[i][dfPos][5]);
		cache_get_value_float(i, "MoveX", DoorFaction[i][dfMove][0]);
		cache_get_value_float(i, "MoveY", DoorFaction[i][dfMove][1]);
		cache_get_value_float(i, "MoveZ", DoorFaction[i][dfMove][2]);
		cache_get_value_float(i, "MoveRotX", DoorFaction[i][dfMove][3]);
		cache_get_value_float(i, "MoveRotY", DoorFaction[i][dfMove][4]);
		cache_get_value_float(i, "MoveRotZ", DoorFaction[i][dfMove][5]);
        cache_get_value_float(i, "PosXInt", DoorFaction[i][dfPosInt][0]);
		cache_get_value_float(i, "PosYInt", DoorFaction[i][dfPosInt][1]);
		cache_get_value_float(i, "PosZInt", DoorFaction[i][dfPosInt][2]);
		cache_get_value_float(i, "RotXInt", DoorFaction[i][dfPosInt][3]);
		cache_get_value_float(i, "RotYInt", DoorFaction[i][dfPosInt][4]);
		cache_get_value_float(i, "RotZInt", DoorFaction[i][dfPosInt][5]);
		cache_get_value_float(i, "PosXExt", DoorFaction[i][dfPosExt][0]);
		cache_get_value_float(i, "PosYExt", DoorFaction[i][dfPosExt][1]);
		cache_get_value_float(i, "PosZExt", DoorFaction[i][dfPosExt][2]);
		cache_get_value_float(i, "RotXExt", DoorFaction[i][dfPosExt][3]);
		cache_get_value_float(i, "RotYExt", DoorFaction[i][dfPosExt][4]);
		cache_get_value_float(i, "RotZExt", DoorFaction[i][dfPosExt][5]);

		Iter_Add(DoorsFaction, i);

		DoorFaction_Refresh(i);
	}
	printf("*** [Database: Loaded] door faction data (%d count)", rows);
	return 1;
}

DoorFaction_Create(modelid, faction, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
	new id = INVALID_ITERATOR_SLOT;

	if ((id = Iter_Free(DoorsFaction)) != INVALID_ITERATOR_SLOT) {
		Iter_Add(DoorsFaction, id);
		
		DoorFaction[id][dfModel] = modelid;
        DoorFaction[id][dfFaction] = faction;
		DoorFaction[id][dfStatus] = 0;
		DoorFaction[id][dfPos][0] = x;
		DoorFaction[id][dfPos][1] = y;
		DoorFaction[id][dfPos][2] = z;
		DoorFaction[id][dfPos][3] = rx;
		DoorFaction[id][dfPos][4] = ry;
		DoorFaction[id][dfPos][5] = rz;
		DoorFaction[id][dfMove][0] = x;
		DoorFaction[id][dfMove][1] = y;
		DoorFaction[id][dfMove][2] = z;
		DoorFaction[id][dfMove][3] = rx;
		DoorFaction[id][dfMove][4] = ry;
		DoorFaction[id][dfMove][5] = rz;

        DoorFaction[id][dfPosInt][0] = x;
        DoorFaction[id][dfPosInt][1] = y;
        DoorFaction[id][dfPosInt][2] = z;
        DoorFaction[id][dfPosInt][3] = rx;
        DoorFaction[id][dfPosInt][4] = ry;
        DoorFaction[id][dfPosInt][5] = rz;

        DoorFaction[id][dfPosExt][0] = x;
        DoorFaction[id][dfPosExt][1] = y;
        DoorFaction[id][dfPosExt][2] = z;
        DoorFaction[id][dfPosExt][3] = rx;
        DoorFaction[id][dfPosExt][4] = ry;
        DoorFaction[id][dfPosExt][5] = rz;

		new cQuery[2248];
		format(cQuery, sizeof(cQuery), "INSERT INTO `doorfaction` (`Model`) VALUES ('%d')", modelid);
		mysql_tquery(g_SQL, cQuery, "OnDoorFactionCreated", "d", id);
		return id;
	}
	return INVALID_ITERATOR_SLOT;
}

function OnDoorFactionCreated(id) {
	if (Iter_Contains(DoorsFaction, id)) {
		DoorFaction[id][dfID] = cache_insert_id();

		DoorFaction_Refresh(id);
		DoorFaction_Save(id);
		return 1;
	}
	return 0;
}

DoorFaction_Save(id) {
	new cQuery[5248];
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `doorfaction` SET `Model` = '%d'", DoorFaction[id][dfModel]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `Faction`='%d'", cQuery, DoorFaction[id][dfFaction]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `PosX`='%f'", cQuery, DoorFaction[id][dfPos][0]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `PosY`='%f'", cQuery, DoorFaction[id][dfPos][1]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `PosZ`='%f'", cQuery, DoorFaction[id][dfPos][2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `RotX`='%f'", cQuery, DoorFaction[id][dfPos][3]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `RotY`='%f'", cQuery, DoorFaction[id][dfPos][4]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `RotZ`='%f'", cQuery, DoorFaction[id][dfPos][5]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `MoveX`='%f'", cQuery, DoorFaction[id][dfMove][0]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `MoveY`='%f'", cQuery, DoorFaction[id][dfMove][1]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `MoveZ`='%f'", cQuery, DoorFaction[id][dfMove][2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `MoveRotX`='%f'", cQuery, DoorFaction[id][dfMove][3]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `MoveRotY`='%f'", cQuery, DoorFaction[id][dfMove][4]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `MoveRotZ`='%f'", cQuery, DoorFaction[id][dfMove][5]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `PosXInt`='%f'", cQuery, DoorFaction[id][dfPosInt][0]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `PosYInt`='%f'", cQuery, DoorFaction[id][dfPosInt][1]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `PosZInt`='%f'", cQuery, DoorFaction[id][dfPosInt][2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `RotXInt`='%f'", cQuery, DoorFaction[id][dfPosInt][3]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `RotYInt`='%f'", cQuery, DoorFaction[id][dfPosInt][4]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `RotZInt`='%f'", cQuery, DoorFaction[id][dfPosInt][5]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `PosXExt`='%f'", cQuery, DoorFaction[id][dfPosExt][0]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `PosYExt`='%f'", cQuery, DoorFaction[id][dfPosExt][1]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `PosZExt`='%f'", cQuery, DoorFaction[id][dfPosExt][2]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `RotXExt`='%f'", cQuery, DoorFaction[id][dfPosExt][3]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `RotYExt`='%f'", cQuery, DoorFaction[id][dfPosExt][4]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s, `RotZExt`='%f'", cQuery, DoorFaction[id][dfPosExt][5]);
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s WHERE `ID` = %d", cQuery, DoorFaction[id][dfID]);
	return mysql_tquery(g_SQL, cQuery);
}

DoorFaction_Delete(id) {
	if (Iter_Contains(DoorsFaction, id)) {
		Iter_Remove(DoorsFaction, id);
		new cQuery[2248];
		format(cQuery, sizeof(cQuery), "DELETE FROM `doorfaction` WHERE `ID` = '%d'", DoorFaction[id][dfID]);
		mysql_tquery(g_SQL, cQuery);
		if (IsValidDynamicObject(DoorFaction[id][dfObj]))
		DestroyDynamicObject(DoorFaction[id][dfObj]);
        if (IsValidDynamicObject(DoorFaction[id][dfObjDInt]))
		DestroyDynamicObject(DoorFaction[id][dfObjDInt]);
        if (IsValidDynamicObject(DoorFaction[id][dfObjDExt]))
		DestroyDynamicObject(DoorFaction[id][dfObjDExt]);
		DoorFaction[id][dfID] = 0;
		DoorFaction[id][dfObj] = DoorFaction[id][dfObjDInt] = DoorFaction[id][dfObjDExt] = INVALID_STREAMER_ID;
		return 1;
	}
	return 0;
}

DoorFaction_Refresh(id) {
    if (IsValidDynamicObject(DoorFaction[id][dfObj])) DestroyDynamicObject(DoorFaction[id][dfObj]);
    if (IsValidDynamicObject(DoorFaction[id][dfObjDInt])) DestroyDynamicObject(DoorFaction[id][dfObjDInt]);
    if (IsValidDynamicObject(DoorFaction[id][dfObjDExt])) DestroyDynamicObject(DoorFaction[id][dfObjDExt]);
	DoorFaction[id][dfObj] = CreateDynamicObject(DoorFaction[id][dfModel], 
    DoorFaction[id][dfPos][0],
	DoorFaction[id][dfPos][1],
	DoorFaction[id][dfPos][2],
	DoorFaction[id][dfPos][3],
	DoorFaction[id][dfPos][4],
	DoorFaction[id][dfPos][5]);
    DoorFaction[id][dfObjDInt] = CreateDynamicObject(19273, 
    DoorFaction[id][dfPosInt][0],
	DoorFaction[id][dfPosInt][1],
	DoorFaction[id][dfPosInt][2],
	DoorFaction[id][dfPosInt][3],
	DoorFaction[id][dfPosInt][4],
	DoorFaction[id][dfPosInt][5]);
    DoorFaction[id][dfObjDExt] = CreateDynamicObject(19273, 
    DoorFaction[id][dfPosExt][0],
	DoorFaction[id][dfPosExt][1],
	DoorFaction[id][dfPosExt][2],
	DoorFaction[id][dfPosExt][3],
	DoorFaction[id][dfPosExt][4],
	DoorFaction[id][dfPosExt][5]);
	DoorFaction[id][dfStatus] = 0;
	return 1;
}

DoorFaction_Sync(id) {
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObj],E_STREAMER_MODEL_ID,DoorFaction[id][dfModel]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObj],E_STREAMER_X,DoorFaction[id][dfPos][0]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObj],E_STREAMER_Y,DoorFaction[id][dfPos][1]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObj],E_STREAMER_Z,DoorFaction[id][dfPos][2]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObj],E_STREAMER_R_X,DoorFaction[id][dfPos][3]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObj],E_STREAMER_R_Y,DoorFaction[id][dfPos][4]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObj],E_STREAMER_R_Z,DoorFaction[id][dfPos][5]);

    Streamer_SetIntData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDInt],E_STREAMER_MODEL_ID,19273);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDInt],E_STREAMER_X,DoorFaction[id][dfPosInt][0]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDInt],E_STREAMER_Y,DoorFaction[id][dfPosInt][1]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDInt],E_STREAMER_Z,DoorFaction[id][dfPosInt][2]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDInt],E_STREAMER_R_X,DoorFaction[id][dfPosInt][3]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDInt],E_STREAMER_R_Y,DoorFaction[id][dfPosInt][4]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDInt],E_STREAMER_R_Z,DoorFaction[id][dfPosInt][5]);

    Streamer_SetIntData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDExt],E_STREAMER_MODEL_ID,19273);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDExt],E_STREAMER_X,DoorFaction[id][dfPosExt][0]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDExt],E_STREAMER_Y,DoorFaction[id][dfPosExt][1]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDExt],E_STREAMER_Z,DoorFaction[id][dfPosExt][2]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDExt],E_STREAMER_R_X,DoorFaction[id][dfPosExt][3]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDExt],E_STREAMER_R_Y,DoorFaction[id][dfPosExt][4]);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT,DoorFaction[id][dfObjDExt],E_STREAMER_R_Z,DoorFaction[id][dfPosExt][5]);
	return 1;
}

DoorFaction_Nearest(playerid) {
  	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach (new i : DoorsFaction)
	{
		playerdist = GetPlayerDistanceFromPoint(playerid, DoorFaction[i][dfPos][0], DoorFaction[i][dfPos][1], DoorFaction[i][dfPos][2]);
		if(playerdist > 10.0) continue;
		if(playerdist <= tempdist) {
			tempdist = playerdist;
			id = i;
		}
	}
  	return id;
}

// DoorFaction_Operate(playerid, id) {
// 	new vehicleid = GetPlayerVehicleID(playerid);
// 	if (DoorFaction[id][dfStatus] == 0) 
// 	{
// 		DoorFaction[id][dfStatus] = 1;
		
// 		if (DoorFaction[id][dfModel] == 968) {
// 			DoorFaction_Timer[id] = 1;

// 			RotateDynamicObject(DoorFaction[id][dfObj], DoorFaction[id][dfMove][3], DoorFaction[id][dfMove][4], DoorFaction[id][dfMove][5], 1);

// 			SetTimerEx("DoorFaction_Closed", 5000, false, "d", id);
// 			if(IsFactionVeh(vehicleid) || IsABusABVeh(GetPlayerVehicleID(playerid)) || IsABusCDVeh(GetPlayerVehicleID(playerid))) {
// 				SendClientMessage(playerid,COLOR_ARWIN,"TOLL: {FFFFFF}Government Issued vehicle pay no toll access");
// 				return 1;
// 			}
// 			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 403 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 514 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 515) {
// 				if (pData[playerid][pPayToll] > 0) {
// 					pData[playerid][pPayToll] -= 2;
// 					SendClientMessage(playerid,COLOR_ARWIN,"TOLL: {FFFFFF}Used {00FFFF}2 toll card point {FFFFFF}to pay toll access.");
// 				} else {
// 					GivePlayerMoneyEx(playerid, -150);
// 					SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$1.50");
// 				}
// 			}
// 			else {
// 				if (pData[playerid][pPayToll] > 0) {
// 					pData[playerid][pPayToll] -= 1;
// 					SendClientMessage(playerid,COLOR_ARWIN,"TOLL: {FFFFFF}Used {00FFFF}1 toll card point {FFFFFF}to pay toll access.");
// 				} else {
// 					GivePlayerMoneyEx(playerid, -50);
// 					SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$0.50");
// 				}
// 			}
// 		} else {
// 			MoveDynamicObject(DoorFaction[id][dfObj], MoveArrTollGate{id});

// 			DoorFaction_Timer[id] = 1;

// 			SetTimerEx("DoorFaction_Closed", 5000, false, "d", id);

// 			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 403 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 514 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 515) {
// 				if (pData[playerid][pPayToll] > 0) {
// 					pData[playerid][pPayToll] -= 2;
// 					SendClientMessage(playerid,COLOR_ARWIN,"TOLL: {FFFFFF}Used {00FFFF}2 toll card point {FFFFFF}to pay toll access.");
// 				} else {
// 					GivePlayerMoneyEx(playerid, -150);
// 					SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$1.50");
// 				}
// 			}
// 			else {
// 				if (pData[playerid][pPayToll] > 0) {
// 					pData[playerid][pPayToll] -= 1;
// 					SendClientMessage(playerid,COLOR_ARWIN,"TOLL: {FFFFFF}Used {00FFFF}1 toll card point {FFFFFF}to pay toll access.");
// 				} else {
// 					GivePlayerMoneyEx(playerid, -50);
// 					SendClientMessage(playerid,COLOR_ARWIN,"TOLL: "WHITE_E"Kamu telah membayar Toll "GREEN_E"$0.50");
// 				}
// 			}
// 		}
// 	} else {
// 		if (DoorFaction_Timer[id]) {
// 		Error(playerid, "Please wait untill the gate is closed!");
// 		}
// 	}
// 	return 1;
// }

function DoorFaction_Closed(id) {
	if (DoorFaction[id][dfModel] == 968) {
		DoorFaction[id][dfStatus] = 0;
		RotateDynamicObject(DoorFaction[id][dfObj], DoorFaction[id][dfPos][3], DoorFaction[id][dfPos][4], DoorFaction[id][dfPos][5], 1.0);
		DoorFaction_Timer[id] = 0;
	} else {
		DoorFaction[id][dfStatus] = 0;
		MoveDynamicObject(DoorFaction[id][dfObj], DoorFaction[id][dfPos][0], DoorFaction[id][dfPos][1], DoorFaction[id][dfPos][2], 3.0, DoorFaction[id][dfPos][3], DoorFaction[id][dfPos][4], DoorFaction[id][dfPos][5]);
		DoorFaction_Timer[id] = 0;
	}
	return 1;
}

DoorFaction_SetObjectPos(id, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
	if (Iter_Contains(DoorsFaction, id)) {
		DoorFaction[id][dfPos][0] = x;
		DoorFaction[id][dfPos][1] = y;
		DoorFaction[id][dfPos][2] = z;
		DoorFaction[id][dfPos][3] = rx;
		DoorFaction[id][dfPos][4] = ry;
		DoorFaction[id][dfPos][5] = rz;
		return 1;
	}
	return 0;
}

DoorFaction_SetObjectMove(id, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
	if (Iter_Contains(DoorsFaction, id)) {
		DoorFaction[id][dfMove][0] = x;
		DoorFaction[id][dfMove][1] = y;
		DoorFaction[id][dfMove][2] = z;
		DoorFaction[id][dfMove][3] = rx;
		DoorFaction[id][dfMove][4] = ry;
		DoorFaction[id][dfMove][5] = rz;
		return 1;
	}
	return 0;
}

#include <YSI\y_hooks>

hook OnPlayerEditDynObj(playerid, STREAMER_TAG_OBJECT: objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(response == EDIT_RESPONSE_FINAL)
	{
		if (editDoorFactionID[playerid] != -1) {
			new modes = editDoorFactioMode[playerid];
			if (modes == 0) 
			{
				new id = editDoorFactionID[playerid];
				DoorFaction_SetObjectPos(id, x, y, z, rx, ry, rz);
				DoorFaction_Sync(id);
				DoorFaction_Save(id);
				Custom(playerid, "DOOR", "You've sucessfully editing door faction position!");
				editDoorFactionID[playerid] = -1;
				editDoorFactioMode[playerid] = -1;
				return 1;
			} 
			else if (modes == 1) 
			{
				new id = editDoorFactionID[playerid];
				DoorFaction_SetObjectMove(id, x, y, z, rx, ry, rz);

				DoorFaction_Sync(id);
				DoorFaction_Save(id);
				Custom(playerid, "DOOR", "You've successfully editing door faction move!");
				editDoorFactionID[playerid] = -1;
				editDoorFactioMode[playerid] = -1;
				return 1;
			}
            else if(modes == 2) {
                new id = editDoorFactionID[playerid];
				DoorFaction[id][dfPosInt][0] = x;
                DoorFaction[id][dfPosInt][1] = y;
                DoorFaction[id][dfPosInt][2] = z;
                DoorFaction[id][dfPosInt][3] = rx;
                DoorFaction[id][dfPosInt][4] = ry;
                DoorFaction[id][dfPosInt][5] = rz;

				DoorFaction_Sync(id);
				DoorFaction_Save(id);
				Custom(playerid, "DOOR", "You've successfully editing button door faction!");
				editDoorFactionID[playerid] = -1;
				editDoorFactioMode[playerid] = -1;
            }
            else if(modes == 3) {
                new id = editDoorFactionID[playerid];
				DoorFaction[id][dfPosExt][0] = x;
                DoorFaction[id][dfPosExt][1] = y;
                DoorFaction[id][dfPosExt][2] = z;
                DoorFaction[id][dfPosExt][3] = rx;
                DoorFaction[id][dfPosExt][4] = ry;
                DoorFaction[id][dfPosExt][5] = rz;

				DoorFaction_Sync(id);
				DoorFaction_Save(id);
				Custom(playerid, "DOOR", "You've successfully editing button door faction!");
				editDoorFactionID[playerid] = -1;
				editDoorFactioMode[playerid] = -1;
            }
		}
	}
	if(response == EDIT_RESPONSE_CANCEL)
	{
		if (editDoorFactionID[playerid] != -1) {
			new modes = editDoorFactioMode[playerid];
			if(modes == 0 || modes == 1 || modes == 2 || modes  == 3)
			{
				new id = editDoorFactionID[playerid];
				DoorFaction_Sync(id);

				editDoorFactionID[playerid] = -1;		
				editDoorFactioMode[playerid] = -1;
				Custom(playerid, "DOOR", "You've canceled editing door faction.");
				return 1;
			}
		}
	}
	return 0;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) if((newkeys & KEY_SECONDARY_ATTACK))
    {
        foreach(new id : DoorsFaction) if(IsPlayerInRangeOfPoint(playerid, 2.8, DoorFaction[id][dfPosInt][0], DoorFaction[id][dfPosInt][1], DoorFaction[id][dfPosInt][2]) ||
        IsPlayerInRangeOfPoint(playerid, 2.8, DoorFaction[id][dfPosExt][0], DoorFaction[id][dfPosExt][1], DoorFaction[id][dfPosExt][2])) {
            if(DoorFaction[id][dfFaction] != pData[playerid][pFaction]) return Error(playerid, "Acces denied!");
            if (DoorFaction[id][dfStatus] == 0)  {
                ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 10.0, 0, 0, 0, 0, 0);
                DoorFaction[id][dfStatus] = 1;
                DoorFaction_Timer[id] = 1;
                MoveDynamicObject(DoorFaction[id][dfObj], DoorFaction[id][dfMove][0], DoorFaction[id][dfMove][1], DoorFaction[id][dfMove][2], 3.0, DoorFaction[id][dfMove][3], DoorFaction[id][dfMove][4], DoorFaction[id][dfMove][5]);
                SetTimerEx("DoorFaction_Closed", 5000, false, "d", id);
            } else {
                if (DoorFaction_Timer[id]) {
                Error(playerid, "Please wait untill the door is closed!");
                }
            }
        }
    }
	return 1;
}


// Admin Commands
CMD:doorfaction(playerid, params[]) {
	if (pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new option[24], str[32];
	if (sscanf(params, "s[24]S()[32]", option, str)) {
		Usage(playerid, "/doorfaction [option]");
		SendClientMessageEx(playerid, COLOR_YELLOW, "[OPTIONS]: "WHITE_E"create, delete, position, move, near, buttonint, buttonext");
		return 1;
	}
	if (!strcmp(option, "create")) {
		new id, modelid, faction, Float:playerPos[3], Float:rotate[3];
		if (sscanf(str, "dd", modelid, faction)) return Usage(playerid, "/doorfaction create [modelid] [faction (1.SAPD 2.SAGS 3.SAMD 4.SANEWS)]");
		GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
		rotate[0] = 0.0;
		rotate[1] = 0.0;
		rotate[2] = 0.0;

		id = DoorFaction_Create(modelid, faction, playerPos[0], playerPos[1], playerPos[2], rotate[0], rotate[1], rotate[2]);

		Custom(playerid, "DOOR", "You've successfully created door faction id: "YELLOW_E"%d", id);
	} else if (!strcmp(option, "delete")) {
		new id;
		if (sscanf(str, "d", id)) return Usage(playerid, "/doorfaction delete [doorF id]");
		if (!Iter_Contains(DoorsFaction, id)) return Error(playerid, "Invalid door faction ID!");
		DoorFaction_Delete(id);
		Custom(playerid, "DOOR", "You've successfully deleted door faction id: "YELLOW_E"%d", id);
	} else if (!strcmp(option, "position")) {
		new id;
		if (sscanf(str, "d", id)) return Usage(playerid, "/doorfaction position [doorF id]");
		if (!Iter_Contains(DoorsFaction, id)) return Error(playerid, "Invalid door faction ID!");
		editDoorFactionID[playerid] = id;
		editDoorFactioMode[playerid] = 0;
		EditDynamicObject(playerid, DoorFaction[id][dfObj]);
	} else if (!strcmp(option, "move")) {
		new id;
		if (sscanf(str, "d", id)) return Usage(playerid, "/doorfaction move [doorF id]");
		if (!Iter_Contains(DoorsFaction, id)) return Error(playerid, "Invalid door faction ID!");
		editDoorFactionID[playerid] = id;
		editDoorFactioMode[playerid] = 1;

		EditDynamicObject(playerid, DoorFaction[id][dfObj]);
	} else if (!strcmp(option, "near")) {
		new id = -1;
		if ((id = DoorFaction_Nearest(playerid)) != -1) {
		Custom(playerid, "DOOR", "Nearest door faction id: "YELLOW_E"%d", id);
		}
	} else if (!strcmp(option, "buttonint")) {
		new id;
		if (sscanf(str, "d", id)) return Usage(playerid, "/doorfaction buttonint [doorF id]");
		if (!Iter_Contains(DoorsFaction, id)) return Error(playerid, "Invalid door faction ID!");
		editDoorFactionID[playerid] = id;
		editDoorFactioMode[playerid] = 2;

		EditDynamicObject(playerid, DoorFaction[id][dfObjDInt]);
	} else if (!strcmp(option, "buttonext")) {
		new id;
		if (sscanf(str, "d", id)) return Usage(playerid, "/doorfaction buttonext [doorF id]");
		if (!Iter_Contains(DoorsFaction, id)) return Error(playerid, "Invalid door faction ID!");
		editDoorFactionID[playerid] = id;
		editDoorFactioMode[playerid] = 3;

		EditDynamicObject(playerid, DoorFaction[id][dfObjDExt]);
	}
	return 1;
}