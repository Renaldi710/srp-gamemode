//======== Bus ===========
#define forpoint1 2745.33,-2431.58,13.64
#define forpoint2 2400.02,-2565.49,13.21
#define forpoint3 2752.89,-2392.60,13.64

new ForVeh[4];

AddForVehicle()
{
	ForVeh[0] = AddStaticVehicleEx(530, 2758.74,-2385.79, 13.64, 177.14, -1, -1, VEHICLE_RESPAWN);
	ForVeh[1] = AddStaticVehicleEx(530, 2749.74,-2385.79, 13.64, 177.14, -1, -1, VEHICLE_RESPAWN);
	ForVeh[2] = AddStaticVehicleEx(530, 2752.74,-2385.79, 13.64, 177.14, -1, -1, VEHICLE_RESPAWN);
	ForVeh[3] = AddStaticVehicleEx(530, 2755.74,-2385.79, 13.64, 177.14, -1, -1, VEHICLE_RESPAWN);
}

IsAForVeh(carid)
{
	for(new v = 0; v < sizeof(ForVeh); v++) {
	    if(carid == ForVeh[v]) return 1;
	}
	return 0;
}
