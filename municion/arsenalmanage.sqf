if (!isServer) exitWith {};
private ["_armasInInventory","_armasInInventoryNoAttachments","_addedWeapons","_lockedWeapon","_armasFinal","_precio","_arma","_armaTrad","_priceAdd","_updated","_magazinesInInventory","_addedMagazines","_magazine","_magazinesFinal","_itemsInInventory","_addedItems","_item","_cuenta","_itemsFinal","_mochisInInventory","_mochisTrad","_addedMochis","_lockedMochi","_mochisFinal","_mochi","_mochiTrad","_armasAttachments","_armaConCosa"];

_updated = "";

_armasInInventory = weaponCargo caja;
_mochisInInventory = backpackCargo caja;
_magazinesInInventory = magazineCargo caja;
_itemsInInventory = itemCargo caja;
private _allUnlockableInventory = _armasInInventory + _mochisInInventory + _magazinesInInventory + _itemsInInventory;

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
			[_object] spawn weaponCheck;
		  [caja,[_object],true,false] call XLA_fnc_addVirtualBackpackCargo;
		};
    default {
			[caja,[_object],true,false] call XLA_fnc_addVirtualItemCargo;
		};
  };
};

_fnc_addBackToInventory = {
	params["_object", "_category"];

	switch(_category) do {
    case "WEAPON": { caja addWeaponCargoGlobal [_object,1] };
    case "MAGAZINE": { caja addMagazineCargoGlobal [_object,1] };
    case "BACKPACK": { caja addBackpackCargoGlobal [_object,1] };
    default { caja addItemCargoGlobal [_object,1] };
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

clearWeaponCargoGlobal caja;
clearBackpackCargoGlobal caja;
clearMagazineCargoGlobal caja;
clearItemCargoGlobal caja;

{
  private _item = _x;
	private _category = [_item] call fnc_objectCategory;
	private _unlockedList = [_category] call fnc_getUnlockedVariableforCategory;
	private _object = [_item, _category] call _fnc_classnameBase;
	if ([_object, ({_x == _object} count _allUnlockableInventory), _category, _unlockedList] call fnc_attemptUnlock) then {
		//Unlocked!
		_unlockedList pushBackUnique _object;
		[_object, _category] call _fnc_updateVirtualCargo;

		_cfg = [_category] call _fnc_getCfgforCategory;
		_updated = format ["%1%2<br/>",_updated,getText (configFile >> _cfg >> _object >> "displayName")];
	} else {
		[_item, _category] call _fnc_addBackToInventory; // item is original classname, not base
	}
} forEach _allUnlockableInventory;

unlockedRifles = unlockedWeapons - hguns -  mlaunchers - rlaunchers - ["Binocular","Laserdesignator","Rangefinder"] - srifles - mguns;
publicVariable "unlockedWeapons";
publicVariable "unlockedRifles";
publicVariable "unlockedItems";
publicVariable "unlockedBackpacks";
publicVariable "unlockedMagazines";
publicVariable "lockedWeapons";
publicVariable "lockedMochis";

_updated
