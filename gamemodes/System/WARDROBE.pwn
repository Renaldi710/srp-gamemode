/*

	CORE LEMARI

*/

#define MAX_LEMARIS 300

enum    E_DYLEMARI
{
	// loaded from db
	Float: dylX,
	Float: dylY,
	Float: dylZ,
	dylInt,
	dylWorld,
	// temp
	STREAMER_TAG_OBJECT:dylObjID,
	STREAMER_TAG_3D_TEXT_LABEL: dylLabel
}

new dyLemariData[MAX_LEMARIS][E_DYLEMARI],
	Iterator:LEMARI<MAX_LEMARIS>;


//Baju System
enum E_BAJU_DATA
{
	baju_model[6]
}
new bajuData[MAX_PLAYERS][E_BAJU_DATA];


GetClosestLemari(playerid, Float: range = 3.0)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : LEMARI)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, dyLemariData[i][dylX], dyLemariData[i][dylY], dyLemariData[i][dylZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist && GetPlayerInterior(playerid) == dyLemariData[i][dylInt] && GetPlayerVirtualWorld(playerid) == dyLemariData[i][dylWorld])
		{
			dist = tempdist;
			id = i;
		}
	}
	return id;
}

Lemari_Refresh(id)
{
	if(id != -1)
    {
        if(IsValidDynamic3DTextLabel(dyLemariData[id][dylLabel]))
            DestroyDynamic3DTextLabel(dyLemariData[id][dylLabel]);

        static
        	string[255];

		format(string, sizeof(string), "[ID: %d]\n"WHITEP_E"use"YELLOW_E" /openlm "WHITEP_E"to access", id);
		dyLemariData[id][dylLabel] = CreateDynamic3DTextLabel(string, COLOR_GREY, dyLemariData[id][dylX], dyLemariData[id][dylY], dyLemariData[id][dylZ], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, dyLemariData[id][dylWorld], dyLemariData[id][dylInt], -1, 15.0);
	}
    return 1;
}

function LoadLemari()
{
	new rows;
	rows = cache_num_rows();
	if(rows)
  	{
  		new id;
		for(new i = 0; i < rows; i++)
		{
		    cache_get_value_name_int(i, "id", id);
			cache_get_value_name_float(i, "posx", dyLemariData[id][dylX]);
			cache_get_value_name_float(i, "posy", dyLemariData[id][dylY]);
			cache_get_value_name_float(i, "posz", dyLemariData[id][dylZ]);
			cache_get_value_name_int(i, "interior", dyLemariData[id][dylInt]);
			cache_get_value_name_int(i, "world", dyLemariData[id][dylWorld]);

			Lemari_Refresh(id);
			Iter_Add(LEMARI, id);
		}
		printf("*** [Database: Loaded] LEMARI data (%d count).", rows);
	}
}

Lemari_Save(id)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE lemari SET posx='%f', posy='%f', posz='%f', interior='%d', world='%d'  WHERE id='%d'",
	dyLemariData[id][dylX],
	dyLemariData[id][dylY],
	dyLemariData[id][dylZ],
	dyLemariData[id][dylInt],
	dyLemariData[id][dylWorld],
	id
	);
	return mysql_tquery(g_SQL, cQuery);
}

function OnLemariCreated(playerid, id)
{
	Lemari_Save(id);
	Servers(playerid, "You has created LEMARI id: %d.", id);
	return 1;
}


function LoadPlayerBajus(playerid)
{
	new rows = cache_num_rows();
	if(rows)
	{
		pData[playerid][PurchasedClothing] = true;
		cache_get_value_name_int(0, "slot_baju0", bajuData[playerid][baju_model][0]);
		cache_get_value_name_int(0, "slot_baju1", bajuData[playerid][baju_model][1]);
		cache_get_value_name_int(0, "slot_baju2", bajuData[playerid][baju_model][2]);
		cache_get_value_name_int(0, "slot_baju3", bajuData[playerid][baju_model][3]);
		cache_get_value_name_int(0, "slot_baju4", bajuData[playerid][baju_model][4]);

		printf("[BAJU] Loaded: %s(%d)", pData[playerid][pName], playerid);
	}
	return 1;
}

MySQL_CreatePlayerBaju(playerid)
{
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `baju` (`Owner`) VALUES ('%s');", pData[playerid][pName]);
	mysql_tquery(g_SQL, query);
	pData[playerid][PurchasedClothing] = true;

	for(new i = 0; i < 5; i++)
	{
		bajuData[playerid][baju_model][i] = -1;
	}
}

