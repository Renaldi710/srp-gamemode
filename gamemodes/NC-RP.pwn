///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
    North Country coming soon

	/createpv di bagi jadi 2 tipe 	- Tipe Kendaraan Pemain
									- Tipe Kendaraan fraksi

*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma warning disable 239
#pragma warning disable 214

#include <a_samp>
#undef MAX_PLAYERS
#define MAX_PLAYERS	100
#include <crashdetect.inc>
#include <gvar.inc>
#include <a_mysql.inc>
#include <a_actor.inc>
#include <a_zones.inc>
#include <progress2.inc>
#include <eSelection.inc>
#include <Pawn.CMD.inc>
#include <TimestampToDate.inc>
#define ENABLE_3D_TRYG_YSI_SUPPORT
#include <3DTryg.inc>
#include <streamer.inc>
#include <EVF2.inc>
#include <YSI\y_timers>
#include <YSI\y_colours>
#include <YSI\y_va>
#include <sscanf2.inc>
//#include <yom_buttons.inc>
//#include <geoiplite.inc>
#include <garageblock.inc>
#include <dini.inc>
#include <strlib>   
#include <easyDialog>
#include <cb>
#include <chrono>
#include <textdraw-streamer>
#include <mapandreas>
#include <editing>
#include <PreviewModelDialog>  

//-----[ Modular ]-----
#include "Utils\DEFINE.pwn"

new tmpobjid, object_world = -1, object_int = -1;
//====== QUIZ
new quiz,
	answers[256],
	answermade,
	qprs;

new RobMember = 0;
// EVENT SYSTEM
new EventCreated = 0, EventStarted = 0, EventPrize = 500;
new Float: RedX, Float: RedY, Float: RedZ, EventInt, EventWorld;
new Float: BlueX, Float: BlueY, Float: BlueZ;
new EventHP = 100, EventArmour = 0, EventLocked = 0;
new EventWeapon1, EventWeapon2, EventWeapon3, EventWeapon4, EventWeapon5;
new BlueTeam = 0, RedTeam = 0;
new MaxRedTeam = 5, MaxBlueTeam = 5;
new IsAtEvent[MAX_PLAYERS];

new AntiBHOP[MAX_PLAYERS];
//----------[ New Variable ]-----
enum
{
	//---[ DIALOG PUBLIC ]---
	DIALOG_UNUSED,
    DIALOG_LOGIN,
    DIALOG_REGISTER,
    DIALOG_AGE,
	DIALOG_GENDER,
	DIALOG_EMAIL,
	DIALOG_PASSWORD,
	DIALOG_STATS,
	DIALOG_SETTINGS,
	DIALOG_HBEMODE,
	DIALOG_CHANGEAGE,
	//-----------------------
	DIALOG_GOLDSHOP,
	DIALOG_GOLDNAME,
	//---[ DIALOG BISNIS ]---
	DIALOG_SELL_BISNISS,
	DIALOG_SELL_BISNIS,
	DIALOG_MY_BISNIS,
	BISNIS_MENU,
	BISNIS_INFO,
	BISNIS_NAME,
	BISNIS_VAULT,
	BISNIS_WITHDRAW,
	BISNIS_DEPOSIT,
	BISNIS_BUYPROD,
	BISNIS_EDITPROD,
	BISNIS_PRICESET,
	//---[ DIALOG HOUSE ]---
	DIALOG_SELL_HOUSES,
	DIALOG_SELL_HOUSE,
	DIALOG_MY_HOUSES,
	HOUSE_INFO,
	HOUSE_STORAGE,
	HOUSE_WEAPONS,
	HOUSE_MONEY,
	HOUSE_WITHDRAWMONEY,
	HOUSE_DEPOSITMONEY,
	//---[ DIALOG PRIVATE VEHICLE ]---
	DIALOG_FINDVEH,
	DIALOG_TRACKVEH,
	DIALOG_GOTOVEH,
	DIALOG_GETVEH,
	DIALOG_DELETEVEH,
	DIALOG_BUYPV,
	DIALOG_BUYVIPPV,
	DIALOG_BUYPLATE,
	DIALOG_BUYPVCP,
	DIALOG_BUYPVCP_BIKES,
	DIALOG_BUYPVCP_CARS,
	DIALOG_BUYPVCP_UCARS,
	DIALOG_BUYPVCP_JOBCARS,
	DIALOG_BUYPVCP_VIPCARS,
	DIALOG_BUYPVCP_CONFIRM,
	DIALOG_BUYPVCP_VIPCONFIRM,
	DIALOG_RENT_JOBCARS,
	DIALOG_RENT_JOBCARSCONFIRM,
	//---[ DIALOG TOYS ]---
	DIALOG_TOY,
	DIALOG_TOYEDIT,
	DIALOG_TOYPOSISI,
	DIALOG_TOYPOSISIBUY,
	DIALOG_TOYBUY,
	DIALOG_TOYVIP,
	DIALOG_TOYPOSX,
	DIALOG_TOYPOSY,
	DIALOG_TOYPOSZ,
	DIALOG_TOYPOSRX,
	DIALOG_TOYPOSRY,
	DIALOG_TOYPOSRZ,
	//---[ DIALOG PLAYER ]---
	DIALOG_HELP,
	DIALOG_GPS,
	DIALOG_JOB,
	DIALOG_GPS_JOB,
	DIALOG_GPS_MORE,
	DIALOG_PAY,
	//---[ DIALOG WEAPONS ]---
	DIALOG_EDITBONE,
	//---[ DIALOG FAMILY ]---
	FAMILY_SAFE,
	FAMILY_STORAGE,
	FAMILY_WEAPONS,
	FAMILY_MARIJUANA,
	FAMILY_WITHDRAWMARIJUANA,
	FAMILY_DEPOSITMARIJUANA,
	FAMILY_COMPONENT,
	FAMILY_WITHDRAWCOMPONENT,
	FAMILY_DEPOSITCOMPONENT,
	FAMILY_MATERIAL,
	FAMILY_WITHDRAWMATERIAL,
	FAMILY_DEPOSITMATERIAL,
	FAMILY_MONEY,
	FAMILY_WITHDRAWMONEY,
	FAMILY_DEPOSITMONEY,
	FAMILY_INFO,
	//---[ DIALOG FACTION ]---
	DIALOG_LOCKERSAPD,
	DIALOG_WEAPONSAPD,
	DIALOG_LOCKERSAGS,
	DIALOG_WEAPONSAGS,
	DIALOG_LOCKERSAMD,
	DIALOG_WEAPONSAMD,
	DIALOG_LOCKERSANEW,
	DIALOG_WEAPONSANEW,
	
	DIALOG_LOCKERVIP,
	//---[ DIALOG JOB ]---
	//MECH
	DIALOG_SERVICE,
	DIALOG_SERVICE_COLOR,
	DIALOG_SERVICE_COLOR2,
	DIALOG_SERVICE_PAINTJOB,
	DIALOG_SERVICE_WHEELS,
	DIALOG_SERVICE_SPOILER,
	DIALOG_SERVICE_HOODS,
	DIALOG_SERVICE_VENTS,
	DIALOG_SERVICE_LIGHTS,
	DIALOG_SERVICE_EXHAUSTS,
	DIALOG_SERVICE_FRONT_BUMPERS,
	DIALOG_SERVICE_REAR_BUMPERS,
	DIALOG_SERVICE_ROOFS,
	DIALOG_SERVICE_SIDE_SKIRTS,
	DIALOG_SERVICE_BULLBARS,
	DIALOG_SERVICE_NEON,
	//Trucker
	DIALOG_HAULING,
	DIALOG_RESTOCK,
	
	//ARMS Dealer
	DIALOG_ARMS_GUN,
	
	//Farmer job
	DIALOG_PLANT,
	DIALOG_EDIT_PRICE,
	DIALOG_EDIT_PRICE1,
	DIALOG_EDIT_PRICE2,
	DIALOG_EDIT_PRICE3,
	DIALOG_EDIT_PRICE4,
	DIALOG_OFFER,
	//----[ Items ]-----
	DIALOG_MATERIAL,
	DIALOG_COMPONENT,
	DIALOG_DRUGS,
	DIALOG_FOOD,
	DIALOG_FOOD_BUY,
	DIALOG_SEED_BUY,
	DIALOG_PRODUCT,
	DIALOG_GASOIL,
	DIALOG_APOTEK,
	//Bank
	DIALOG_ATM,
	DIALOG_ATMWITHDRAW,
	DIALOG_BANK,
	DIALOG_BANKDEPOSIT,
	DIALOG_BANKWITHDRAW,
	DIALOG_BANKREKENING,
	DIALOG_BANKTRANSFER,
	DIALOG_BANKCONFIRM,
	DIALOG_BANKSUKSES,
	
	//reports
	DIALOG_REPORTS,
	//ask
	DIALOG_ASKS,
	DIALOG_SALARY,
	DIALOG_PAYCHECK,
	
	//Sidejob
	DIALOG_SWEEPER,
	DIALOG_BUS,
	DIALOG_FORKLIFT,
	// HEALTH
	DIALOG_HEALTH,
	// OBAT
	DIALOG_OBAT,
	// KUOTA
	DIALOG_ISIKUOTA,
	DIALOG_DOWNLOAD,
	DIALOG_KUOTA,
	// STUCK
	DIALOG_STUCK,
	// TDM
	DIALOG_TDM,
	//
	DIALOG_PICKUPVEH,
	DIALOG_TRACKPARK,
	DIALOG_MY_WS,
	DIALOG_TRACKWS,
	WS_MENU,
	WS_SETNAME,
	WS_SETOWNER,
	WS_SETEMPLOYE,
	WS_SETEMPLOYEE,
	WS_SETOWNERCONFIRM,
	WS_SETMEMBER,
	WS_SETMEMBERE,
	WS_MONEY,
	WS_WITHDRAWMONEY,
	WS_DEPOSITMONEY,
	WS_COMPONENT,
	WS_COMPONENT2,
	WS_MATERIAL,
	WS_MATERIAL2,

	//dialog
	DIALOG_SELECTCHAR,
	DIALOG_CREATECHAR,
	//tax
	DIALOG_PAYTAX,
	DIALOG_PAYTAX_BISNIS,
	DIALOG_PAYTAX_HOUSE,
	DIALOG_ADDFURNOBJECT
}

// DOWNLOAD
new download[MAX_PLAYERS];
// Countdown
new Count = -1;
new countTimer;
new showCD[MAX_PLAYERS];
new CountText[5][5] =
{
	"~r~1",
	"~g~2",
	"~y~3",
	"~g~4",
	"~b~5"
};

// WBR
new File[128];

// ROB
new robmoney;

// Server Uptime
new up_days,
	up_hours,
	up_minutes,
	up_seconds,
	WorldTime = 10,
	WorldWeather = 24;

new SAPDSkinMale[] =
{
	280, 281, 282, 283, 284, 288, 300, 301, 302, 303, 304, 305, 310, 311, 165, 166, 265, 266, 267,
	121, 285, 286, 287, 117, 118, 165, 166
};

new SAPDSkinFemale[] =
{
	306, 307, 309, 148, 150
};

new SAGSSkinMale[] =
{
	171, 17, 71, 147, 187, 165, 166, 163, 164, 255, 295, 294, 303, 304, 305, 189, 253
};

new SAGSSkinFemale[] =
{
	9, 11, 76, 141, 150, 219, 169, 172, 194, 263
};

new SAMDSkinMale[] =
{
	70, 187, 303, 304, 305, 274, 275, 276, 277, 278, 279, 165, 71, 177
};

new SAMDSkinFemale[] =
{
	308, 76, 141, 148, 150, 169, 172, 194, 219
};

new SANASkinMale[] =
{
	171, 187, 189, 240, 303, 304, 305, 20, 59
};

new SANASkinFemale[] =
{
	172, 194, 211, 216, 219, 233, 11, 9
};

new ToysModel[] =
{
	19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022,
	19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19033, 19034, 19035, 19801, 18891, 18892, 18893,
	18894, 18895, 18896, 18897, 18898, 18899, 18900, 18901, 18902, 18903, 18904, 18905, 18906, 18907, 18908, 18909, 18910,
	18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920, 19036, 19037, 19038, 19557, 11704, 19472, 18974,
	19163, 19064, 19160, 19352, 19528, 19330, 19331, 18921, 18922, 18923, 18924, 18925, 18926, 18927, 18928, 18929, 18930,
	18931, 18932, 18933, 18934, 18935, 18939, 18940, 18941, 18942, 18943, 18944, 18945, 18946, 18947, 18948, 18949, 18950,
	18951, 18953, 18954, 18960, 18961, 19098, 19096, 18964, 18967, 18968, 18969, 19106, 19113, 19114, 19115, 18970, 18638,
	19553, 19558, 19554, 18971, 18972, 18973, 19101, 19116, 19117, 19118, 19119, 19120, 18952, 18645, 19039, 19040, 19041,
	19042, 19043, 19044, 19045, 19046, 19047, 19053, 19421, 19422, 19423, 19424, 19274, 19518, 19077, 19517, 19317, 19318,
	19319, 19520, 1550, 19592, 19621, 19622, 19623, 19624, 19625, 19626, 19555, 19556, 19469, 19085, 19559, 19904, 19942,
	19944, 11745, 19773, 18639, 18640, 18641, 18635, 18633, 3028, 11745, 19142, 371, 336, 1242, 2967, 3016, 11718, 19141,
	19137, 19607, 19086, 18637, 18642, 19590, 918, 19306, 19307, 6865
};

new ShopSkinMale[] =
{
    1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33,
	34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 68, 72, 73,
	78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
	110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 153, 154, 156, 158, 159, 160, 161, 162, 167, 168, 170,
	171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 188, 189, 190, 200, 202, 203,
	204, 206, 208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240, 241,
	242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289, 290, 291, 292, 293,
	294, 296, 297, 299
};

new ShopSkinFemale[]=
{
    9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 85, 88, 89, 90, 91, 92,
	93, 129, 130, 131, 138, 140, 141, 145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195, 196,
	197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245,
	246, 251, 256, 257, 263, 298
};

new VipSkinMale[] =
{
	1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33,
	34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 68, 72, 73,
	78, 79, 80, 81, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
	110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170,
	171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203,
	204, 206, 208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240, 241,
	242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289, 290, 291, 292, 293,
	294, 295, 296, 297, 299
};

new VipSkinFemale[] =
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 85, 88, 89, 90, 91, 92,
	93, 129, 130, 131, 138, 140, 141, 145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195, 196,
	197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245,
	246, 251, 256, 257, 263, 298
};

new VipModel[] =
{
	19138, 19139, 19140, 19064, 19065, 19066,
	19137,
	19528,
	19558,
	19036,
	19037,
	19038,
	18971,
	18970,
	18972,
	18946,
	19078,
	19079,
	11745,
	19317,
	19318,
	19319
};

// Faction Vehicle
#define VEHICLE_RESPAWN 7200

new SAPDVehicles[30],
	SAGSVehicles[30],
	SAMDVehicles[30],
	SANAVehicles[30];

//Showroom Checkpoint
new ShowRoomCP,
	ShowRoomCPRent;

// Showroom Vehicles
//new SRV[35],
//	VSRV[20];
	
/*// Button and Doors
new SAGSLobbyBtn[2],
	SAGSLobbyDoor;
new gMyButtons[2],
	gMyDoor;*/
	
/*//Keypad Txd
new SAGSLobbyKey[2],
	SAGSLobbyDoor;
*/

// Duty Timer

new DutyTimer;

// Yom Button
new SAGSLobbyBtn[2],
	SAGSLobbyDoor,
	SAPDLobbyBtn[4],
	SAPDLobbyDoor[4],
	LLFLobbyBtn[2],
	LLFLobbyDoor;

// MySQL connection handle
new MySQL: g_SQL;

new TogOOC = 1;

static const BajuLakiLaki[] = {
    1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33,
	34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 68, 72, 73,
	78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
	110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170,
	171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203,
	204, 206, 208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240, 241,
	242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289, 290, 291, 292, 293,
	294, 295, 296, 299
};

static const BajuPerempuan[] = 
{
    9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 85, 88, 89, 90, 91, 92,
	93, 129, 130, 131, 138, 140, 141, 145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195, 196,
	197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245,
	246, 251, 256, 257, 263, 298
};

enum
{
	SIDEJOB_NONE = 0,
	SIDEJOB_BUS_AB,
	SIDEJOB_BUS_CD,
	SIDEJOB_SWEEPER,
	SIDEJOB_FORKLIFT,
	SIDEJOB_PIZZA,
	SIDEJOB_COURIER
}

enum ucpData {
    uID,
    uUsername[64],
    uPassword[128],
    uVerifyCode,
    uSalt[128],
    uIP[16],
    uLogged,
    uLoginAttempts,
    uRegisterDate,
	uRegistered,
    uAdmin,
	uSkin,
};
new UcpData[MAX_PLAYERS][ucpData];

// Player data
enum E_PLAYERS
{
	pID,
	pUCP[22],
	pExtraChar,
	pChar,
	pName[MAX_PLAYER_NAME],
	pAdminname[MAX_PLAYER_NAME],
	pTwittername[MAX_PLAYER_NAME],
	pIP[16],
	pPassword[65],
	pSalt[17],
	pEmail[40],
	pAdmin,
	pHelper,
	pLevel,
	pLevelUp,
	pVip,
	pVipTime,
	pGold,
	pRegDate[50],
	pLastLogin[50],
	pLastCar,
	pMoney,
	Text3D:pMaskLabel,
	pBankMoney,
	pBankRek,
	pPhone,
	pPhoneCredit,
	pPhoneBook,
	pSMS,
	pCall,
	pCallTime,
	pWT,
	pHours,
	pMinutes,
	pSeconds,
	pPaycheck,
	pSkin,
	pFacSkin,
	pGender,
	pAge[50],
	pInDoor,
	pInHouse,
	pInBiz,
	pInBasement,
	Float: pPosX,
	Float: pPosY,
	Float: pPosZ,
	Float: pPosA,
	pInt,
	pWorld,
	Float:pHealth,
    Float:pArmour,
	pHunger,
	pBladder,
	pEnergy,
	pHungerTime,
	pEnergyTime,
	pBladderTime,
	pSick,
	pSickTime,
	pHospital,
	pHospitalTime,
	pInjured,
	pOnDuty,
	pOnDutyTime,
	pFaction,
	pFactionRank,
	pFactionLead,
	pTazer,
	pBroadcast,
	pNewsGuest,
	pFamily,
	pFamilyRank,
	pJail,
	pJailTime,
	pArrest,
	pArrestTime,
	pWarn,
	pJob,
	pJob2,
	pMinerTime,
	pLumberTime,
	pFishTime,
	//pProductTime,
	pTruckerCrateTime,
	//pTruckerProductTime,
	pTruckerHaulingTime,
	pSweeperTime,
	pCourierTime,
	pBusTime,
	pForkliftTime,
	pTrashMasterTime,
	pJobTime,
	pExitJob,
	pMedicine,
	pMedkit,
	pMask,
	pHelmet,
	pSnack,
	pSprunk,
	pGas,
	pBandage,
	pGPS,
	pMaterial,
	pComponent,
	pFood,
	pSeed,
	pPotato,
	pWheat,
	pOrange,
	pPrice1,
	pPrice2,
	pPrice3,
	pPrice4,
	pMarijuana,
	pPlant,
	pPlantTime,
	pFishTool,
	pWorm,
	Float:pFish,
	Float:pFish1,
	Float:pFish2,
	Float:pFish3,
	Float:pFish4,
	pInFish,
	Timer:pFishingTime,
	pIDCard,
	pIDCardTime,
	pDriveLic,
	pDriveLicTime,
	pBoatLic,
	pBoatLicTime,
	pGuns[13],
    pAmmo[13],
	pWeapon,
	//Not Save
	Cache:Cache_ID,
	bool: IsLoggedIn,
	LoginAttempts,
	LoginTimer,
	pSpawned,
	pAdminDuty,
	pFreezeTimer,
	pFreeze,
	pMaskID,
	pMaskOn,
	pSPY,
	pTogPM,
	pVeh,
	pTogLog,
	pTogAds,
	pTogWT,
	Text3D:pAdoTag,
	Text3D:pBTag,
	bool:pBActive,
	bool:pAdoActive,
	pFlare,
	bool:pFlareActive,
	pTrackCar,
	pBuyPvModel,
	pTrackHouse,
	pTrackBisnis,
	pTrackDestination,
	pTrackFactionVeh,
	pFacInvite,
	pFacOffer,
	pFamInvite,
	pFamOffer,
	pFindEms,
	pCuffed,
	toySelected,
	bool:PurchasedToy,
	pEditingItem,
	pProductModify,
	pCurrSeconds,
	pCurrMinutes,
	pCurrHours,
	pSpec,
	playerSpectated,
	pFriskOffer,
	pDragged,
	pDraggedBy,
	pDragTimer,
	pHBEMode,
	pHelmetOn,
	pSeatBelt,
	pReportTime,
	pAskTime,
	//Player Progress Bar
	PlayerBar:fuelbar,
	PlayerBar:damagebar,
	PlayerBar:hungrybar,
	PlayerBar:energybar,
	PlayerBar:bladdybar,
	PlayerBar:spfuelbar,
	PlayerBar:spdamagebar,
	PlayerBar:sphungrybar,
	PlayerBar:spenergybar,
	PlayerBar:spbladdybar,
	PlayerBar:activitybar,
	//pProducting,
	pCooking,
	pArmsDealer,
	pMechanic,
	pActivity,
	pActivityTime,
	//Jobs
	pSideJob,
	pSideJobTime,
	pGetJob,
	pGetJob2,
	pTaxiDuty,
	pTaxiTime,
	//rent
	pRentData,
	pRents,
	pBusWaiting,
	pFare,
	pFareTimer,
	pTotalFare,
	Float:pFareOldX,
	Float:pFareOldY,
	Float:pFareOldZ,
	Float:pFareNewX,
	Float:pFareNewY,
	Float:pFareNewZ,
	pMechDuty,
	pMechVeh,
	pMechColor1,
	pMechColor2,
	//ATM
	EditingATMID,
	//lumber job
	EditingTreeID,
	CuttingTreeID,
	bool:CarryingLumber,
	//Miner job
	EditingOreID,
	MiningOreID,
	CarryingLog,
	LoadingPoint,
	//production
	//CarryProduct,
	//trucker
	pTrailer,
	pMissions,
	pMission,
	pHauling,
	//Farmer
	pHarvest,
	pHarvestID,
	pOffer,
	//Bank
	pTransfer,
	pTransferRek,
	pTransferName[128],
	pTrashmasterJob,
	//Gas Station
	pFill,
	pFillTime,
	pFillPrice,
	//Gate
	gEditID,
	gEdit,
	// WBR
	pHead,
 	pPerut,
 	pLHand,
 	pRHand,
 	pLFoot,
 	pRFoot,
 	// Inspect Offer
 	pInsOffer,
 	// Obat System
 	pObat,
 	// Suspect
 	pSuspectTimer,
 	pSuspect,
 	// Phone On Off
 	pUsePhone,
 	pTogPhone,
 	// Shareloc Offer
 	pLocOffer,
 	// Twitter
 	pTwitter,
 	pRegTwitter,
 	// Kuota
 	pKuota,
 	// DUTY SYSTEM
 	pDutyHour,
 	// CHECKPOINT
 	pCP,
 	// ROBBERY
 	pRobTime,
 	pRobOffer,
 	pRobLeader,
 	pRobMember,
 	pMemberRob,
 	// Roleplay Booster
 	pBooster,
 	pBoostTime,
	// Smuggler
	bool:pTakePacket,
	pTrackPacket,
	// Garkot
	pPark,
	pLoc,
	// WS
	pMenuType,
	pInWs,
	pTransferWS,
	pCrateType,
	pEditSpeed,
	pSpeedTime,
	pInvSelect,
	pAdvertise[200],
	pAdvertiseTime,
	bool:pTempCreateChar,
	bool:pTempAge,
	bool:pTempGender,
	pTempSkin,
	//roadbloc
	pEditRoadblock,
	pEditHouseStructure,
	pEditStaticStructure,
	pEditStructure,
	pEditFurniture,
    pEditFurnHouse,
	pClaimSP,
	pStorageSelect,
	pInventoryItem,
	pStorageItem,
	pGiveItem,
	pTarget,
	pFlyLic,
	pFlyLicTime,
	pGunLic,
	pGunLicTime,
	pTruckerLic,
	pTruckerLicTime,
	pLumberLic,
	pLumberLicTime,
	pTrainingTime,
	pTaketest,
	//Skill
	pSkillFishing,
	pSkillTrucker,
	pSkillBuilder,
	pSkillFarmer,
	pSkillMecha,
	pScoreWeapon[5],
	pSkillWeapon[5],
    pScoreFishing,
    pScoreTrucker,
    pScoreFarmer,
	pScoreMecha,
	pContact,
	pPhonePrivacy,
	bool:PurchasedClothing,
	clothingSelected,
	pSideJobVeh,
	pPizzaTime,
	Float:pAdmMark[4],
    pAdmMarkInt,
    pAdmMarkVW,
	pWeaponCreateTime,
	//smuggle
	pSmugglerPick,
	pSmugglerFind,
	pSmugglerTime,
	pFurnStore
};
new pData[MAX_PLAYERS][E_PLAYERS];

new CharacterList[MAX_PLAYERS][MAX_CHARACTERS][MAX_PLAYER_NAME + 1],
	CharacterSkin[MAX_PLAYERS][MAX_CHARACTERS],
	bool:CharacterState[MAX_PLAYERS],
	CharacterSelect[MAX_PLAYERS];

new g_MysqlRaceCheck[MAX_PLAYERS];

new ListedVehicles[MAX_PLAYERS][100],
    ListedStructure[MAX_PLAYERS][MAX_HOUSE_STRUCTURES],
    ListedInventory[MAX_PLAYERS][MAX_INVENTORY],
	ListedFurniture[MAX_PLAYERS][MAX_FURNITURE],
	ListedHouse[MAX_PLAYERS][100];

new Mobile[MAX_PLAYERS];
new gListedItems[MAX_PLAYERS][100];

//----------[ Lumber Object Vehicle Job ]------------
#define MAX_LUMBERS 50
#define LUMBER_LIFETIME 100
#define LUMBER_LIMIT 10

enum    E_LUMBER
{
	// temp
	lumberDroppedBy[MAX_PLAYER_NAME],
	lumberSeconds,
	lumberObjID,
	lumberTimer,
	Text3D: lumberLabel
}
new LumberData[MAX_LUMBERS][E_LUMBER],
	Iterator:Lumbers<MAX_LUMBERS>;

new
	LumberObjects[MAX_VEHICLES][LUMBER_LIMIT];


new const MaxGunAmmo[54] = {
	0,-1,-1,-1,-1,-1,-1,-1,-1,-1,
	-1,-1,-1,-1,-1,-1,10,10,10,0,
	0,0,850,350,350,250,200,350,2000,2000,
	2000,750,2000,100,50,5,5,10,9999,10,
	-1,500,500,10,-1,-1,-1,0,0,0,
	0,0,0,0
};
	
new
	Float: LumberAttachOffsets[LUMBER_LIMIT][4] = {
	    {-0.223, -1.089, -0.230, -90.399},
		{-0.056, -1.091, -0.230, 90.399},
		{0.116, -1.092, -0.230, -90.399},
		{0.293, -1.088, -0.230, 90.399},
		{-0.123, -1.089, -0.099, -90.399},
		{0.043, -1.090, -0.099, 90.399},
		{0.216, -1.092, -0.099, -90.399},
		{-0.033, -1.090, 0.029, -90.399},
		{0.153, -1.089, 0.029, 90.399},
		{0.066, -1.091, 0.150, -90.399}
	};

//---------[ Ores miner Job Log ]-------	
#define LOG_LIFETIME 100
#define LOG_LIMIT 10
#define MAX_LOG 100

enum    E_LOG
{
	// temp
	bool:logExist,
	logType,
	logDroppedBy[MAX_PLAYER_NAME],
	logSeconds,
	logObjID,
	logTimer,
	Text3D:logLabel
}
new LogData[MAX_LOG][E_LOG];

new
	LogStorage[MAX_VEHICLES][2];

enum ZoneInfoEnum {
    Float:zonePosx1,
    Float:zonePosx2,
    Float:zonePosy1,
    Float:zonePosy2,
    Float:zonePosz1,
    Float:zonePosz2,
    ZoneName[27]
}

