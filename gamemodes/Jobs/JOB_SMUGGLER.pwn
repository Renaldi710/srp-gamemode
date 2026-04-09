#define SMUGGLER_SALARY 5000
#define MAX_PACKET 5

new selectedLocation;
new packetStatus[MAX_PACKET];
new packetPlayerid[MAX_PACKET] = {INVALID_PLAYER_ID, ...};
new packetObject[MAX_PACKET], Text3D:packetLabel[MAX_PACKET];
new packetActive = 0;

new Float:pickPacket[][3] = {
  {-1293.7229,2524.0850,87.4563},
  {-772.7677,2423.5154,157.0893}
};

new Float:storePacket[][3] = {
  {1568.2803,30.8219,24.1641},
  {859.2977,-18.9858,63.3022}
};


static SendSmugglerMessage(color, const str[], {Float,_}:...)
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

        foreach (new i : Player) if (pData[i][pJob] == 12 || pData[i][pJob2] == 12) {
            SendClientMessage(i, color, string);
        }
        return 1;
    }
    foreach (new i : Player) if (pData[i][pJob] == 12 || pData[i][pJob2] == 12) {
        SendClientMessage(i, color, str);
    }
    return 1;
}


#include <YSI\y_hooks>
hook OnPlayerEnterRaceCP(playerid)
{   
  if (pData[playerid][pJob] == 12 || pData[playerid][pJob2] == 12) {
    if (GetPVarInt(playerid, "sedangSmuggler") == 1) {
      GameTextForPlayer(playerid, "~p~SMUGGLER PACKET~n~~w~USE ~R~/GETPACKET~w~ TO PICKUP PACKET", 3000, 4);
    } else if (pData[playerid][pSmugglerPick] && GetPVarInt(playerid, "sedangNganter") == 1) {
      GivePlayerMoneyEx(playerid, SMUGGLER_SALARY);
      pData[playerid][pSmugglerPick] = 0;
      pData[playerid][pSmugglerFind] = 0;
      packetPlayerid[selectedLocation] = INVALID_PLAYER_ID;
      packetStatus[selectedLocation] = 0;
      DeletePVar(playerid, "sedangSmuggler");
      DeletePVar(playerid, "sedangNganter");
      packetActive = 0;
      pData[playerid][pSmugglerTime] = 3600;
      new strings[214];

      if(selectedLocation == 0)
      {
        Material += 2;
        format(strings, sizeof(strings), ""RED_E"[ARMS DEALER]\n"YELLOW_E"'/getjob' "WHITE_E"to be an Arms Dealer\n"YELLOW_E"'/buyschematic' "WHITE_E"to buy gun schematicn\n"YELLOW_E"'/buypacket' "WHITE_E"buy material packet\nAvailable packages: "GREEN"%d", Material);
        UpdateDynamic3DTextLabelText(Material, ARWIN, strings);
      }
      if(selectedLocation == 1)
      {
        Marijuana += 2;
        format(strings, sizeof(strings), ""RED_E"[DRUG DEALER]\n"YELLOW_E"'/getjob' "WHITE_E"to be an Drug Dealer\n"YELLOW_E"'/buypacket' "WHITE_E"to buy drugs package\nAvailable packages: "GREEN_E"%d", Marijuana);
        UpdateDynamic3DTextLabelText(Crack, ARWIN, strings);
      }
      Server_Save();
      foreach (new i : Player) if (pData[i][pJob] == 12 || pData[i][pJob2] == 12) {
        pData[i][pSmugglerPick] = 0;
        pData[i][pSmugglerFind] = 0;
        DeletePVar(i, "sedangSmuggler");
        DeletePVar(i, "sedangNganter");
      }
      DisablePlayerRaceCheckpoint(playerid);
      Custom(playerid, "SMUGGLER", "You've been stored the packet and you'll received "GREEN_E"%s", FormatMoney(SMUGGLER_SALARY));
    }
  }
  return 1;
}


task PacketUpdate[300000]() {
  if (packetActive == 0) {
    selectedLocation = random(sizeof(pickPacket));
    if (packetStatus[selectedLocation] == 0) {
      packetStatus[selectedLocation] = 1;
      packetObject[selectedLocation] = CreateDynamicObject(1279, pickPacket[selectedLocation][0], pickPacket[selectedLocation][1], pickPacket[selectedLocation][2]-0.9, 0.0, 0.0, 0.0, 0, 0);
      packetActive = 1;
      SendSmugglerMessage(ARWIN, "SMUGGLER: "WHITE"New packet available '"YELLOW_E"/findpacket"WHITE_E"' to find the packet.");
    }
  } else SendSmugglerMessage(ARWIN, "SMUGGLER: "WHITE"Smuggler job is currently active, use '"YELLOW_E"/findpacket"WHITE_E"' to find the packet.");
}


