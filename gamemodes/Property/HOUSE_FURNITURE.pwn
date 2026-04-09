IsFurnitureItem(item[])
{
    for (new i = 0; i < sizeof(g_aFurnitureData); i ++) if(!strcmp(g_aFurnitureData[i][e_FurnitureName], item)) {
        return 1;
    }
    return 0;
}

GetFurnitureNameByModel(model)
{
    new
        name[32];

    for (new i = 0; i < sizeof(g_aFurnitureData); i ++) if(g_aFurnitureData[i][e_FurnitureModel] == model) {
        strcat(name, g_aFurnitureData[i][e_FurnitureName]);

        break;
    }
    return name;
}

Furniture_GetCount(houseid) {
    return Iter_Count(HouseFurnitures[houseid]);
}

Furniture_GetMaxItems(houseid) {
    new maxItems = 0;

    switch (hData[houseid][hType]) {
        case 1: maxItems = 100; // Small house
        case 2: maxItems = 150; // Medium house
        case 3: maxItems = 200; // Big house
    }

    return maxItems;
}

function OnLoadFurniture(houseid)
{
    new
        rows = cache_num_rows(),
        id = cellmin,
        str[32];

    Iter_Init(HouseFurnitures);
    if (rows) {
        for (new i = 0; i != rows; i ++) if((id = Iter_Free(HouseFurnitures[houseid])) != cellmin) {
            Iter_Add(HouseFurnitures[houseid], id);

            cache_get_value(i, "furnitureName", FurnitureData[houseid][id][furnitureName], 32);
            cache_get_value_int(i, "furnitureID", FurnitureData[houseid][id][furnitureID]);
            cache_get_value_int(i, "furnitureModel", FurnitureData[houseid][id][furnitureModel]);
            cache_get_value_int(i, "furnitureUnused", FurnitureData[houseid][id][furnitureUnused]);
            cache_get_value_float(i, "furnitureX", FurnitureData[houseid][id][furniturePos][0]);
            cache_get_value_float(i, "furnitureY", FurnitureData[houseid][id][furniturePos][1]);
            cache_get_value_float(i, "furnitureZ", FurnitureData[houseid][id][furniturePos][2]);
            cache_get_value_float(i, "furnitureRX", FurnitureData[houseid][id][furnitureRot][0]);
            cache_get_value_float(i, "furnitureRY", FurnitureData[houseid][id][furnitureRot][1]);
            cache_get_value_float(i, "furnitureRZ", FurnitureData[houseid][id][furnitureRot][2]);

            cache_get_value(i, "furnitureMaterials", str, 32);
            sscanf(str, "p<|>dddddddddddddddd", 
                FurnitureData[houseid][id][furnitureMaterials][0],
                FurnitureData[houseid][id][furnitureMaterials][1],
                FurnitureData[houseid][id][furnitureMaterials][2],
                FurnitureData[houseid][id][furnitureMaterials][3],
                FurnitureData[houseid][id][furnitureMaterials][4],
                FurnitureData[houseid][id][furnitureMaterials][5],
                FurnitureData[houseid][id][furnitureMaterials][6],
                FurnitureData[houseid][id][furnitureMaterials][7],
                FurnitureData[houseid][id][furnitureMaterials][8],
                FurnitureData[houseid][id][furnitureMaterials][9],
                FurnitureData[houseid][id][furnitureMaterials][10],
                FurnitureData[houseid][id][furnitureMaterials][11],
                FurnitureData[houseid][id][furnitureMaterials][12],
                FurnitureData[houseid][id][furnitureMaterials][13],
                FurnitureData[houseid][id][furnitureMaterials][14],
                FurnitureData[houseid][id][furnitureMaterials][15]
            );

            Furniture_Refresh(id, houseid);
        }
    }
    return 1;
}