new ZoneInfo[375][ZoneInfoEnum] = {
    {-2353.17, -2153.17, 2275.79, 2475.79, 0.0, 200.0, "Bayside Marina"},
    {-2741.07, -2353.17, 2175.15, 2722.79, 0.0, 200.0, "Bayside"},
    {-2741.07, -2533.04, 1268.41, 1490.47, -4.57764, 200.0, "Battery Point"},
    {-2741.07, -2533.04, 793.411, 1268.41, -6.10352, 200.0, "Paradiso"},
    {-2741.07, -2533.04, 458.411, 793.411, -7.62939, 200.0, "Santa Flora"},
    {-2994.49, -2741.07, 458.411, 1339.61, -6.10352, 200.0, "Palisades"},
    {-2867.85, -2593.44, 277.411, 458.411, -9.15527, 200.0, "City Hall"},
    {-2994.49, -2867.85, 277.411, 458.411, -9.15527, 200.0, "Ocean Flats"},
    {-2994.49, -2593.44, -222.589, 277.411, -0.000106812, 200.0, "Ocean Flats"},
    {-2994.49, -2831.89, -430.276, -222.589, -0.00012207, 200.0, "Ocean Flats"},
    {-2270.04, -2178.69, -430.276, -324.114, -0.00012207, 200.0, "Foster Valley"},
    {-2178.69, -1794.92, -599.884, -324.114, -0.00012207, 200.0, "Foster Valley"},
    {-2593.44, -2411.22, -222.589, 54.722, -0.000106812, 200.0, "Hashbury"},
    {-2533.04, -2274.17, 968.369, 1358.9, -6.10352, 200.0, "Juniper Hollow"},
    {-2533.04, -1996.66, 1358.9, 1501.21, -4.57764, 200.0, "Esplanade North"},
    {-1996.66, -1524.24, 1358.9, 1592.51, -4.57764, 200.0, "Esplanade North"},
    {-1982.32, -1524.24, 1274.26, 1358.9, -4.57764, 200.0, "Esplanade North"},
    {-1871.72, -1701.3, 744.17, 1176.42, -6.10352, 300.0, "Financial"},
    {-2274.17, -1982.32, 744.17, 1358.9, -6.10352, 200.0, "Calton Heights"},
    {-1982.32, -1871.72, 744.17, 1274.26, -6.10352, 200.0, "Downtown"},
    {-1871.72, -1620.3, 1176.42, 1274.26, -4.57764, 200.0, "Downtown"},
    {-1700.01, -1580.01, 744.267, 1176.52, -6.10352, 200.0, "Downtown"},
    {-1580.01, -1499.89, 744.267, 1025.98, -6.10352, 200.0, "Downtown"},
    {-2533.04, -2274.17, 578.396, 968.369, -7.62939, 200.0, "Juniper Hill"},
    {-2274.17, -2078.67, 578.396, 744.17, -7.62939, 200.0, "Chinatown"},
    {-2078.67, -1499.89, 578.396, 744.267, -7.62939, 200.0, "Downtown"},
    {-2329.31, -1993.28, 458.411, 578.396, -7.62939, 200.0, "King's"},
    {-2411.22, -1993.28, 265.243, 373.539, -9.15527, 200.0, "King's"},
    {-2253.54, -1993.28, 373.539, 458.411, -9.15527, 200.0, "King's"},
    {-2411.22, -2173.04, -222.589, 265.243, -0.000114441, 200.0, "Garcia"},
    {-2270.04, -1794.92, -324.114, -222.589, -0.00012207, 200.0, "Doherty"},
    {-2173.04, -1794.92, -222.589, 265.243, -0.000106812, 200.0, "Doherty"},
    {-1993.28, -1794.92, 265.243, 578.396, -9.15527, 200.0, "Downtown"},
    {-1499.89, -1242.98, -50.0963, 249.904, -0.000106812, 200.0, "Easter Bay Airport"},
    {-1794.92, -1242.98, 249.904, 578.396, -9.15527, 200.0, "Easter Basin"},
    {-1794.92, -1499.89, -50.0963, 249.904, -0.000106812, 200.0, "Easter Basin"},
    {-1620.3, -1580.01, 1176.52, 1274.26, -4.57764, 200.0, "Esplanade East"},
    {-1580.01, -1499.89, 1025.98, 1274.26, -6.10352, 200.0, "Esplanade East"},
    {-1499.89, -1339.89, 578.396, 1274.26, -79.6152, 20.3848, "Esplanade East"},
    {-2324.94, -1964.22, -2584.29, -2212.11, -6.10352, 200.0, "Angel Pine"},
    {-1632.83, -1601.33, -2263.44, -2231.79, -3.05176, 200.0, "Shady Cabin"},
    {-1166.97, -321.744, -2641.19, -1856.03, 0.0, 200.0, "Back o Beyond"},
    {-1166.97, -815.624, -1856.03, -1602.07, 0.0, 200.0, "Leafy Hollow"},
    {-594.191, -187.7, -1648.55, -1276.6, 0.0, 200.0, "Flint Range"},
    {-792.254, -452.404, -698.555, -380.043, -5.34058, 200.0, "Fallen Tree"},
    {-1209.67, -908.161, -1317.1, -787.391, 114.981, 251.981, "The Farm"},
    {-1645.23, -1372.14, 2498.52, 2777.85, 0.0, 200.0, "El Quebrados"},
    {-1372.14, -1277.59, 2498.52, 2615.35, 0.0, 200.0, "Aldea Mavada"},
    {-968.772, -481.126, 1929.41, 2155.26, -3.05176, 200.0, "The Sherman Dam"},
    {-926.13, -719.234, 1398.73, 1634.69, -3.05176, 200.0, "Las Barrancas"},
    {-376.233, 123.717, 826.326, 1220.44, -3.05176, 200.0, "Fort Carson"},
    {337.244, 860.554, 710.84, 1031.71, -115.239, 203.761, "Hunter Quarry"},
    {338.658, 664.308, 1228.51, 1655.05, 0.0, 200.0, "Octane Springs"},
    {176.581, 338.658, 1305.45, 1520.72, -3.05176, 200.0, "Green Palms"},
    {-405.77, -276.719, 1712.86, 1892.75, -3.05176, 200.0, "Regular Tom"},
    {-365.167, -208.57, 2123.01, 2217.68, -3.05176, 200.0, "Las Brujas"},
    {37.0325, 435.988, 2337.18, 2677.9, -3.05176, 200.0, "Verdant Meadows"},
    {-354.332, -133.625, 2580.36, 2816.82, 2.09808, 200.0, "Las Payasadas"},
    {-901.129, -592.09, 2221.86, 2571.97, 0.0, 200.0, "Arco del Oeste"},
    {-1794.92, -1213.91, -730.118, -50.0963, -3.05176, 200.0, "Easter Bay Airport"},
    {2576.92, 2759.25, 62.1579, 385.503, 0.0, 200.0, "Hankypanky Point"},
    {2160.22, 2576.92, -149.004, 228.322, 0.0, 200.0, "Palomino Creek"},
    {2285.37, 2770.59, -768.027, -269.74, 0.0, 200.0, "North Rock"},
    {1119.51, 1451.4, 119.526, 493.323, -3.05176, 200.0, "Montgomery"},
    {1451.4, 1582.44, 347.457, 420.802, -6.10352, 200.0, "Montgomery"},
    {603.035, 761.994, 264.312, 366.572, 0.0, 200.0, "Hampton Barns"},
    {508.189, 1306.66, -139.259, 119.526, 0.0, 200.0, "Fern Ridge"},
    {580.794, 861.085, -674.885, -404.79, -9.53674, 200.0, "Dillimore"},
    {967.383, 1176.78, -450.39, -217.9, -3.05176, 200.0, "Hilltop Farm"},
    {104.534, 349.607, -220.137, 152.236, 2.38419, 200.0, "Blueberry"},
    {19.6074, 349.607, -404.136, -220.137, 3.8147, 200.0, "Blueberry"},
    {-947.98, -319.676, -304.32, 327.071, -1.14441, 200.0, "The Panopticon"},
    {2759.25, 2774.25, 296.501, 594.757, 0.0, 200.0, "FRedsands Eastrick Bridge"},
    {1664.62, 1785.14, 401.75, 567.203, 0.0, 200.0, "The Mako Span"},
    {-319.676, 104.534, -220.137, 293.324, 0.0, 200.0, "Blueberry Acres"},
    {-222.179, -122.126, 293.324, 476.465, 0.0, 200.0, "Martin Bridge"},
    {434.341, 603.035, 366.572, 555.68, 0.0, 200.0, "Fallow Bridge"},
    {-1820.64, -1226.78, -2643.68, -1771.66, -8.01086, 200.0, "Shady Creeks"},
    {-2030.12, -1820.64, -2174.89, -1771.66, -6.10352, 200.0, "Shady Creeks"},
    {-2533.04, -2329.31, 458.411, 578.396, 0.0, 200.0, "Queens"},
    {-2593.44, -2411.22, 54.722, 458.411, 0.0, 200.0, "Queens"},
    {-2411.22, -2253.54, 373.539, 458.411, 0.0, 200.0, "Queens"},
    {-480.539, 869.461, 596.349, 2993.87, -242.99, 900.0, "Bone County"},
    {-2997.47, -480.539, 1659.68, 2993.87, -242.99, 900.0, "Tierra Robada"},
    {-2741.45, -2616.4, 1659.68, 2175.15, -6.10352, 200.0, "Gant Bridge"},
    {-2741.07, -2616.4, 1490.47, 1659.68, -6.10352, 200.0, "Gant Bridge"},
    {-1213.91, -480.539, 596.349, 1659.68, -242.99, 900.0, "Tierra Robada"},
    {-1213.91, 2997.06, -768.027, 596.349, -242.99, 900.0, "Red County"},
    {-1213.91, 44.6147, -2892.97, -768.027, -242.99, 900.0, "Flint County"},
    {-1132.82, -956.476, -768.027, -578.118, 0.0, 200.0, "Easter Bay Chemicals"},
    {-1132.82, -956.476, -787.391, -768.027, 0.0, 200.0, "Easter Bay Chemicals"},
    {-1213.91, -1132.82, -730.118, -50.0963, 0.0, 200.0, "Easter Bay Airport"},
    {-2178.69, -1794.92, -1115.58, -599.884, 0.0, 200.0, "Foster Valley"},
    {-2178.69, -1794.92, -1250.97, -1115.58, 0.0, 200.0, "Foster Valley"},
    {-1242.98, -1213.91, -50.0963, 578.396, 0.0, 200.0, "Easter Bay Airport"},
    {-1213.91, -947.98, -50.096, 578.396, -4.57764, 200.0, "Easter Bay Airport"},
    {-2997.47, -1213.91, -2892.97, -1115.58, -242.99, 900.0, "Whetstone"},
    {1249.62, 1852.0, -2394.33, -2179.25, -89.0839, 110.916, "Los Santos International"},
    {1852.0, 2089.0, -2394.33, -2179.25, -89.0839, 110.916, "Los Santos International"},
    {930.221, 1249.62, -2488.42, -2006.78, -89.0839, 110.916, "Verdant Bluffs"},
    {1812.62, 1970.62, -2179.25, -1852.87, -89.0839, 110.916, "El Corona"},
    {1970.62, 2089.0, -2179.25, -1852.87, -89.0839, 110.916, "Willowfield"},
    {2089.0, 2201.82, -2235.84, -1989.9, -89.0839, 110.916, "Willowfield"},
    {2089.0, 2324.0, -1989.9, -1852.87, -89.0839, 110.916, "Willowfield"},
    {2201.82, 2324.0, -2095.0, -1989.9, -89.0839, 110.916, "Willowfield"},
    {2373.77, 2809.22, -2697.09, -2330.46, -89.0837, 110.916, "Ocean Docks"},
    {2201.82, 2324.0, -2418.33, -2095.0, -89.0837, 110.916, "Ocean Docks"},
    {647.712, 851.449, -1804.21, -1577.59, -89.0839, 110.916, "Marina"},
    {647.712, 930.221, -2173.29, -1804.21, -89.0839, 110.916, "Verona Beach"},
    {930.221, 1073.22, -2006.78, -1804.21, -89.0839, 110.916, "Verona Beach"},
    {1073.22, 1249.62, -2006.78, -1842.27, -89.0839, 110.916, "Verdant Bluffs"},
    {1249.62, 1692.62, -2179.25, -1842.27, -89.0839, 110.916, "Verdant Bluffs"},
    {1692.62, 1812.62, -2179.25, -1842.27, -89.0839, 110.916, "El Corona"},
    {851.449, 1046.15, -1804.21, -1577.59, -89.0839, 110.916, "Verona Beach"},
    {647.712, 807.922, -1577.59, -1416.25, -89.0838, 110.916, "Marina"},
    {807.922, 926.922, -1577.59, -1416.25, -89.0839, 110.916, "Marina"},
    {1161.52, 1323.9, -1722.26, -1577.59, -89.0839, 110.916, "Verona Beach"},
    {1046.15, 1161.52, -1722.26, -1577.59, -89.0839, 110.916, "Verona Beach"},
    {1046.15, 1323.9, -1804.21, -1722.26, -89.0839, 110.916, "Conference Center"},
    {1073.22, 1323.9, -1842.27, -1804.21, -89.0839, 110.916, "Conference Center"},
    {1323.9, 1701.9, -1842.27, -1722.26, -89.0839, 110.916, "Commerce"},
    {1323.9, 1440.9, -1722.26, -1577.59, -89.0839, 110.916, "Commerce"},
    {1370.85, 1463.9, -1577.59, -1384.95, -89.084, 110.916, "Commerce"},
    {1463.9, 1667.96, -1577.59, -1430.87, -89.0839, 110.916, "Commerce"},
    {1440.9, 1583.5, -1722.26, -1577.59, -89.0839, 110.916, "Pershing Square"},
    {1583.5, 1758.9, -1722.26, -1577.59, -89.0839, 110.916, "Commerce"},
    {1701.9, 1812.62, -1842.27, -1722.26, -89.0839, 110.916, "Little Mexico"},
    {1758.9, 1812.62, -1722.26, -1577.59, -89.0839, 110.916, "Little Mexico"},
    {1667.96, 1812.62, -1577.59, -1430.87, -89.0839, 110.916, "Commerce"},
    {1812.62, 1971.66, -1852.87, -1742.31, -89.0839, 110.916, "Idlewood"},
    {1812.62, 1951.66, -1742.31, -1602.31, -89.0839, 110.916, "Idlewood"},
    {1951.66, 2124.66, -1742.31, -1602.31, -89.0839, 110.916, "Idlewood"},
    {1812.62, 2124.66, -1602.31, -1449.67, -89.0839, 110.916, "Idlewood"},
    {2124.66, 2222.56, -1742.31, -1494.03, -89.0839, 110.916, "Idlewood"},
    {1812.62, 1996.91, -1449.67, -1350.72, -89.0839, 110.916, "Glen Park"},
    {1812.62, 1994.33, -1100.82, -973.38, -89.0839, 110.916, "Glen Park"},
    {1996.91, 2056.86, -1449.67, -1350.72, -89.0839, 110.916, "Jefferson"},
    {2124.66, 2266.21, -1494.03, -1449.67, -89.0839, 110.916, "Jefferson"},
    {2056.86, 2281.45, -1372.04, -1210.74, -89.0839, 110.916, "Jefferson"},
    {2056.86, 2185.33, -1210.74, -1126.32, -89.0839, 110.916, "Jefferson"},
    {2185.33, 2281.45, -1210.74, -1154.59, -89.0839, 110.916, "Jefferson"},
    {1994.33, 2056.86, -1100.82, -920.815, -89.0839, 110.916, "Las Colinas"},
    {2056.86, 2126.86, -1126.32, -920.815, -89.0839, 110.916, "Las Colinas"},
    {2185.33, 2281.45, -1154.59, -934.489, -89.0839, 110.916, "Las Colinas"},
    {2126.86, 2185.33, -1126.32, -934.489, -89.0839, 110.916, "Las Colinas"},
    {1971.66, 2222.56, -1852.87, -1742.31, -89.0839, 110.916, "Idlewood"},
    {2222.56, 2632.83, -1852.87, -1722.33, -89.0839, 110.916, "Ganton"},
    {2222.56, 2632.83, -1722.33, -1628.53, -89.0839, 110.916, "Ganton"},
    {2541.7, 2703.58, -1941.4, -1852.87, -89.0839, 110.916, "Willowfield"},
    {2632.83, 2959.35, -1852.87, -1668.13, -89.0839, 110.916, "East Beach"},
    {2632.83, 2747.74, -1668.13, -1393.42, -89.0839, 110.916, "East Beach"},
    {2747.74, 2959.35, -1668.13, -1498.62, -89.0839, 110.916, "East Beach"},
    {2421.03, 2632.83, -1628.53, -1454.35, -89.0839, 110.916, "East Los Santos"},
    {2222.56, 2421.03, -1628.53, -1494.03, -89.0839, 110.916, "East Los Santos"},
    {2056.86, 2266.21, -1449.67, -1372.04, -89.0839, 110.916, "Jefferson"},
    {2266.26, 2381.68, -1494.03, -1372.04, -89.0839, 110.916, "East Los Santos"},
    {2381.68, 2421.03, -1494.03, -1454.35, -89.0839, 110.916, "East Los Santos"},
    {2281.45, 2381.68, -1372.04, -1135.04, -89.084, 110.916, "East Los Santos"},
    {2381.68, 2462.13, -1454.35, -1135.04, -89.0839, 110.916, "East Los Santos"},
    {2462.13, 2581.73, -1454.35, -1135.04, -89.0839, 110.916, "East Los Santos"},
    {2581.73, 2632.83, -1454.35, -1393.42, -89.0839, 110.916, "Los Flores"},
    {2581.73, 2747.74, -1393.42, -1135.04, -89.0839, 110.916, "Los Flores"},
    {2747.74, 2959.35, -1498.62, -1120.04, -89.0839, 110.916, "East Beach"},
    {2747.74, 2959.35, -1120.04, -945.035, -89.0839, 110.916, "Las Colinas"},
    {2632.74, 2747.74, -1135.04, -945.035, -89.0839, 110.916, "Las Colinas"},
    {2281.45, 2632.74, -1135.04, -945.035, -89.0839, 110.916, "Las Colinas"},
    {1463.9, 1724.76, -1430.87, -1290.87, -89.084, 110.916, "Downtown Los Santos"},
    {1724.76, 1812.62, -1430.87, -1250.9, -89.0839, 110.916, "Downtown Los Santos"},
    {1463.9, 1724.76, -1290.87, -1150.87, -89.084, 110.916, "Downtown Los Santos"},
    {1370.85, 1463.9, -1384.95, -1170.87, -89.0839, 110.916, "Downtown Los Santos"},
    {1724.76, 1812.62, -1250.9, -1150.87, -89.0839, 110.916, "Downtown Los Santos"},
    {1463.9, 1812.62, -1150.87, -768.027, -89.0839, 110.916, "MULINT"},
    {1414.07, 1667.61, -768.027, -452.425, -89.0839, 110.916, "Mulholland"},
    {1281.13, 1641.13, -452.425, -290.913, -89.0839, 110.916, "Mulholland"},
    {1269.13, 1414.07, -768.027, -452.425, -89.0839, 110.916, "Mulholland"},
    {787.461, 1072.66, -1416.25, -1310.21, -89.0838, 110.916, "Market"},
    {787.461, 952.663, -1310.21, -1130.84, -89.0838, 110.916, "Vinewood"},
    {952.663, 1072.66, -1310.21, -1130.85, -89.0839, 110.916, "Market"},
    {1370.85, 1463.9, -1170.87, -1130.85, -89.0839, 110.916, "Downtown Los Santos"},
    {1378.33, 1463.9, -1130.85, -1026.33, -89.0838, 110.916, "Downtown Los Santos"},
    {1391.05, 1463.9, -1026.33, -926.999, -89.0839, 110.916, "Downtown Los Santos"},
    {1252.33, 1378.33, -1130.85, -1026.33, -89.0839, 110.916, "Temple"},
    {1252.33, 1391.05, -1026.33, -926.999, -89.0839, 110.916, "Temple"},
    {1252.33, 1357.0, -926.999, -910.17, -89.0839, 110.916, "Temple"},
    {1357.0, 1463.9, -926.999, -768.027, -89.0838, 110.916, "Mulholland"},
    {1318.13, 1357.0, -910.17, -768.027, -89.0839, 110.916, "Mulholland"},
    {1169.13, 1318.13, -910.17, -768.027, -89.0838, 110.916, "Mulholland"},
    {787.461, 952.604, -1130.84, -954.662, -89.0839, 110.916, "Vinewood"},
    {952.663, 1096.47, -1130.84, -937.184, -89.084, 110.916, "Temple"},
    {1096.47, 1252.33, -1130.84, -1026.33, -89.0838, 110.916, "Temple"},
    {1096.47, 1252.33, -1026.33, -910.17, -89.0839, 110.916, "Temple"},
    {768.694, 952.604, -954.662, -860.619, -89.0838, 110.916, "Mulholland"},
    {687.802, 911.802, -860.619, -768.027, -89.0839, 110.916, "Mulholland"},
    {737.573, 1142.29, -768.027, -674.885, -89.0838, 110.916, "Mulholland"},
    {1096.47, 1169.13, -910.17, -768.027, -89.0838, 110.916, "Mulholland"},
    {952.604, 1096.47, -937.184, -860.619, -89.0839, 110.916, "Mulholland"},
    {911.802, 1096.47, -860.619, -768.027, -89.0838, 110.916, "Mulholland"},
    {861.085, 1156.55, -674.885, -600.896, -89.0839, 110.916, "Mulholland"},
    {342.648, 647.712, -2173.29, -1684.65, -89.0838, 110.916, "Santa Maria Beach"},
    {72.6481, 342.648, -2173.29, -1684.65, -89.0839, 110.916, "Santa Maria Beach"},
    {72.6481, 225.165, -1684.65, -1544.17, -89.084, 110.916, "Rodeo"},
    {72.6481, 225.165, -1544.17, -1404.97, -89.0839, 110.916, "Rodeo"},
    {225.165, 312.803, -1684.65, -1501.95, -89.0839, 110.916, "Rodeo"},
    {225.165, 334.503, -1501.95, -1369.62, -89.0839, 110.916, "Rodeo"},
    {334.503, 422.68, -1501.95, -1406.05, -89.0839, 110.916, "Rodeo"},
    {312.803, 422.68, -1684.65, -1501.95, -89.0839, 110.916, "Rodeo"},
    {422.68, 558.099, -1684.65, -1570.2, -89.0839, 110.916, "Rodeo"},
    {558.099, 647.522, -1684.65, -1384.93, -89.0839, 110.916, "Rodeo"},
    {466.223, 558.099, -1570.2, -1385.07, -89.0839, 110.916, "Rodeo"},
    {422.68, 466.223, -1570.2, -1406.05, -89.0839, 110.916, "Rodeo"},
    {647.557, 787.461, -1227.28, -1118.28, -89.0839, 110.916, "Vinewood"},
    {647.557, 787.461, -1118.28, -954.662, -89.0839, 110.916, "Richman"},
    {647.557, 768.694, -954.662, -860.619, -89.0839, 110.916, "Richman"},
    {466.223, 647.522, -1385.07, -1235.07, -89.0839, 110.916, "Rodeo"},
    {334.503, 466.223, -1406.05, -1292.07, -89.0839, 110.916, "Rodeo"},
    {225.165, 334.503, -1369.62, -1292.07, -89.0839, 110.916, "Richman"},
    {225.165, 466.223, -1292.07, -1235.07, -89.084, 110.916, "Richman"},
    {72.6481, 225.165, -1404.97, -1235.07, -89.0839, 110.916, "Richman"},
    {72.6481, 321.356, -1235.07, -1008.15, -89.0839, 110.916, "Richman"},
    {321.356, 647.522, -1235.07, -1044.07, -89.0839, 110.916, "Richman"},
    {321.356, 647.557, -1044.07, -860.619, -89.0839, 110.916, "Richman"},
    {321.356, 687.802, -860.619, -768.027, -89.0839, 110.916, "Richman"},
    {321.356, 700.794, -768.027, -674.885, -89.0839, 110.916, "Richman"},
    {2027.4, 2087.39, 863.229, 1703.23, -89.0839, 110.916, "The Strip"},
    {2106.7, 2162.39, 1863.23, 2202.76, -89.0839, 110.916, "The Strip"},
    {1817.39, 2027.39, 863.232, 1083.23, -89.084, 110.916, "The Four Dragons Casino"},
    {1817.39, 2027.39, 1083.23, 1283.23, -89.0839, 110.916, "The Pink Swan"},
    {1817.39, 2027.39, 1283.23, 1469.23, -89.0839, 110.916, "The High Roller"},
    {1817.39, 2027.4, 1469.23, 1703.23, -89.084, 110.916, "Pirates in Men's Pants"},
    {1817.39, 2106.7, 1863.23, 2011.83, -89.0839, 110.916, "The Visage"},
    {1817.39, 2027.4, 1703.23, 1863.23, -89.0839, 110.916, "The Visage"},
    {1457.39, 2377.39, 823.228, 863.229, -89.0839, 110.916, "Julius Thruway South"},
    {1197.39, 1236.63, 1163.39, 2243.23, -89.0839, 110.916, "Julius Thruway West"},
    {2377.39, 2537.39, 788.894, 897.901, -89.0839, 110.916, "Julius Thruway South"},
    {2537.39, 2902.35, 676.549, 943.235, -89.0839, 110.916, "Rockshore East"},
    {2087.39, 2623.18, 943.235, 1203.23, -89.0839, 110.916, "Come-A-Lot"},
    {2087.39, 2640.4, 1203.23, 1383.23, -89.0839, 110.916, "The Camel's Toe"},
    {2087.39, 2437.39, 1383.23, 1543.23, -89.0839, 110.916, "Royal Casino"},
    {2087.39, 2437.39, 1543.23, 1703.23, -89.0839, 110.916, "Caligula's Palace"},
    {2137.4, 2437.39, 1703.23, 1783.23, -89.0839, 110.916, "Caligula's Palace"},
    {2437.39, 2624.4, 1383.23, 1783.23, -89.0839, 110.916, "Pilgrim"},
    {2437.39, 2685.16, 1783.23, 2012.18, -89.0839, 110.916, "StarFisher's Lagoon Casino"},
    {2027.4, 2162.39, 1783.23, 1863.23, -89.084, 110.916, "The Strip"},
    {2027.4, 2137.4, 1703.23, 1783.23, -89.0839, 110.916, "The Strip"},
    {2011.94, 2237.4, 2202.76, 2508.23, -89.0839, 110.916, "The Emerald Isle"},
    {2162.39, 2685.16, 2012.18, 2202.76, -89.0839, 110.916, "Old Venturas Strip"},
    {2498.21, 2749.9, 2626.55, 2861.55, -89.0839, 110.916, "K.A.C.C. Military Fuels"},
    {2749.9, 2921.62, 1937.25, 2669.79, -89.0839, 110.916, "Creek"},
    {2749.9, 2923.39, 1548.99, 1937.25, -89.0839, 110.916, "Sobell Rail Yards"},
    {2749.9, 2923.39, 1198.99, 1548.99, -89.0839, 110.916, "Linden Station"},
    {2623.18, 2749.9, 943.235, 1055.96, -89.0839, 110.916, "Julius Thruway East"},
    {2749.9, 2923.39, 943.235, 1198.99, -89.0839, 110.916, "Linden Side"},
    {2685.16, 2749.9, 1055.96, 2626.55, -89.0839, 110.916, "Julius Thruway East"},
    {2498.21, 2685.16, 2542.55, 2626.55, -89.0839, 110.916, "Julius Thruway North"},
    {2536.43, 2685.16, 2442.55, 2542.55, -89.0839, 110.916, "Julius Thruway East"},
    {2625.16, 2685.16, 2202.76, 2442.55, -89.0839, 110.916, "Julius Thruway East"},
    {2237.4, 2498.21, 2542.55, 2663.17, -89.0839, 110.916, "Julius Thruway North"},
    {2121.4, 2237.4, 2508.23, 2663.17, -89.0839, 110.916, "Julius Thruway North"},
    {1938.8, 2121.4, 2508.23, 2624.23, -89.0839, 110.916, "Julius Thruway North"},
    {1534.56, 1848.4, 2433.23, 2583.23, -89.0839, 110.916, "Julius Thruway North"},
    {1236.63, 1297.47, 2142.86, 2243.23, -89.084, 110.916, "Julius Thruway West"},
    {1848.4, 1938.8, 2478.49, 2553.49, -89.0839, 110.916, "Julius Thruway North"},
    {1777.39, 1817.39, 863.232, 2342.83, -89.0839, 110.916, "Harry Gold Parkway"},
    {1817.39, 2106.7, 2011.83, 2202.76, -89.0839, 110.916, "Redsands East"},
    {1817.39, 2011.94, 2202.76, 2342.83, -89.0839, 110.916, "Redsands East"},
    {1848.4, 2011.94, 2342.83, 2478.49, -89.084, 110.916, "Redsands East"},
    {1704.59, 1848.4, 2342.83, 2433.23, -89.0839, 110.916, "Julius Thruway North"},
    {1236.63, 1777.39, 1883.11, 2142.86, -89.0839, 110.916, "Redsands West"},
    {1297.47, 1777.39, 2142.86, 2243.23, -89.084, 110.916, "Redsands West"},
    {1377.39, 1704.59, 2243.23, 2433.23, -89.0839, 110.916, "Redsands West"},
    {1704.59, 1777.39, 2243.23, 2342.83, -89.0839, 110.916, "Redsands West"},
    {1236.63, 1457.37, 1203.28, 1883.11, -89.0839, 110.916, "Las Venturas Airport"},
    {1457.37, 1777.39, 1203.28, 1883.11, -89.0839, 110.916, "Las Venturas Airport"},
    {1457.37, 1777.4, 1143.21, 1203.28, -89.0839, 110.916, "Las Venturas Airport"},
    {1457.39, 1777.4, 863.229, 1143.21, -89.0839, 110.916, "LVA Freight Depot"},
    {1197.39, 1277.05, 1044.69, 1163.39, -89.0839, 110.916, "Blackfield Intersection"},
    {1166.53, 1375.6, 795.01, 1044.69, -89.0839, 110.916, "Blackfield Intersection"},
    {1277.05, 1315.35, 1044.69, 1087.63, -89.0839, 110.916, "Blackfield Intersection"},
    {1375.6, 1457.39, 823.228, 919.447, -89.084, 110.916, "Blackfield Intersection"},
    {1375.6, 1457.37, 919.447, 1203.28, -89.0839, 110.916, "LVA Freight Depot"},
    {1277.05, 1375.6, 1087.63, 1203.28, -89.0839, 110.916, "LVA Freight Depot"},
    {1315.35, 1375.6, 1044.69, 1087.63, -89.0839, 110.916, "LVA Freight Depot"},
    {1236.63, 1277.05, 1163.41, 1203.28, -89.0839, 110.916, "LVA Freight Depot"},
    {964.391, 1197.39, 1044.69, 1203.22, -89.0839, 110.916, "Greenglass College"},
    {964.391, 1166.53, 930.89, 1044.69, -89.0839, 110.916, "Greenglass College"},
    {964.391, 1197.39, 1203.22, 1403.22, -89.084, 110.916, "Blackfield"},
    {964.391, 1197.39, 1403.22, 1726.22, -89.084, 110.916, "Blackfield"},
    {2237.4, 2536.43, 2202.76, 2542.55, -89.0839, 110.916, "Roca Escalante"},
    {2536.43, 2625.16, 2202.76, 2442.55, -89.0839, 110.916, "Roca Escalante"},
    {1823.08, 1997.22, 596.349, 823.228, -89.0839, 110.916, "Last Dime Motel"},
    {1997.22, 2377.39, 596.349, 823.228, -89.0839, 110.916, "Rockshore West"},
    {2377.39, 2537.39, 596.349, 788.894, -89.084, 110.916, "Rockshore West"},
    {1558.09, 1823.08, 596.349, 823.235, -89.084, 110.916, "Randolph Industrial Estate"},
    {1375.6, 1558.09, 596.349, 823.228, -89.084, 110.916, "Blackfield Chapel"},
    {1325.6, 1375.6, 596.349, 795.01, -89.084, 110.916, "Blackfield Chapel"},
    {1377.39, 1534.56, 2433.23, 2507.23, -89.0839, 110.916, "Julius Thruway North"},
    {1098.39, 1377.39, 2243.23, 2507.23, -89.0839, 110.916, "Pilson Intersection"},
    {883.308, 1098.31, 1726.22, 2507.23, -89.0839, 110.916, "Whitewood Estates"},
    {1534.56, 1848.4, 2583.23, 2863.23, -89.0839, 110.916, "Prickle Pine"},
    {1117.4, 1534.56, 2507.23, 2723.23, -89.0839, 110.916, "Prickle Pine"},
    {1848.4, 1938.8, 2553.49, 2863.23, -89.0839, 110.916, "Prickle Pine"},
    {2121.4, 2498.21, 2663.17, 2861.55, -89.0839, 110.916, "Spinybed"},
    {1938.8, 2121.4, 2624.23, 2861.55, -89.0839, 110.916, "Prickle Pine"},
    {2624.4, 2685.16, 1383.23, 1783.23, -89.084, 110.916, "Pilgrim"},
    {2450.39, 2759.25, 385.503, 562.349, -100.0, 200.0, "San Andreas Sound"},
    {1916.99, 2131.72, -233.323, 13.8002, -100.0, 200.0, "Fisher's Lagoon"},
    {-1339.89, -1213.91, 828.129, 1057.04, -89.0839, 110.916, "Garver Bridge"},
    {-1213.91, -1087.93, 950.022, 1178.93, -89.0839, 110.916, "Garver Bridge"},
    {-1499.89, -1339.89, 696.442, 925.353, -179.615, 20.3848, "Garver Bridge"},
    {-1339.89, -1213.91, 599.218, 828.129, -89.0839, 110.916, "Kincaid Bridge"},
    {-1213.91, -1087.93, 721.111, 950.022, -89.0839, 110.916, "Kincaid Bridge"},
    {-1087.93, -961.95, 855.37, 986.281, -89.0839, 110.916, "Kincaid Bridge"},
    {-321.744, 44.6147, -2224.43, -1724.43, -89.0839, 110.916, "Los Santos Inlet"},
    {-789.737, -599.505, 1659.68, 1929.41, -89.084, 110.916, "Sherman Reservoir"},
    {-314.426, -106.339, -753.874, -463.073, -89.0839, 110.916, "Flint Water"},
    {-1709.71, -1446.01, -833.034, -730.118, -1.52588, 200.0, "Easter Tunnel"},
    {-2290.19, -1950.19, 2548.29, 2723.29, -89.084, 110.916, "Bayside Tunnel"},
    {-410.02, -137.969, 1403.34, 1681.23, -3.05176, 200.0, "'The Big Ear'"},
    {-90.2183, 153.859, 1286.85, 1554.12, -3.05176, 200.0, "Lil' Probe Inn"},
    {-936.668, -715.961, 2611.44, 2847.9, 2.09808, 200.0, "Valle Ocultado"},
    {1812.62, 2056.86, -1350.72, -1100.82, -89.0839, 110.916, "Glen Park"},
    {2324.0, 2703.58, -2302.33, -2145.1, -89.0839, 110.916, "Ocean Docks"},
    {2811.25, 2861.25, 1229.59, 1407.59, -39.594, 60.406, "Linden Station"},
    {1692.62, 1812.62, -1971.8, -1932.8, -20.4921, 79.5079, "Unity Station"},
    {647.712, 787.461, -1416.25, -1227.28, -89.0839, 110.916, "Vinewood"},
    {787.461, 866.009, -1410.93, -1310.21, -34.1263, 65.8737, "Market Station"},
    {-2007.83, -1922.0, 56.3063, 224.782, 0.0, 100.0, "Cranberry Station"},
    {1377.48, 1492.45, 2600.43, 2687.36, -21.9263, 78.0737, "Yellow Bell Station"},
    {-2616.4, -1996.66, 1501.21, 1659.68, -3.05176, 200.0, "San Fierro Bay"},
    {-2616.4, -1996.66, 1659.68, 2175.15, -3.05176, 200.0, "San Fierro Bay"},
    {-464.515, -208.57, 2217.68, 2580.36, 0.0, 200.0, "El Castillo del Diablo"},
    {-208.57, 114.033, 2123.01, 2337.18, -7.62939, 200.0, "El Castillo del Diablo"},
    {-208.57, 8.42999, 2337.18, 2487.18, 0.0, 200.0, "El Castillo del Diablo"},
    {-91.586, 421.234, 1655.05, 2123.01, -50.0, 250.0, "Restricted Area"},
    {1546.65, 1745.83, 208.164, 347.457, 0.0, 200.0, "Montgomery Intersection"},
    {1582.44, 1664.62, 347.457, 401.75, 0.0, 200.0, "Montgomery Intersection"},
    {-1119.01, -862.025, 1178.93, 1351.45, -89.084, 110.916, "Robada Intersection"},
    {-187.7, 17.0632, -1596.76, -1276.6, -89.0839, 110.916, "Flint Intersection"},
    {-1315.42, -1264.4, -405.388, -209.543, 15.4061, 25.4061, "Easter Bay Airport"},
    {-1354.39, -1315.42, -287.398, -209.543, 15.4061, 25.4061, "Easter Bay Airport"},
    {-1490.33, -1264.4, -209.543, -148.388, 15.4061, 25.4061, "Easter Bay Airport"},
    {1072.66, 1370.85, -1416.25, -1130.85, -89.084, 110.916, "Market"},
    {926.922, 1370.85, -1577.59, -1416.25, -89.0839, 110.916, "Market"},
    {-2646.4, -2270.04, -355.493, -222.589, 0.0, 200.0, "Avispa Country Club"},
    {-2831.89, -2646.4, -430.276, -222.589, -6.10352, 200.0, "Avispa Country Club"},
    {-2994.49, -2178.69, -811.276, -430.276, 0.0, 200.0, "Missionary Hill"},
    {-2178.69, -1936.12, -1771.66, -1250.97, -47.9166, 576.083, "Mount Chilliad"},
    {-2997.47, -2178.69, -1115.58, -971.913, -47.9166, 576.083, "Mount Chilliad"},
    {-2994.49, -2178.69, -2189.91, -1115.58, -47.9166, 576.083, "Mount Chilliad"},
    {-2178.69, -2030.12, -2189.91, -1771.66, -47.9166, 576.083, "Mount Chilliad"},
    {1117.4, 1457.46, 2723.23, 2863.23, -89.0839, 110.916, "Yellow Bell Golf Course"},
    {1457.46, 1534.56, 2723.23, 2863.23, -89.0839, 110.916, "Yellow Bell Golf Course"},
    {1515.81, 1729.95, 1586.4, 1714.56, -12.5, 87.5, "Las Venturas Airport"},
    {2089.0, 2201.82, -2394.33, -2235.84, -89.0839, 110.916, "Ocean Docks"},
    {1382.73, 2201.82, -2730.88, -2394.33, -89.0839, 110.916, "Los Santos International"},
    {2201.82, 2324.0, -2730.88, -2418.33, -89.0839, 110.916, "Ocean Docks"},
    {1974.63, 2089.0, -2394.33, -2256.59, -39.0839, 60.9161, "Los Santos International"},
    {1400.97, 2189.82, -2669.26, -2597.26, -39.0839, 60.9161, "Los Santos International"},
    {2051.63, 2152.45, -2597.26, -2394.33, -39.0839, 60.9161, "Los Santos International"},
    {2437.39, 2495.09, 1858.1, 1970.85, -39.0839, 60.9161, "StarFisher's Lagoon Casino"},
    {-399.633, -319.033, -1075.52, -977.516, -1.48904, 198.511, "Beacon Hill"},
    {-2361.51, -2270.04, -417.199, -355.493, 0.0, 200.0, "Avispa Country Club"},
    {-2667.81, -2646.4, -302.135, -262.32, -28.8305, 71.1695, "Avispa Country Club"},
    {-2395.14, -2354.09, -222.589, -204.792, -5.34058, 200.0, "Garcia"},
    {-2470.04, -2270.04, -355.493, -318.493, 0.0, 46.1, "Avispa Country Club"},
    {-2550.04, -2470.04, -355.493, -318.493, 0.0, 39.7, "Avispa Country Club"},
    {2703.58, 2959.35, -2126.9, -1852.87, -89.0839, 110.916, "Playa del Seville"},
    {2703.58, 2959.35, -2302.33, -2126.9, -89.0839, 110.916, "Ocean Docks"},
    {2162.39, 2437.39, 1883.23, 2012.18, -89.0839, 110.916, "StarFisher's Lagoon Casino"},
    {2162.39, 2437.39, 1783.23, 1883.23, -89.0839, 110.916, "The Clown's Pocket"},
    {2324.0, 2703.58, -2145.1, -2059.23, -89.084, 110.916, "Ocean Docks"},
    {2324.0, 2541.7, -2059.23, -1852.87, -89.0839, 110.916, "Willowfield"},
    {2541.7, 2703.58, -2059.23, -1941.4, -89.0839, 110.916, "Willowfield"},
    {1098.31, 1197.39, 1726.22, 2243.23, -89.0839, 110.916, "Whitewood Estates"},
    {1507.51, 1582.55, -1385.21, -1325.31, 110.916, 335.916, "Downtown Los Santos"}
};