MySQL_SavePlayerBaju(playerid)
{
	if(pData[playerid][PurchasedClothing] == false) return true;

	new lstr[1544];

	mysql_format(g_SQL, lstr, sizeof(lstr), "UPDATE `baju` SET `slot_baju0` = '%i', `slot_baju1` = '%i', `slot_baju2` = '%i', `slot_baju3` = '%i', `slot_baju4` = '%i' WHERE `Owner`= '%s'", bajuData[playerid][baju_model][0], bajuData[playerid][baju_model][1], bajuData[playerid][baju_model][2], bajuData[playerid][baju_model][3], bajuData[playerid][baju_model][4], pData[playerid][pName]);
    mysql_tquery(g_SQL, lstr);
    return 1;
}

/*

	CMD LEMARI

*/

CMD:lemari(playerid, params[])
{
    static type[24], string[128];
    if(pData[playerid][pAdmin] < 6) return PermissionError(playerid);

    if(sscanf(params, "s[24]S()[128]", type, string)) return Usage(playerid, "/lemari [create/goto/pos/delete");
    if(!strcmp(type, "create", true))
    {
    	if(pData[playerid][pAdmin] < 5)
    		return PermissionError(playerid);

    	new id = Iter_Free(LEMARI), query[512];
    	if(id == -1) return Error(playerid, "Can't add any more Lemari.");
    	new Float: x, Float: y, Float: z;
    	GetPlayerPos(playerid, x, y, z);

    	dyLemariData[id][dylX] = x;
    	dyLemariData[id][dylY] = y;
    	dyLemariData[id][dylZ] = z;
    	dyLemariData[id][dylInt] = GetPlayerInterior(playerid);
    	dyLemariData[id][dylWorld] = GetPlayerVirtualWorld(playerid);

    	new str[128];
    	format(str, sizeof(str), "[ID: %d]\n"WHITEP_E"use"YELLOW_E" /openlm "WHITEP_E"to access", id);
    	dyLemariData[id][dylLabel] = CreateDynamic3DTextLabel(str, COLOR_GREY, dyLemariData[id][dylX], dyLemariData[id][dylY], dyLemariData[id][dylZ], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, dyLemariData[id][dylWorld], dyLemariData[id][dylInt], -1, 15.0);
    	Iter_Add(LEMARI, id);

    	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO lemari SET id='%d', posx='%f', posy='%f', posz='%f', interior='%d', world='%d'", id, dyLemariData[id][dylX], dyLemariData[id][dylY], dyLemariData[id][dylZ], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
    	mysql_tquery(g_SQL, query, "OnLemariCreated", "ii", playerid, id);
    }
    else if(!strcmp(type, "pos", true))
    {
    	if(pData[playerid][pAdmin] < 5)
    		return PermissionError(playerid);

    	new id;
    	if(sscanf(string, "d", id)) return Usage(playerid, "/lemari [edit] [id]");
    	if(!Iter_Contains(LEMARI, id)) return Error(playerid, "Invalid ID.");

    	GetPlayerPos(playerid, dyLemariData[id][dylX], dyLemariData[id][dylY], dyLemariData[id][dylZ]);
        Lemari_Save(id);
        Lemari_Refresh(id);

        SendAdminMessage(COLOR_RED, "%s has adjusted the location of lemari ID: %d.", pData[playerid][pAdminname], id);
    }
    else if(!strcmp(type, "delete", true))
    {
    	if(pData[playerid][pAdmin] < 5)
    		return PermissionError(playerid);

    	new id, query[512];
    	if(sscanf(string, "d", id)) return Usage(playerid, "/lemari [delete] [id]");
    	if(!Iter_Contains(LEMARI, id)) return Error(playerid, "Invalid ID.");

    	DestroyDynamic3DTextLabel(dyLemariData[id][dylLabel]);

    	dyLemariData[id][dylX] = dyLemariData[id][dylY] = dyLemariData[id][dylZ] = 0.0;
    	dyLemariData[id][dylInt] = dyLemariData[id][dylWorld] = 0;
    	dyLemariData[id][dylLabel] = STREAMER_TAG_3D_TEXT_LABEL:INVALID_STREAMER_ID;
    	Iter_Remove(LEMARI, id);

    	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM lemari WHERE id=%d", id);
    	mysql_tquery(g_SQL, query);
    	Servers(playerid, "You removed Lemari id %d.", id);
    }
    else if(!strcmp(type, "goto", true))
    {
    	if(pData[playerid][pAdmin] < 5)
    		return PermissionError(playerid);

    	new id;
    	if(sscanf(string, "d", id)) return Usage(playerid, "/lemari [goto] [id]");
    	if(!Iter_Contains(LEMARI, id)) return Error(playerid, "Invalid ID.");

    	SetPlayerPosition(playerid, dyLemariData[id][dylX], dyLemariData[id][dylY], dyLemariData[id][dylZ], 2.0);
    	SetPlayerInterior(playerid, dyLemariData[id][dylInt]);
    	SetPlayerVirtualWorld(playerid, dyLemariData[id][dylWorld]);
    	Servers(playerid, "You has teleport to lemari id %d", id);
    }
    return 1;
}

