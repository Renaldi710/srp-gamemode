
//header
#define MAX_BUSAB_VEHICLES 2
#define MAX_BUSCD_VEHICLES 2

new BusABVeh[MAX_BUSAB_VEHICLES];
new BusCDVeh[MAX_BUSCD_VEHICLES];

//Sidejob Bus - ARIWIWIN14
new BusSteps[MAX_PLAYERS][4];
new DialogBus[2] = 0;
new DialogBusCD[2] = 0;
new BusCDSteps[MAX_PLAYERS][4];
new TimerBus[MAX_PLAYERS] = -1;
new BusLaps[MAX_PLAYERS] = -1;

enum busrute {
	bus_rute,
	bus_stop,
	Float:bus_posx,
    Float:bus_posy,
    Float:bus_posz
};

stock const BusRuteAB[][busrute] = {
    //BUS RUTE A
    {1, 0, 1664.8519,-1480.0690,13.3828}, //bus
    {1, 0, 1660.4170,-1442.6373,13.3828}, //bus
    {1, 1, 1696.1937,-1443.2544,13.3828}, //busstop
    {1, 0, 1862.4148,-1467.0056,13.3828}, //bus
    {1, 1, 1991.3264,-1468.0311,13.3906}, //busstop
    {1, 0, 2115.1006,-1462.9398,23.8316}, //bus
    {1, 0, 2115.6057,-1382.0657,23.8281}, //bus
    {1, 0, 2075.3293,-1380.4027,23.8264}, //bus
    {1, 1, 2072.9578,-1202.0762,23.7493}, //busstop
    {1, 0, 2072.5869,-1093.0664,24.8290}, //bus
    {1, 1, 2156.0818,-1118.9518,25.3533}, //busstop
    {1, 0, 2194.3335,-1127.3676,25.0698}, //bus
    {1, 1, 2235.4971,-1140.3053,25.6250}, //busstop
    {1, 0, 2365.3123,-1156.3004,27.4453}, //bus
    {1, 0, 2383.4690,-1176.5262,27.6193}, //bus
    {1, 0, 2543.5842,-1186.4663,59.9982}, //bus
    {1, 1, 2702.3457,-1186.4694,69.2402}, //busstop
    {1, 0, 2719.9509,-1186.3718,69.2362}, //bus
    {1, 0, 2720.0908,-1490.1483,30.2813}, //bus
    {1, 0, 2759.7131,-1490.7689,29.2955}, //bus
    {1, 0, 2870.4841,-1490.7781,10.8262}, //bus
    {1, 1, 2864.1077,-1520.4075,10.8927}, //busstop
    {1, 0, 2821.5530,-1655.0381,10.6953}, //bus
    {1, 1, 2669.6355,-1654.9445,10.6953}, //busstop
    {1, 0, 2640.7769,-1657.0166,10.7264}, //bus
    {1, 0, 2641.0684,-1729.4913,10.7344}, //bus
    {1, 0, 2411.4080,-1728.8491,13.4824}, //bus
    {1, 1, 2411.1963,-1774.1786,13.3906}, //busstop
    {1, 0, 2412.1628,-1969.6499,13.3959}, //bus
    {1, 0, 2211.4736,-1969.7048,13.3324}, //bus
    {1, 1, 2223.3108,-2024.2961,13.3447}, //busstop
    {1, 0, 2411.8184,-2211.9634,24.7268}, //bus
    {1, 1, 2732.5063,-2407.4463,13.4603}, //busstop
    {1, 0, 2750.2061,-2499.4463,13.5382}, //bus
    {1, 0, 2686.2041,-2501.9114,13.5311}, //bus
    {1, 0, 2686.9690,-2402.5898,13.4989}, //bus
    {1, 0, 2560.8062,-2387.2188,13.4688}, //bus
    {1, 0, 2434.3918,-2444.9648,13.4531}, //bus
    {1, 1, 2311.5137,-2323.6960,13.3828}, //busstop
    {1, 0, 2269.8525,-2233.6128,13.5805}, //bus
    {1, 1, 2234.4993,-2198.0586,13.3327}, //busstop
    {1, 0, 2081.3560,-2107.8030,13.3518}, //bus
    {1, 0, 1963.8911,-2107.6436,13.3828}, //bus
    {1, 0, 1963.5741,-1921.3982,13.3828}, //bus
    {1, 1, 1964.2314,-1799.1132,13.3828}, //busstop
    {1, 0, 1929.2683,-1749.9778,13.3828}, //bus
    {1, 0, 1804.0713,-1730.1064,13.3906}, //bus
    {1, 0, 1532.0626,-1729.3407,13.3828}, //bus
    {1, 1, 1534.0341,-1672.2256,13.3828}, //busstop
    {1, 0, 1530.7733,-1594.5035,13.3906}, //bus
    {1, 0, 1660.0977,-1579.5072,13.3906}, //bus
    {1, 0, 1680.7488,-1550.1185,13.3828}, //bus
    {1, 2, 1704.4437,-1517.1609,13.3828}, //busfinish
    //BUS RUTE B
    {2, 0, 1655.7344,-1485.3538,13.3828}, // bus
    {2, 1, 1655.4032,-1565.4762,13.3828}, // busstop
    {2, 0, 1670.7325,-1595.0814,13.3828}, // bus
    {2, 0, 1819.4340,-1613.1931,13.3826}, // bus
    {2, 0, 1819.2643,-1885.2611,13.3893}, // bus
    {2, 1, 1776.3428,-1914.3070,13.3866}, // busstop
    {2, 0, 1792.5007,-1891.8330,13.3985}, // bus
    {2, 0, 1831.3939,-1934.8696,13.3767}, // bus
    {2, 0, 1958.9939,-1934.8496,13.3828}, // bus
    {2, 1, 1958.7129,-2133.0486,13.3828}, // busstop
    {2, 0, 1960.3470,-2164.5239,13.3828}, // bus
    {2, 0, 1673.4492,-2163.4392,18.5600}, // bus
    {2, 0, 1540.0748,-2059.9377,32.2899}, // bus
    {2, 0, 1526.3776,-1870.4814,12.9502}, // bus
    {2, 0, 1365.6886,-1866.8370,12.9509}, // bus
    {2, 1, 1253.8467,-1850.0437,12.9506}, // busstop
    {2, 0, 1064.6333,-1847.8706,12.9660}, // bus
    {2, 1, 875.8144,-1768.4203,12.9505}, // busstop
    {2, 0, 636.0189,-1729.4323,13.3869}, // bus
    {2, 0, 639.5729,-1476.8981,14.0262}, // bus
    {2, 1, 640.3020,-1345.1982,12.9506}, // busstop
    {2, 0, 713.2177,-1121.8778,17.3369}, // bus
    {2, 1, 927.1906,-981.0065,37.7700}, // busstop
    {2, 0, 956.6175,-975.5684,38.4431}, // bus
    {2, 0, 960.4560,-1079.1655,24.5822}, // bus
    {2, 0, 987.5025,-1149.1365,23.4703}, // bus
    {2, 1, 1100.8461,-1151.1061,23.2241}, // busstop
    {2, 0, 1211.4893,-1148.2722,23.0554}, // bus
    {2, 0, 1213.9670,-1268.2590,13.1274}, // bus
    {2, 1, 1193.5088,-1350.9121,12.9689}, // busstop
    {2, 0, 1222.0850,-1407.4750,12.7241}, // bus
    {2, 0, 1359.9766,-1377.8314,13.0471}, // bus
    {2, 1, 1360.0629,-1288.0322,12.8783}, // busstop
    {2, 0, 1359.3790,-1155.8519,23.2212}, // bus
    {2, 0, 1380.2749,-1038.3796,25.8772}, // bus
    {2, 1, 1464.3293,-1036.7314,23.2236}, // busstop
    {2, 0, 1564.6484,-1086.0306,23.0705}, // bus
    {2, 0, 1596.3087,-1163.1663,23.4756}, // bus
    {2, 1, 1646.2555,-1163.3318,23.4657}, // busstop
    {2, 0, 1712.0216,-1175.7394,23.2238}, // bus
    {2, 0, 1712.0302,-1355.3077,12.9471}, // bus
    {2, 0, 1698.7974,-1438.4319,12.9547}, // bus
    {2, 1, 1672.7831,-1438.2915,12.9505}, // busstop
    {2, 0, 1656.2053,-1456.6877,12.9516}, // bus
    {2, 0, 1680.1610,-1550.2164,12.9524}, // bus
    {2, 2, 1702.5800,-1508.6711,12.9570} // busfinish
};