enum e_FurnitureData {
    e_FurnitureType,
    e_FurnitureName[32],
    e_FurnitureModel
};


stock const g_aFurnitureTypes[][] = {
    {"Frames"},
    {"Tables"},
    {"Chairs"},
    {"Beds"},
    {"Cabinets"},
    {"Television Sets"},
    {"Kitchen Appliances"},
    {"Bathroom Appliances"},
    {"Decoration"},
    {"Misc Furniture"}
};

new const g_aFurnitureData[][e_FurnitureData] = {
    {1, "Frame 1", 2282},
    {1, "Frame 2", 2277},
    {1, "Frame 3", 2274},
    {1, "Frame 4", 2280},
    {1, "Frame 5", 2254},
    {1, "Frame 6", 2275},
    {1, "Frame 7", 2276},
    {1, "Frame 8", 2278},
    {1, "Frame 9", 2279},
    {1, "Frame 10", 2281},
    {1, "Frame 11", 2272},
    {1, "Frame 12", 2283},
    {1, "Frame 13", 2284},
    {1, "Frame 14", 2285},
    {1, "Frame 15", 2286},
    {1, "Frame 16", 2287},
    {1, "Frame 17", 2288},
    {1, "Frame 18", 2273},
    {1, "Frame 19", 2261},
    {1, "Frame 20", 2255},
    {1, "Frame 21", 2256},
    {1, "Frame 22", 2257},
    {1, "Frame 23", 2258},
    {1, "Frame 24", 2259},
    {1, "Frame 25", 2260},
    {1, "Frame 26", 2262},
    {1, "Frame 27", 2270},
    {1, "Frame 28", 2263},
    {1, "Frame 29", 2264},
    {1, "Frame 30", 2265},
    {1, "Frame 31", 2266},
    {1, "Frame 32", 2267},
    {1, "Frame 33", 2268},
    {1, "Frame 34", 2269},
    {1, "Frame 35", 2289},
    {1, "Frame 36", 19172},
    {1, "Frame 37", 19173},
    {1, "Frame 38", 19174},
    {2, "Table 1", 1433},
    {2, "Table 2", 1998},
    {2, "Table 3", 2008},
    {2, "Table 4", 2180},
    {2, "Table 5", 2185},
    {2, "Table 6", 2205},
    {2, "Table 7", 2314},
    {2, "Table 8", 2635},
    {2, "Table 9", 2637},
    {2, "Table 10", 2644},
    {2, "Table 11", 2747},
    {2, "Table 12", 2764},
    {2, "Table 13", 2763},
    {2, "Table 14", 2762},
    {2, "Table 15", 936},
    {2, "Table 16", 937},
    {2, "Table 17", 941},
    {2, "Table 18", 2115},
    {2, "Table 19", 2116},
    {2, "Table 20", 2112},
    {2, "Table 21", 2111},
    {2, "Table 22", 2110},
    {2, "Table 23", 2109},
    {2, "Table 24", 2085},
    {2, "Table 25", 2032},
    {2, "Table 26", 2031},
    {2, "Table 27", 2030},
    {2, "Table 28", 2029},
    {2, "Table 29", 1815},
    {2, "Table 30", 1814},
    {2, "Table 31", 2117},
    {2, "Table 32", 2319},
    {2, "Table 33", 2357},
    {2, "Table 34", 1817},
    {2, "Table 35", 2315},
    {2, "Table 36", 2321},
    {2, "Table 37", 2184},
    {2, "Table 38", 2311},
    {2, "Table 39", 2313},
    {3, "Chair 1", 1671},
    {3, "Chair 2", 1704},
    {3, "Chair 3", 1705},
    {3, "Chair 4", 1708},
    {3, "Chair 5", 1711},
    {3, "Chair 6", 1715},
    {3, "Chair 7", 1721},
    {3, "Chair 8", 1724},
    {3, "Chair 9", 1727},
    {3, "Chair 10", 1729},
    {3, "Chair 11", 1735},
    {3, "Chair 12", 1739},
    {3, "Chair 13", 1805},
    {3, "Chair 14", 1806},
    {3, "Chair 15", 1810},
    {3, "Chair 16", 1811},
    {3, "Chair 17", 2079},
    {3, "Chair 18", 2120},
    {3, "Chair 19", 2124},
    {3, "Chair 20", 2356},
    {3, "Chair 21", 1768},
    {3, "Chair 22", 1766},
    {3, "Chair 23", 1764},
    {3, "Chair 24", 1763},
    {3, "Chair 25", 1761},
    {3, "Chair 26", 1760},
    {3, "Chair 27", 1757},
    {3, "Chair 28", 1756},
    {3, "Chair 29", 1753},
    {3, "Chair 30", 1713},
    {3, "Chair 31", 1712},
    {3, "Chair 32", 1706},
    {3, "Chair 33", 1703},
    {3, "Chair 34", 1702},
    {3, "Chair 35", 1754},
    {3, "Chair 36", 1755},
    {3, "Chair 37", 1758},
    {3, "Chair 38", 1759},
    {3, "Chair 39", 1762},
    {3, "Chair 40", 1765},
    {3, "Chair 41", 1767},
    {3, "Chair 42", 1769},
    {3, "Chair 43", 2808},
    {3, "Chair 44", 19996},
    {3, "Chair 45", 2123},
    {3, "Chair 46", 19999},
    {3, "Chair 47", 2309},
    {3, "Chair 48", 2293},
    {3, "Chair 49", 2096},
    {4, "Bed 1", 1700},
    {4, "Bed 2", 1701},
    {4, "Bed 3", 1725},
    {4, "Bed 4", 1745},
    {4, "Bed 5", 1793},
    {4, "Bed 6", 1794},
    {4, "Bed 7", 1795},
    {4, "Bed 8", 1796},
    {4, "Bed 9", 1797},
    {4, "Bed 10", 1771},
    {4, "Bed 11", 1798},
    {4, "Bed 12", 1799},
    {4, "Bed 13", 1800},
    {4, "Bed 14", 1801},
    {4, "Bed 15", 1802},
    {4, "Bed 16", 1812},
    {4, "Bed 17", 2090},
    {4, "Bed 18", 2299},
    {4, "Bed 19", 2302},
    {4, "Bed 20", 14866},
    {4, "Bed 21", 14446},
    {4, "Bed 22", 2298},
    {4, "Bed 23", 2299},
    {4, "Bed 24", 2575},
    {4, "Bed 25", 2566},
    {5, "Cabinet 1", 1416},
    {5, "Cabinet 2", 1417},
    {5, "Cabinet 3", 1741},
    {5, "Cabinet 4", 1742},
    {5, "Cabinet 5", 1743},
    {5, "Cabinet 6", 2025},
    {5, "Cabinet 7", 2065},
    {5, "Cabinet 8", 2066},
    {5, "Cabinet 9", 2067},
    {5, "Cabinet 10", 2087},
    {5, "Cabinet 11", 2088},
    {5, "Cabinet 12", 2094},
    {5, "Cabinet 13", 2095},
    {5, "Cabinet 14", 2306},
    {5, "Cabinet 15", 2307},
    {5, "Cabinet 16", 2323},
    {5, "Cabinet 17", 2328},
    {5, "Cabinet 18", 2329},
    {5, "Cabinet 19", 2330},
    {5, "Cabinet 20", 2708},
    {5, "Cabinet 21", 2204},
    {6, "Television 1", 1518},
    {6, "Television 2", 1717},
    {6, "Television 3", 1747},
    {6, "Television 4", 1748},
    {6, "Television 5", 1749},
    {6, "Television 6", 1750},
    {6, "Television 7", 1752},
    {6, "Television 8", 1781},
    {6, "Television 9", 1791},
    {6, "Television 10", 1792},
    {6, "Television 11", 2312},
    {6, "Television 12", 2316},
    {6, "Television 13", 2317},
    {6, "Television 14", 2318},
    {6, "Television 15", 2320},
    {6, "Television 16", 2595},
    {6, "Television 17", 16377},
    {6, "Television 18", 19786},
    {6, "Television 19", 19787},
    {7, "Kitchen 1", 2013},
    {7, "Kitchen 2", 2017},
    {7, "Kitchen 3", 2127},
    {7, "Kitchen 4", 2130},
    {7, "Kitchen 5", 2131},
    {7, "Kitchen 6", 2132},
    {7, "Kitchen 7", 2135},
    {7, "Kitchen 8", 2136},
    {7, "Kitchen 9", 2144},
    {7, "Kitchen 10", 2147},
    {7, "Kitchen 11", 2149},
    {7, "Kitchen 12", 2150},
    {7, "Kitchen 13", 2415},
    {7, "Kitchen 14", 2417},
    {7, "Kitchen 15", 2421},
    {7, "Kitchen 16", 2426},
    {7, "Kitchen 17", 2014},
    {7, "Kitchen 18", 2015},
    {7, "Kitchen 19", 2016},
    {7, "Kitchen 20", 2018},
    {7, "Kitchen 21", 2019},
    {7, "Kitchen 22", 2022},
    {7, "Kitchen 23", 2133},
    {7, "Kitchen 24", 2134},
    {7, "Kitchen 25", 2137},
    {7, "Kitchen 26", 2138},
    {7, "Kitchen 27", 2139},
    {7, "Kitchen 28", 2140},
    {7, "Kitchen 29", 2141},
    {7, "Kitchen 30", 2142},
    {7, "Kitchen 31", 2143},
    {7, "Kitchen 32", 2145},
    {7, "Kitchen 33", 2148},
    {7, "Kitchen 34", 2151},
    {7, "Kitchen 35", 2152},
    {7, "Kitchen 36", 2153},
    {7, "Kitchen 37", 2154},
    {7, "Kitchen 38", 2155},
    {7, "Kitchen 39", 2156},
    {7, "Kitchen 40", 2157},
    {7, "Kitchen 41", 2158},
    {7, "Kitchen 42", 2159},
    {7, "Kitchen 43", 2160},
    {7, "Kitchen 44", 2134},
    {7, "Kitchen 45", 2135},
    {7, "Kitchen 46", 2338},
    {7, "Kitchen 47", 2341},
    {7, "Kitchen 48", 19927},
    {7, "Kitchen 49", 19926},
    {7, "Kitchen 50", 19928},
    {7, "Kitchen 51", 19929},
    {7, "Kitchen 52", 19930},
    {7, "Kitchen 53", 19931},
    {7, "Kitchen 54", 19923},
    {7, "Kitchen 55", 14720},
    {8, "Bathroom 1", 2514},
    {8, "Bathroom 2", 2516},
    {8, "Bathroom 3", 2517},
    {8, "Bathroom 4", 2518},
    {8, "Bathroom 5", 2520},
    {8, "Bathroom 6", 2521},
    {8, "Bathroom 7", 2522},
    {8, "Bathroom 8", 2523},
    {8, "Bathroom 9", 2524},
    {8, "Bathroom 10", 2525},
    {8, "Bathroom 11", 2526},
    {8, "Bathroom 12", 2527},
    {8, "Bathroom 13", 2528},
    {8, "Bathroom 14", 2738},
    {8, "Bathroom 15", 2739},
    {9, "Decoration 1", 2812},
    {9, "Decoration 2", 2813},
    {9, "Decoration 3", 2815},
    {9, "Decoration 4", 2816},
    {9, "Decoration 5", 2817},
    {9, "Decoration 6", 2818},
    {9, "Decoration 7", 2819},
    {9, "Decoration 8", 2820},
    {9, "Decoration 9", 2822},
    {9, "Decoration 10", 2824},
    {9, "Decoration 11", 2826},
    {9, "Decoration 12", 2827},
    {9, "Decoration 13", 2828},
    {9, "Decoration 14", 2829},
    {9, "Decoration 15", 2830},
    {9, "Decoration 16", 2831},
    {9, "Decoration 17", 2832},
    {9, "Decoration 18", 2833},
    {9, "Decoration 19", 2835},
    {9, "Decoration 20", 2836},
    {9, "Decoration 21", 2841},
    {9, "Decoration 22", 2848},
    {9, "Decoration 23", 2849},
    {9, "Decoration 24", 2850},
    {9, "Decoration 25", 2851},
    {9, "Decoration 26", 2852},
    {9, "Decoration 27", 2853},
    {9, "Decoration 28", 2854},
    {9, "Decoration 29", 2855},
    {9, "Decoration 30", 2862},
    {9, "Decoration 31", 2863},
    {9, "Decoration 32", 2864},
    {9, "Decoration 33", 2865},
    {9, "Decoration 34", 2868},
    {9, "Decoration 35", 2870},
    {9, "Decoration 36", 11705},
    {9, "Decoration 37", 11706},
    {9, "Decoration 38", 11707},
    {9, "Decoration 39", 11715},
    {9, "Decoration 40", 11716},
    {9, "Decoration 41", 11718},
    {9, "Decoration 42", 11719},
    {9, "Decoration 43", 11737},
    {10, "Washer", 1208},
    {10, "Ceiling Fan", 1661},
    {10, "Moose Head", 1736},
    {10, "Radiator", 1738},
    {10, "Mop and Pail", 1778},
    {10, "Water Cooler", 1808},
    {10, "Water Cooler 2", 2002},
    {10, "Money Safe", 1829},
    {10, "Printer", 2186},
    {10, "Computer", 2190},
    {10, "Treadmill", 2627},
    {10, "Bench Press", 2629},
    {10, "Exercise Bike", 2630},
    {10, "Mat 1", 2631},
    {10, "Mat 2", 2632},
    {10, "Mat 3", 2817},
    {10, "Mat 4", 2818},
    {10, "Mat 5", 2833},
    {10, "Mat 6", 2834},
    {10, "Mat 7", 2835},
    {10, "Mat 8", 2836},
    {10, "Mat 9", 2841},
    {10, "Mat 10", 2842},
    {10, "Mat 11", 2847},
    {10, "Book Pile 1", 2824},
    {10, "Book Pile 2", 2826},
    {10, "Book Pile 3", 2827},
    {10, "Basketball", 2114},
    {10, "Lamp 1", 2108},
    {10, "Lamp 2", 2106},
    {10, "Lamp 3", 2069},
    {10, "Dresser 1", 2569},
    {10, "Dresser 2", 2570},
    {10, "Dresser 3", 2573},
    {10, "Dresser 4", 2574},
    {10, "Dresser 5", 2576},
    {10, "Book", 2894},
    {10, "Cupboard", 19937},
    {10, "Toast", 1481},
    {10, "DVD Player 1", 1787},
    {10, "DVD Player 2", 1788},
    {10, "DVD Player 3", 1790},
    {10, "Playstation", 2028},
    {10, "Tiger Skin", 1828},
    {10, "Radio 1", 2103},
    {10, "Radio 2", 2226},
    {10, "Speaker 1", 2229},
    {10, "Speaker 2", 2230},
    {10, "Speaker 3", 2231},
    {10, "Speaker 4", 2232},
    {10, "Safe", 2332}
};

//------[ Trucker ]--------

//new VehProduct[MAX_VEHICLES];
//new VehGasOil[MAX_VEHICLES];

new bool:DialogSaya[MAX_PLAYERS][20];

//-----[ Modular ]-----
main() 
{
	SetTimer("onlineTimer", 1000, true);
	SetTimer("TDUpdates", 8000, true);
}
#include "Utils\COLOR.pwn"
#include "Utils\TEXTDRAW.pwn"
#include "System\UCP.pwn"
#include "System\ANIMS.pwn"
#include "System\GARKOT.pwn"
#include "System\SPEEDCAM.pwn"
#include "System\INVENTORY.pwn"
#include "System\PRIVATE_VEHICLE.pwn"
#include "System\VEHICLE_STORAGE.pwn"
#include "System\REPORT.pwn"
#include "System\ASK.pwn"
#include "System\WEAPON_ATTH.pwn"
#include "System\TOYS.pwn"
#include "System\HELMET.pwn"
#include "System\ELM.pwn"
#include "Utils\SERVER.pwn"
#include "System\DOOR.pwn"
#include "System\FAMILY.pwn"
#include "Property\HOUSE.pwn"
#include "Property\BISNIS.pwn"
#include "Property\GAS_STATION.pwn"
#include "System\DYNAMIC_LOCKER.pwn"
#include "System\RENTAL.pwn"
#include "System\FISH_AREA.pwn"
#include "System\BASEMENT.pwn"
#include "Jobs\JOB_FISH.pwn"
#include "Jobs\JOB_BUS.pwn"
#include "Jobs\JOB_SWEEPER.pwn"
#include "Jobs\JOB_COURIER.pwn"
#include "Jobs\JOB_TRASHMASTER.pwn"
#include "Jobs\JOB_PIZZA.pwn"
//#include "System\AFK.pwn"
#include "System\SCHOOL_LICENSE.pwn"
#include "System\LICENSE.pwn"
#include "Player\TRAINING.pwn"
#include "Player\CONTACTS.pwn"
#include "System\WARDROBE.pwn"

#include "Jobs\JOB_FORKLIFT.pwn"
#include "System\VOUCHER.pwn"
#include "Property\WORKSHOP.pwn"
#include "System\SALARY.pwn"
#include "System\ATM.pwn"
#include "System\GATE.pwn"
#include "System\ADVERTISEMENT.pwn"
#include "System\FACTION_VEHICLE.pwn"
#include "System\FACTION_GARAGE.pwn"
#include "System\FLYMODE.pwn"
#include "System\TAX.pwn"
#include "System\TOLL.pwn"
#include "System\ALLTEXTURES.pwn"
#include "System\FACTIONDOOR.pwn"
#include "System\INTERIOR.pwn"

#include "Player\SKILLS.pwn"
//#include "AUDIO.pwn"
//#include "ROBBERY.pwn"

#include "Jobs\JOB_SMUGGLER.pwn"
#include "Jobs\JOB_TAXI.pwn"
#include "Jobs\JOB_MECH.pwn"
#include "Jobs\JOB_LUMBER.pwn"
#include "Jobs\JOB_MINER.pwn"
//#include "Jobs\JOB_PRODUCTION.pwn"
#include "Jobs\JOB_TRUCKER.pwn"
#include "Jobs\JOB_FARMER.pwn"

#include "Property\HOUSE_STRUCTURE.pwn"
#include "Property\HOUSE_FURNITURE.pwn"

#include "System\MISSIONS_QUEUE.pwn"
#include "Property\FURN_STORE.pwn"
#include "Utils\NATIVE.pwn"
#include "System\ARMS_DEALER.pwn"

#include "Commands\ADMIN.pwn"
#include "Commands\FACTION.pwn"
#include "Commands\PLAYER.pwn"

#include "System\SAPD_TASER.pwn"
#include "System\SAPD_SPIKE.pwn"
#include "System\SAPD_ALPR.pwn"
#include "System\SAPD_IMPOUND.pwn"

#include "Utils\DIALOG.pwn"

#include "Commands\ALIAS\ALIAS_ADMIN.pwn"
#include "Commands\ALIAS\ALIAS_PLAYER.pwn"
#include "Commands\ALIAS\ALIAS_BISNIS.pwn"
#include "Commands\ALIAS\ALIAS_HOUSE.pwn"
#include "Commands\ALIAS\ALIAS_PRIVATE_VEHICLE.pwn"

#include "System\EVENT.pwn"

#include "Utils\FUNCTION.pwn"

#include "Utils\TASK.pwn"

#include "Mapping\MAP_STORAGE_CRATE.pwn"
#include "Mapping\MAP_STADIUM_PIER.pwn"
#include "Mapping\MAP_FISH_FACTORY.pwn"
#include "Mapping\MAP_BUS.pwn"
#include "Mapping\MAP_MECHANIC.pwn"
#include "Mapping\MAP_SHOWROOM.pwn"

#include "Mapping\Exterior\ext_toll.pwn"
#include "Mapping\Exterior\ext_sapd2.pwn"
#include "Mapping\Exterior\ext_chigago.pwn"
#include "Mapping\Interior\int_sapd.pwn"
#include "Mapping\Exterior\ext_samd.pwn"
#include "Mapping\Interior\int_samd.pwn"
#include "Mapping\Interior\int_sags.pwn"
#include "Mapping\Interior\int_basement.pwn"
#include "Mapping\Exterior\ext_boatrepair.pwn"
#include "Mapping\Exterior\ext_boatschool.pwn"

// Faction Vehicle
IsSAPDCar(carid)
{
	foreach(new ii : PVehicles) if(GetVehicleType(ii) == VEHICLE_TYPE_FACTION && pvData[ii][cVeh] == carid)
	{
	    if(pvData[ii][cExtraID] == SAPD) return 1;
	}
	return 0;
}

IsGovCar(carid)
{
	foreach(new ii : PVehicles) if(GetVehicleType(ii) == VEHICLE_TYPE_FACTION && pvData[ii][cVeh] == carid)
	{
	    if(pvData[ii][cExtraID] == SAGS) return 1;
	}
	return 0;
}

IsSAMDCar(carid)
{
	foreach(new ii : PVehicles) if(GetVehicleType(ii) == VEHICLE_TYPE_FACTION && pvData[ii][cVeh] == carid)
	{
	    if(pvData[ii][cExtraID] == SAMD) return 1;
	}
	return 0;
}

IsSANACar(carid)
{
	foreach(new ii : PVehicles) if(GetVehicleType(ii) == VEHICLE_TYPE_FACTION && pvData[ii][cVeh] == carid)
	{
	    if(pvData[ii][cExtraID] == SANEW) return 1;
	}
	return 0;
}

forward SaveLunarSystem(playerid);
public SaveLunarSystem(playerid)
{
	format(File, sizeof(File), "[AkunPlayer]/Stats/%s.ini", pData[playerid][pName]);
	if( dini_Exists( File ) )
	{
		// WBR
        dini_IntSet(File, "Kepala", pData[playerid][pHead]);
        dini_IntSet(File, "Perut", pData[playerid][pPerut]);
        dini_IntSet(File, "TanganKanan", pData[playerid][pRHand]);
        dini_IntSet(File, "TanganKiri", pData[playerid][pLHand]);
        dini_IntSet(File, "KakiKanan", pData[playerid][pRFoot]);
        dini_IntSet(File, "KakiKiri", pData[playerid][pLFoot]);
        // ASK
        dini_IntSet(File, "AskTime", pData[playerid][pAskTime]);
        // OBAT
        dini_IntSet(File, "Obat Myricous", pData[playerid][pObat]);
        // SUSPECT
        dini_IntSet(File, "Suspected", pData[playerid][pSuspect]);
        dini_IntSet(File, "GetLoc Timer", pData[playerid][pSuspectTimer]);
        // PHONE
        dini_IntSet(File, "Phone Status", pData[playerid][pUsePhone]);
        // TWITTER
        dini_IntSet(File, "Twitter", pData[playerid][pTwitter]);
        // Kuota
        dini_IntSet(File, "Kuota", pData[playerid][pKuota]);
        // DELAY ROB
        dini_IntSet(File, "Rob Delay", pData[playerid][pRobTime]);
        // Booster System
        dini_IntSet(File, "Boost", pData[playerid][pBooster]);
        dini_IntSet(File, "Boost Time", pData[playerid][pBoostTime]);
	}
}

forward LoadLunarSystem(playerid);
public LoadLunarSystem(playerid)
{
	format( File, sizeof( File ), "[AkunPlayer]/Stats/%s.ini", pData[playerid][pName]);
    if(dini_Exists(File))//Buat load data user(dikarenakan sudah ada datanya)
    {  
    	// WBR
        pData[playerid][pHead] = dini_Int( File,"Kepala");
        pData[playerid][pPerut] = dini_Int( File,"Perut");
        pData[playerid][pRHand] = dini_Int( File,"TanganKanan");
        pData[playerid][pLHand] = dini_Int( File,"TanganKiri");
        pData[playerid][pRFoot] = dini_Int( File,"KakiKanan");
        pData[playerid][pLFoot] = dini_Int( File,"KakiKiri");
        // ASK
        pData[playerid][pAskTime] = dini_Int( File, "AskTime");
        // OBAT
        pData[playerid][pObat] = dini_Int( File, "Obat Myricous");
        // SUSPECT
        pData[playerid][pSuspect] = dini_Int( File, "Suspected");
        pData[playerid][pSuspectTimer] = dini_Int( File, "GetLoc Timer");
        // PHONE
        pData[playerid][pUsePhone] = dini_Int( File, "Phone Status");
        // TWITTER
        pData[playerid][pKuota] = dini_Int(File , "Kuota");
        pData[playerid][pTwitter] = dini_Int(File, "Twitter");
        // DUTY
        pData[playerid][pDutyHour] = dini_Int(File, "Waktu Duty");
        // DELAY ROB
        pData[playerid][pRobTime] = dini_Int(File, "Rob Delay");
        // RP BOOST
        pData[playerid][pBooster] = dini_Int(File, "Boost");
        pData[playerid][pBoostTime] = dini_Int(File, "Boost Time");
    }
    else //Buat user baru(Bikin file buat pemain baru dafar)
    {
    	dini_Create( File );
    	// WBR
        dini_IntSet(File, "Kepala", 100);
        dini_IntSet(File, "Perut", 100);
        dini_IntSet(File, "TanganKanan", 100);
        dini_IntSet(File, "TanganKiri", 100);
        dini_IntSet(File, "KakiKanan", 100);
        dini_IntSet(File, "KakiKiri", 100);
        // ASK
        dini_IntSet(File, "AskTime", 0);
        // Obat
        dini_IntSet(File, "Obat Myricous", 0);
        // Suspect
        dini_IntSet(File, "Suspected", 0);
        dini_IntSet(File, "GetLoc Timer", 0);
        dini_IntSet(File, "Phone Status", 0);
        // TWITTER
        dini_IntSet(File, "Kuota", 0);
        dini_IntSet(File, "Twitter", 0);
        // DUTY
        dini_IntSet(File, "Waktu Duty", 0);
        // ROB
        dini_IntSet(File, "Rob Delay", 0);
        // Roleplay Boost
        dini_IntSet(File, "Booost", 0);
        dini_IntSet(File, "Boost Time", 0);
        pData[playerid][pHead] = dini_Int( File,"Kepala");
        pData[playerid][pPerut] = dini_Int( File,"Perut");
        pData[playerid][pRHand] = dini_Int( File,"TanganKanan");
        pData[playerid][pLHand] = dini_Int( File,"TanganKiri");
        pData[playerid][pRFoot] = dini_Int( File,"KakiKanan");
        pData[playerid][pLFoot] = dini_Int( File,"KakiKiri");
        pData[playerid][pAskTime] = dini_Int( File, "AskTime");
        pData[playerid][pObat] = dini_Int( File, "Obat Myricous");
        pData[playerid][pSuspect] = dini_Int( File, "Suspected");
        pData[playerid][pSuspectTimer] = dini_Int( File, "GetLoc Timer");
        pData[playerid][pUsePhone] = dini_Int( File, "Phone Status");
        pData[playerid][pKuota] = dini_Int(File, "Kuota");
        pData[playerid][pTwitter] = dini_Int(File, "Twitter");
        pData[playerid][pDutyHour] = dini_Int(File, "Waktu Duty");
        pData[playerid][pRobTime] = dini_Int(File, "Rob Delay");
        pData[playerid][pBooster] = dini_Int(File, "Boost");
        pData[playerid][pBoostTime] = dini_Int(File, "Boost Time");
    }
    pData[playerid][pMemberRob] = 0;
    pData[playerid][pRobMember] = 0;
    pData[playerid][pRobLeader] = 0;
    return 1;
}

