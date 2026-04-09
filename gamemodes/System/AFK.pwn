#include <YSI\y_hooks>

new
    AFKTick[MAX_PLAYERS] = { 0, ... },
    AFKChecker[MAX_PLAYERS] = { 0, ... },
    AFKTime[MAX_PLAYERS] = { 0, ... },
    PlayerAFKCode[MAX_PLAYERS];

hook OnPlayerUpdate(playerid)
{
    if(!pData[playerid][pSpawned])
        return 0;
    
    AFKTick[playerid] ++;
    return 1;
}

ptask Player_AFKUpdate[1000](playerid)
{
    if (!IsPlayerConnected(playerid) || !pData[playerid][pSpawned])
        return 0;

    if (AFKTick[playerid] > 10000)
    {
        AFKTick[playerid] = 1;
        AFKChecker[playerid] = 0;
    }
    if (AFKChecker[playerid] < AFKTick[playerid] && GetPlayerState(playerid) != PLAYER_STATE_NONE)
    {
        AFKChecker[playerid] = AFKTick[playerid];
        AFKTime[playerid] = 0;
    }
    else if (AFKChecker[playerid] == AFKTick[playerid] && GetPlayerState(playerid) != PLAYER_STATE_NONE)
    {
        AFKTime[playerid]++;

        if (AFKTime[playerid] > 3)
        {
            TogglePlayerControllable(playerid, 0);
            SetPlayerChatBubble(playerid, "[Away From Keyboard]", X11_ORANGE, 15.0, 1200);
            PlayerAFKCode[playerid] = RandomEx(1000,9999);
            Custom(playerid, "AFK", ""YELLOW"You are now in AFK Mode, to resume game use '"ORANGE"/afk %d"YELLOW"'", PlayerAFKCode[playerid]);
        }
        if (AFKTime[playerid] >= 1800)
        {
            SendClientMessageToAllEx(X11_TOMATO, "BotCmd: %s(%d) Telah di tendang dari server");
            SendClientMessageToAll(X11_TOMATO, "Reason: Afk lebih dari 30 menit");
            Kick(playerid);
        }
    }
    return 1;
}

CMD:afk(playerid, params[]) 
{
    new 
        code
    ;

    if (!IsPlayerConnected(playerid)) 
        return Error(playerid, "You are not logged in!")

    if (AFKTime[playerid] == 0) 
        return Error(playerid, "You're not in AFK Mode");

    if(sscanf(params, "d", code)) 
        return Usage(playerid, "/afk %d", PlayerAFKCode[playerid]);

    if(PlayerAFKCode[playerid] == code) 
    {
        TogglePlayerControllable(playerid, 1);
        PlayerAFKCode[playerid] = -1;
        AFKTick[playerid] = 0;
        AFKChecker[playerid] = 0;
        AFKTime[playerid] = 0;
        Custom(playerid, "AFK", ""YELLOW"You are now no longer in AFK Mode.");
    }
    else 
    {
        PlayerAFKCode[playerid] = RandomEx(100,999);
        Custom(playerid, "AFK", ""YELLOW"You are now in AFK Mode, to resume game use '"ORANGE"/afk %d"YELLOW"'", PlayerAFKCode[playerid]);
    }
    return 1;
}