new ServerMoney, //2255.92, -1747.33, 1014.77
	Material,
	MaterialPrice,
	LumberPrice,
	Component,
	ComponentPrice,
	MetalPrice,
	GasOil,
	GasOilPrice,
	CoalPrice,
	Product,
	ProductPrice,
	Apotek,
	MedicinePrice,
	MedkitPrice,
	Food,
	FoodPrice,
	SeedPrice,
	PotatoPrice,
	WheatPrice,
	OrangePrice,
	Marijuana,
	MarijuanaPrice,
	FishPrice,
	GStationPrice,
	ObatMyr,
	ObatPrice,
	StockCrateCompo,
	StockCrateFish,
	StockCratePlant,
	StockCrateLumber
;
	
new MoneyPickup,
	Text3D:MoneyText,
	MatPickup,
	Text3D:MatText,
	CompPickup,
	Text3D:CompText,
	GasOilPickup,
	Text3D:GasOilText,
	OrePickup,
	Text3D:OreText,
	ProductPickup,
	Text3D:ProductText,
	ApotekPickup,
	Text3D:ApotekText,
	FoodPickup,
	Text3D:FoodText,
	DrugPickup,
	Text3D:DrugText,
	ObatPickup,
	Text3D:ObatText,
	Text3D:FishCrateText,
	Text3D:PlantText,
	Text3D:LumberText,
	Text3D:LumberjackText,
	Text3D:CompoCrateText,
	STREAMER_TAG_OBJECT:SELLFISH,
	STREAMER_TAG_OBJECT:SELLFARM2,
	Text3D:Crack
;
	
