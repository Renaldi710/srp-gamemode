
GetBisnisPaytax(playerid)
{
	new tmpcount;
	foreach(new id : Bisnis)
	{
		if(!strcmp(pData[playerid][pName], bData[id][bOwner], true))
		{
	     	tmpcount++;
		}
	}
	return tmpcount;
}

ReturnBisnisPaytaxID(playerid, slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_BISNIS) return -1;
	foreach(new id : Bisnis)
	{
		if(!strcmp(pData[playerid][pName], bData[id][bOwner], true))
		{
		    tmpcount++;
		    if(tmpcount == slot)
		    {
		    	return id;
		  	}
		}
	}
	return -1;
}

GetHousesPaytax(playerid)
{
	new tmpcount;
	foreach(new hid : Houses)
	{
	    if(!strcmp(hData[hid][hOwner], pData[playerid][pName], true))
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnHousesPaytaxID(playerid, slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_HOUSES) return -1;
	foreach(new hid : Houses)
	{
		if(!strcmp(pData[playerid][pName], hData[hid][hOwner], true))
		{
		    tmpcount++;
		    if(tmpcount == slot)
		    {
		    	return hid;
		  	}
		}
	}
	return -1;
}

CMD:paytax(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, 1395.9802,-29.4111,1013.9901))
		return Error(playerid, "Kamu harus berada di city hall");

	new string[1024];
	format(string, sizeof(string), "Business Tax\nHouse Tax");
	ShowPlayerDialog(playerid, DIALOG_PAYTAX, DIALOG_STYLE_LIST, "Paytax Assets", string , "Yes","No");
	return 1;
}