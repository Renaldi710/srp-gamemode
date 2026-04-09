//Enums
#define MAX_ASKS (50)

enum askData {
    bool:askExists,
    askType,
    askPlayer,
    askText[128 char]
};
new AskData[MAX_ASKS][askData];


Ask_GetCount(playerid)
{
    new count;

    for (new i = 0; i != MAX_ASKS; i ++)
    {
        if(AskData[i][askExists] && AskData[i][askPlayer] == playerid)
        {
			count++;
        }
    }
    return count;
}

Ask_Clear(playerid)
{
    for (new i = 0; i != MAX_ASKS; i ++)
    {
        if(AskData[i][askExists] && AskData[i][askPlayer] == playerid)
        {
            Ask_Remove(i);
        }
    }
}

Ask_Add(playerid, const text[], type = 1)
{
    for (new i = 0; i != MAX_ASKS; i ++)
    {
        if(!AskData[i][askExists])
        {
            AskData[i][askExists] = true;
            AskData[i][askType] = type;
            AskData[i][askPlayer] = playerid;

            strpack(AskData[i][askText], text, 128 char);
            return i;
        }
    }
    return -1;
}

Ask_Remove(reportid)
{
    if(reportid != -1 && AskData[reportid][askExists] == true)
    {
        AskData[reportid][askExists] = false;
        AskData[reportid][askPlayer] = INVALID_PLAYER_ID;
    }
    return 1;
}

CMD:ask(playerid, params[])
{
    new reportid = -1;

    if(isnull(params))
    {
        Usage(playerid, "/ask [pertanyaan]");
        Info(playerid, "Command ini khusus untuk pertanyaan.");
        return 1;
    }
    if(Ask_GetCount(playerid) > 1)
        return Error(playerid, "Kamu sudah memiliki 1 Pertanyaan!");

    if(pData[playerid][pAskTime] >= gettime())
        return Error(playerid, "Mohon tunggu %d detik untuk mengajukan pertanyaan.", pData[playerid][pAskTime] - gettime());

    if((reportid = Ask_Add(playerid, params)) != -1)
    {
        Custom(playerid, "ASK", "Pertanyaan anda: {FFFF00}%s", params);
        SendStaffMessage(ARWIN, "[ASK #%d] "YELLOW"%s(%d): "WHITE"%s", reportid, pData[playerid][pName], playerid, params);
        pData[playerid][pReportTime] = gettime() + 180;
    }
    else Error(playerid, "Pertanyaan sedang penuh!");
    return 1;
}

CMD:ans(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return Error(playerid, "Kamu tidak memiliki hak untuk menggunakan ini!");

    new reportid, msg[32];
    if(sscanf(params,"ds[32]", reportid, msg))
        return Usage(playerid, "/ans [ask id] [jawaban] (/asks for a list)");

    if((reportid < 0 || reportid >= MAX_ASKS) || !AskData[reportid][askExists])
        return Error(playerid, "ID Ask tidak valid, Listitem dari 0 sampai %d.", MAX_ASKS);

    SendStaffMessage(ARWIN, "[ANSWER #%d] "RED"%s "WHITE" has accepted "YELLOW"%s(%d) "WHITE"ask.", pData[playerid][pAdminname], pData[AskData[reportid][askPlayer]][pName], AskData[reportid][askPlayer]);
    Custom(AskData[reportid][askPlayer], "[ANSWER]" ,"{FF0000}%s {FFFFFF}: %s.", pData[playerid][pAdminname], msg);

    Ask_Remove(reportid);
    return 1;
}

CMD:asks(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
			
	new gstr[1024], mstr[128], lstr[512];
    strcat(gstr,"ID\tPlayer\tDescription\n",sizeof(gstr));

    for (new i = 0; i != MAX_ASKS; i ++) if(AskData[i][askExists])
    {       
        strunpack(mstr, AskData[i][askText]);

        if(strlen(mstr) > 32)
            format(lstr,sizeof(lstr), "#%d\t%s (%d)\t%.32s ...\n", i, pData[AskData[i][askPlayer]][pName], AskData[i][askPlayer], mstr);
        else
            format(lstr,sizeof(lstr), "#%d\t%s (%d)\t%s\n", i, pData[AskData[i][askPlayer]][pName], AskData[i][askPlayer], mstr);

        strcat(gstr,lstr,sizeof(gstr));
    }
    ShowPlayerDialog(playerid, DIALOG_ASKS, DIALOG_STYLE_TABLIST_HEADERS, "Ask List",gstr,"Next","Cancel");
    return 1;
}

CMD:clearask(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
            return PermissionError(playerid);
    new
        count;

    for (new i = 0; i != MAX_ASKS; i ++)
    {
        if(AskData[i][askExists]) {
            Ask_Remove(i);
            count++;
        }
    }
    if(!count)
        return Error(playerid, "Tidak ada Pertanyaan yang aktif.");
            
    SendStaffMessage(X11_TOMATO, "AdmCmd: %s has removed all asks on the server.", pData[playerid][pAdminname]);
    return 1;
}