CreateServerPoint()
{
	if(IsValidDynamic3DTextLabel(MoneyText))
            DestroyDynamic3DTextLabel(MoneyText);

	if(IsValidDynamicPickup(MoneyPickup))
		DestroyDynamicPickup(MoneyPickup);
			
	//Server Money
	new strings[1024];
	MoneyPickup = CreateDynamicPickup(1239, 23, 2255.92, -1747.33, 1014.77, -1, -1, -1, 15.0);
	format(strings, sizeof(strings), "[Server Money]\n"WHITE_E"Goverment Money: "LG_E"%s", FormatMoney(ServerMoney));
	MoneyText = CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2255.92, -1747.33, 1014.77, 15.0);
	
	//if(IsValidDynamic3DTextLabel(MatText))
        //DestroyDynamic3DTextLabel(MatText);

	if(IsValidDynamicPickup(MatPickup))
		DestroyDynamicPickup(MatPickup);
	
	if(IsValidDynamic3DTextLabel(CompText))
        DestroyDynamic3DTextLabel(CompText);

	if(IsValidDynamicPickup(CompPickup))
		DestroyDynamicPickup(CompPickup);
	
	//if(IsValidDynamic3DTextLabel(GasOilText))
            //DestroyDynamic3DTextLabel(GasOilText);

	//if(IsValidDynamicPickup(GasOilPickup))
		//DestroyDynamicPickup(GasOilPickup);
		
	if(IsValidDynamic3DTextLabel(OreText))
            DestroyDynamic3DTextLabel(OreText);

	if(IsValidDynamicPickup(OrePickup))
		DestroyDynamicPickup(OrePickup);
		
	//if(IsValidDynamic3DTextLabel(ProductText))
           //DestroyDynamic3DTextLabel(ProductText);
		
	//if(IsValidDynamicPickup(ProductPickup))
		//DestroyDynamicPickup(ProductPickup);

	if(IsValidDynamic3DTextLabel(ApotekText))
            DestroyDynamic3DTextLabel(ApotekText);
		
	if(IsValidDynamicPickup(ApotekPickup))
		DestroyDynamicPickup(ApotekPickup);
	
	if(IsValidDynamic3DTextLabel(FoodText))
            DestroyDynamic3DTextLabel(FoodText);
		
	if(IsValidDynamicPickup(FoodPickup))
		DestroyDynamicPickup(FoodPickup);
		
	if(IsValidDynamic3DTextLabel(DrugText))
            DestroyDynamic3DTextLabel(DrugText);
		
	if(IsValidDynamicPickup(DrugPickup))
		DestroyDynamicPickup(DrugPickup);

	if(IsValidDynamic3DTextLabel(ObatText))
        DestroyDynamic3DTextLabel(ObatText);
		
	if(IsValidDynamicPickup(ObatPickup))
		DestroyDynamicPickup(ObatPickup);

	if(IsValidDynamic3DTextLabel(LumberText))
        DestroyDynamic3DTextLabel(LumberText);

	if(IsValidDynamicObject(SELLFARM2))
        DestroyDynamicObject(SELLFARM2);

	if(IsValidDynamicObject(SELLFISH))
        DestroyDynamicObject(SELLFISH);

	SELLFISH = CreateDynamicObject(18244, 2843.075195, -1516.672241, 16.355049, 88.599990, 89.999992, 0.000000, -1, -1, -1, 300.00, 300.00); 
	format(strings,sizeof(strings),""PINK_E"Fish Factory\n"WHITE_E"Fish Price: \n"GREEN_E"%s"WHITE_E"/lb", FormatMoney(FishPrice));
	SetDynamicObjectMaterialText(SELLFISH, 0, strings, 130, "Arial", 40, 1, 0xFFFFFFFF, 0xFF000000, 1);

	//Plant Farmer
	SELLFARM2 = CreateDynamicObject(18244, -371.336853, -1427.711547, 30.534753, 93.300041, -0.499999, -90.200012);
	format(strings,sizeof(strings),""PURPLE_E2"Plant Price\n{FFFFFF}Wheat: "GREEN_E"%s"WHITE_E"\nPotato: "GREEN_E"%s"WHITE_E"\nOrange: "GREEN_E"%s"WHITE_E"", FormatMoney(WheatPrice), FormatMoney(PotatoPrice), FormatMoney(OrangePrice));
	SetDynamicObjectMaterialText(SELLFARM2, 0, strings, 100, "Arial", 25, 1, 0xFFFFFFFF, 0xFF000000, 1);

	FoodPickup = CreateDynamicPickup(1239, 23, 2729.6711,-2451.4734,17.5937, -1, -1, -1, 15.0);
	format(strings, sizeof(strings), "[Food]\n"WHITE_E"Food Stock: "LG_E"%d\n\n"WHITE_E"Food Price: "LG_E"%s /item\n"YELLOW"/buyfood",
	Food, FormatMoney(FoodPrice));
	FoodText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 2729.6711,-2451.4734,17.5937, 15.0); // food
	
	//JOBS
	//MatPickup = CreateDynamicPickup(1239, 23, -258.54, -2189.92, 28.97, -1, -1, -1, 15.0);
	//format(strings, sizeof(strings), "[Material]\n"WHITE_E"Material Stock: "LG_E"%d\n\n"WHITE_E"Material Price: "LG_E"%s /item\n"LB_E"/buy", Material, FormatMoney(MaterialPrice));
	//MatText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -258.54, -2189.92, 28.97, 15.0); // lumber
	
	CompPickup = CreateDynamicPickup(1239, 23, 854.6860,-604.8564,18.4219, -1, -1, -1, 15.0);
	format(strings, sizeof(strings), "[Component Storage]\n"WHITE_E"Component Stock: "LG_E"%d\n\n"WHITE_E"Component Price: "LG_E"%s /item\n"LB_E"/buycomponent", Component, FormatMoney(ComponentPrice));
	CompText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 854.6860,-604.8564,18.4219, 15.0); // comp
	
	//GasOilPickup = CreateDynamicPickup(1239, 23, 375.6953,869.5052,20.4063, -1, -1, -1, 15.0);
	//format(strings, sizeof(strings), "[Miner]\n"WHITE_E"GasOil Stock: "LG_E"%d liters\n\n"WHITE_E"GasOil Price: "LG_E"%s /liters\n"LB_E"/buy", GasOil, FormatMoney(GasOilPrice));
	//GasOilText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 375.6953,869.5052,20.4063, 15.0); // gasoil
	
	OrePickup = CreateDynamicPickup(1239, 23, 273.7129,1358.4484,10.5859, -1, -1, -1, 15.0);
	format(strings, sizeof(strings), "[Miner]\n"WHITE_E"Ore Metal Price: "LG_E"%s / item\n\n"WHITE_E"Ore Coal Price: "LG_E"%s /item\n"LB_E"/ore sell", FormatMoney(MetalPrice), FormatMoney(CoalPrice));
	OreText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 273.7129,1358.4484,10.5859, 15.0); // sell ore

	CreateDynamicPickup(1239, 23, -1425.8391,-1529.2734,102.2214, -1, -1, -1, 15.0);
	format(strings, sizeof(strings), "[Lumberjack]\n"WHITE_E"Lumber Price: "LG_E"%s / item\n\n"LB_E"/lum unload", FormatMoney(LumberPrice));
	LumberText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -1425.8391,-1529.2734,102.2214, 15.0); // sell ore
	
	//ProductPickup = CreateDynamicPickup(1239, 23, -279.67, -2148.42, 28.54, -1, -1, -1, 15.0);
	//format(strings, sizeof(strings), "[PRODUCT]\n"WHITE_E"Product Stock: "YELLOW"%d/1500\n\n"WHITE_E"Product Price: "LG_E"%s /item\n"LB_E"/buy /sellproduct", Product, FormatMoney(ProductPrice));
	//ProductText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -279.67, -2148.42, 28.54, 15.0); // product
	
	ApotekPickup = CreateDynamicPickup(1241, 23, -1265.5786,-417.8357,14.1784, -1, -1, -1, 15.0);
	format(strings, sizeof(strings), "[Hospital]\n"WHITE_E"Apotek Stock: "LG_E"%d\n"LB_E"/buy", Apotek);
	ApotekText = CreateDynamic3DTextLabel(strings, COLOR_PINK, -1265.5786,-417.8357,14.1784, 15.0); // Apotek hospital
	
	//DrugPickup = CreateDynamicPickup(1239, 23, 333.6938,1124.4623,1083.8903, -1, -1, -1, 15.0);
	//format(strings, sizeof(strings), "[Black Market]\n"WHITE_E"Marijuana Stock: "LG_E"%d\n\n"WHITE_E"Marijuana Price: "LG_E"%s /item\n"LB_E"/buy /sellmarijuana", Marijuana, FormatMoney(MarijuanaPrice));
	//DrugText = CreateDynamic3DTextLabel(strings, COLOR_GREY, 333.6938,1124.4623,1083.8903, 15.0); // product

	ObatPickup = CreateDynamicPickup(1241, 23, -1274.8046,-423.5040,14.1784, -1, -1, -1, 15.0);
	format(strings, sizeof(strings), "[Obat Myricous]\n"WHITE_E"Myricous Stock: "LG_E"%d\n\n"WHITE_E"Myricous Price: "LG_E"%s /item\n"LB_E"/buy", ObatMyr, FormatMoney(ObatPrice));
	ObatText = CreateDynamic3DTextLabel(strings, COLOR_GREY, -1274.8046,-423.5040,14.1784, 15.0); // product
}

