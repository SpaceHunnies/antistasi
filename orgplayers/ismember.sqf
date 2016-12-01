params["_obj"];
if !(isMultiplayer) exitWith { true };
if (isNil "miembros") exitWith { true };
_owner = _obj getVariable ["owner",_obj];
(count miembros > 0) && {(getPlayerUID _owner) in miembros}