Furniture_Refresh(furnitureid, houseid)
{
    if(Iter_Contains(HouseFurnitures[houseid], furnitureid))
    {
        if(!IsValidDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject])) {
            if(FurnitureData[houseid][furnitureid][furnitureUnused] == 0)
            {
                FurnitureData[houseid][furnitureid][furnitureObject] = CreateDynamicObject(
                    FurnitureData[houseid][furnitureid][furnitureModel],
                    FurnitureData[houseid][furnitureid][furniturePos][0],
                    FurnitureData[houseid][furnitureid][furniturePos][1],
                    FurnitureData[houseid][furnitureid][furniturePos][2],
                    FurnitureData[houseid][furnitureid][furnitureRot][0],
                    FurnitureData[houseid][furnitureid][furnitureRot][1],
                    FurnitureData[houseid][furnitureid][furnitureRot][2],
                    houseid,
                    hData[houseid][hInt]
                );
            }
        }
        Furniture_Update(furnitureid, houseid);

        foreach(new i : Player) if(pData[i][IsLoggedIn] && IsPlayerInRangeOfPoint(i, 5, FurnitureData[houseid][furnitureid][furniturePos][0], FurnitureData[houseid][furnitureid][furniturePos][1], FurnitureData[houseid][furnitureid][furniturePos][2])) {
			Streamer_Update(i);
		}
    }
    return 1;
}

Furniture_Update(furnitureid, houseid) {
    if(Iter_Contains(HouseFurnitures[houseid], furnitureid)) {
        if (!IsValidDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject]))
            return 0;

        if (FurnitureData[houseid][furnitureid][furnitureUnused] == 1) {
            DestroyDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject]);
            FurnitureData[houseid][furnitureid][furnitureObject] = INVALID_STREAMER_ID;
            
            return 1;
        }

		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_X, FurnitureData[houseid][furnitureid][furniturePos][0]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_Y,FurnitureData[houseid][furnitureid][furniturePos][1]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_Z, FurnitureData[houseid][furnitureid][furniturePos][2]);

		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_R_X, FurnitureData[houseid][furnitureid][furnitureRot][0]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_R_Y, FurnitureData[houseid][furnitureid][furnitureRot][1]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_R_Z, FurnitureData[houseid][furnitureid][furnitureRot][2]);

		Streamer_SetIntData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_WORLD_ID, houseid);
		Streamer_SetIntData(STREAMER_TYPE_OBJECT, FurnitureData[houseid][furnitureid][furnitureObject], E_STREAMER_INTERIOR_ID, hData[houseid][hInt]);

        for(new i = 0; i != MAX_MATERIALS; i++) if(FurnitureData[houseid][furnitureid][furnitureMaterials][i] > 0) {
            SetDynamicObjectMaterial(FurnitureData[houseid][furnitureid][furnitureObject], i, 
                GetTModel(FurnitureData[houseid][furnitureid][furnitureMaterials][i]), 
                GetTXDName(FurnitureData[houseid][furnitureid][furnitureMaterials][i]), 
                GetTextureName(FurnitureData[houseid][furnitureid][furnitureMaterials][i]), 0
            );
        }

        return 1;
    }
    return 0;
}

Furniture_Save(furnitureid, houseid)
{
    static
        string[1024];

    format(string, sizeof(string), "UPDATE `furniture` SET `ID` = '%d', `furnitureModel` = '%d', `furnitureName` = '%e', `furnitureX` = '%.4f', `furnitureY` = '%.4f', `furnitureZ` = '%.4f', `furnitureRX` = '%.4f', `furnitureRY` = '%.4f', `furnitureRZ` = '%.4f', `furnitureUnused` = '%d', `furnitureMaterials` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `furnitureID` = '%d'",
        houseid,
        FurnitureData[houseid][furnitureid][furnitureModel],
        FurnitureData[houseid][furnitureid][furnitureName],
        FurnitureData[houseid][furnitureid][furniturePos][0],
        FurnitureData[houseid][furnitureid][furniturePos][1],
        FurnitureData[houseid][furnitureid][furniturePos][2],
        FurnitureData[houseid][furnitureid][furnitureRot][0],
        FurnitureData[houseid][furnitureid][furnitureRot][1],
        FurnitureData[houseid][furnitureid][furnitureRot][2],
        FurnitureData[houseid][furnitureid][furnitureUnused],
        FurnitureData[houseid][furnitureid][furnitureMaterials][0],
        FurnitureData[houseid][furnitureid][furnitureMaterials][1],
        FurnitureData[houseid][furnitureid][furnitureMaterials][2],
        FurnitureData[houseid][furnitureid][furnitureMaterials][3],
        FurnitureData[houseid][furnitureid][furnitureMaterials][4],
        FurnitureData[houseid][furnitureid][furnitureMaterials][5],
        FurnitureData[houseid][furnitureid][furnitureMaterials][6],
        FurnitureData[houseid][furnitureid][furnitureMaterials][7],
        FurnitureData[houseid][furnitureid][furnitureMaterials][8],
        FurnitureData[houseid][furnitureid][furnitureMaterials][9],
        FurnitureData[houseid][furnitureid][furnitureMaterials][10],
        FurnitureData[houseid][furnitureid][furnitureMaterials][11],
        FurnitureData[houseid][furnitureid][furnitureMaterials][12],
        FurnitureData[houseid][furnitureid][furnitureMaterials][13],
        FurnitureData[houseid][furnitureid][furnitureMaterials][14],
        FurnitureData[houseid][furnitureid][furnitureMaterials][15],
        FurnitureData[houseid][furnitureid][furnitureID]
    );
    return mysql_tquery(g_SQL, string);
}

