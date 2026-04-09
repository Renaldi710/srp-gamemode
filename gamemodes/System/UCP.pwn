
/*
ShowCharacterMenu(playerid) 
{
    new name[MAX_CHARACTERS * 50], count;

    for (new i; i < MAX_CHARACTERS; i ++) if(CharacterList[playerid][i][0] != EOS) {
      new feda[128];
      format(feda, sizeof feda, "%s\n", CharacterList[playerid][i]);
      strcat(name, feda);
      count++;
    }

    if(count < MAX_CHARACTERS)
      strcat(name, "<New Character>");

    ShowPlayerDialog(playerid, DIALOG_SELECTCHAR, DIALOG_STYLE_LIST, "Character List", name, "Select", "Quit");
    return 1;
}*/

#define CAMERA1_DIEM 1295.42, 748.90, 1061.02
#define CAMERA2_DIEM 1296.25, 748.38, 1060.84

#define CAMERA1_CHAR0 1295.86, 744.47, 1059.34
#define CAMERA2_CHAR0 1296.85, 744.49, 1059.22

#define CAMERA1_CHAR1 1300.28, 746.08, 1059.88
#define CAMERA2_CHAR1 1300.77, 745.21, 1059.78

#define CAMERA1_CHAR2 1309.87, 742.30, 1059.62
#define CAMERA2_CHAR2 1310.84, 742.06, 1059.60

#define SKINPOS_CHAR0 1298.0037,744.3879,1058.7932
#define SKINPOS_CHAR1 1301.4471,741.5056,1058.7932
#define SKINPOS_CHAR2 1314.3859,740.9257,1058.7932


#define SKINA_CHAR0 91.7153
#define SKINA_CHAR1 269.0832
#define SKINA_CHAR2 269.0834


function OnCharacterLoaded(playerid) 
{
    for (new i = 0; i < MAX_CHARACTERS; i ++) {
      CharacterList[playerid][i][0] = EOS;
    }

    for (new i = 0; i < cache_num_rows(); i ++) {
      cache_get_value_name(i, "username", CharacterList[playerid][i], 128);
      cache_get_value_name_int(i, "skin", CharacterSkin[playerid][i]);
    }

    ShowCharacterMenu(playerid);
    return 1;
}

//select char & register systems

ShowCharacterMenu(playerid) {
    forex(i, 10) {
        PlayerTextDrawShow(playerid, MultiChar[playerid][i]);
        SelectTextDraw(playerid, -1);
        SetSpawnInfo(playerid, 0, 1, 1309.7660,753.3946,1062.3527,240.0641, 0, 0, 0, 0, 0, 0);
        SpawnPlayer(playerid);
        Streamer_UpdateEx(playerid, 1309.7660,753.3946,1062.3527);
        SetCameraBehindPlayer(playerid);
        defer ApplyAnim(playerid);
        CharacterState[playerid] = true;
        SetPlayerCameraPos(playerid, CAMERA1_DIEM);
        SetPlayerCameraLookAt(playerid, CAMERA2_DIEM);
        if(CharacterList[playerid][0][0] != EOS) {
          PlayerTextDrawSetString(playerid, MultiChar[playerid][4], sprintf("%s", CharacterList[playerid][0][0]));
        } else {
          PlayerTextDrawSetString(playerid, MultiChar[playerid][4], "New Character");
        }
        if(CharacterList[playerid][1][0] != EOS) {
          PlayerTextDrawSetString(playerid, MultiChar[playerid][5], sprintf("%s", CharacterList[playerid][1][0]));
        } else {
          PlayerTextDrawSetString(playerid, MultiChar[playerid][5], "New Character");
        }
        if(CharacterList[playerid][2][0] != EOS) {
          PlayerTextDrawSetString(playerid, MultiChar[playerid][6], sprintf("%s", CharacterList[playerid][2][0]));
        } else {
          PlayerTextDrawSetString(playerid, MultiChar[playerid][6], "New Character");
        }
    }
    return 1;
}

timer ApplyAnim[999](playerid) {
  ApplyAnimation(playerid, "MISC", "SEAT_LR", 4.1, true, false, false, false, 0);
  return 1;
}