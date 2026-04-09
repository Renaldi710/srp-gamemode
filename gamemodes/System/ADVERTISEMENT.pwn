
#define MAX_ADVERTISEMENTS							(100)
enum adsQueue {
    adsExists,
    adsContact,
    adsType,
    adsContent[128],
    adsContactName[52],
    adsMinutes,
    adsUsed,
    adsAntri
};

new AdsQueue[MAX_ADVERTISEMENTS][adsQueue];
new ListedAds[MAX_PLAYERS][10];
new PlayerAds[MAX_PLAYERS]; //mengatasi looping ads

Advertisement_Create(playerid, number, type, content[]) {
    new payout = strlen(content) * 2;
    if(GetPlayerMoney(playerid) < payout) return Error(playerid, "Not enough money.");
    new index = Advertisement_GetFreeID(), count = 1;
    if (index == -1) return Error(playerid, "Advertisement is full!");
    for (new i = 0; i < MAX_ADVERTISEMENTS; i ++) if (AdsQueue[index][adsAntri]) count++;
    AdsQueue[index][adsAntri] = true;
    AdsQueue[index][adsExists] = true;
    AdsQueue[index][adsContact] = number;
    AdsQueue[index][adsType] = type;
    strunpack(AdsQueue[index][adsContent], content);
    strunpack(AdsQueue[index][adsContactName], ReturnName2(playerid));
    AdsQueue[index][adsUsed] = 0;
    AdsQueue[index][adsMinutes] = count*20;
    pData[playerid][pAdvertiseTime] = 600;
    PlayerAds[playerid] = index;
    GivePlayerMoneyEx(playerid, -payout);
    Server_AddMoney(payout);
    Custom(playerid, "ADVERT", "You've paid {00FF00}%s {FFFFFF}(%d letters) for the advertisement", FormatMoney(payout), strlen(content));
    Custom(playerid, "ADVERT", "Your advertisement has been added to the queue and it'll be displayed in {FFFF00}%d minute(s)", AdsQueue[index][adsMinutes]/10);
    return 1;
}

Advertisement_GetFreeID() {
    for (new i = 0; i < MAX_ADVERTISEMENTS; i ++) if (!AdsQueue[i][adsExists]) {
        return i;
    }
    return -1;
}

ShowAdvertisements(playerid) {
    Dialog_Show(playerid, Dialog_Advertisements, DIALOG_STYLE_LIST, "Categories", "Automotive\nProperty\nEvent\nServices\nJob Search", "Select", "Cancel");
    return 1;
}

Advertisement_Remove(playerid) {
    for (new i = 0; i < MAX_ADVERTISEMENTS; i ++) if (AdsQueue[i][adsExists] && AdsQueue[i][adsUsed] == 1 && AdsQueue[i][adsContact] == pData[playerid][pPhone]) {
        AdsQueue[i][adsAntri] = false;
        AdsQueue[i][adsExists] = false;
        AdsQueue[i][adsContact] = 0;
        AdsQueue[i][adsContent] = EOS;
        AdsQueue[i][adsType] = 0;
        AdsQueue[i][adsUsed] = 0;
        AdsQueue[i][adsMinutes] = -1;
        PlayerAds[playerid] = -1;
    }
    return 1;
}

//optimized
ptask Advertise[1000](playerid) 
{
    if(pData[playerid][IsLoggedIn] && PlayerAds[playerid] > -1)
    {
        if(AdsQueue[PlayerAds[playerid]][adsMinutes] > 0) 
        {
            if(-- AdsQueue[PlayerAds[playerid]][adsMinutes] == 0) 
            {
                foreach(new i : Player)
                {
                    if(pData[i][pTogAds] == 0)
                    {
                        SendClientMessageEx(i, COLOR_RED, "{FF0000}Ad: {33AA33}%s", AdsQueue[PlayerAds[playerid]][adsContent]);
                        SendClientMessageEx(i, COLOR_RED, "{FF0000}Contact Info: [{33AA33}%s{FF0000}] Phone Number: [{33AA33}%d{FF0000}]", AdsQueue[PlayerAds[playerid]][adsContactName], AdsQueue[PlayerAds[playerid]][adsContact]);
                    }
                }
                AdsQueue[PlayerAds[playerid]][adsMinutes] = -1;
                AdsQueue[PlayerAds[playerid]][adsAntri] = false;
                AdsQueue[PlayerAds[playerid]][adsUsed] = 1;
                PlayerAds[playerid] = -1;
            }
        }
    }
    return 1;
}