CMD:findpacket(playerid, params[]) {
  if (pData[playerid][pJob] != 12 && pData[playerid][pJob2] != 12)
    return Error(playerid, "You don't have the appropriate job.");
  
  if (pData[playerid][pSmugglerPick])
    return Error(playerid, "Kamu tidak bisa mengambil packet yang lain, karena kamu sedang mengantarkan paket.");
  if(pData[playerid][pSmugglerTime] > 0) return Error(playerid, "Tidak bisa menggunakan command ini, anda masih terkena delay");
  if (packetStatus[selectedLocation] == 1) {
    SetPlayerRaceCheckpoint(playerid, 1,  pickPacket[selectedLocation][0], pickPacket[selectedLocation][1], pickPacket[selectedLocation][2], 0, 0, 0, 3.0);
    pData[playerid][pSmugglerFind] = 1;
    SetPVarInt(playerid, "sedangSmuggler", 1);
    Custom(playerid, "SMUGGLER", "Please goto the marked location to pickup the packet.");
  } else if (packetStatus[selectedLocation] == 2) {
    new Float:pos[3], Float:oPos[3];
    GetPlayerPos(packetPlayerid[selectedLocation], pos[0], pos[1], pos[2]);
    DisablePlayerRaceCheckpoint(playerid);
    SetPlayerRaceCheckpoint(playerid, 1, pos[0], pos[1], pos[2], 0, 0, 0, 3.0);

    if (packetPlayerid[selectedLocation] == INVALID_PLAYER_ID) {
        GetDynamicObjectPos(packetObject[selectedLocation], oPos[0], oPos[1], oPos[2]);
        SetPlayerRaceCheckpoint(playerid, 1, oPos[0], oPos[1], oPos[2], 0, 0, 0, 3.0);
    }
    SetPVarInt(playerid, "sedangSmuggler", 1);
    Custom(playerid, "SMUGGLER", "Please goto the marked location to pickup the packet.");
  } else {
    Error(playerid, "Tidak ada paket yang perlu dikirim.");
  }
  return 1;
}

CMD:pickpacket(playerid, params[]) {
  if (pData[playerid][pJob] != 12 && pData[playerid][pJob2] != 12)
    return Error(playerid, "You don't have the appropriate job.");
  if(pData[playerid][pSmugglerTime] > 0) return Error(playerid, "Tidak bisa menggunakan command ini, anda masih terkena delay");
  new Float:oPos[3];
  GetDynamicObjectPos(packetObject[selectedLocation], oPos[0], oPos[1], oPos[2]);

  if (!IsPlayerInRangeOfPoint(playerid, 3.0, oPos[0], oPos[1], oPos[2]))
    return Error(playerid, "You're not near any packet.");

  SetPVarInt(playerid, "sedangNganter", 1);
  SetPVarInt(playerid, "sedangSmuggler", 0);

  DestroyDynamicObject(packetObject[selectedLocation]);
  packetObject[selectedLocation] = INVALID_STREAMER_ID;
  DestroyDynamic3DTextLabel(packetLabel[selectedLocation]);
  packetLabel[selectedLocation] = Text3D:INVALID_3DTEXT_ID;
  pData[playerid][pSmugglerPick] = 1;
  pData[playerid][pSmugglerFind] = 0;
  packetPlayerid[selectedLocation] = playerid;
  packetStatus[selectedLocation] = 2;
  SetPlayerRaceCheckpoint(playerid, 1, storePacket[selectedLocation][0], storePacket[selectedLocation][1], storePacket[selectedLocation][2], 0, 0, 0, 3.0);
  Custom(playerid, "SMUGGLER", "You've pickup the packet, please go to marked location to store this packet!");
  return 1;
}

