#define MAX_CONTACTS (50)

enum contactData 
{
	contactID,
	contactExists,
	contactName[32],
	contactNumber
};

new ContactData[MAX_PLAYERS][MAX_CONTACTS][contactData];
new ListedContacts[MAX_PLAYERS][MAX_CONTACTS];

function OnContactsLoad(playerid)
{
    new owner[128];
	
    new rows = cache_num_rows();
 	if(rows)
  	{
		for (new i = 0; i < rows && i < MAX_CONTACTS; i ++) 
		{
			ContactData[playerid][i][contactExists] = true;
			cache_get_value_name_int(i, "contactID", ContactData[playerid][i][contactID]);
			cache_get_value_name(i, "contactName", owner);
			format(ContactData[playerid][i][contactName], 128, owner);			
			cache_get_value_name_int(i, "contactNumber", ContactData[playerid][i][contactNumber]);
		}	
	}
}

function OnContactAdd(playerid, id)
{
	ContactData[playerid][id][contactID] = cache_insert_id();
	return 1;
}

GetNumberOwner(number)
{
	foreach (new i : Player) if (pData[i][pPhone] == number)
	{
		return i;
	}
	return INVALID_PLAYER_ID;
}

GetContactNameByNumber(playerid, number)
{
    new 
        name[MAX_PLAYER_NAME];

    for (new i = 0; i != MAX_CONTACTS; i ++) if(ContactData[playerid][i][contactExists] && ContactData[playerid][i][contactNumber] == number) {
        format(name, 24, "%s", ContactData[playerid][i][contactName]);
        return name;
    }
    format(name, 24, "Unknown");
    return name;
}

stock ShowContacts(playerid)
{
	new
	    string[32 * MAX_CONTACTS],
		count = 0;

	string = "Add Contact\n";

	for (new i = 0; i != MAX_CONTACTS; i ++) if (ContactData[playerid][i][contactExists]) 
	{
	    format(string, sizeof(string), "%s%s - "YELLOW_E"#%d\n", string, ContactData[playerid][i][contactName], ContactData[playerid][i][contactNumber]);

		ListedContacts[playerid][count++] = i;
	}
	Dialog_Show(playerid, Contacts, DIALOG_STYLE_LIST, "My Contacts", string, "Select", "Back");
	return 1;
}

ShowPlayerSMS(playerid)
{
	new query[512], list[4056], type, number, msg[1012];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM sms WHERE owner = '%d' ORDER BY id ASC", pData[playerid][pID]);
	mysql_query(g_SQL, query);
	new rows = cache_num_rows();
	if(rows)
	{
		format(list, sizeof(list), "Info\tMessage\n");
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name_int(i, "type", type);
			cache_get_value_name_int(i, "number", number);
			cache_get_value_name(i, "message", msg);
			switch(type)
			{
				case 1:
				{
					format(list, sizeof(list), "%sSMS To #%d\t%s\n", list, number, msg);
				}
				case 2:
				{
					format(list, sizeof(list), "%sSMS From #%d\t%s\n", list, number, msg);
				}
			}
		}
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "SMS History", list, "Close", "");
	}
    else
    {
        Error(playerid, "Anda tidak memiliki pesan kepada siapa pun");
    }
	return 1;
}

function OnSMSsend(playerid, no, sms[])
{
	new name[32], id, String[212];
	if(cache_num_rows() > 0)
	{
		cache_get_value_name(0, "username", name);
		cache_get_value_name_int(0, "reg_id", id);	
		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO sms(owner, message, number, type) VALUES ('%d', '%s', '%d', '%d')", id, sms, pData[playerid][pPhone], 2);
		mysql_tquery(g_SQL, query);

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO sms(owner, message, number, type) VALUES ('%d', '%s', '%d', '%d')", pData[playerid][pID], sms, no, 1);
		mysql_tquery(g_SQL, query);

		new nametarget[32];
		for (new i = 0; i != MAX_CONTACTS; i ++) if (ContactData[playerid][i][contactExists]) 
		{
			if(no == ContactData[playerid][i][contactNumber])
			{
				format(nametarget, 32, "%s", ContactData[playerid][i][contactName]);
			}
			else
			{
				format(nametarget, 32, "%s", "Unknow");
			}
		}
		SendClientMessageEx(playerid, COLOR_WHITE, "AME: {C2A2DA}types something to his cellphone");
		format(String, sizeof(String), "types something to his cellphone");
		SetPlayerChatBubble(playerid, String, COLOR_PURPLE, 5.0, 5000);
		SendClientMessageEx(playerid, COLOR_RED, "SMS: "YELLOW_E"Message sent to {00FFFF}%s (%d)", nametarget, no);
		SendClientMessageEx(playerid, COLOR_RED, "MESSAGE: "YELLOW_E"%s", sms);
	}
	return 1;
}


