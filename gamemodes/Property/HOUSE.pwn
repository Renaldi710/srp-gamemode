//House System
#define MAX_HOUSES	500
#define LIMIT_PER_PLAYER 3
#define Loop(%0,%1,%2) for(new %0 = %2; %0 < %1; %0++)

enum houseinfo
{
	hOwner[MAX_PLAYER_NAME],
	hAddress[128],
	hPrice,
	hType,
	hLocked,
	hMoney,
	hWeapon[10],
	hAmmo[10],
	hInt,
	Float:hExtposX,
	Float:hExtposY,
	Float:hExtposZ,
	Float:hExtposA,
	Float:hIntposX,
	Float:hIntposY,
	Float:hIntposZ,
	Float:hIntposA,
	hVisit,
	//Not Saved
	hPickup,
	STREAMER_TAG_CP:hCPExt,
	STREAMER_TAG_CP:hCPInt,
	Text3D:hLabel,
	housePacket,
	houseBuilder,
	houseBuilderTime,
};

new hData[MAX_HOUSES][houseinfo],
	Iterator: Houses<MAX_HOUSES>;

enum houseStructure {
    structureID,
    structureModel,
    Float:structurePos[3],
    Float:structureRot[3],
    structureMaterial,
    structureColor,
    structureType,
    structureObject
};

new HouseStructure[MAX_HOUSES][MAX_HOUSE_STRUCTURES][houseStructure],
    Iterator:HouseStruct[MAX_HOUSES]<MAX_HOUSE_STRUCTURES>;

enum furnitureData {
    furnitureID,
    furnitureModel,
    furnitureName[32],
    Float:furniturePos[3],
    Float:furnitureRot[3],
    furnitureMaterials[MAX_MATERIALS],
    furnitureObject,
    furnitureUnused
};

new FurnitureData[MAX_HOUSES][MAX_FURNITURE][furnitureData],
    Iterator:HouseFurnitures[MAX_HOUSES]<MAX_FURNITURE>;

enum e_HouseInteriors {
    e_ObjModel,
    Float:e_ObjPosX,
    Float:e_ObjPosY,
    Float:e_ObjPosZ,
    Float:e_ObjRotX,
    Float:e_ObjRotY,
    Float:e_ObjRotZ,
    e_Type
};

