//if (player != Stavros) exitWith {hint "Only Commander can ask for NATO support"};
_tipo = _this select 0;

if (!allowPlayerRecruit) exitWith {hint "Server is very loaded. \nWait one minute or change FPS settings in order to fulfill this request"};
if (_tipo in misiones) exitWith {hint "NATO is already busy with this kind of mission"};
if (!([player] call hasRadio)) exitWith {hint "You need a radio in your inventory to be able to give orders to other squads"};

_bases = bases - mrkAAF;
_aeropuertos = aeropuertos - mrkAAF;

_costeNATO = 5;
_textoHint = "";

switch (_tipo) do {
  case "NATOAmmo": {
    _costeNATO = 5;
    _textohint = "Click on the spot where you want the Ammodrop";
  };
};

_NATOSupp = server getVariable "prestigeNATO";

if (_NATOSupp < _costeNATO) exitWith {hint format ["We lack of enough NATO Support in order to proceed with this request (%1 needed)",_costeNATO]};

if (_tipo == "NATOUAV") exitWith {[] remoteExec [_tipo,HCattack]};

posicionTel = [];

hint format ["%1",_textohint];

openMap true;
onMapSingleClick "posicionTel = _pos;";

waitUntil {sleep 1; (count posicionTel > 0) or (!visibleMap)};
onMapSingleClick "";

if (!visibleMap) exitWith {};

_posicionTel =+ posicionTel;
if ((_tipo != "NATOArmor") or (_tipo == "NATORoadblock")) then {openMap false};

// break, in case no valid point of origin was selected
_salir = false;

// location for the QRF to depart from -- default: NATO carrier
_loc = "spawnNATO";

if (_tipo == "NATOAmmo") exitWith {[_posiciontel,_NATOSupp] remoteExec [_tipo,HCattack]};

_sitio = [marcadores, _posicionTel] call BIS_Fnc_nearestPosition;


if (_posicionTel distance getMarkerPos _sitio > 50) exitWith {hint "You must click near a map marker"};

if (_salir) exitWith {};