Dialog:SMSReply(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if (isnull(inputtext))
			return Dialog_Show(playerid, SMSReply, DIALOG_STYLE_INPUT, "Message Reply", "Error: Please enter a message to send.\n\nPlease enter the message to send to %d:", "Send", "Back", pData[playerid][pSMS]);

		new ph = pData[playerid][pSMS], String[212];

		if (!ph)
	    return Error(playerid, "The specified phone number is not in service.");
		format(String, sizeof(String), "%d %s", ph, inputtext);
		callcmd::sms(playerid, String);
	}
	return 1;
}

Dialog:MyPhone(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch (listitem)
		{
		    case 0:
		    {
		        if (pData[playerid][pUsePhone] == 0)
		            return Error(playerid, "Your phone must be powered on.");

				Dialog_Show(playerid, DialNumber, DIALOG_STYLE_INPUT, "Dial Number", "Please enter the number that you wish to dial below:", "Dial", "Back");
			}
			case 1:
			{
			    if (pData[playerid][pUsePhone] == 0)
		            return Error(playerid, "Your phone must be powered on.");

                if(pData[playerid][pPhoneBook] == 0)
                    return Error(playerid, "Anda harus mempunyai phone book.");

			    ShowContacts(playerid);
			}
		    case 2:
		    {
		        if (pData[playerid][pUsePhone] == 0)
		            return Error(playerid, "Your phone must be powered on.");

		        Dialog_Show(playerid, SendText, DIALOG_STYLE_INPUT, "Send Text Message", "Please enter the number that you wish to send a text message to:", "Dial", "Back");
			}
			case 3:
			{
			    if (pData[playerid][pUsePhone] == 1)
			    {
					pData[playerid][pUsePhone] = 0;
			        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has powered off their cellphone.", ReturnName(playerid));
				}
				else
				{
				    pData[playerid][pUsePhone] = 1;
			        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has powered on their cellphone.", ReturnName(playerid));
				}
			}
			case 4:
			{
				ShowPlayerSMS(playerid);
			}
			case 5:
			{
				if(pData[playerid][pVip] < 1) return PermissionError(playerid);
				if(pData[playerid][pPhonePrivacy] == 1)
				{
					pData[playerid][pPhonePrivacy] = 0;
					SendClientMessageEx(playerid, COLOR_WHITE, "You have disabled the phone privacy feature.");
				}
				else
				{
					pData[playerid][pPhonePrivacy] = 1;
					SendClientMessageEx(playerid, COLOR_WHITE, "You have enabled the phone privacy feature.");
				}
			}
		}
	}
	return 1;
}

Dialog:SendText(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new number = strval(inputtext);

	    if (isnull(inputtext) || !IsNumeric(inputtext))
	        return Dialog_Show(playerid, SendText, DIALOG_STYLE_INPUT, "Send Text Message", "Please enter the number that you wish to send a text message to:", "Dial", "Back");

        if (GetNumberOwner(number) == INVALID_PLAYER_ID)
            return Dialog_Show(playerid, SendText, DIALOG_STYLE_INPUT, "Send Text Message", "Error: That number is not online right now.\n\nPlease enter the number that you wish to send a text message to:", "Dial", "Back");

		pData[playerid][pContact] = GetNumberOwner(number);
		Dialog_Show(playerid, TextMessage, DIALOG_STYLE_INPUT, "Text Message", "Please enter the message to send to %s:", "Send", "Back", ReturnName(pData[playerid][pContact]));
	}
	else
	{
		return callcmd::phone(playerid, "\1");
	}
	return 1;
}

