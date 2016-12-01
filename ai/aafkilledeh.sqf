#define CAPTIVE_DISTANCE 300 // meters.
#define FIA_SKILL_INCREASE_REWARD 0.05 // increase FIA AI skill by this much when they kill
#define FIA_INFLUENCE_REWARD 0.5 // Influence rewarded when FIA kills AAF
#define CIV_DEATH_AAF_INFLUENCE_REWARD 2 // Influence rewarded when FIA kills civ
#define CIV_DEATH_NATO_PENALTY 1 // Amount is subtracted
#define CIV_DEATH_PLAYER_RATING_PENALTY -500 // Should be negative
#define SURRENDER_DISTANCE 100
#define LEADER_REINFORCE_CHANCE 0.1 // percentage chance leader of this units group calls reinforcements, only happens if group is fleeing
#define FLEE_SCORE_DECREASE_CHANCE 0.5 // chance groupmember may lose courage

params ["_killed", "_killer"];
private ["_coste","_enemy","_grupo"];

// TODO: killer is probably always null thanks to ACE
if (isNull _killer) then {
	_killer = _killed getVariable [ "ace_medical_lastDamageSource", _killer ];
};

// Deactivate this units OPFORSpawn variable so they're not counted in
// "how many enemy units in area" counts.
if (_killed getVariable ["OPFORSpawn",false]) then { _killed setVariable ["OPFORSpawn",nil,true] };
[_killed] spawn fnc_cleanupDeadBody;

if ((side _killer == side_blue) || (captive _killer)) then {
  _grupo = group _killed;
  if (isPlayer _killer) then { // Give player points and set captive status
    [2,_killer,false] call playerScoreAdd;

    if ((captive _killer) && (_killer distance _killed < CAPTIVE_DISTANCE)) then {
      [_killer,false] remoteExec ["setCaptive",_killer];
    };
  } else { // this is an AI - skill them up
    _skill = skill _killer;
    [_killer,_skill + FIA_SKILL_INCREASE_REWARD] remoteExec ["setSkill",_killer];
  };

  if (vehicle _killer isKindOf "StaticMortar") then {
    if (isMultiplayer) then {
      {
        if ((_x distance _killed < CAPTIVE_DISTANCE) and (captive _x)) then { [_x,false] remoteExec ["setCaptive",_x] };
      } forEach playableUnits;
    } else {
      if ((player distance _killed < CAPTIVE_DISTANCE) and (captive player)) then { player setCaptive false };
    };
  };

  if (count weapons _killed < 1) then { // Civillians
    _nul = [CIV_DEATH_NATO_PENALTY,0] remoteExec ["prestige",2]; // remove 1 nato prestige
    _nul = [CIV_DEATH_AAF_INFLUENCE_REWARD,0,getPos _killed] remoteExec ["citySupportChange",2]; //opfor citysupport up by 2
    if (isPlayer _killer) then {_killer addRating CIV_DEATH_PLAYER_RATING_PENALTY}; // Recall rating -2000 switches side to OPFOR
  } else {
    _coste = server getVariable (typeOf _killed); // TODO: YIKES! Need a prefix on this
    if (isNil "_coste") then {diag_log format ["Don't know the cost of %1",typeOf _killed]; _coste = 0};
    [-_coste] remoteExec ["resourcesAAF",2];
    _nul = [FIA_INFLUENCE_REWARD,0,getPos _killed] remoteExec ["citySupportChange",2];
  };

  {
    private _unit_in_group = _x;
    if ((alive _unit_in_group) && (fleeing _unit_in_group)) then {
      if !(_unit_in_group getVariable ["surrendered",false]) then {
        // if within surrender distance and not in a vehicle
        if (([SURRENDER_DISTANCE,1,_unit_in_group,"BLUFORSpawn"] call distanceUnits) and (vehicle _unit_in_group == _unit_in_group)) then {
          [_unit_in_group] spawn surrenderAction;
        } else {
          // If there is an enemy nearby to the leader of this unit group, randomly
          // spawn a patrol response
          if ((_unit_in_group == leader group _unit_in_group) && (random 1 < LEADER_REINFORCE_CHANCE)) then {
            _enemy = _unit_in_group findNearestEnemy _unit_in_group;
            if (!isNull _enemy) then {
              [position _unit_in_group] remoteExec ["patrolCA",HCattack];
            };
          };
          [_unit_in_group,_unit_in_group] spawn cubrirConHumo; // Throw down smoke
        };
      } else { // if we have not surrendered, reconsider fleeing!
        if (random 1 < FLEE_SCORE_DECREASE_CHANCE) then {
          private _courage_score = 0.5 - (_unit_in_group skill "courage");
          private _units_in_group = count units _grupo;
          private _units_in_group_fighting = { alive _x && !(_x getVariable ["surrendered",false]) } count units _grupo;
          private _fleeing_score = _courage_score - (_units_in_group_fighting / _units_in_group)
          _unit_in_group allowFleeing _fleeing_score
        };
      };
    };
  } forEach units _grupo;
};