Furniture_Add(houseid, name[], modelid, Float:x, Float:y, Float:z, Float:rx = 0.0, Float:ry = 0.0, Float:rz = 0.0, unused = 1)
{
    static
        id = cellmin;

    if(!Iter_Contains(Houses, houseid))
        return 0;

    if((id = Iter_Free(HouseFurnitures[houseid])) != cellmin)
    {
        Iter_Add(HouseFurnitures[houseid], id);

        format(FurnitureData[houseid][id][furnitureName], 32, name);
        FurnitureData[houseid][id][furnitureModel] = modelid;
        FurnitureData[houseid][id][furniturePos][0] = x;
        FurnitureData[houseid][id][furniturePos][1] = y;
        FurnitureData[houseid][id][furniturePos][2] = z;
        FurnitureData[houseid][id][furnitureRot][0] = rx;
        FurnitureData[houseid][id][furnitureRot][1] = ry;
        FurnitureData[houseid][id][furnitureRot][2] = rz;
        FurnitureData[houseid][id][furnitureUnused] = unused;

        Furniture_Refresh(id, houseid);
        mysql_tquery(g_SQL, sprintf("INSERT INTO `furniture` (`ID`) VALUES('%d')", houseid), "OnFurnitureCreated", "dd", id, houseid);

        return id;
    }
    return cellmin;
}

Furniture_Delete(furnitureid, houseid)
{
    if(Iter_Contains(HouseFurnitures[houseid], furnitureid))
    {
        mysql_tquery(g_SQL, sprintf("DELETE FROM `furniture` WHERE `furnitureID` = '%d'", FurnitureData[houseid][furnitureid][furnitureID]));

        if (IsValidDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject])) {
            DestroyDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject]);
            FurnitureData[houseid][furnitureid][furnitureObject] = INVALID_STREAMER_ID;
        }

        Iter_Remove(HouseFurnitures[houseid], furnitureid);

        new tmp_furniture[furnitureData];
        FurnitureData[houseid][furnitureid] = tmp_furniture;
    }
    return 1;
}

House_RemoveFurniture(houseid)
{
    if(Iter_Contains(Houses, houseid))
    {
        foreach (new furnitureid : HouseFurnitures[houseid]) {
            mysql_tquery(g_iHandle, sprintf("DELETE FROM `furniture` WHERE `furnitureID` = '%d'", FurnitureData[houseid][furnitureid][furnitureID]));

            if (IsValidDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject])) {
                DestroyDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject]);
                FurnitureData[houseid][furnitureid][furnitureObject] = INVALID_STREAMER_ID;
            }

            new tmp_furniture[furnitureData];
            FurnitureData[houseid][furnitureid] = tmp_furniture;

            new current = furnitureid;
            Iter_SafeRemove(HouseFurnitures[houseid], current, furnitureid);
        }
    }
    return 1;
}

function OnFurnitureCreated(furnitureid, houseid)
{
    FurnitureData[houseid][furnitureid][furnitureID] = cache_insert_id();
    Furniture_Save(furnitureid, houseid);
    return 1;
}

Dialog:ListedFurniture(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new id = House_Inside(playerid);

        if(id != -1 && (Player_OwnsHouse(playerid, id) || hData[id][houseBuilder] == pData[playerid][pID]))
        {
            pData[playerid][pEditFurniture] = ListedFurniture[playerid][listitem];
            pData[playerid][pEditFurnHouse] = id;
            Dialog_Show(playerid, FurnitureList, DIALOG_STYLE_LIST, FurnitureData[id][pData[playerid][pEditFurniture]][furnitureName], "Edit Position\nMove to in front me\nDestroy Furniture\nStore Furniture", "Select", "Cancel");
        }
    }
    return 1;
}

