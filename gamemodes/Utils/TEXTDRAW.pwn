//------------[ Textdraw ]------------


//Info textdraw
new PlayerText:InfoTD[MAX_PLAYERS];
new Text:TextTime, Text:TextDate;

//Server Name textdraw
new Text:SOIRP_TXD;

new TD_Random_Messages_Intro[ ][ ] =
{
	"Basic ~w~Roleplay",
	"~b~~w~Basic.boards.net",
	"~w~Basic ~r~Roleplay"
};

function TDUpdates()
{
	TextDrawSetString(Text:SOIRP_TXD, TD_Random_Messages_Intro[random(sizeof(TD_Random_Messages_Intro))]);
}

//HBE textdraw Modern
new Text:TDEditor_TD[19];
new Text: NorthLogo[3];


new PlayerText: Entry_HUD[MAX_PLAYERS][16];
new PlayerText: OldSchoolHbe[MAX_PLAYERS][15];

new PlayerText:DPname[MAX_PLAYERS];
new PlayerText:DPmoney[MAX_PLAYERS];
new PlayerText:DPcoin[MAX_PLAYERS];

new PlayerText:DPvehname[MAX_PLAYERS];
new PlayerText:DPvehengine[MAX_PLAYERS];
new PlayerText:DPvehspeed[MAX_PLAYERS];
new Text:DPvehfare[MAX_PLAYERS];

//HBE textdraw Simple
new PlayerText:SPvehname[MAX_PLAYERS];
new PlayerText:SPvehengine[MAX_PLAYERS];
new PlayerText:SPvehspeed[MAX_PLAYERS];

new PlayerText:ActiveTD[MAX_PLAYERS];

new PlayerText: ALPR[MAX_PLAYERS][9];

new PlayerText:HBE_GUI[6][MAX_PLAYERS];
new PlayerText:HBE_SPEED[MAX_PLAYERS];
new PlayerText:HBE_HEALTH[MAX_PLAYERS];
new PlayerText:HBE_FUEL[MAX_PLAYERS];
new PlayerBar:HBE_HUNGER[MAX_PLAYERS];
new PlayerBar:HBE_THIRST[MAX_PLAYERS];
new PlayerBar:HBE_STRESS[MAX_PLAYERS];

new PlayerText: Entry_Logo[MAX_PLAYERS][2];
new PlayerText: HUNGER[MAX_PLAYERS];
new PlayerText: THIRST[MAX_PLAYERS];
new PlayerText: STRESS[MAX_PLAYERS];

new Text: PlayerCrateTD;
new PlayerText: PlayerCrate[MAX_PLAYERS][2];

new PlayerText: DirectionUI[MAX_PLAYERS][7];
new PlayerText: OldSchoolHUD[MAX_PLAYERS][20];
new PlayerText: PlayerHbe[MAX_PLAYERS][22];

new PlayerText: DirectionTD[MAX_PLAYERS][3];
new PlayerText: MultiChar[MAX_PLAYERS][10];
new PlayerText: RegisterChar[MAX_PLAYERS][17];

new Text:BoxStartTraining;
new Text:BoxTraining;
new PlayerText:TextStartTraining[MAX_PLAYERS];
new PlayerText:TextTraining[MAX_PLAYERS];

