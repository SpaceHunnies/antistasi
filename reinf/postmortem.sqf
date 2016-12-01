#define CLEANUP_DEATH_TIMER_IN_SECONDS 900
// After death, delete unit and their group, if applicable.

params ["_killed"];
sleep CLEANUP_DEATH_TIMER_IN_SECONDS; //randomly sleep for 900 !?!?

deleteVehicle _killed;
_grupo = group _killed;

if ((!isNull _grupo) and ({ alive _x } count units _grupo == 0)) then {
  deleteGroup _grupo;
};

if (_killed in staticsToSave) then {
  staticsToSave = staticsToSave - [_killed];
  publicVariable "staticsToSave";
};