Dialog:AdsType(playerid, response, listitem, inputtext[]) {
    new string[999];
    if (response) 
	{
       switch(listitem)
	   {
			case 0:
			{
                format(string, sizeof(string), ""YELLOW_E"Ad Preview:\n"RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]\n\n"WHITE_E"Category: "YELLOW_E"Automotive\n"WHITE_E"Lengt: "YELLOW_E"%d\n"WHITE_E"Price: "YELLOW_E"%s\n\nConfirm the advertisement?", 
                pData[playerid][pAdvertise], ReturnName2(playerid), pData[playerid][pPhone],
                strlen(pData[playerid][pAdvertise]), FormatMoney(strlen(pData[playerid][pAdvertise])*2));
                Dialog_Show(playerid, AdsConfirmAuto, DIALOG_STYLE_MSGBOX, "Confirm Advertisement", string, "Confirm", "Cancel");
			}
			case 1:
			{
				format(string, sizeof(string), ""YELLOW_E"Ad Preview:\n"RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]\n\n"WHITE_E"Category: "YELLOW_E"Property\n"WHITE_E"Lengt: "YELLOW_E"%d\n"WHITE_E"Price: "YELLOW_E"%s\n\nConfirm the advertisement?", 
                pData[playerid][pAdvertise], ReturnName2(playerid), pData[playerid][pPhone],
                strlen(pData[playerid][pAdvertise]), FormatMoney(strlen(pData[playerid][pAdvertise])*2));
                Dialog_Show(playerid, AdsConfirmPro, DIALOG_STYLE_MSGBOX, "Confirm Advertisement", string, "Confirm", "Cancel");
			}
			case 2:
			{
				format(string, sizeof(string), ""YELLOW_E"Ad Preview:\n"RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]\n\n"WHITE_E"Category: "YELLOW_E"Event\n"WHITE_E"Lengt: "YELLOW_E"%d\n"WHITE_E"Price: "YELLOW_E"%s\n\nConfirm the advertisement?", 
                pData[playerid][pAdvertise], ReturnName2(playerid), pData[playerid][pPhone],
                strlen(pData[playerid][pAdvertise]), FormatMoney(strlen(pData[playerid][pAdvertise])*2));
                Dialog_Show(playerid, AdsConfirmEvent, DIALOG_STYLE_MSGBOX, "Confirm Advertisement", string, "Confirm", "Cancel");
			}
			case 3:
			{
				format(string, sizeof(string), ""YELLOW_E"Ad Preview:\n"RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]\n\n"WHITE_E"Category: "YELLOW_E"Service\n"WHITE_E"Lengt: "YELLOW_E"%d\n"WHITE_E"Price: "YELLOW_E"%s\n\nConfirm the advertisement?", 
                pData[playerid][pAdvertise], ReturnName2(playerid), pData[playerid][pPhone],
                strlen(pData[playerid][pAdvertise]), FormatMoney(strlen(pData[playerid][pAdvertise])*2));
                Dialog_Show(playerid, AdsConfirmService, DIALOG_STYLE_MSGBOX, "Confirm Advertisement", string, "Confirm", "Cancel");
			}
			case 4:
			{
				format(string, sizeof(string), ""YELLOW_E"Ad Preview:\n"RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]\n\n"WHITE_E"Category: "YELLOW_E"Job Search\n"WHITE_E"Lengt: "YELLOW_E"%d\n"WHITE_E"Price: "YELLOW_E"%s\n\nConfirm the advertisement?", 
                pData[playerid][pAdvertise], ReturnName2(playerid), pData[playerid][pPhone],
                strlen(pData[playerid][pAdvertise]), FormatMoney(strlen(pData[playerid][pAdvertise])*2));
                Dialog_Show(playerid, AdsConfirmJob, DIALOG_STYLE_MSGBOX, "Confirm Advertisement", string, "Confirm", "Cancel");
			}
	   }
    }
    return 1;
}

