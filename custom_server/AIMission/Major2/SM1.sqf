/*
  Code by blckeagls
  Modified by Ghostrider
  See Major\SM1.sqf for comments
*/

private ["_coords","_crate","_aiGroup","_numAIGrp","_arc","_dir","_dist","_xpos","_ypos","_newPos","_objects","_startMsg","_endMsg","_missionObjs","_compositions","_missionCfg","_compSel","_mines"];
diag_log "[blckeagls] Starting GREEN mission SM1";

_coords = _this select 0;
_objects = [];
_mines = [];

#include "\q\addons\custom_server\AIMission\Major2\compositions\compositionsGreen.sqf"; 

_compositions = 
[
	//"resupplyCamp",
	//"redCamp",
	//"medicalCamp"
	//"default"
];

_compSel = _compositions call BIS_fnc_selectRandom;
diag_log format["[blckeagls] Green Mission composition = %1 ",_compSel];
// Select a mission configuration and load the data into _missionCfg
switch (_compositions call BIS_fnc_selectRandom) do 
{
	case "default": {_missionCfg = _default};
	case "medicalCamp": {_missionCfg = _medicalCamp};
	case "redCamp": {_missionCfg = _redCamp};
	case "resupplyCamp": {_missionCfg = _resupplyCamp};
};

// Parse the _missionCfg into messages and a list of objects for clarity of code
_startMsg = _missionCfg select 0 select 0;
_endMsg = _missionCfg select 0 select 1;
_missionObjs = _missionCfg select 1;

//Sends message to all players about the AI Mission

[_startMsg] call blck_MessagePlayers;

C2coords = _coords;

publicVariable "C2coords";
[] execVM "debug\addmarkers2.sqf";

waitUntil{ {isPlayer _x && _x distance _coords <= blck_TriggerDistance /*&& vehicle _x == _x*/} count playableunits > 0 };

//Creates the crate
_crate = [_coords] call blck_spawnCrate;
_objects = [_coords, round(random(360)),_missionObjs,true] call blck_spawnCompositionObjects;
[_crate,blck_BoxesLoot_Major2,blck_lootCountsMajor2 select 0, blck_lootCountsMajor2 select 1, blck_lootCountsMajor2 select 2, blck_lootCountsMajor2 select 3, blck_lootCountsMajor2 select 4] call blck_fillBoxes;

if (blck_useSmokeAtCrates) then  // spawn a fire and smoke near the crate
{
	private ["_temp"];
	_temp = [_coords] call blck_smokeAtCrates;
	_objects = _objects + _temp;
};
if (blck_useMines) then
{
	_mines = [_coords] call blck_spawnMines;
};
_numAIGrp = round((blck_MinAI_Major2 + round(random(blck_MaxAI_Major2 - blck_MinAI_Major2)))/blck_AIGrps_Major2);
_arc = 360/blck_AIGrps_Major2;
_dir = random 360;
_dist = (20+(random 15));
for "_i" from 1 to blck_AIGrps_Major2 do {
	_dist = (20+(random 15));
	_xpos = (_coords select 0) + sin (_dir) * _dist;
	_ypos = (_coords select 1) + cos (_dir) * _dist;
	_newPos = [_xpos,_ypos,0];
	_aiGroup = [_newPos,_numAIGrp,_numAIGrp+1,"green"] call blck_spawnGroup;
	blck_AIMajor2 = blck_AIMajor2 + _aiGroup;
	_dir = _dir + _arc;
};
if (blck_useStatic) then 
{
	if (blck_SpawnVeh_Major2 == 1) then
	{
		_aiGroup = [_coords,1,1,"GREEN"] call blck_spawnGroup;
		blck_AIMajor2 = blck_AIMajor2 + _aiGroup;
		_veh = [_coords,_aiGroup,blck_staticWeapons call BIS_fnc_selectRandom] call blck_spawnEmplacedWeapon;
		_objects = _objects + [_veh];
	};
	if (blck_SpawnVeh_Major2 > 1) then
	{
		_arc = 360/blck_SpawnVeh_Major2;
		_dir = random 360;
		_dist = (15+(random 10));
		for "_i" from 1 to blck_SpawnVeh_Major2 do
		{ 
			_dir = _dir + _arc;
			if (_dir > 360) then {_dir = _dir - 360};
			_xpos = (_coords select 0) + sin (_dir) * _dist;
			_ypos = (_coords select 1) + cos (_dir) * _dist;
			_newPos = [_xpos,_ypos,0];		
			_aiGroup = [_coords,1,1,"GREEN"] call blck_spawnGroup;
			blck_AIMajor2 = blck_AIMajor2 + _aiGroup;
			_veh = [_coords,_aiGroup,blck_staticWeapons call BIS_fnc_selectRandom] call blck_spawnEmplacedWeapon;
			_objects = _objects + [_veh];
		};
	};	
};
waitUntil{{isPlayer _x && _x distance _crate < 10 && vehicle _x == _x  } count playableunits > 0};
[_mines] call blck_clearMines;
[_endMsg] call blck_MessagePlayers;
[_objects, blck_cleanupCompositionTimer] spawn blck_cleanupObjects;
MissionGoMajor2 = false;