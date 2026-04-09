// Server Define
#define TEXT_GAMEMODE	"North Country Roleplay | H-1"
#define TEXT_WEBURL		"https://discord.gg/epZChURC"
#define TEXT_LANGUAGE	"Indonesia/English"


#define		MYSQL_HOST 			"localhost"
#define		MYSQL_USER 			"root"
#define		MYSQL_PASSWORD 		""
#define		MYSQL_DATABASE 		"alvi2"

/*
#define		MYSQL_HOST 			"hosting.zxshop.store"
#define		MYSQL_USER 			"u81_4tVZn1egsG"
#define		MYSQL_PASSWORD 		"eUY^0Hi3y65NziZsF1=NDDr^"
#define		MYSQL_DATABASE 		"s81_north"*/

// how many seconds until it kicks the player for taking too long to login
#define		SECONDS_TO_LOGIN 	200

// default spawn point: Las Venturas (The High Roller)
#define 	DEFAULT_POS_X 		1744.3411
#define 	DEFAULT_POS_Y 		-1862.8655
#define 	DEFAULT_POS_Z 		13.3983
#define 	DEFAULT_POS_A 		270.0000

#define MAX_CHARACTERS   (3)

#define NormalName(%0)                  CharacterList[%0][pData[%0][pChar]]
#define ReturnAdminName(%0)             UcpData[%0][uUsername]

#define UTC_07							(25200)

//Android Client Check
//#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0

#define Loop(%0,%1,%2) for(new %0 = %2; %0 < %1; %0++)
#define forex(%0,%1) for(new %0 = 0; %0 < %1; %0++)
#define RGBAToInt(%0,%1,%2,%3)          ((16777216 * (%0)) + (65536 * (%1)) + (256 * (%2)) + (%3))

// Message
#define function%0(%1) forward %0(%1); public %0(%1)
#define Servers(%1,%2) SendClientMessageEx(%1, ARWIN, "SERVER: "WHITE_E""%2)
#define Info(%1,%2) SendClientMessageEx(%1, ARWIN, "INFO: "WHITE_E""%2)
#define Vehicle(%1,%2) SendClientMessageEx(%1, ARWIN, "VEHICLE: "WHITE_E""%2)
#define Usage(%1,%2) SendClientMessageEx(%1, COLOR_GREY , "USAGE: "WHITE_E""%2)
#define Error(%1,%2) SendClientMessageEx(%1, COLOR_GREY, "ERROR: "%2)
#define PermissionError(%0) SendClientMessage(%0, COLOR_GREY, "ERROR: Kamu tidak memiliki akses untuk melakukan command ini!")
#define Custom(%0,%1,%2)     SendClientMessageEx(%0, ARWIN, %1": {FFFFFF}"%2)

#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

//Converter
#define minplus(%1) \
        (((%1) < 0) ? (-(%1)) : ((%1)))

// AntiCaps
#define UpperToLower(%1) for( new ToLowerChar; ToLowerChar < strlen( %1 ); ToLowerChar ++ ) if ( %1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91 ) %1[ ToLowerChar ] += 32

// Banneds
const BAN_MASK = (-1 << (32 - (/*this is the CIDR ip detection range [def: 26]*/26)));

//MapIcon
#define MAP_ICON_STREAM_DISTANCE (200.0) // menggambar ikon di peta (radius)

//---------[ Define Faction ]-----
#define SAPD	1		//locker 1573.26, -1652.93, -40.59
#define	SAGS	2		// 1464.10, -1790.31, 2349.68
#define SAMD	3		// -1100.25, 1980.02, -58.91
#define SANEW	4		// 256.14, 1776.99, 701.08
//---------[ JOB ]---------//
#define BOX_INDEX            9 // Index Box Barang

#define GetMoney(%0)  pData[%0][pMoney]
#define GetVehicleType(%0)  pvData[%0][cType]
#define GetFactionType(%0)  pData[%0][pFaction]
#define CheckAdmin(%0,%1)   pData[%0][pAdmin] < %1
#define GetPlayerJob(%0)  pData[%0][pJob]

//-----[ eSelection Define ]-----
#define 	SPAWN_SKIN_MALE 		1
#define 	SPAWN_SKIN_FEMALE 		2
#define 	SHOP_SKIN_MALE 			3
#define 	SHOP_SKIN_FEMALE 		4
#define 	VIP_SKIN_MALE 			5
#define 	VIP_SKIN_FEMALE 		6
#define 	SAPD_SKIN_MALE 			7
#define 	SAPD_SKIN_FEMALE 		8
#define 	SAPD_SKIN_WAR 			9
#define 	SAGS_SKIN_MALE 			10
#define 	SAGS_SKIN_FEMALE 		11
#define 	SAMD_SKIN_MALE 			12
#define 	SAMD_SKIN_FEMALE 		13
#define 	SANA_SKIN_MALE 			14
#define 	SANA_SKIN_FEMALE 		15
#define 	SACF_SKIN_MALE 			16
#define 	SACF_SKIN_FEMALE 		17
#define 	TOYS_MODEL 				18
#define 	VIPTOYS_MODEL 			19
#define     VEHICLE_TOYS            20
#define		BARRICADE_OBJECT		21

//Owned
#define MAX_OWN_RESIDENTIAL         (1)
#define MAX_OWN_COMMERCIAL          (1)

#define MAX_INVENTORY 	48
#define MAX_HOUSE_STRUCTURES            (300)
#define MAX_FURNITURE             		(200)
#define MAX_MATERIALS              	 		(16)