public OnGameModeInit()
{
	//mysql_log(ALL);
	new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true);

	g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id);
	if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
	{
		print("MySQL connection failed. Server is shutting down.");
		SendRconCommand("exit");
		return 1;
	}
	print("MySQL connection is successful.");
	mysql_tquery(g_SQL, "SELECT * FROM `server`", "LoadServer");
	mysql_tquery(g_SQL, "SELECT * FROM `doors`", "LoadDoors");
	mysql_tquery(g_SQL, "SELECT * FBROM `familys`", "LoadFamilys");
	mysql_tquery(g_SQL, "SELECT * FROM `houses`", "LoadHouses");
	mysql_tquery(g_SQL, "SELECT * FROM `bisnis`", "LoadBisnis");
	mysql_tquery(g_SQL, "SELECT * FROM `lockers`", "LoadLockers");
	mysql_tquery(g_SQL, "SELECT * FROM `gstations`", "LoadGStations");
	mysql_tquery(g_SQL, "SELECT * FROM `atms`", "LoadATM");
	mysql_tquery(g_SQL, "SELECT * FROM `gates`", "LoadGates");
	mysql_tquery(g_SQL, "SELECT * FROM `vouchers`", "LoadVouchers");
	mysql_tquery(g_SQL, "SELECT * FROM `trees`", "LoadTrees");
	mysql_tquery(g_SQL, "SELECT * FROM `ores`", "LoadOres");
	mysql_tquery(g_SQL, "SELECT * FROM `plants`", "LoadPlants");
	mysql_tquery(g_SQL, "SELECT * FROM `workshop`", "LoadWorkshop");
	mysql_tquery(g_SQL, "SELECT * FROM `parks`", "LoadPark");
	mysql_tquery(g_SQL, "SELECT * FROM `rentplayer`", "Rent_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `fishingarea`", "FishingAreaLoad");
	mysql_tquery(g_SQL, "SELECT * FROM `factiongarage`", "FactionGarage_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `basement`", "LoadBasement");
	mysql_tquery(g_SQL, "SELECT * FROM `lemari`", "LoadLemari", "");
	mysql_tquery(g_SQL, "SELECT * FROM `doorfaction`", "DoorFaction_Load");
	//furn
	mysql_tquery(g_SQL, "SELECT * FROM `furnstore` ORDER BY `id` ASC", "FurnStore_Load", "");
    mysql_tquery(g_SQL, "SELECT * FROM `furnobject` ORDER BY `id` ASC", "FurnObject_Load", "");

	LoadFactionVehicle();

	CallLocalFunction("LoadMapping", "");

	LoadServerMap();

	CreateTextDraw();
	CreateServerPoint();
	CreateJoinLumberPoint();
	CreateJoinTaxiPoint();
	CreateJoinMechPoint();
	CreateJoinMinerPoint();
	//CreateJoinProductionPoint();
	CreateJoinTruckPoint();
	CreateArmsPoint();
	CreateJoinFarmerPoint();
	LoadTazerSAPD();
	
	new gm[32];
	format(gm, sizeof(gm), "%s", TEXT_GAMEMODE);
	SetGameModeText(gm);
	format(gm, sizeof(gm), "weburl %s", TEXT_WEBURL);
	SendRconCommand(gm);
	format(gm, sizeof(gm), "language %s", TEXT_LANGUAGE);
	SendRconCommand(gm);
	
	SendRconCommand("mapname San Andreas");
	ManualVehicleEngineAndLights();
	EnableStuntBonusForAll(0);
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	LimitPlayerMarkerRadius(15.0);
	SetNameTagDrawDistance(20.0);
	//DisableNameTagLOS();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	SetWorldTime(WorldTime);
	SetWeather(WorldWeather);
	BlockGarages(.text="NO ENTER");
	//Audio_SetPack("default_pack");
	

	new strings[350]; 

	SetTimer("LoadServerStuff", 5000, 0);

	//IMPOUND
 	CreateDynamic3DTextLabel(""GRAY"Impound Center\n"YELLOW"'/unimpound' "WHITE"untuk mengunimpound kendaraan", COLOR_WHITE, 2820.2354, -1475.2073, 16.2500+0.5, 10.0);
 	CreateDynamicPickup(1239, 23, 2820.2354, -1475.2073, 16.2500, -1); // TEMPAT UNTUK UNIMPOUND

	CreateActor(59, 1673.4685,-2310.3572,13.5431,179.9549);
	CreateDynamic3DTextLabel("Cecep Sugeni\n"WHITE"Gunakan "YELLOW"/claimsp "WHITE"Untuk claim straterpack", COLOR_GREY, 1673.4685,-2310.3572,13.5431+1.0, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // server menu

	CreateDynamicPickup(1239, 23, 1395.9802,-29.4111,1013.9901, -1);
	format(strings, sizeof(strings), "[City Hall]\n{FFFFFF}/newidcard - create new ID Card\n/newage - Change Birthday\n/sellhouse - sell your house\n/sellbisnis - sell your bisnis\n/paytax - membayar pajak");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 1395.9802,-29.4111,1013.9901+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // ID Card
	
	CreateDynamicPickup(1239, 23, 1667.9655,-1408.8066,13.5497, -1);
	format(strings, sizeof(strings), "[Insurance Company]\n"YELLOW"/buyinsu "WHITE"- buy insurance\n"YELLOW"/claimpv "WHITE"- claim insurance\n"YELLOW"/sellpv "WHITE"- sell vehicle");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 1667.9655,-1408.8066,13.5497+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance
	
	//CreateDynamicPickup(1239, 23, 252.22, 117.43, 1003.21, -1);
	//format(strings, sizeof(strings), "[License]\n"YELLOW"/newdrivelic "WHITE"- create new license");
	//CreateDynamic3DTextLabel(strings, COLOR_GREY, 252.22, 117.43, 1003.21+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic
	
	CreateDynamicPickup(1239, 23, 1389.5691,-23.1329,1000.9911, -1);
	format(strings, sizeof(strings), "[Plate]\n"YELLOW"/buyplate "WHITE"- create new plate");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 1389.5691,-23.1329,1000.9911+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate
	
	CreateDynamicPickup(1239, 23, 1386.8989,-23.1341,1000.9911, -1);
	format(strings, sizeof(strings), "[Ticket]\n"YELLOW"/payticket "WHITE"- to pay ticket");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 1386.8989,-23.1341,1000.9911+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket
	
	CreateDynamicPickup(1239, 23, 1367.2697,-20.2810,1000.9911, -1);
	format(strings, sizeof(strings), "[Arrest Point]\n"YELLOW"/arrest "WHITE"- arrest wanted player");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 1367.2697,-20.2810,1000.9911+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // arrest
	
	CreateDynamicPickup(1239, 23, 1142.38, -1330.74, 13.62, -1);
	format(strings, sizeof(strings), "[Hospital]\n{FFFFFF}/dropinjured");
	CreateDynamic3DTextLabel(strings, COLOR_PINK, 1142.38, -1330.74, 13.62+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // hospital
	
	CreateDynamicPickup(1239, 23, 2246.55, -1750.25, 1014.77, -1);
	format(strings, sizeof(strings), "[Bank]\n"YELLOW"/bank "WHITE"- access rekening\n"YELLOW"/newrek "WHITE"- create new rekening");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 2246.55, -1750.25, 1014.77+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank
	
	CreateDynamicPickup(1239, 23, 2461.21, 2270.42, 91.67, -1);
	format(strings, sizeof(strings), "[Advertisment]\n{FFFFFF}/ad - public ads");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 2461.21, 2270.42, 91.67+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // iklan

	CreateDynamicPickup(1241, 23, -1268.5018,-419.0994,14.1784, -1);
	format(strings, sizeof(strings), "[MYRICOUS PRODUCTION]\n{FFFFFF}/mix & /sellobat");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, -1268.5018,-419.0994,14.1784+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // racik obat
	
	//Dynamic CP
	//ShowRoomCP = CreateDynamicCP(1750.25, -1766.13, 13.54, 1.0, -1, -1, -1, 5.0);
	CreateDynamic3DTextLabel(""GRAY"[Showroom]\n"YELLOW"/buypv "WHITE"- Untuk membeli kendaraan", -1, 1775.7257,-1790.5582,13.8916+0.5, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);
	CreateDynamicPickup(1239, 23, 1775.7257,-1790.5582,13.8916, -1);

	//ShowRoomCPRent = CreateDynamicCP(1750.16, -1761.53, 13.54, 1.0, -1, -1, -1, 5.0);
	//CreateDynamic3DTextLabel("{7fff00}Rental Vehicle\n{ffffff}Stand Here!"YELLOW_E"/unrentpv", COLOR_LBLUE, 1750.16, -1761.53, 13.54, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);
	
	//Sidejob Vehicle
	//AddSweeperVehicle();
	AddBusVehicle();
	AddForVehicle();

    CreateDynamicMapIcon(361.2099,-2032.1703,7.8359, 9, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON Fish Bait
    CreateDynamicMapIcon(2330.1626,-2315.2642,13.5469, 56, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON MECHA JOB
    CreateDynamicMapIcon(-77.1687,-1136.5388,1.0781, 51, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON TRUCKER JOB
    CreateDynamicMapIcon(-382.7033,-1438.9998,26.1691, 56, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON FARMER JOB
    CreateDynamicMapIcon(2244.4438,-2002.7745,18.8555, 27, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON MODSHOP
    CreateDynamicMapIcon(1481.0156,-1772.1384,18.8370, 35, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON CITY HALL
    CreateDynamicMapIcon(1555.5023,-1675.6029,16.1953, 30, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON LSPD
    CreateDynamicMapIcon(1172.0767,-1323.6888,15.4037, 22, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON SAMD
    CreateDynamicMapIcon(2200.9639,-2215.5659,13.5547, 26, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON MC
    CreateDynamicMapIcon(1657.9524,-1394.4664,13.5469, 40, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON INSURANCE
    CreateDynamicMapIcon(1462.2328,-1021.0492,24.1048, 52, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON BANK
    CreateDynamicMapIcon(2615.8027,-2473.2822,3.1963, 9, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON Boat Repair
    CreateDynamicMapIcon(2060.5090,-1909.3605,13.5469, 36, 0, 0, 0, -1, MAP_ICON_STREAM_DISTANCE, MAPICON_LOCAL); // ICON Boat Repair

	
	/*CreateDynamicObject(19305, 1388.987670, -25.291969, 1001.358520, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(19305, 1391.275756, -25.481920, 1001.358520, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SAGSLobbyKey[0] = CreateKeypadEx(1388.987670, -25.291969, 1001.358520, "1234");
    SAGSLobbyKey[1] = CreateKeypadEx(1391.275756, -25.481920, 1001.358520, "1234");
	SAGSLobbyDoor = CreateDynamicObject(1569, 1389.375000, -25.387500, 999.978210, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);*/
	
	/*CreateButton(Float:x, Float:y, Float:z, text[],
	world = 0, interior = 0, Float:areasize = 1.0, label = 0,
	labeltext[] = "", labelcolour = 0xFFFF00FF, Float:streamdist = BTN_DEFAULT_STREAMDIST, testlos = true)
	
	SAGSLobbyBtn[0] = CreateButton(1388.987670, -25.291969, 1001.358520, "SAGS Lobby", 0, 0, 1.0, 0, "No", 0xFFFF00FF, BTN_DEFAULT_STREAMDIST, true);
    SAGSLobbyBtn[1] = CreateButton(1391.275756, -25.481920, 1001.358520, "SAGS Lobby", 0,  0, 1.0, 0, "No", 0xFFFF00FF, BTN_DEFAULT_STREAMDIST, true);

	SAGSLobbyDoor = CreateDoor(1569, SAGSLobbyBtn,
		1389.375000, -25.387500, 999.978210, 0.00000, 0.00000, 0.00000,
		1387.9232, -25.3887, 999.9782, 0.00000, 0.00000, 0.00000,
		.movespeed = 1.0, .closedelay = 3000, .maxbuttons = 2, .movesound = 1186, .stopsound = 1186, .worldid = 0, .interiorid = 0, .initstate = DR_STATE_CLOSED);
	*/
	
	printf("[Object] Number of Dynamic objects loaded: %d", CountDynamicObjects());
	return 1;
}

public OnGameModeExit()
{
	new count = 0, count1 = 0;
	foreach(new gsid : GStation)
	{
		if(Iter_Contains(GStation, gsid))
		{
			count++;
			GStation_Save(gsid);
		}
	}
	printf("[Gas Station] Number of Saved: %d", count);
	
	foreach(new pid : Plants)
	{
		if(Iter_Contains(Plants, pid))
		{
			count1++;
			Plant_Save(pid);
		}
	}
	printf("[Farmer Plant] Number of Saved: %d", count1);
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
	{
		if (IsPlayerConnected(i))
		{
			OnPlayerDisconnect(i, 1);
		}
	}
	forex(fac, 4)
	{
		SaveFactionVehicle(fac);
	}
	Server_Save();
	UnloadTazerSAPD();
	//Audio_DestroyTCPServer();
	mysql_close(g_SQL);
	return 1;
}

function SAGSLobbyDoorClose()
{
	MoveDynamicObject(SAGSLobbyDoor, 1389.375000, -25.387500, 999.978210, 3);
	return 1;
}

function SAPDLobbyDoorClose()
{
	MoveDynamicObject(SAPDLobbyDoor[0], 253.10965, 107.61060, 1002.21368, 3);
	MoveDynamicObject(SAPDLobbyDoor[1], 253.12556, 110.49657, 1002.21460, 3);
	MoveDynamicObject(SAPDLobbyDoor[2], 239.69435, 116.15908, 1002.21411, 3);
	MoveDynamicObject(SAPDLobbyDoor[3], 239.64050, 119.08750, 1002.21332, 3);
	return 1;
}

function LLFLobbyDoorClose()
{
	MoveDynamicObject(LLFLobbyDoor, -2119.21509, 657.54187, 1060.73560, 3);
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(!ispassenger)
	{
		if(IsSAPDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 1)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SAPD!");
			}
		}
		if(IsGovCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 2)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SAGS!");
			}
		}
		if(IsSAMDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 3)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SAMD!");
			}
		}
		if(IsSANACar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 4)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SANEW!");
			}
		}
		if(GetVehicleModel(vehicleid) == 548 || GetVehicleModel(vehicleid) == 417 || GetVehicleModel(vehicleid) == 487 || GetVehicleModel(vehicleid) == 488 ||
		GetVehicleModel(vehicleid) == 497 || GetVehicleModel(vehicleid) == 563 || GetVehicleModel(vehicleid) == 469)
		{
			if(pData[playerid][pLevel] < 5)
			{
				RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				Error(playerid, "Anda tidak memiliki izin!");
			}
		}
	}
	return 1;
}

stock SGetName(playerid)
{
    new name[ 64 ];
    GetPlayerName(playerid, name, sizeof( name ));
    return name;
}

public OnPlayerText(playerid, text[])
{
	if(isnull(text)) return 0;
	printf("[CHAT] %s(%d) : %s", pData[playerid][pName], playerid, text);
	
	if(pData[playerid][pSpawned] == 0 && pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be spawned or logged in to use chat.");
	    return 0;
	}
	// AUTO RP
	if(!strcmp(text, "rpgun", true) || !strcmp(text, "gunrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s lepaskan senjatanya dari sabuk dan siap untuk menembak kapan saja.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcrash", true) || !strcmp(text, "crashrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kaget setelah kecelakaan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfish", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memancing dengan kedua tangannya.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfall", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s jatuh dan merasakan sakit.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpmad", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa kesal dan ingin mengeluarkan amarah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rprob", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menggeledah sesuatu dan siap untuk merampok.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcj", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mencuri kendaraan seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpwar", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berperang dengan sesorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdie", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s pingsan dan tidak sadarkan diri.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfixmeka", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memperbaiki mesin kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcheckmeka", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memeriksa kondisi kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfight", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ribut dan memukul seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcry", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang bersedih dan menangis.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rprun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berlari dan kabur.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfear", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa ketakutan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdropgun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s meletakkan senjata kebawah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rptakegun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mengamnbil senjata.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpgivegun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memberikan kendaraan kepada seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpshy", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa malu.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpnusuk", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menusuk dan membunuh seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpharvest", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memanen tanaman.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rplockhouse", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang mengunci rumah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rplockcar", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang mengunci kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpnodong", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memulai menodong seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpeat", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s makan makanan yang ia beli.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdrink", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s meminum minuman yang ia beli.", ReturnName(playerid));
		return 0;
	}
	if(text[0] == '!')
	{
		new tmp[512];
		if(text[1] == ' ')
		{
			format(tmp, sizeof(tmp), "%s", text[2]);
		}
		else
		{
			format(tmp, sizeof(tmp), "%s", text[1]);
		}
		if(pData[playerid][pAdminDuty] == 1)
		{
			if(strlen(tmp) > 64)
			{
				SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %.64s ..", ReturnName(playerid), tmp);
				SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", tmp[64]);
				return 0;
			}
			else
			{
				SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %s ))", ReturnName(playerid), tmp);
				return 0;
			}
		}
		else
		{
			if(strlen(tmp) > 64)
			{
				SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %.64s ..", ReturnName(playerid), tmp);
				SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", tmp[64]);
				return 0;
			}
			else
			{
				SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %s ))", ReturnName(playerid), tmp);
				return 0;
			}
		}
	}
	if(text[0] == '@')
	{
		if(pData[playerid][pSMS] != 0)
		{
			if(pData[playerid][pPhoneCredit] < 1)
			{
				Error(playerid, "Anda tidak memiliki Credit!");
				return 0;
			}
			if(pData[playerid][pInjured] != 0)
			{
				Error(playerid, "Tidak dapat melakukan saat ini.");
				return 0;
			}
			new tmp[512];
			foreach(new ii : Player)
			{
				if(text[1] == ' ')
				{
			 		format(tmp, sizeof(tmp), "%s", text[2]);
				}
				else
				{
				    format(tmp, sizeof(tmp), "%s", text[1]);
				}
				if(pData[ii][pPhone] == pData[playerid][pSMS])
				{
					if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii))
					{
						Error(playerid, "Nomor ini tidak aktif!");
						return 0;
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS to %d]"WHITE_E" %s", pData[playerid][pSMS], tmp);
					SendClientMessageEx(ii, COLOR_YELLOW, "[SMS from %d]"WHITE_E" %s", pData[playerid][pPhone], tmp);
					PlayerPlaySound(ii, 6003, 0,0,0);
					pData[ii][pSMS] = pData[playerid][pPhone];
					
					pData[playerid][pPhoneCredit] -= 1;
					return 0;
				}
			}
		}
	}
	if(pData[playerid][pCall] != INVALID_PLAYER_ID)
	{
		// Anti-Caps
		if(GetPVarType(playerid, "Caps"))
			UpperToLower(text);
		new lstr[1024];
		format(lstr, sizeof(lstr), "[CellPhone] %s says: %s", ReturnName(playerid), text);
		ProxDetector(10, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
		SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
		SendClientMessageEx(pData[playerid][pCall], COLOR_YELLOW, "[CELLPHONE] "WHITE_E"%s.", text);
		return 0;
	}
	else
	{
		// Anti-Caps
		if(GetPVarType(playerid, "Caps"))
			UpperToLower(text);
		new lstr[1024];
		if(!IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		{
			if(pData[playerid][pAdminDuty] == 1)
			{
				format(lstr, sizeof(lstr), ""RED"%s"WHITE": (( %s ))", pData[playerid][pAdminname], text);
				ProxDetector(25, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
				SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
			}
			else
			{
				format(lstr, sizeof(lstr), "%s says: %s", ReturnName(playerid), text);
				ProxDetector(25, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
				SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		{
			if(pData[playerid][pAdmin] < 1)
			{
				format(lstr, sizeof(lstr), "[OOC ZONE] %s: (( %s ))", ReturnName(playerid), text);
				ProxDetector(40, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
			else if(pData[playerid][pAdmin] > 1 || pData[playerid][pHelper] > 1)
			{
				format(lstr, sizeof(lstr), "[OOC ZONE] %s: %s", pData[playerid][pAdminname], text);
				ProxDetector(40, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
		}
		return 0;
	}
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(pData[playerid][pAdminDuty])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), fX, fY, fZ);
		}
		else
		{
			SetPlayerPos(playerid, fX, fY, fZ);
			//SendAdminMessage(COLOR_CLIENT,"[AdmCmd]"RED" %s{C6E2FF} telah teleportasi ke kordinat "YELLOW"%f, %f, %f", ReturnName(playerid), fX, fY, fZ);
		}
	}
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if (result == -1)
    {
        Error(playerid, "Unknown Command! Gunakan /help untuk info lanjut.");
        return 0;
    }
	printf("[CMD]: %s(%d) menggunakan CMD '%s' (%s)", pData[playerid][pName], playerid, cmd, params);
    return 1;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	new PlayerIP[16];
	g_MysqlRaceCheck[playerid]++;
	AntiBHOP[playerid] = 0;
	IsAtEvent[playerid] = 0;
	ResetVariables(playerid);
	CreatePlayerTextDraws(playerid);

	RemoveServerMap(playerid);

	CallLocalFunction("RemoveBuilding", "d", playerid);
	
	GetPlayerName(playerid, pData[playerid][pName], MAX_PLAYER_NAME);
	GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
	pData[playerid][pIP] = PlayerIP;

	SetTimerEx("SafeLogin", 1000, 0, "i", playerid);
	
	SetPlayerVirtualWorld(playerid, playerid + 1);
	SendClientMessage(playerid, -1, "Validiting your account data...");
	SetTimerEx("CheckAccount", 1000, false, "d", playerid);
	//CheckAccount(playerid);

	pData[playerid][activitybar] = CreatePlayerProgressBar(playerid, 273.500000, 157.333541, 88.000000, 8.000000, 5930683, 100, 0);
	
	//HBE textdraw Modern
	pData[playerid][damagebar] = CreatePlayerProgressBar(playerid, 459.000000, 415.749938, 61.000000, 9.000000, 16711935, 1000.0, 0);
	pData[playerid][fuelbar] = CreatePlayerProgressBar(playerid, 459.500000, 432.083221, 61.000000, 9.000000, 16711935, 1000.0, 0);
                
	pData[playerid][hungrybar] = CreatePlayerProgressBar(playerid, 565.500000, 405.833404, 68.000000, 8.000000, 16711935, 100.0, 0);
	pData[playerid][energybar] = CreatePlayerProgressBar(playerid, 565.500000, 420.416717, 68.000000, 8.000000, 16711935, 100.0, 0);
	pData[playerid][bladdybar] = CreatePlayerProgressBar(playerid, 565.500000, 435.000091, 68.000000, 8.000000, 16711935, 100.0, 0);
	
	//HBE textdraw Simple
	pData[playerid][spdamagebar] = CreatePlayerProgressBar(playerid, 565.500000, 383.666717, 51.000000, 7.000000, 16711935, 1000.0, 0);
	pData[playerid][spfuelbar] = CreatePlayerProgressBar(playerid, 566.000000, 398.250061, 51.000000, 7.000000, 16711935, 1000.0, 0);
                
	pData[playerid][sphungrybar] = CreatePlayerProgressBar(playerid, 467.500000, 433.833282, 41.000000, 8.000000, 16711935, 100.0, 0);
	pData[playerid][spenergybar] = CreatePlayerProgressBar(playerid, 531.500000, 433.249938, 41.000000, 8.000000, 16711935, 100.0, 0);
	pData[playerid][spbladdybar] = CreatePlayerProgressBar(playerid, 595.500000, 433.250061, 41.000000, 8.000000, 16711935, 100.0, 0);

	HBE_HUNGER[playerid] = CreatePlayerProgressBar(playerid, 575.000000, 376.000000, 65.500000, 3.000000, -1, 100.000000, 0);
	//SetPlayerProgressBarValue(playerid, HBE_HUNGER[playerid], 50.000000);

	HBE_THIRST[playerid] = CreatePlayerProgressBar(playerid, 575.000000, 360.000000, 65.500000, 3.000000, -1, 100.000000, 0);
	//SetPlayerProgressBarValue(playerid, HBE_THIRST[playerid], 50.000000);

	HBE_STRESS[playerid] = CreatePlayerProgressBar(playerid, 575.000000, 344.000000, 65.500000, 3.000000, -1, 100.000000, 0);
	//SetPlayerProgressBarValue(playerid, HBE_STRESS[playerid], 50.000000);

    if(pData[playerid][pHead] < 0) pData[playerid][pHead] = 20;

    if(pData[playerid][pPerut] < 0) pData[playerid][pPerut] = 20;

    if(pData[playerid][pRFoot] < 0) pData[playerid][pRFoot] = 20;

    if(pData[playerid][pLFoot] < 0) pData[playerid][pLFoot] = 20;

    if(pData[playerid][pLHand] < 0) pData[playerid][pLHand] = 20;
   
    if(pData[playerid][pRHand] < 0) pData[playerid][pRHand] = 20;

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	for(new i; i < 10; i++)
	{
		if(DialogSaya[playerid][i] == true)
		{
			if(IsABusABVeh(GetPlayerVehicleID(playerid))) {
				DialogBus[i]--;
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			}
			if(IsABusCDVeh(GetPlayerVehicleID(playerid))) {
				DialogBusCD[i]--;
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			}
			if(IsASweeperVeh(GetPlayerVehicleID(playerid))) {
				DialogSweeper[i] = false;
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			}
		}
	}
	if(IsACourierVeh(GetPlayerVehicleID(playerid)) && pData[playerid][pSideJob] == SIDEJOB_COURIER)
    {
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
    }
	//pData[playerid][pLastLogin] = gettime();
	if(IsPlayerInAnyVehicle(playerid))
	{
        RemovePlayerFromVehicle(playerid);
    }
	//UpdateWeapons(playerid);
	g_MysqlRaceCheck[playerid]++;
	
	if(pData[playerid][IsLoggedIn] == true)
	{
		if(IsAtEvent[playerid] == 0)
		{
			UpdatePlayerData(playerid);
		}
		RemovePlayerVehicle(playerid);
		Report_Clear(playerid);
		Ask_Clear(playerid);
		Player_ResetMining(playerid);
		Player_ResetCutting(playerid);
		Player_RemoveLumber(playerid);
		Player_ResetHarvest(playerid);
		KillTazerTimer(playerid);
		KillTimer(pData[playerid][pFareTimer]);
		SaveLunarSystem(playerid);
		if(IsAtEvent[playerid] == 1)
		{
			if(GetPlayerTeam(playerid) == 1)
			{
				if(EventStarted == 1)
				{
					RedTeam -= 1;
					foreach(new ii : Player)
					{
						if(GetPlayerTeam(ii) == 2)
						{
							GivePlayerMoneyEx(ii, EventPrize);
							Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
						else if(GetPlayerTeam(ii) == 1)
						{
							Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							RedTeam = 0;
						}
					}
				}
			}
			if(GetPlayerTeam(playerid) == 2)
			{
				if(EventStarted == 1)
				{
					BlueTeam -= 1;
					foreach(new ii : Player)
					{
						if(GetPlayerTeam(ii) == 1)
						{
							GivePlayerMoneyEx(ii, EventPrize);
							Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
						else if(GetPlayerTeam(ii) == 2)
						{
							Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
					}
				}
			}
			SetPlayerTeam(playerid, 0);
			IsAtEvent[playerid] = 0;
			pData[playerid][pInjured] = 0;
			pData[playerid][pSpawned] = 1;
		}
		if(pData[playerid][pRobLeader] == 1)
		{
			foreach(new ii : Player) 
			{
				if(pData[ii][pMemberRob] > 1)
				{
					Servers(ii, "* Pemimpin Perampokan anda telah keluar! [ MISI GAGAL ]");
					pData[ii][pMemberRob] = 0;
					RobMember = 0;
					pData[ii][pRobLeader] = 0;
					ServerMoney += robmoney;
				}
			}
		}
		if(pData[playerid][pMemberRob] == 1)
		{
			pData[playerid][pMemberRob] = 0;
			foreach(new ii : Player) 
			{
				if(pData[ii][pRobLeader] > 1)
				{
					Servers(ii, "* Member berkurang 1");
					pData[ii][pMemberRob] -= 1;
					RobMember -= 1;
				}
			}
		}
	}
	
	if(IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pAdoTag]);

    if(IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pBTag]);
			
	if(IsValidDynamicObject(pData[playerid][pFlare]))
            DestroyDynamicObject(pData[playerid][pFlare]);
    
    if(pData[playerid][pMaskOn] == 1)
        Delete3DTextLabel(pData[playerid][pMaskLabel]);

    pData[playerid][pAdoActive] = false;

	if (pData[playerid][LoginTimer])
	{
		KillTimer(pData[playerid][LoginTimer]);
		pData[playerid][LoginTimer] = 0;
	}

	pData[playerid][IsLoggedIn] = false;
	
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 40.0, x, y, z))
		{
			switch(reason)
			{
				case 0:
				{
					SendClientMessageEx(ii, COLOR_RED, "[SERVER]"YELLOW_E" %s(%d) telah keluar dari Server.{7fffd4}(FC/Crash/Timeout)", pData[playerid][pName], playerid);
				}
				case 1:
				{
					SendClientMessageEx(ii, COLOR_RED, "[SERVER]"YELLOW_E" %s(%d) telah keluar dari Server.{7fffd4}(Disconnected)", pData[playerid][pName], playerid);
				}
				case 2:
				{
					SendClientMessageEx(ii, COLOR_RED, "[SERVER]"YELLOW_E" %s(%d) telah keluar dari Server.{7fffd4}(Kick/Banned)", pData[playerid][pName], playerid);
				}
			}
		}
	}
	ResetVariables(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(CharacterState[playerid] == false)
	{
		StopAudioStreamForPlayer(playerid);
		SetPlayerInterior(playerid, pData[playerid][pInt]);
		SetPlayerVirtualWorld(playerid, pData[playerid][pWorld]);
		SetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
		SetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, 0);
		SetPlayerSpawn(playerid);
		LoadAnims(playerid);
		
		SetPlayerSkillLevel(playerid, WEAPON_SILENCED, 1);
		SetPlayerSkillLevel(playerid, WEAPON_DEAGLE, pData[playerid][pSkillWeapon][2]);
		SetPlayerSkillLevel(playerid, WEAPON_SHOTGUN, pData[playerid][pSkillWeapon][1]);
		SetPlayerSkillLevel(playerid, WEAPON_SAWEDOFF, 1);
		SetPlayerSkillLevel(playerid, WEAPON_SHOTGSPA, 1);
		SetPlayerSkillLevel(playerid, WEAPON_UZI, 1);
		SetPlayerSkillLevel(playerid, WEAPON_MP5, pData[playerid][pSkillWeapon][3]);
		SetPlayerSkillLevel(playerid, WEAPON_AK47, pData[playerid][pSkillWeapon][4]);
		SetPlayerSkillLevel(playerid, WEAPON_M4, 1);
		SetPlayerSkillLevel(playerid, WEAPON_TEC9, 1);
		SetPlayerSkillLevel(playerid, WEAPON_RIFLE, pData[playerid][pSkillWeapon][0]);
		SetPlayerSkillLevel(playerid, WEAPON_SNIPER, 1);
	}
	else if(CharacterState[playerid] == true)
	{
		TogglePlayerControllable(playerid, 0);
	}
	return 1;
}

SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(pData[playerid][pGender] == 0)
		{
			TogglePlayerControllable(playerid,0);
			SetPlayerHealth(playerid, 100.0);
			SetPlayerArmour(playerid, 0.0);
			SetPlayerPos(playerid, 1716.1129, -1880.0715, -10.0);
			SetPlayerVirtualWorld(playerid, 0);
			ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir\n(Tgl/Bulan/Tahun)\nMisal : 15/04/1998", "Enter", "Batal");
		}
		else
		{	
			SetPlayerColor(playerid, COLOR_WHITE);

			if(pData[playerid][pHBEMode] == 1) //simple
			{
				forex(ui, 5)
				{
					PlayerTextDrawShow(playerid, Entry_HUD[playerid][ui]);
				}
			}
			if(pData[playerid][pHBEMode] == 2) //modern
			{
				forex(ui, 6)
				{
					PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][ui]);
				}
			}
			
			TextDrawShowForPlayer(playerid, NorthLogo[0]);
			TextDrawShowForPlayer(playerid, NorthLogo[1]);
			TextDrawShowForPlayer(playerid, NorthLogo[2]);

			TextDrawShowForPlayer(playerid, TextDate);
			TextDrawShowForPlayer(playerid, TextTime);
			//PlayerTextDrawShow(playerid, GTAIDNAME[0][playerid]);
			//PlayerTextDrawShow(playerid, GTAIDNAME[1][playerid]);

			SetPlayerSkin(playerid, pData[playerid][pSkin]);
			if(pData[playerid][pOnDuty] >= 1)
			{
				SetPlayerSkin(playerid, pData[playerid][pFacSkin]);
				SetFactionColor(playerid);
			}
			if(pData[playerid][pAdminDuty] > 0)
			{
				SetPlayerColor(playerid, COLOR_RED);
			}
			SetTimerEx("SpawnTimer", 6000, false, "i", playerid);
		}
	}
}