new g_aHouseInteriors[][e_HouseInteriors] = {
    // Small
    {19379,383.881,632.481,1012.149,0.000,90.000,270.000,1},
    {19379,374.301,632.481,1012.149,0.000,90.000,270.000,1},
    {19379,374.301,622.131,1012.149,0.000,90.000,270.000,1},
    {19379,374.301,621.990,1008.589,0.000,90.000,270.000,1},
    {19379,374.301,632.481,1008.589,0.000,90.000,270.000,1},
    {19379,383.881,632.481,1008.589,0.000,90.000,270.000,1},
    {19369,388.612,628.821,1010.345,0.000,0.000,0.000,1},
    {19369,388.612,631.981,1010.345,0.000,0.000,0.000,1},
    {19369,388.612,635.181,1010.345,0.000,0.000,0.000,1},
    {19369,388.612,638.361,1010.345,0.000,0.000,0.000,1},
    {19369,387.002,637.640,1010.345,0.000,0.000,90.000,1},
    {19369,383.882,637.640,1010.345,0.000,0.000,90.000,1},
    {19369,380.752,637.640,1010.345,0.000,0.000,90.000,1},
    {19369,377.572,637.640,1010.345,0.000,0.000,90.000,1},
    {19369,374.382,637.640,1010.345,0.000,0.000,90.000,1},
    {19369,371.182,637.640,1010.345,0.000,0.000,90.000,1},
    {19369,383.932,627.260,1010.345,0.000,0.000,90.000,1},
    {19369,379.022,625.590,1010.345,0.000,0.000,180.000,1},
    {19369,371.192,627.260,1010.345,0.000,0.000,90.000,1},
    {19369,377.582,627.260,1010.345,0.000,0.000,90.000,1},
    {19369,380.742,627.260,1010.345,0.000,0.000,90.000,1},
    {19369,387.122,627.260,1010.345,0.000,0.000,90.000,1},
    {19369,379.022,622.380,1010.345,0.000,0.000,180.000,1},
    {19369,379.022,619.221,1010.345,0.000,0.000,180.000,1},
    {19369,377.442,617.580,1010.345,0.000,0.000,270.000,1},
    {19369,374.313,617.580,1010.345,0.000,0.000,270.000,1},
    {19369,371.203,617.580,1010.345,0.000,0.000,270.000,1},
    {19369,369.583,619.220,1010.345,0.000,0.000,360.000,1},
    {19369,369.583,622.370,1010.345,0.000,0.000,360.000,1},
    {19369,369.583,625.560,1010.345,0.000,0.000,360.000,1},
    {19369,369.583,628.730,1010.345,0.000,0.000,360.000,1},
    {19369,369.583,631.880,1010.345,0.000,0.000,360.000,1},
    {19369,369.583,635.010,1010.345,0.000,0.000,360.000,1},
    {19369,369.583,638.210,1010.345,0.000,0.000,360.000,1},
    {1506,388.525,633.680,1008.675,0.000,0.000,90.000,1},
    {19397,374.375,627.252,1010.345,0.000,0.000,90.000,1},
    {1491,375.131,627.269,1008.605,0.000,0.000,540.000,1},
    // Medium
    {19379,427.058,602.686,1002.676,540.000,990.000,450.000,2},
    {19379,427.058,613.025,1002.676,540.000,990.000,450.000,2},
    {19379,427.058,623.415,1002.676,540.000,990.000,450.000,2},
    {19379,417.508,623.415,1002.676,540.000,990.000,450.000,2},
    {19379,417.508,612.946,1002.676,540.000,990.000,450.000,2},
    {19379,417.508,602.546,1002.676,540.000,990.000,450.000,2},
    {19379,408.058,602.546,1002.676,540.000,990.000,450.000,2},
    {19379,408.058,613.016,1002.676,540.000,990.000,450.000,2},
    {19379,427.058,613.145,999.136,540.000,990.000,450.000,2},
    {19379,417.458,613.145,999.136,540.000,990.000,450.000,2},
    {19379,427.058,602.686,999.136,540.000,990.000,450.000,2},
    {19379,417.488,602.686,999.136,540.000,990.000,450.000,2},
    {19379,407.918,602.686,999.136,540.000,990.000,450.000,2},
    {19379,407.918,613.085,999.136,540.000,990.000,450.000,2},
    {19379,427.058,623.546,999.136,540.000,990.000,450.000,2},
    {19379,417.538,623.546,999.136,540.000,990.000,450.000,2},
    {19367,416.614,623.171,1000.873,0.000,-180.000,0.000,2},
    {19367,416.614,626.341,1000.873,0.000,-180.000,0.000,2},
    {19367,418.213,627.912,1000.873,0.000,-180.000,90.000,2},
    {19367,421.353,627.912,1000.873,0.000,-180.000,90.000,2},
    {19367,424.543,627.912,1000.873,0.000,-180.000,90.000,2},
    {19367,426.527,623.140,1000.878,180.000,0.000,180.000,2},
    {19367,426.527,626.320,1000.878,180.000,0.000,180.000,2},
    {19367,427.733,627.912,1000.873,0.000,-180.000,90.000,2},
    {19367,-922.011,597.801,-0.290,0.000,0.000,0.000,2},
    {19367,417.782,616.789,1000.873,0.000,-180.000,0.000,2},
    {19367,417.774,610.177,1000.873,0.000,-180.360,0.000,2},
    {19367,417.787,606.978,1000.873,0.000,-180.360,0.000,2},
    {19367,419.409,605.406,1000.878,-180.000,0.000,270.000,2},
    {19367,422.605,605.411,1000.878,-180.000,0.000,270.000,2},
    {19367,425.797,605.402,1000.878,-180.000,0.000,270.000,2},
    {19367,428.993,605.394,1000.878,-180.000,0.000,270.000,2},
    {19367,417.775,603.989,1000.893,0.000,-180.360,0.000,2},
    {19367,432.202,605.396,1000.878,-180.000,0.000,270.000,2},
    {19367,5829.613,-4209.926,-6659.902,0.000,0.000,0.000,2},
    {19367,5829.613,-4209.926,-6659.902,0.000,0.000,0.000,2},
    {19367,1683.819,-8018.711,-4805.494,0.000,0.000,0.000,2},
    {19367,433.064,0.663,1000.878,-180.000,0.000,270.000,2},
    {19367,431.692,607.110,1000.878,180.000,0.019,180.000,2},
    {19367,431.687,610.299,1000.878,180.000,0.000,180.000,2},
    {1505,8492.210,-2183.372,999.819,0.000,0.000,0.000,2},
    {1505,431.691,611.874,999.168,0.000,0.000,90.000,2},
    {19367,431.695,614.996,1000.878,180.000,0.000,180.000,2},
    {19367,431.699,618.190,1000.878,180.000,0.000,180.000,2},
    {19367,429.800,618.376,1000.878,180.000,0.000,90.000,2},
    {19367,426.595,618.386,1000.878,180.000,0.000,90.000,2},
    {19367,423.400,618.399,1000.878,180.000,0.000,90.000,2},
    {19367,426.527,619.989,1000.878,180.000,0.000,180.000,2},
    {19367,416.614,620.030,1000.873,0.000,-180.000,0.000,2},
    {19367,416.265,618.361,1000.878,180.000,0.000,90.000,2},
    {19367,418.747,618.353,1000.878,180.000,0.000,90.000,2},
    {19367,413.304,618.371,1000.878,180.000,0.000,90.000,2},
    {19367,410.369,618.390,1000.878,180.000,0.000,90.000,2},
    {19367,416.130,606.410,1000.878,180.000,0.000,90.000,2},
    {19367,413.114,606.416,1000.878,180.000,0.000,90.000,2},
    {19367,411.550,607.922,1000.873,0.000,-180.360,0.000,2},
    {19367,411.546,611.113,1000.873,0.000,-180.360,0.000,2},
    {19367,411.545,614.285,1000.873,0.000,-180.360,0.000,2},
    {19367,411.540,617.329,1000.873,0.000,-180.360,0.000,2},
    {19367,417.767,612.095,1000.873,0.000,-180.360,0.000,2},
    {1491,417.780,613.683,999.185,0.000,0.000,90.000,2},
    {1491,420.300,618.362,999.185,0.000,0.000,0.000,2},
    {19367,432.986,618.375,1000.878,180.000,0.000,90.000,2},
    {19367,420.929,618.403,1003.443,180.000,-180.000,-90.000,2},
    {19367,417.728,614.346,1003.417,178.000,180.000,360.000,2},
    {19367,431.165,612.774,1003.317,0.000,-18.360,359.799,2},
    // Big
    {970,1396.816894,1511.817016,14.148458,0.000000,0.000000,0.000000,3},
    {970,1392.625976,1511.817016,14.148458,0.000000,0.000000,0.000000,3},
    {970,1388.425415,1511.817016,14.148458,0.000000,0.000000,0.000000,3},
    {970,1384.225830,1511.817016,14.148458,0.000000,0.000000,0.000000,3},
    {19379,1388.848754,1513.377441,9.872499,0.000000,90.000000,0.000000,3},
    {19379,1388.848754,1523.007690,9.872499,0.000000,90.000000,0.000000,3},
    {19379,1399.318115,1513.377441,9.872499,0.000000,90.000000,0.000000,3},
    {19379,1399.318115,1522.998779,9.872499,0.000000,90.000000,0.000000,3},
    {19449,1383.703491,1513.386108,11.678435,0.000000,0.000000,0.000000,3},
    {19449,1383.703491,1523.005493,11.678435,0.000000,0.000000,0.000000,3},
    {19449,1388.542968,1527.735717,11.678435,0.000000,0.000000,90.000000,3},
    {19449,1398.162963,1527.735717,11.678435,0.000000,0.000000,90.000000,3},
    {19379,1409.817871,1522.998779,9.872499,0.000000,90.000000,0.000000,3},
    {19449,1407.782470,1527.735717,11.678435,0.000000,0.000000,90.000000,3},
    {19379,1409.817749,1513.377441,16.992519,0.000000,90.000000,0.000000,3},
    {19357,1414.204345,1527.735717,11.678435,0.000000,0.000000,90.000000,3},
    {19449,1414.966674,1523.005493,11.678435,0.000000,0.000000,0.000000,3},
    {19449,1414.966674,1513.383422,11.678435,0.000000,0.000000,0.000000,3},
    {19449,1407.782470,1508.654907,11.678435,0.000000,0.000000,90.000000,3},
    {19357,1414.204345,1508.654541,11.678435,0.000000,0.000000,90.000000,3},
    {19449,1398.151000,1508.654907,11.678435,0.000000,0.000000,90.000000,3},
    {19449,1388.539184,1508.654907,11.678435,0.000000,0.000000,90.000000,3},
    {19379,1409.817871,1522.998779,13.512515,0.000000,90.000000,0.000000,3},
    {19379,1399.356567,1522.998779,13.512515,0.000000,90.000000,0.000000,3},
    {19357,1394.183959,1526.056274,11.678435,0.000000,0.000000,0.000000,3},
    {19387,1394.183959,1522.856079,11.678435,0.000000,0.000000,0.000000,3},
    {19449,1394.183959,1516.596801,11.678435,0.000000,0.000000,0.000000,3},
    {1502,1394.128906,1523.636474,9.938437,0.000000,0.000000,-90.000000,3},
    {19357,1399.072998,1518.105712,11.678435,0.000000,0.000000,90.000000,3},
    {19379,1404.155883,1513.388671,13.512515,0.000000,90.000000,0.000000,3},
    {19449,1408.535888,1518.105712,11.678435,0.000000,0.000000,90.000000,3},
    {14414,1397.078125,1509.768432,10.228441,0.000000,0.000000,90.000000,3},
    {19387,1402.253906,1518.116088,11.678435,0.000000,0.000000,90.000000,3},
    {19357,1395.872192,1518.105712,11.678435,0.000000,0.000000,90.000000,3},
    {19387,1402.253906,1510.323974,11.678435,0.000000,0.000000,180.000000,3},
    {19370,1397.156250,1516.577636,13.512515,0.000000,90.000000,0.000000,3},
    {19462,1411.136108,1513.377807,13.512515,0.000000,90.000000,0.000000,3},
    {19462,1414.627563,1513.377807,13.512515,0.000000,90.000000,0.000000,3},
    {19430,1414.133544,1518.105712,11.678435,0.000000,0.000000,-90.000000,3},
    {19357,1400.563964,1511.834960,11.678435,0.000000,0.000000,90.000000,3},
    {19357,1397.354003,1511.885009,11.678435,0.000000,0.000000,90.000000,3},
    {19430,1395.042846,1511.885131,11.678435,0.000000,0.000000,-90.000000,3},
    {19370,1397.156250,1513.406616,13.512515,0.000000,90.000000,0.000000,3},
    {19449,1414.966674,1523.005493,15.168431,0.000000,0.000000,0.000000,3},
    {19449,1414.966674,1513.383422,15.168424,0.000000,0.000000,0.000000,3},
    {19379,1388.866943,1522.998779,13.512515,0.000000,90.000000,0.000000,3},
    {19462,1390.591674,1513.552001,13.512515,0.000000,90.000000,270.000000,3},
    {19462,1390.591674,1517.032836,13.512515,0.000000,90.000000,270.000000,3},
    {19370,1384.045410,1513.406616,13.512515,0.000000,90.000000,0.000000,3},
    {19449,1383.703491,1523.005493,15.168426,0.000000,0.000000,0.000000,3},
    {19449,1383.703491,1513.375122,15.168426,0.000000,0.000000,0.000000,3},
    {19449,1407.782470,1508.654907,15.158441,0.000000,0.000000,90.000000,3},
    {19357,1414.204345,1508.654541,15.158438,0.000000,0.000000,90.000000,3},
    {19449,1398.182006,1508.654907,15.158441,0.000000,0.000000,90.000000,3},
    {19449,1388.591796,1508.654907,15.158441,0.000000,0.000000,90.000000,3},
    {19449,1388.542968,1527.735717,15.168425,0.000000,0.000000,90.000000,3},
    {19449,1398.162231,1527.735717,15.168425,0.000000,0.000000,90.000000,3},
    {19449,1407.793579,1527.735717,15.168425,0.000000,0.000000,90.000000,3},
    {19357,1414.204345,1527.735717,15.168425,0.000000,0.000000,90.000000,3},
    {19379,1388.848754,1513.377441,16.992519,0.000000,90.000000,0.000000,3},
    {19379,1388.848754,1523.007690,16.992519,0.000000,90.000000,0.000000,3},
    {19379,1399.318115,1522.998779,16.992519,0.000000,90.000000,0.000000,3},
    {19379,1399.318115,1513.377441,16.992519,0.000000,90.000000,0.000000,3},
    {19379,1409.817871,1522.998779,16.992519,0.000000,90.000000,0.000000,3},
    {19379,1409.817749,1513.377441,9.872499,0.000000,90.000000,0.000000,3},
    {1502,1403.000488,1518.127197,9.938437,0.000000,0.000000,-180.000000,3},
    {1502,1402.281005,1509.533569,9.938437,0.000000,0.000000,-270.000000,3},
    {19370,1384.044799,1516.577636,13.512515,0.000000,90.000000,0.000000,3},
    {19357,1385.401733,1518.273803,15.178421,0.000000,0.000000,90.000000,3},
    {19387,1388.611816,1518.273803,15.178421,0.000000,0.000000,90.000000,3},
    {19357,1391.822875,1518.273803,15.178421,0.000000,0.000000,90.000000,3},
    {19387,1395.031616,1518.273803,15.178421,0.000000,0.000000,90.000000,3},
    {19357,1401.432861,1518.273803,15.178421,0.000000,0.000000,90.000000,3},
    {19357,1398.232177,1518.273803,15.178421,0.000000,0.000000,90.000000,3},
    {19387,1404.621215,1518.273803,15.178421,0.000000,0.000000,90.000000,3},
    {19357,1407.833740,1518.273803,15.178421,0.000000,0.000000,90.000000,3},
    {19357,1411.033813,1518.273803,15.178421,0.000000,0.000000,90.000000,3},
    {19387,1414.241210,1518.273803,15.178421,0.000000,0.000000,90.000000,3},
    {19449,1393.243164,1523.046752,15.178421,0.000000,0.000000,0.000000,3},
    {19449,1402.263916,1523.046752,15.178421,0.000000,0.000000,0.000000,3},
    {19449,1411.655273,1523.046752,15.178421,0.000000,0.000000,0.000000,3},
    {1502,1389.360107,1518.306274,13.418445,0.000000,0.000000,-180.000000,3},
    {1502,1395.781005,1518.306274,13.418445,0.000000,0.000000,-180.000000,3},
    {1502,1405.360839,1518.306274,13.418445,0.000000,0.000000,-180.000000,3},
    {1502,1414.991333,1518.306274,13.418445,0.000000,0.000000,-180.000000,3},
    {1504,1383.777343,1518.188476,9.948436,0.000000,0.000000,90.000000,3},
    {1504,1383.777343,1518.219482,9.948436,0.000000,0.000000,270.000000,3}
};

