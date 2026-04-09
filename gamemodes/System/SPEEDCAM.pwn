
#define MAX_SPEED_CAMERAS           50

enum speedData {
    speedID,
    speedExists,
    Float:speedPos[4],
    Float:speedRange,
    Float:speedLimit,
    speedObject,
    Text3D:speedText3D,
    speedVehicle,
    speedVehPlate[24],
    speedVehSpeed
};

new SpeedData[MAX_SPEED_CAMERAS][speedData];


Speed_Refresh(speedid)
{
    if(speedid != -1 && SpeedData[speedid][speedExists])
    {
        new
        string[64];

        if(!IsValidDynamicObject(SpeedData[speedid][speedObject])) SpeedData[speedid][speedObject] = CreateDynamicObject(18880, SpeedData[speedid][speedPos][0], SpeedData[speedid][speedPos][1], SpeedData[speedid][speedPos][2], 0.0, 0.0, SpeedData[speedid][speedPos][3]);
        Speed_ObjectUpdate(speedid);

        if(IsValidDynamic3DTextLabel(SpeedData[speedid][speedText3D]))
            DestroyDynamic3DTextLabel(SpeedData[speedid][speedText3D]);

        format(string, sizeof(string), "[Camera %d]\n"WHITE_E"Speed Limit: %.0f mph", speedid, SpeedData[speedid][speedLimit]);

        SpeedData[speedid][speedText3D] = CreateDynamic3DTextLabel(string, ARWIN, SpeedData[speedid][speedPos][0], SpeedData[speedid][speedPos][1], SpeedData[speedid][speedPos][2] + 2.5, 7.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
    }
    return 1;
}

Speed_ObjectUpdate(speedid) {
    new objectid = SpeedData[speedid][speedObject];

    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_X, SpeedData[speedid][speedPos][0]);
    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_Y, SpeedData[speedid][speedPos][1]);
    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_Z, SpeedData[speedid][speedPos][2]);
    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_R_Z, SpeedData[speedid][speedPos][3]);
    return 1;
}

function Speed_Load()
{
    new
        rows = cache_num_rows();

    for (new i = 0; i < rows; i ++) if(i < MAX_SPEED_CAMERAS)
    {
        SpeedData[i][speedExists] = true;
        cache_get_value_int(i, "speedID", SpeedData[i][speedID]);
        cache_get_value_float(i, "speedRange", SpeedData[i][speedRange]);
        cache_get_value_float(i, "speedLimit", SpeedData[i][speedLimit]);
        cache_get_value_float(i, "speedX", SpeedData[i][speedPos][0]);
        cache_get_value_float(i, "speedY", SpeedData[i][speedPos][1]);
        cache_get_value_float(i, "speedZ", SpeedData[i][speedPos][2]);
        cache_get_value_float(i, "speedAngle", SpeedData[i][speedPos][3]);

        Speed_Refresh(i);
    }
    printf("*** [Database: Loaded] speedcam data (%d count).", rows);
    return 1;
}

function OnSpeedCreated(speedid)
{
    if(speedid == -1 || !SpeedData[speedid][speedExists])
        return 0;

    SpeedData[speedid][speedID] = cache_insert_id();
    Speed_Save(speedid);

    return 1;
}

Speed_Save(speedid)
{
    new
        query[255];

    format(query, sizeof(query), "UPDATE `speedcameras` SET `speedRange` = '%.4f', `speedLimit` = '%.4f', `speedX` = '%.4f', `speedY` = '%.4f', `speedZ` = '%.4f', `speedAngle` = '%.4f' WHERE `speedID` = '%d'",
        SpeedData[speedid][speedRange],
        SpeedData[speedid][speedLimit],
        SpeedData[speedid][speedPos][0],
        SpeedData[speedid][speedPos][1],
        SpeedData[speedid][speedPos][2],
        SpeedData[speedid][speedPos][3],
        SpeedData[speedid][speedID]
    );
    return mysql_tquery(g_SQL, query);
}