enum busrutecd {
	bus_rute,
	bus_stop,
	Float:bus_posx,
    Float:bus_posy,
    Float:bus_posz
};

stock const BusRuteCD[][busrutecd] = {
    {1, 0, 1789.8038,-1910.2421,13.3965}, // bus
    {1, 0, 1794.6454,-1891.6124,13.4000}, // bus
    {1, 0, 1819.0791,-1903.1943,13.3998}, // bus
    {1, 0, 1839.9869,-1934.6993,13.3769}, // bus
    {1, 1, 2044.1656,-1939.9158,13.3363}, // busstop
    {1, 0, 2084.0276,-1914.5232,13.3828}, // bus
    {1, 1, 2087.9209,-1777.5283,13.3828}, // busstop
    {1, 0, 2110.7065,-1754.8124,13.3984}, // bus
    {1, 0, 2185.0957,-1749.5691,13.3750}, // bus
    {1, 0, 2235.3999,-1734.7627,13.3828}, // bus
    {1, 0, 2320.9644,-1750.1040,13.3813}, // bus
    {1, 1, 2355.8933,-1751.3287,13.3828}, // busstop
    {1, 0, 2415.9995,-1748.6517,13.3828}, // bus
    {1, 0, 2428.6790,-1735.0371,13.4973}, // bus
    {1, 0, 2645.2036,-1730.7228,10.7344}, // bus
    {1, 0, 2644.6743,-1659.6682,10.7106}, // bus
    {1, 0, 2824.1406,-1660.4504,10.6953}, // bus
    {1, 0, 2839.7900,-1595.8273,10.9219}, // bus
    {1, 1, 2865.6421,-1538.3290,10.9219}, // busstop
    {1, 0, 2875.2903,-1383.7513,10.9219}, // bus
    {1, 0, 2842.4414,-1173.2307,24.6340}, // bus
    {1, 0, 2848.1660,-755.3646,10.8203}, // bus
    {1, 0, 2790.7297,-457.4602,10.8203}, // bus
    {1, 0, 2796.2673,-248.0582,10.7128}, // bus
    {1, 0, 2861.7351,-120.0071,22.4277}, // bus
    {1, 0, 2815.0247,46.1301,20.0732}, // bus
    {1, 1, 2498.8999,45.0775,26.3359}, // busstop
    {1, 0, 2391.5015,30.4711,26.3373}, // bus
    {1, 0, 2391.9268,-25.8683,26.3341}, // bus
    {1, 0, 2296.1377,-25.5836,26.3359}, // bus
    {1, 1, 2297.0374,0.0108,26.3359}, // busstop
    {1, 0, 2295.9258,44.0177,26.3359}, // bus
    {1, 0, 1996.9176,42.0685,31.3630}, // bus
    {1, 0, 1530.2184,109.3467,29.5134}, // bus
    {1, 0, 1358.7848,222.2167,19.4063}, // busstop
    {1, 0, 1292.3419,249.3253,19.4092}, // bus
    {1, 0, 1319.3998,315.4232,19.4121}, // bus
    {1, 1, 1247.2976,347.5418,19.4063}, // busstop
    {1, 0, 1219.6003,344.4161,19.4063}, // bus
    {1, 0, 1201.4966,287.2044,19.4063}, // bus
    {1, 0, 1285.5605,247.6544,19.4049}, // bus
    {1, 1, 1252.8479,172.0424,19.4291}, // busstop
    {1, 0, 1246.8007,7.0412,26.9873}, // bus
    {1, 0, 1297.0122,-79.6649,36.5049}, // bus
    {1, 0, 1184.8602,-181.2368,40.0838}, // bus
    {1, 0, 1257.4956,-429.6951,3.9143}, // bus
    {1, 1, 1153.5724,-910.9689,42.6719}, // busstop
    {1, 0, 1181.7842,-952.6616,42.6372}, // bus
    {1, 0, 1361.3503,-948.8843,34.1875}, // bus
    {1, 0, 1351.8397,-1054.0084,26.6219}, // bus
    {1, 0, 1340.3252,-1169.0103,23.7071}, // bus
    {1, 0, 1340.3354,-1383.1633,13.5183}, // bus
    {1, 0, 1335.2676,-1461.5745,13.3828}, // bus
    {1, 1, 1293.9576,-1633.1235,13.3828}, // busstop
    {1, 0, 1295.0951,-1847.2932,13.3828}, // bus
    {1, 0, 1347.7147,-1864.0436,13.3828}, // bus
    {1, 1, 1468.9249,-1875.8187,13.3828}, // busstop
    {1, 0, 1641.0212,-1874.6506,13.3828}, // bus
    {1, 0, 1696.5647,-1814.9302,13.3843}, // bus
    {1, 0, 1819.5455,-1834.6351,13.4141}, // bus
    {1, 2, 1809.3248,-1887.8591,13.4083}, // busfinish
    {2, 0, 1792.3917,-1913.4398,13.3958}, // bus //61
    {2, 0, 1824.1718,-1884.4861,13.3305}, // bus
    {2, 0, 1814.9694,-1829.7550,13.4141}, // bus
    {2, 0, 1687.1064,-1814.4185,13.3828}, // bus
    {2, 0, 1635.0269,-1870.1403,13.3828}, // bus
    {2, 1, 1474.5834,-1868.3545,13.3828}, // busstop
    {2, 0, 1346.7040,-1857.0729,13.3828}, // bus
    {2, 0, 1270.8599,-1840.4575,13.3875}, // bus
    {2, 1, 1246.6869,-1832.2734,13.3969}, // busstop
    {2, 0, 1213.4849,-1843.9089,13.3828}, // bus
    {2, 0, 1064.2153,-1849.9833,13.3984}, // bus
    {2, 0, 1011.5676,-1790.8563,13.9042}, // bus
    {2, 0, 598.1656,-1722.4233,13.6749}, // bus
    {2, 0, 463.4594,-1704.2274,10.9755}, // bus
    {2, 0, 448.2998,-1767.3318,5.4022}, // bus
    {2, 0, 348.0680,-1768.7677,5.0627}, // bus
    {2, 1, 346.1573,-1752.6847,4.4780}, // busstop
    {2, 0, 228.8203,-1729.7861,4.1614}, // bus
    {2, 1, 131.1072,-1716.8644,8.2200}, // busstop
    {2, 0, 147.2711,-1554.0142,10.2428}, // bus
    {2, 0, -146.5194,-1312.0742,2.6953}, // bus
    {2, 0, -120.7932,-1191.2642,2.6953}, // bus
    {2, 1, -96.4038,-1163.3280,2.3731}, // busstop
    {2, 0, -89.6188,-1120.4990,1.0894}, // bus
    {2, 0, -121.5254,-985.9754,25.6876}, // bus
    {2, 0, 41.2090,-632.0195,3.1140}, // bus
    {2, 0, -180.3119,-340.3247,1.0781}, // bus
    {2, 0, -305.5986,-150.0883,1.0781}, // bus
    {2, 0, 135.6575,-213.2567,1.4297}, // bus
    {2, 1, 136.0794,-164.1571,1.4313}, // busstop
    {2, 0, 139.9523,-75.1018,1.4297}, // bus
    {2, 0, 235.2402,-69.2930,1.4234}, // bus
    {2, 1, 235.5847,16.4922,2.4297}, // busstop
    {2, 0, 235.9501,46.0989,2.4297}, // bus
    {2, 0, 519.4582,237.0126,14.3042}, // bus
    {2, 0, 622.8590,323.6433,19.6911}, // bus
    {2, 0, 333.7533,737.9718,10.1398}, // bus
    {2, 0, 178.1719,1149.2686,14.2862}, // bus
    {2, 0, 101.2950,1200.3956,18.7394}, // bus
    {2, 1, -81.0625,1201.3937,19.5938}, // busstop
    {2, 0, -198.2613,1201.0051,19.5938}, // bus
    {2, 1, -198.4955,1068.4492,19.5938}, // busstop
    {2, 0, -198.4193,1020.3553,19.5859}, // bus
    {2, 0, -272.3315,1024.6115,19.5938}, // bus
    {2, 1, -272.9107,1066.8411,19.5938}, // busstop
    {2, 0, -270.6971,1194.0591,19.5938}, // bus
    {2, 0, 115.6576,1195.0753,17.8537}, // bus
    {2, 0, 182.4707,1139.0691,14.4840}, // bus
    {2, 0, 361.0774,681.4902,10.0801}, // bus
    {2, 0, 617.4900,311.7920,19.7045}, // bus
    {2, 0, 509.9776,222.1681,13.4252}, // bus
    {2, 0, 475.3690,-414.7675,28.5962}, // bus
    {2, 0, 638.2377,-421.9430,16.1875}, // bus
    {2, 0, 649.7715,-487.3950,16.1875}, // bus
    {2, 0, 679.3287,-496.2370,16.1864}, // bus
    {2, 1, 679.1948,-574.1946,16.1875}, // busstop
    {2, 0, 679.7988,-732.7595,16.9855}, // bus
    {2, 0, 792.9104,-1035.1078,24.6201}, // bus
    {2, 0, 794.6979,-1307.3857,13.3828}, // bus
    {2, 1, 794.3225,-1360.0281,13.3906}, // busstop
    {2, 0, 815.8316,-1406.6146,13.2476}, // bus
    {2, 1, 1100.5616,-1408.4752,13.460}, // busstop
    {2, 0, 1339.8774,-1408.0970,13.3418}, // bus
    {2, 0, 1320.0614,-1496.6547,13.3828}, // bus
    {2, 0, 1295.1655,-1744.3837,13.3828}, // bus
    {2, 0, 1309.0530,-1854.5619,13.3828}, // bus
    {2, 1, 1589.6437,-1875.6797,13.3828}, // busstop
    {2, 0, 1686.9114,-1858.9540,13.3828}, // bus
    {2, 0, 1701.0665,-1814.4916,13.3680}, // bus
    {2, 0, 1819.7148,-1834.7476,13.4141}, // bus
    {2, 0, 1805.8527,-1887.4204,13.4083}, // bus
    {2, 2, 1778.7081,-1916.0391,13.3884} // busfinish
};