enum houseInteriors {
    eHouseInterior,
    Float:eHouseX,
    Float:eHouseY,
    Float:eHouseZ,
    Float:eHouseAngle
};

new const Float:arrHouseInteriors[3][houseInteriors] = {
    {3, 386.9173,633.6785,1009.6749,118.8647},
    {4, 431.2519,612.6088,1000.2219,89.7749},
    {5, 1384.50, 1518.17, 10.95, 270.38}
};

CreateHouseInterior(houseid) {
    new id = cellmin;
    for (new i = 0; i < sizeof(g_aHouseInteriors); i ++) if (g_aHouseInteriors[i][e_Type] == hData[houseid][hType]) {
        id = HouseStructure_Add(houseid, g_aHouseInteriors[i][e_ObjModel], g_aHouseInteriors[i][e_ObjPosX], g_aHouseInteriors[i][e_ObjPosY], g_aHouseInteriors[i][e_ObjPosZ], g_aHouseInteriors[i][e_ObjRotX], g_aHouseInteriors[i][e_ObjRotY], g_aHouseInteriors[i][e_ObjRotZ], 1);

        if (id == cellmin) break;
    }
    return 1;
}

Player_OwnsHouse(playerid, houseid)
{
	if(houseid == -1) return 0;
	if(!IsPlayerConnected(playerid)) return 0;
	if(!strcmp(hData[houseid][hOwner], pData[playerid][pName], true)) return 1;
	return 0;
}

Player_HouseCount(playerid)
{
	#if LIMIT_PER_PLAYER != 0
    new count;
	foreach(new i : Houses)
	{
		if(Player_OwnsHouse(playerid, i)) count++;
	}

	return count;
	#else
	return 0;
	#endif
}