Server_Percent(price)
{
    return floatround((float(price) / 100) * 85);
}

Server_AddPercent(price)
{
    new money = (price - Server_Percent(price));
    ServerMoney = ServerMoney + money;
    Server_Save();
}

Server_AddMoney(amount)
{
    ServerMoney = ServerMoney + amount;
    Server_Save();
}

Server_MinMoney(amount)
{
    ServerMoney -= amount;
    Server_Save();
}

Server_Save()
{
    new str[2024];

	//CreateServerPoint();
    format(str, sizeof(str), "UPDATE server SET servermoney='%d', material='%d', materialprice='%d', lumberprice='%d', component='%d', componentprice='%d', metalprice='%d', gasoil='%d', gasoilprice='%d', coalprice='%d', product='%d', productprice='%d', medicineprice='%d', medkitprice='%d', food='%d', foodprice='%d', seedprice='%d', potatoprice='%d', wheatprice='%d', orangeprice='%d', marijuana='%d', marijuanaprice='%d', fishprice='%d', gstationprice='%d', obatmyr='%d', obatprice='%d', fishcrate='%d', plantcrate='%d', lumbercrate='%d', compcrate='%d' WHERE id=0",
	ServerMoney, Material, MaterialPrice, LumberPrice, Component, ComponentPrice, MetalPrice, GasOil, GasOilPrice, CoalPrice, Product, ProductPrice, MedicinePrice, MedkitPrice, 
	Food, FoodPrice, SeedPrice, PotatoPrice, WheatPrice, OrangePrice, Marijuana, MarijuanaPrice, FishPrice, GStationPrice, ObatMyr, ObatPrice, StockCrateFish, StockCratePlant, StockCrateLumber, StockCrateCompo);
    return mysql_tquery(g_SQL, str);
}

