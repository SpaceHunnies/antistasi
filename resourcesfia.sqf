#define RESOURCE_SCALE_FACTOR 2

params ["_hr", "_resourcesFIA"];

private ["_hr","_resourcesFIA","_hrT","_resourcesFIAT"];
waitUntil {!resourcesIsChanging};
resourcesIsChanging = true;

if (isNil "_resourcesFIA") then {diag_log "Tienes algún coste sin definit en las tablas de FIA"};
if ((isNil "_hr") or (isNil "_resourcesFIA")) exitWith {};

if (_hr > 0) then {
  _hr = _hr * RESOURCE_SCALE_FACTOR;
};
if (_resourcesFIA > 0) then {
  _resourcesFIA = _resourcesFIA * RESOURCE_SCALE_FACTOR;
};

_hrT = server getVariable "hr";
_resourcesFIAT = server getVariable "resourcesFIA";

_hrT = _hrT + _hr;
_resourcesFIAT = round (_resourcesFIAT + _resourcesFIA);

if (_hrT < 0) then {_hrT = 0};
if (_resourcesFIAT < 0) then {_resourcesFIAT = 0};

server setVariable ["hr",_hrT,true];
server setVariable ["resourcesFIA",_resourcesFIAT,true];
resourcesIsChanging = false;

_texto = "";
_hrSim = "";
if (_hr > 0) then {_hrSim = "+"};

_resourcesFIASim = "";
if (_resourcesFIA > 0) then {_resourcesFIASim = "+"};
if ((_hr != 0) and (_resourcesFIA != 0)) then
  {
  _texto = format ["<t size='0.6' color='#C1C0BB'>FIA Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>HR: %3%1<br/>Money: %4%2 €",_hr,_resourcesFIA,_hrSim,_resourcesFIASim]
  }
else
  {
  if (_hr != 0) then {_texto = format ["<t size='0.6' color='#C1C0BB'>FIA Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>HR: %3%1",_hr,_resourcesFIA,_hrSim]} else {_texto = format ["<t size='0.6' color='#C1C0BB'>FIA Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>Money: %4%2 €",_hr,_resourcesFIA,_hrSim,_resourcesFIASim]};
  };

if (_texto != "") then {[petros,"income",_texto] remoteExec ["commsMP",stavros]};