function SpawnTimer(playerid)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, pData[playerid][pMoney]);
	SetPlayerScore(playerid, pData[playerid][pLevel]);
	SetPlayerHealth(playerid, pData[playerid][pHealth]);
	SetPlayerArmour(playerid, pData[playerid][pArmour]);
	pData[playerid][pSpawned] = 1;
	TogglePlayerControllable(playerid, 1);
	SetCameraBehindPlayer(playerid);
	AttachPlayerToys(playerid);
	SetWeapons(playerid);
	if(pData[playerid][pJail] > 0)
	{
		JailPlayer(playerid); 
	}
	if(pData[playerid][pArrestTime] > 0)
	{
		SetPlayerArrest(playerid, pData[playerid][pArrest]);
	}
	LoadLunarSystem(playerid);
	LoadPlayerVehicle(playerid);
	return 1;
}


public OnPlayerSelectionMenuResponse(playerid, extraid, response, listitem, modelid)
{
	switch(extraid)
	{
		case SHOP_SKIN_MALE:
		{
			if(response)
			{
				if(GetPVarInt(playerid, "ClothesBuyType") == 1)
				{
					pData[playerid][pSkin] = modelid;
                 	SetPlayerSkin(playerid, modelid);
					Info(playerid, "Anda telah membeli skin "YELLOW"ID %d", modelid);
					SetPVarInt(playerid, "ClothesBuyType", 0);
				}
				else if(GetPVarInt(playerid, "ClothesBuyType") == 2)
				{
					if(pData[playerid][PurchasedClothing] == false) MySQL_CreatePlayerBaju(playerid);
                	bajuData[playerid][baju_model][pData[playerid][clothingSelected]] = modelid;
					Info(playerid, "Anda telah membeli skin "YELLOW"ID %d, "WHITE_E"Cari lemari untuk mengganti baju", modelid);
					SetPVarInt(playerid, "ClothesBuyType", 0);
				}
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][0];
				GivePlayerMoneyEx(playerid, -price);
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);
				Bisnis_Save(bizid);
			}
		}
		case SHOP_SKIN_FEMALE:
		{
			if(response)
			{
				if(GetPVarInt(playerid, "ClothesBuyType") == 1)
				{
					pData[playerid][pSkin] = modelid;
                 	SetPlayerSkin(playerid, modelid);
					Info(playerid, "Anda telah membeli skin "YELLOW"ID %d", modelid);
					SetPVarInt(playerid, "ClothesBuyType", 0);
				}
				else if(GetPVarInt(playerid, "ClothesBuyType") == 2)
				{
					if(pData[playerid][PurchasedClothing] == false) MySQL_CreatePlayerBaju(playerid);
                	bajuData[playerid][baju_model][pData[playerid][clothingSelected]] = modelid;
					Info(playerid, "Anda telah membeli skin "YELLOW"ID %d, "WHITE_E"Cari lemari untuk mengganti baju", modelid);
					SetPVarInt(playerid, "ClothesBuyType", 0);
				}
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][0];
				GivePlayerMoneyEx(playerid, -price);
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);
				Bisnis_Save(bizid);
			}
		}
		case VIP_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengganti skin ID %d.", ReturnName(playerid), modelid);
				Info(playerid, "Anda telah berhasil mengganti Skin");
			}
		}
		case VIP_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengganti skin ID %d.", ReturnName(playerid), modelid);
				Info(playerid, "Anda telah berhasil membeli pakaian baru");
			}
		}
		case SAPD_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Info(playerid, "Berhasil mengubah Faction Skin");
			}
		}
		case SAPD_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Info(playerid, "Berhasil mengubah Faction Skin");
			}
		}
		case SAPD_SKIN_WAR:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Info(playerid, "Berhasil mengubah Faction Skin");
			}
		}
		case SAGS_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Info(playerid, "Berhasil mengubah Faction Skin");
			}
		}
		case SAGS_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Info(playerid, "Berhasil mengubah Faction Skin");
			}
		}
		case SAMD_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Info(playerid, "Berhasil mengubah Faction Skin");
			}
		}
		case SAMD_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Info(playerid, "Berhasil mengubah Faction Skin");
			}
		}
		case SANA_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Info(playerid, "Berhasil mengubah Faction Skin");
			}
		}
		case SANA_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Info(playerid, "Berhasil mengubah Faction Skin");
			}
		}
		case TOYS_MODEL:
		{
			if(response)
			{
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][1];
				
				GivePlayerMoneyEx(playerid, -price);
				if(pData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
				pToys[playerid][pData[playerid][toySelected]][toy_model] = modelid;

				new finstring[750];
				strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
				strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");
				ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");
				
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s telah membeli aksesoris seharga %s <", ReturnName(playerid), FormatMoney(price));
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET prod='%d', money='%d' WHERE ID='%d'", bData[bizid][bProd], bData[bizid][bMoney], bizid);
				mysql_tquery(g_SQL, query);
			}
		}
		case VIPTOYS_MODEL:
		{
			if(response)
			{
				if(pData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
				pToys[playerid][pData[playerid][toySelected]][toy_model] = modelid;

				new finstring[750];
				strcat(finstring, "Spine\nHead\nLeft upper arm\nRight upper arm\nLeft hand\nRight hand\nLeft thigh\nRight tigh\nLeft foot\nRight foot");
				strcat(finstring, "\nRight calf\nLeft calf\nLeft forearm\nRight forearm\nLeft clavicle\nRight clavicle\nNeck\nJaw");
				ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");
				
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengambil object ID %d di locker.", ReturnName(playerid), modelid);
			}
		}
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid) {
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	DeletePVar(playerid, "UsingSprunk");
	SetPVarInt(playerid, "GiveUptime", -1);
	pData[playerid][pSpawned] = 0;
	Player_ResetCutting(playerid);
	Player_RemoveLumber(playerid);
	Player_ResetMining(playerid);
	Player_ResetHarvest(playerid);
	
	//pData[playerid][CarryProduct] = 0;
	
	KillTimer(pData[playerid][pActivity]);
	KillTimer(pData[playerid][pMechanic]);
	//KillTimer(pData[playerid][pProducting]);
	KillTimer(pData[playerid][pCooking]);
	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
	pData[playerid][pActivityTime] = 0;
	
	pData[playerid][pMechDuty] = 0;
	pData[playerid][pTaxiDuty] = 0;
	pData[playerid][pMission] = -1;
	
	pData[playerid][pSideJob] = SIDEJOB_NONE;
	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	SetPlayerColor(playerid, COLOR_WHITE);
	RemovePlayerAttachedObject(playerid, 9);
	GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
	/*
	foreach(new ii : Player)
    {
        if(pData[ii][pAdmin] > 0)
        {
            SendDeathMessageToPlayer(ii, killerid, playerid, reason);
        }
    }*/
    if(IsAtEvent[playerid] == 1)
    {
    	SetPlayerPos(playerid, 1474.65, -1736.36, 13.38);
    	SetPlayerVirtualWorld(playerid, 0);
    	SetPlayerInterior(playerid, 0);
    	ClearAnimations(playerid);
    	ResetPlayerWeaponsEx(playerid);
       	SetPlayerColor(playerid, COLOR_WHITE);
    	if(GetPlayerTeam(playerid) == 1)
    	{
    		Servers(playerid, "Anda sudah terkalahkan");
    		RedTeam -= 1;
    	}
    	else if(GetPlayerTeam(playerid) == 2)
    	{
    		Servers(playerid, "Anda sudah terkalahkan");
    		BlueTeam -= 1;
    	}
    	if(BlueTeam == 0)
    	{
    		foreach(new ii : Player)
    		{
    			if(GetPlayerTeam(ii) == 1)
    			{
    				GivePlayerMoneyEx(ii, EventPrize);
    				Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    			else if(GetPlayerTeam(ii) == 2)
    			{
    				Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    		}
    	}
    	if(RedTeam == 0)
    	{
    		foreach(new ii : Player)
    		{
    			if(GetPlayerTeam(ii) == 2)
    			{
    				GivePlayerMoneyEx(ii, EventPrize);
    				Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    			else if(GetPlayerTeam(ii) == 1)
    			{
    				Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				RedTeam = 0;
    			}
    		}
    	}
    	SetPlayerTeam(playerid, 0);
    	IsAtEvent[playerid] = 0;
    	pData[playerid][pInjured] = 0;
    	pData[playerid][pSpawned] = 1;
    }
    if(IsAtEvent[playerid] == 0)
    {
    	new asakit = RandomEx(0, 5);
    	new bsakit = RandomEx(0, 9);
    	new csakit = RandomEx(0, 7);
    	new dsakit = RandomEx(0, 6);
    	pData[playerid][pLFoot] -= dsakit;
    	pData[playerid][pLHand] -= bsakit;
    	pData[playerid][pRFoot] -= csakit;
    	pData[playerid][pRHand] -= dsakit;
    	pData[playerid][pHead] -= asakit;
    }
	return 1;
}

public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z) {

    if (pData[playerid][pEditHouseStructure] != -1) {
        new houseid = pData[playerid][pEditHouseStructure];

        foreach (new i : HouseStruct[houseid]) {
            if (HouseStructure[houseid][i][structureObject] == objectid) {
                switch (SelectStructureType[playerid]) {
                    case STRUCTURE_SELECT_EDITOR: {
                        if (HouseStructure[houseid][i][structureType] == 0) {
                            pData[playerid][pEditStructure] = i;
                            EditDynamicObject(playerid, HouseStructure[houseid][i][structureObject]);
                            Custom(playerid, "HOUSE", "You're now editing %s.", GetStructureNameByModel(HouseStructure[houseid][i][structureModel]));
                            break;
                        }
                    }
                    case STRUCTURE_SELECT_RETEXTURE: {
                        SetPVarInt(playerid, "structureObj", i);
                        CancelEdit(playerid);
                        Dialog_Show(playerid, House_StructureRetexture, DIALOG_STYLE_INPUT, "Retexture House Structure", "Please input the texture name below:\n"YELLOW"[model] [txdname] [texture] [opt: alpha] [opt: red] [opt: green] [opt: blue]", "Retexture", "Cancel");
                        break;
                    }
                    case STRUCTURE_SELECT_DELETE: {
                        if (HouseStructure[houseid][i][structureType] == 0) {
                            Custom(playerid, "HOUSE", "You've been successfully deleted %s", GetStructureNameByModel(HouseStructure[houseid][i][structureModel]));
                            HouseStructure_Delete(i, houseid);
                            break;
                        }
                    }
                    case STRUCTURE_SELECT_COPY: {
                        if (HouseStructure[houseid][i][structureType] == 0) {
                            new price;

                            for (new id = 0; id < sizeof(g_aHouseStructure); id ++) if (g_aHouseStructure[id][e_StructureModel] == HouseStructure[houseid][i][structureModel]) {
                                price = g_aHouseStructure[id][e_StructureCost];
                            }

                            if (Inventory_Count(playerid, "Component") < price)
                                return Error(playerid, "You need %d Component(s) to copy this structure.", price);

                            new copyId = HouseStructure_CopyObject(i, houseid);

                            if (copyId == cellmin)
                                return Error(playerid, "Your house has reached maximum of structure");

                            Inventory_Remove(playerid, "Component", price);
                            pData[playerid][pEditStructure] = copyId;
                            pData[playerid][pEditHouseStructure] = houseid;
                            EditDynamicObject(playerid, HouseStructure[houseid][copyId][structureObject]);
                            Custom(playerid, "HOUSE", "You have copied structure for "GREEN"%d component(s)", price);
                            Custom(playerid, "HOUSE", "You're now editing copied object of %s.", GetStructureNameByModel(HouseStructure[houseid][i][structureModel]));
                            break;
                        }
                    }
                }
                break;
            }
        }
    }
	if (pData[playerid][pEditFurnHouse] != -1) {
        new houseid = pData[playerid][pEditFurnHouse];

        foreach (new furnitureid : HouseFurnitures[houseid]) if (objectid == FurnitureData[houseid][furnitureid][furnitureObject]) {
            switch (SelectFurnitureType[playerid]) {
                case FURNITURE_SELECT_MOVE: {
                    pData[playerid][pEditFurniture] = furnitureid;
                    EditDynamicObject(playerid, FurnitureData[houseid][furnitureid][furnitureObject]);
                    Custom(playerid, "HOUSE", "You are now editing the position of item \"%s\".", FurnitureData[houseid][furnitureid][furnitureName]);
                    break;
                }
                case FURNITURE_SELECT_DESTROY:
                {
                    Custom(playerid, "HOUSE", "You have destroyed furniture \"%s\".", FurnitureData[houseid][furnitureid][furnitureName]);
                    Furniture_Delete(furnitureid, houseid);

                    CancelEdit(playerid);
                    pData[playerid][pEditFurniture] = -1;
                    pData[playerid][pEditFurnHouse] = -1;
                    break;
                }
                case FURNITURE_SELECT_STORE: {
                    if (FurnitureData[houseid][furnitureid][furnitureUnused])
                        return Error(playerid, "This furniture is already stored"), CancelEdit(playerid);
                    
                    FurnitureData[houseid][furnitureid][furnitureUnused] = 1;
                    Furniture_Refresh(furnitureid, houseid);
                    Furniture_Save(furnitureid, houseid);
                    Custom(playerid, "HOUSE", "You have stored furniture \"%s"WHITE"\" into your house.", FurnitureData[houseid][furnitureid][furnitureName]);
                    break;
                }
            }
            break;
        }
    }
    return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ,Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	new weaponid = EditingWeapon[playerid];
    if(weaponid)
    {
        if(response == 1)
        {
            new enum_index = weaponid - 22, weaponname[18], string[340];
 
            GetWeaponName(weaponid, weaponname, sizeof(weaponname));
           
            WeaponSettings[playerid][enum_index][Position][0] = fOffsetX;
            WeaponSettings[playerid][enum_index][Position][1] = fOffsetY;
            WeaponSettings[playerid][enum_index][Position][2] = fOffsetZ;
            WeaponSettings[playerid][enum_index][Position][3] = fRotX;
            WeaponSettings[playerid][enum_index][Position][4] = fRotY;
            WeaponSettings[playerid][enum_index][Position][5] = fRotZ;
 
            RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
            SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
 
            Servers(playerid, "You have successfully adjusted the position of your %s.", weaponname);
           
            mysql_format(g_SQL, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, PosX, PosY, PosZ, RotX, RotY, RotZ) VALUES ('%d', %d, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f) ON DUPLICATE KEY UPDATE PosX = VALUES(PosX), PosY = VALUES(PosY), PosZ = VALUES(PosZ), RotX = VALUES(RotX), RotY = VALUES(RotY), RotZ = VALUES(RotZ)", pData[playerid][pID], weaponid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
            mysql_tquery(g_SQL, string);
        }
		else if(response == 0)
		{
			new enum_index = weaponid - 22;
			SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
		}
        EditingWeapon[playerid] = 0;
		return 1;
    }
	else
	{
		if(response == 1)
		{
			GameTextForPlayer(playerid, "~g~~h~Toy Position Updated~y~!", 4000, 5);

			pToys[playerid][index][toy_x] = fOffsetX;
			pToys[playerid][index][toy_y] = fOffsetY;
			pToys[playerid][index][toy_z] = fOffsetZ;
			pToys[playerid][index][toy_rx] = fRotX;
			pToys[playerid][index][toy_ry] = fRotY;
			pToys[playerid][index][toy_rz] = fRotZ;
			pToys[playerid][index][toy_sx] = fScaleX;
			pToys[playerid][index][toy_sy] = fScaleY;
			pToys[playerid][index][toy_sz] = fScaleZ;
			
			MySQL_SavePlayerToys(playerid);
		}
		else if(response == 0)
		{
			GameTextForPlayer(playerid, "~r~~h~Selection Cancelled~y~!", 4000, 5);

			SetPlayerAttachedObject(playerid,
				index,
				modelid,
				boneid,
				pToys[playerid][index][toy_x],
				pToys[playerid][index][toy_y],
				pToys[playerid][index][toy_z],
				pToys[playerid][index][toy_rx],
				pToys[playerid][index][toy_ry],
				pToys[playerid][index][toy_rz],
				pToys[playerid][index][toy_sx],
				pToys[playerid][index][toy_sy],
				pToys[playerid][index][toy_sz]);
		}
		SetPVarInt(playerid, "UpdatedToy", 1);
		TogglePlayerControllable(playerid, true);
	}
	return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT: objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new Float:position[3], Float:rotation[3];

	if(pData[playerid][pEditFurniture] != -1)
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			new id = House_Inside(playerid);
			if(id != -1 && (Player_OwnsHouse(playerid, id) || hData[id][houseBuilder] == pData[playerid][pID]))
			{
				if (Iter_Contains(HouseFurnitures[id], pData[playerid][pEditFurniture])) {
					FurnitureData[id][pData[playerid][pEditFurniture]][furniturePos][0] = x;
					FurnitureData[id][pData[playerid][pEditFurniture]][furniturePos][1] = y;
					FurnitureData[id][pData[playerid][pEditFurniture]][furniturePos][2] = z;
					FurnitureData[id][pData[playerid][pEditFurniture]][furnitureRot][0] = rx;
					FurnitureData[id][pData[playerid][pEditFurniture]][furnitureRot][1] = ry;
					FurnitureData[id][pData[playerid][pEditFurniture]][furnitureRot][2] = rz;
					
					SetDynamicObjectPos(objectid,x,y,z);
					SetDynamicObjectRot(objectid,rx,ry,rz);
					Furniture_Refresh(pData[playerid][pEditFurniture], id);
					Furniture_Save(pData[playerid][pEditFurniture], id);

					Custom(playerid, "HOUSE", "You have edited the position of item \"%s\".", FurnitureData[id][pData[playerid][pEditFurniture]][furnitureName]);

					pData[playerid][pEditFurniture] = -1;
					pData[playerid][pEditFurnHouse] = -1;
				}
			}
		}
		if(response == EDIT_RESPONSE_CANCEL)
		{
			new slot = pData[playerid][pEditFurniture], houseid = House_Inside(playerid);

			if (houseid != -1 && Iter_Contains(HouseFurnitures[houseid], slot)) {
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_X,position[0]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_Y,position[1]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_Z,position[2]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_R_X,rotation[0]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_R_Y,rotation[1]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,FurnitureData[houseid][slot][furnitureObject],E_STREAMER_R_Z,rotation[2]);
				SetDynamicObjectPos(objectid,position[0],position[1],position[2]);
				SetDynamicObjectRot(objectid,rotation[0],rotation[1],rotation[2]);
			}
		}
	}
	if (pData[playerid][pEditStructure] != -1) 
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			new houseid = pData[playerid][pInHouse], id = pData[playerid][pEditStructure];

			if (houseid != -1) {
				if (Iter_Contains(HouseStruct[houseid], id)) {
					HouseStructure[houseid][id][structurePos][0] = x;
					HouseStructure[houseid][id][structurePos][1] = y;
					HouseStructure[houseid][id][structurePos][2] = z;
					HouseStructure[houseid][id][structureRot][0] = rx;
					HouseStructure[houseid][id][structureRot][1] = ry;
					HouseStructure[houseid][id][structureRot][2] = rz;

					SetDynamicObjectPos(objectid, x, y, z);
					SetDynamicObjectRot(objectid, rx, ry, rz);
					HouseStructure_Refresh(id, houseid);
					HouseStructure_Save(id, houseid);

					Custom(playerid, "HOUSE", "Structure position has been saved.");

					pData[playerid][pEditHouseStructure] = -1;
					pData[playerid][pEditStructure] = -1;
				}
			}
		}
		if(response == EDIT_RESPONSE_CANCEL)
		{
			new slot = pData[playerid][pEditStructure], houseid = pData[playerid][pEditHouseStructure];

			if (houseid != -1) {
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_X,position[0]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_Y,position[1]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_Z,position[2]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_R_X,rotation[0]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_R_Y,rotation[1]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,HouseStructure[houseid][slot][structureObject],E_STREAMER_R_Z,rotation[2]);
				SetDynamicObjectPos(objectid,position[0],position[1],position[2]);
				SetDynamicObjectRot(objectid,rotation[0],rotation[1],rotation[2]);

				pData[playerid][pEditHouseStructure] = -1;
				pData[playerid][pEditStructure] = -1;
			}
		}
	}
	if (pData[playerid][pEditSpeed] != -1 && SpeedData[pData[playerid][pEditSpeed]][speedExists]) 
	{
		if(response == EDIT_RESPONSE_FINAL)
		{	
			new id = pData[playerid][pEditSpeed];
			SpeedData[id][speedPos][0] = x;
			SpeedData[id][speedPos][1] = y;
			SpeedData[id][speedPos][2] = z;
			SpeedData[id][speedPos][3] = rz;
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
			
			Speed_Refresh(id);
			Speed_Save(id);
			Custom(playerid, "SPEEDCAM", "Speed camera position has been saved.");
			pData[playerid][pEditSpeed] = -1;
		}
		if(response == EDIT_RESPONSE_CANCEL)
		{
			if(pData[playerid][pEditSpeed] != -1) 
			{
				new slot = pData[playerid][pEditSpeed];

				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,SpeedData[slot][speedObject],E_STREAMER_X,position[0]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,SpeedData[slot][speedObject],E_STREAMER_Y,position[1]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,SpeedData[slot][speedObject],E_STREAMER_Z,position[2]);
				Streamer_GetFloatData(STREAMER_TYPE_OBJECT,SpeedData[slot][speedObject],E_STREAMER_R_Z,rotation[2]);
				SetDynamicObjectPos(objectid,position[0],position[1],position[2]);
				SetDynamicObjectRot(objectid,rotation[0],rotation[1],rotation[2]);
				pData[playerid][pEditSpeed] = -1;
			}
		}
	}
	if(pData[playerid][EditingTreeID] != -1 && Iter_Contains(Trees, pData[playerid][EditingTreeID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingTreeID];
	        TreeData[etid][treeX] = x;
	        TreeData[etid][treeY] = y;
	        TreeData[etid][treeZ] = z;
	        TreeData[etid][treeRX] = rx;
	        TreeData[etid][treeRY] = ry;
	        TreeData[etid][treeRZ] = rz;

	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_X, TreeData[etid][treeX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Y, TreeData[etid][treeY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Z, TreeData[etid][treeZ] + 1.5);

		    Tree_Save(etid);
	        pData[playerid][EditingTreeID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingTreeID];
	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);
	        pData[playerid][EditingTreeID] = -1;
	    }
	}
	if(pData[playerid][EditingOreID] != -1 && Iter_Contains(Ores, pData[playerid][EditingOreID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingOreID];
	        OreData[etid][oreX] = x;
	        OreData[etid][oreY] = y;
	        OreData[etid][oreZ] = z;
	        OreData[etid][oreRX] = rx;
	        OreData[etid][oreRY] = ry;
	        OreData[etid][oreRZ] = rz;

	        SetDynamicObjectPos(objectid, OreData[etid][oreX], OreData[etid][oreY], OreData[etid][oreZ]);
	        SetDynamicObjectRot(objectid, OreData[etid][oreRX], OreData[etid][oreRY], OreData[etid][oreRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_X, OreData[etid][oreX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_Y, OreData[etid][oreY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_Z, OreData[etid][oreZ] + 1.5);

		    Ore_Save(etid);
	        pData[playerid][EditingOreID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingOreID];
	        SetDynamicObjectPos(objectid, OreData[etid][oreX], OreData[etid][oreY], OreData[etid][oreZ]);
	        SetDynamicObjectRot(objectid, OreData[etid][oreRX], OreData[etid][oreRY], OreData[etid][oreRZ]);
	        pData[playerid][EditingOreID] = -1;
	    }
	}
	if(pData[playerid][EditingATMID] != -1 && Iter_Contains(ATMS, pData[playerid][EditingATMID]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingATMID];
	        AtmData[etid][atmX] = x;
	        AtmData[etid][atmY] = y;
	        AtmData[etid][atmZ] = z;
	        AtmData[etid][atmRX] = rx;
	        AtmData[etid][atmRY] = ry;
	        AtmData[etid][atmRZ] = rz;

	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_X, AtmData[etid][atmX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Y, AtmData[etid][atmY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Z, AtmData[etid][atmZ] + 0.3);

		    Atm_Save(etid);
	        pData[playerid][EditingATMID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingATMID];
	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);
	        pData[playerid][EditingATMID] = -1;
	    }
	}
	if(pData[playerid][gEditID] != -1 && Iter_Contains(Gates, pData[playerid][gEditID]))
	{
		new id = pData[playerid][gEditID];
		if(response == EDIT_RESPONSE_UPDATE)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			SetDynamicObjectPos(objectid, gPosX[playerid], gPosY[playerid], gPosZ[playerid]);
			SetDynamicObjectRot(objectid, gRotX[playerid], gRotY[playerid], gRotZ[playerid]);
			gPosX[playerid] = 0; gPosY[playerid] = 0; gPosZ[playerid] = 0;
			gRotX[playerid] = 0; gRotY[playerid] = 0; gRotZ[playerid] = 0;
			Servers(playerid, " You have canceled editing gate ID %d.", id);
			Gate_Save(id);
		}
		else if(response == EDIT_RESPONSE_FINAL)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
			if(pData[playerid][gEdit] == 1)
			{
				gData[id][gCX] = x;
				gData[id][gCY] = y;
				gData[id][gCZ] = z;
				gData[id][gCRX] = rx;
				gData[id][gCRY] = ry;
				gData[id][gCRZ] = rz;
				if(IsValidDynamic3DTextLabel(gData[id][gText])) DestroyDynamic3DTextLabel(gData[id][gText]);
				new str[64];
				format(str, sizeof(str), "Gate ID: %d", id);
				gData[id][gText] = CreateDynamic3DTextLabel(str, COLOR_WHITE, gData[id][gCX], gData[id][gCY], gData[id][gCZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 10.0);
				
				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's closing position.", id);
				gData[id][gStatus] = 0;
				Gate_Save(id);
			}
			else if(pData[playerid][gEdit] == 2)
			{
				gData[id][gOX] = x;
				gData[id][gOY] = y;
				gData[id][gOZ] = z;
				gData[id][gORX] = rx;
				gData[id][gORY] = ry;
				gData[id][gORZ] = rz;
				
				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's opening position.", id);

				gData[id][gStatus] = 1;
				Gate_Save(id);
			}
		}
	}
	return 1;
}

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if(areaid == production && startProduce[playerid] && GetPVarInt(playerid, "lagiedit") == 0)
	{
		InfoTD_MSG(playerid, 3000, "Posisikan furniture pada area kerja");

		PlayerEditPoint(playerid, 1489.54, 1789.14, 10.90, 0.0, 0.0, 0.0, "editLokasiFurn", produceObject[playerid]);
		SetPVarInt(playerid, "lagiedit", 1);
	}
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	foreach(new fid : FurnStore) if(checkpointid == storeData[fid][storeCP]) GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR ~r~F~n~~w~TO ENTER/EXIT", 3000, 4);
	foreach(new bid : Bisnis) if(checkpointid == bData[bid][bCP][0] || checkpointid == bData[bid][bCP][1]) GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR ~r~F~n~~w~TO ENTER/EXIT", 3000, 4);
	foreach(new did : Doors) if(checkpointid == dData[did][dCP][0] || checkpointid == dData[did][dCP][1]) GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR ~r~F~n~~w~TO ENTER/EXIT", 3000, 4);
	foreach(new atm : ATMS) if(checkpointid == AtmData[atm][atmCP]) GameTextForPlayer(playerid, "~p~ATM MACHINE~n~~w~USE '~y~/ATM~w~' TO USE ATM", 3000, 4);
	foreach(new houseid : Houses)
	{
		new rada = 50;
		if(checkpointid == hData[houseid][hCPExt])
		{
			GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR ~r~F~n~~w~TO ENTER/EXIT", 3000, 4);
			if(pData[playerid][pSideJob] == SIDEJOB_COURIER && CourierCrate[playerid] == 2) 
			{
				for(new id = 0; id < 10; id++)
				{
					if(CourierID[playerid][id] == houseid) 
					{
						RemovePlayerAttachedObject(playerid, 9);
						CourierStatus[playerid][id] = true;
						CourierID[playerid][id] = -1;
						ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0 ,0,0,0,0,1);
						CourierCount[playerid]++;
						Custom(playerid, "COURIER", "Delivered "GREEN"%d {ffffff}out of {ffff00}10", CourierCount[playerid]);
						RemovePlayerMapIcon(playerid, rada+id);
						SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
						if(CourierCount[playerid] == 10)
						{
							Custom(playerid, "COURIER", "Delivered all crates, {ffffff}Please return the delivery vehicle back to the warehouse!");
							Custom(playerid, "COURIER", "You've delivered 10 packages, please return the delivery vehicle now!");
							SetPlayerRaceCheckpoint(playerid, 1, 1778.1998,-1693.6936,13.4569, 0.0, 0.0, 0.0, 5.0);
							for(new i; i < 10; i++)
							{
								RemovePlayerMapIcon(playerid, rada+i);
							}
						}
					}
				}
			}
		}
		if(checkpointid == hData[houseid][hCPInt])
		{
			GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER~w~ OR ~r~F~n~~w~TO ENTER/EXIT", 3000, 4);
		}
	}
	if(checkpointid == pData[playerid][LoadingPoint])
	{
	    if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID"), type[64], carid = -1;
		if(pData[playerid][CarryingLog] == 0)
		{
			type = "Metal";
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			type = "Coal";
		}
		else
		{
			type = "Unknown";
		}
		if(Vehicle_LogCount(vehicleid) >= LOG_LIMIT) return Error(playerid, "You can't load any more ores to this vehicle.");
		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(pData[playerid][CarryingLog] == 0)
			{
				pvData[carid][cMetal] += 1;
			}
			else if(pData[playerid][CarryingLog] == 1)
			{
				pvData[carid][cCoal] += 1;
			}
		}
		LogStorage[vehicleid][ pData[playerid][CarryingLog] ]++;
		Custom(playerid, "MINING", "Loaded "YELLOW"%s.", type);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		Player_RemoveLog(playerid);
		return 1;
	}
	if(checkpointid == ShowRoomCP)
	{
		ShowPlayerDialog(playerid, DIALOG_BUYPVCP, DIALOG_STYLE_LIST, "{7fffd4}Basic Showroom", "Motorcycle\nMobil\nKendaraan Unik\nKendaraan Job", "Select", "Cancel");
	}
	if(checkpointid == ShowRoomCPRent)
	{
		new str[1024];
		format(str, sizeof(str), "Kendaraan\tHarga\n"WHITE_E"%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days",
		GetVehicleModelName(414), 
		GetVehicleModelName(455), 
		GetVehicleModelName(456),
		GetVehicleModelName(498),
		GetVehicleModelName(499),
		GetVehicleModelName(609),
		GetVehicleModelName(478),
		GetVehicleModelName(422),
		GetVehicleModelName(543),
		GetVehicleModelName(554),
		GetVehicleModelName(525),
		GetVehicleModelName(438),
		GetVehicleModelName(420)
		);
		
		ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARS, DIALOG_STYLE_TABLIST_HEADERS, "Rent Job Cars", str, "Rent", "Close");
	}
	foreach(new pid : Plants) if(Iter_Contains(Plants, pid))
	{
		if(checkpointid == PlantData[pid][PlantCP])
		{
			new type[24], mstr[128];
			if(PlantData[pid][PlantType] == 1)
			{
				type = "Potato";
			}
			else if(PlantData[pid][PlantType] == 2)
			{
				type = "Wheat";
			}
			else if(PlantData[pid][PlantType] == 3)
			{
				type = "Orange";
			}
			else if(PlantData[pid][PlantType] == 4)
			{
				type = "Marijuana";
			}
			if(PlantData[pid][PlantTime] > 1)
			{
				format(mstr, sizeof(mstr), "~w~Plant Type: ~g~%s ~n~~w~Plant Time: ~r~%s", type, ConvertToMinutes(PlantData[pid][PlantTime]));
				InfoTD_MSG(playerid, 1000, mstr);
			}
			else
			{
				format(mstr, sizeof(mstr), "~w~Plant Type: ~g~%s ~n~~w~Plant Time: ~g~Now", type);
				InfoTD_MSG(playerid, 1000, mstr);
			}
		}
	}
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(pData[playerid][pSideJob] == SIDEJOB_PIZZA && pizzaTakeStatus[playerid] == true && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) 
	{
		if(pizzaDelivered[playerid] == 10) return 1;

		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		SetPlayerAttachedObject(playerid, 9, 2814, 1, 0.083000, 0.297000, -0.029000, -91.200042, 32.800014, 0.000000, 1.000000, 1.000000, 1.000000, 0, 0);
		pizzaHoldingBox[playerid] = true;
		pizzaTakeStatus[playerid] = false;

		Info(playerid, "Gunakan "YELLOW"/cancelbox "WHITE"untuk menaruh/membuang box anda");

		PlayerPlaySound(playerid, 40405, 0.0, 0.0, 0.0);
		ApplyAnimation(playerid, "CARRY", "liftup105", 4.1, false, false, false, false, 0, true);
	}
	if(pData[playerid][pSideJob] == SIDEJOB_COURIER && CourierCrate[playerid] == 1 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		CourierCrate[playerid] = 2;
		DisablePlayerRaceCheckpoint(playerid);
		Info(playerid, "Gunakan "YELLOW"/cancelbox "WHITE"untuk menaruh/membuang box anda");
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
		SetPlayerAttachedObject(playerid, 9, 1220, 1, 0.002953, 0.469660, -0.009797, 269.851104, 34.443557, 0.000000, 0.804894, 0.800000, 0.822361 );
	}
	if(pData[playerid][pSideJob] == SIDEJOB_COURIER && CourierCount[playerid] == 10 && IsACourierVeh(GetPlayerVehicleID(playerid)) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
		AddPlayerSalary(playerid, "(Courier) Delivered 10 packages", 650);	
       	Custom(playerid, "COURIER", "Courier sidejob completed, "GREEN"$650 {ffffff}has been issued for your next paycheck");
        Custom(playerid, "SALARY", "Your salary statement has been updated, please check command {ffff00}'/salary'");
        TimerCourier[playerid] = 0;
        pData[playerid][pSideJob] = SIDEJOB_NONE;
        CourierCount[playerid] = 0;
        RemovePlayerFromVehicle(playerid);
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		pData[playerid][pCourierTime] = 3600;
		PlayerPlaySound(playerid, 183, 0.0, 0.0, 0.0);
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackCar] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan kendaraan anda!");
		pData[playerid][pTrackCar] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackHouse] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan rumah anda!");
		pData[playerid][pTrackHouse] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackBisnis] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan bisnis anda!");
		pData[playerid][pTrackBisnis] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackDestination] == 1)
	{
		Info(playerid, "Anda berhasil menemukan destinasi anda!");
		pData[playerid][pTrackDestination] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{

	if(pData[playerid][CarryingLog] != -1)
	{
		if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID"), type[64], carid = -1;
		if(pData[playerid][CarryingLog] == 0)
		{
			type = "Metal";
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			type = "Coal";
		}
		else
		{
			type = "Unknown";
		}
		if(Vehicle_LogCount(vehicleid) >= LOG_LIMIT) return Error(playerid, "You can't load any more ores to this vehicle.");
		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(pData[playerid][CarryingLog] == 0)
			{
				pvData[carid][cMetal] += 1;
			}
			else if(pData[playerid][CarryingLog] == 1)
			{
				pvData[carid][cCoal] += 1;
			}
		}
		LogStorage[vehicleid][ pData[playerid][CarryingLog] ]++;
		Custom(playerid, "MINING", "Loaded "YELLOW"%s.", type);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		Player_RemoveLog(playerid);
		DisablePlayerCheckpoint(playerid);
		return 1;
	}
	if(pData[playerid][pFindEms] != INVALID_PLAYER_ID)
	{
		pData[playerid][pFindEms] = INVALID_PLAYER_ID;
		DisablePlayerCheckpoint(playerid);
	}
	/*
	if(pData[playerid][pSideJob] == 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 574)
		{
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint1))
			{
				SetPlayerCheckpoint(playerid, sweperpoint2, 7.0);
				//GameTextForPlayer(playerid, "~g~Bersih!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint2))
			{
				SetPlayerCheckpoint(playerid, sweperpoint3, 7.0);
				//GameTextForPlayer(playerid, "~g~Bersih!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint3))
			{
				SetPlayerCheckpoint(playerid, sweperpoint4, 7.0);
				//GameTextForPlayer(playerid, "~g~Bersih!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint4))
			{
				SetPlayerCheckpoint(playerid, sweperpoint5, 7.0);
				//GameTextForPlayer(playerid, "~g~Bersih!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint5))
			{
				SetPlayerCheckpoint(playerid, sweperpoint6, 7.0);
				//GameTextForPlayer(playerid, "~g~Bersih!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint6))
			{
				SetPlayerCheckpoint(playerid, sweperpoint7, 7.0);
				//GameTextForPlayer(playerid, "~g~Bersih!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint7))
			{
				SetPlayerCheckpoint(playerid, sweperpoint8, 7.0);
				//GameTextForPlayer(playerid, "~g~Bersih!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint8))
			{
				SetPlayerCheckpoint(playerid, sweperpoint9, 7.0);
				//GameTextForPlayer(playerid, "~g~Bersih!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint9))
			{
				SetPlayerCheckpoint(playerid, sweperpoint10, 7.0);
				//GameTextForPlayer(playerid, "~g~Bersih!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint10))
			{
				SetPlayerCheckpoint(playerid, sweperpoint11, 7.0);
				//GameTextForPlayer(playerid, "~g~Bersih!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint11))
			{
				SetPlayerCheckpoint(playerid, sweperpoint12, 7.0);
				//GameTextForPlayer(playerid, "~g~Bersih!", 1000, 3);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint12))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pSweeperTime] = 600;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Sidejob(Sweeper)", 150);
				Info(playerid, "Sidejob(Sweeper) telah masuk ke pending salary anda!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}*/
	/*
	if(pData[playerid][pSideJob] == 2)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 431)
		{
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint1))
			{
				SetPlayerCheckpoint(playerid, buspoint2, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint2))
			{
				SetPlayerCheckpoint(playerid, buspoint3, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint3))
			{
				SetPlayerCheckpoint(playerid, buspoint4, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint4))
			{
				SetPlayerCheckpoint(playerid, buspoint5, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint5))
			{
				SetPlayerCheckpoint(playerid, buspoint6, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint6))
			{
				SetPlayerCheckpoint(playerid, buspoint7, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint7))
			{
				SetPlayerCheckpoint(playerid, buspoint8, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint8))
			{
				SetPlayerCheckpoint(playerid, buspoint9, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint9))
			{
				SetPlayerCheckpoint(playerid, buspoint10, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint10))
			{
				SetPlayerCheckpoint(playerid, buspoint11, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint11))
			{
				SetPlayerCheckpoint(playerid, buspoint12, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint12))
			{
				SetPlayerCheckpoint(playerid, buspoint13, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint13))
			{
				SetPlayerCheckpoint(playerid, buspoint14, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint14))
			{
				SetPlayerCheckpoint(playerid, buspoint15, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint15))
			{
				SetPlayerCheckpoint(playerid, buspoint16, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint16))
			{
				SetPlayerCheckpoint(playerid, buspoint17, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint17))
			{
				SetPlayerCheckpoint(playerid, buspoint18, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint18))
			{
				SetPlayerCheckpoint(playerid, buspoint19, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint19))
			{
				SetPlayerCheckpoint(playerid, buspoint20, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint20))
			{
				SetPlayerCheckpoint(playerid, buspoint21, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint21))
			{
				SetPlayerCheckpoint(playerid, buspoint22, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint22))
			{
				SetPlayerCheckpoint(playerid, buspoint23, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint23))
			{
				SetPlayerCheckpoint(playerid, buspoint24, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint24))
			{
				SetPlayerCheckpoint(playerid, buspoint25, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint25))
			{
				SetPlayerCheckpoint(playerid, buspoint26, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint26))
			{
				SetPlayerCheckpoint(playerid, buspoint27, 7.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,buspoint27))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pBusTime] = 360;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Sidejob(Bus)", 200);
				Info(playerid, "Sidejob(Bus) telah masuk ke pending salary anda!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}*/
	if(pData[playerid][pSideJob] == SIDEJOB_FORKLIFT)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 530)
		{
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint1))
			{
				SetPlayerCheckpoint(playerid, 2400.02,-2565.49,13.21, 4.0);
				TogglePlayerControllable(playerid, 0);
				GameTextForPlayer(playerid, "~w~MEMUAT ~g~BARANG...", 5000, 3);
				SetTimerEx("JobForklift", 3000, false, "i", playerid);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint2))
			{
				SetPlayerCheckpoint(playerid, 2752.89,-2392.60,13.64, 4.0);
				TogglePlayerControllable(playerid, 0);
				GameTextForPlayer(playerid, "~w~MELETAKKAN ~g~BARANG...", 5000, 3);
				SetTimerEx("JobForklift", 3000, false, "i", playerid);
				return 1;
			}
			if(IsPlayerInRangeOfPoint(playerid, 4.0,forpoint3))
			{
				pData[playerid][pSideJob] = SIDEJOB_NONE;
				pData[playerid][pForkliftTime] = 80;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Sidejob(Forklift)", 70);
				Info(playerid, "Sidejob(Forklift) telah masuk ke pending salary anda!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
				return 1;
			}
		}
	}
	//DisablePlayerCheckpoint(playerid);
	return 1;
}