Dialog:FurnitureList(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new id = House_Inside(playerid),
            Float:x,
            Float:y,
            Float:z,
            Float:angle;

        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, angle);

        x += 1.0 * floatsin(-angle, degrees);
        y += 1.0 * floatcos(-angle, degrees);

        if(id != -1 && (Player_OwnsHouse(playerid, id) || hData[id][houseBuilder] == pData[playerid][pID]))
        {
            switch (listitem)
            {
                case 0:
                {
                    new furnitureid = pData[playerid][pEditFurniture];

                    if(FurnitureData[id][furnitureid][furnitureUnused])
                    {
                        FurnitureData[id][furnitureid][furnitureUnused] = 0;
                        FurnitureData[id][furnitureid][furniturePos][0] = x;
                        FurnitureData[id][furnitureid][furniturePos][1] = y;
                        FurnitureData[id][furnitureid][furniturePos][2] = z;
                        FurnitureData[id][furnitureid][furnitureRot][0] = 0.0;
                        FurnitureData[id][furnitureid][furnitureRot][1] = 0.0;
                        FurnitureData[id][furnitureid][furnitureRot][2] = angle;

                        Furniture_Refresh(furnitureid, id);
                    }
                    EditDynamicObject(playerid, FurnitureData[id][furnitureid][furnitureObject]);
                    Custom(playerid, "HOUSE", "You are now editing the position of item \"%s"WHITE"\".", FurnitureData[id][furnitureid][furnitureName]);
                }
                case 1:
                {
                    new furnitureid = pData[playerid][pEditFurniture];

                    if(FurnitureData[id][pData[playerid][pEditFurniture]][furnitureUnused])
                        return Error(playerid, "Attach this furniture first by select option \"Editing Position\"");

                    FurnitureData[id][furnitureid][furnitureUnused] = 0;
                    FurnitureData[id][furnitureid][furniturePos][0] = x;
                    FurnitureData[id][furnitureid][furniturePos][1] = y;
                    FurnitureData[id][furnitureid][furniturePos][2] = z;
                    FurnitureData[id][furnitureid][furnitureRot][0] = 0.0;
                    FurnitureData[id][furnitureid][furnitureRot][1] = 0.0;
                    FurnitureData[id][furnitureid][furnitureRot][2] = angle;

                    SetDynamicObjectPos(FurnitureData[id][furnitureid][furnitureObject], FurnitureData[id][furnitureid][furniturePos][0], FurnitureData[id][furnitureid][furniturePos][1], FurnitureData[id][furnitureid][furniturePos][2]);
                    SetDynamicObjectRot(FurnitureData[id][furnitureid][furnitureObject], FurnitureData[id][furnitureid][furnitureRot][0], FurnitureData[id][furnitureid][furnitureRot][1], FurnitureData[id][furnitureid][furnitureRot][2]);
                    Furniture_Refresh(furnitureid, id);
                    Furniture_Save(furnitureid, id);
                    Custom(playerid, "HOUSE", "Now this furniture is moved to in front you.");
                }
                case 2:
                {
                    Custom(playerid, "HOUSE", "You have destroyed furniture \"%s"WHITE"\".", FurnitureData[id][pData[playerid][pEditFurniture]][furnitureName]);
                    Furniture_Delete(pData[playerid][pEditFurniture], id);

                    CancelEdit(playerid);
                    pData[playerid][pEditFurniture] = -1;
                    pData[playerid][pEditFurnHouse] = -1;
                }
                case 3: {
                    new furnitureid = pData[playerid][pEditFurniture];

                    if (FurnitureData[id][furnitureid][furnitureUnused])
                        return Error(playerid, "This furniture is already stored");
                    
                    FurnitureData[id][furnitureid][furnitureUnused] = 1;
                    Furniture_Refresh(furnitureid, id);
                    Furniture_Save(furnitureid, id);
                    Custom(playerid, "HOUSE", "You have stored furniture \"%s"WHITE"\" into your house.", FurnitureData[id][furnitureid][furnitureName]);
                }
            }
        }
        else {
            pData[playerid][pEditFurniture] = -1;
            pData[playerid][pEditFurnHouse] = -1;
        }
    }
    else {
        pData[playerid][pEditFurniture] = -1;
        pData[playerid][pEditFurnHouse] = -1;
    }
    return 1;
}

