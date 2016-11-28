if (!isServer) exitWith {};
if (leader group Petros != Petros) exitWith {};

_tipos   = ["CON","LOG","RES","CONVOY","PR","AS","AS_T"];
_weights = [1.0,1.0,1.0,1.0,1.0,0.2];
_tipo = "";

// Remove any mission types currently active
{
  if (_x in misiones) then {_tipos = _tipos - [_x]};
} forEach _tipos;
if (count _tipos == 0) exitWith {}; // if all mission types active, quit.

_tipo = [_tipos, _weights] call BIS_fnc_selectRandomWeighted;

_nul = [_tipo,true,false] call missionRequest;