House_IsBuilder(playerid) {
    foreach (new i : Houses) if (hData[i][houseBuilder] == pData[playerid][pID]) {
        return 1;
    }
    return 0;
}

HouseReset(houseid)
{
	format(hData[houseid][hOwner], MAX_PLAYER_NAME, "-");
	hData[houseid][hLocked] = 1;
    hData[houseid][hMoney] = 0;
	hData[houseid][hWeapon] = 0;
	hData[houseid][hAmmo] = 0;
	hData[houseid][hVisit] = 0;
	hData[houseid][housePacket] = 0;
	hData[houseid][hVisit] = 0;
	House_Type(houseid);
	
	for (new i = 0; i < 10; i ++)
    {
        hData[houseid][hWeapon][i] = 0;

		hData[houseid][hAmmo][i] = 0;
    }
}
	
/*GetHouseOwnerID(houseid)
{
	foreach(new i : Player)
	{
		if(!strcmp(hData[houseid][hOwner], pData[i][pName], true)) return i;
	}
	return INVALID_PLAYER_ID;
}*/

HouseTenant_GetCount(hid)
{
	new query[144], Cache: check, count;
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `house_tenant` WHERE `HouseID` = '%d'", hid);
	check = mysql_query(g_SQL, query);
	new result = cache_num_rows();
	if(result) {
		for(new i; i != result; i++) {
			count++;
		}
	}
	cache_delete(check);
	return count;
}

House_IsTenant(playerid, hid) {
	new str[128], Cache: cache;
	format(str, sizeof(str), "SELECT * FROM `house_tenant` WHERE `Name`='%s' AND `HouseID`='%d'", ReturnName(playerid), hid);
	cache = mysql_query(g_SQL, str);
	new result = cache_num_rows();
	cache_delete(cache);
	return result;
}

HouseTenant_Add(playerid, hid)
{
	new str[128];
	format(str, sizeof(str), "INSERT INTO `house_tenant` SET `Name`='%s', `HouseID`='%d', `Time`=UNIX_TIMESTAMP()", ReturnName(playerid), hid);
	mysql_tquery(g_SQL, str);
	return 1;
}

HouseTenant_Remove(id)
{
	new query[200];
	format(query,sizeof(query),"DELETE FROM `house_tenant` WHERE `ID`='%d'", id);
	mysql_tquery(g_SQL, query);
	return 1;
}

HouseTenant_RemoveAll(hid)
{
	new query[200];
	format(query,sizeof(query),"DELETE FROM `house_tenant` WHERE `HouseID`='%d'", hid);
	mysql_tquery(g_SQL, query);
	return 1;
}

House_ShowTenant(playerid, hid, type = 0)
{
	new query[255], Cache: cache;
	format(query, sizeof(query), "SELECT * FROM `house_tenant` WHERE `HouseID`='%d'", hid);
	cache = mysql_query(g_SQL, query);

	if(!cache_num_rows()) return Error(playerid, "There are no one tenant for this house.");
	
	format(query, sizeof(query), "#\tName\tDate Added\n");
	for(new i; i < cache_num_rows(); i++) {
		new biz,
            time,
			name[24];

        cache_get_value_int(i, "ID", biz);
		cache_get_value_int(i, "Time", time);
		cache_get_value(i, "Name", name, sizeof(name));
		format(query, sizeof(query), "%s%d\t%s\t%s\n", query, biz, name, experieddate(time,3));
	}
	if (!type)
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "House Tenant", query, "Close", "");
	else
		Dialog_Show(playerid, House_RemoveTenant, DIALOG_STYLE_TABLIST_HEADERS, "Remove Tenant", query, "Remove", "Close");

	cache_delete(cache);
	return 1;
}

House_WeaponStorage(playerid, houseid)
{
    if(houseid == -1)
        return 0;

    static
        string[320];

    string[0] = 0;

    for (new i = 0; i < 5; i ++)
    {
        if(!hData[houseid][hWeapon][i])
            format(string, sizeof(string), "%sEmpty Slot\n", string);

        else
            format(string, sizeof(string), "%s%s (Ammo: %d)\n", string, ReturnWeaponName(hData[houseid][hWeapon][i]), hData[houseid][hAmmo][i]);
    }
    ShowPlayerDialog(playerid, HOUSE_WEAPONS, DIALOG_STYLE_LIST, "Weapon Storage", string, "Select", "Cancel");
    return 1;
}

House_OpenStorage(playerid, houseid)
{
    if(houseid == -1)
        return 0;

    new
        items[1],
        string[10 * 32];

    for (new i = 0; i < 5; i ++) if(hData[houseid][hWeapon][i]) 
	{
        items[0]++;
    }
    if(!Player_OwnsHouse(playerid, houseid))
        format(string, sizeof(string), "Weapon Storage (%d/5)", items[0]);

    else
        format(string, sizeof(string), "Weapon Storage (%d/5)\nMoney Safe (%s)", items[0], FormatMoney(hData[houseid][hMoney]));

    ShowPlayerDialog(playerid, HOUSE_STORAGE, DIALOG_STYLE_LIST, "House Storage", string, "Select", "Cancel");
    return 1;
}