//function

AddBusVehicle()
{
	new strings[212];
	//SIDE JOB BUS VEHICLE
    BusABVeh[0] = AddStaticVehicle(437,1695.269,-1532.492,13.546,359.192,1,1);
	BusABVeh[1] = AddStaticVehicle(437,1694.885,-1499.217,13.546,359.815,1,1);

	for(new x;x<MAX_BUSAB_VEHICLES;x++)
	{
	    format(strings, sizeof(strings), ""GREEN_E"COACH-%d", BusABVeh[x]);
	    SetVehicleNumberPlate(BusABVeh[x], strings);
	    SetVehicleToRespawn(BusABVeh[x]);
	}
	//SIDE JOB BUS VEHICLE
	BusCDVeh[0] = AddStaticVehicle(431, 1802.932, -1930.035, 13.386, 30.789, 1, 1);
    BusCDVeh[1] = AddStaticVehicle(431, 1801.523, -1909.784, 13.396, 28.951, 1, 1);

	for(new x;x<MAX_BUSCD_VEHICLES;x++)
	{
	    format(strings, sizeof(strings), ""GREEN_E"BUS-%d", BusCDVeh[x]);
	    SetVehicleNumberPlate(BusCDVeh[x], strings);
	    SetVehicleToRespawn(BusCDVeh[x]);
	}
}

IsABusABVeh(carid)
{
	for(new v = 0; v < MAX_BUSAB_VEHICLES; v++) {
	    if(carid == BusABVeh[v]) return 1;
	}
	return 0;
}

IsABusCDVeh(carid)
{
	for(new v = 0; v < MAX_BUSCD_VEHICLES; v++) {
	    if(carid == BusCDVeh[v]) return 1;
	}
	return 0;
}

