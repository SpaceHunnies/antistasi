if (!isServer) exitWith {};
private ["_armasInInventory","_armasInInventoryNoAttachments","_addedWeapons","_lockedWeapon","_armasFinal","_precio","_arma","_armaTrad","_priceAdd","_updated","_magazinesInInventory","_addedMagazines","_magazine","_magazinesFinal","_itemsInInventory","_addedItems","_item","_cuenta","_itemsFinal","_mochisInInventory","_mochisTrad","_addedMochis","_lockedMochi","_mochisFinal","_mochi","_mochiTrad","_armasAttachments","_armaConCosa"];

// FUNCS

_fnc_getCfgforCategory = {
  params ["_category"];

  switch(_category) do {
    //case "WEAPON": { "CfgWeapons" };
    case "MAGAZINE": { "CfgMagazines" };
    case "BACKPACK": { "CfgVehicles" };
    default { "CfgWeapons" };
  };
};

_fnc_updateVirtualCargo = {
	params["_object", "_category"];

	switch(_category) do {
    case "WEAPON": {
			lockedWeapons = lockedWeapons - [_object];
			[_object] spawn weaponCheck;
		  [caja,[_object],true,false] call XLA_fnc_addVirtualWeaponCargo;
		};
    case "MAGAZINE": {
			[caja,[_object],true,false] call XLA_fnc_addVirtualMagazineCargo;
		};
    case "BACKPACK": {
			lockedMochis = lockedMochis - [_object];
		  [caja,[_object],true,false] call XLA_fnc_addVirtualBackpackCargo;
		};
    default {
			[caja,[_object],true,false] call XLA_fnc_addVirtualItemCargo;
		};
  };
};

_fnc_addBackToInventory = {
	params["_object", "_category", "_quantity"];

	switch(_category) do {
    case "WEAPON": { caja addWeaponCargoGlobal [_object,_quantity] };
    case "MAGAZINE": { caja addMagazineCargoGlobal [_object,_quantity] };
    case "BACKPACK": { caja addBackpackCargoGlobal [_object,_quantity] };
    default { caja addItemCargoGlobal [_object,_quantity] };
  };
};

_fnc_classnameBase = {
	params["_object", "_category"];

	switch(_category) do {
    case "WEAPON": { [_object] call BIS_fnc_baseWeapon };
    case "BACKPACK": { [_object] call BIS_fnc_basicBackpack };
    default { _object };
  };
};

_fnc_unlock = {
  params ["_class", "_category", "_unlockedList"];
  private _cfg = [_category] call _fnc_getCfgforCategory;

  _unlockedList pushBackUnique _class;
  [_class, _category] call _fnc_updateVirtualCargo;
  _updated = format ["%1%2<br/>",_updated,getText (configFile >> _cfg >> _class >> "displayName")];
};

// SCRIPT

_updated = "";

_armasInInventory = weaponCargo caja;
_mochisInInventory = backpackCargo caja;
_magazinesInInventory = magazineCargo caja;
_itemsInInventory = itemCargo caja;
private _allUnlockableInventory = _armasInInventory + _mochisInInventory + _magazinesInInventory + _itemsInInventory;

diag_log _allUnlockableInventory;

_allUnlockableInventoryBaseClass = _allUnlockableInventory apply {
  private _item = _x;
  private _category = [_item] call fnc_objectCategory;
  [_item, _category] call _fnc_classnameBase;
};

diag_log _allUnlockableInventoryBaseClass;

private _allUnlockableInventoryUnique = [];
{ _allUnlockableInventoryUnique pushBackUnique _x; } forEach _allUnlockableInventory;

diag_log _allUnlockableInventoryUnique;

_allUnlockableInvInfo = _allUnlockableInventoryUnique apply {
  private _item = _x;
  private _category = [_item] call fnc_objectCategory;
  private _baseClass = [_item, _category] call _fnc_classnameBase;
  private _numInInventory = {_x == _item} count _allUnlockableInventory;
  private _numBaseClassInInventory = {_x == _baseClass} count _allUnlockableInventoryBaseClass;
  [_item, _category, _baseClass, _numInInventory, _numBaseClassInInventory];
};

diag_log _allUnlockableInvInfo;

clearWeaponCargoGlobal caja;
clearBackpackCargoGlobal caja;
clearMagazineCargoGlobal caja;
clearItemCargoGlobal caja;

{
  private _fullClass = _x select 0;
  private _category = _x select 1;
  private _baseClass = _x select 2;
  private _numFullClass = _x select 3;
  private _numBaseClass = _x select 4;
	private _unlockedList = [_category] call fnc_getUnlockedVariableforCategory;
	if ([_baseClass, _numBaseClass, _category, _unlockedList] call fnc_attemptUnlock) then {
    [_baseClass, _category, _unlockedList] call _fnc_unlock;
	} else {
    // Return to inventory.
    [_fullClass, _category, _numFullClass] call _fnc_addBackToInventory;
  };
} forEach _allUnlockableInvInfo;

unlockedRifles = unlockedWeapons - hguns -  mlaunchers - rlaunchers - ["Binocular","Laserdesignator","Rangefinder"] - srifles - mguns;
publicVariable "unlockedWeapons";
publicVariable "unlockedRifles";
publicVariable "unlockedItems";
publicVariable "unlockedBackpacks";
publicVariable "unlockedMagazines";
publicVariable "lockedWeapons";
publicVariable "lockedMochis";

_updated
