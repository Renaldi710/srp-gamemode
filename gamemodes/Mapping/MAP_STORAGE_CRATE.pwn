#include <YSI_Coding\y_hooks>

hook RemoveBuilding(playerid)
{
    //crate truck
	RemoveBuildingForPlayer(playerid, 16303, 323.773, 914.257, 15.789, 0.250);
}

hook LoadMapping() 
{ 
	//Crate Farmer
	CreateDynamicObject(983, -367.901885, -1417.058837, 26.442993, -91.099975, 178.399917, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -365.062438, -1416.979980, 26.441453, -91.099975, 178.399917, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -367.299194, -1417.628662, 26.453891, -91.099975, -91.200111, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -365.879791, -1417.599975, 26.453329, -91.099975, -91.200111, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(1271, -367.271209, -1416.720581, 25.066568, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(1271, -366.521331, -1416.720581, 25.066568, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(1271, -365.631408, -1416.720581, 25.066568, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(1271, -365.941436, -1416.720581, 25.756580, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(1271, -366.921478, -1416.720581, 25.756580, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(1271, -366.351593, -1416.720581, 26.436586, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    
	//Crate Truck
	tmpobjid = CreateDynamicObject(18981, 317.602050, 910.980712, 20.086242, -0.000024, 90.000030, -55.699970, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 317.602050, 910.980712, 19.176246, -0.000024, 90.000030, -55.699970, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0x00000000);
	tmpobjid = CreateDynamicObject(18661, 319.419342, 902.834167, 23.506240, 0.000000, 0.000000, 124.500007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "{FFFFFF} ((OOC INFORMATION))", 130, "Arial", 50, 1, 0x00000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19174, 319.423400, 902.861450, 23.066238, 0.000000, 0.000000, 34.299995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(18661, 319.023773, 902.562194, 23.136241, 0.000000, 0.000000, 124.500007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "{FFFFFF} - Dilarang menyelak antrian", 130, "Arial", 35, 1, 0x00000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(18661, 319.040283, 902.573303, 22.836240, 0.000000, 0.000000, 124.500007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "{FFFFFF} - Menyelak antrian=Jail (PG)", 130, "Arial", 35, 1, 0x00000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19445, 332.183074, 901.531066, 17.696249, 0.000003, 0.000006, 32.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 335.612426, 903.741638, 17.696249, 0.000003, 0.000006, 32.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 328.896484, 899.412841, 17.696249, 0.000003, 0.000006, 32.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 325.408264, 897.164611, 17.696249, 0.000003, 0.000006, 32.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 321.625762, 894.726806, 17.696249, 0.000003, 0.000006, 32.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 318.103698, 892.456970, 17.696249, 0.000003, 0.000006, 32.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 309.653381, 892.388427, 17.696249, 0.000003, 0.000006, 122.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 307.340179, 895.977600, 17.696249, 0.000003, 0.000006, 122.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 304.620880, 900.197204, 17.696249, 0.000003, 0.000006, 122.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 301.744354, 904.660766, 17.696249, 0.000003, 0.000006, 122.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 329.836059, 922.765136, 17.696249, 0.000003, 0.000006, 122.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 332.712585, 918.301208, 17.696249, 0.000003, 0.000006, 122.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 335.499206, 914.124877, 17.696249, 0.000003, 0.000006, 122.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 337.820800, 910.541259, 17.696249, 0.000003, 0.000006, 122.799995, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	CreateDynamicObject(9244, 315.977844, 912.694580, 25.856233, -0.000024, 0.000017, -55.699970, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(18981, 309.365844, 905.362182, 18.936250, -0.000024, 90.000030, -55.699970, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(18981, 325.557342, 916.407470, 18.936250, -0.000024, 90.000030, -55.699970, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(18981, 331.037689, 908.391906, 18.936246, -0.000024, 90.000030, -55.699970, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(18981, 314.848907, 897.360595, 18.936248, -0.000024, 90.000030, -55.699970, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(970, 321.217407, 903.597290, 21.086244, 0.000000, 0.000000, 36.300003, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(970, 321.975219, 902.565673, 21.086244, 0.000000, 0.000000, 36.300003, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(970, 318.654693, 900.126464, 21.086244, 0.000000, 0.000000, 36.300003, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(970, 317.888916, 901.152160, 21.086244, 0.000000, 0.000000, 36.300003, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(1231, 333.926696, 907.801757, 23.246227, 0.000000, 0.000000, 35.800006, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(1231, 314.310363, 893.937377, 23.246227, 0.000000, 0.000000, 35.800006, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(1231, 300.688415, 913.987243, 23.246227, 0.000000, 0.000000, 35.800006, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(1231, 320.768218, 927.926696, 23.246227, 0.000000, 0.000000, 35.800006, -1, -1, -1, 300.00, 300.00);
}