forward JobForklift(playerid);
public JobForklift(playerid)
{
	TogglePlayerControllable(playerid, 1);
	GameTextForPlayer(playerid, "~w~SELESAI!", 5000, 3);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_LOOK_BEHIND))
	{
		static
			carid = -1;

		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(Vehicle_IsOwner(playerid, carid))
			{
				if(!pvData[carid][cLocked])
				{
					pvData[carid][cLocked] = 1;
					InfoTD_MSG(playerid, 3000, "Vehicle ~r~Locked");
					PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
					SwitchVehicleDoors(pvData[carid][cVeh], true);
				}
				else
				{
					pvData[carid][cLocked] = 0;
					InfoTD_MSG(playerid, 3000, "Vehicle ~g~Unlocked");
					PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
					SwitchVehicleDoors(pvData[carid][cVeh], false);
				}
			}
		}
	}
	if(PRESSED(KEY_CROUCH) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		/*
		new park = -1;
		park = GetClosestParks(playerid);
		
		if(park > -1)
		{
			if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Kamu harus login!");
			if(pData[playerid][pInjured] >= 1) return Error(playerid, "Kamu tidak bisa melakukan ini!");
			if(!IsPlayerInAnyVehicle(playerid)) return Error(playerid, "You must be in Vehicle");

			if(CountParkedVeh(park) >= 40)
				return Error(playerid, "Garasi Kota sudah memenuhi Kapasitas!");

			new carid = -1,
				found = 0;

			if((carid = Vehicle_Nearest2(playerid)) != -1)
			{

				GetVehiclePos(pvData[carid][cVeh], pvData[carid][cPosX], pvData[carid][cPosY], pvData[carid][cPosZ]);
				GetVehicleZAngle(pvData[carid][cVeh], pvData[carid][cPosA]);
				GetVehicleHealth(pvData[carid][cVeh], pvData[carid][cHealth]);
				RemovePlayerFromVehicle(playerid);

				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
				pvData[carid][cPark] = park;
				InfoTD_MSG(playerid, 4000, "~y~Kendaraan~n~~w~Terparkir");
				SetPlayerArmedWeapon(playerid, 0);
				found++;
				if(IsValidVehicle(pvData[carid][cVeh]))
				{
					DestroyVehicle(pvData[carid][cVeh]);
					pvData[carid][cVeh] = INVALID_VEHICLE_ID;
				}
			}
			if(!found)
				return Error(playerid, "Kendaraan ini tidak dapat di Park!");
		}*/
		//basement
		foreach(new bmid : Basement)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ]) && GetPlayerVirtualWorld(playerid) == BasementData[bmid][bmExtvw] && GetPlayerInterior(playerid) == BasementData[bmid][bmExtint])
			{
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(BasementData[bmid][bmIntposX] == 0.0 && BasementData[bmid][bmIntposY] == 0.0 && BasementData[bmid][bmIntposZ] == 0.0)
						return Error(playerid, "Basement ini belum memiliki interior!");

					if(BasementData[bmid][bmLocked])
						return Error(playerid, "Basement ini sedang terkunci!");
						
					if(BasementData[bmid][bmFaction] != 0)
					{
						if(BasementData[bmid][bmFaction] != pData[playerid][pFaction])
							return Error(playerid, "Basement ini hanya untuk faction tertentu!");
					}
					if(BasementData[bmid][bmFamily] != 0)
					{
						if(BasementData[bmid][bmFamily] != pData[playerid][pFamily])
							return Error(playerid, "Basement ini hanya untuk family official tertentu!");
					}
					
					if(BasementData[bmid][bmVip] > pData[playerid][pVip])
						return Error(playerid, "Status donasi VIP anda tidak cukup untuk masuk ke pintu ini!");
					
					if(BasementData[bmid][bmAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Anda tidak memiliki level admin yang cukup untuk masuk ke pintu ini!");

					if(strlen(BasementData[bmid][bmPass]))
					{
						new params[256];
						if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
						if(strcmp(params, BasementData[bmid][bmPass])) return Error(playerid, "Kata sandi basement salah!");
						
						SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), BasementData[bmid][bmIntposX], BasementData[bmid][bmIntposY], BasementData[bmid][bmIntposZ], BasementData[bmid][bmIntposA]);
						LinkVehicleToInterior(GetPlayerVehicleID(playerid), BasementData[bmid][bmIntint]);
						SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), BasementData[bmid][bmIntvw]);

						SetPlayerInteriorEx(playerid, BasementData[bmid][bmIntint]);
						SetPlayerVirtualWorldEx(playerid, BasementData[bmid][bmIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);

						if(pData[playerid][pLastCar] != INVALID_VEHICLE_ID)
						{
							foreach(new i : Player)
							{
								if (GetPlayerVehicleID(i) == pData[playerid][pLastCar])
								{
									SetPlayerInteriorEx(i, BasementData[bmid][bmIntint]);
									SetPlayerVirtualWorldEx(i, BasementData[bmid][bmIntvw]);
									SetCameraBehindPlayer(i);
									SetPlayerWeather(i, 0);
								}
							}
						}
					}
					else
					{
						SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), BasementData[bmid][bmIntposX], BasementData[bmid][bmIntposY], BasementData[bmid][bmIntposZ], BasementData[bmid][bmIntposA]);
						LinkVehicleToInterior(GetPlayerVehicleID(playerid), BasementData[bmid][bmIntint]);
						SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), BasementData[bmid][bmIntvw]);
					
						SetPlayerInteriorEx(playerid, BasementData[bmid][bmIntint]);
						SetPlayerVirtualWorldEx(playerid, BasementData[bmid][bmIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);

						if(pData[playerid][pLastCar] != INVALID_VEHICLE_ID)
						{
							foreach(new i : Player)
							{
								if (GetPlayerVehicleID(i) == pData[playerid][pLastCar])
								{
									SetPlayerInteriorEx(i, BasementData[bmid][bmIntint]);
									SetPlayerVirtualWorldEx(i, BasementData[bmid][bmIntvw]);
									SetCameraBehindPlayer(i);
									SetPlayerWeather(i, 0);
								}
							}
						}
					}
				}
			}
			else if(IsPlayerInRangeOfPoint(playerid, 2.8, BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ]) && GetPlayerVirtualWorld(playerid) == BasementData[bmid][bmIntvw] && GetPlayerInterior(playerid) == BasementData[bmid][bmIntint])
			{
				if(BasementData[bmid][bmOutexitX] == 0.0 && BasementData[bmid][bmOutexitY] == 0.0 && BasementData[bmid][bmOutexitZ] == 0.0)
				return Error(playerid, "Basement ini belum memiliki exterior!");
				
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), BasementData[bmid][bmOutexitX], BasementData[bmid][bmOutexitY], BasementData[bmid][bmOutexitZ], BasementData[bmid][bmOutexitA]);
					LinkVehicleToInterior(GetPlayerVehicleID(playerid), BasementData[bmid][bmExtint]);
					SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), BasementData[bmid][bmExtvw]);

					SetPlayerInteriorEx(playerid, BasementData[bmid][bmExtint]);
					SetPlayerVirtualWorldEx(playerid, BasementData[bmid][bmExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);

					if(pData[playerid][pLastCar] != INVALID_VEHICLE_ID)
					{
						foreach(new i : Player)
						{
							if (GetPlayerVehicleID(i) == pData[playerid][pLastCar])
							{
								SetPlayerInteriorEx(i, BasementData[bmid][bmExtint]);
								SetPlayerVirtualWorldEx(i, BasementData[bmid][bmExtvw]);
								SetCameraBehindPlayer(i);
								SetPlayerWeather(i, WorldWeather);
							}
						}
					}
				}
			}
        }
    }
	/*
    if((newkeys & KEY_JUMP) && !IsPlayerInAnyVehicle(playerid))
    {
        AntiBHOP[playerid] ++;
        if(pData[playerid][pRFoot] <= 70 || pData[playerid][pLFoot] <= 70)
        {
        	SetTimerEx("AppuiePasJump", 1700, false, "i", playerid);
        	if(AntiBHOP[playerid] == 2)
        	{
        		ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
        		new jpName[MAX_PLAYER_NAME];
        		GetPlayerName(playerid,jpName,MAX_PLAYER_NAME);
        		SetTimerEx("AppuieJump", 3000, false, "i", playerid);
        	}
        	return 1;
        }
        if(pData[playerid][pRFoot] <= 90 || pData[playerid][pLFoot] <= 90)
        {
        	SetTimerEx("AppuiePasJump", 700, false, "i", playerid);
        	if(AntiBHOP[playerid] == 2)
        	{
        		ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
        		new jpName[MAX_PLAYER_NAME];
        		GetPlayerName(playerid,jpName,MAX_PLAYER_NAME);
        		SetTimerEx("AppuieJump", 3000, false, "i", playerid);
        	}
        	return 1;
        }
        if(pData[playerid][pRFoot] <= 40 || pData[playerid][pLFoot] <= 40)
        {
        	SetTimerEx("AppuiePasJump", 3200, false, "i", playerid);
        	if(AntiBHOP[playerid] == 2)
        	{
        		ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
        		new jpName[MAX_PLAYER_NAME];
        		GetPlayerName(playerid,jpName,MAX_PLAYER_NAME);
        		SetTimerEx("AppuieJump", 3000, false, "i", playerid);
        	}
        	return 1;
        }
    }*/
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && (newkeys & KEY_YES))
	{
	    if(pData[playerid][CarryingLumber])
		{
			Player_DropLumber(playerid);
		}
		else if(pData[playerid][CarryingLog] == 0)
		{
			Player_DropLog(playerid, pData[playerid][CarryingLog]);
			Info(playerid, "You dropping "YELLOW"metal ore.");
			DisablePlayerCheckpoint(playerid);
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			Player_DropLog(playerid, pData[playerid][CarryingLog]);
			Info(playerid, "You dropping "YELLOW"coal ore.");
			DisablePlayerCheckpoint(playerid);
		}
	}
	if((newkeys & KEY_SECONDARY_ATTACK))
    {
		//basement
		foreach(new bmid : Basement)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, BasementData[bmid][bmExtposX], BasementData[bmid][bmExtposY], BasementData[bmid][bmExtposZ]) && GetPlayerVirtualWorld(playerid) == BasementData[bmid][bmExtvw] && GetPlayerInterior(playerid) == BasementData[bmid][bmExtint])
			{
				if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
				{
					if(BasementData[bmid][bmIntposX] == 0.0 && BasementData[bmid][bmIntposY] == 0.0 && BasementData[bmid][bmIntposZ] == 0.0)
						return Error(playerid, "Basement ini belum memiliki interior!");

					if(BasementData[bmid][bmLocked])
						return Error(playerid, "Basement ini sedang terkunci!");
						
					if(BasementData[bmid][bmFaction] != 0)
					{
						if(BasementData[bmid][bmFaction] != pData[playerid][pFaction])
							return Error(playerid, "Basement ini hanya untuk faction tertentu!");
					}
					if(BasementData[bmid][bmFamily] != 0)
					{
						if(BasementData[bmid][bmFamily] != pData[playerid][pFamily])
							return Error(playerid, "Basement ini hanya untuk family official tertentu!");
					}
					
					if(BasementData[bmid][bmVip] > pData[playerid][pVip])
						return Error(playerid, "Status donasi VIP anda tidak cukup untuk masuk ke pintu ini!");
					
					if(BasementData[bmid][bmAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Anda tidak memiliki level admin yang cukup untuk masuk ke pintu ini!");

					if(strlen(BasementData[bmid][bmPass]))
					{
						new params[256];
						if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
						if(strcmp(params, BasementData[bmid][bmPass])) return Error(playerid, "Kata sandi basement salah!");
						
						SetPlayerPositionEx(playerid, BasementData[bmid][bmIntposX], BasementData[bmid][bmIntposY], BasementData[bmid][bmIntposZ], BasementData[bmid][bmIntposA]);
						
						SetPlayerInterior(playerid, BasementData[bmid][bmIntint]);
						SetPlayerVirtualWorld(playerid, BasementData[bmid][bmIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						SetPlayerPositionEx(playerid, BasementData[bmid][bmIntposX], BasementData[bmid][bmIntposY], BasementData[bmid][bmIntposZ], BasementData[bmid][bmIntposA]);
					
						SetPlayerInterior(playerid, BasementData[bmid][bmIntint]);
						SetPlayerVirtualWorld(playerid, BasementData[bmid][bmIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
			}
			else if(IsPlayerInRangeOfPoint(playerid, 2.8, BasementData[bmid][bmInexitX], BasementData[bmid][bmInexitY], BasementData[bmid][bmInexitZ]) && GetPlayerVirtualWorld(playerid) == BasementData[bmid][bmIntvw] && GetPlayerInterior(playerid) == BasementData[bmid][bmIntint])
			{
				if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
				{
					if(BasementData[bmid][bmOutexitX] == 0.0 && BasementData[bmid][bmOutexitY] == 0.0 && BasementData[bmid][bmOutexitZ] == 0.0)
					return Error(playerid, "Basement ini belum memiliki exterior!");

					SetPlayerPositionEx(playerid, BasementData[bmid][bmOutexitX], BasementData[bmid][bmOutexitY], BasementData[bmid][bmOutexitZ], BasementData[bmid][bmOutexitA]);
					
					SetPlayerInterior(playerid, BasementData[bmid][bmExtint]);
					SetPlayerVirtualWorld(playerid, BasementData[bmid][bmExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
				}
			}
		}

		foreach(new did : Doors)
		{
			if(IsValidDynamicCP(dData[did][dCP][0]) && IsPlayerInDynamicCP(playerid, dData[did][dCP][0]))
			{
				if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
					return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

				if(dData[did][dLocked])
					return Error(playerid, "This entrance is locked at the moment.");
					
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return Error(playerid, "This door only for faction.");
				}
				if(dData[did][dFamily] > 0)
				{
					if(dData[did][dFamily] != pData[playerid][pFamily])
						return Error(playerid, "This door only for family.");
				}
				
				if(dData[did][dVip] > pData[playerid][pVip])
					return Error(playerid, "Your VIP level not enough to enter this door.");
				
				if(dData[did][dAdmin] > pData[playerid][pAdmin])
					return Error(playerid, "Your admin level not enough to enter this door.");
					
				if(strlen(dData[did][dPass]))
				{
					new params[256];
					if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
					if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
					
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					pData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
				}
				else
				{
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					pData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
				}
			}
			if(IsValidDynamicCP(dData[did][dCP][1]) && IsPlayerInDynamicCP(playerid, dData[did][dCP][1]))
			{
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return Error(playerid, "This door only for faction.");
				}
				
				if(dData[did][dCustom])
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				else
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				pData[playerid][pInDoor] = -1;
				SetPlayerInterior(playerid, dData[did][dExtint]);
				SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsValidDynamicCP(bData[bid][bCP][0]) && IsPlayerInDynamicCP(playerid, bData[bid][bCP][0]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return Error(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return Error(playerid, "This bisnis is locked!");
					
				pData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);
				
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inbisnisid = pData[playerid][pInBiz];
		if(pData[playerid][pInBiz] != -1 && IsValidDynamicCP(bData[inbisnisid][bCP][1]) && IsPlayerInDynamicCP(playerid, bData[inbisnisid][bCP][1]))
		{
			pData[playerid][pInBiz] = -1;
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return Error(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return Error(playerid, "This house is locked!");
				
				pData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inhouseid = pData[playerid][pInHouse];
		if(pData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			pData[playerid][pInHouse] = -1;
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);
			
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return Error(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(pData[playerid][pFaction] == 0)
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have registered for this door!");
					
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				//pData[playerid][pInBiz] = fid;
				SetPlayerWeather(playerid, 0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ]))
			{
				SetPlayerPositionEx(playerid, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ], fData[fid][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
				//pData[playerid][pInBiz] = -1;
			}
        }
	}
	//SAPD Taser/Tazer
	if(newkeys & KEY_FIRE && TaserData[playerid][TaserEnabled] && GetPlayerWeapon(playerid) == 0 && !IsPlayerInAnyVehicle(playerid) && TaserData[playerid][TaserCharged])
	{
  		TaserData[playerid][TaserCharged] = false;

	    new Float: x, Float: y, Float: z, Float: health;
     	GetPlayerPos(playerid, x, y, z);
	    PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0);
	    ApplyAnimation(playerid, "KNIFE", "KNIFE_3", 4.1, 0, 1, 1, 0, 0, 1);
		pData[playerid][pActivityTime] = 0;
	    TaserData[playerid][ChargeTimer] = SetTimerEx("ChargeUp", 1000, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Recharge...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

	    for(new i, maxp = GetPlayerPoolSize(); i <= maxp; ++i)
		{
	        if(!IsPlayerConnected(i)) continue;
          	if(playerid == i) continue;
          	if(TaserData[i][TaserCountdown] != 0) continue;
          	if(IsPlayerInAnyVehicle(i)) continue;
			if(GetPlayerDistanceFromPoint(i, x, y, z) > 2.0) continue;
			ClearAnimations(i, 1);
			TogglePlayerControllable(i, false);
   			ApplyAnimation(i, "CRACK", "crckdeth2", 4.1, 0, 0, 0, 1, 0, 1);
			PlayerPlaySound(i, 6003, 0.0, 0.0, 0.0);

			GetPlayerHealth(i, health);
			TaserData[i][TaserCountdown] = TASER_BASETIME + floatround((100 - health) / 12);
   			Info(i, "You got tased for "YELLOW"%d secounds!", TaserData[i][TaserCountdown]);
			TaserData[i][GetupTimer] = SetTimerEx("TaserGetUp", 1000, true, "i", i);
			break;
	    }
	}
	//Vehicle
	if((newkeys & KEY_YES ))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			return callcmd::engine(playerid, "");
		}
		/*
		foreach(new park : Parks)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.3, ppData[park][parkX], ppData[park][parkY], ppData[park][parkZ]))
			{
				if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Kamu harus login!");
				if(pData[playerid][pInjured] >= 1) return Error(playerid, "Kamu tidak bisa melakukan ini!");
				if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "You must be not in Vehicle");
		
				if(GetAnyVehiclePark(park) <= 0) return Error(playerid, "Tidak ada Kendaraan yang diparkirkan disini.");
				new id, count = GetAnyVehiclePark(park), location[4080], lstr[596];

				pData[playerid][pPark] = park;

				strcat(location,"No\tVehicle\tPlate\tOwner\n",sizeof(location));
				Loop(itt, (count + 1), 1)
				{
					id = ReturnAnyVehiclePark(itt, park);
					if(itt == count)
					{
						format(lstr,sizeof(lstr), "%d\t%s\t%s\t%s\n", itt, GetVehicleModelName(pvData[id][cModel]), pvData[id][cPlate], GetVehicleOwnerName(id));
					}
					else format(lstr,sizeof(lstr), "%d\t%s\t%s\t%s\n", itt, GetVehicleModelName(pvData[id][cModel]), pvData[id][cPlate], GetVehicleOwnerName(id));
					strcat(location,lstr,sizeof(location));
				}
				ShowPlayerDialog(playerid, DIALOG_PICKUPVEH, DIALOG_STYLE_TABLIST_HEADERS,"Parked Vehicle",location,"Pickup","Cancel");
			}
		}*/
	}
	if((newkeys & KEY_NO ))
	{
		if(IsAtEvent[playerid] == 1)
			return Error(playerid, "Anda tidak dapat membuka player menu saat event");

		Dialog_Show(playerid, DialogPlayerMenu, DIALOG_STYLE_TABLIST_HEADERS,
		"Player > Menu", "Details\nInventory\n"GRAY"Accessories\nVehicle Menu\n"GRAY"Phone",
		"Select", "Close");
	}
	/*
	if(GetPVarInt(playerid, "UsingSprunk"))
	{
		if(pData[playerid][pEnergy] >= 100 )
		{
  			Info(playerid, " Kamu terlalu banyak minum.");
	   	}
	   	else
	   	{
	   		pData[playerid][pBladder] -= 1;
		    pData[playerid][pEnergy] += 5;
		}
	}*/
	// STREAMER MASK SYSTEM
	if(PRESSED( KEY_WALK ))
	{
		if(pData[playerid][pMaskOn] == 1)
		{
			for(new i; i<MAX_PLAYERS; i++)
			{
				ShowPlayerNameTagForPlayer(i, playerid, 0);
			}
		}
		else if(pData[playerid][pMaskOn] == 0)
		{
			for(new i; i<MAX_PLAYERS; i++)
			{
				ShowPlayerNameTagForPlayer(i, playerid, 1);
			}
		}
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(GetEngineStatus(vehicleid))
			{
				if(GetVehicleSpeed(vehicleid) <= 40)
				{
					new playerState = GetPlayerState(playerid);
					if(playerState == PLAYER_STATE_DRIVER)
					{
						SendClientMessageToAllEx(COLOR_RED, "Anti-Bug User: "GREY2_E"%s have been auto kicked for vehicle engine hack!", pData[playerid][pName]);
						KickEx(playerid);
					}
				}
			}
		}
	}
	if(PRESSED( KEY_FIRE ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
		{
			foreach(new did : Doors)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
							return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

						if(dData[did][dLocked])
							return Error(playerid, "This entrance is locked at the moment.");
							
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != pData[playerid][pFaction])
								return Error(playerid, "This door only for faction.");
						}
						if(dData[did][dFamily] > 0)
						{
							if(dData[did][dFamily] != pData[playerid][pFamily])
								return Error(playerid, "This door only for family.");
						}
						
						if(dData[did][dVip] > pData[playerid][pVip])
							return Error(playerid, "Your VIP level not enough to enter this door.");
						
						if(dData[did][dAdmin] > pData[playerid][pAdmin])
							return Error(playerid, "Your admin level not enough to enter this door.");
							
						if(strlen(dData[did][dPass]))
						{
							new params[256];
							if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
							if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
							
							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							pData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
						}
						else
						{
							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							pData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
						}
					}
				}
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != pData[playerid][pFaction])
								return Error(playerid, "This door only for faction.");
						}
					
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
						}
						pData[playerid][pInDoor] = -1;
						SetPlayerInterior(playerid, dData[did][dExtint]);
						SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, WorldWeather);
					}
				}
			}
		}
	}
	//if(IsKeyJustDown(KEY_CTRL_BACK,newkeys,oldkeys))
	if(PRESSED( KEY_CTRL_BACK ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && pData[playerid][pCuffed] == 0)
		{
			ClearAnimations(playerid);
			StopLoopingAnim(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
    }
	if(IsKeyJustDown(KEY_SECONDARY_ATTACK, newkeys, oldkeys))
	{
		if(GetPVarInt(playerid, "UsingSprunk"))
		{
			DeletePVar(playerid, "UsingSprunk");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_WASTED && pData[playerid][pJail] < 1)
    {	
		if(pData[playerid][pInjured] == 0)
        {
            pData[playerid][pInjured] = 1;
            SetPlayerHealthEx(playerid, 99999);

            pData[playerid][pInt] = GetPlayerInterior(playerid);
            pData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

            GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
            GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
        }
        else
        {
            pData[playerid][pHospital] = 1;
        }
	}
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(pData[playerid][playerSpectated] != 0)
		{
			foreach(new ii : Player)
			{
				if(pData[ii][pSpec] == playerid)
				{
					PlayerSpectatePlayer(ii, playerid);
					Servers(ii, ,"%s(%i) is now on foot.", pData[playerid][pName], playerid);
				}
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
		if(pData[playerid][pInjured] == 1)
        {
            //RemoveFromVehicle(playerid);
			RemovePlayerFromVehicle(playerid);
            SetPlayerHealthEx(playerid, 99999);
        }
		foreach (new ii : Player) if(pData[ii][pSpec] == playerid) 
		{
            PlayerSpectateVehicle(ii, GetPlayerVehicleID(playerid));
        }
	}
	if(oldstate == PLAYER_STATE_PASSENGER)
	{
		TextDrawHideForPlayer(playerid, TDEditor_TD[11]);
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
	}
	if(oldstate == PLAYER_STATE_DRIVER)
    {	
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
            return RemovePlayerFromVehicle(playerid);/*RemoveFromVehicle(playerid);*/
			
		PlayerTextDrawHide(playerid, OldSchoolHbe[playerid][6]);
		PlayerTextDrawHide(playerid, OldSchoolHbe[playerid][7]);
		PlayerTextDrawHide(playerid, OldSchoolHbe[playerid][8]);
		PlayerTextDrawHide(playerid, OldSchoolHbe[playerid][9]);
		PlayerTextDrawHide(playerid, OldSchoolHbe[playerid][10]);
		PlayerTextDrawHide(playerid, OldSchoolHbe[playerid][11]);
		PlayerTextDrawHide(playerid, OldSchoolHbe[playerid][12]);
		PlayerTextDrawHide(playerid, OldSchoolHbe[playerid][13]);
		PlayerTextDrawHide(playerid, OldSchoolHbe[playerid][14]);

		PlayerTextDrawHide(playerid, Entry_HUD[playerid][5]);
		PlayerTextDrawHide(playerid, Entry_HUD[playerid][6]);
		PlayerTextDrawHide(playerid, Entry_HUD[playerid][7]);
		PlayerTextDrawHide(playerid, Entry_HUD[playerid][8]);
		PlayerTextDrawHide(playerid, Entry_HUD[playerid][9]);
		PlayerTextDrawHide(playerid, Entry_HUD[playerid][10]);
		PlayerTextDrawHide(playerid, Entry_HUD[playerid][11]);
			
		if(pData[playerid][pTaxiDuty] == 1)
		{
			pData[playerid][pTaxiDuty] = 0;
			SetPlayerColor(playerid, COLOR_WHITE);
			Servers(playerid, "You are no longer on taxi duty!");
		}
		if(pData[playerid][pFare] == 1)
		{
			KillTimer(pData[playerid][pFareTimer]);
			Info(playerid, "Anda telah menonaktifkan taxi fare pada total: {00FF00}%s", FormatMoney(pData[playerid][pTotalFare]));
			pData[playerid][pFare] = 0;
			pData[playerid][pTotalFare] = 0;
		}

		if(pData[playerid][pSideJob] == SIDEJOB_COURIER)
		{
			TimerCourier[playerid] = 61;
			new Float:x1, Float:y1, Float:z1;
			GetVehiclePartPos(pData[playerid][pSideJobVeh], VEHICLE_PART_TRUNK, x1, y1, z1);
			SetPlayerRaceCheckpoint(playerid, 1, x1, y1, z1, x1, y1, z1, 1);
			CourierCrate[playerid] = 1;
			SetVehicleParamsForPlayer(pData[playerid][pSideJobVeh],playerid,1,0);
			return 1;
		}
		if(pData[playerid][pSideJob] == SIDEJOB_PIZZA)
		{
			pizzaTimer[playerid] = 61;
			new Float:x1, Float:y1, Float:z1;
			GetVehiclePartPos(pData[playerid][pSideJobVeh], VEHICLE_PART_TRUNK, x1, y1, z1);
			SetPlayerRaceCheckpoint(playerid, 1, x1, y1, z1, x1, y1, z1, 1);
			pizzaTakeStatus[playerid] = true;
			SetVehicleParamsForPlayer(pData[playerid][pSideJobVeh],playerid,1,0);
			return 1;
		}
        
		HidePlayerProgressBar(playerid, pData[playerid][spfuelbar]);
        HidePlayerProgressBar(playerid, pData[playerid][spdamagebar]);
		
        HidePlayerProgressBar(playerid, pData[playerid][fuelbar]);
        HidePlayerProgressBar(playerid, pData[playerid][damagebar]);
	}
	else if(newstate == PLAYER_STATE_DRIVER)
    {
		//Spec Player
		new vehicleid = GetPlayerVehicleID(playerid);

		/*if(IsSRV(vehicleid))
		{
			new tstr[128], price = GetVehicleCost(GetVehicleModel(vehicleid));
			format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleName(vehicleid), FormatMoney(price));
			ShowPlayerDialog(playerid, DIALOG_BUYPV, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
		}
		else if(IsVSRV(vehicleid))
		{
			new tstr[128], price = GetVipVehicleCost(GetVehicleModel(vehicleid));
			if(pData[playerid][pVip] == 0)
			{
				Error(playerid, "Kendaraan Khusus VIP Player.");
				RemovePlayerFromVehicle(playerid);
				//SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
			else
			{
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d Coin", GetVehicleName(vehicleid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYVIPPV, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
		}*/
		if(IsACourierVeh(GetPlayerVehicleID(playerid)) && pData[playerid][pSideJob] == SIDEJOB_NONE) 
		{
			Dialog_Show(playerid, CourierSidejob, DIALOG_STYLE_MSGBOX, "{ffffff}Sidejob: Courier", 
			"Are you ready to start working sidejob as a Courier?", "Start", "Cancel");
		}
		if(IsPizzaVeh(GetPlayerVehicleID(playerid)) && pData[playerid][pSideJob] == SIDEJOB_NONE) 
		{
			Dialog_Show(playerid, PizzaSidejob, DIALOG_STYLE_MSGBOX, "{ffffff}Sidejob: PizzaBoy", 
			"Are you ready to start working sidejob as a PizzaBoy?", "Start", "Cancel");
		}

		foreach(new pv : PVehicles)
		{
			if(GetVehicleType(pv) == VEHICLE_TYPE_PLAYER)
			{
				if(vehicleid == pvData[pv][cVeh])
				{
					if(IsABike(vehicleid) || GetVehicleModel(vehicleid) == 424)
					{
						if(pvData[pv][cLocked] == 1)
						{
							RemovePlayerFromVehicle(playerid);
							//new Float:slx, Float:sly, Float:slz;
							//GetPlayerPos(playerid, slx, sly, slz);
							//SetPlayerPos(playerid, slx, sly, slz);
							Error(playerid, "This bike is locked by owner.");
							return 1;
						}
					}
				}
			}
		}

		if(IsEngineVehicle(vehicleid) && !GetEngineStatus(vehicleid))
		{
			Custom(playerid, "ENGINE", "Mesin masih mati, Gunakan "YELLOW"[Y] "WHITE"untuk menyalakan mesin");
		}
		
		if(pData[playerid][pSideJob] == SIDEJOB_PIZZA)
		{
			SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),playerid,0,0);
			if(pizzaTakeStatus[playerid] == true)
			{
				DisablePlayerRaceCheckpoint(playerid);
				pizzaTakeStatus[playerid] = false;
			}
		}
		if(pData[playerid][pSideJob] == SIDEJOB_COURIER)
		{
			SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),playerid,0,0);
		}
		if(pData[playerid][pSideJob] == SIDEJOB_BUS_AB)
		{
			SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),playerid,0,0);
		}
		if(pData[playerid][pSideJob] == SIDEJOB_BUS_CD)
		{
			SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),playerid,0,0);
		}
		/*
		if(IsASweeperVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_SWEEPER, DIALOG_STYLE_MSGBOX, "Side Job - Sweeper", "Anda akan bekerja sebagai pembersih jalan?", "Start Job", "Close");
		}*/
		/*
		if(IsABusVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_BUS, DIALOG_STYLE_MSGBOX, "Side Job - Bus", "Anda akan bekerja sebagai pengangkut penumpang bus?", "Start Job", "Close");
		}*/
		if(IsAForVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_FORKLIFT, DIALOG_STYLE_MSGBOX, "Side Job - Forklift", "Anda akan bekerja sebagai pemuat barang dengan Forklift?", "Start Job", "Close");
		}
		
		if(!IsEngineVehicle(vehicleid))
        {
            SwitchVehicleEngine(vehicleid, true);
        }

		if(IsEngineVehicle(vehicleid) && pData[playerid][pDriveLic] == 0 && TakeLicense[playerid] == 0 && TakeTestBoat[playerid] == 0)
        {
            Custom(playerid, "DRIVELIC", "You don't have "YELLOW"Driving License "WHITE"Please be careful");
        }
		if(IsEngineVehicle(vehicleid) && pData[playerid][pDriveLic] == 2 && TakeLicense[playerid] == 0 && TakeTestBoat[playerid] == 0)
        {
            Custom(playerid, "DRIVELIC", "Your "YELLOW"Driving License "WHITE_E"Has "RED"Expired, "WHITE"Please be careful");
        }

		if(pData[playerid][pHBEMode] == 1)
		{
			PlayerTextDrawShow(playerid, Entry_HUD[playerid][5]);
			PlayerTextDrawShow(playerid, Entry_HUD[playerid][6]);
			PlayerTextDrawShow(playerid, Entry_HUD[playerid][7]);
			PlayerTextDrawShow(playerid, Entry_HUD[playerid][8]);
			PlayerTextDrawShow(playerid, Entry_HUD[playerid][9]);
			PlayerTextDrawShow(playerid, Entry_HUD[playerid][10]);
			PlayerTextDrawShow(playerid, Entry_HUD[playerid][11]);

			PlayerTextDrawSetString(playerid, Entry_HUD[playerid][8], sprintf("%s", GetVehicleModel(GetPlayerVehicleID(playerid))));
		}
		else if(pData[playerid][pHBEMode] == 2)
		{
			PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][6]);
			PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][7]);
			PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][8]);
			PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][9]);
			PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][10]);
			PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][11]);
			PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][12]);
			PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][13]);
			PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][14]);
		}
		new Float:health;
        GetVehicleHealth(GetPlayerVehicleID(playerid), health);
        VehicleHealthSecurityData[GetPlayerVehicleID(playerid)] = health;
        VehicleHealthSecurity[GetPlayerVehicleID(playerid)] = true;
		
		if(pData[playerid][playerSpectated] != 0)
  		{
			foreach(new ii : Player)
			{
    			if(pData[ii][pSpec] == playerid)
			    {
        			PlayerSpectateVehicle(ii, vehicleid);
				    Servers(ii, ""YELLOW"%s(%i) "WHITE"is now driving a "YELLOW"%s(%d).", pData[playerid][pName], playerid, GetVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
				}
			}
		}
		SetPVarInt(playerid, "LastVehicleID", INVALID_VEHICLE_ID);
		pData[playerid][pLastCar] = INVALID_VEHICLE_ID;

		SetPVarInt(playerid, "LastVehicleID", vehicleid);
		pData[playerid][pLastCar] = vehicleid;
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    switch(weaponid)
    {
        case 0..18, 39..54: return 1;
    }

    if(weaponid >= 1 && weaponid <= 46)
    {
		
        new slot = g_aWeaponSlots[weaponid];

        if(pData[playerid][pGuns][slot] == weaponid)
        {
            pData[playerid][pAmmo][slot]--;

            if(pData[playerid][pAmmo][slot] <= 0)
            {
				//pData[playerid][pAmmoSurplus][slot] = 0;
                pData[playerid][pGuns][slot] = 0;
				ResetPlayerWeaponsEx(playerid);
            }
        }
	}
	for(new id = 0; id < 15; id++)
	{
	 	if(hitid == slottrain[playerid][id]) 
		{
			CountTraining[playerid] += 2;
			TrainingRandom(playerid);
			break;
		}
		
	}
	return 1;
}

