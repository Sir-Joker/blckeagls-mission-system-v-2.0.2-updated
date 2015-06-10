	
// Place any overrides of the default configurations here.
// An example would be to move the center or change the dimensions for the map on which the missions are spawned so that only part of the map is used.
// Or map-specific configurations if you run the mission system on multiple servers. Our configurations are shown below as an example


diag_log "[blckeagls] Loading Configuration Overides";

if (blck_WorldName == "bornholm") then 
{  // 6022.8906,23.348747,17387.381
	blck_SpawnVeh_Major = 3; //3;
	blck_SpawnVeh_Major2 = 2; //2;
	blck_SpawnVeh_Minor = -1;
	blck_SpawnVeh_Minor2 = 1; //1;
	blck_locationBlackList = blck_locationBlackList + [[[4274,19753,0], 1500]];  //  
	diag_log "[DBD Clan] --- >>> Loading config overides for Bornholm";
};
if (blck_WorldName == "chernarus") then 
{  // 6022.8906,23.348747,17387.381
	blck_SpawnVeh_Major = 3;
	blck_SpawnVeh_Major2 = 2;
	blck_SpawnVeh_Minor = -1;
	blck_SpawnVeh_Minor2 = 1; //1;
	diag_log "[DBD Clan] --- >>> Loading config overides for Chernarus";
};
if (blck_WorldName == "altis") then 
{  // 6022.8906,23.348747,17387.381
	blck_SpawnVeh_Major = 3;
	blck_SpawnVeh_Major2 = 2;
	blck_SpawnVeh_Minor = -1;
	blck_SpawnVeh_Minor2 = 1;
	
	blck_locationBlackList = blck_locationBlackList + [[[10846,10672,12.8],300]];  //  
	
	diag_log "[DBD Clan] --- >>> Loading config overides for Altis";
};
if (blck_debugON) then 
{
	diag_log "[blckeagls] Debug seting is ON, Custom configurations used";
	
	blck_cleanupCompositionTimer = 60;  // Time after mission completion at which items in the composition are deleted.
	blck_AICleanUpTimer = 45;  // Time after mission completion at which any remaining live AI are deleted.
	blck_bodyCleanUpTimer = 300;
	
	//Minimum Spawn time between missions in seconds
		blck_TMin_Major = 5; // Orange
		blck_TMin_Major2 = 4; // Green
		blck_TMin_Minor = 2;  // Blue
		blck_TMin_Minor2 = 3; // Red
	
	//Maximum Spawn time between missions in seconds
		blck_TMax_Major = 10;
		blck_TMax_Major2 = 8;
		blck_TMax_Minor = 4;
		blck_TMax_Minor2 = 6;
		
		blck_aiCleanUpTimer = 30; // in seconds
		
		blck_SpawnVeh_Major = 4;
		blck_SpawnVeh_Major2 = 3;
		blck_SpawnVeh_Minor = 1;
		blck_SpawnVeh_Minor2 = 2;
		
		blck_SkillsBlue = [
		["aimingAccuracy",0.01],
		["aimingShake",0.01],
		["aimingSpeed",0.01],
		["endurance",0.01],
		["spotDistance",0.01],
		["spotTime",0.01],
		["courage",0.01],
		["reloadSpeed",0.80],
		["commanding",0.8],
		["general",1.00]
	];
};