#include <YSI\y_hooks>

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {
	new engine, lights, alarm, doors, bonnet, boot, objective;
	if(IsABusCDVeh(vehicleid) && pData[playerid][pSideJob] == SIDEJOB_BUS_CD) {
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, 0); // ONLY the engine param was changed to VEHICLE_PARAMS_ON (1)
		if(BusCDSteps[playerid][0] > 0) {
			switch(BusRuteCD[BusCDSteps[playerid][0]][bus_stop]) {
				case 0: SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][0]][bus_posx], BusRuteCD[BusCDSteps[playerid][0]][bus_posy], BusRuteCD[BusCDSteps[playerid][0]][bus_posz], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posz], 5);
				case 1: SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][0]][bus_posx], BusRuteCD[BusCDSteps[playerid][0]][bus_posy], BusRuteCD[BusCDSteps[playerid][0]][bus_posz], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posz], 2);
				case 2: SetPlayerRaceCheckpoint(playerid, 1, BusRuteCD[BusCDSteps[playerid][0]][bus_posx], BusRuteCD[BusCDSteps[playerid][0]][bus_posy], BusRuteCD[BusCDSteps[playerid][0]][bus_posz], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posz], 5);
			}
		}
		if(BusCDSteps[playerid][1] > 0) {
			switch(BusRuteCD[BusCDSteps[playerid][1]][bus_stop]) {
				case 0: SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][1]][bus_posx], BusRuteCD[BusCDSteps[playerid][1]][bus_posy], BusRuteCD[BusCDSteps[playerid][1]][bus_posz], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posz], 5);
				case 1: SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][1]][bus_posx], BusRuteCD[BusCDSteps[playerid][1]][bus_posy], BusRuteCD[BusCDSteps[playerid][1]][bus_posz], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posz], 2);
				case 2: SetPlayerRaceCheckpoint(playerid, 1, BusRuteCD[BusCDSteps[playerid][1]][bus_posx], BusRuteCD[BusCDSteps[playerid][1]][bus_posy], BusRuteCD[BusCDSteps[playerid][1]][bus_posz], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posz], 5);
			}
		}
		
	}
	if(IsABusABVeh(vehicleid) && pData[playerid][pSideJob] == SIDEJOB_BUS_AB) {
		if(BusSteps[playerid][0] > 0) {
			switch(BusRuteAB[BusSteps[playerid][0]][bus_stop]) {
				case 0: SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][0]][bus_posx], BusRuteAB[BusSteps[playerid][0]][bus_posy], BusRuteAB[BusSteps[playerid][0]][bus_posz], BusRuteAB[BusSteps[playerid][0]+1][bus_posx], BusRuteAB[BusSteps[playerid][0]+1][bus_posy], BusRuteAB[BusSteps[playerid][0]+1][bus_posz], 5);
				case 1: SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][0]][bus_posx], BusRuteAB[BusSteps[playerid][0]][bus_posy], BusRuteAB[BusSteps[playerid][0]][bus_posz], BusRuteAB[BusSteps[playerid][0]+1][bus_posx], BusRuteAB[BusSteps[playerid][0]+1][bus_posy], BusRuteAB[BusSteps[playerid][0]+1][bus_posz], 2);
				case 2: SetPlayerRaceCheckpoint(playerid, 1, BusRuteAB[BusSteps[playerid][0]][bus_posx], BusRuteAB[BusSteps[playerid][0]][bus_posy], BusRuteAB[BusSteps[playerid][0]][bus_posz], BusRuteAB[BusSteps[playerid][0]+1][bus_posx], BusRuteAB[BusSteps[playerid][0]+1][bus_posy], BusRuteAB[BusSteps[playerid][0]+1][bus_posz], 5);
			}
		}
		else if(BusSteps[playerid][1] > 0) {
			switch(BusRuteAB[BusSteps[playerid][1]][bus_stop]) {
				case 0: SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][1]][bus_posx], BusRuteAB[BusSteps[playerid][1]][bus_posy], BusRuteAB[BusSteps[playerid][1]][bus_posz], BusRuteAB[BusSteps[playerid][1]+1][bus_posx], BusRuteAB[BusSteps[playerid][1]+1][bus_posy], BusRuteAB[BusSteps[playerid][1]+1][bus_posz], 5);
				case 1: SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][1]][bus_posx], BusRuteAB[BusSteps[playerid][1]][bus_posy], BusRuteAB[BusSteps[playerid][1]][bus_posz], BusRuteAB[BusSteps[playerid][1]+1][bus_posx], BusRuteAB[BusSteps[playerid][1]+1][bus_posy], BusRuteAB[BusSteps[playerid][1]+1][bus_posz], 2);
				case 2: SetPlayerRaceCheckpoint(playerid, 1, BusRuteAB[BusSteps[playerid][1]][bus_posx], BusRuteAB[BusSteps[playerid][1]][bus_posy], BusRuteAB[BusSteps[playerid][1]][bus_posz], BusRuteAB[BusSteps[playerid][1]+1][bus_posx], BusRuteAB[BusSteps[playerid][1]+1][bus_posy], BusRuteAB[BusSteps[playerid][1]+1][bus_posz], 5);
			}
		}
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, 0); // ONLY the engine param was changed to VEHICLE_PARAMS_ON (1)
		
	}
	return 1;
}


hook OnPlayerStateChange(playerid, newstate, oldstate) {
	if(oldstate == PLAYER_STATE_DRIVER) {
		if(IsABusABVeh(pData[playerid][pSideJobVeh]) && pData[playerid][pSideJob] == SIDEJOB_BUS_AB) {
			TimerBus[playerid] = 31;
			SetVehicleParamsForPlayer(pData[playerid][pSideJobVeh],playerid,1,0);
			return 1;
		}
		if(IsABusCDVeh(pData[playerid][pSideJobVeh]) && pData[playerid][pSideJob] == SIDEJOB_BUS_CD) {
			TimerBus[playerid] = 31;
			SetVehicleParamsForPlayer(pData[playerid][pSideJobVeh],playerid,1,0);
			return 1;
		}
	}
	if(newstate == PLAYER_STATE_DRIVER && newstate != PLAYER_STATE_PASSENGER) {
		if(IsABusCDVeh(GetPlayerVehicleID(playerid)) && pData[playerid][pSideJob] == SIDEJOB_NONE)
		{
			new String[212], S3MP4K[212];
			if(pData[playerid][pBusTime] == 0)
			{
				strcat(S3MP4K, "Route\tPayout\n");
				format(String, sizeof(String), "{7fffd4}Route C: Palomino - Montgomery\t$5,000\n");
				strcat(S3MP4K, String);
				format(String, sizeof(String), "{7fffd4}Route D: Blueberry - Flint Country\t$5,000\n");
				strcat(S3MP4K, String);
				Dialog_Show(playerid, DialogBusCD, DIALOG_STYLE_TABLIST_HEADERS, "SIDEJOB: Bus Driver", S3MP4K, "Select", "Cancel");
			}
			else
			{
				format(String, sizeof(String),"ERROR: Kamu harus menunggu %d Menit untuk menjadi Bus Driver", pData[playerid][pBusTime]/60);
				SendClientMessage(playerid, COLOR_GREY, String);
				RemovePlayerFromVehicle(playerid);		
			}
		}
		if(IsABusABVeh(GetPlayerVehicleID(playerid)) && pData[playerid][pSideJob] == SIDEJOB_NONE)
		{
			new String[212], S3MP4K[212];
			if(pData[playerid][pBusTime] == 0)
			{
				strcat(S3MP4K, "Route\tPayout\n");
				format(String, sizeof(String), "{7fffd4}Route A: Los Santos East\t{33AA33}$4,500\n");
				strcat(S3MP4K, String);
				format(String, sizeof(String), "{7fffd4}Route B: Los Santos West\t{33AA33}$4,500\n");
				strcat(S3MP4K, String);
				Dialog_Show(playerid, DialogBusAB, DIALOG_STYLE_TABLIST_HEADERS, "SIDEJOB: Bus Driver", S3MP4K, "Select", "Cancel");
			}
			else
			{
				format(String, sizeof(String),"ERROR: Kamu harus menunggu %d Menit untuk menjadi Bus Driver", pData[playerid][pBusTime]/60);
				SendClientMessage(playerid, COLOR_GREY, String);
				RemovePlayerFromVehicle(playerid);		
			}
		}
	}
	return 1;
}