CMD:getpacket(playerid, params[]) {
  if (pData[playerid][pJob] != 12 && pData[playerid][pJob2] != 12)
    return Error(playerid, "You don't have the appropriate job.");
  if(pData[playerid][pSmugglerTime] > 0) return Error(playerid, "Tidak bisa menggunakan command ini, anda masih terkena delay");
  if (GetPVarInt(playerid, "sedangSmuggler") == 1) {
    if (IsPlayerInRangeOfPoint(playerid, 3.0, pickPacket[selectedLocation][0], pickPacket[selectedLocation][1], pickPacket[selectedLocation][2]) && pData[playerid][pSmugglerFind]) {
      packetPlayerid[selectedLocation] = playerid;
      packetStatus[selectedLocation] = 2;
      foreach (new i : Player) if (pData[i][pJob] == 8 || pData[i][pJob2] == 8) {
        if (GetPVarInt(i, "sedangSmuggler") == 1) {
          DisablePlayerRaceCheckpoint(i);
        }
        Custom(i, "[SMUGGLER", "Someone has already pickup the packet, packet was moved!");
        Custom(i, "[SMUGGLER", "Type /findpacket again to know the packet location.");
      }
      pData[playerid][pSmugglerPick] = 1;
      pData[playerid][pSmugglerFind] = 0;
      SetPVarInt(playerid, "sedangNganter", 1);
      SetPVarInt(playerid, "sedangSmuggler", 0);
      DestroyDynamicObject(packetObject[selectedLocation]);
      packetObject[selectedLocation] = INVALID_STREAMER_ID;
      SetPlayerRaceCheckpoint(playerid, 1, storePacket[selectedLocation][0], storePacket[selectedLocation][1], storePacket[selectedLocation][2], 0, 0, 0, 3.0);
      ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
      Custom(playerid, "SMUGGLER", "You've pickup the packet, please go to marked location to store this packet!");
    } else return Error(playerid, "Please go to the marked location, to pickup the packet.");
  }
  return 1;
}

CMD:droppacket(playerid) {
  if (pData[playerid][pJob] != 12 && pData[playerid][pJob2] != 12)
    return Error(playerid, "You don't have the appropriate job.");

  if (pData[playerid][pSmugglerPick] == 0 && GetPVarInt(playerid, "sedangNganter") == 0)
    return Error(playerid, "You are not being sending any packet.");

  new Float:pos[3];
  GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
  packetPlayerid[selectedLocation] = INVALID_PLAYER_ID;
  packetObject[selectedLocation] = CreateDynamicObject(1279, pos[0], pos[1], pos[2]-0.9, 0.0, 0.0, 0.0, 0, 0);
  packetLabel[selectedLocation] = CreateDynamic3DTextLabel("[Packet]\n"WHITE_E"Type "YELLOW_E"/pickpacket"WHITE_E" to pick the packet.", ARWIN, pos[0], pos[1], pos[2]+0.5, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
  pData[playerid][pSmugglerPick] = 0;
  pData[playerid][pSmugglerFind] = 0;
  DisablePlayerRaceCheckpoint(playerid);
  Custom(playerid, "SMUGGLER", "You've dropped the packet");
  DeletePVar(playerid, "sedangSmuggler");
  DeletePVar(playerid, "sedangNganter");
  return 1;
}

CMD:resetsmuggler(playerid, params[]) {
  if (pData[playerid][pAdmin] < 5)
    return PermissionError(playerid);

  packetActive = 0;
  packetPlayerid[selectedLocation] = INVALID_PLAYER_ID;
  packetStatus[selectedLocation] = 0;
  foreach (new i : Player) if (pData[i][pJob] == 12 || pData[i][pJob2] == 12) {
    pData[i][pSmugglerPick] = 0;
    pData[i][pSmugglerFind] = 0;
    DeletePVar(i, "sedangSmuggler");
    DeletePVar(i, "sedangNganter");
  }
  Custom(playerid, "RESET", "You've reseted smuggler packet.");
  return 1;
}

CMD:testsmuggler(playerid, params[]) {
  if (pData[playerid][pAdmin] < 5)
    return PermissionError(playerid);

  if (packetActive == 0) {
    selectedLocation = random(sizeof(pickPacket));
    if (packetStatus[selectedLocation] == 0) {
      packetStatus[selectedLocation] = 1;
      packetObject[selectedLocation] = CreateDynamicObject(1279, pickPacket[selectedLocation][0], pickPacket[selectedLocation][1], pickPacket[selectedLocation][2]-0.9, 0.0, 0.0, 0.0, 0, 0);
      packetActive = 1;
      SendSmugglerMessage(ARWIN, "SMUGGLER: "WHITE"New packet available '"YELLOW_E"/findpacket"WHITE_E"' to find the packet.");
      printf("%d", selectedLocation);
    }
  } else SendSmugglerMessage(ARWIN, "SMUGGLER: "WHITE"Smuggler job is currently active, use '"YELLOW_E"/findpacket"WHITE_E"' to find the packet.");
  return 1;
}