Speed_Nearest(playerid)
{
    new id = -1;
    for (new i = 0, j = MAX_SPEED_CAMERAS; i < j; i ++) if(IsPlayerInRangeOfPoint(playerid, SpeedData[i][speedRange], SpeedData[i][speedPos][0], SpeedData[i][speedPos][1], SpeedData[i][speedPos][2])) {
        id = i;
    }

    return id;
}

Speed_UpdateSuspect(speedid, vehicleid) {
    if(speedid != -1 && SpeedData[speedid][speedExists]) {
        if (vehicleid != INVALID_VEHICLE_ID) {
            new plate[24];
            GetVehicleNumberPlate(vehicleid, plate);
            SpeedData[speedid][speedVehicle] = GetVehicleModel(vehicleid);
            format(SpeedData[speedid][speedVehPlate], 24, "%s", plate);
            SpeedData[speedid][speedVehSpeed] = floatround(GetVehicleSpeed(vehicleid));

            if(IsValidDynamic3DTextLabel(SpeedData[speedid][speedText3D])) {
                new direction[12], string[512];

                GetVehicleDirection(vehicleid, direction);
                format(string, sizeof(string), "CAMERA: %d\n"WHITE_E"Last Vehicle: "GREEN_E"%s\n"WHITE_E"Plate: "GREEN_E"%s\n"WHITE_E"Heading: "GREEN_E"%s\n"WHITE_E"Speed: "GREEN_E"%d mph/%.0f mph", speedid, GetVehicleNameByModel(SpeedData[speedid][speedVehicle]), SpeedData[speedid][speedVehPlate], direction, SpeedData[speedid][speedVehSpeed], SpeedData[speedid][speedLimit]);
                UpdateDynamic3DTextLabelText(SpeedData[speedid][speedText3D], ARWIN, string);
            }
        }
    }
    return 1;
}

Speed_Delete(speedid)
{
    if(speedid != -1 && SpeedData[speedid][speedExists])
    {
        new
            string[64];

        if(IsValidDynamicObject(SpeedData[speedid][speedObject]))
            DestroyDynamicObject(SpeedData[speedid][speedObject]);

        if(IsValidDynamic3DTextLabel(SpeedData[speedid][speedText3D]))
            DestroyDynamic3DTextLabel(SpeedData[speedid][speedText3D]);

        format(string, sizeof(string), "DELETE FROM `speedcameras` WHERE `speedID` = '%d'", SpeedData[speedid][speedID]);
        mysql_tquery(g_SQL, string);

        SpeedData[speedid][speedExists] = false;
        SpeedData[speedid][speedLimit] = 0.0;
        SpeedData[speedid][speedRange] = 0.0;
        SpeedData[speedid][speedID] = 0;

        SpeedData[speedid][speedObject] = INVALID_STREAMER_ID;
        SpeedData[speedid][speedText3D] = Text3D:INVALID_STREAMER_ID;
    }
    return 1;
}

Speed_Create(playerid, Float:limit, Float:range)
{
    new
            Float:x,
        Float:y,
        Float:z,
        Float:angle;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);

    for (new i = 0; i < MAX_SPEED_CAMERAS; i ++) if(!SpeedData[i][speedExists])
    {
        SpeedData[i][speedExists] = true;
        SpeedData[i][speedRange] = range;
        SpeedData[i][speedLimit] = limit;

        SpeedData[i][speedPos][0] = x + (1.5 * floatsin(-angle, degrees));
        SpeedData[i][speedPos][1] = y + (1.5 * floatcos(-angle, degrees));
        SpeedData[i][speedPos][2] = z - 1.2;
        SpeedData[i][speedPos][3] = angle;

        Speed_Refresh(i);
        mysql_tquery(g_SQL, "INSERT INTO `speedcameras` (`speedRange`) VALUES(0.0)", "OnSpeedCreated", "d", i);
        return i;
    }
    return -1;
}