hook OnPlayerLeaveRaceCp(playerid)
{
	if(pData[playerid][pSideJob] == SIDEJOB_BUS_AB) {
        if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 437) if(IsPlayerInAnyVehicle(playerid)) {
			if(BusRuteAB[BusSteps[playerid][0]][bus_rute] == 1 && BusRuteAB[BusSteps[playerid][0]][bus_stop] == 1) pData[playerid][pBusWaiting] = -1;
			if(BusRuteAB[BusSteps[playerid][1]][bus_rute] == 2 && BusRuteAB[BusSteps[playerid][1]][bus_stop] == 1) pData[playerid][pBusWaiting] = -1;
		}
    }
	if(pData[playerid][pSideJob] == SIDEJOB_BUS_CD) {
		if(IsPlayerInAnyVehicle(playerid)) {
			if(BusRuteCD[BusCDSteps[playerid][0]][bus_rute] == 1 && BusRuteCD[BusCDSteps[playerid][0]][bus_stop] == 1) pData[playerid][pBusWaiting] = -1;
			if(BusRuteCD[BusCDSteps[playerid][1]][bus_rute] == 2 && BusRuteCD[BusCDSteps[playerid][1]][bus_stop] == 1) pData[playerid][pBusWaiting] = -1;
		}
	}
	return 1;
}

hook OnPlayerEnterRaceCP(playerid) {
    if(pData[playerid][pSideJob] == SIDEJOB_BUS_AB) {
        if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 437)
        {
			if(BusSteps[playerid][0]) {
				//BUSAB RUTE A
				if(BusRuteAB[BusSteps[playerid][0]][bus_rute] == 1 && BusRuteAB[BusSteps[playerid][0]][bus_stop] == 0)
				{
					PlayerPlaySound(playerid, 1056, 0, 0, 0);
					BusSteps[playerid][0]++;
					switch(BusRuteAB[BusSteps[playerid][0]][bus_stop]) {
						case 0: SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][0]][bus_posx], BusRuteAB[BusSteps[playerid][0]][bus_posy], BusRuteAB[BusSteps[playerid][0]][bus_posz], BusRuteAB[BusSteps[playerid][0]+1][bus_posx], BusRuteAB[BusSteps[playerid][0]+1][bus_posy], BusRuteAB[BusSteps[playerid][0]+1][bus_posz], 5);
						case 1: SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][0]][bus_posx], BusRuteAB[BusSteps[playerid][0]][bus_posy], BusRuteAB[BusSteps[playerid][0]][bus_posz], BusRuteAB[BusSteps[playerid][0]+1][bus_posx], BusRuteAB[BusSteps[playerid][0]+1][bus_posy], BusRuteAB[BusSteps[playerid][0]+1][bus_posz], 2);
						case 2: SetPlayerRaceCheckpoint(playerid, 1, BusRuteAB[BusSteps[playerid][0]][bus_posx], BusRuteAB[BusSteps[playerid][0]][bus_posy], BusRuteAB[BusSteps[playerid][0]][bus_posz], BusRuteAB[BusSteps[playerid][0]+1][bus_posx], BusRuteAB[BusSteps[playerid][0]+1][bus_posy], BusRuteAB[BusSteps[playerid][0]+1][bus_posz], 5);
					}
					return 1;
				}
				else if(BusRuteAB[BusSteps[playerid][0]][bus_rute] == 1 && BusRuteAB[BusSteps[playerid][0]][bus_stop] == 1) pData[playerid][pBusWaiting] = 16;
				else if(BusRuteAB[BusSteps[playerid][0]][bus_rute] == 1 && BusRuteAB[BusSteps[playerid][0]][bus_stop] == 2)
				{
					if(BusLaps[playerid] < 3) {
						TogglePlayerControllable(playerid, 0);
						new str[212];
						format(str, sizeof(str), "You have finished %d out of 3 possible laps\nWould you like to continue the next lap?", BusLaps[playerid]);
						Dialog_Show(playerid, ContinueBusA, DIALOG_STYLE_MSGBOX, "Bus Driver: Continue lap?", str, "Continue", "Finish");
					}
					else {
						Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$4,500 {FFFFFF}for finising a bus route lap!");
						GivePlayerMoneyEx(playerid, 4500);
						BusLaps[playerid] = -1;
						pData[playerid][pBusTime] = 2500;
						DisablePlayerRaceCheckpoint(playerid);
						SetVehicleToRespawn(GetPlayerVehicleID(playerid));
						pData[playerid][pSideJob] = SIDEJOB_NONE;
						BusSteps[playerid][0] = 0;
						DialogBus[0]--; // Dialog 0 telah di pilih
						DialogSaya[playerid][0] = false;
					}
					return 1;
				}
			}
			else if(BusSteps[playerid][1]) {
				//BUSAB RUTE B
				if(BusRuteAB[BusSteps[playerid][1]][bus_rute] == 2 && BusRuteAB[BusSteps[playerid][1]][bus_stop] == 0)
				{
					PlayerPlaySound(playerid, 1056, 0, 0, 0);
					BusSteps[playerid][1]++;
					switch(BusRuteAB[BusSteps[playerid][1]][bus_stop]) {
						case 0: SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][1]][bus_posx], BusRuteAB[BusSteps[playerid][1]][bus_posy], BusRuteAB[BusSteps[playerid][1]][bus_posz], BusRuteAB[BusSteps[playerid][1]+1][bus_posx], BusRuteAB[BusSteps[playerid][1]+1][bus_posy], BusRuteAB[BusSteps[playerid][1]+1][bus_posz], 5);
						case 1: SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][1]][bus_posx], BusRuteAB[BusSteps[playerid][1]][bus_posy], BusRuteAB[BusSteps[playerid][1]][bus_posz], BusRuteAB[BusSteps[playerid][1]+1][bus_posx], BusRuteAB[BusSteps[playerid][1]+1][bus_posy], BusRuteAB[BusSteps[playerid][1]+1][bus_posz], 2);
						case 2: SetPlayerRaceCheckpoint(playerid, 1, BusRuteAB[BusSteps[playerid][1]][bus_posx], BusRuteAB[BusSteps[playerid][1]][bus_posy], BusRuteAB[BusSteps[playerid][1]][bus_posz], BusRuteAB[BusSteps[playerid][1]+1][bus_posx], BusRuteAB[BusSteps[playerid][1]+1][bus_posy], BusRuteAB[BusSteps[playerid][1]+1][bus_posz], 5);
					}
					return 1;
				}
				else if(BusRuteAB[BusSteps[playerid][1]][bus_rute] == 2 && BusRuteAB[BusSteps[playerid][1]][bus_stop] == 1) pData[playerid][pBusWaiting] = 16;
				else if(BusRuteAB[BusSteps[playerid][1]][bus_rute] == 2 && BusRuteAB[BusSteps[playerid][1]][bus_stop] == 2)
				{
					if(BusLaps[playerid] < 3) {
						TogglePlayerControllable(playerid, 0);
						new str[212];
						format(str, sizeof(str), "You have finished %d out of 3 possible laps\nWould you like to continue the next lap?", BusLaps[playerid]);
						Dialog_Show(playerid, ContinueBusB, DIALOG_STYLE_MSGBOX, "Bus Driver: Continue lap?", str, "Continue", "Finish");
					}
					else {
						Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$4,500 {FFFFFF}for finising a bus route lap!");
						GivePlayerMoneyEx(playerid, 4500);
						BusLaps[playerid] = -1;
						pData[playerid][pBusTime] = 2500;
						DisablePlayerRaceCheckpoint(playerid);
						SetVehicleToRespawn(GetPlayerVehicleID(playerid));
						pData[playerid][pSideJob] = SIDEJOB_NONE;
						BusSteps[playerid][1] = 0;
						DialogBus[1]--; // Dialog 0 telah di pilih
						DialogSaya[playerid][0] = false;
					}
					return 1;
				}
			}
        }
    }
    if(pData[playerid][pSideJob] == SIDEJOB_BUS_CD) {
        if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 431)
        {
            if(IsPlayerInAnyVehicle(playerid))
            {
                if(BusCDSteps[playerid][0]) {
					//BUSCD RUTE A
					if(BusRuteCD[BusCDSteps[playerid][0]][bus_rute] == 1 && BusRuteCD[BusCDSteps[playerid][0]][bus_stop] == 0)
					{
						PlayerPlaySound(playerid, 1056, 0, 0, 0);
						BusCDSteps[playerid][0]++;
						switch(BusRuteCD[BusCDSteps[playerid][0]][bus_stop]) {
							case 0: SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][0]][bus_posx], BusRuteCD[BusCDSteps[playerid][0]][bus_posy], BusRuteCD[BusCDSteps[playerid][0]][bus_posz], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posz], 5);
							case 1: SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][0]][bus_posx], BusRuteCD[BusCDSteps[playerid][0]][bus_posy], BusRuteCD[BusCDSteps[playerid][0]][bus_posz], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posz], 2);
							case 2: SetPlayerRaceCheckpoint(playerid, 1, BusRuteCD[BusCDSteps[playerid][0]][bus_posx], BusRuteCD[BusCDSteps[playerid][0]][bus_posy], BusRuteCD[BusCDSteps[playerid][0]][bus_posz], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posz], 5);
						}
						return 1;
					}
					else if(BusRuteCD[BusCDSteps[playerid][0]][bus_rute] == 1 && BusRuteCD[BusCDSteps[playerid][0]][bus_stop] == 1) pData[playerid][pBusWaiting] = 31;
					else if(BusRuteCD[BusCDSteps[playerid][0]][bus_rute] == 1 && BusRuteCD[BusCDSteps[playerid][0]][bus_stop] == 2)
					{
						if(BusLaps[playerid] < 2) {
							TogglePlayerControllable(playerid, 0);
							new str[212];
							format(str, sizeof(str), "You have finished %d out of 2 possible laps\nWould you like to continue the next lap?", BusLaps[playerid]);
							Dialog_Show(playerid, ContinueBusC, DIALOG_STYLE_MSGBOX, "Bus Driver: Continue lap?", str, "Continue", "Finish");
						}
						else {
							Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$5,000 {FFFFFF}for finising a bus route lap!");
							GivePlayerMoneyEx(playerid, 5000);
							pData[playerid][pBusTime] = 2500;
							DisablePlayerRaceCheckpoint(playerid);
							SetVehicleToRespawn(GetPlayerVehicleID(playerid));
							pData[playerid][pSideJob] = SIDEJOB_NONE;
							BusCDSteps[playerid][0] = 0;
							DialogBusCD[0]--; // Dialog 0 telah di pilih
							DialogSaya[playerid][0] = false;
						}
						return 1;
					}
				}
				if(BusCDSteps[playerid][1]) {
					//BUSCD RUTE A
					if(BusRuteCD[BusCDSteps[playerid][1]][bus_rute] == 2 && BusRuteCD[BusCDSteps[playerid][1]][bus_stop] == 0)
					{
						PlayerPlaySound(playerid, 1056, 0, 0, 0);
						BusCDSteps[playerid][1]++;
						switch(BusRuteCD[BusCDSteps[playerid][1]][bus_stop]) {
							case 0: SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][1]][bus_posx], BusRuteCD[BusCDSteps[playerid][1]][bus_posy], BusRuteCD[BusCDSteps[playerid][1]][bus_posz], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posz], 5);
							case 1: SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][1]][bus_posx], BusRuteCD[BusCDSteps[playerid][1]][bus_posy], BusRuteCD[BusCDSteps[playerid][1]][bus_posz], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posz], 2);
							case 2: SetPlayerRaceCheckpoint(playerid, 1, BusRuteCD[BusCDSteps[playerid][1]][bus_posx], BusRuteCD[BusCDSteps[playerid][1]][bus_posy], BusRuteCD[BusCDSteps[playerid][1]][bus_posz], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posz], 5);
						}
						return 1;
					}
					else if(BusRuteCD[BusCDSteps[playerid][1]][bus_rute] == 2 && BusRuteCD[BusCDSteps[playerid][1]][bus_stop] == 1) pData[playerid][pBusWaiting] = 31;
					else if(BusRuteCD[BusCDSteps[playerid][1]][bus_rute] == 2 && BusRuteCD[BusCDSteps[playerid][1]][bus_stop] == 2)
					{
						if(BusLaps[playerid] < 2) {
							TogglePlayerControllable(playerid, 0);
							new str[212];
							format(str, sizeof(str), "You have finished %d out of 2 possible laps\nWould you like to continue the next lap?", BusLaps[playerid]);
							Dialog_Show(playerid, ContinueBusD, DIALOG_STYLE_MSGBOX, "Bus Driver: Continue lap?", str, "Continue", "Finish");
						}
						else {
							Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$5,000 {FFFFFF}for finising a bus route lap!");
							GivePlayerMoneyEx(playerid, 5000);
							pData[playerid][pBusTime] = 2500;
							DisablePlayerRaceCheckpoint(playerid);
							SetVehicleToRespawn(GetPlayerVehicleID(playerid));
							pData[playerid][pSideJob] = SIDEJOB_NONE;
							BusCDSteps[playerid][1] = 0;
							DialogBusCD[1]--; // Dialog 0 telah di pilih
							DialogSaya[playerid][0] = false;
						}
						return 1;
					}
				}
            }
        }
    }
    return 1;
}