stock GivePlayerHealth(playerid,Float:Health)
{
	new Float:health; GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+Health);
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new
        Float: vehicleHealth,
        playerVehicleId = GetPlayerVehicleID(playerid);

    new Float:health, Float: HP;
	
	GetPlayerHealth(playerid, health);
    GetVehicleHealth(playerVehicleId, vehicleHealth);
    new panels, doors, lights, tires;
    //GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    //UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

	foreach(new i : PVehicles)
    {
        if(vehicleid == pvData[i][cVeh])
		{
		    if(pvData[i][cBodyUpgrade] == 1)
		    {
			    GetVehicleHealth(pvData[i][cVeh], HP);
			    if(HP >= 1300)
			    {
					GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
			        UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, 0);
				}
				else
				{
					GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
				    UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
			  	}
			}
		}
	}
    if(pData[playerid][pSeatBelt] == 0 || pData[playerid][pHelmetOn] == 0)
    {
    	if(GetVehicleSpeed(vehicleid) <= 20)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 50)
    	{
    		new asakit = RandomEx(0, 2);
    		new bsakit = RandomEx(0, 2);
    		new csakit = RandomEx(0, 2);
    		new dsakit = RandomEx(0, 2);
    		pData[playerid][pLFoot] -= dsakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= dsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 90)
    	{
    		new asakit = RandomEx(0, 3);
    		new bsakit = RandomEx(0, 3);
    		new csakit = RandomEx(0, 3);
    		new dsakit = RandomEx(0, 3);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= csakit;
    		pData[playerid][pRFoot] -= dsakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	return 1;
    }
    if(pData[playerid][pSeatBelt] == 1 || pData[playerid][pHelmetOn] == 1)
    {
    	if(GetVehicleSpeed(vehicleid) <= 20)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 50)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= dsakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= dsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 90)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= csakit;
    		pData[playerid][pRFoot] -= dsakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    }
	if(IsABusABVeh(GetPlayerVehicleID(playerid))) Custom(playerid, "SIDEJOB", "{ffff00}WARNING!{ffffff}, please avoid damage or your job will be ended!");
	if(IsABusCDVeh(GetPlayerVehicleID(playerid))) Custom(playerid, "SIDEJOB", "{ffff00}WARNING!{ffffff}, please avoid damage or your job will be ended!");
	if(IsASweeperVeh(GetPlayerVehicleID(playerid))) Custom(playerid, "SIDEJOB", "{ffff00}WARNING!{ffffff}, please avoid damage or your job will be ended!");
	if(IsAForVeh(GetPlayerVehicleID(playerid))) Custom(playerid, "SIDEJOB", "{ffff00}WARNING!{ffffff}, please avoid damage or your job will be ended!");
	if(IsVehicleTrashmaster(GetPlayerVehicleID(playerid))) Custom(playerid, "SIDEJOB", "{ffff00}WARNING!{ffffff}, please avoid damage or your job will be ended!");
	if(IsACourierVeh(GetPlayerVehicleID(playerid))) Custom(playerid, "SIDEJOB", "{ffff00}WARNING!{ffffff}, please avoid damage or your job will be ended!");
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(IsAtEvent[playerid] == 0)
	{
		new sakit = RandomEx(1, 4);
		new asakit = RandomEx(1, 5);
		new bsakit = RandomEx(1, 7);
		new csakit = RandomEx(1, 4);
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 9)
		{
			pData[playerid][pHead] -= 20;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 3)
		{
			pData[playerid][pPerut] -= sakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 6)
		{
			pData[playerid][pRHand] -= bsakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 5)
		{
			pData[playerid][pLHand] -= asakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 8)
		{
			pData[playerid][pRFoot] -= csakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 7)
		{
			pData[playerid][pLFoot] -= bsakit;
		}
	}
	else if(IsAtEvent[playerid] == 1)
	{
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 9)
		{
			GivePlayerHealth(playerid, -90);
			SendClientMessage(issuerid, -1,"{7fffd4}[ TDM ]{ffffff} Headshot!");
		}
	}
    return 1;
}

public OnPlayerUpdate(playerid)
{
	//SAPD Tazer/Taser
	UpdateTazer(playerid);
	
	//SAPD Road Spike
	CheckPlayerInSpike(playerid);
	return 1;
}

task VehicleUpdate[40000]()
{
	for (new i = 1; i != MAX_VEHICLES; i ++) if(IsEngineVehicle(i) && GetEngineStatus(i))
    {
        if(GetVehicleFuel(i) > 0)
        {
			new fuel = GetVehicleFuel(i);
            SetVehicleFuel(i, fuel - 1);

            if(GetVehicleFuel(i) >= 1 && GetVehicleFuel(i) <= 10)
            {
               Info(GetVehicleDriver(i), "Kendaraan ingin habis bensin, Harap pergi ke SPBU ( Gas Station )");
            }
        }
        if(GetVehicleFuel(i) <= 0)
        {
            SetVehicleFuel(i, 0);
            SwitchVehicleEngine(i, false);
        }
    }
	foreach(new ii : PVehicles)
	{
		if(GetVehicleType(ii) == VEHICLE_TYPE_PLAYER)
		{
			if(IsValidVehicle(pvData[ii][cVeh]))
			{
				if(pvData[ii][cPlateTime] != 0 && pvData[ii][cPlateTime] <= gettime())
				{
					format(pvData[ii][cPlate], 32, "NoHave");
					SetVehicleNumberPlate(pvData[ii][cVeh], pvData[ii][cPlate]);
					pvData[ii][cPlateTime] = 0;
				}
				if(pvData[ii][cRent] != 0 && pvData[ii][cRent] <= gettime())
				{
					pvData[ii][cRent] = 0;
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[ii][cID]);
					mysql_tquery(g_SQL, query);
					if(IsValidVehicle(pvData[ii][cVeh])) DestroyVehicle(pvData[ii][cVeh]);
					pvData[ii][cVeh] = INVALID_VEHICLE_ID;
					Iter_SafeRemove(PVehicles, ii, ii);
				}
			}
			if(pvData[ii][cClaimTime] != 0 && pvData[ii][cClaimTime] <= gettime())
			{
				pvData[ii][cClaimTime] = 0;
			}
		}
	}
}

public OnVehicleDestroyed(vehicleid)
{
	if(VehCore[vehicleid][vSirenOn] && IsValidDynamicObject(VehCore[vehicleid][vSirenObject])) {
		DestroyDynamicObject(VehCore[vehicleid][vSirenObject]);

		VehCore[vehicleid][vSirenObject] = INVALID_STREAMER_ID;
	}
	VehCore[vehicleid][vSirenOn] = 0;
	VehCore[vehicleid][vLights] = 0;
	VehCore[vehicleid][vTrash] = 0;
	VehCore[vehicleid][vTemporary] = false;

	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	foreach(new playerid : Player) 
	{
		if(pData[playerid][pSideJobVeh] == vehicleid)
        {
			if(pData[playerid][pSideJob] == SIDEJOB_COURIER)
			{
				new gaji;
				gaji = CourierCount[playerid]*2500;
				TimerCourier[playerid] = 0;
				pData[playerid][pSideJob] = SIDEJOB_NONE;

				if(IsValidVehicle(pData[playerid][pSideJobVeh]))
					SetVehicleToRespawn(pData[playerid][pSideJobVeh]);

				pData[playerid][pSideJobVeh] = INVALID_VEHICLE_ID;

				AddPlayerSalary(playerid, sprintf("(Courier) Delivered %d packages", CourierCount[playerid]), gaji);	
				Custom(playerid, "COURIER", "Courier sidejob failed, {3BBD44}$%s {ffffff}has been issued for your next paycheck", FormatMoney(gaji));
				Custom(playerid, "SALARY", "Your salary statement has been updated, please check command {ffff00}'/salary'");
				CourierCount[playerid] = 0;
				CourierCrate[playerid] = 0;
				RemovePlayerAttachedObject(playerid, 9);
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
				pData[playerid][pCourierTime] = 1600;
				for(new id; id < 10; id++)
				{
					CourierStatus[playerid][id] = false;
				}
			}
        }
		if (TrailerMission[playerid] == vehicleid)
		{
			Custom(playerid, "TRUCKING", "Trailer anda hancur dan anda di berhentikan dari pekerjaan");
			new index = PlayerMissions[playerid];

			DisablePlayerRaceCheckpoint(playerid);
			if (IsValidVehicle(TrailerMission[playerid])) {
				DestroyVehicle(TrailerMission[playerid]);
			}

			TrailerMission[playerid] = INVALID_VEHICLE_ID;
			pData[playerid][pTrailer] = false;
			pData[playerid][pMissions] = false;
			pData[playerid][pTruckerHaulingTime] = 600;

			DialogMissions[index] = false; 

			PlayerMissions[playerid] = -1;
			PlayerTakeMissions[playerid] = false;

			if (g_QueueSize > 0) {
				new nextPlayerInQueue = g_MissionQueue[0];
				if (IsPlayerConnected(nextPlayerInQueue)) {
					GivePlayerMission(nextPlayerInQueue);
				} else {
					RemoveFromMissionQueue(nextPlayerInQueue);
				}
			}
		}
	}
	foreach(new ii : PVehicles)
	{
		if(GetVehicleType(ii) == VEHICLE_TYPE_PLAYER)
		{
			if(vehicleid == pvData[ii][cVeh])
			{
				if(pvData[ii][cInsu] > 0)
				{
					pvData[ii][cInsu]--;
					pvData[ii][cClaim] = 1;
					pvData[ii][cClaimTime] = gettime() + (1 * 600);
					foreach(new pid : Player) 
					{
						if(pvData[ii][cExtraID] == pData[pid][pID])
						{
							Info(pid, "Kendaraan anda hancur, pergi ke asuransi untuk mengembalikan kendaraan {00FF00}'/myinsu'");
						}
						if(IsValidVehicle(pvData[ii][cVeh]))
							DestroyVehicle(pvData[ii][cVeh]);

						Car_RemoveAllItems(ii);
						
						pvData[ii][cVeh] = INVALID_VEHICLE_ID;
					}
				}
				else
				{
					foreach(new pid : Player)
					{
						if(pvData[ii][cExtraID] == pData[pid][pID])
						{
							new query[128];
							mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[pid][cID]);
							mysql_tquery(g_SQL, query);
							
							if(IsValidVehicle(pvData[ii][cVeh]))
								DestroyVehicle(pvData[ii][cVeh]);

							pvData[ii][cVeh] = INVALID_VEHICLE_ID;

							Car_RemoveAllItems(ii);
							
							Info(pid, "Kendaraan anda hancur dan tidak memiliki insuransi.");
							Iter_SafeRemove(PVehicles, ii, ii);
						}
					}
				}
			}
		}
		else if(GetVehicleType(ii) == VEHICLE_TYPE_FACTION)
		{
			if(vehicleid == pvData[ii][cVeh])
			{
				if(IsValidVehicle(pvData[ii][cVeh]))
					DestroyVehicle(pvData[ii][cVeh]);

				pvData[ii][cVeh] = INVALID_VEHICLE_ID;
				pvData[ii][cClaim] = 1;

				SendFactionMessage(pvData[ii][cExtraID], COLOR_BLUE, "[%s] Vehicle model %s Has been destroyed", GetFactionName(pvData[ii][cExtraID]), GetVehicleModelName(pvData[ii][cModel]));
			}
		}
	}
	return 1;
}

ptask PlayerVehicleUpdate[200](playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsValidVehicle(vehicleid))
	{
		if(!GetEngineStatus(vehicleid) && IsEngineVehicle(vehicleid))
		{	
			SwitchVehicleEngine(vehicleid, false);
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new Float:fHealth;
			GetVehicleHealth(vehicleid, fHealth);
			if(IsValidVehicle(vehicleid) && fHealth <= 350.0)
			{
				SetValidVehicleHealth(vehicleid, 300.0);
				SwitchVehicleEngine(vehicleid, false);
				GameTextForPlayer(playerid, "~r~Totalled!", 2500, 3);
			}
		}
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(pData[playerid][pHBEMode] == 1)
			{
				new Float:fDamage, fFuel, color1, color2;
				new tstr[64];
				
				GetVehicleColor(vehicleid, color1, color2);

				GetVehicleHealth(vehicleid, fDamage);
				
				//fDamage = floatdiv(1000 - fDamage, 10) * 1.42999;

				if(fDamage <= 350.0) fDamage = 0.0;
				else if(fDamage > 1000.0) fDamage = 1000.0;
				
				fFuel = GetVehicleFuel(vehicleid);
				
				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 1000) fFuel = 1000;

				format(tstr, sizeof(tstr), "%.0f Mph", GetVehicleSpeed(vehicleid));
				PlayerTextDrawSetString(playerid, Entry_HUD[playerid][10], tstr);

				format(tstr, sizeof(tstr), "%.0f%", fDamage);
				PlayerTextDrawSetString(playerid, Entry_HUD[playerid][7], tstr);

				format(tstr, sizeof(tstr), "%dL", fFuel);
				PlayerTextDrawSetString(playerid, Entry_HUD[playerid][11], tstr);				
			}
			else if(pData[playerid][pHBEMode] == 2)
			{
				new Float:fDamage, fFuel, color1, color2;
				new tstr[64];
				
				GetVehicleColor(vehicleid, color1, color2);

				GetVehicleHealth(vehicleid, fDamage);
				
				//fDamage = floatdiv(1000 - fDamage, 10) * 1.42999;

				if(fDamage <= 350.0) fDamage = 0.0;
				else if(fDamage > 1000.0) fDamage = 1000.0;
				
				fFuel = GetVehicleFuel(vehicleid);
				
				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 1000) fFuel = 1000;

				format(tstr, sizeof(tstr), "%.0f Mph", GetVehicleSpeed(vehicleid));
				PlayerTextDrawSetString(playerid, OldSchoolHbe[playerid][14], tstr);

				format(tstr, sizeof(tstr), "%.0f%", fDamage);
				PlayerTextDrawSetString(playerid, OldSchoolHbe[playerid][10], tstr);

				format(tstr, sizeof(tstr), "%dL", fFuel);
				PlayerTextDrawSetString(playerid, OldSchoolHbe[playerid][11], tstr);	
			}
			else
			{
			
			}
		}
	}
}