GetOwnedHouses(playerid)
{
	new tmpcount;
	foreach(new hid : Houses)
	{
	    if(!strcmp(hData[hid][hOwner], pData[playerid][pName], true))
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}
ReturnPlayerHousesID(playerid, hslot)
{
	new tmpcount;
	if(hslot < 1 && hslot > LIMIT_PER_PLAYER) return -1;
	foreach(new hid : Houses)
	{
	    if(!strcmp(pData[playerid][pName], hData[hid][hOwner], true))
	    {
     		tmpcount++;
       		if(tmpcount == hslot)
       		{
        		return hid;
  			}
	    }
	}
	return -1;
}

House_Save(houseid)
{
	new cQuery[1536];
	format(cQuery, sizeof(cQuery), "UPDATE houses SET owner='%s', address='%s', price='%d', type='%d', locked='%d', money='%d'",
	hData[houseid][hOwner],
	hData[houseid][hAddress],
	hData[houseid][hPrice],
	hData[houseid][hType],
	hData[houseid][hLocked],
	hData[houseid][hMoney]
	);
	
	for (new i = 0; i < 10; i ++) 
	{
        format(cQuery, sizeof(cQuery), "%s, houseWeapon%d='%d', houseAmmo%d='%d'", cQuery, i + 1, hData[houseid][hWeapon][i], i + 1, hData[houseid][hAmmo][i]);
    }
	
	format(cQuery, sizeof(cQuery), "%s, houseint='%d', extposx='%f', extposy='%f', extposz='%f', extposa='%f', intposx='%f', intposy='%f', intposz='%f', intposa='%f', visit='%d', houseBuilder = '%d', houseBuilderTime = '%d' WHERE ID='%d'",
        cQuery,
        hData[houseid][hInt],
        hData[houseid][hExtposX],
        hData[houseid][hExtposY],
		hData[houseid][hExtposZ],
		hData[houseid][hExtposA],
		hData[houseid][hIntposX],
		hData[houseid][hIntposY],
		hData[houseid][hIntposZ],
		hData[houseid][hIntposA],
		hData[houseid][hVisit],
		hData[houseid][houseBuilder],
        hData[houseid][houseBuilderTime],
        houseid
    );
	return mysql_tquery(g_SQL, cQuery);
}

House_Type(houseid)
{
	if(hData[houseid][hType] == 1)
	{
	    switch(random(3))
		{
			case 0:
			{
				hData[houseid][hIntposX] = 845.89;
				hData[houseid][hIntposY] = -2048.00;
				hData[houseid][hIntposZ] = 1476.91;
				hData[houseid][hIntposA] = 92.60;
				//hData[houseid][hInt] = 1;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 337.61;
				hData[houseid][hIntposY] = 1854.10;
				hData[houseid][hIntposZ] = 1002.08;
				hData[houseid][hIntposA] = 265.14;
				//hData[houseid][hInt] = 1;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 338.29;
				hData[houseid][hIntposY] = 1794.87;
				hData[houseid][hIntposZ] = 1002.17;
				hData[houseid][hIntposA] = 269.09;
				//hData[houseid][hInt] = 1;
			}
			/*case 0:
			{
				hData[houseid][hIntposX] = 223.32;
				hData[houseid][hIntposY] = 1287.26;
				hData[houseid][hIntposZ] = 1082.14;
				hData[houseid][hIntposA] = 352.43;
				hData[houseid][hInt] = 1;
			}
			case 1:
			{
				hData[houseid][hIntposX] = -68.85;
				hData[houseid][hIntposY] = 1351.42;
				hData[houseid][hIntposZ] = 1080.21;
				hData[houseid][hIntposA] = 358.06;
				hData[houseid][hInt] = 6;
			}
			case 2:
			{
				hData[houseid][hIntposX] = -42.59;
				hData[houseid][hIntposY] = 1405.65;
				hData[houseid][hIntposZ] = 1084.42;
				hData[houseid][hIntposA] = 354.17;
				hData[houseid][hInt] = 8;
			}
			case 3:
			{
				hData[houseid][hIntposX] = 260.82;
				hData[houseid][hIntposY] = 1237.48;
				hData[houseid][hIntposZ] = 1084.25;
				hData[houseid][hIntposA] = 9.24;
				hData[houseid][hInt] = 9;
			}
			case 4:
			{
				hData[houseid][hIntposX] = 22.90;
				hData[houseid][hIntposY] = 1403.32;
				hData[houseid][hIntposZ] = 1084.43;
				hData[houseid][hIntposA] = 0.24;
				hData[houseid][hInt] = 5;
			}
			case 5:
			{
				hData[houseid][hIntposX] = 226.17;
				hData[houseid][hIntposY] = 1239.99;
				hData[houseid][hIntposZ] = 1082.14;
				hData[houseid][hIntposA] = 84.87;
				hData[houseid][hInt] = 2;
			}*/
		}
	}
	if(hData[houseid][hType] == 2)
	{
	    switch(random(3))
		{
			case 0:
			{
				hData[houseid][hIntposX] = 736.03;
				hData[houseid][hIntposY] = 1672.08;
				hData[houseid][hIntposZ] = 501.08;
				hData[houseid][hIntposA] = 356.23;
				//hData[houseid][hInt] = 1;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 338.78;
				hData[houseid][hIntposY] = 1734.95;
				hData[houseid][hIntposZ] = 1002.08;
				hData[houseid][hIntposA] = 268.46;
				//hData[houseid][hInt] = 1;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 351.59;
				hData[houseid][hIntposY] = 1669.31;
				hData[houseid][hIntposZ] = 1002.17;
				hData[houseid][hIntposA] = 176.03;
			//	hData[houseid][hInt] = 1;
			}
			/*case 0:
			{
				hData[houseid][hIntposX] = 235.25;
				hData[houseid][hIntposY] = 1186.68;
				hData[houseid][hIntposZ] = 1080.25;
				hData[houseid][hIntposA] = 10.63;
				hData[houseid][hInt] = 3;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 295.04;
				hData[houseid][hIntposY] = 1472.60;
				hData[houseid][hIntposZ] = 1080.25;
				hData[houseid][hIntposA] = 3.49;
				hData[houseid][hInt] = 15;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 24.13;
				hData[houseid][hIntposY] = 1340.47;
				hData[houseid][hIntposZ] = 1084.37;
				hData[houseid][hIntposA] = 0.72;
				hData[houseid][hInt] = 10;
			}
			case 3:
			{
				hData[houseid][hIntposX] = -260.73;
				hData[houseid][hIntposY] = 1456.78;
				hData[houseid][hIntposZ] = 1084.36;
				hData[houseid][hIntposA] = 97.64;
				hData[houseid][hInt] = 4;
			}
			case 4:
			{
				hData[houseid][hIntposX] = 83.28;
				hData[houseid][hIntposY] = 1322.48;
				hData[houseid][hIntposZ] = 1083.86;
				hData[houseid][hIntposA] = 354.73;
				hData[houseid][hInt] = 9;
			}*/
		}
	}
	if(hData[houseid][hType] == 3)
	{
	    switch(random(4))
		{
			case 0:
			{
				hData[houseid][hIntposX] = 1855.38;
				hData[houseid][hIntposY] = -1709.12;
				hData[houseid][hIntposZ] = 1720.06;
				hData[houseid][hIntposA] = 273.58;
				hData[houseid][hInt] = 1;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 4577.82;
				hData[houseid][hIntposY] = -2527.82;
				hData[houseid][hIntposZ] = 5.28;
				hData[houseid][hIntposA] = 262.63;
				hData[houseid][hInt] = 1;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 1263.68;
				hData[houseid][hIntposY] = -605.30;
				hData[houseid][hIntposZ] = 1001.08;
				hData[houseid][hIntposA] = 189.50;
				hData[houseid][hInt] = 1;
			}
			case 3:
			{
				hData[houseid][hIntposX] = 1224.34;
				hData[houseid][hIntposY] = -749.22;
				hData[houseid][hIntposZ] = 1085.72;
				hData[houseid][hIntposA] = 265.59;
				hData[houseid][hInt] = 1;
			}
			/*case 0:
			{
				hData[houseid][hIntposX] = 226.70;
				hData[houseid][hIntposY] = 1114.22;
				hData[houseid][hIntposZ] = 1080.99;
				hData[houseid][hIntposA] = 267.25;
				hData[houseid][hInt] = 5;
			}
			case 1:
			{
				hData[houseid][hIntposX] = 2323.84;
				hData[houseid][hIntposY] = -1149.33;
				hData[houseid][hIntposZ] = 1050.71;
				hData[houseid][hIntposA] = 8.92;
				hData[houseid][hInt] = 12;
			}
			case 2:
			{
				hData[houseid][hIntposX] = 139.83;
				hData[houseid][hIntposY] = 1366.16;
				hData[houseid][hIntposZ] = 1083.85;
				hData[houseid][hIntposA] = 354.86;
				hData[houseid][hInt] = 5;
			}
			case 3:
			{
				hData[houseid][hIntposX] = 234.04;
				hData[houseid][hIntposY] = 1063.92;
				hData[houseid][hIntposZ] = 1084.21;
				hData[houseid][hIntposA] = 351.12;
				hData[houseid][hInt] = 6;
			}*/
		}
	}
}

House_Refresh(houseid)
{
    if(Iter_Contains(Houses, houseid))
    {
        if(IsValidDynamic3DTextLabel(hData[houseid][hLabel]))
            DestroyDynamic3DTextLabel(hData[houseid][hLabel]);

        if(IsValidDynamicPickup(hData[houseid][hPickup]))
            DestroyDynamicPickup(hData[houseid][hPickup]);
			
		if(IsValidDynamicCP(hData[houseid][hCPExt]))
            DestroyDynamicCP(hData[houseid][hCPExt]);

		if(IsValidDynamicCP(hData[houseid][hCPInt]))
            DestroyDynamicCP(hData[houseid][hCPInt]);

        static
        string[255];
		
		new type[128];
		if(hData[houseid][hType] == 1)
		{
			type= "Small";
		}
		else if(hData[houseid][hType] == 2)
		{
			type= "Medium";
		}
		else if(hData[houseid][hType] == 3)
		{
			type= "Large";
		}
		else
		{
			type= "Unknow";
		}

        if(strcmp(hData[houseid][hOwner], "-"))
		{
			format(string, sizeof(string), "[ID: %d]\n{FFFFFF}House Location: "GRAY"%s\n{FFFFFF}House Type: "GREEN"%s\n"WHITE_E"Owner: "YELLOW"%s", houseid, GetLocation(hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]), type, hData[houseid][hOwner]);
			hData[houseid][hPickup] = CreateDynamicPickup(19132, 23, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]+0.2, 0, 0, _, 10.0);
        }
        else
        {
            format(string, sizeof(string), "[ID: %d]\n{00FF00}This house for sell\n{FFFFFF}House Location: {FFFF00}%s\n{FFFFFF}House Type: {FFFF00}%s\n{FFFFFF}House Price: {FFFF00}%s\n"WHITE_E"Type /buy to purchase", houseid, GetLocation(hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]), type, FormatMoney(hData[houseid][hPrice]));
            hData[houseid][hPickup] = CreateDynamicPickup(19132, 23, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]+0.2, 0, 0, _, 10.0);
        }
		hData[houseid][hCPExt] = CreateDynamicCP(hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ], 1.7, -1, -1, _, 3.0);
		hData[houseid][hCPInt] = CreateDynamicCP(hData[houseid][hIntposX], hData[houseid][hIntposY], hData[houseid][hIntposZ], 1.7, houseid, hData[houseid][hInt], _, 3.0);
		printf("house cp %d %d", hData[houseid][hCPExt], hData[houseid][hCPInt]);
		hData[houseid][hLabel] = CreateDynamic3DTextLabel(string, COLOR_GREY, hData[houseid][hExtposX], hData[houseid][hExtposY], hData[houseid][hExtposZ]+0.5, 2.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
    }
    return 1;
}