function LoadServer()
{
	cache_get_value_name_int(0, "servermoney", ServerMoney);
	cache_get_value_name_int(0, "material", Material);
	cache_get_value_name_int(0, "materialprice", MaterialPrice);
	cache_get_value_name_int(0, "lumberprice", LumberPrice);
	cache_get_value_name_int(0, "component", Component);
	cache_get_value_name_int(0, "componentprice", ComponentPrice);
	cache_get_value_name_int(0, "metalprice", MetalPrice);
	cache_get_value_name_int(0, "gasoil", GasOil);
	cache_get_value_name_int(0, "gasoilprice", GasOilPrice);
	cache_get_value_name_int(0, "coalprice", CoalPrice);
	cache_get_value_name_int(0, "product", Product);
	cache_get_value_name_int(0, "productprice", ProductPrice);
	cache_get_value_name_int(0, "apotek", Apotek);
	cache_get_value_name_int(0, "medicineprice", MedicinePrice);
	cache_get_value_name_int(0, "medkitprice", MedkitPrice);
	cache_get_value_name_int(0, "food", Food);
	cache_get_value_name_int(0, "foodprice", FoodPrice);
	cache_get_value_name_int(0, "seedprice", SeedPrice);
	cache_get_value_name_int(0, "potatoprice", PotatoPrice);
	cache_get_value_name_int(0, "wheatprice", WheatPrice);
	cache_get_value_name_int(0, "orangeprice", OrangePrice);
	cache_get_value_name_int(0, "marijuana", Marijuana);
	cache_get_value_name_int(0, "marijuanaprice", MarijuanaPrice);
	cache_get_value_name_int(0, "fishprice", FishPrice);
	cache_get_value_name_int(0, "gstationprice", GStationPrice);
	cache_get_value_name_int(0, "obatmyr", ObatMyr);
	cache_get_value_name_int(0, "obatprice", ObatPrice);
	cache_get_value_name_int(0, "cratefish", StockCrateFish);
	cache_get_value_name_int(0, "cratelumber", StockCrateLumber);
	cache_get_value_name_int(0, "crateplant", StockCratePlant);
	cache_get_value_name_int(0, "compcrate", StockCrateCompo);
	printf("[Server] Number of Loaded Data Server...");
	printf("[Server] ServerMoney: %d", ServerMoney);
	//printf("[Server] Material: %d", Material);
	//printf("[Server] MaterialPrice: %d", MaterialPrice);
	//printf("[Server] LumberPrice: %d", LumberPrice);
	
	CreateServerPoint();
}
