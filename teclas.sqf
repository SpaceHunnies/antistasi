_handled = false;
if (player getVariable ["inconsciente",false]) exitWith {_handled};
if (player getVariable ["owner",player] != player) exitWith {_handled};
_key = _this select 1;
if (_key == 21) then {
  if (_this select 2) then {
    if (player == stavros) then {
      [] spawn artySupport;
    };
  }
  else {
    if (player == stavros) then {
      closedialog 0;
      _nul = createDialog "radio_comm_commander";
    }
    else {
      closedialog 0;
      _nul = createDialog "radio_comm_player";
    };
  };
}
else
  {

  if (isMultiplayer) then {
  if (_key == 207) then
    {
    if (!hayACEhearing) then
      {
      if (soundVolume <= 0.5) then
        {
        0.5 fadeSound 1;
        hintSilent "You've taken out your ear plugs.";
        }
      else
        {
        0.5 fadeSound 0.1;
        hintSilent "You've inserted your ear plugs.";
        };
      };
    };
  }
  else {
    if (!hayACEhearing) then {
      if (_key == 207) then {
        0.5 fadeSound 0.1;
        hintSilent "You've inserted your ear plugs.";
      };
      if (_key == 199) then {
        0.5 fadeSound 1;
        hintSilent "You've taken out your ear plugs.";
      };
    };
  };
};

// teleport on ctrl-shift-num5
if (_key == 76) then {
  if ((_this select 3) && (_this select 2)) then {
    [] spawn teleport;
  };
};

_handled