function LoadHouses()
{
    static
        str[128],
		hid;
		
	new rows = cache_num_rows(), owner[128], address[128];
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "ID", hid);
			cache_get_value_name(i, "owner", owner);
			format(hData[hid][hOwner], 128, owner);
			cache_get_value_name(i, "address", address);
			format(hData[hid][hAddress], 128, address);
			cache_get_value_name_int(i, "price", hData[hid][hPrice]);
			cache_get_value_name_int(i, "type", hData[hid][hType]);
			cache_get_value_name_float(i, "extposx", hData[hid][hExtposX]);
			cache_get_value_name_float(i, "extposy", hData[hid][hExtposY]);
			cache_get_value_name_float(i, "extposz", hData[hid][hExtposZ]);
			cache_get_value_name_float(i, "extposa", hData[hid][hExtposA]);
			cache_get_value_name_float(i, "intposx", hData[hid][hIntposX]);
			cache_get_value_name_float(i, "intposy", hData[hid][hIntposY]);
			cache_get_value_name_float(i, "intposz", hData[hid][hIntposZ]);
			cache_get_value_name_float(i, "intposa", hData[hid][hIntposA]);
			cache_get_value_name_int(i, "houseint", hData[hid][hInt]);
			cache_get_value_name_int(i, "money", hData[hid][hMoney]);
			cache_get_value_name_int(i, "locked", hData[hid][hLocked]);
			cache_get_value_name_int(i, "visit", hData[hid][hVisit]);
			cache_get_value_name_int(i, "houseBuilder", hData[hid][houseBuilder]);
			cache_get_value_name_int(i, "houseBuilderTime", hData[hid][houseBuilderTime]);

			for (new j = 0; j < 10; j ++)
			{
				format(str, 24, "houseWeapon%d", j + 1);
				cache_get_value_name_int(i, str, hData[hid][hWeapon][j]);

				format(str, 24, "houseAmmo%d", j + 1);
				cache_get_value_name_int(i, str, hData[hid][hAmmo][j]);
			}
			foreach (new j : Houses) {
				format(str, sizeof(str), "SELECT * FROM `housestruct` WHERE `HouseID` = '%d'", hid);
            	mysql_tquery(g_SQL, str, "OnLoadHouseStructure", "d", j);

				format(str, sizeof(str), "SELECT * FROM `furniture` WHERE `ID` = '%d'", hid);
            	mysql_tquery(g_SQL, str, "OnLoadFurniture", "d", j);
			}


			Iter_Add(Houses, hid);
			House_Refresh(hid);
		}
		printf("[Houses] Number of Loaded: %d.", rows);
	}
}

//----------[ House Commands ]--------
//House System
CMD:createhouse(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);
	
	new hid = Iter_Free(Houses), address[128];
	if(hid == -1) return Error(playerid, "You cant create more door!");
	new price, type, query[512];
	if(sscanf(params, "dd", price, type)) return Usage(playerid, "/createhouse [price] [type, 1.small 2.medium 3.Big]");
	format(hData[hid][hOwner], 128, "-");
	GetPlayerPos(playerid, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]);
	GetPlayerFacingAngle(playerid, hData[hid][hExtposA]);
	hData[hid][hPrice] = price;
	hData[hid][hType] = type;
	address = GetLocation(hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]);
	format(hData[hid][hAddress], 128, address);
	hData[hid][hLocked] = 1;
	hData[hid][hMoney] = 0;

	hData[hid][hIntposX] = arrHouseInteriors[type-1][eHouseX];
	hData[hid][hIntposY] = arrHouseInteriors[type-1][eHouseY];
	hData[hid][hIntposZ] = arrHouseInteriors[type-1][eHouseZ];
	hData[hid][hIntposA] = arrHouseInteriors[type-1][eHouseAngle];
	hData[hid][hInt] = arrHouseInteriors[type-1][eHouseInterior];

	hData[hid][hVisit] = 0;
	//House_Type(hid);
	
	for (new i = 0; i < 10; i ++) 
	{
        hData[hid][hWeapon][i] = 0;
        hData[hid][hAmmo][i] = 0;
    }
	Iter_Add(Houses, hid);

	House_Refresh(hid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO houses SET ID='%d', owner='%s', price='%d', type='%d', extposx='%f', extposy='%f', extposz='%f', extposa='%f', address='%s'", hid, hData[hid][hOwner], hData[hid][hPrice], hData[hid][hType], hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ], hData[hid][hExtposA], hData[hid][hAddress]);
	mysql_tquery(g_SQL, query, "OnHousesCreated", "i", hid);
	return 1;
}