Dialog:TextMessage(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if (isnull(inputtext))
			return Dialog_Show(playerid, TextMessage, DIALOG_STYLE_INPUT, "Text Message", "Error: Please enter a message to send.\n\nPlease enter the message to send to %s:", "Send", "Back", ReturnName(pData[playerid][pContact]));

		new ph = pData[playerid][pContact], String[212];

		if (!ph)
	    return Error(playerid, "The specified phone number is not in service.");
		format(String, sizeof(String), "%d %s", ph, inputtext);
		callcmd::sms(playerid, String);
	}
	else 
	{
        Dialog_Show(playerid, SendText, DIALOG_STYLE_INPUT, "Send Text Message", "Please enter the number that you wish to send a text message to:", "Submit", "Back");
	}
	return 1;
}

Dialog:DialNumber(playerid, response, listitem, inputtext[])
{
	if (response)
	{

	    if (isnull(inputtext) || !IsNumeric(inputtext))
	        return Dialog_Show(playerid, DialNumber, DIALOG_STYLE_INPUT, "Dial Number", "Please enter the number that you wish to dial below:", "Dial", "Back");
	}
	else 
	{
		return callcmd::phone(playerid, "\1");
	}
	return 1;
}

Dialog:EnterNumber(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    static
	        name[32],
			string[128];

		strunpack(name, pData[playerid][pEditingItem]);

	    if (isnull(inputtext) || !IsNumeric(inputtext))
	        return Dialog_Show(playerid, EnterNumber, DIALOG_STYLE_INPUT, "Contact Number", "Contact Name: %s\n\nPlease enter the phone number for this contact:", "Submit", "Back", name);

		for (new i = 0; i != MAX_CONTACTS; i ++)
		{
			if (!ContactData[playerid][i][contactExists])
			{
            	ContactData[playerid][i][contactExists] = true;
            	ContactData[playerid][i][contactNumber] = strval(inputtext);

				format(ContactData[playerid][i][contactName], 32, name);

				format(string, sizeof(string), "INSERT INTO `contacts` (`ID`, `contactName`, `contactNumber`) VALUES('%d', '%s', '%d')", pData[playerid][pID], name, ContactData[playerid][i][contactNumber]);
				mysql_tquery(g_SQL, string, "OnContactAdd", "dd", playerid, i);

				Info(playerid, "You have added \"%s\" to your contacts.", name);
                return 1;
			}
	    }
	    Error(playerid, "There is no room left for anymore contacts.");
	}
	else {
		ShowContacts(playerid);
	}
	return 1;
}

Dialog:NewContact(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext))
			return Dialog_Show(playerid, NewContact, DIALOG_STYLE_INPUT, "New Contact", "Error: Please enter a contact name.\n\nPlease enter the name of the contact below:", "Submit", "Back");

	    if (strlen(inputtext) > 32)
	        return Dialog_Show(playerid, NewContact, DIALOG_STYLE_INPUT, "New Contact", "Error: The contact name can't exceed 32 characters.\n\nPlease enter the name of the contact below:", "Submit", "Back");

		strpack(pData[playerid][pEditingItem], inputtext, 32);

	    Dialog_Show(playerid, EnterNumber, DIALOG_STYLE_INPUT, "Contact Number", "Contact Name: %s\n\nPlease enter the phone number for this contact:", "Submit", "Back", inputtext);
	}
	else 
	{
		ShowContacts(playerid);
	}
	return 1;
}

Dialog:ContactInfo(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
			id = pData[playerid][pContact],
			string[72];

		switch (listitem)
		{
		    case 0:
		    {
				new phonenumb = ContactData[playerid][id][contactNumber], String[212];
				foreach(new ii : Player)
				{
					if(pData[ii][pPhone] == phonenumb)
					{
						if(pData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");
						if(pData[ii][pUsePhone] == 0) return Error(playerid, "The specified phone number went offline");
						if(pData[ii][pCall] == INVALID_PLAYER_ID)
						{
							pData[playerid][pCall] = ii;

							format(String, sizeof(String), "PHONE: {ffffff}Ponsel anda berbunyi!, nomor {ffff00}%s (%d) {ffffff}mencoba untuk menghubungi anda, /p untuk menjawab", GetContactNameByNumber(ii, pData[playerid][pPhone]), pData[playerid][pPhone]);
							SendClientMessageEx(ii, ARWIN, String);
							format(String, sizeof(String), "PHONE: {ffffff}Anda telah mencoba menghubungi nomor {ffff00}%s (%d) {ffffff}silahkan tunggu sampai di jawab", GetContactNameByNumber(playerid, pData[ii][pPhone]), phonenumb);
							SendClientMessageEx(playerid, ARWIN, String);
							PlayerPlaySound(playerid, 1052, 0,0,0);
							PlayerPlaySound(ii, 1139, 0,0,0);
							SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out a cellphone and calling someone.", ReturnName(playerid));
							return 1;
						}
						else
						{
							Error(playerid, "Nomor ini sedang sibuk.");
							return 1;
						}
					}
				}
		    }
		    case 1:
		    {
		        format(string, sizeof(string), "DELETE FROM `contacts` WHERE `ID` = '%d' AND `contactID` = '%d'", pData[playerid][pID], ContactData[playerid][id][contactID]);
		        mysql_tquery(g_SQL, string);

		        Info(playerid, ""WHITE_E"You have deleted "YELLOW_E"%s "WHITE_E"from your contacts.", ContactData[playerid][id][contactName]);

		        ContactData[playerid][id][contactExists] = false;
		        ContactData[playerid][id][contactNumber] = 0;
		        ContactData[playerid][id][contactID] = 0;
		        ShowContacts(playerid);
		    }
		}
	}
	else 
	{
	    ShowContacts(playerid);
	}
	return 1;
}

