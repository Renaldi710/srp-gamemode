//#define BOX_INDEX 0
new CourierVehicle[4];
new TimerCourier[MAX_PLAYERS], CourierCrate[MAX_PLAYERS], CourierCount[MAX_PLAYERS], CourierID[MAX_PLAYERS][11];

new Float: CourierPlayerX[MAX_PLAYERS][100];
new Float: CourierPlayerY[MAX_PLAYERS][100];
new Float: CourierPlayerZ[MAX_PLAYERS][100];
new bool:CourierStatus[MAX_PLAYERS][11];

#include <YSI\y_hooks>
hook OnGameModeInit()
{
    new objectcourier;
    CourierVehicle[0] = AddStaticVehicle(498,1772.3386,-1702.9760,13.5782,11.1372,2,1);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[0], -1.210, -0.670, 0.900, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[0], 1.216, -0.709, 0.870, 0.000, 0.000, 179.700);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[0], -1.221, -1.271, 0.400, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[0], 1.230, -0.229, 0.320, 0.000, 0.000, 179.800);

    CourierVehicle[1] = AddStaticVehicle(498,1776.0262,-1702.9165,13.5767,9.1052,2,1);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[1], -1.210, -0.670, 0.900, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[1], 1.216, -0.709, 0.870, 0.000, 0.000, 179.700);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[1], -1.221, -1.271, 0.400, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[1], 1.230, -0.229, 0.320, 0.000, 0.000, 179.800);


    CourierVehicle[2] = AddStaticVehicle(498,1780.6472,-1702.3958,13.5761,10.6289,2,1);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[2], -1.210, -0.670, 0.900, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[2], 1.216, -0.709, 0.870, 0.000, 0.000, 179.700);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[2], -1.221, -1.271, 0.400, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[2], 1.230, -0.229, 0.320, 0.000, 0.000, 179.800);

    CourierVehicle[3] = AddStaticVehicle(498,1784.5532,-1702.2916,13.5749,10.9174,2,1);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[3], -1.210, -0.670, 0.900, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "AMAZING", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[3], 1.216, -0.709, 0.870, 0.000, 0.000, 179.700);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[3], -1.221, -1.271, 0.400, 0.000, 0.000, 0.000);
    objectcourier = CreateDynamicObject(18667,0.0,0.0,-1000.0,0.0,0.0,0.0,0,0,-1,300.0,300.0);
    SetDynamicObjectMaterialText(objectcourier, 0, "PRIME", 130, "Courier New", 110, 1, -1, 0, 0);
    AttachDynamicObjectToVehicle(objectcourier, CourierVehicle[3], 1.230, -0.229, 0.320, 0.000, 0.000, 179.800);

}

IsACourierVeh(carid)
{
    for(new v = 0; v < sizeof(CourierVehicle); v++) {
        if(carid == CourierVehicle[v]) return 1;
    }
    return 0;
}


Dialog:CourierSidejob(playerid, response, listitem, inputtext[]) {
    if(response)
    {
        if(pData[playerid][pCourierTime] > 0) return Error(playerid, "Kamu harus menunggu %d Menit untuk menjadi pengantar paket", pData[playerid][pCourierTime]/60);
        Custom(playerid, "SIDEJOB", "Icon merah {FFFFFF}di radar map adalah lokasi pengiriman paket ke rumah");
        Custom(playerid, "SIDEJOB", "Setelah sampai rumah, keluar dari kendaraan lalu antar paket ke pintu rumah");
        Custom(playerid, "SIDEJOB", "Jika sudah mengantar 10 paket, mohon kembalikan kendaraan ke tempat awal");
        Custom(playerid, "SIDEJOB", "Meninggalkan mobil Boxville selama 60 detik artinya berhenti bekerja");
        
        pData[playerid][pSideJob] = SIDEJOB_COURIER;
        CourierCount[playerid] = 0;
        new rand[10], rada = 50, count = 0;

        foreach(new hid : Houses) if(!hData[hid][housePacket]) 
        {
            count++;
        }
        for(new id = 0; id < 10; id++)
        {
            rand[id] = random(count - 1);
            if(++rand[id] >= count) 
            {
                rand[id] = 0;
            }
            if(rand[id] == rand[id]) rand[id] = random(count - 1);
            CourierStatus[playerid][id] = false;
            CourierID[playerid][id] = rand[id];

            pData[playerid][pSideJobVeh] = GetPlayerVehicleID(playerid);
            
            CourierPlayerX[playerid][id] = hData[rand[id]][hExtposX];
            CourierPlayerY[playerid][id] = hData[rand[id]][hExtposY];
            CourierPlayerZ[playerid][id] = hData[rand[id]][hExtposZ];
            SetPlayerMapIcon(playerid, rada+id, CourierPlayerX[playerid][id], CourierPlayerY[playerid][id], CourierPlayerZ[playerid][id], 0, COLOR_RED, MAPICON_GLOBAL);
        }
    }
    else
    {
        RemovePlayerFromVehicle(playerid);
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));

        pData[playerid][pSideJobVeh] = INVALID_VEHICLE_ID;
    }
    return 1;
}

ptask CourierTimer[1000](playerid) 
{
    if(pData[playerid][pSideJob] == SIDEJOB_COURIER && !IsPlayerInAnyVehicle(playerid) && CourierCrate[playerid])
    {
        TimerCourier[playerid]--;
        new str[256];
        format(str, sizeof(str), "~w~Return To Vehicle ~n~in ~y~%d seconds", TimerCourier[playerid]);
        GameTextForPlayer(playerid, str, 1000, 6);
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        if(TimerCourier[playerid] == 0)
        {
            new gaji;
            gaji = CourierCount[playerid]*75;
            TimerCourier[playerid] = 0;
            pData[playerid][pSideJob] = SIDEJOB_NONE;

            if(IsValidVehicle(pData[playerid][pSideJobVeh]))
                SetVehicleToRespawn(pData[playerid][pSideJobVeh]);

            pData[playerid][pSideJobVeh] = INVALID_VEHICLE_ID;

            format(str, sizeof(str), "(Courier) Delivered %d packages", CourierCount[playerid]);
            AddPlayerSalary(playerid, str, gaji);	
            Custom(playerid, "COURIER", "Courier sidejob failed, {3BBD44}$%s {ffffff}has been issued for your next paycheck", FormatMoney(gaji));
            Custom(playerid, "SALARY", "Your salary statement has been updated, please check command {ffff00}'/salary'");
            CourierCount[playerid] = 0;
            CourierCrate[playerid] = 0;
            RemovePlayerAttachedObject(playerid, 9);
            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
            pData[playerid][pCourierTime] = 1600;
            for(new id; id < 10; id++)
            {
                CourierStatus[playerid][id] = false;
            }
        }
    }
    return 1;
}
