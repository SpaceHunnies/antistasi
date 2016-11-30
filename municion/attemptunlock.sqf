/*
 * Attempts to unlock a given item in the Arsenal.
 *
 * Arguments:
 * 0: Target item, weapon, backpack or magazine <OBJECT>
 *
 * Return Value: Boolean
 *
 * Modifies Globals: unlocked lists, e.g. unlockedWeapons
 *
 * Example:
 *
 */

params ["_object", "_inventoryCountofObject","_category", "_unlockedList"];

_fnc_hasNumReqToUnlock = {
  params ["_category", "_inventoryCountofObject"];
  private _threshold = [_category, _inventoryCountofObject] call fnc_categoryUnlockThreshold;
  diag_log format ["%1, %2", _inventoryCountofObject, _threshold];
  _inventoryCountofObject >= _threshold;
};

_fnc_hasMagazine = {
  params["_object", "_category"];
  if (_category isEqualTo "WEAPON") then {
    _magazines = getArray (configFile / "CfgWeapons" / _object / "magazines");
    private _ary = unlockedMagazines arrayIntersect _magazines;
    !(_ary isEqualTo []);
  } else {
    true
  };
};

!(_object in _unlockedList) && { [_object, _category] call _fnc_hasMagazine } && { [_category, _inventoryCountofObject] call _fnc_hasNumReqToUnlock };