//dialog

Dialog:DialogBusAB(playerid, response, listitem, inputtext[]) {
    if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				if(pData[playerid][pBusTime] == 0)
				{
					if(DialogBus[0] < 2) // Kalau False atau tidak dipilih
					{
						DialogBus[0]++; // Dialog 0 telah di pilih
						DialogSaya[playerid][0] = true;
						BusSteps[playerid][0] = 1;
						pData[playerid][pSideJob] = SIDEJOB_BUS_AB;
						pData[playerid][pSideJobVeh] = GetPlayerVehicleID(playerid);
						BusLaps[playerid] = 1;
						ChangeVehicleColor(GetPlayerVehicleID(playerid), 2, 2);
						SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][0]-1][bus_posx], BusRuteAB[BusSteps[playerid][0]-1][bus_posy], BusRuteAB[BusSteps[playerid][0]-1][bus_posz], BusRuteAB[BusSteps[playerid][0]][bus_posx], BusRuteAB[BusSteps[playerid][0]][bus_posy], BusRuteAB[BusSteps[playerid][0]][bus_posz], 5);
						SendClientMessage(playerid, ARWIN, "SIDEJOB: {FFFFFF}You've started working as a Bus Driver, please follow the checkpoint");
					}
					else return SendClientMessage(playerid,-1,"ERROR: Route already taken by Someone");
				}
			}
			case 1: {
				if(pData[playerid][pBusTime] == 0)
				{
					if(DialogBus[1] < 2) // Kalau False atau tidak dipilih
					{
						DialogBus[1]++; // Dialog 0 telah di pilih
						DialogSaya[playerid][0] = true;
						BusSteps[playerid][1] = 53;
						pData[playerid][pSideJob] = SIDEJOB_BUS_AB;
						pData[playerid][pSideJobVeh] = GetPlayerVehicleID(playerid);
						BusLaps[playerid] = 1;
						ChangeVehicleColor(GetPlayerVehicleID(playerid), 3, 3);
						if(BusRuteAB[BusSteps[playerid][1]][bus_rute] == 2) {
							SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][1]][bus_posx], BusRuteAB[BusSteps[playerid][1]][bus_posy], BusRuteAB[BusSteps[playerid][1]][bus_posz], BusRuteAB[BusSteps[playerid][1]+1][bus_posx], BusRuteAB[BusSteps[playerid][1]+1][bus_posy], BusRuteAB[BusSteps[playerid][1]+1][bus_posz], 5);
						}
						SendClientMessage(playerid, ARWIN, "SIDEJOB: {FFFFFF}You've started working as a Bus Driver, please follow the checkpoint");
					}
					else return SendClientMessage(playerid,-1, "ERROR: Route already taken by Someone");
				}
			}
		}
	}
	else {
		SetVehicleToRespawn(pData[playerid][pSideJobVeh]);
	}
    return 1;
}