Dialog:AdsConfirmAuto(playerid, response, listitem, inputtext[]) {
    if (response)  Advertisement_Create(playerid, pData[playerid][pPhone], 1, pData[playerid][pAdvertise]);
    return 1;
}

Dialog:AdsConfirmPro(playerid, response, listitem, inputtext[]) {
    if (response)  Advertisement_Create(playerid, pData[playerid][pPhone], 2, pData[playerid][pAdvertise]);
    return 1;
}

Dialog:AdsConfirmEvent(playerid, response, listitem, inputtext[]) {
    if (response)  Advertisement_Create(playerid, pData[playerid][pPhone], 3, pData[playerid][pAdvertise]);
    return 1;
}

Dialog:AdsConfirmService(playerid, response, listitem, inputtext[]) {
    if (response)  Advertisement_Create(playerid, pData[playerid][pPhone], 4, pData[playerid][pAdvertise]);
    return 1;
}

Dialog:AdsConfirmJob(playerid, response, listitem, inputtext[]) {
    if (response)  Advertisement_Create(playerid, pData[playerid][pPhone], 5, pData[playerid][pAdvertise]);
    return 1;
}

Dialog:Dialog_Advertisements(playerid, response, listitem, inputtext[]) {
    if (response) {
        new ads[150 * 10], count = 0;
        strcat(ads, "Contact Person\tContact Number\tAdvertisement\n");
        for (new i = 0; i < MAX_ADVERTISEMENTS; i ++) if (AdsQueue[i][adsExists] && AdsQueue[i][adsType] == (listitem + 1)) {
            if (strlen(AdsQueue[i][adsContent]) > 64) {
                format(ads, sizeof(ads), "%s%s\t%d\t%.64s...\n", ads, AdsQueue[i][adsContactName], AdsQueue[i][adsContact], AdsQueue[i][adsContent]);
            } else format(ads, sizeof(ads), "%s%s\t%d\t%s\n", ads, AdsQueue[i][adsContactName], AdsQueue[i][adsContact], AdsQueue[i][adsContent]);
            ListedAds[playerid][count++] = i;
        }
        if (!count) ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_LIST, inputtext, "Advertisement History", "Detail", "Back");
        else Dialog_Show(playerid, SelectAds, DIALOG_STYLE_TABLIST_HEADERS, "Advertisement History", ads, "Detail", "Back");
    }
    return 1;
}

Dialog:SelectAds(playerid, response, listitem, inputtext[]) {
    if (!response) ShowAdvertisements(playerid);
    else {
        new index = ListedAds[playerid][listitem],
            targetid = GetNumberOwner(AdsQueue[index][adsContact]);

        if (targetid == INVALID_PLAYER_ID)
            return Error(playerid, "The specified phone number is not in service.");

        if(targetid == playerid)
            return Dialog_Show(playerid, RemoveAds, DIALOG_STYLE_MSGBOX,"Advertisement","Are you sure you want to remove your ads?","Yes","No");

        //if(pData[targetid][pPhoneOff])
            //return Error(playerid, "The recipient has their cellphone powered off.");

        SetPVarInt(playerid, "replyTextTo", targetid);
        new lstr[512];
        format(lstr,sizeof(lstr),""RED_E"Ad: "GREEN_E"%s\n"RED_E"Contact Person: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]", AdsQueue[index][adsContent], AdsQueue[index][adsContactName], AdsQueue[index][adsContact]);
        Dialog_Show(playerid, ReplyAds, DIALOG_STYLE_MSGBOX,"Advertisement",lstr,"Reply","Close");
    }
    return 1;
}