CMD:openlm(playerid)
{
	new id = -1;
	id = GetClosestLemari(playerid);

	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "This command can only be used on foot, exit your vehicle!");
	if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "You must be logged in to attach objects to your character!");

	if(!IsPlayerInRangeOfPoint(playerid, 4.0, dyLemariData[id][dylX], dyLemariData[id][dylY], dyLemariData[id][dylZ]))
		return Error(playerid, "Anda Tidak Dekat Lemari");

	new string[1500];
	format(string, sizeof(string), "#\tStatus\tClothes ID\n");
	if(bajuData[playerid][baju_model][0] < 0)
	{
	    format(string, sizeof(string), "%s1\tEmpty\t-\n", string);
	}
	else if(bajuData[playerid][baju_model][0] > 0) {
		format(string, sizeof(string), "%s1\tReady\t%d\n", string, bajuData[playerid][baju_model][0]);
	}
	if(bajuData[playerid][baju_model][1] < 0)
	{
	    format(string, sizeof(string), "%s2\tEmpty\t-\n", string);
	}
	else if(bajuData[playerid][baju_model][1] > 0) {
		format(string, sizeof(string), "%s2\tReady\t%d\n", string, bajuData[playerid][baju_model][1]);
	}
	if(bajuData[playerid][baju_model][2] < 0)
	{
	    format(string, sizeof(string), "%s3\tEmpty\t-\n", string);
	}
	else if(bajuData[playerid][baju_model][2] > 0) {
		format(string, sizeof(string), "%s3\tReady\t%d\n", string, bajuData[playerid][baju_model][2]);
	}

	Dialog_Show(playerid, DialogSlotBaju, DIALOG_STYLE_TABLIST_HEADERS, ""WHITE_E"Public Wardrobe", string, "Select", "Cancel");
	return 1;
}


Dialog:DialogSlotBaju(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				if(bajuData[playerid][baju_model][0] > 0)
				{
					pData[playerid][pSkin] = bajuData[playerid][baju_model][0];
	                SetPlayerSkin(playerid, bajuData[playerid][baju_model][0]);
					Custom(playerid, "SKIN", "Anda berhasil mengganti baju dengan ID "YELLOW"%d", bajuData[playerid][baju_model][0]);
	            }
	            else return Error(playerid, "Tidak Ada Pakaian Di Slot Ini");
			}
			case 1:
			{
				if(bajuData[playerid][baju_model][1] > 0)
				{
					pData[playerid][pSkin] = bajuData[playerid][baju_model][1];
	                SetPlayerSkin(playerid, bajuData[playerid][baju_model][1]);
					Custom(playerid, "SKIN", "Anda berhasil mengganti baju dengan ID "YELLOW"%d", bajuData[playerid][baju_model][1]);
	            }
	            else return Error(playerid, "Tidak Ada Pakaian Di Slot Ini");
			}
			case 2:
			{
				if(bajuData[playerid][baju_model][1] > 0)
				{
					pData[playerid][pSkin] = bajuData[playerid][baju_model][2];
	                SetPlayerSkin(playerid, bajuData[playerid][baju_model][2]);
					Custom(playerid, "SKIN", "Anda berhasil mengganti baju dengan ID "YELLOW"%d", bajuData[playerid][baju_model][2]);
	            } 
	            else return Error(playerid, "Tidak Ada Pakaian Di Slot Ini");
			}
		}
	}
    return 1;
}