Dialog:DialogBusCD(playerid, response, listitem, inputtext[]) {
    if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				if(pData[playerid][pBusTime] == 0)
				{
					if(DialogBusCD[0] < 2) // Kalau False atau tidak dipilih
					{
						DialogBusCD[0]++; // Dialog 0 telah di pilih
						DialogSaya[playerid][0] = true;
						BusCDSteps[playerid][0] = 1;
						pData[playerid][pSideJob] = SIDEJOB_BUS_CD;
						pData[playerid][pSideJobVeh] = GetPlayerVehicleID(playerid);
						BusLaps[playerid] = 1;
                        ChangeVehicleColor(GetPlayerVehicleID(playerid), 128, 128);
						if(BusRuteCD[BusCDSteps[playerid][0]][bus_rute] == 1) {
							SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][0]][bus_posx], BusRuteCD[BusCDSteps[playerid][0]][bus_posy], BusRuteCD[BusCDSteps[playerid][0]][bus_posz], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posz], 5);
						}
						SendClientMessage(playerid, ARWIN, "SIDEJOB: {FFFFFF}You've started working as a Bus Driver, please follow the checkpoint");
					}
					else{
						SendClientMessage(playerid,-1, "ERROR: Route already taken by Someone");
						return 1;
					}
				}
			}
			case 1:
			{
				if(pData[playerid][pBusTime] == 0)
				{
					if(DialogBusCD[1] < 2) // Kalau False atau tidak dipilih
					{
						DialogBusCD[1]++; // Dialog 0 telah di pilih
						DialogSaya[playerid][0] = true;
						BusCDSteps[playerid][1] = 61;
						pData[playerid][pSideJob] = SIDEJOB_BUS_CD;
						pData[playerid][pSideJobVeh] = GetPlayerVehicleID(playerid);
						BusLaps[playerid] = 1;
                        ChangeVehicleColor(GetPlayerVehicleID(playerid), 211, 211);
						if(BusRuteCD[BusCDSteps[playerid][1]][bus_rute] == 2) {
							SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][1]][bus_posx], BusRuteCD[BusCDSteps[playerid][1]][bus_posy], BusRuteCD[BusCDSteps[playerid][1]][bus_posz], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posz], 5);
						}
						SendClientMessage(playerid, ARWIN, "SIDEJOB: {FFFFFF}You've started working as a Bus Driver, please follow the checkpoint");
					}
					else{
						SendClientMessage(playerid,-1, "ERROR: Route already taken by Someone");
						return 1;
					}
				}
			}
		}
	}
	else {
		if(IsValidVehicle(pData[playerid][pSideJobVeh]))
			SetVehicleToRespawn(pData[playerid][pSideJobVeh]);

		pData[playerid][pSideJobVeh] = INVALID_VEHICLE_ID;
	}
    return 1;
}
  
Dialog:ContinueBusA(playerid, response, listitem, inputtext[]) {
    if(response) { 
		TogglePlayerControllable(playerid, 1);
		BusLaps[playerid]++;
		BusSteps[playerid][0] = 1;
		Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$6,000 {FFFFFF}for finising a bus route lap!");
		GivePlayerMoneyEx(playerid, 6000);
		SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][0]-1][bus_posx], BusRuteAB[BusSteps[playerid][0]-1][bus_posy], BusRuteAB[BusSteps[playerid][0]-1][bus_posz], BusRuteAB[BusSteps[playerid][0]][bus_posx], BusRuteAB[BusSteps[playerid][0]][bus_posy], BusRuteAB[BusSteps[playerid][0]][bus_posz], 5);
	}
	else {
		TogglePlayerControllable(playerid, 1);
		Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$5,000 {FFFFFF}for finising a bus route lap!");
		GivePlayerMoneyEx(playerid, 5000);
		pData[playerid][pBusTime] = 2500;
		DisablePlayerRaceCheckpoint(playerid);
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		BusLaps[playerid] = -1;
		pData[playerid][pSideJob] = SIDEJOB_NONE;
		pData[playerid][pSideJobVeh] = INVALID_VEHICLE_ID;
		BusSteps[playerid][0] = 0;
		DialogBus[0]--; // Dialog 0 telah di pilih
		DialogSaya[playerid][0] = false;
		return 1;
	}
    return 1;
}
  
Dialog:ContinueBusB(playerid, response, listitem, inputtext[]) {
    if(response) { 
		TogglePlayerControllable(playerid, 1);
		BusLaps[playerid]++;
		BusSteps[playerid][1] = 53;
		Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$5,000 {FFFFFF}for finising a bus route lap!");
		GivePlayerMoneyEx(playerid, 5000);
		SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][1]][bus_posx], BusRuteAB[BusSteps[playerid][1]][bus_posy], BusRuteAB[BusSteps[playerid][1]+1][bus_posz], BusRuteAB[BusSteps[playerid][1]+1][bus_posx], BusRuteAB[BusSteps[playerid][1]+1][bus_posy], BusRuteAB[BusSteps[playerid][1]][bus_posz], 5);
	}
	else {
		TogglePlayerControllable(playerid, 1);
		Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$4,500 {FFFFFF}for finising a bus route lap!");
		GivePlayerMoneyEx(playerid, 4500);
		BusLaps[playerid] = -1;
		pData[playerid][pBusTime] = 2500;
		DisablePlayerRaceCheckpoint(playerid);
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		pData[playerid][pSideJob] = SIDEJOB_NONE;
		pData[playerid][pSideJobVeh] = INVALID_VEHICLE_ID;
		BusSteps[playerid][1] = 0;
		DialogBus[0]--; // Dialog 0 telah di pilih
		DialogSaya[playerid][0] = false;
		return 1;
	}
    return 1;
}

Dialog:ContinueBusC(playerid, response, listitem, inputtext[]) {
    if(response) { 
		TogglePlayerControllable(playerid, 1);
		BusLaps[playerid]++;
		Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$850 {FFFFFF}for finising a bus route lap!");
		GivePlayerMoneyEx(playerid, 850);
		BusCDSteps[playerid][0] = 1;
		if(BusRuteCD[BusCDSteps[playerid][0]][bus_rute] == 1) {
			SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][0]][bus_posx], BusRuteCD[BusCDSteps[playerid][0]][bus_posy], BusRuteCD[BusCDSteps[playerid][0]][bus_posz], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posz], 5);
		}
	}
	else {
		TogglePlayerControllable(playerid, 1);
		Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$850 {FFFFFF}for finising a bus route lap!");
		GivePlayerMoneyEx(playerid, 850);
		pData[playerid][pBusTime] = 2500;
		DisablePlayerRaceCheckpoint(playerid);
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		pData[playerid][pSideJob] = SIDEJOB_NONE;
		pData[playerid][pSideJobVeh] = INVALID_VEHICLE_ID;
		BusCDSteps[playerid][0] = 0;
		DialogBusCD[0]--; // Dialog 0 telah di pilih
		DialogSaya[playerid][0] = false;
		return 1;
	}
    return 1;
}
  