ptask PlayerUpdate[999](playerid)
{
	//Anti-Cheat Vehicle health hack
	for(new v, j = GetVehiclePoolSize(); v <= j; v++) if(GetVehicleModel(v))
    {
        new Float:health;
        GetVehicleHealth(v, health);
        if( (health > VehicleHealthSecurityData[v]) && VehicleHealthSecurity[v] == false)
        {
			if(GetPlayerVehicleID(playerid) == v)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					SetValidVehicleHealth(v, VehicleHealthSecurityData[v]);
					SendClientMessageToAllEx(COLOR_RED, "Anti-Cheat: "GREY2_E"%s have been auto kicked for vehicle health hack!", pData[playerid][pName]);
					KickEx(playerid);
				}
			}
        }
        if(VehicleHealthSecurity[v] == true)
        {
            VehicleHealthSecurity[v] = false;
        }
        VehicleHealthSecurityData[v] = health;
    }
	//Anti-Money Hack
	/*
	if(GetPlayerMoney(playerid) > pData[playerid][pMoney])
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, pData[playerid][pMoney]);
		//SendAdminMessage(COLOR_RED, "Possible money hacks detected on %s(%i). Check on this player. "LG_E"($%d).", pData[playerid][pName], playerid, GetPlayerMoney(playerid) - pData[playerid][pMoney]);
	}
	//Anti Armour Hacks
	new Float:A;
	GetPlayerArmour(playerid, A);
	if(A > 98)
	{
		SetPlayerArmourEx(playerid, 0);
		SendClientMessageToAllEx(COLOR_RED, "Anti-Cheat: "GREY2_E"%s(%i) has been auto kicked for armour hacks!", pData[playerid][pName], playerid);
		KickEx(playerid);
	}*/
	//Weapon AC
	if(pData[playerid][pSpawned] == 1)
	{
		if(IsTraining[playerid] == 0) 
		{
			if(GetPlayerWeapon(playerid) != pData[playerid][pWeapon])
			{
				pData[playerid][pWeapon] = GetPlayerWeapon(playerid);

				if(pData[playerid][pWeapon] >= 1 && pData[playerid][pWeapon] <= 45 && pData[playerid][pWeapon] != 40 && pData[playerid][pWeapon] != 2 && pData[playerid][pGuns][g_aWeaponSlots[pData[playerid][pWeapon]]] != GetPlayerWeapon(playerid))
				{
					SendStaffMessage(X11_TOMATO, "AdmWarn: %s(%d) has possibly used weapon hacks (%s), Please to check /spec this player first!", pData[playerid][pName], playerid, ReturnWeaponName(pData[playerid][pWeapon]));
					//SendClientMessageToAllEx(COLOR_RED, "BotCmd: %s was kicked by BOT. Reason: used weapon hacks (%s).", pData[playerid][pName], ReturnWeaponName(pData[playerid][pWeapon]));
					SetWeapons(playerid); //Reload old weapons
					//KickEx(playerid);
					//Log_Write("logs/cheat_log.txt", "[%s] %s has possibly used weapon hacks (%s).", ReturnDate(), pData[playerid][pName], ReturnWeaponName(pData[playerid][pWeapon]));
					//return 1;
				}
			}
		}
	}
	//training abuse
	if(pData[playerid][pSpawned] == 1)
	{
		if(IsTraining[playerid] != 0) 
		{
			if(pData[playerid][pInBiz] != -1 && GetPlayerInterior(playerid) != bData[pData[playerid][pInBiz]][bInt]) //deafult weapon training interior
			{
				SendClientMessageToAllEx(X11_TOMATO, "BotCmd: %s(%d) Has been kicked from server", pData[playerid][pName], playerid);
				SendClientMessageToAll(X11_TOMATO, "Reason: Abuse Weapon Training");
				Kick(playerid);
			}
		}
	}
	//Weapon Atth
	if(NetStats_GetConnectedTime(playerid) - WeaponTick[playerid] >= 250)
	{
		static weaponid, ammo, objectslot, count, index;
 
		for (new i = 2; i <= 7; i++) //Loop only through the slots that may contain the wearable weapons
		{
			GetPlayerWeaponData(playerid, i, weaponid, ammo);
			index = weaponid - 22;
		   
			if (weaponid && ammo && !WeaponSettings[playerid][index][Hidden] && IsWeaponWearable(weaponid) && EditingWeapon[playerid] != weaponid)
			{
				objectslot = GetWeaponObjectSlot(weaponid);
 
				if (GetPlayerWeapon(playerid) != weaponid)
					SetPlayerAttachedObject(playerid, objectslot, GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
 
				else if (IsPlayerAttachedObjectSlotUsed(playerid, objectslot)) RemovePlayerAttachedObject(playerid, objectslot);
			}
		}
		for (new i = 4; i <= 8; i++) if (IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			count = 0;
 
			for (new j = 22; j <= 38; j++) if (PlayerHasWeapon(playerid, j) && GetWeaponObjectSlot(j) == i)
				count++;
 
			if(!count) RemovePlayerAttachedObject(playerid, i);
		}
		WeaponTick[playerid] = NetStats_GetConnectedTime(playerid);
	}
	
	//Player Update Online Data
	//GetPlayerHealth(playerid, pData[playerid][pHealth]);
    //GetPlayerArmour(playerid, pData[playerid][pArmour]);
	
	if(pData[playerid][IsLoggedIn] == true)
	{
		/*
		if(pData[playerid][pJail] <= 0)
		{
			if(pData[playerid][pHunger] > 100)
			{
				pData[playerid][pHunger] = 100;
			}
			if(pData[playerid][pHunger] < 0)
			{
				pData[playerid][pHunger] = 0;
			}
			if(pData[playerid][pEnergy] > 100)
			{
				pData[playerid][pEnergy] = 100;
			}
			if(pData[playerid][pEnergy] < 0)
			{
				pData[playerid][pEnergy] = 0;
			}
			if(pData[playerid][pBladder] > 100)
			{
				pData[playerid][pBladder] = 100;
			}
			if(pData[playerid][pBladder] < 0)
			{
				pData[playerid][pBladder] = 0;
			}
		}*/
		
		if(pData[playerid][pHBEMode] == 1)
		{
			static 
				tstr[280]
			;

			format(tstr, sizeof(tstr), "%d", pData[playerid][pHunger]);
			PlayerTextDrawSetString(playerid, Entry_HUD[playerid][2], tstr);
			PlayerTextDrawShow(playerid, Entry_HUD[playerid][2]);

			format(tstr, sizeof(tstr), "%d", pData[playerid][pEnergy]);
			PlayerTextDrawSetString(playerid, Entry_HUD[playerid][4], tstr);
			PlayerTextDrawShow(playerid, Entry_HUD[playerid][4]);

			format(tstr, sizeof(tstr), "%s", GetPlayerDirection(playerid));
			PlayerTextDrawSetString(playerid, DirectionTD[playerid][0], tstr);
			PlayerTextDrawShow(playerid, DirectionTD[playerid][0]);

			format(tstr, sizeof(tstr), "%s", GetPlayerDirections(playerid));
			PlayerTextDrawSetString(playerid, DirectionTD[playerid][1], tstr);
			PlayerTextDrawShow(playerid, DirectionTD[playerid][1]);

			format(tstr, sizeof(tstr), "%s", GetPlayerZone(playerid));
			PlayerTextDrawSetString(playerid, DirectionTD[playerid][2], tstr);
			PlayerTextDrawShow(playerid, DirectionTD[playerid][2]);
		}
		else if(pData[playerid][pHBEMode] == 2)
		{
			static 
				tstr[280]
			;

			format(tstr, sizeof(tstr), "%d", pData[playerid][pHunger]);
			PlayerTextDrawSetString(playerid, OldSchoolHbe[playerid][3], tstr);
			PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][3]);

			format(tstr, sizeof(tstr), "%d", pData[playerid][pEnergy]);
			PlayerTextDrawSetString(playerid, OldSchoolHbe[playerid][4], tstr);
			PlayerTextDrawShow(playerid, OldSchoolHbe[playerid][4]);

			format(tstr, sizeof(tstr), "%s", GetPlayerDirection(playerid));
			PlayerTextDrawSetString(playerid, DirectionTD[playerid][0], tstr);
			PlayerTextDrawShow(playerid, DirectionTD[playerid][0]);

			format(tstr, sizeof(tstr), "%s", GetPlayerDirections(playerid));
			PlayerTextDrawSetString(playerid, DirectionTD[playerid][1], tstr);
			PlayerTextDrawShow(playerid, DirectionTD[playerid][1]);

			format(tstr, sizeof(tstr), "%s", GetPlayerZone(playerid));
			PlayerTextDrawSetString(playerid, DirectionTD[playerid][2], tstr);
			PlayerTextDrawShow(playerid, DirectionTD[playerid][2]);
		}
		
		if(pData[playerid][pHospital] == 1)
		{
			if(pData[playerid][pInjured] == 1)
			{
				SetPlayerPosition(playerid, -1288.7493,-424.5992,15.1382,263.3859, 1);
			
				SetPlayerInterior(playerid, 19);
				SetPlayerVirtualWorld(playerid, 24);

				//SetPlayerCameraPos(playerid, -2024.67, -93.13, 1066.78);
				//SetPlayerCameraLookAt(playerid, -2028.32, -92.87, 1067.43);
				ResetPlayerWeaponsEx(playerid);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pInjured] = 0;
			}
			pData[playerid][pHospitalTime]++;
			new mstr[64];
			format(mstr, sizeof(mstr), "~n~~n~~n~~w~Recovering... %d", 15 - pData[playerid][pHospitalTime]);
			InfoTD_MSG(playerid, 1000, mstr);

			ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
			ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
			if(pData[playerid][pHospitalTime] >= 15)
			{
				pData[playerid][pInjured] = 0;
				pData[playerid][pHospitalTime] = 0;
				pData[playerid][pHospital] = 0;
				pData[playerid][pHunger] = 50;
				pData[playerid][pEnergy] = 50;
				pData[playerid][pBladder] = 50;
				SetPlayerHealthEx(playerid, 50);
				pData[playerid][pSick] = 0;
				GivePlayerMoneyEx(playerid, -150);
				SetPlayerHealthEx(playerid, 50);

				for (new i; i < 20; i++)
				{
					SendClientMessage(playerid, -1, "");
				}

				SendClientMessage(playerid, COLOR_GREY, "--------------------------------------------------------------------------------------------------------");
				SendClientMessage(playerid, COLOR_WHITE, "Kamu telah keluar dari rumah sakit, kamu membayar $150 kerumah sakit.");
				SendClientMessage(playerid, COLOR_GREY, "--------------------------------------------------------------------------------------------------------");
				
				Info(playerid, ""YELLOW"semua senjata mu telah hilang di sita karena mati");
				SetPlayerPosition(playerid, 1182.8778, -1324.2023, 13.5784, 269.8747);

				TogglePlayerControllable(playerid, 1);
				SetCameraBehindPlayer(playerid);

				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0);
				ClearAnimations(playerid);
				pData[playerid][pSpawned] = 1;
				SetPVarInt(playerid, "GiveUptime", -1);
			}
		}
		if(pData[playerid][pInjured] == 1 && pData[playerid][pHospital] != 1)
		{
			new mstr[64];
			format(mstr, sizeof(mstr), "/death for spawn to hospital");
			InfoTD_MSG(playerid, 1000, mstr);
			
			if(GetPVarInt(playerid, "GiveUptime") == -1)
			{
				SetPVarInt(playerid, "GiveUptime", gettime());
			}
			
			if(GetPVarInt(playerid,"GiveUptime"))
			{
				if((gettime()-GetPVarInt(playerid, "GiveUptime")) > 100)
				{
					Info(playerid, "Now you can spawn, type "YELLOW"'/death' "WHITE"for spawn to hospital.");
					SetPVarInt(playerid, "GiveUptime", 0);
				}
			}
			
			ApplyAnimation(playerid, "CRACK", "null", 4.0, 0, 0, 0, 1, 0, 1);
			ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
			SetPlayerHealthEx(playerid, 99999);
		}
		if(pData[playerid][pInjured] == 0 && pData[playerid][pGender] != 0) //Pengurangan Data
		{
			if(++ pData[playerid][pHungerTime] >= 150)
			{
				if(pData[playerid][pHunger] > 0)
				{
					pData[playerid][pHunger]--;
				}
				else if(pData[playerid][pHunger] <= 0)
				{
					pData[playerid][pSick] = 1;
				}
				pData[playerid][pHungerTime] = 0;
			}
			if(++ pData[playerid][pEnergyTime] >= 120)
			{
				if(pData[playerid][pEnergy] > 0)
				{
					pData[playerid][pEnergy]--;
				}
				else if(pData[playerid][pEnergy] <= 0)
				{
					pData[playerid][pSick] = 1;
				}
				pData[playerid][pEnergyTime] = 0;
			}
			if(++ pData[playerid][pBladderTime] >= 100)
			{
				if(pData[playerid][pBladder] > 0)
				{
					pData[playerid][pBladder]--;
				}
				else if(pData[playerid][pBladder] <= 0)
				{
					pData[playerid][pSick] = 1;
				}
				pData[playerid][pBladderTime] = 0;
			}
			if(pData[playerid][pSick] == 1)
			{
				if(++ pData[playerid][pSickTime] >= 200)
				{
					if(pData[playerid][pSick] >= 1)
					{
						new Float:hp;
						GetPlayerHealth(playerid, hp);
						SetPlayerDrunkLevel(playerid, 8000);
						ApplyAnimation(playerid,"CRACK","crckdeth2",4.1,0,1,1,1,1,1);
						Info(playerid, "Sepertinya anda sakit, segeralah pergi ke dokter.");
						SetPlayerHealth(playerid, hp - 3);
						pData[playerid][pSickTime] = 0;
					}
				}
			}
		}
		
		//Jail Player
		if(pData[playerid][pJail] > 0)
		{
			if(pData[playerid][pJailTime] > 0)
			{
				pData[playerid][pJailTime]--;
				new mstr[128];
				format(mstr, sizeof(mstr), "~b~~h~You will be unjail in ~w~%d ~b~~h~seconds.", pData[playerid][pJailTime]);
				InfoTD_MSG(playerid, 1000, mstr);
			}
			else
			{
				pData[playerid][pJail] = 0;
				pData[playerid][pJailTime] = 0;
				//SpawnPlayer(playerid);
				SetPlayerPositionEx(playerid, 1482.0356,-1724.5726,13.5469,750, 2000);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
				SendClientMessageToAllEx(COLOR_RED, "Server: "GREY2_E" %s(%d) have been un-jailed by the server. (times up)", pData[playerid][pName], playerid);
			}
		}
		//Arreset Player
		if(pData[playerid][pArrest] > 0)
		{
			if(pData[playerid][pArrestTime] > 0)
			{
				pData[playerid][pArrestTime]--;
				new mstr[128];
				format(mstr, sizeof(mstr), "~b~~h~You will be released in ~w~%d ~b~~h~seconds.", pData[playerid][pArrestTime]);
				InfoTD_MSG(playerid, 1000, mstr);
			}
			else
			{
				pData[playerid][pArrest] = 0;
				pData[playerid][pArrestTime] = 0;
				//SpawnPlayer(playerid);
				SetPlayerPositionEx(playerid, 1526.69, -1678.05, 5.89, 267.76, 2000);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
				Info(playerid, "You have been auto release. (times up)");
			}
		}
	}
}

forward AppuieJump(playerid);
public AppuieJump(playerid)
{
    AntiBHOP[playerid] = 0;
    ClearAnimations(playerid);
    return 1;
}
forward AppuiePasJump(playerid);
public AppuiePasJump(playerid)
{
    AntiBHOP[playerid] = 0;
    return 1;
}

function LoadServerStuff()
{
	new strings[212];
	
	CreateDynamic3DTextLabel("[Bait Store]\n"YELLOW"'/buybait' "WHITE_E"untuk membeli Umpan ", COLOR_GREY,361.2099,-2032.1703,7.8359,10.0);
    CreateDynamicPickup(1239, 23, 361.2099,-2032.1703,7.8359+0.50, -1); // buybait

	format(strings, sizeof(strings), "[Farmer Storage]\n"WHITE_E"Use "YELLOW_E"'/plant sell' "WHITE_E"to sell your plant\n"WHITE_E"Use "YELLOW_E"'/buyseed' "WHITE_E"to buy seed");
	CreateDynamicPickup(1239, 23, -373.5426,-1427.1572,25.7266, 0, 0, _, 15.0);
	CreateDynamic3DTextLabel(strings, COLOR_GREY, -373.5426,-1427.1572,25.7266+0.50, 15.0);

	//format(strings, sizeof(strings), "[Lumber Selling]\n"WHITE_E"Use "YELLOW_E"'/lum sell' "WHITE_E"to sell your log");
	//CreateDynamicPickup(1239, 23, -1425.8391,-1529.2734,102.2214, 0, 0, _, 15.0);
	//CreateDynamic3DTextLabel(strings, COLOR_CYAN, -1425.8391,-1529.2734,102.2214+0.50, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);

	//Plant unload Component
	CreateDynamicPickup(1271, 23, 2792.4355,-2456.1199,13.6325, -1);
	format(strings, sizeof(strings), "[Plant Crate]\n"WHITE_E"Use "YELLOW_E"'/unloadcrate' "WHITE_E"to unload crate");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 2792.4355,-2456.1199,13.6325+0.50, 3.0); // Plate

	CreateDynamicPickup(1239, 23, 2844.0684,-1516.6871,11.3002, -1);
	format(strings, sizeof(strings), "Fish Factory\n"YELLOW_E"/sellallfish "WHITE_E"- to sell fish");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 2844.0684,-1516.6871,11.3002+0.50, 15.0); // Plate

	//Crate Unload Fish
	CreateDynamicPickup(1271, 23, -577.1335,-503.6530,25.5107, -1);
	format(strings, sizeof(strings), "[Fish & Lumber Crate]\n"WHITE_E"Use "YELLOW_E"'/unloadcrate' "WHITE_E"to unload crate");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, -577.1335,-503.6530,25.5107+0.50, 7.0); // Plate

	//lumber crate
	CreateDynamicPickup(1271, 23, -1446.8132,-1544.4138,101.9547, -1);
	format(strings, sizeof(strings), "[Lumber Crate]\n"WHITE_E"Available crates: "YELLOW"%d/100\n"WHITE_E"Use "YELLOW_E"'/takecrate' "WHITE_E"to pickup a crate", StockCrateLumber);
	LumberjackText = CreateDynamic3DTextLabel(strings, COLOR_GREY, -1446.8132,-1544.4138,101.9547+0.50, 15.0); // Plate

	//Plant Component
	CreateDynamicPickup(1271, 23, -366.3686,-1419.0941,25.7266, -1);
	format(strings, sizeof(strings), "[Plant Crate]\n"WHITE_E"Available crates: "YELLOW"%d/100\n"WHITE_E"Use "YELLOW_E"'/takecrate' "WHITE_E"to pickup a crate", StockCratePlant);
	PlantText = CreateDynamic3DTextLabel(strings, COLOR_GREY, -366.3686,-1419.0941,25.7266+0.50, 15.0); // Plate

	//Crate Component
	CreateDynamicPickup(1271, 23, 323.6411, 904.5583, 21.5862, -1);
	format(strings, sizeof(strings), "[Component Crate]\n"WHITE"Available Crates: "YELLOW"%d/100\n"WHITE_E"Use "YELLOW_E"'/takecrate' "WHITE_E"to pickup crate", StockCrateCompo);
	CompoCrateText = CreateDynamic3DTextLabel(strings, COLOR_GREY, 323.6411, 904.5583, 21.5862+0.50, 15.0); // Plate

	//Crate unload Component
	CreateDynamicPickup(1271, 23, 797.7953,-616.8799,16.3359, -1);
	format(strings, sizeof(strings), "[Component Crate]\n"WHITE_E"Use "YELLOW_E"'/unloadcrate' "WHITE_E"to unload crate");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, 797.7953,-616.8799,16.3359+0.50, 15.0); //
	
	//fish crate
	CreateDynamicPickup(1271, 23, 2836.3945,-1541.1984,11.0991, -1);
	format(strings, sizeof(strings), "Canned Fish Crates\n"WHITE"Fish Available: "YELLOW"%d/100\n"WHITE_E"Use "YELLOW_E"'/takecrate' "WHITE_E"to pickup crate", StockCrateFish);
	FishCrateText = CreateDynamic3DTextLabel(strings, COLOR_GREY, 2836.3945,-1541.1984,11.0991+0.50, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate
	return 1;
}

public OnClickDynamicPlayerTextDraw(playerid, PlayerText:textid)
{
	if(textid == RegisterChar[playerid][3])
	{
		ShowPlayerDialog(playerid, DIALOG_CREATECHAR, DIALOG_STYLE_INPUT, "Create Character", ""WHITE_E"Masukkan nama karakter, maksimal 24 karakter\n\nContoh: "YELLOW_E"Sean_Rutledge, Eddison_Murphy dan lainnya.", "Create", "Back");
	}
	if(textid == RegisterChar[playerid][5])
	{
		ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir\n(Tgl/Bulan/Tahun)\nMisal : 15/04/1998", "Enter", "Batal");
	}
	if(textid == RegisterChar[playerid][7])
	{
		PlayerTextDrawColor(playerid, RegisterChar[playerid][7], -2686876);
		PlayerTextDrawColor(playerid, RegisterChar[playerid][8], 150);
		PlayerTextDrawShow(playerid, RegisterChar[playerid][7]);
		PlayerTextDrawShow(playerid, RegisterChar[playerid][8]);
		pData[playerid][pGender] = 1;
		pData[playerid][pTempGender] = true;
	}
	if(textid == RegisterChar[playerid][8])
	{
		PlayerTextDrawColor(playerid, RegisterChar[playerid][7], 150);
		PlayerTextDrawColor(playerid, RegisterChar[playerid][8], -2686876);
		PlayerTextDrawShow(playerid, RegisterChar[playerid][7]);
		PlayerTextDrawShow(playerid, RegisterChar[playerid][8]);
		pData[playerid][pGender] = 2;
		pData[playerid][pTempGender] = true;
	}
	if(textid == RegisterChar[playerid][13]) //prev
	{
		if(pData[playerid][pGender] == 0) return Error(playerid, "Mohon masukan gender anda terlebih dahulu sebelum memilih skin");
		if(pData[playerid][pTempSkin] == 0)
		{
			if(CharacterSelect[playerid] == 0)
			{
				SetPlayerPos(playerid, SKINPOS_CHAR0);
				SetPlayerFacingAngle(playerid, SKINA_CHAR0);
			}
			else if(CharacterSelect[playerid] == 1)
			{
				SetPlayerPos(playerid, SKINPOS_CHAR1);
				SetPlayerFacingAngle(playerid, SKINA_CHAR1);
			}
			else if(CharacterSelect[playerid] == 2)
			{
				SetPlayerPos(playerid, SKINPOS_CHAR2);
				SetPlayerFacingAngle(playerid, SKINA_CHAR2);
			}
		}
		pData[playerid][pTempSkin]--;
		if(pData[playerid][pGender] == 1)
		{
			if(pData[playerid][pTempSkin] < 0) pData[playerid][pTempSkin] = sizeof BajuLakiLaki - 1;
			SetPlayerSkin(playerid, BajuLakiLaki[pData[playerid][pTempSkin]]);
		}
		else if(pData[playerid][pGender] == 2)
		{
			if(pData[playerid][pTempSkin] < 0) pData[playerid][pTempSkin] = sizeof BajuPerempuan - 1;
			SetPlayerSkin(playerid, BajuPerempuan[pData[playerid][pTempSkin]]);
		}
	}
	if(textid == RegisterChar[playerid][14]) //next
	{	
		if(pData[playerid][pGender] == 0) return Error(playerid, "Mohon masukan gender anda terlebih dahulu sebelum memilih skin");
		if(pData[playerid][pTempSkin] == 0)
		{
			if(CharacterSelect[playerid] == 0)
			{
				SetPlayerPos(playerid, SKINPOS_CHAR0);
				SetPlayerFacingAngle(playerid, SKINA_CHAR0);
			}
			else if(CharacterSelect[playerid] == 1)
			{
				SetPlayerPos(playerid, SKINPOS_CHAR1);
				SetPlayerFacingAngle(playerid, SKINA_CHAR1);
			}
			else if(CharacterSelect[playerid] == 2)
			{
				SetPlayerPos(playerid, SKINPOS_CHAR2);
				SetPlayerFacingAngle(playerid, SKINA_CHAR2);
			}
		}
		pData[playerid][pTempSkin]++;
		if(pData[playerid][pGender] == 1)
		{
			if(pData[playerid][pTempSkin] >= sizeof BajuLakiLaki) pData[playerid][pTempSkin] = 0;
			SetPlayerSkin(playerid, BajuLakiLaki[pData[playerid][pTempSkin]]);
		}
		if(pData[playerid][pGender] == 2)
		{
			if(pData[playerid][pTempSkin] >= sizeof BajuPerempuan) pData[playerid][pTempSkin] = 0;
			SetPlayerSkin(playerid, BajuPerempuan[pData[playerid][pTempSkin]]);
		}
	}
	if(textid == RegisterChar[playerid][11]) //finish
	{
		if(pData[playerid][pTempCreateChar] == false) return Error(playerid, "Anda belum memberikan nama character anda");
		if(pData[playerid][pTempAge] == false) return Error(playerid, "Anda belum memilih tanggal lahir");
		if(pData[playerid][pTempGender] == false) return Error(playerid, "Anda belum memilih gender");
		if(pData[playerid][pTempSkin] == 0) return Error(playerid, "Anda belum memilih skin");

		pData[playerid][pSkin] = GetPlayerSkin(playerid);
		forex(i, 17) PlayerTextDrawHide(playerid, RegisterChar[playerid][i]);
		CancelSelectTextDraw(playerid);

		CharacterState[playerid] = false;

		pData[playerid][pPosX] = 1683.2726;
		pData[playerid][pPosY] = -2328.0679;
		pData[playerid][pPosZ] = 13.5469;
		pData[playerid][pPosA] = 0.5398;
		
		SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1683.2726,-2328.0679,13.5469,0.5398, 0, 0, 0, 0, 0, 0);
		SpawnPlayer(playerid);
	}

	if(textid == MultiChar[playerid][8])
	{
		if(CharacterSelect[playerid] == -1)
			return Error(playerid, "Pilih karakter yang akan di mainkan!");

		for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) if(UcpData[i][uUsername][0] != EOS)
        {
            if(!strcmp(UcpData[i][uUsername], GetName(playerid)) && i != playerid)
            {
                Error(playerid, "Seseorang sedang login menggunakan UCP yang sama.");
                KickEx(playerid);
                return 1;
            }
        }

		if(CharacterList[playerid][CharacterSelect[playerid]][0] != EOS)
		{
			pData[playerid][pChar] = CharacterSelect[playerid];
			CharacterState[playerid] = false;
			forex(i, 10) PlayerTextDrawHide(playerid, MultiChar[playerid][i]);
			CancelSelectTextDraw(playerid);
			SetPlayerName(playerid, CharacterList[playerid][CharacterSelect[playerid]]);

			new cQuery[256];
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `players` WHERE `username` = '%s' ORDER BY `reg_id` ASC LIMIT 1;", CharacterList[playerid][pData[playerid][pChar]]);
			mysql_tquery(g_SQL, cQuery, "AssignPlayerData", "d", playerid); 
		}
		else
		{
			forex(i, 10) PlayerTextDrawHide(playerid, MultiChar[playerid][i]);
			forex(i, 17) PlayerTextDrawShow(playerid, RegisterChar[playerid][i]);
		}
	}
	if(textid == MultiChar[playerid][1])
	{
		if(CharacterSelect[playerid] == -1)
		{
			InterpolateCameraPos(playerid, CAMERA1_DIEM, CAMERA1_CHAR0, 2000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, CAMERA2_DIEM, CAMERA2_CHAR0, 2000, CAMERA_MOVE);
		}
		else if(CharacterSelect[playerid] == 1)
		{
			InterpolateCameraPos(playerid, CAMERA1_CHAR1, CAMERA1_CHAR0, 2000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, CAMERA2_CHAR1, CAMERA2_CHAR0, 2000, CAMERA_MOVE);
		}
		else if(CharacterSelect[playerid] == 2)
		{
			InterpolateCameraPos(playerid, CAMERA1_CHAR2, CAMERA1_CHAR0, 2000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, CAMERA2_CHAR2, CAMERA2_CHAR0, 2000, CAMERA_MOVE);
		}
		if(CharacterList[playerid][0][0] != EOS)
		{
			SetPlayerPos(playerid, SKINPOS_CHAR0);
			Streamer_UpdateEx(playerid, SKINPOS_CHAR0);
			SetPlayerFacingAngle(playerid, SKINA_CHAR0);
			SetPlayerSkin(playerid, CharacterSkin[playerid][0]);
			ApplyAnimation(playerid, "MISC", "SEAT_LR", 4.0, 1, 0, 0, 0, 0, 1);
		}
		//GetPlayerName(playerid, CharacterList[playerid][0][0], MAX_PLAYER_NAME);
		CharacterSelect[playerid] = 0;
	}
	if(textid == MultiChar[playerid][2])
	{
		if(CharacterSelect[playerid] == -1)
		{
			InterpolateCameraPos(playerid, CAMERA1_DIEM, CAMERA1_CHAR1, 2000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, CAMERA2_DIEM, CAMERA2_CHAR1, 2000, CAMERA_MOVE);
		}
		else if(CharacterSelect[playerid] == 0)
		{
			InterpolateCameraPos(playerid, CAMERA1_CHAR0, CAMERA1_CHAR1, 2000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, CAMERA2_CHAR0, CAMERA2_CHAR1, 2000, CAMERA_MOVE);
		}
		else if(CharacterSelect[playerid] == 2)
		{
			InterpolateCameraPos(playerid, CAMERA1_CHAR2, CAMERA1_CHAR1, 2000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, CAMERA2_CHAR2, CAMERA2_CHAR1, 2000, CAMERA_MOVE);
		}
		if(CharacterList[playerid][1][0] != EOS)
		{
			SetPlayerPos(playerid, SKINPOS_CHAR1);
			Streamer_UpdateEx(playerid, SKINPOS_CHAR1);
			SetPlayerFacingAngle(playerid, SKINA_CHAR1);
			SetPlayerSkin(playerid, CharacterSkin[playerid][1]);
			ApplyAnimation(playerid, "POOL", "POOL_Med_Start",50.0,0,0,0,1,1,1);
		}
		//GetPlayerName(playerid, CharacterList[playerid][1][0], MAX_PLAYER_NAME);
		CharacterSelect[playerid] = 1;
	}
	if(textid == MultiChar[playerid][3])
	{
		if(CharacterSelect[playerid] == -1)
		{
			InterpolateCameraPos(playerid, CAMERA1_DIEM, CAMERA1_CHAR2, 2000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, CAMERA2_DIEM, CAMERA2_CHAR2, 2000, CAMERA_MOVE);
		}
		else if(CharacterSelect[playerid] == 0)
		{
			InterpolateCameraPos(playerid, CAMERA1_CHAR0, CAMERA1_CHAR2, 2000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, CAMERA2_CHAR0, CAMERA2_CHAR2, 2000, CAMERA_MOVE);
		}
		else if(CharacterSelect[playerid] == 1)
		{
			InterpolateCameraPos(playerid, CAMERA1_CHAR1, CAMERA1_CHAR2, 2000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, CAMERA2_CHAR1, CAMERA2_CHAR2, 2000, CAMERA_MOVE);
		}
		if(CharacterList[playerid][2][0] != EOS)
		{
			SetPlayerPos(playerid, SKINPOS_CHAR2);
			Streamer_UpdateEx(playerid, SKINPOS_CHAR2);
			SetPlayerFacingAngle(playerid, SKINA_CHAR2);
			SetPlayerSkin(playerid, CharacterSkin[playerid][2]);
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		} 
		CharacterSelect[playerid] = 2;
	}
	if(textid == inv_gui[playerid][8])
	{
		CloseInventory(playerid);
	}
	if(textid == inv_gui[playerid][3])
	{
		new id = pData[playerid][pInvSelect],
			string[64]	
		;

		if(id == -1)
			return Error(playerid, "Tidak ada item di slot yang dipilih!");

		if(InventoryData[playerid][id][invQuantity] < 1)
            return Error(playerid, "Tidak ada item di slot yang dipilih!");

		strunpack(string, InventoryData[playerid][id][invItem]);

		CallLocalFunction("OnPlayerUseItem", "ids", playerid, id, string);
	}
	if(textid == inv_gui[playerid][12]) {

        if(invPage[playerid] < 2) {
            invPage[playerid]++;
            SyncInventoryPage(playerid);
            PlayerPlaySound(playerid, 1039, 0.0, 0.0, 0.0);
        }
    }
    if(textid == inv_gui[playerid][11]) {

        if(invPage[playerid] > 0) {
            invPage[playerid]--;

            SyncInventoryPage(playerid);
            PlayerPlaySound(playerid, 1039, 0.0, 0.0, 0.0);
        }
    }
	for(new index; index < 16; index ++)
	{
		if(textid == inv_select[playerid][index])
		{
			for(new j = 0; j < 16; j++) {
				PlayerTextDrawColor(playerid, inv_select[playerid][j], -156);
				PlayerTextDrawShow(playerid, inv_select[playerid][j]);
			}

			new idxs = invPage[playerid] * 16;
			new itemid = index + idxs;

			if(pData[playerid][pInvSelect] == itemid) {
				pData[playerid][pInvSelect]= -1;
			}
			else {
				PlayerTextDrawColor(playerid, inv_select[playerid][index], -1094795674);
				PlayerTextDrawShow(playerid, inv_select[playerid][index]);
				new idx = invPage[playerid] * 16;
				new real_idx = idx + index;
				pData[playerid][pInvSelect] = real_idx;
			}
			break;
		}
	}

	return 1;
}
/*
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if (dialogid == 0) 
	{
        if (response) 
		{
            SetPlayerSkin(playerid, listitem);
            GameTextForPlayer(playerid, "~g~Skin Changed!", 3000, 3);
        }
    }
	if(dialogid == 1) 
	{
		if (response) 
		{
			if (GetPlayerMoney(playerid) < WEAPON_SHOP[listitem][WEAPON_PRICE]) 
			{
				SendClientMessage(playerid, 0xAA0000FF, "Not enough money to purchase this gun!");
				return callcmd::weapons(playerid);
			}
			
			GivePlayerMoney(playerid, -WEAPON_SHOP[listitem][WEAPON_PRICE]);
			GivePlayerWeapon(playerid, WEAPON_SHOP[listitem][WEAPON_ID], WEAPON_SHOP[listitem][WEAPON_AMMO]);
			
			GameTextForPlayer(playerid, "~g~Gun Purchased!", 3000, 3);
		}
	}
    return 1;
} */

LoadServerMap()
{
	CreateSMBToll();
	CreateIntSapd();
	CreateExtSapd();
	CreateChigago();
	CreateDepanRs(); 
	CreateIntSamd();
	CreateIntSags();
	CreateBasementInt();
	CreateBoatRepair();
	CreateExtSchoolBoat();
}

RemoveServerMap(playerid)
{
	RemoExtSapd(playerid);
	RemoveChigago(playerid);
	RemoveExtRs(playerid);
	RemoveBoatRepair(playerid);
}