Dialog:Contacts(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (!listitem) 
	    {
	        Dialog_Show(playerid, NewContact, DIALOG_STYLE_INPUT, "New Contact", "Please enter the name of the contact below:", "Submit", "Back");
	    }
	    else 
	    {
		    pData[playerid][pContact] = ListedContacts[playerid][listitem - 1];

	        Dialog_Show(playerid, ContactInfo, DIALOG_STYLE_LIST, ContactData[playerid][pData[playerid][pContact]][contactName], "Call Contact\nDelete Contact", "Select", "Back");
	    }
	}
	else 
	{
		return callcmd::phone(playerid, "\1");
	}
	for (new i = 0; i != MAX_CONTACTS; i ++) {
	    ListedContacts[playerid][i] = -1;
	}
	return 1;
}

CMD:reply(playerid, params[])
{
	if(!pData[playerid][pPhone])
	    return Error(playerid, "You don't have a cellphone on you.");

    if (pData[playerid][pInjured])
	    return Error(playerid, "You can't use this command now.");

	if(pData[playerid][pSMS] == 0)
	    return Error(playerid, "There is no one messaging you.");
	if (pData[playerid][pUsePhone] == 0)
		return Error(playerid, "Your phone must be powered on.");
	new str[128];
	format(str, sizeof(str), "Reply to: %s\nMessage:", GetContactNameByNumber(playerid, pData[playerid][pSMS]));
	Dialog_Show(playerid, SMSReply, DIALOG_STYLE_INPUT, "Message Reply", str, "Send", "Close");
	return 1;
}