function OnHousesCreated(hid)
{
	static id;
	House_Save(hid);
    CreateHouseInterior(hid);
    for (new i = 0; i < sizeof(g_aHouseInteriors); i ++) if (g_aHouseInteriors[i][e_Type] == hData[hid][hType]) {
        if ((id = Iter_Free(HouseStruct[hid])) != cellmin) {
            Iter_Add(HouseStruct[hid], id);
            
            HouseStructure[hid][id][structureModel] = g_aHouseInteriors[i][e_ObjModel];
            HouseStructure[hid][id][structurePos][0] = g_aHouseInteriors[i][e_ObjPosX];
            HouseStructure[hid][id][structurePos][1] = g_aHouseInteriors[i][e_ObjPosY];
            HouseStructure[hid][id][structurePos][2] = g_aHouseInteriors[i][e_ObjPosZ];
            HouseStructure[hid][id][structureRot][0] = g_aHouseInteriors[i][e_ObjRotX];
            HouseStructure[hid][id][structureRot][1] = g_aHouseInteriors[i][e_ObjRotY];
            HouseStructure[hid][id][structureRot][2] = g_aHouseInteriors[i][e_ObjRotZ];
            HouseStructure[hid][id][structureMaterial] = 0;
            HouseStructure[hid][id][structureColor] = 0;
            HouseStructure[hid][id][structureType] = 1;

            HouseStructure_Refresh(id, hid);
            new query[128];
            mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `housestruct` (`HouseID`) VALUES ('%d')", hid);
            mysql_tquery(g_SQL, query, "OnHouseStructureCreated", "dd", id, hid);
        }
    }
	return 1;
}

CMD:gotohouse(playerid, params[])
{
	new hid;
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);
		
	if(sscanf(params, "d", hid))
		return Usage(playerid, "/gotohouse [id]");
	if(!Iter_Contains(Houses, hid)) return Error(playerid, "The doors you specified ID of doesn't exist.");
	SetPlayerPosition(playerid, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ], hData[hid][hExtposA]);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
	SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to house id %d", hid);
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInBiz] = -1;
	return 1;
}

CMD:typehouses(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);
	
	new count = 0;
	foreach(new hid : Houses)
	{
		if(hData[hid][hType] == 1)
		{
			House_Type(hid);
			House_Refresh(hid);
			House_Save(hid);
		}
		if(hData[hid][hType] == 2)
		{
			House_Type(hid);
			House_Refresh(hid);
			House_Save(hid);
		}
		if(hData[hid][hType] == 3)
		{
			House_Type(hid);
			House_Refresh(hid);
			House_Save(hid);
		}
		count++;
	}
	Servers(playerid, "Anda telah me reset house interior type sebanyak %d rumah.", count);
	return 1;
}

CMD:edithouse(playerid, params[])
{
    static
        hid,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", hid, type, string))
    {
        Usage(playerid, "/edithouse [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, interior, locked, owner, price, type, reset, delete");
        return 1;
    }
    if((hid < 0 || hid >= MAX_HOUSES))
        return Error(playerid, "You have specified an invalid ID.");
	if(!Iter_Contains(Houses, hid)) return Error(playerid, "The doors you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]);
		GetPlayerFacingAngle(playerid, hData[hid][hExtposA]);
        House_Save(hid);
		House_Refresh(hid);

        SendAdminMessage(COLOR_LRED, "%s has adjusted the location of house ID: %d.", pData[playerid][pAdminname], hid);
    }
    else if(!strcmp(type, "interior", true))
    {
        GetPlayerPos(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ]);
		GetPlayerFacingAngle(playerid, hData[hid][hIntposA]);
		hData[hid][hInt] = GetPlayerInterior(playerid);

        House_Save(hid);
		House_Refresh(hid);

       /*foreach (new i : Player)
        {
            if(pData[i][pEntrance] == EntranceData[id][entranceID])
            {
                SetPlayerPos(i, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);
                SetPlayerFacingAngle(i, EntranceData[id][entranceInt][3]);

                SetPlayerInterior(i, EntranceData[id][entranceInterior]);
                SetCameraBehindPlayer(i);
            }
        }*/
        SendAdminMessage(X11_TOMATO, "%s has adjusted the interior spawn of house ID: %d.", pData[playerid][pAdminname], hid);
    }
    else if(!strcmp(type, "locked", true))
    {
        new locked;

        if(sscanf(string, "d", locked))
            return Usage(playerid, "/edithouse [id] [locked] [0/1]");

        if(locked < 0 || locked > 1)
            return Error(playerid, "You must specify at least 0 or 1.");

        hData[hid][hLocked] = locked;
        House_Save(hid);
		House_Refresh(hid);

        if(locked) {
            SendAdminMessage(X11_TOMATO, "%s has locked house ID: %d.", pData[playerid][pAdminname], hid);
        }
        else {
            SendAdminMessage(X11_TOMATO, "%s has unlocked house ID: %d.", pData[playerid][pAdminname], hid);
        }
    }
    else if(!strcmp(type, "price", true))
    {
        new price;

        if(sscanf(string, "d", price))
            return Usage(playerid, "/edithouse [id] [Price] [Amount]");

        hData[hid][hPrice] = price;

        House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(X11_TOMATO, "%s has adjusted the price of house ID: %d to %d.", pData[playerid][pAdminname], hid, price);
    }
	else if(!strcmp(type, "type", true))
    {
        new htype;

        if(sscanf(string, "d", htype))
            return Usage(playerid, "/edithouse [id] [Type] [1.small 2.medium 3.Big]");

        hData[hid][hType] = htype;
		House_Type(hid);
        House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(X11_TOMATO, "%s has adjusted the type of house ID: %d to %d.", pData[playerid][pAdminname], hid, htype);
    }
    else if(!strcmp(type, "owner", true))
    {
        new owners[MAX_PLAYER_NAME];

        if(sscanf(string, "s[32]", owners))
            return Usage(playerid, "/edithouse [id] [owner] [player name] (use '-' to no owner)");

        format(hData[hid][hOwner], MAX_PLAYER_NAME, owners);
  
        House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(X11_TOMATO, "%s has adjusted the owner of house ID: %d to %s", pData[playerid][pAdminname], hid, owners);
    }
    else if(!strcmp(type, "reset", true))
    {
        HouseReset(hid);
		House_Save(hid);
		House_Refresh(hid);
        SendAdminMessage(X11_TOMATO, "%s has reset house ID: %d.", pData[playerid][pAdminname], hid);
    }
	else if(!strcmp(type, "delete", true))
	{
		HouseReset(hid);
		
		DestroyDynamic3DTextLabel(hData[hid][hLabel]);
        DestroyDynamicPickup(hData[hid][hPickup]);
        DestroyDynamicCP(hData[hid][hCPExt]);
		DestroyDynamicCP(hData[hid][hCPInt]);
		
		hData[hid][hExtposX] = 0;
		hData[hid][hExtposY] = 0;
		hData[hid][hExtposZ] = 0;
		hData[hid][hExtposA] = 0;
		hData[hid][hPrice] = 0;
		hData[hid][hInt] = 0;
		hData[hid][hIntposX] = 0;
		hData[hid][hIntposY] = 0;
		hData[hid][hIntposZ] = 0;
		hData[hid][hIntposA] = 0;
		hData[hid][hLabel] = Text3D: INVALID_3DTEXT_ID;
		hData[hid][hPickup] = -1;
		hData[hid][hCPExt] = INVALID_STREAMER_ID;
		hData[hid][hCPInt] = INVALID_STREAMER_ID;

		hData[hid][houseBuilder] = 0;
        hData[hid][houseBuilderTime] = 0;

		HouseStructure_DeleteAll(hid);
		
		Iter_Remove(Houses, hid);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM houses WHERE ID=%d", hid);
		mysql_tquery(g_SQL, query);
        SendAdminMessage(X11_TOMATO, "%s has delete house ID: %d.", pData[playerid][pAdminname], hid);
	}
    return 1;
}