Dialog:ContinueBusD(playerid, response, listitem, inputtext[]) {
    if(response) { 
		TogglePlayerControllable(playerid, 1);
		BusLaps[playerid]++;
		Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$1,000 {FFFFFF}for finising a bus route lap!");
		GivePlayerMoneyEx(playerid, 1000);
		BusCDSteps[playerid][0] = 1;
		if(BusRuteCD[BusCDSteps[playerid][0]][bus_rute] == 1) {
			SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][0]][bus_posx], BusRuteCD[BusCDSteps[playerid][0]][bus_posy], BusRuteCD[BusCDSteps[playerid][0]][bus_posz], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posz], 5);
		}
	}
	else {
		TogglePlayerControllable(playerid, 1);
		Custom(playerid, "SIDEJOB", "{FFFFFF}You've earned {00FF00}$1,000 {FFFFFF}for finising a bus route lap!");
		GivePlayerMoneyEx(playerid, 1000);
		pData[playerid][pBusTime] = 2500;
		DisablePlayerRaceCheckpoint(playerid);
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		pData[playerid][pSideJob] = SIDEJOB_NONE;
		pData[playerid][pSideJobVeh] = INVALID_VEHICLE_ID;
		BusCDSteps[playerid][1] = 0;
		DialogBusCD[1]--; // Dialog 0 telah di pilih
		DialogSaya[playerid][0] = false;
		return 1;
	}
    return 1;
}
  
//task

ptask PlayerBus[1000](playerid)
{
	if(pData[playerid][pBusWaiting] > 0)
	{
		if(pData[playerid][pBusWaiting] > 0)
		{
			pData[playerid][pBusWaiting]--;
			new string[212];
			format(string,32,"~w~PLEASE WAIT~n~~y~%i SECOND",pData[playerid][pBusWaiting]);
			GameTextForPlayer(playerid, string, 2000, 6);
			PlayerPlaySound(playerid, 1056, 0, 0, 0);
			if(pData[playerid][pBusWaiting] <= 0)
			{
				pData[playerid][pBusWaiting] = -1;
				PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 437 && pData[playerid][pSideJob] == SIDEJOB_BUS_AB) {
					if(BusRuteAB[BusSteps[playerid][0]][bus_rute] == 1 && BusRuteAB[BusSteps[playerid][0]][bus_stop] == 1)
					{
						BusSteps[playerid][0]++;
						SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][0]][bus_posx], BusRuteAB[BusSteps[playerid][0]][bus_posy], BusRuteAB[BusSteps[playerid][0]][bus_posz], BusRuteAB[BusSteps[playerid][0]+1][bus_posx], BusRuteAB[BusSteps[playerid][0]+1][bus_posy], BusRuteAB[BusSteps[playerid][0]+1][bus_posz], 5);
					}
					else if(BusRuteAB[BusSteps[playerid][1]][bus_rute] == 2 && BusRuteAB[BusSteps[playerid][1]][bus_stop] == 1)
					{
						BusSteps[playerid][1]++;
						SetPlayerRaceCheckpoint(playerid, 0, BusRuteAB[BusSteps[playerid][1]][bus_posx], BusRuteAB[BusSteps[playerid][1]][bus_posy], BusRuteAB[BusSteps[playerid][1]][bus_posz], BusRuteAB[BusSteps[playerid][1]+1][bus_posx], BusRuteAB[BusSteps[playerid][1]+1][bus_posy], BusRuteAB[BusSteps[playerid][1]+1][bus_posz], 5);
					}
				}
                else if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 431 && pData[playerid][pSideJob] == SIDEJOB_BUS_CD) {
					if(BusRuteCD[BusCDSteps[playerid][0]][bus_rute] == 1 && BusRuteCD[BusCDSteps[playerid][0]][bus_stop] == 1)
					{
						BusCDSteps[playerid][0]++;
						SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][0]][bus_posx], BusRuteCD[BusCDSteps[playerid][0]][bus_posy], BusRuteCD[BusCDSteps[playerid][0]][bus_posz], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][0]+1][bus_posz], 5);
					}
					else if(BusRuteCD[BusCDSteps[playerid][1]][bus_rute] == 2 && BusRuteCD[BusCDSteps[playerid][1]][bus_stop] == 1)
					{
						BusCDSteps[playerid][1]++;
						SetPlayerRaceCheckpoint(playerid, 0, BusRuteCD[BusCDSteps[playerid][1]][bus_posx], BusRuteCD[BusCDSteps[playerid][1]][bus_posy], BusRuteCD[BusCDSteps[playerid][1]][bus_posz], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posx], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posy], BusRuteCD[BusCDSteps[playerid][1]+1][bus_posz], 5);
					}
				}
			}	
		}
	}	
	if(pData[playerid][pSideJob] == SIDEJOB_BUS_AB && TimerBus[playerid] > 0 && !IsPlayerInAnyVehicle(playerid)) {
		TimerBus[playerid]--;
        new str[256];
        format(str, sizeof(str), "~w~Return To Vehicle ~n~in ~y~%d seconds", TimerBus[playerid]);
        GameTextForPlayer(playerid, str, 1000, 6);
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
		if(TimerBus[playerid] == 0) { 
			pData[playerid][pBusTime] = 2500;
			DisablePlayerRaceCheckpoint(playerid);

			if(IsValidVehicle(pData[playerid][pSideJobVeh]))
				SetVehicleToRespawn(pData[playerid][pSideJobVeh]);

			pData[playerid][pSideJobVeh] = INVALID_VEHICLE_ID;
			pData[playerid][pSideJob] = SIDEJOB_NONE;
			BusSteps[playerid][0] = 0;
			DialogBus[0]--; // Dialog 0 telah di pilih
			DialogSaya[playerid][0] = false;
		}
	}
	if(pData[playerid][pSideJob] == SIDEJOB_BUS_CD && TimerBus[playerid] > 0 && !IsPlayerInAnyVehicle(playerid)) {
		TimerBus[playerid]--;
        new str[256];
        format(str, sizeof(str), "~w~Return To Vehicle ~n~in ~y~%d seconds", TimerBus[playerid]);
        GameTextForPlayer(playerid, str, 1000, 6);
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
		if(TimerBus[playerid] == 0) { 
			pData[playerid][pBusTime] = 2500;
			DisablePlayerRaceCheckpoint(playerid);

			if(IsValidVehicle(pData[playerid][pSideJobVeh]))
				SetVehicleToRespawn(pData[playerid][pSideJobVeh]);

			pData[playerid][pSideJobVeh] = INVALID_VEHICLE_ID;
			pData[playerid][pSideJob] = SIDEJOB_NONE;
			BusSteps[playerid][0] = 0;
			DialogBus[0]--; // Dialog 0 telah di pilih
			DialogSaya[playerid][0] = false;
		}
	}
	return 1;
}
