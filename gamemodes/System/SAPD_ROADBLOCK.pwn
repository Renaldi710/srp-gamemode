#include <YSI\y_hooks>

#define MAX_DYNAMIC_BARRICADES	100

new const gRoadblockModels[] = 
{
    19975, 	
    19972, 	
    19966, 	
    1459, 	
    978,     
    981, 	
    1238, 	
    1425,	
    3265,	
    3091,   
    1422,    
    19970, 	
    19971, 	
    1237,   
    1423,	
    983, 	 
    1251,   
    19953,
    19954,  
    19974, 	
    19834, 
    1428, 
    1437
};


enum E_BARRICADE_DATA
{
    cadeType,
    cadeModel,

    cadeText[225],
    Float:cadePos[6],

    cadeArea,
    cadeObject
};

new
	Iterator:Barricade<MAX_DYNAMIC_BARRICADES>,
	BarricadeData[MAX_DYNAMIC_BARRICADES][E_BARRICADE_DATA];


// Function
Barricade_IsExists(index)
{
	if(Iter_Contains(Barricade, index))
		return 1;

	return 0;
}

Barricade_Create(playerid, type, model, text[])
{
	static
		index;

	if((index = Iter_Free(Barricade)) != cellmin)
	{
		Iter_Add(Barricade, index);

		BarricadeData[index][cadeType] = type;
		BarricadeData[index][cadeModel] = model;

		FixText(text);    
        format(BarricadeData[index][cadeText], 225, text);

		GetPlayerPos(playerid, BarricadeData[index][cadePos][0], BarricadeData[index][cadePos][1], BarricadeData[index][cadePos][2]);
		BarricadeData[index][cadePos][4] = 0.0;
		BarricadeData[index][cadePos][3] = 0.0;
		GetPlayerFacingAngle(playerid, BarricadeData[index][cadePos][5]);

		SetPlayerPos(playerid, BarricadeData[index][cadePos][0]+1, BarricadeData[index][cadePos][1], BarricadeData[index][cadePos][2]);
		Barricade_Sync(index);
		return index;
	}
	return -1;
}

Barricade_Delete(index, bool:remove_all = false)
{
	if(Barricade_IsExists(index))
	{
		if(!remove_all)
			Iter_Remove(Barricade, index);

		if(IsValidDynamicObject(BarricadeData[index][cadeObject]))
			DestroyDynamicObject(BarricadeData[index][cadeObject]);

		if(IsValidDynamicArea(BarricadeData[index][cadeArea]))
			DestroyDynamicArea(BarricadeData[index][cadeArea]);

		new tmp_BarricadeData[E_BARRICADE_DATA];
		BarricadeData[index] = tmp_BarricadeData;

		BarricadeData[index][cadeObject] = INVALID_STREAMER_ID;
		BarricadeData[index][cadeArea] = INVALID_STREAMER_ID;
		return 1;
	}
	return 0;
}