/*
CMD:buyhouse(playerid, params[])
{
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtpos][0], hData[hid][hExtpos][1], hData[hid][hExtpos][2]))
		{
			if(hData[hid][hPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this houses.");
			if(strcmp(hData[hid][hOwner], "-")) return Error(playerid, "Someone already owns this house.");
			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 2) return Error(playerid, "You can't buy any more houses.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 3) return Error(playerid, "You can't buy any more houses.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 4) return Error(playerid, "You can't buy any more houses.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more houses.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -hData[hid][hPrice]);
			GetPlayerName(playerid, hData[hid][hOwner], MAX_PLAYER_NAME);
			hData[hid][hVisit] = gettime();
			
			House_Refresh(hid);
			House_Save(hid);
		}
	
	}
	return 1;
}*/
CMD:lockhouse(playerid, params[])
{
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
		{
			if(!Player_OwnsHouse(playerid, hid)) return Error(playerid, "You don't own this house.");
			if(!hData[hid][hLocked])
			{
				hData[hid][hLocked] = 1;
				House_Save(hid);

				InfoTD_MSG(playerid, 4000, "You have ~r~locked~w~ your house!");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
			else
			{
				hData[hid][hLocked] = 0;
				House_Save(hid);

				InfoTD_MSG(playerid, 4000,"You have ~g~unlocked~w~ your house!");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
		}
	}
	return 1;
}

CMD:givehouse(playerid, params[])
{
	new hid, otherid;
	if(sscanf(params, "ud", otherid, hid)) return Usage(playerid, "/givehouse [playerid/name] [id] | /myhouse - for show info");
	if(hid == -1) return Error(playerid, "Invalid id");
	
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");
	
	if(!Player_OwnsHouse(playerid, hid)) return Error(playerid, "You dont own this id house.");
	
	if(pData[otherid][pVip] == 1)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 2) return Error(playerid, "Target player cant own any more houses.");
		#endif
	}
	else if(pData[otherid][pVip] == 2)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 3) return Error(playerid, "Target player cant own any more houses.");
		#endif
	}
	else if(pData[otherid][pVip] == 3)
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 4) return Error(playerid, "Target player cant own any more houses.");
		#endif
	}
	else
	{
		#if LIMIT_PER_PLAYER > 0
		if(Player_HouseCount(otherid) + 1 > 1) return Error(playerid, "Target player cant own any more houses.");
		#endif
	}
	GetPlayerName(otherid, hData[hid][hOwner], MAX_PLAYER_NAME);
	hData[hid][hVisit] = gettime();
	
	House_Refresh(hid);
	House_Save(hid);
	Info(playerid, "Anda memberikan rumah id: %d kepada %s", hid, ReturnName(otherid));
	Info(otherid, "%s memberikan rumah id: %d kepada anda", hid, ReturnName(playerid));
	return 1;
}

CMD:sellhouse(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1395.9802,-29.4111,1013.9901)) return Error(playerid, "Anda harus berada di City Hall!");
	if(GetOwnedHouses(playerid) == -1) return Error(playerid, "You don't have a houses.");
	//if(!Player_OwnsBusiness(playerid, id)) return Error(playerid, "You don't own this business.");
	new hid, _tmpstring[128], count = GetOwnedHouses(playerid), CMDSString[1024];
	CMDSString = "";
	new lock[128];
	Loop(itt, (count + 1), 1)
	{
	    hid = ReturnPlayerHousesID(playerid, itt);
		if(hData[hid][hLocked] == 1)
		{
			lock = "{FF0000}Locked";
		
		}
		else
		{
			lock = "{00FF00}Unlocked";
		}
		if(itt == count)
		{
		    format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s   (%s{FFFF2A})\n", itt, hData[hid][hAddress], lock);
		}
		else format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s  (%s{FFFF2A})\n", itt, hData[hid][hAddress], lock);
		strcat(CMDSString, _tmpstring);
	}
	ShowPlayerDialog(playerid, DIALOG_SELL_HOUSES, DIALOG_STYLE_LIST, "Sell Houses", CMDSString, "Sell", "Cancel");
	return 1;
}

CMD:myhouse(playerid)
{
	if(GetOwnedHouses(playerid) == -1) return Error(playerid, "You don't have a houses.");
	//if(!Player_OwnsBusiness(playerid, id)) return Error(playerid, "You don't own this business.");
	new hid, _tmpstring[128], count = GetOwnedHouses(playerid), CMDSString[1024];
	CMDSString = "";
	new lock[128];
	Loop(itt, (count + 1), 1)
	{
	    hid = ReturnPlayerHousesID(playerid, itt);
		if(hData[hid][hLocked] == 1)
		{
			lock = "{FF0000}Dikunci";
		
		}
		else
		{
			lock = "{00FF00}Dibuka";
		}
		if(itt == count)
		{
		    format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s   (%s)\n", itt, hData[hid][hAddress], lock);
		}
		else format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s  (%s)\n", itt, hData[hid][hAddress], lock);
		strcat(CMDSString, _tmpstring);
	}
	ShowPlayerDialog(playerid, DIALOG_MY_HOUSES, DIALOG_STYLE_LIST, "{FF0000}North Country: {0000FF}Houses", CMDSString, "Select", "Cancel");
	return 1;
}

CMD:hm(playerid, params[])
{
	if(!Player_OwnsHouse(playerid, pData[playerid][pInHouse])) 
		if(pData[playerid][pFaction] != 1)
			return Error(playerid, "Kamu bukan pemilik rumah.");

	Dialog_Show(playerid, HouseMenu, DIALOG_STYLE_TABLIST, "House Menu", "Storage\nAssign Builder\nTenant Management", "Select", "Close");
	//House_OpenStorage(playerid, pData[playerid][pInHouse]);
    return 1;
}