stock SendSpeedCamMessageEx(type, color, const str[], {Float,_}:...)
{
    static
        args,
        start,
        end,
        string[144]
    ;
    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if(args > 12)
    {
        #emit ADDR.pri str
        #emit STOR.pri start

        for (end = start + (args - 12); end > start; end -= 4)
        {
            #emit LREF.pri end
            #emit PUSH.pri
        }
        #emit PUSH.S str
        #emit PUSH.C 144
        #emit PUSH.C string
        #emit PUSH.C args

        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        foreach (new i : Player) if(pData[i][pFaction] != -1 && pData[i][pFaction] == type) {
                SendClientMessage(i, color, string);
        }
        return 1;
    }
    foreach (new i : Player) if(pData[i][pFaction] != -1 && pData[i][pFaction] == type) {
        SendClientMessage(i, color, str);
    }
    return 1;
}

CMD:createspeed(playerid, params[])
{
    static
        Float:limit,
        Float:range;

    if (pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(sscanf(params, "ff", limit, range))
        return Usage(playerid, "/createspeed [speed limit] [range] (default range: 30)");

    if(limit < 5.0 || limit > 150.0)
        return Error(playerid, "The speed limit can't be below 5 or above 150.");

    if(range < 5.0 || range > 50.0)
        return Error(playerid, "The range can't be below 5 or above 50.");

    if(Speed_Nearest(playerid) != -1)
        return Error(playerid, "You can't do this in range another speed camera.");

    new id = Speed_Create(playerid, limit, range);

    if(id == -1)
        return Error(playerid, "The server has reached the limit for speed cameras.");

    Servers(playerid, "You have created speed camera ID: %d.", id);
    return 1;
}

CMD:editspeed(playerid, params[]) {
    if (pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    new option[24], optionalParams[32];
    if (sscanf(params, "s[24]S()[32]", option, optionalParams))
        return Usage(playerid, "/editspeed [pos/speedlimit/range]");

    if (!strcmp(option, "pos", true)) {
        new speedId;
        if (sscanf(optionalParams, "d", speedId))
            return Usage(playerid, "/editspeed pos [speed id]");

        if((speedId < 0 || speedId >= MAX_SPEED_CAMERAS) || !SpeedData[speedId][speedExists])
            return Error(playerid, "You have specified an invalid speed camera ID.");

        pData[playerid][pEditSpeed] = speedId;
        EditDynamicObject(playerid, SpeedData[speedId][speedObject]);
        Custom(playerid, "SPEEDCAM", "You're now editing Speed Camera id: "YELLOW_E"%d", speedId);
    } else if (!strcmp(option, "speedlimit", true)) {
        new speedId, Float:limit;
        if (sscanf(optionalParams, "df", speedId, limit))
            return Usage(playerid, "/editspeed speedlimit [speed id] [speed limit (mph)]");

        if((speedId < 0 || speedId >= MAX_SPEED_CAMERAS) || !SpeedData[speedId][speedExists])
            return Error(playerid, "You have specified an invalid speed camera ID.");

        SpeedData[speedId][speedLimit] = limit;
        Speed_Refresh(speedId);
        Speed_Save(speedId);
        Custom(playerid, "SPEEDCAM", "You've been changed speed limit of Speed Camera id: "YELLOW_E"%d", speedId);
    } else if (!strcmp(option, "range", true)) {
        new speedId, Float:range;
        if (sscanf(optionalParams, "df", speedId, range))
            return Usage(playerid, "/editspeed speedlimit [speed id] [speed range]");

        if((speedId < 0 || speedId >= MAX_SPEED_CAMERAS) || !SpeedData[speedId][speedExists])
            return Error(playerid, "You have specified an invalid speed camera ID.");

        SpeedData[speedId][speedRange] = range;
        Speed_Refresh(speedId);
        Speed_Save(speedId);
        Custom(playerid, "SPEEDCAM", "You've been changed range of Speed Camera id: "YELLOW_E"%d", speedId);
    } else Usage(playerid, "/editspeed [pos/speedlimit/range]");
    return 1;
}

CMD:destroyspeed(playerid, params[])
{
    static
        id = 0;

    if (pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(sscanf(params, "d", id))
        return Usage(playerid, "/destroyspeed [speed id]");

    if((id < 0 || id >= MAX_SPEED_CAMERAS) || !SpeedData[id][speedExists])
        return Error(playerid, "You have specified an invalid speed camera ID.");

    Speed_Delete(id);
    Servers(playerid, "You have successfully destroyed speed camera ID: %d.", id);
    return 1;
}