Dialog:RemoveAds(playerid, response, listitem, inputtext[]) 
{
    if (response) 
    {
        Advertisement_Remove(playerid);
        Custom(playerid, "ADVERTISEMENT", ""YELLOW"You successfully removed your ads");
    } 
    return 1;
}

Dialog:ReplyAds(playerid, response, listitem, inputtext[]) {
    if (response) {
        new lstr[512], index = GetPVarInt(playerid, "replyTextTo");
        format(lstr,sizeof(lstr),"To: %d\nMessage:", pData[index][pPhone]);
        Dialog_Show(playerid, ReplyMessage, DIALOG_STYLE_INPUT,"Phone > Messaging > Write",lstr,"Send","Close");
    } else DeletePVar(playerid, "replyTextTo");
    return 1;
}

Dialog:ReplyMessage(playerid, response, listitem, inputtext[]) {
    if (response) {
        if (GetPVarInt(playerid, "replyTextTo") != INVALID_PLAYER_ID) {
            new targetid = GetPVarInt(playerid, "replyTextTo"), msg[64];

            if (sscanf(inputtext, "s[64]", msg))
                return Dialog_Show(playerid, ReplyMessage, DIALOG_STYLE_INPUT, "Reply Message", "Replying message to: %d", "Send", "Cancel", pData[targetid][pPhone]);

            if (strlen(msg) > 64)
                return Dialog_Show(playerid, ReplyMessage, DIALOG_STYLE_INPUT, "Reply Message", "Replying message to: %d", "Send", "Cancel", pData[targetid][pPhone]);

            new ph = pData[targetid][pPhone];
			new String[512];
			if (!ph)
            return Error(playerid, "The specified phone number is not in service.");
            format(String, sizeof(String), "%d %s", ph, inputtext);
            callcmd::sms(playerid, String);
        }
    } else DeletePVar(playerid, "replyTextTo");
    return 1;
}


CMD:ads(playerid, params[])
{
	ShowAdvertisements(playerid);
	return 1;
}

CMD:ad(playerid, params[])
{
	if(isnull(params)) return Usage(playerid, "(/ad)vertise [advert text]");
    if(pData[playerid][pPhone] < 1) return Error(playerid, "You dont have phone!");
	//if(pData[playerid][pCS] < 1) return Error(playerid, "Anda harus mempunyai Character Story untuk membuat iklan!");
	if(pData[playerid][pVip] > 1)
	{
		if(pData[playerid][pAdvertiseTime] > 0) return Error(playerid, "Tunggu %d menit untuk membuat iklan.", pData[playerid][pAdvertiseTime] / 60);
		if(isnull(params)) return Usage(playerid, "(/ad)vertise [advert text]");
		if (strlen(params) > 200) return Error(playerid, "Max characters length is 200 chars");
		format(pData[playerid][pAdvertise], 200, params);
		Dialog_Show(playerid, AdsType, DIALOG_STYLE_LIST, "Advertisement Type", "Automotive\nProperty\nEvent\nService\nJob Search", "Input", "Close");
    }
	else
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2461.21, 2270.42, 91.67)) return Error(playerid, "You must in SANA Station!");
		if(pData[playerid][pAdvertiseTime] > 0) return Error(playerid, "Tunggu %d menit untuk membuat iklan.", pData[playerid][pAdvertiseTime] / 60);
		if(isnull(params)) return Usage(playerid, "(/ad)vertise [advert text]");
		if (strlen(params) > 200) return Error(playerid, "Max characters length is 200 chars");
		format(pData[playerid][pAdvertise], 200, params);
		Dialog_Show(playerid, AdsType, DIALOG_STYLE_LIST, "Advertisement Type", "Automotive\nProperty\nEvent\nService\nJob Search", "Input", "Close");
	}
    return 1;
}

