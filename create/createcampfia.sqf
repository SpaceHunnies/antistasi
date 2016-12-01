if (!isServer and hasInterface) exitWith {};

private ["_marcador","_posicion","_grupo","_campGroup","_fire"];

_objs = [];

_marcador = _this select 0;
_posicion = getMarkerPos _marcador;

_camp = [] call cmpCamp;
_posicion = _posicion findEmptyPosition [5,50,"I_Heli_Transport_02_F"];
0 = [_posicion, floor(random 361), _camp] call BIS_fnc_ObjectsMapper;

{
  if (str typeof _x find campCrate > -1) then {_nul = [_x] call cajaAAF; [[_x,"heal_camp"],"flagaction"] call BIS_fnc_MP;};
  if (str typeof _x find "Land_MetalBarrel_F" > -1) then {[[_x,"refuel"],"flagaction"] call BIS_fnc_MP;};
  if (str typeof _x find "Land_Campfire_F" > -1) then {_fire = _x;};
} forEach nearestObjects [_posicion, [], 15];

_grupo = [_posicion, side_blue, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_SniperTeam_M")] call BIS_Fnc_spawnGroup;
_grupo setBehaviour "STEALTH";
_grupo setCombatMode "GREEN";


{[_x] spawn FIAinitBASES;} forEach units _grupo;

sleep 10;
_fire inflame true;

waitUntil {sleep 5; (not(spawner getVariable _marcador)) or ({alive _x} count units _grupo == 0) or (not(_marcador in campsFIA))};

if ({alive _x} count units _grupo == 0) then
  {
  campsFIA = campsFIA - [_marcador]; publicVariable "campsFIA";
  campList = campList - [[_marcador, markerText _marcador]]; publicVariable "campList";
  usedCN = usedCN - [markerText _marcador]; publicVariable "usedCN";
  marcadores = marcadores - [_marcador]; publicVariable "marcadores";
  deleteMarker _marcador;
  [["TaskFailed", ["", "Camp Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
  };

waitUntil {sleep 5; (not(spawner getVariable _marcador)) or (not(_marcador in campsFIA))};

{deleteVehicle _x} forEach units _grupo;
deleteGroup _grupo;

//[_posicion, "campFIA"] remoteExec ["despawnCamp"];
[_posicion, "camp"] remoteExec ["despawnCamp"];