CMD:call(playerid, params[])
{
	new phonenumb;
	new String[500];
	if(pData[playerid][pPhone] == 0) return Error(playerid, "You dont have phone!");
	if(pData[playerid][pPhoneCredit] <= 0) return Error(playerid, "You dont have phone credits!");
	if (pData[playerid][pUsePhone] == 0)
		return Error(playerid, "Your phone must be powered on.");
	if(sscanf(params, "d", phonenumb))
	{
		Usage(playerid, "/call [number]");
		SendClientMessageEx(playerid, ARWIN, "OPERATOR: {FFFFFF}You've reached the operator");
		SendClientMessageEx(playerid, ARWIN, "OPERATOR: {FFFFFF}Call 911 for emergency services");
		SendClientMessageEx(playerid, ARWIN, "OPERATOR: {FFFFFF}Call 888 for SAGS call center");	
		SendClientMessageEx(playerid, ARWIN, "OPERATOR: {FFFFFF}Call 111 for Taxi/Mechanic service");	
		return 1;	
	}
	if(phonenumb == 888)
	{
		SendClientMessageEx(playerid, ARWIN, "888: {FFFFFF}You have reached the SAGS call center.");
		SendClientMessageEx(playerid, ARWIN, "888: {FFFFFF}How can I help you?");
		Mobile[playerid] = 888;
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		return 1;
	}
	if(phonenumb == 911)
	{
		SendClientMessageEx(playerid, ARWIN, "911: {FFFFFF}You have reached the 911 Emergency Service.");
		SendClientMessageEx(playerid, ARWIN, "911: {FFFFFF}Do you need a police or a paramedic ?");
		Mobile[playerid] = 911;
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		return 1;
	}
	if(phonenumb == 111)
	{
		SendClientMessageEx(playerid, ARWIN, "111: {FFFFFF}You have reached the 111 Service.");
		SendClientMessageEx(playerid, ARWIN, "111: {FFFFFF}Do you need a taxi or a mechanic ?");
		Mobile[playerid] = 111;
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		return 1;
	}
	if(Mobile[playerid] != INVALID_PLAYER_ID)
	{
		Error(playerid, "You are already on a call...");
		return 1;
	}
	if(phonenumb == pData[playerid][pPhone]) return Error(playerid, "Nomor sedang sibuk!");
	if(phonenumb < 1) return Error(playerid, "Tidak bisa call di bawah no 0");
	foreach(new ii : Player)
	{
		if(pData[ii][pPhone] == phonenumb)
		{
			if (pData[ii][pUsePhone] == 0)
				return Error(playerid, "The recipient has their cellphone powered off.");
			if(pData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");

			if(pData[ii][pCall] == INVALID_PLAYER_ID)
			{
				pData[playerid][pCall] = ii;
				format(String, sizeof(String), "[PHONE]: "YELLOW_E"Anda telah mencoba menghubungi {00FFFF}%s (%d)"YELLOW_E" silahkan tunggu sampai di jawab", GetContactNameByNumber(playerid, pData[ii][pPhone]), pData[ii][pPhone]);
				SendClientMessage(playerid, COLOR_RED, String);

				format(String, sizeof(String), "[PHONE]: "YELLOW_E"Ponsel anda berbunyi!, {00FFFF}%s (%d) "YELLOW_E"mencoba untuk menghubungi anda, /p untuk menjawab", GetContactNameByNumber(ii, pData[playerid][pPhone]), pData[playerid][pPhone]);
				SendClientMessage(ii, COLOR_RED, String);
				
				PlayerPlaySound(playerid, 1052, 0,0,0);
				PlayerPlaySound(ii, 1139, 0,0,0);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out a cellphone and calling someone.", ReturnName(playerid));
				return 1;
			}
			else return Error(playerid, "Nomor ini sedang sibuk.");
		}
	}
	return 1;
}

CMD:p(playerid, params[])
{
	if(pData[playerid][pCall] != INVALID_PLAYER_ID)
		return Error(playerid, "Anda sudah sedang menelpon seseorang!");
		
	if(pData[playerid][pInjured] != 0)
		return Error(playerid, "You cant do that in this time.");
		
	foreach(new ii : Player)
	{
		if(playerid == pData[ii][pCall])
		{
			pData[ii][pPhoneCredit]--;
			
			pData[playerid][pCall] = ii;
			SendClientMessageEx(ii, ARWIN, "PHONE: {ffffff}Telepon anda telah di jawab.");
			SendClientMessageEx(ii, ARWIN, "PHONE: {ffffff}Gunakan chat biasa untuk berkomunikasi lewat telpon, '/hu' untuk menutup telpon.");
			SendClientMessageEx(playerid, ARWIN, "PHONE: {ffffff}Anda telah menjawab telpon.");
			SendClientMessageEx(playerid, ARWIN, "PHONE: {ffffff}Gunakan chat biasa untuk berkomunikasi lewat telpon, '/hu' untuk menutup telpon.");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			//SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s answers their cellphone.", ReturnName(playerid));
			return 1;
		}
	}
	return 1;
}

CMD:hu(playerid, params[])
{
	new caller = pData[playerid][pCall];
	if(IsPlayerConnected(caller) && caller != INVALID_PLAYER_ID)
	{
		pData[caller][pCall] = INVALID_PLAYER_ID;
		SetPlayerSpecialAction(caller, SPECIAL_ACTION_STOPUSECELLPHONE);
		//SendNearbyMessage(caller, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(caller));
		SendClientMessageEx(caller, ARWIN, "PHONE: {ffffff}Telepon telah dimatikan.");
		
		//SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(playerid));
		SendClientMessageEx(playerid,  ARWIN, "PHONE: {ffffff}Kamu telah menutup telepon");
		pData[playerid][pCall] = INVALID_PLAYER_ID;
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		DeletePVar(playerid, "UsePayphone");
	}
	return 1;
}


CMD:phone(playerid, params[])
{
	if(pData[playerid][pPhone] == 0) return Error(playerid, "You dont have phone!");
	static
	    str[32];

	format(str, sizeof(str), "Phone (#%d)", pData[playerid][pPhone]);

    if (pData[playerid][pUsePhone] == 0) {
        Dialog_Show(playerid, MyPhone, DIALOG_STYLE_LIST, str, "Dial Number\nMy Contacts\nSend Text Message\nTurn On Phone\nMessaging\nPhone Privacy", "Select", "Cancel");
    }
    else
    {
        Dialog_Show(playerid, MyPhone, DIALOG_STYLE_LIST, str, "Dial Number\nMy Contacts\nSend Text Message\nTurn Off Phone\nMessaging\nPhone Privacy", "Select", "Cancel");
    }
	return 1;
}

CMD:sms(playerid, params[])
{
	new ph, text[50], String[500], ii, nametarget[32], nameplayerid[32];
	if(pData[playerid][pPhone] == 0) return Error(playerid, "You dont have phone!");
	if(pData[playerid][pPhoneCredit] <= 0) return Error(playerid, "You dont have phone credits!");
	if(pData[playerid][pInjured] != 0) return Error(playerid, "You cant do at this time.");
	if (pData[playerid][pUsePhone] == 0)
		return Error(playerid, "Your phone must be powered on.");
	if(sscanf(params, "ds[50]", ph, text))
        return Usage(playerid, "/sms [phone number] [message max 50 text]");

	if (!ph)
	    return Error(playerid, "The specified phone number is not in service.");

	if ((ii = GetNumberOwner(ph)) != INVALID_PLAYER_ID)
	{
	/*    if (ii == playerid)
	        return SendErrorMessage(playerid, "You can't text yourself!");*/

		if (pData[ii][pUsePhone] == 0)
		    return Error(playerid, "The recipient has their cellphone powered off.");

		for (new i = 0; i != MAX_CONTACTS; i ++) if (ContactData[playerid][i][contactExists]) 
		{
			if(pData[ii][pPhone] == ContactData[playerid][i][contactNumber])
			{
				format(nametarget, 32, "%s", ContactData[playerid][i][contactName]);
			}
			else
			{
				format(nametarget, 32, "%s", "Unknow");
			}
		}
		else for (new id = 0; id != MAX_CONTACTS; id ++) if (ContactData[ii][id][contactExists]) 
		{
			if(pData[ii][pPhone] == ContactData[ii][id][contactNumber])
			{
				format(nameplayerid, 32, "%s", ContactData[ii][id][contactName]);
			}
			else
			{
				format(nameplayerid, 32, "%s", "Unknow");
			}
		}
		SendClientMessageEx(ii, COLOR_YELLOW, "SMS: "WHITE"Message from "RED"%s (%d)", GetContactNameByNumber(ii, pData[playerid][pPhone]), pData[playerid][pPhone]);
		SendClientMessageEx(ii, COLOR_YELLOW, "Message: "WHITE"%s", text);

		SendClientMessageEx(playerid, COLOR_WHITE, "AME: {C2A2DA}types something to his cellphone");
		format(String, sizeof(String), "types something to his cellphone");
		SetPlayerChatBubble(playerid, String, COLOR_PURPLE, 5.0, 5000);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SMS: "WHITE"Message sent to "RED"%s (%d)", GetContactNameByNumber(playerid, pData[ii][pPhone]), pData[ii][pPhone]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "Message: "WHITE"%s", text);

		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		PlayerPlaySound(ii, 1139, 0.0, 0.0, 0.0);
		pData[ii][pSMS] = pData[playerid][pPhone];
		
		pData[playerid][pPhoneCredit] -= 1;

		new query[512];
		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO sms(owner, message, number, type) VALUES ('%d', '%s', '%d', '%d')", pData[ii][pID], text, pData[playerid][pPhone], 2);
		mysql_tquery(g_SQL, query);

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO sms(owner, message, number, type) VALUES ('%d', '%s', '%d', '%d')", pData[playerid][pID], text, pData[ii][pPhone], 1);
		mysql_tquery(g_SQL, query);
	}
	else
	{
	    new query[103];
		mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `players` WHERE `phone` = '%d' LIMIT 1", ph);
		mysql_pquery(g_SQL, query, "OnSMSsend", "dds", playerid, ph, text);
	}
	return 1;
}