CreatePlayerTextDraws(playerid)
{
	//alpr
	ALPR[playerid][0] = CreatePlayerTextDraw(playerid, 270.000, -113.000, "New textdraw");
	PlayerTextDrawLetterSize(playerid, ALPR[playerid][0], 0.300, 1.500);
	PlayerTextDrawAlignment(playerid, ALPR[playerid][0], 1);
	PlayerTextDrawColor(playerid, ALPR[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, ALPR[playerid][0], 1);
	PlayerTextDrawSetOutline(playerid, ALPR[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, ALPR[playerid][0], 150);
	PlayerTextDrawFont(playerid, ALPR[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, ALPR[playerid][0], 1);

	ALPR[playerid][1] = CreatePlayerTextDraw(playerid, 509.000, 127.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, ALPR[playerid][1], 99.000, 53.000);
	PlayerTextDrawAlignment(playerid, ALPR[playerid][1], 1);
	PlayerTextDrawColor(playerid, ALPR[playerid][1], 192);
	PlayerTextDrawSetShadow(playerid, ALPR[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, ALPR[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, ALPR[playerid][1], 255);
	PlayerTextDrawFont(playerid, ALPR[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, ALPR[playerid][1], 1);

	ALPR[playerid][2] = CreatePlayerTextDraw(playerid, 557.000, 129.000, "ALPR");
	PlayerTextDrawLetterSize(playerid, ALPR[playerid][2], 0.170, 1.099);
	PlayerTextDrawAlignment(playerid, ALPR[playerid][2], 2);
	PlayerTextDrawColor(playerid, ALPR[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, ALPR[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, ALPR[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, ALPR[playerid][2], 150);
	PlayerTextDrawFont(playerid, ALPR[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, ALPR[playerid][2], 1);

	ALPR[playerid][3] = CreatePlayerTextDraw(playerid, 516.000, 140.000, "Plate:");
	PlayerTextDrawLetterSize(playerid, ALPR[playerid][3], 0.170, 1.099);
	PlayerTextDrawAlignment(playerid, ALPR[playerid][3], 1);
	PlayerTextDrawColor(playerid, ALPR[playerid][3], -2686721);
	PlayerTextDrawSetShadow(playerid, ALPR[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, ALPR[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, ALPR[playerid][3], 150);
	PlayerTextDrawFont(playerid, ALPR[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, ALPR[playerid][3], 1);

	ALPR[playerid][4] = CreatePlayerTextDraw(playerid, 515.000, 152.000, "Model:");
	PlayerTextDrawLetterSize(playerid, ALPR[playerid][4], 0.170, 1.099);
	PlayerTextDrawAlignment(playerid, ALPR[playerid][4], 1);
	PlayerTextDrawColor(playerid, ALPR[playerid][4], -2686721);
	PlayerTextDrawSetShadow(playerid, ALPR[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, ALPR[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, ALPR[playerid][4], 150);
	PlayerTextDrawFont(playerid, ALPR[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, ALPR[playerid][4], 1);

	ALPR[playerid][5] = CreatePlayerTextDraw(playerid, 516.000, 164.000, "Name:");
	PlayerTextDrawLetterSize(playerid, ALPR[playerid][5], 0.170, 1.099);
	PlayerTextDrawAlignment(playerid, ALPR[playerid][5], 1);
	PlayerTextDrawColor(playerid, ALPR[playerid][5], -2686721);
	PlayerTextDrawSetShadow(playerid, ALPR[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, ALPR[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, ALPR[playerid][5], 150);
	PlayerTextDrawFont(playerid, ALPR[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, ALPR[playerid][5], 1);

	ALPR[playerid][6] = CreatePlayerTextDraw(playerid, 602.000, 140.000, "N/A");
	PlayerTextDrawLetterSize(playerid, ALPR[playerid][6], 0.170, 1.099);
	PlayerTextDrawAlignment(playerid, ALPR[playerid][6], 3);
	PlayerTextDrawColor(playerid, ALPR[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, ALPR[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, ALPR[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, ALPR[playerid][6], 150);
	PlayerTextDrawFont(playerid, ALPR[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, ALPR[playerid][6], 1);

	ALPR[playerid][7] = CreatePlayerTextDraw(playerid, 602.000, 152.000, "N/A");
	PlayerTextDrawLetterSize(playerid, ALPR[playerid][7], 0.170, 1.099);
	PlayerTextDrawAlignment(playerid, ALPR[playerid][7], 3);
	PlayerTextDrawColor(playerid, ALPR[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, ALPR[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, ALPR[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, ALPR[playerid][7], 150);
	PlayerTextDrawFont(playerid, ALPR[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, ALPR[playerid][7], 1);

	ALPR[playerid][8] = CreatePlayerTextDraw(playerid, 602.000, 165.000, "N/A");
	PlayerTextDrawLetterSize(playerid, ALPR[playerid][8], 0.170, 1.099);
	PlayerTextDrawAlignment(playerid, ALPR[playerid][8], 3);
	PlayerTextDrawColor(playerid, ALPR[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, ALPR[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, ALPR[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, ALPR[playerid][8], 150);
	PlayerTextDrawFont(playerid, ALPR[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, ALPR[playerid][8], 1);

	//Player Textdraws
    TextStartTraining[playerid] = CreatePlayerTextDraw(playerid, 583.000000, 103.000000, "~y~Start in~n~~w~10");
    PlayerTextDrawFont(playerid, TextStartTraining[playerid], 0);
    PlayerTextDrawLetterSize(playerid, TextStartTraining[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TextStartTraining[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TextStartTraining[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TextStartTraining[playerid], 0);
    PlayerTextDrawAlignment(playerid, TextStartTraining[playerid], 3);
    PlayerTextDrawColor(playerid, TextStartTraining[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, TextStartTraining[playerid], 255);
    PlayerTextDrawBoxColor(playerid, TextStartTraining[playerid], 50);
    PlayerTextDrawUseBox(playerid, TextStartTraining[playerid], 0);
    PlayerTextDrawSetProportional(playerid, TextStartTraining[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, TextStartTraining[playerid], 0);

	TextTraining[playerid] = CreatePlayerTextDraw(playerid, 561.000000, 103.000000, "~y~Time Left~n~~w~130~n~~y~Score~n~~w~130");
    PlayerTextDrawFont(playerid, TextTraining[playerid], 0);
    PlayerTextDrawLetterSize(playerid, TextTraining[playerid], 0.600000, 1.650000);
    PlayerTextDrawTextSize(playerid, TextTraining[playerid], 645.000000, 112.000000);
    PlayerTextDrawSetOutline(playerid, TextTraining[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TextTraining[playerid], 0);
    PlayerTextDrawAlignment(playerid, TextTraining[playerid], 2);
    PlayerTextDrawColor(playerid, TextTraining[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, TextTraining[playerid], 255);
    PlayerTextDrawBoxColor(playerid, TextTraining[playerid], 50);
    PlayerTextDrawUseBox(playerid, TextTraining[playerid], 0);
    PlayerTextDrawSetProportional(playerid, TextTraining[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, TextTraining[playerid], 0);

	RegisterChar[playerid][0] = CreatePlayerTextDraw(playerid, 100.000, 138.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, RegisterChar[playerid][0], 119.000, 93.000);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][0], 1);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][0], 150);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][0], 255);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][0], 1);

	RegisterChar[playerid][1] = CreatePlayerTextDraw(playerid, 138.000, 128.000, "Vintage");
	PlayerTextDrawLetterSize(playerid, RegisterChar[playerid][1], 0.300, 1.500);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][1], 1);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][1], 150);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][1], 3);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][1], 1);

	RegisterChar[playerid][2] = CreatePlayerTextDraw(playerid, 150.000, 138.000, "Create");
	PlayerTextDrawLetterSize(playerid, RegisterChar[playerid][2], 0.300, 1.500);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][2], 1);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][2], 150);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][2], 3);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][2], 1);

	RegisterChar[playerid][3] = CreatePlayerTextDraw(playerid, 103.000, 158.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, RegisterChar[playerid][3], 113.000, 20.000);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][3], 1);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][3], 150);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][3], 255);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterChar[playerid][3], 1);

	RegisterChar[playerid][4] = CreatePlayerTextDraw(playerid, 160.000, 161.000, "Your_Name");
	PlayerTextDrawLetterSize(playerid, RegisterChar[playerid][4], 0.170, 1.199);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][4], 2);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][4], 150);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][4], 1);

	RegisterChar[playerid][5] = CreatePlayerTextDraw(playerid, 103.000, 181.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, RegisterChar[playerid][5], 113.000, 20.000);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][5], 1);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][5], 150);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][5], 255);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterChar[playerid][5], 1);

	RegisterChar[playerid][6] = CreatePlayerTextDraw(playerid, 160.000, 184.000, "Date of Birth");
	PlayerTextDrawLetterSize(playerid, RegisterChar[playerid][6], 0.170, 1.199);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][6], 2);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][6], 150);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][6], 1);

	RegisterChar[playerid][7] = CreatePlayerTextDraw(playerid, 103.000, 204.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, RegisterChar[playerid][7], 53.000, 20.000);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][7], 1);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][7], 150);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][7], 255);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterChar[playerid][7], 1);

	RegisterChar[playerid][8] = CreatePlayerTextDraw(playerid, 162.000, 204.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, RegisterChar[playerid][8], 54.000, 20.000);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][8], 1);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][8], 150);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][8], 255);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterChar[playerid][8], 1);

	RegisterChar[playerid][9] = CreatePlayerTextDraw(playerid, 129.000, 208.000, "Male");
	PlayerTextDrawLetterSize(playerid, RegisterChar[playerid][9], 0.170, 1.199);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][9], 2);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][9], 150);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][9], 1);

	RegisterChar[playerid][10] = CreatePlayerTextDraw(playerid, 188.000, 208.000, "Female");
	PlayerTextDrawLetterSize(playerid, RegisterChar[playerid][10], 0.170, 1.199);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][10], 2);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][10], 150);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][10], 1);

	RegisterChar[playerid][11] = CreatePlayerTextDraw(playerid, 100.000, 233.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, RegisterChar[playerid][11], 119.000, 21.000);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][11], 1);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][11], -2686876);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][11], 255);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterChar[playerid][11], 1);

	RegisterChar[playerid][12] = CreatePlayerTextDraw(playerid, 160.000, 237.000, "Create");
	PlayerTextDrawLetterSize(playerid, RegisterChar[playerid][12], 0.170, 1.199);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][12], 2);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][12], 150);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][12], 1);

	RegisterChar[playerid][13] = CreatePlayerTextDraw(playerid, 255.000, 347.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, RegisterChar[playerid][13], 33.000, 21.000);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][13], 1);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][13], -2686876);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][13], 255);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][13], 4);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterChar[playerid][13], 1);

	RegisterChar[playerid][14] = CreatePlayerTextDraw(playerid, 352.000, 347.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, RegisterChar[playerid][14], 33.000, 21.000);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][14], 1);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][14], -2686876);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][14], 255);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][14], 4);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, RegisterChar[playerid][14], 1);

	RegisterChar[playerid][15] = CreatePlayerTextDraw(playerid, 369.000, 350.000, ">>");
	PlayerTextDrawLetterSize(playerid, RegisterChar[playerid][15], 0.180, 1.500);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][15], 2);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][15], 150);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][15], 1);

	RegisterChar[playerid][16] = CreatePlayerTextDraw(playerid, 270.000, 350.000, "<<");
	PlayerTextDrawLetterSize(playerid, RegisterChar[playerid][16], 0.180, 1.500);
	PlayerTextDrawAlignment(playerid, RegisterChar[playerid][16], 2);
	PlayerTextDrawColor(playerid, RegisterChar[playerid][16], -1);
	PlayerTextDrawSetShadow(playerid, RegisterChar[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, RegisterChar[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, RegisterChar[playerid][16], 150);
	PlayerTextDrawFont(playerid, RegisterChar[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, RegisterChar[playerid][16], 1);

	MultiChar[playerid][0] = CreatePlayerTextDraw(playerid, 236.000, 366.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, MultiChar[playerid][0], 168.000, 41.000);
	PlayerTextDrawAlignment(playerid, MultiChar[playerid][0], 1);
	PlayerTextDrawColor(playerid, MultiChar[playerid][0], 170);
	PlayerTextDrawSetShadow(playerid, MultiChar[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MultiChar[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, MultiChar[playerid][0], 255);
	PlayerTextDrawFont(playerid, MultiChar[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, MultiChar[playerid][0], 1);

	MultiChar[playerid][1] = CreatePlayerTextDraw(playerid, 239.000, 377.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, MultiChar[playerid][1], 52.000, 24.000);
	PlayerTextDrawAlignment(playerid, MultiChar[playerid][1], 1);
	PlayerTextDrawColor(playerid, MultiChar[playerid][1], 170);
	PlayerTextDrawSetShadow(playerid, MultiChar[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MultiChar[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, MultiChar[playerid][1], 255);
	PlayerTextDrawFont(playerid, MultiChar[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, MultiChar[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, MultiChar[playerid][1], 1);

	MultiChar[playerid][2] = CreatePlayerTextDraw(playerid, 294.000, 377.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, MultiChar[playerid][2], 52.000, 24.000);
	PlayerTextDrawAlignment(playerid, MultiChar[playerid][2], 1);
	PlayerTextDrawColor(playerid, MultiChar[playerid][2], 170);
	PlayerTextDrawSetShadow(playerid, MultiChar[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MultiChar[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, MultiChar[playerid][2], 255);
	PlayerTextDrawFont(playerid, MultiChar[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, MultiChar[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, MultiChar[playerid][2], 1);

	MultiChar[playerid][3] = CreatePlayerTextDraw(playerid, 349.000, 377.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, MultiChar[playerid][3], 52.000, 24.000);
	PlayerTextDrawAlignment(playerid, MultiChar[playerid][3], 1);
	PlayerTextDrawColor(playerid, MultiChar[playerid][3], 170);
	PlayerTextDrawSetShadow(playerid, MultiChar[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MultiChar[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, MultiChar[playerid][3], 255);
	PlayerTextDrawFont(playerid, MultiChar[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, MultiChar[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, MultiChar[playerid][3], 1);

	MultiChar[playerid][4] = CreatePlayerTextDraw(playerid, 265.000, 384.000, "New_Character");
	PlayerTextDrawLetterSize(playerid, MultiChar[playerid][4], 0.160, 0.999);
	PlayerTextDrawAlignment(playerid, MultiChar[playerid][4], 2);
	PlayerTextDrawColor(playerid, MultiChar[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, MultiChar[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MultiChar[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, MultiChar[playerid][4], 150);
	PlayerTextDrawFont(playerid, MultiChar[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MultiChar[playerid][4], 1);

	MultiChar[playerid][5] = CreatePlayerTextDraw(playerid, 320.000, 384.000, "New_Character");
	PlayerTextDrawLetterSize(playerid, MultiChar[playerid][5], 0.160, 0.999);
	PlayerTextDrawAlignment(playerid, MultiChar[playerid][5], 2);
	PlayerTextDrawColor(playerid, MultiChar[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, MultiChar[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MultiChar[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, MultiChar[playerid][5], 150);
	PlayerTextDrawFont(playerid, MultiChar[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MultiChar[playerid][5], 1);

	MultiChar[playerid][6] = CreatePlayerTextDraw(playerid, 375.000, 384.000, "New_Character");
	PlayerTextDrawLetterSize(playerid, MultiChar[playerid][6], 0.160, 0.999);
	PlayerTextDrawAlignment(playerid, MultiChar[playerid][6], 2);
	PlayerTextDrawColor(playerid, MultiChar[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, MultiChar[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MultiChar[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, MultiChar[playerid][6], 150);
	PlayerTextDrawFont(playerid, MultiChar[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, MultiChar[playerid][6], 1);

	MultiChar[playerid][7] = CreatePlayerTextDraw(playerid, 319.000, 355.000, "North Country");
	PlayerTextDrawLetterSize(playerid, MultiChar[playerid][7], 0.280, 1.299);
	PlayerTextDrawAlignment(playerid, MultiChar[playerid][7], 2);
	PlayerTextDrawColor(playerid, MultiChar[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, MultiChar[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MultiChar[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, MultiChar[playerid][7], 150);
	PlayerTextDrawFont(playerid, MultiChar[playerid][7], 3);
	PlayerTextDrawSetProportional(playerid, MultiChar[playerid][7], 1);

	MultiChar[playerid][8] = CreatePlayerTextDraw(playerid, 236.000, 408.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, MultiChar[playerid][8], 168.000, 10.000);
	PlayerTextDrawAlignment(playerid, MultiChar[playerid][8], 1);
	PlayerTextDrawColor(playerid, MultiChar[playerid][8], -2686876);
	PlayerTextDrawSetShadow(playerid, MultiChar[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MultiChar[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, MultiChar[playerid][8], 255);
	PlayerTextDrawFont(playerid, MultiChar[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, MultiChar[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, MultiChar[playerid][8], 1);

	MultiChar[playerid][9] = CreatePlayerTextDraw(playerid, 320.000, 408.000, "Select");
	PlayerTextDrawLetterSize(playerid, MultiChar[playerid][9], 0.149, 0.999);
	PlayerTextDrawAlignment(playerid, MultiChar[playerid][9], 2);
	PlayerTextDrawColor(playerid, MultiChar[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, MultiChar[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MultiChar[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, MultiChar[playerid][9], 150);
	PlayerTextDrawFont(playerid, MultiChar[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, MultiChar[playerid][9], 1);

	OldSchoolHbe[playerid][0] = CreatePlayerTextDraw(playerid, 582.000, 295.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, OldSchoolHbe[playerid][0], 57.000, 40.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][0], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][0], 160);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][0], 255);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][0], 1);

	OldSchoolHbe[playerid][1] = CreatePlayerTextDraw(playerid, 589.000, 302.000, "Hunger_:");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][1], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][1], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][1], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][1], 1);

	OldSchoolHbe[playerid][2] = CreatePlayerTextDraw(playerid, 589.000, 317.000, "Energy_:");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][2], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][2], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][2], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][2], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][2], 1);

	OldSchoolHbe[playerid][3] = CreatePlayerTextDraw(playerid, 624.000, 303.000, "100");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][3], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][3], 2);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][3], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][3], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][3], 1);

	OldSchoolHbe[playerid][4] = CreatePlayerTextDraw(playerid, 624.000, 317.000, "100");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][4], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][4], 2);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][4], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][4], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][4], 1);

	OldSchoolHbe[playerid][5] = CreatePlayerTextDraw(playerid, 579.000, 285.000, "Players");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][5], 0.300, 1.500);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][5], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][5], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][5], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][5], 1);

	OldSchoolHbe[playerid][6] = CreatePlayerTextDraw(playerid, 582.000, 230.000, "LD_BUM:blkdot");
	PlayerTextDrawTextSize(playerid, OldSchoolHbe[playerid][6], 57.000, 56.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][6], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][6], 160);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][6], 255);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][6], 1);

	OldSchoolHbe[playerid][7] = CreatePlayerTextDraw(playerid, 579.000, 221.000, "Vehicle");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][7], 0.300, 1.500);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][7], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][7], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][7], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][7], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][7], 1);

	OldSchoolHbe[playerid][8] = CreatePlayerTextDraw(playerid, 589.000, 240.000, "Engine_:");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][8], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][8], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][8], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][8], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][8], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][8], 1);

	OldSchoolHbe[playerid][9] = CreatePlayerTextDraw(playerid, 589.000, 255.000, "Fuel_:");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][9], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][9], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][9], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][9], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][9], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][9], 1);

	OldSchoolHbe[playerid][10] = CreatePlayerTextDraw(playerid, 616.000, 240.000, "1000");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][10], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][10], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][10], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][10], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][10], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][10], 1);

	OldSchoolHbe[playerid][11] = CreatePlayerTextDraw(playerid, 616.000, 255.000, "100");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][11], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][11], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][11], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][11], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][11], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][11], 1);

	OldSchoolHbe[playerid][12] = CreatePlayerTextDraw(playerid, 589.000, 255.000, "Fuel_:");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][12], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][12], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][12], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][12], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][12], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][12], 1);

	OldSchoolHbe[playerid][13] = CreatePlayerTextDraw(playerid, 589.000, 270.000, "Speed_:");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][13], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][13], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][13], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][13], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][13], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][13], 1);

	OldSchoolHbe[playerid][14] = CreatePlayerTextDraw(playerid, 616.000, 270.000, "000");
	PlayerTextDrawLetterSize(playerid, OldSchoolHbe[playerid][14], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHbe[playerid][14], 1);
	PlayerTextDrawColor(playerid, OldSchoolHbe[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHbe[playerid][14], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHbe[playerid][14], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHbe[playerid][14], 150);
	PlayerTextDrawFont(playerid, OldSchoolHbe[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, OldSchoolHbe[playerid][14], 1);

	DirectionTD[playerid][0] = CreatePlayerTextDraw(playerid, 110.000, 355.000, "N");
	PlayerTextDrawLetterSize(playerid, DirectionTD[playerid][0], 0.529, 2.199);
	PlayerTextDrawAlignment(playerid, DirectionTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, DirectionTD[playerid][0], -2686721);
	PlayerTextDrawSetShadow(playerid, DirectionTD[playerid][0], 1);
	PlayerTextDrawSetOutline(playerid, DirectionTD[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, DirectionTD[playerid][0], 150);
	PlayerTextDrawFont(playerid, DirectionTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, DirectionTD[playerid][0], 1);

	DirectionTD[playerid][1] = CreatePlayerTextDraw(playerid, 110.000, 373.000, "North");
	PlayerTextDrawLetterSize(playerid, DirectionTD[playerid][1], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, DirectionTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, DirectionTD[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, DirectionTD[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, DirectionTD[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, DirectionTD[playerid][1], 150);
	PlayerTextDrawFont(playerid, DirectionTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, DirectionTD[playerid][1], 1);

	DirectionTD[playerid][2] = CreatePlayerTextDraw(playerid, 109.000, 381.000, "Santa_maria_beach");
	PlayerTextDrawLetterSize(playerid, DirectionTD[playerid][2], 0.170, 1.199);
	PlayerTextDrawAlignment(playerid, DirectionTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, DirectionTD[playerid][2], 1433087999);
	PlayerTextDrawSetShadow(playerid, DirectionTD[playerid][2], 1);
	PlayerTextDrawSetOutline(playerid, DirectionTD[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, DirectionTD[playerid][2], 150);
	PlayerTextDrawFont(playerid, DirectionTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, DirectionTD[playerid][2], 1);


	PlayerHbe[playerid][0] = CreatePlayerTextDraw(playerid, 171.000, 430.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][0], 3.000, 5.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][0], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][0], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][0], 1);

	PlayerHbe[playerid][1] = CreatePlayerTextDraw(playerid, 174.000, 428.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][1], 2.000, 3.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][1], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][1], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][1], 1);

	PlayerHbe[playerid][2] = CreatePlayerTextDraw(playerid, 169.000, 428.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][2], 2.000, 3.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][2], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][2], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][2], 1);

	PlayerHbe[playerid][3] = CreatePlayerTextDraw(playerid, 138.500, 428.000, "V");
	PlayerTextDrawLetterSize(playerid, PlayerHbe[playerid][3], 0.328, 0.999);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][3], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][3], 150);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][3], 1);

	PlayerHbe[playerid][4] = CreatePlayerTextDraw(playerid, 139.500, 429.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][4], 5.697, 6.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][4], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][4], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][4], 1);

	PlayerHbe[playerid][5] = CreatePlayerTextDraw(playerid, 137.500, 426.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][5], 5.697, 6.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][5], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][5], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][5], 1);

	PlayerHbe[playerid][6] = CreatePlayerTextDraw(playerid, 141.500, 426.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][6], 5.697, 6.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][6], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][6], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][6], 1);

	PlayerHbe[playerid][7] = CreatePlayerTextDraw(playerid, 199.000, 432.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][7], 5.000, 1.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][7], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][7], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][7], 1);

	PlayerHbe[playerid][8] = CreatePlayerTextDraw(playerid, 199.000, 429.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][8], 5.000, 2.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][8], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][8], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][8], 1);

	PlayerHbe[playerid][9] = CreatePlayerTextDraw(playerid, 197.500, 426.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][9], 7.697, 5.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][9], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][9], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][9], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][9], 1);

	PlayerHbe[playerid][10] = CreatePlayerTextDraw(playerid, 226.000, 430.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][10], 6.697, 6.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][10], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][10], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][10], 1);

	PlayerHbe[playerid][11] = CreatePlayerTextDraw(playerid, 226.597, 424.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][11], 5.697, 13.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][11], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][11], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][11], 1);

	PlayerHbe[playerid][12] = CreatePlayerTextDraw(playerid, 145.000, 421.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][12], 19.000, 21.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][12], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][12], 80);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][12], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][12], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][12], 1);

	PlayerHbe[playerid][13] = CreatePlayerTextDraw(playerid, 176.000, 421.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][13], 19.000, 21.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][13], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][13], 80);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][13], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][13], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][13], 1);

	PlayerHbe[playerid][14] = CreatePlayerTextDraw(playerid, 205.000, 421.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][14], 19.000, 21.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][14], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][14], 80);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][14], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][14], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][14], 1);

	PlayerHbe[playerid][15] = CreatePlayerTextDraw(playerid, 232.000, 421.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, PlayerHbe[playerid][15], 19.000, 21.000);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][15], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][15], 80);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][15], 255);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][15], 4);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][15], 1);

	PlayerHbe[playerid][16] = CreatePlayerTextDraw(playerid, 154.000, 427.000, "100");
	PlayerTextDrawLetterSize(playerid, PlayerHbe[playerid][16], 0.128, 0.799);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][16], 2);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][16], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][16], 150);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][16], 1);

	PlayerHbe[playerid][17] = CreatePlayerTextDraw(playerid, 185.000, 427.000, "90");
	PlayerTextDrawLetterSize(playerid, PlayerHbe[playerid][17], 0.128, 0.799);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][17], 2);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][17], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][17], 150);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][17], 1);

	PlayerHbe[playerid][18] = CreatePlayerTextDraw(playerid, 214.000, 427.000, "90");
	PlayerTextDrawLetterSize(playerid, PlayerHbe[playerid][18], 0.128, 0.799);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][18], 2);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][18], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][18], 150);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][18], 1);

	PlayerHbe[playerid][19] = CreatePlayerTextDraw(playerid, 242.000, 427.000, "90");
	PlayerTextDrawLetterSize(playerid, PlayerHbe[playerid][19], 0.128, 0.799);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][19], 2);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][19], 150);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][19], 1);

	PlayerHbe[playerid][20] = CreatePlayerTextDraw(playerid, 138.000, 398.000, "ID: 8 Los Santos, Ganton");
	PlayerTextDrawLetterSize(playerid, PlayerHbe[playerid][20], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][20], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][20], -2686721);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][20], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][20], 150);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][20], 1);

	PlayerHbe[playerid][21] = CreatePlayerTextDraw(playerid, 138.000, 411.000, "Saturday, August 28, 2020, 15:00:00");
	PlayerTextDrawLetterSize(playerid, PlayerHbe[playerid][21], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, PlayerHbe[playerid][21], 1);
	PlayerTextDrawColor(playerid, PlayerHbe[playerid][21], -1);
	PlayerTextDrawSetShadow(playerid, PlayerHbe[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, PlayerHbe[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerHbe[playerid][21], 150);
	PlayerTextDrawFont(playerid, PlayerHbe[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, PlayerHbe[playerid][21], 1);

	OldSchoolHUD[playerid][0] = CreatePlayerTextDraw(playerid, 528.000, 121.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][0], 18.000, 23.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][0], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][0], 255);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][0], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][0], 1);

	OldSchoolHUD[playerid][1] = CreatePlayerTextDraw(playerid, 536.000, 113.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][1], -9.000, 4.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][1], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][1], 255);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][1], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][1], 1);

	OldSchoolHUD[playerid][2] = CreatePlayerTextDraw(playerid, 529.000, 128.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][2], 16.000, 15.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][2], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][2], 512819199);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][2], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][2], 1);

	OldSchoolHUD[playerid][3] = CreatePlayerTextDraw(playerid, 537.000, 113.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][3], -5.000, 8.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][3], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][3], 255);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][3], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][3], 1);

	OldSchoolHUD[playerid][4] = CreatePlayerTextDraw(playerid, 537.000, 130.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][4], 4.000, 4.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][4], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][4], 12582911);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][4], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][4], 1);

	OldSchoolHUD[playerid][5] = CreatePlayerTextDraw(playerid, 529.000, 122.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][5], 16.000, 5.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][5], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][5], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][5], 1);

	OldSchoolHUD[playerid][6] = CreatePlayerTextDraw(playerid, 539.000, 136.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][6], 4.000, 4.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][6], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][6], 12582911);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][6], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][6], 1);

	OldSchoolHUD[playerid][7] = CreatePlayerTextDraw(playerid, 533.000, 116.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][7], 3.000, 26.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][7], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][7], 12582911);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][7], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][7], 1);

	OldSchoolHUD[playerid][8] = CreatePlayerTextDraw(playerid, 536.000, 114.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][8], -8.000, 2.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][8], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][8], 12582911);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][8], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][8], 1);

	OldSchoolHUD[playerid][9] = CreatePlayerTextDraw(playerid, 552.000, 111.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][9], 36.000, 41.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][9], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][9], 255);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][9], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][9], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][9], 1);

	OldSchoolHUD[playerid][10] = CreatePlayerTextDraw(playerid, 554.000, 113.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][10], 33.000, 36.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][10], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][10], -12254977);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][10], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][10], 1);

	OldSchoolHUD[playerid][11] = CreatePlayerTextDraw(playerid, 556.000, 115.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][11], 29.000, 32.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][11], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][11], -16776961);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][11], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][11], 1);

	OldSchoolHUD[playerid][12] = CreatePlayerTextDraw(playerid, 557.000, 116.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][12], 27.000, 30.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][12], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][12], -5963521);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][12], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][12], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][12], 1);

	OldSchoolHUD[playerid][13] = CreatePlayerTextDraw(playerid, 564.000, 124.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][13], 5.000, 4.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][13], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][13], 8388863);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][13], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][13], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][13], 1);

	OldSchoolHUD[playerid][14] = CreatePlayerTextDraw(playerid, 564.000, 129.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][14], 5.000, 4.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][14], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][14], 8388863);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][14], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][14], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][14], 1);

	OldSchoolHUD[playerid][15] = CreatePlayerTextDraw(playerid, 567.000, 134.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][15], 5.000, 4.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][15], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][15], -2147483393);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][15], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][15], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][15], 1);

	OldSchoolHUD[playerid][16] = CreatePlayerTextDraw(playerid, 573.000, 130.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][16], 5.000, 4.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][16], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][16], 8388863);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][16], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][16], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][16], 1);

	OldSchoolHUD[playerid][17] = CreatePlayerTextDraw(playerid, 569.000, 124.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, OldSchoolHUD[playerid][17], 5.000, 4.000);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][17], 1);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][17], -2147483393);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][17], 255);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][17], 4);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][17], 1);

	OldSchoolHUD[playerid][18] = CreatePlayerTextDraw(playerid, 537.000, 139.000, "100");
	PlayerTextDrawLetterSize(playerid, OldSchoolHUD[playerid][18], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][18], 2);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][18], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][18], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][18], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][18], 150);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][18], 2);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][18], 1);

	OldSchoolHUD[playerid][19] = CreatePlayerTextDraw(playerid, 570.000, 139.000, "100");
	PlayerTextDrawLetterSize(playerid, OldSchoolHUD[playerid][19], 0.150, 0.999);
	PlayerTextDrawAlignment(playerid, OldSchoolHUD[playerid][19], 2);
	PlayerTextDrawColor(playerid, OldSchoolHUD[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, OldSchoolHUD[playerid][19], 1);
	PlayerTextDrawSetOutline(playerid, OldSchoolHUD[playerid][19], 1);
	PlayerTextDrawBackgroundColor(playerid, OldSchoolHUD[playerid][19], 150);
	PlayerTextDrawFont(playerid, OldSchoolHUD[playerid][19], 2);
	PlayerTextDrawSetProportional(playerid, OldSchoolHUD[playerid][19], 1);

	DirectionUI[playerid][0] = CreatePlayerTextDraw(playerid, 32.000, 428.000, "V");
	PlayerTextDrawLetterSize(playerid, DirectionUI[playerid][0], 0.418, 1.699);
	PlayerTextDrawAlignment(playerid, DirectionUI[playerid][0], 2);
	PlayerTextDrawColor(playerid, DirectionUI[playerid][0], 255);
	PlayerTextDrawSetShadow(playerid, DirectionUI[playerid][0], 1);
	PlayerTextDrawSetOutline(playerid, DirectionUI[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, DirectionUI[playerid][0], 255);
	PlayerTextDrawFont(playerid, DirectionUI[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, DirectionUI[playerid][0], 1);

	DirectionUI[playerid][1] = CreatePlayerTextDraw(playerid, 32.000, 415.000, "O");
	PlayerTextDrawLetterSize(playerid, DirectionUI[playerid][1], 0.428, 2.598);
	PlayerTextDrawAlignment(playerid, DirectionUI[playerid][1], 2);
	PlayerTextDrawColor(playerid, DirectionUI[playerid][1], 255);
	PlayerTextDrawSetShadow(playerid, DirectionUI[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, DirectionUI[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, DirectionUI[playerid][1], 255);
	PlayerTextDrawFont(playerid, DirectionUI[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, DirectionUI[playerid][1], 1);

	DirectionUI[playerid][2] = CreatePlayerTextDraw(playerid, 32.000, 419.000, "O");
	PlayerTextDrawLetterSize(playerid, DirectionUI[playerid][2], 0.300, 1.699);
	PlayerTextDrawAlignment(playerid, DirectionUI[playerid][2], 2);
	PlayerTextDrawColor(playerid, DirectionUI[playerid][2], -2147483393);
	PlayerTextDrawSetShadow(playerid, DirectionUI[playerid][2], 1);
	PlayerTextDrawSetOutline(playerid, DirectionUI[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, DirectionUI[playerid][2], -2147483393);
	PlayerTextDrawFont(playerid, DirectionUI[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, DirectionUI[playerid][2], 1);

	DirectionUI[playerid][3] = CreatePlayerTextDraw(playerid, 32.000, 427.000, "V");
	PlayerTextDrawLetterSize(playerid, DirectionUI[playerid][3], 0.239, 1.199);
	PlayerTextDrawAlignment(playerid, DirectionUI[playerid][3], 2);
	PlayerTextDrawColor(playerid, DirectionUI[playerid][3], -2147483393);
	PlayerTextDrawSetShadow(playerid, DirectionUI[playerid][3], 1);
	PlayerTextDrawSetOutline(playerid, DirectionUI[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, DirectionUI[playerid][3], -2147483393);
	PlayerTextDrawFont(playerid, DirectionUI[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, DirectionUI[playerid][3], 1);

	DirectionUI[playerid][4] = CreatePlayerTextDraw(playerid, 32.000, 422.000, "O");
	PlayerTextDrawLetterSize(playerid, DirectionUI[playerid][4], 0.170, 0.999);
	PlayerTextDrawAlignment(playerid, DirectionUI[playerid][4], 2);
	PlayerTextDrawColor(playerid, DirectionUI[playerid][4], 255);
	PlayerTextDrawSetShadow(playerid, DirectionUI[playerid][4], 1);
	PlayerTextDrawSetOutline(playerid, DirectionUI[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, DirectionUI[playerid][4], 255);
	PlayerTextDrawFont(playerid, DirectionUI[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, DirectionUI[playerid][4], 1);

	DirectionUI[playerid][5] = CreatePlayerTextDraw(playerid, 43.000, 429.000, "SE flint country");
	PlayerTextDrawLetterSize(playerid, DirectionUI[playerid][5], 0.149, 1.098);
	PlayerTextDrawAlignment(playerid, DirectionUI[playerid][5], 1);
	PlayerTextDrawColor(playerid, DirectionUI[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, DirectionUI[playerid][5], 1);
	PlayerTextDrawSetOutline(playerid, DirectionUI[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, DirectionUI[playerid][5], 150);
	PlayerTextDrawFont(playerid, DirectionUI[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, DirectionUI[playerid][5], 1);

	//CARTE
	PlayerCrate[playerid][0] = CreatePlayerTextDraw(playerid, 552.000000, 107.000000, "Storage");
    PlayerTextDrawFont(playerid, PlayerCrate[playerid][0], 0);
    PlayerTextDrawLetterSize(playerid, PlayerCrate[playerid][0], 0.479166, 1.850000);
    PlayerTextDrawTextSize(playerid, PlayerCrate[playerid][0], 755.000000, 167.000000);
    PlayerTextDrawSetOutline(playerid, PlayerCrate[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, PlayerCrate[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, PlayerCrate[playerid][0], 2);
    PlayerTextDrawColor(playerid, PlayerCrate[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerCrate[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, PlayerCrate[playerid][0], 50);
    PlayerTextDrawUseBox(playerid, PlayerCrate[playerid][0], 0);
    PlayerTextDrawSetProportional(playerid, PlayerCrate[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerCrate[playerid][0], 0);

    PlayerCrate[playerid][1] = CreatePlayerTextDraw(playerid, 507.000000, 133.000000, "Trash~n~0/10");
    PlayerTextDrawFont(playerid, PlayerCrate[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, PlayerCrate[playerid][1], 0.325000, 1.100000);
    PlayerTextDrawTextSize(playerid, PlayerCrate[playerid][1], 755.000000, 167.000000);
    PlayerTextDrawSetOutline(playerid, PlayerCrate[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, PlayerCrate[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, PlayerCrate[playerid][1], 1);
    PlayerTextDrawColor(playerid, PlayerCrate[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerCrate[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, PlayerCrate[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, PlayerCrate[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, PlayerCrate[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerCrate[playerid][1], 0);

	//entry hud
	Entry_HUD[playerid][0] = CreatePlayerTextDraw(playerid, 584.000, 326.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, Entry_HUD[playerid][0], 57.000, 49.000);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][0], 1);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][0], 190);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][0], 255);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][0], 1);

	Entry_HUD[playerid][1] = CreatePlayerTextDraw(playerid, 558.000, 300.000, "_");
	PlayerTextDrawTextSize(playerid, Entry_HUD[playerid][1], 64.000, 88.000);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][1], 1);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][1], 0);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, Entry_HUD[playerid][1], 2880);
	PlayerTextDrawSetPreviewRot(playerid, Entry_HUD[playerid][1], -17.000, -88.000, 8.000, 3.497);
	PlayerTextDrawSetPreviewVehCol(playerid, Entry_HUD[playerid][1], 0, 0);

	Entry_HUD[playerid][2] = CreatePlayerTextDraw(playerid, 620.000, 335.000, "100");
	PlayerTextDrawLetterSize(playerid, Entry_HUD[playerid][2], 0.218, 1.090);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][2], 2);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][2], 1);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][2], 150);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][2], 1);

	Entry_HUD[playerid][3] = CreatePlayerTextDraw(playerid, 565.000, 317.000, "_");
	PlayerTextDrawTextSize(playerid, Entry_HUD[playerid][3], 64.000, 88.000);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][3], 1);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][3], 0);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, Entry_HUD[playerid][3], 19835);
	PlayerTextDrawSetPreviewRot(playerid, Entry_HUD[playerid][3], -27.000, 0.000, 8.000, 3.697);
	PlayerTextDrawSetPreviewVehCol(playerid, Entry_HUD[playerid][3], 0, 0);

	Entry_HUD[playerid][4] = CreatePlayerTextDraw(playerid, 621.000, 356.000, "100");
	PlayerTextDrawLetterSize(playerid, Entry_HUD[playerid][4], 0.218, 1.090);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][4], 2);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][4], 1);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][4], 150);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][4], 1);

	Entry_HUD[playerid][5] = CreatePlayerTextDraw(playerid, 584.000, 244.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, Entry_HUD[playerid][5], 57.000, 78.000);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][5], 1);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][5], 190);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][5], 255);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][5], 1);

	Entry_HUD[playerid][6] = CreatePlayerTextDraw(playerid, 562.000, 214.000, "_");
	PlayerTextDrawTextSize(playerid, Entry_HUD[playerid][6], 64.000, 88.000);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][6], 1);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][6], 0);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid, Entry_HUD[playerid][6], 19627);
	PlayerTextDrawSetPreviewRot(playerid, Entry_HUD[playerid][6], -42.000, -9.000, -119.000, 2.897);
	PlayerTextDrawSetPreviewVehCol(playerid, Entry_HUD[playerid][6], 0, 0);

	Entry_HUD[playerid][7] = CreatePlayerTextDraw(playerid, 618.000, 252.000, "100");
	PlayerTextDrawLetterSize(playerid, Entry_HUD[playerid][7], 0.218, 1.090);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][7], 2);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][7], 1);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][7], 1);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][7], 150);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][7], 1);

	Entry_HUD[playerid][8] = CreatePlayerTextDraw(playerid, 563.000, 236.000, "_");
	PlayerTextDrawTextSize(playerid, Entry_HUD[playerid][8], 64.000, 88.000);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][8], 1);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][8], 0);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][8], 0);
	PlayerTextDrawSetPreviewModel(playerid, Entry_HUD[playerid][8], 560);
	PlayerTextDrawSetPreviewRot(playerid, Entry_HUD[playerid][8], -42.000, -9.000, -119.000, 3.096);
	PlayerTextDrawSetPreviewVehCol(playerid, Entry_HUD[playerid][8], 0, 0);

	Entry_HUD[playerid][9] = CreatePlayerTextDraw(playerid, 563.000, 270.000, "_");
	PlayerTextDrawTextSize(playerid, Entry_HUD[playerid][9], 64.000, 72.000);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][9], 1);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][9], 0);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][9], 0);
	PlayerTextDrawSetPreviewModel(playerid, Entry_HUD[playerid][9], 1650);
	PlayerTextDrawSetPreviewRot(playerid, Entry_HUD[playerid][9], -31.000, -11.000, -180.000, 2.996);
	PlayerTextDrawSetPreviewVehCol(playerid, Entry_HUD[playerid][9], 0, 0);

	Entry_HUD[playerid][10] = CreatePlayerTextDraw(playerid, 621.000, 277.000, "100 mph");
	PlayerTextDrawLetterSize(playerid, Entry_HUD[playerid][10], 0.149, 0.998);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][10], 2);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][10], 1);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][10], 1);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][10], 150);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][10], 1);

	Entry_HUD[playerid][11] = CreatePlayerTextDraw(playerid, 620.000, 301.000, "100L");
	PlayerTextDrawLetterSize(playerid, Entry_HUD[playerid][11], 0.218, 1.090);
	PlayerTextDrawAlignment(playerid, Entry_HUD[playerid][11], 2);
	PlayerTextDrawColor(playerid, Entry_HUD[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, Entry_HUD[playerid][11], 1);
	PlayerTextDrawSetOutline(playerid, Entry_HUD[playerid][11], 1);
	PlayerTextDrawBackgroundColor(playerid, Entry_HUD[playerid][11], 150);
	PlayerTextDrawFont(playerid, Entry_HUD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, Entry_HUD[playerid][11], 1);

	//Info textdraw
	InfoTD[playerid] = CreatePlayerTextDraw(playerid, 321.000, 358.000, "selamat anda mendapatkan pepek kuda");
	PlayerTextDrawLetterSize(playerid, InfoTD[playerid], 0.214, 1.031);
	PlayerTextDrawAlignment(playerid, InfoTD[playerid], 2);
	PlayerTextDrawColor(playerid, InfoTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, InfoTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, InfoTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, InfoTD[playerid], 255);
	PlayerTextDrawFont(playerid, InfoTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, InfoTD[playerid], 1);
	
	ActiveTD[playerid] = CreatePlayerTextDraw(playerid, 274.000000, 176.583435, "Mengisi Ulang...");
	PlayerTextDrawLetterSize(playerid, ActiveTD[playerid], 0.374000, 1.349166);
	PlayerTextDrawAlignment(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawColor(playerid, ActiveTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, ActiveTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, ActiveTD[playerid], 255);
	PlayerTextDrawFont(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ActiveTD[playerid], 0);
	
	//HBE Textdraw Modern
	DPname[playerid] = CreatePlayerTextDraw(playerid, 537.000000, 367.333251, "Pateeer");
	PlayerTextDrawLetterSize(playerid, DPname[playerid], 0.328999, 1.179998);
	PlayerTextDrawAlignment(playerid, DPname[playerid], 1);
	PlayerTextDrawColor(playerid, DPname[playerid], -1);
	PlayerTextDrawSetShadow(playerid, DPname[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPname[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPname[playerid], 255);
	PlayerTextDrawFont(playerid, DPname[playerid], 0);
	PlayerTextDrawSetProportional(playerid, DPname[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPname[playerid], 0);

	DPmoney[playerid] = CreatePlayerTextDraw(playerid, 535.000000, 381.916473, "$50.000");
	PlayerTextDrawLetterSize(playerid, DPmoney[playerid], 0.231499, 1.034165);
	PlayerTextDrawAlignment(playerid, DPmoney[playerid], 1);
	PlayerTextDrawColor(playerid, DPmoney[playerid], 16711935);
	PlayerTextDrawSetShadow(playerid, DPmoney[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPmoney[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPmoney[playerid], 255);
	PlayerTextDrawFont(playerid, DPmoney[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DPmoney[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPmoney[playerid], 0);

	DPcoin[playerid] = CreatePlayerTextDraw(playerid, 535.500000, 392.999877, "5000_Coin");
	PlayerTextDrawLetterSize(playerid, DPcoin[playerid], 0.246000, 0.952498);
	PlayerTextDrawAlignment(playerid, DPcoin[playerid], 1);
	PlayerTextDrawColor(playerid, DPcoin[playerid], -65281);
	PlayerTextDrawSetShadow(playerid, DPcoin[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPcoin[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPcoin[playerid], 255);
	PlayerTextDrawFont(playerid, DPcoin[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DPcoin[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPcoin[playerid], 0);

	/*TDEditor_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 565.500000, 405.833404, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][3], 68.000000, 8.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][3], 16711935);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);

	TDEditor_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 565.500000, 420.416717, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][4], 68.000000, 8.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][4], 16711935);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 0);

	TDEditor_PTD[playerid][5] = CreatePlayerTextDraw(playerid, 565.500000, 435.000091, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][5], 68.000000, 8.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][5], 16711935);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][5], 0);*/

	DPvehname[playerid] = CreatePlayerTextDraw(playerid, 431.000000, 367.333312, "Turismo");
	PlayerTextDrawLetterSize(playerid, DPvehname[playerid], 0.299499, 1.121665);
	PlayerTextDrawAlignment(playerid, DPvehname[playerid], 1);
	PlayerTextDrawColor(playerid, DPvehname[playerid], -1);
	PlayerTextDrawSetShadow(playerid, DPvehname[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPvehname[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPvehname[playerid], 255);
	PlayerTextDrawFont(playerid, DPvehname[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DPvehname[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPvehname[playerid], 0);

	DPvehengine[playerid] = CreatePlayerTextDraw(playerid, 462.000000, 381.916778, "ON");
	PlayerTextDrawLetterSize(playerid, DPvehengine[playerid], 0.229000, 0.940832);
	PlayerTextDrawAlignment(playerid, DPvehengine[playerid], 1);
	PlayerTextDrawColor(playerid, DPvehengine[playerid], 16711935);
	PlayerTextDrawSetShadow(playerid, DPvehengine[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPvehengine[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPvehengine[playerid], 255);
	PlayerTextDrawFont(playerid, DPvehengine[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DPvehengine[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPvehengine[playerid], 0);

	DPvehspeed[playerid] = CreatePlayerTextDraw(playerid, 460.000000, 391.833312, "120_Mph");
	PlayerTextDrawLetterSize(playerid, DPvehspeed[playerid], 0.266999, 0.946666);
	PlayerTextDrawAlignment(playerid, DPvehspeed[playerid], 1);
	PlayerTextDrawColor(playerid, DPvehspeed[playerid], -1);
	PlayerTextDrawSetShadow(playerid, DPvehspeed[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPvehspeed[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPvehspeed[playerid], 255);
	PlayerTextDrawFont(playerid, DPvehspeed[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DPvehspeed[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPvehspeed[playerid], 0);

	DPvehfare[playerid] = TextDrawCreate(462.000000, 401.166687, "$500.000");
	TextDrawLetterSize(DPvehfare[playerid], 0.216000, 0.952498);
	TextDrawAlignment(DPvehfare[playerid], 1);
	TextDrawColor(DPvehfare[playerid], 16711935);
	TextDrawSetShadow(DPvehfare[playerid], 0);
	TextDrawSetOutline(DPvehfare[playerid], 1);
	TextDrawBackgroundColor(DPvehfare[playerid], 255);
	TextDrawFont(DPvehfare[playerid], 1);
	TextDrawSetProportional(DPvehfare[playerid], 1);
	TextDrawSetShadow(DPvehfare[playerid], 0);

	/*TDEditor_PTD[playerid][10] = CreatePlayerTextDraw(playerid, 459.000000, 415.749938, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][10], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][10], 61.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][10], 16711935);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][10], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][10], 0);

	TDEditor_PTD[playerid][11] = CreatePlayerTextDraw(playerid, 459.500000, 432.083221, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][11], 61.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][11], 16711935);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][11], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][11], 0);*/
	
	//HBE textdraw Simple
	SPvehname[playerid] = CreatePlayerTextDraw(playerid, 540.000000, 366.749908, "Turismo");
	PlayerTextDrawLetterSize(playerid, SPvehname[playerid], 0.319000, 1.022498);
	PlayerTextDrawAlignment(playerid, SPvehname[playerid], 1);
	PlayerTextDrawColor(playerid, SPvehname[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SPvehname[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SPvehname[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, SPvehname[playerid], 255);
	PlayerTextDrawFont(playerid, SPvehname[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SPvehname[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SPvehname[playerid], 0);

	SPvehspeed[playerid] = CreatePlayerTextDraw(playerid, 538.000000, 412.833160, "250_Mph");
	PlayerTextDrawLetterSize(playerid, SPvehspeed[playerid], 0.275498, 1.244166);
	PlayerTextDrawAlignment(playerid, SPvehspeed[playerid], 1);
	PlayerTextDrawColor(playerid, SPvehspeed[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SPvehspeed[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SPvehspeed[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, SPvehspeed[playerid], 255);
	PlayerTextDrawFont(playerid, SPvehspeed[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SPvehspeed[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SPvehspeed[playerid], 0);

	SPvehengine[playerid] = CreatePlayerTextDraw(playerid, 611.500000, 414.000152, "ON");
	PlayerTextDrawLetterSize(playerid, SPvehengine[playerid], 0.280999, 1.104166);
	PlayerTextDrawAlignment(playerid, SPvehengine[playerid], 1);
	PlayerTextDrawColor(playerid, SPvehengine[playerid], 16711935);
	PlayerTextDrawSetShadow(playerid, SPvehengine[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SPvehengine[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, SPvehengine[playerid], 255);
	PlayerTextDrawFont(playerid, SPvehengine[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SPvehengine[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SPvehengine[playerid], 0);

	HBE_GUI[0][playerid] = CreatePlayerTextDraw(playerid, 594.000000, 336.000000, "_");
	PlayerTextDrawFont(playerid, HBE_GUI[0][playerid], 1);
	PlayerTextDrawLetterSize(playerid, HBE_GUI[0][playerid], 0.649999, 5.599985);
	PlayerTextDrawTextSize(playerid, HBE_GUI[0][playerid], 266.500000, 87.500000);
	PlayerTextDrawSetOutline(playerid, HBE_GUI[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid, HBE_GUI[0][playerid], 0);
	PlayerTextDrawAlignment(playerid, HBE_GUI[0][playerid], 2);
	PlayerTextDrawColor(playerid, HBE_GUI[0][playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, HBE_GUI[0][playerid], 255);
	PlayerTextDrawBoxColor(playerid, HBE_GUI[0][playerid], 213);
	PlayerTextDrawUseBox(playerid, HBE_GUI[0][playerid], 1);
	PlayerTextDrawSetProportional(playerid, HBE_GUI[0][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HBE_GUI[0][playerid], 0);

	HBE_GUI[1][playerid] = CreatePlayerTextDraw(playerid, 555.000000, 341.000000, "HUD:radar_datefood");
	PlayerTextDrawFont(playerid, HBE_GUI[1][playerid], 4);
	PlayerTextDrawLetterSize(playerid, HBE_GUI[1][playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, HBE_GUI[1][playerid], 14.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, HBE_GUI[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid, HBE_GUI[1][playerid], 0);
	PlayerTextDrawAlignment(playerid, HBE_GUI[1][playerid], 1);
	PlayerTextDrawColor(playerid, HBE_GUI[1][playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, HBE_GUI[1][playerid], 255);
	PlayerTextDrawBoxColor(playerid, HBE_GUI[1][playerid], 50);
	PlayerTextDrawUseBox(playerid, HBE_GUI[1][playerid], 1);
	PlayerTextDrawSetProportional(playerid, HBE_GUI[1][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HBE_GUI[1][playerid], 0);

	HBE_GUI[2][playerid] = CreatePlayerTextDraw(playerid, 556.000000, 357.000000, "HUD:radar_datedrink");
	PlayerTextDrawFont(playerid, HBE_GUI[2][playerid], 4);
	PlayerTextDrawLetterSize(playerid, HBE_GUI[2][playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, HBE_GUI[2][playerid], 12.500000, 11.500000);
	PlayerTextDrawSetOutline(playerid, HBE_GUI[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid, HBE_GUI[2][playerid], 0);
	PlayerTextDrawAlignment(playerid, HBE_GUI[2][playerid], 1);
	PlayerTextDrawColor(playerid, HBE_GUI[2][playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, HBE_GUI[2][playerid], 255);
	PlayerTextDrawBoxColor(playerid, HBE_GUI[2][playerid], 50);
	PlayerTextDrawUseBox(playerid, HBE_GUI[2][playerid], 1);
	PlayerTextDrawSetProportional(playerid, HBE_GUI[2][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HBE_GUI[2][playerid], 0);

	HBE_GUI[3][playerid] = CreatePlayerTextDraw(playerid, 555.000000, 372.000000, "HUD:radar_sweet");
	PlayerTextDrawFont(playerid, HBE_GUI[3][playerid], 4);
	PlayerTextDrawLetterSize(playerid, HBE_GUI[3][playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, HBE_GUI[3][playerid], 14.000000, 10.500000);
	PlayerTextDrawSetOutline(playerid, HBE_GUI[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid, HBE_GUI[3][playerid], 0);
	PlayerTextDrawAlignment(playerid, HBE_GUI[3][playerid], 1);
	PlayerTextDrawColor(playerid, HBE_GUI[3][playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, HBE_GUI[3][playerid], 255);
	PlayerTextDrawBoxColor(playerid, HBE_GUI[3][playerid], 50);
	PlayerTextDrawUseBox(playerid, HBE_GUI[3][playerid], 1);
	PlayerTextDrawSetProportional(playerid, HBE_GUI[3][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HBE_GUI[3][playerid], 0);

	HBE_GUI[4][playerid] = CreatePlayerTextDraw(playerid, 549.000000, 324.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, HBE_GUI[4][playerid], 4);
	PlayerTextDrawLetterSize(playerid, HBE_GUI[4][playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, HBE_GUI[4][playerid], 91.000000, 2.500000);
	PlayerTextDrawSetOutline(playerid, HBE_GUI[4][playerid], 1);
	PlayerTextDrawSetShadow(playerid, HBE_GUI[4][playerid], 0);
	PlayerTextDrawAlignment(playerid, HBE_GUI[4][playerid], 1);
	PlayerTextDrawColor(playerid, HBE_GUI[4][playerid], -2686721);
	PlayerTextDrawBackgroundColor(playerid, HBE_GUI[4][playerid], 255);
	PlayerTextDrawBoxColor(playerid, HBE_GUI[4][playerid], 50);
	PlayerTextDrawUseBox(playerid, HBE_GUI[4][playerid], 1);
	PlayerTextDrawSetProportional(playerid, HBE_GUI[4][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HBE_GUI[4][playerid], 0);

	HBE_SPEED[playerid] = CreatePlayerTextDraw(playerid, 568.000000, 277.000000, "100");
	PlayerTextDrawFont(playerid, HBE_SPEED[playerid], 3);
	PlayerTextDrawLetterSize(playerid, HBE_SPEED[playerid], 0.616666, 5.050002);
	PlayerTextDrawTextSize(playerid, HBE_SPEED[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HBE_SPEED[playerid], 1);
	PlayerTextDrawSetShadow(playerid, HBE_SPEED[playerid], 0);
	PlayerTextDrawAlignment(playerid, HBE_SPEED[playerid], 2);
	PlayerTextDrawColor(playerid, HBE_SPEED[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, HBE_SPEED[playerid], 255);
	PlayerTextDrawBoxColor(playerid, HBE_SPEED[playerid], 50);
	PlayerTextDrawUseBox(playerid, HBE_SPEED[playerid], 0);
	PlayerTextDrawSetProportional(playerid, HBE_SPEED[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HBE_SPEED[playerid], 0);

	HBE_GUI[5][playerid] = CreatePlayerTextDraw(playerid, 597.000000, 286.000000, "KMH");
	PlayerTextDrawFont(playerid, HBE_GUI[5][playerid], 3);
	PlayerTextDrawLetterSize(playerid, HBE_GUI[5][playerid], 0.229167, 0.950000);
	PlayerTextDrawTextSize(playerid, HBE_GUI[5][playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HBE_GUI[5][playerid], 1);
	PlayerTextDrawSetShadow(playerid, HBE_GUI[5][playerid], 0);
	PlayerTextDrawAlignment(playerid, HBE_GUI[5][playerid], 2);
	PlayerTextDrawColor(playerid, HBE_GUI[5][playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, HBE_GUI[5][playerid], 255);
	PlayerTextDrawBoxColor(playerid, HBE_GUI[5][playerid], 50);
	PlayerTextDrawUseBox(playerid, HBE_GUI[5][playerid], 0);
	PlayerTextDrawSetProportional(playerid, HBE_GUI[5][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HBE_GUI[5][playerid], 0);

	HBE_HEALTH[playerid] = CreatePlayerTextDraw(playerid, 627.000000, 297.000000, "HEALTH: 1000");
	PlayerTextDrawFont(playerid, HBE_HEALTH[playerid], 1);
	PlayerTextDrawLetterSize(playerid, HBE_HEALTH[playerid], 0.162500, 0.950000);
	PlayerTextDrawTextSize(playerid, HBE_HEALTH[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HBE_HEALTH[playerid], 1);
	PlayerTextDrawSetShadow(playerid, HBE_HEALTH[playerid], 0);
	PlayerTextDrawAlignment(playerid, HBE_HEALTH[playerid], 3);
	PlayerTextDrawColor(playerid, HBE_HEALTH[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, HBE_HEALTH[playerid], 255);
	PlayerTextDrawBoxColor(playerid, HBE_HEALTH[playerid], 50);
	PlayerTextDrawUseBox(playerid, HBE_HEALTH[playerid], 0);
	PlayerTextDrawSetProportional(playerid, HBE_HEALTH[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HBE_HEALTH[playerid], 0);

	HBE_FUEL[playerid] = CreatePlayerTextDraw(playerid, 620.000000, 308.000000, "FUEL: 1000");
	PlayerTextDrawFont(playerid, HBE_FUEL[playerid], 1);
	PlayerTextDrawLetterSize(playerid, HBE_FUEL[playerid], 0.162500, 0.950000);
	PlayerTextDrawTextSize(playerid, HBE_FUEL[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HBE_FUEL[playerid], 1);
	PlayerTextDrawSetShadow(playerid, HBE_FUEL[playerid], 0);
	PlayerTextDrawAlignment(playerid, HBE_FUEL[playerid], 3);
	PlayerTextDrawColor(playerid, HBE_FUEL[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, HBE_FUEL[playerid], 255);
	PlayerTextDrawBoxColor(playerid, HBE_FUEL[playerid], 50);
	PlayerTextDrawUseBox(playerid, HBE_FUEL[playerid], 0);
	PlayerTextDrawSetProportional(playerid, HBE_FUEL[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HBE_FUEL[playerid], 0);

	HUNGER[playerid] = CreatePlayerTextDraw(playerid, 612.000, 352.000, "100%");
	PlayerTextDrawLetterSize(playerid, HUNGER[playerid], 0.170, 1.099);
	PlayerTextDrawAlignment(playerid, HUNGER[playerid], 2);
	PlayerTextDrawColor(playerid, HUNGER[playerid], -1);
	PlayerTextDrawSetShadow(playerid, HUNGER[playerid], 0);
	PlayerTextDrawSetOutline(playerid, HUNGER[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, HUNGER[playerid], 150);
	PlayerTextDrawFont(playerid, HUNGER[playerid], 1);
	PlayerTextDrawSetProportional(playerid, HUNGER[playerid], 1);

	THIRST[playerid] = CreatePlayerTextDraw(playerid, 612.000, 366.000, "100%");
	PlayerTextDrawLetterSize(playerid, THIRST[playerid], 0.170, 1.099);
	PlayerTextDrawAlignment(playerid, THIRST[playerid], 2);
	PlayerTextDrawColor(playerid, THIRST[playerid], -1);
	PlayerTextDrawSetShadow(playerid, THIRST[playerid], 0);
	PlayerTextDrawSetOutline(playerid, THIRST[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, THIRST[playerid], 150);
	PlayerTextDrawFont(playerid, THIRST[playerid], 1);
	PlayerTextDrawSetProportional(playerid, THIRST[playerid], 1);

	STRESS[playerid] = CreatePlayerTextDraw(playerid, 612.000, 383.000, "100%");
	PlayerTextDrawLetterSize(playerid, STRESS[playerid], 0.170, 1.099);
	PlayerTextDrawAlignment(playerid, STRESS[playerid], 2);
	PlayerTextDrawColor(playerid, STRESS[playerid], -1);
	PlayerTextDrawSetShadow(playerid, STRESS[playerid], 0);
	PlayerTextDrawSetOutline(playerid, STRESS[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, STRESS[playerid], 150);
	PlayerTextDrawFont(playerid, STRESS[playerid], 1);
	PlayerTextDrawSetProportional(playerid, STRESS[playerid], 1);

}

CreateTextDraw()
{
	//Date and Time
	TextDate = TextDrawCreate(36.000, 432.000, "19 Januari 2024");
	TextDrawLetterSize(TextDate, 0.199, 1.250);
	TextDrawTextSize(TextDate, 735.500, 610.000);
	TextDrawAlignment(TextDate, 1);
	TextDrawColor(TextDate, -1);
	TextDrawSetShadow(TextDate, 1);
	TextDrawSetOutline(TextDate, 1);
	TextDrawBackgroundColor(TextDate, 255);
	TextDrawFont(TextDate, 1);
	TextDrawSetProportional(TextDate, 1);

	TextTime = TextDrawCreate(555.000, 29.000, "15:09:13");
	TextDrawLetterSize(TextTime, 0.270, 1.149);
	TextDrawTextSize(TextTime, 796.500, 847.000);
	TextDrawAlignment(TextTime, 1);
	TextDrawColor(TextTime, -1);
	TextDrawSetShadow(TextTime, 1);
	TextDrawSetOutline(TextTime, 1);
	TextDrawBackgroundColor(TextTime, 255);
	TextDrawFont(TextTime, 3);
	TextDrawSetProportional(TextTime, 1);
	
	//Server Name
	SOIRP_TXD = TextDrawCreate(25.777742, 421.119964, "~r~Basic ~w~Roleplay");
	TextDrawLetterSize(SOIRP_TXD, 0.269998, 1.405864);
	TextDrawAlignment(SOIRP_TXD, 1);
	TextDrawColor(SOIRP_TXD, 0xFF0000FF);
	TextDrawSetShadow(SOIRP_TXD, 0);
	TextDrawSetOutline(SOIRP_TXD, 1);
	TextDrawBackgroundColor(SOIRP_TXD, 0x000000FF);
	TextDrawFont(SOIRP_TXD, 1);
	TextDrawSetProportional(SOIRP_TXD, 1);
	
	//HBE textdraw Modern
	TDEditor_TD[0] = TextDrawCreate(531.000000, 365.583435, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[0], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[0], 164.000000, 109.000000);
	TextDrawAlignment(TDEditor_TD[0], 1);
	TextDrawColor(TDEditor_TD[0], 120);
	TextDrawSetShadow(TDEditor_TD[0], 0);
	TextDrawSetOutline(TDEditor_TD[0], 0);
	TextDrawBackgroundColor(TDEditor_TD[0], 255);
	TextDrawFont(TDEditor_TD[0], 4);
	TextDrawSetProportional(TDEditor_TD[0], 0);
	TextDrawSetShadow(TDEditor_TD[0], 0);

	TDEditor_TD[1] = TextDrawCreate(533.000000, 367.916778, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[1], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[1], 105.000000, 13.000000);
	TextDrawAlignment(TDEditor_TD[1], 1);
	TextDrawColor(TDEditor_TD[1], 16777215);
	TextDrawSetShadow(TDEditor_TD[1], 0);
	TextDrawSetOutline(TDEditor_TD[1], 0);
	TextDrawBackgroundColor(TDEditor_TD[1], 255);
	TextDrawFont(TDEditor_TD[1], 4);
	TextDrawSetProportional(TDEditor_TD[1], 0);
	TextDrawSetShadow(TDEditor_TD[1], 0);

	TDEditor_TD[2] = TextDrawCreate(543.500000, 399.416625, "");
	TextDrawLetterSize(TDEditor_TD[2], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[2], 15.000000, 20.000000);
	TextDrawAlignment(TDEditor_TD[2], 1);
	TextDrawColor(TDEditor_TD[2], -1);
	TextDrawSetShadow(TDEditor_TD[2], 0);
	TextDrawSetOutline(TDEditor_TD[2], 0);
	TextDrawBackgroundColor(TDEditor_TD[2], 0);
	TextDrawFont(TDEditor_TD[2], 5);
	TextDrawSetProportional(TDEditor_TD[2], 0);
	TextDrawSetShadow(TDEditor_TD[2], 0);
	TextDrawSetPreviewModel(TDEditor_TD[2], 2703);
	TextDrawSetPreviewRot(TDEditor_TD[2], 0.000000, 90.000000, 80.000000, 1.000000);

	TDEditor_TD[3] = TextDrawCreate(536.500000, 414.000030, "");
	TextDrawLetterSize(TDEditor_TD[3], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[3], 26.000000, 19.000000);
	TextDrawAlignment(TDEditor_TD[3], 1);
	TextDrawColor(TDEditor_TD[3], -1);
	TextDrawSetShadow(TDEditor_TD[3], 0);
	TextDrawSetOutline(TDEditor_TD[3], 0);
	TextDrawBackgroundColor(TDEditor_TD[3], 0);
	TextDrawFont(TDEditor_TD[3], 5);
	TextDrawSetProportional(TDEditor_TD[3], 0);
	TextDrawSetShadow(TDEditor_TD[3], 0);
	TextDrawSetPreviewModel(TDEditor_TD[3], 1546);
	TextDrawSetPreviewRot(TDEditor_TD[3], 0.000000, 0.000000, 200.000000, 1.000000);

	TDEditor_TD[4] = TextDrawCreate(543.000000, 428.000030, "");
	TextDrawLetterSize(TDEditor_TD[4], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[4], 17.000000, 17.000000);
	TextDrawAlignment(TDEditor_TD[4], 1);
	TextDrawColor(TDEditor_TD[4], -1);
	TextDrawSetShadow(TDEditor_TD[4], 0);
	TextDrawSetOutline(TDEditor_TD[4], 0);
	TextDrawBackgroundColor(TDEditor_TD[4], 0);
	TextDrawFont(TDEditor_TD[4], 5);
	TextDrawSetProportional(TDEditor_TD[4], 0);
	TextDrawSetShadow(TDEditor_TD[4], 0);
	TextDrawSetPreviewModel(TDEditor_TD[4], 2738);
	TextDrawSetPreviewRot(TDEditor_TD[4], 0.000000, 0.000000, 100.000000, 1.000000);

	TDEditor_TD[5] = TextDrawCreate(425.000000, 365.583557, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[5], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[5], 102.000000, 92.000000);
	TextDrawAlignment(TDEditor_TD[5], 1);
	TextDrawColor(TDEditor_TD[5], 120);
	TextDrawSetShadow(TDEditor_TD[5], 0);
	TextDrawSetOutline(TDEditor_TD[5], 0);
	TextDrawBackgroundColor(TDEditor_TD[5], 255);
	TextDrawFont(TDEditor_TD[5], 4);
	TextDrawSetProportional(TDEditor_TD[5], 0);
	TextDrawSetShadow(TDEditor_TD[5], 0);

	TDEditor_TD[6] = TextDrawCreate(428.000000, 367.916717, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[6], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[6], 97.000000, 11.000000);
	TextDrawAlignment(TDEditor_TD[6], 1);
	TextDrawColor(TDEditor_TD[6], 16777215);
	TextDrawSetShadow(TDEditor_TD[6], 0);
	TextDrawSetOutline(TDEditor_TD[6], 0);
	TextDrawBackgroundColor(TDEditor_TD[6], 255);
	TextDrawFont(TDEditor_TD[6], 4);
	TextDrawSetProportional(TDEditor_TD[6], 0);
	TextDrawSetShadow(TDEditor_TD[6], 0);

	TDEditor_TD[7] = TextDrawCreate(428.000000, 380.750030, "Engine:");
	TextDrawLetterSize(TDEditor_TD[7], 0.248998, 1.063333);
	TextDrawAlignment(TDEditor_TD[7], 1);
	TextDrawColor(TDEditor_TD[7], -1);
	TextDrawSetShadow(TDEditor_TD[7], 0);
	TextDrawSetOutline(TDEditor_TD[7], 1);
	TextDrawBackgroundColor(TDEditor_TD[7], 255);
	TextDrawFont(TDEditor_TD[7], 1);
	TextDrawSetProportional(TDEditor_TD[7], 1);
	TextDrawSetShadow(TDEditor_TD[7], 0);

	TDEditor_TD[8] = TextDrawCreate(428.000000, 389.499969, "Speed:");
	TextDrawLetterSize(TDEditor_TD[8], 0.266499, 1.191666);
	TextDrawAlignment(TDEditor_TD[8], 1);
	TextDrawColor(TDEditor_TD[8], -1);
	TextDrawSetShadow(TDEditor_TD[8], 0);
	TextDrawSetOutline(TDEditor_TD[8], 1);
	TextDrawBackgroundColor(TDEditor_TD[8], 255);
	TextDrawFont(TDEditor_TD[8], 1);
	TextDrawSetProportional(TDEditor_TD[8], 1);
	TextDrawSetShadow(TDEditor_TD[8], 0);

	TDEditor_TD[9] = TextDrawCreate(437.000000, 411.083343, "");
	TextDrawLetterSize(TDEditor_TD[9], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[9], 13.000000, 18.000000);
	TextDrawAlignment(TDEditor_TD[9], 1);
	TextDrawColor(TDEditor_TD[9], -1);
	TextDrawSetShadow(TDEditor_TD[9], 0);
	TextDrawSetOutline(TDEditor_TD[9], 0);
	TextDrawBackgroundColor(TDEditor_TD[9], 0);
	TextDrawFont(TDEditor_TD[9], 5);
	TextDrawSetProportional(TDEditor_TD[9], 0);
	TextDrawSetShadow(TDEditor_TD[9], 0);
	TextDrawSetPreviewModel(TDEditor_TD[9], 1240);
	TextDrawSetPreviewRot(TDEditor_TD[9], 0.000000, 0.000000, 0.000000, 1.000000);

	TDEditor_TD[10] = TextDrawCreate(434.500000, 425.666595, "");
	TextDrawLetterSize(TDEditor_TD[10], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[10], 20.000000, 21.000000);
	TextDrawAlignment(TDEditor_TD[10], 1);
	TextDrawColor(TDEditor_TD[10], -1);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	TextDrawSetOutline(TDEditor_TD[10], 0);
	TextDrawBackgroundColor(TDEditor_TD[10], 0);
	TextDrawFont(TDEditor_TD[10], 5);
	TextDrawSetProportional(TDEditor_TD[10], 0);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	TextDrawSetPreviewModel(TDEditor_TD[10], 1650);
	TextDrawSetPreviewRot(TDEditor_TD[10], 0.000000, 0.000000, 0.000000, 1.000000);
	
	TDEditor_TD[11] = TextDrawCreate(427.000000, 400.583374, "Fare:");
	TextDrawLetterSize(TDEditor_TD[11], 0.360498, 1.022500);
	TextDrawAlignment(TDEditor_TD[11], 1);
	TextDrawColor(TDEditor_TD[11], -1);
	TextDrawSetShadow(TDEditor_TD[11], 0);
	TextDrawSetOutline(TDEditor_TD[11], 1);
	TextDrawBackgroundColor(TDEditor_TD[11], 255);
	TextDrawFont(TDEditor_TD[11], 1);
	TextDrawSetProportional(TDEditor_TD[11], 1);
	TextDrawSetShadow(TDEditor_TD[11], 0);
	
	//HBE textdraw Simple
	TDEditor_TD[12] = TextDrawCreate(450.500000, 428.000091, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[12], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[12], 191.000000, 27.000000);
	TextDrawAlignment(TDEditor_TD[12], 1);
	TextDrawColor(TDEditor_TD[12], 175);
	TextDrawSetShadow(TDEditor_TD[12], 0);
	TextDrawSetOutline(TDEditor_TD[12], 0);
	TextDrawBackgroundColor(TDEditor_TD[12], 255);
	TextDrawFont(TDEditor_TD[12], 4);
	TextDrawSetProportional(TDEditor_TD[12], 0);
	TextDrawSetShadow(TDEditor_TD[12], 0);

	TDEditor_TD[13] = TextDrawCreate(450.000000, 422.166778, "");
	TextDrawLetterSize(TDEditor_TD[13], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[13], 17.000000, 34.000000);
	TextDrawAlignment(TDEditor_TD[13], 1);
	TextDrawColor(TDEditor_TD[13], -1);
	TextDrawSetShadow(TDEditor_TD[13], 0);
	TextDrawSetOutline(TDEditor_TD[13], 0);
	TextDrawBackgroundColor(TDEditor_TD[13], 0);
	TextDrawFont(TDEditor_TD[13], 5);
	TextDrawSetProportional(TDEditor_TD[13], 0);
	TextDrawSetShadow(TDEditor_TD[13], 0);
	TextDrawSetPreviewModel(TDEditor_TD[13], 2703);
	TextDrawSetPreviewRot(TDEditor_TD[13], 100.000000, 0.000000, -10.000000, 1.000000);

	TDEditor_TD[14] = TextDrawCreate(507.500000, 429.166748, "");
	TextDrawLetterSize(TDEditor_TD[14], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[14], 25.000000, 20.000000);
	TextDrawAlignment(TDEditor_TD[14], 1);
	TextDrawColor(TDEditor_TD[14], -1);
	TextDrawSetShadow(TDEditor_TD[14], 0);
	TextDrawSetOutline(TDEditor_TD[14], 0);
	TextDrawBackgroundColor(TDEditor_TD[14], 0);
	TextDrawFont(TDEditor_TD[14], 5);
	TextDrawSetProportional(TDEditor_TD[14], 0);
	TextDrawSetShadow(TDEditor_TD[14], 0);
	TextDrawSetPreviewModel(TDEditor_TD[14], 1546);
	TextDrawSetPreviewRot(TDEditor_TD[14], 0.000000, 0.000000, 100.000000, 1.000000);

	TDEditor_TD[15] = TextDrawCreate(574.500000, 427.999969, "");
	TextDrawLetterSize(TDEditor_TD[15], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[15], 20.000000, 19.000000);
	TextDrawAlignment(TDEditor_TD[15], 1);
	TextDrawColor(TDEditor_TD[15], -1);
	TextDrawSetShadow(TDEditor_TD[15], 0);
	TextDrawSetOutline(TDEditor_TD[15], 0);
	TextDrawBackgroundColor(TDEditor_TD[15], 0);
	TextDrawFont(TDEditor_TD[15], 5);
	TextDrawSetProportional(TDEditor_TD[15], 0);
	TextDrawSetShadow(TDEditor_TD[15], 0);
	TextDrawSetPreviewModel(TDEditor_TD[15], 2738);
	TextDrawSetPreviewRot(TDEditor_TD[15], 0.000000, 0.000000, 100.000000, 1.000000);

	TDEditor_TD[16] = TextDrawCreate(533.000000, 365.000061, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[16], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[16], 105.000000, 62.000000);
	TextDrawAlignment(TDEditor_TD[16], 1);
	TextDrawColor(TDEditor_TD[16], 175);
	TextDrawSetShadow(TDEditor_TD[16], 0);
	TextDrawSetOutline(TDEditor_TD[16], 0);
	TextDrawBackgroundColor(TDEditor_TD[16], 255);
	TextDrawFont(TDEditor_TD[16], 4);
	TextDrawSetProportional(TDEditor_TD[16], 0);
	TextDrawSetShadow(TDEditor_TD[16], 0);

	TDEditor_TD[17] = TextDrawCreate(550.000000, 378.999938, "");
	TextDrawLetterSize(TDEditor_TD[17], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[17], 11.000000, 14.000000);
	TextDrawAlignment(TDEditor_TD[17], 1);
	TextDrawColor(TDEditor_TD[17], -1);
	TextDrawSetShadow(TDEditor_TD[17], 0);
	TextDrawSetOutline(TDEditor_TD[17], 0);
	TextDrawBackgroundColor(TDEditor_TD[17], 0);
	TextDrawFont(TDEditor_TD[17], 5);
	TextDrawSetProportional(TDEditor_TD[17], 0);
	TextDrawSetShadow(TDEditor_TD[17], 0);
	TextDrawSetPreviewModel(TDEditor_TD[17], 1240);
	TextDrawSetPreviewRot(TDEditor_TD[17], 0.000000, 0.000000, 0.000000, 1.000000);

	TDEditor_TD[18] = TextDrawCreate(546.500000, 391.249938, "");
	TextDrawLetterSize(TDEditor_TD[18], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[18], 18.000000, 19.000000);
	TextDrawAlignment(TDEditor_TD[18], 1);
	TextDrawColor(TDEditor_TD[18], -1);
	TextDrawSetShadow(TDEditor_TD[18], 0);
	TextDrawSetOutline(TDEditor_TD[18], 0);
	TextDrawBackgroundColor(TDEditor_TD[18], 0);
	TextDrawFont(TDEditor_TD[18], 5);
	TextDrawSetProportional(TDEditor_TD[18], 0);
	TextDrawSetShadow(TDEditor_TD[18], 0);
	TextDrawSetPreviewModel(TDEditor_TD[18], 1650);
	TextDrawSetPreviewRot(TDEditor_TD[18], 0.000000, 0.000000, 0.000000, 1.000000);

	PlayerCrateTD = TextDrawCreate(552.000000, 110.000000, "_");
    TextDrawFont(PlayerCrateTD, 1);
    TextDrawLetterSize(PlayerCrateTD, 0.600000, 6.099998);
    TextDrawTextSize(PlayerCrateTD, 298.500000, 95.000000);
    TextDrawSetOutline(PlayerCrateTD, 1);
    TextDrawSetShadow(PlayerCrateTD, 0);
    TextDrawAlignment(PlayerCrateTD, 2);
    TextDrawColor(PlayerCrateTD, -1);
    TextDrawBackgroundColor(PlayerCrateTD, 255);
    TextDrawBoxColor(PlayerCrateTD, 190);
    TextDrawUseBox(PlayerCrateTD, 1);
    TextDrawSetProportional(PlayerCrateTD, 1);
    TextDrawSetSelectable(PlayerCrateTD, 0);

	NorthLogo[0] = TextDrawCreate(308.000, 4.000, "North");
	TextDrawLetterSize(NorthLogo[0], 0.238, 1.190);
	TextDrawAlignment(NorthLogo[0], 2);
	TextDrawColor(NorthLogo[0], -1);
	TextDrawSetShadow(NorthLogo[0], 1);
	TextDrawSetOutline(NorthLogo[0], 1);
	TextDrawBackgroundColor(NorthLogo[0], 150);
	TextDrawFont(NorthLogo[0], 3);
	TextDrawSetProportional(NorthLogo[0], 1);

	NorthLogo[1] = TextDrawCreate(338.000, 4.000, "Country");
	TextDrawLetterSize(NorthLogo[1], 0.238, 1.190);
	TextDrawAlignment(NorthLogo[1], 2);
	TextDrawColor(NorthLogo[1], -710344449);
	TextDrawSetShadow(NorthLogo[1], 1);
	TextDrawSetOutline(NorthLogo[1], 1);
	TextDrawBackgroundColor(NorthLogo[1], 150);
	TextDrawFont(NorthLogo[1], 3);
	TextDrawSetProportional(NorthLogo[1], 1);

	NorthLogo[2] = TextDrawCreate(325.000, 10.000, "Roleplay");
	TextDrawLetterSize(NorthLogo[2], 0.300, 1.500);
	TextDrawAlignment(NorthLogo[2], 2);
	TextDrawColor(NorthLogo[2], -1448498689);
	TextDrawSetShadow(NorthLogo[2], 1);
	TextDrawSetOutline(NorthLogo[2], 1);
	TextDrawBackgroundColor(NorthLogo[2], 150);
	TextDrawFont(NorthLogo[2], 0);
	TextDrawSetProportional(NorthLogo[2], 1);


	//Textdraws
    BoxStartTraining = TextDrawCreate(561.000000, 105.000000, "_");
    TextDrawFont(BoxStartTraining, 1);
    TextDrawLetterSize(BoxStartTraining, 0.600000, 3.949994);
    TextDrawTextSize(BoxStartTraining, 298.500000, 96.000000);
    TextDrawSetOutline(BoxStartTraining, 1);
    TextDrawSetShadow(BoxStartTraining, 0);
    TextDrawAlignment(BoxStartTraining, 2);
    TextDrawColor(BoxStartTraining, -1);
    TextDrawBackgroundColor(BoxStartTraining, 255);
    TextDrawBoxColor(BoxStartTraining, 210);
    TextDrawUseBox(BoxStartTraining, 1);
    TextDrawSetProportional(BoxStartTraining, 1);
    TextDrawSetSelectable(BoxStartTraining, 0);

    BoxTraining = TextDrawCreate(561.000000, 105.000000, "_");
    TextDrawFont(BoxTraining, 1);
    TextDrawLetterSize(BoxTraining, 0.600000, 7.249993);
    TextDrawTextSize(BoxTraining, 298.500000, 96.000000);
    TextDrawSetOutline(BoxTraining, 1);
    TextDrawSetShadow(BoxTraining, 0);
    TextDrawAlignment(BoxTraining, 2);
    TextDrawColor(BoxTraining, -1);
    TextDrawBackgroundColor(BoxTraining, 255);
    TextDrawBoxColor(BoxTraining, 210);
    TextDrawUseBox(BoxTraining, 1);
    TextDrawSetProportional(BoxTraining, 1);
    TextDrawSetSelectable(BoxTraining, 0);
}