Barricade_Sync(index)
{
	if(Barricade_IsExists(index))
	{
		new Float:z_min;

		switch(BarricadeData[index][cadeModel])
		{
			case 981, 978: z_min = 0.2;
			case 1423: z_min = 0.3;
			case 3091, 1459, 983: z_min = 0.5;
			case 1238, 1422, 1425: z_min = 0.7;
			case 19834: z_min = -0.3;
			case 2899: z_min = 0.9;
			default: z_min = 1.0;
		}

		if(IsValidDynamicObject(BarricadeData[index][cadeObject]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_X, BarricadeData[index][cadePos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_Y, BarricadeData[index][cadePos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_Z, BarricadeData[index][cadePos][2]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_R_X, BarricadeData[index][cadePos][3]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_R_Y, BarricadeData[index][cadePos][4]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_R_Z, BarricadeData[index][cadePos][5]);
		}
		else
		{
			BarricadeData[index][cadeObject] = CreateDynamicObject(BarricadeData[index][cadeModel], BarricadeData[index][cadePos][0], BarricadeData[index][cadePos][1], BarricadeData[index][cadePos][2] - z_min, BarricadeData[index][cadePos][3], BarricadeData[index][cadePos][4], BarricadeData[index][cadePos][5], 0, 0);
			if(BarricadeData[index][cadeModel] == 981)
            	SetDynamicObjectMaterialText(BarricadeData[index][cadeObject], 2, BarricadeData[index][cadeText], 100, "Arial", 30, 1, -1, 0xFF000000, 1);
		}

		if(IsValidDynamicArea(BarricadeData[index][cadeArea]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_AREA, BarricadeData[index][cadeArea], E_STREAMER_X, BarricadeData[index][cadePos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, BarricadeData[index][cadeArea], E_STREAMER_Y, BarricadeData[index][cadePos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, BarricadeData[index][cadeArea], E_STREAMER_MIN_Z, BarricadeData[index][cadePos][2] - 1.0);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, BarricadeData[index][cadeArea], E_STREAMER_MAX_Z, BarricadeData[index][cadePos][2] + 3.0);
		}
		else
		{
			BarricadeData[index][cadeArea] = CreateDynamicCylinder(BarricadeData[index][cadePos][0], BarricadeData[index][cadePos][1], BarricadeData[index][cadePos][2] - 1.0, BarricadeData[index][cadePos][2] + 3.0, 2.5, 0, 0);

			new streamer_info[2];

			streamer_info[0] = 1;
			streamer_info[1] = index;
			Streamer_SetArrayData(STREAMER_TYPE_AREA, BarricadeData[index][cadeArea], E_STREAMER_EXTRA_ID, streamer_info);
		}
	}
	return 1;
}

Barricade_Nearest(playerid, Float:range = 3.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : Barricade) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, BarricadeData[i][cadePos][0], BarricadeData[i][cadePos][1], BarricadeData[i][cadePos][2]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	return id;
}

CMD:rb(playerid, params[])
{
    new
        index,
        option[15],
        nextParams[225],
        // vehicleid = Vehicle_Nearest(playerid, 5),
        Float:fX, Float:fY, Float:fZ;
        
    if(pData[playerid][pFaction] != 1)
	   return Error(playerid, "You dont have Faction Sapd!");
        

    if(!pData[playerid][pOnDuty])
        return Error(playerid, "Duty terlebih dahulu!");

    if(IsPlayerInAnyVehicle(playerid))
        return Error(playerid, "Harus turun dari kendaraan untuk menggunakan perintah!");

    if(GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
        return Error(playerid, "Hanya bisa digunakan di lokasi outdoor!");

    if(sscanf(params,"s[15]S()[225]", option, nextParams))
    {
        Usage(playerid, "/rb [entity]");
        Usage(playerid, "ENTITY : [add/addcustom/edit/nearest/destroy/destroyall]");
        return 1;
    }
    GetPlayerPos(playerid, fX, fY, fZ);

    if(!strcmp(option, "add", true))
    {
        new text[225];

        if(sscanf(nextParams,"s[225]", text))
            return Usage(playerid, "/rb add [text]");

        if((index = Barricade_Create(playerid, 2, 981, text)) != -1) 
        {
            pData[playerid][pEditingMode] = 2;
            pData[playerid][pEditRoadblock] = index;
            EditDynamicObject(playerid, BarricadeData[index][cadeObject]);
            SendFactionMessage(pData[playerid][pFaction], COLOR_RADIO, "** [SAPD Radio] %s(%d) %s: has dropped a roadblock at %s. ((ID %d))", GetFactionRank(playerid), pData[playerid][pFactionRank], ReturnName(playerid), GetLocation(fX, fY, fZ), index);
        }
        else 
        {
            Error(playerid, "Roadblock sudah mencapai batas maksimal ("#MAX_DYNAMIC_ROADBLOCK" roadblock).");
        }
    }
    else if(!strcmp(option, "addcustom", true))
    {
        ShowPlayerSelectionMenu(playerid, MODEL_SELECTION_Barricade, "Roadblock Objects:", gRoadblockModels, sizeof(gRoadblockModels));
    }
    else if(!strcmp(option, "edit", true))
    {
        if(sscanf(nextParams, "d", index))
            return Usage(playerid, "/rb edit <roadblockid>");

        if(Barricade_IsExists(index))
        {
            pData[playerid][pEditingMode] = 2;
            pData[playerid][pEditRoadblock] = index;
            EditDynamicObject(playerid, BarricadeData[index][cadeObject]);
        }
        else Error(playerid, "Invalid roadblock id!");
    }
    else if(!strcmp(option, "nearest", true))
    {
        if((index = Barricade_Nearest(playerid)) != -1 && BarricadeData[index][cadeType] == 2)
        {
            Servers(playerid, "You stands near roadblock (( ID : %d ))", index);
        }
        else Error(playerid, "Kamu tidak berada didekat roadblock.");
    }
    else if(!strcmp(option, "destroy", true))
    {
        if((index = Barricade_Nearest(playerid)) != -1 && BarricadeData[index][cadeType] == 2)
        {
            Barricade_Delete(index);
            SendFactionMessage(pData[playerid][pFaction], COLOR_RADIO, "** [SAPD Radio] %s(%d) %s: has pickup a roadblocks.", GetFactionRank(playerid), pData[playerid][pFactionRank], ReturnName(playerid));
        }
        else Error(playerid, "Kamu tidak berada didekat roadblock.");
    }
    else if(!strcmp(option, "destroyall", true))
    {
        foreach(new i : Barricade) if(BarricadeData[i][cadeType] == 2)
        {
            Barricade_Delete(i, true);

            new next;
            Iter_SafeRemove(Barricade, i, next);
            i = next;
        }
        SendFactionMessage(pData[playerid][pFaction], COLOR_RADIO, "** [SAPD Radio] %s(%d) %s: has destroyed all of the roadblocks.", GetFactionRank(playerid), pData[playerid][pFactionRank], ReturnName(playerid));
    }
    else 
    {
        Usage(playerid, "/rb [entity]");
        Usage(playerid, "ENTITY : [add/addcustom/edit/nearest/destroy/destroyall]");
    }
    return 1;
}
