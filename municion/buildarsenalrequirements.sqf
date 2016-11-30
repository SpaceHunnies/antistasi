/*
 * Builds string of arsenal requirements for UI display
 *
 * Arguments: None
 *
 * Return Value: STRING
 */

private _weapons = ["WEAPON"] call fnc_categoryUnlockThreshold;
private _backpacks = ["BACKPACK"] call fnc_categoryUnlockThreshold;
private _magazines = ["MAGAZINE"] call fnc_categoryUnlockThreshold;
private _optics = ["OPTIC"] call fnc_categoryUnlockThreshold;
private _vests = ["VEST"] call fnc_categoryUnlockThreshold;
private _items = ["ITEM"] call fnc_categoryUnlockThreshold;

format ["Arsenal Unlocking Requirements\nWeapons: %1\nBackpacks: %2\nMagazines/Usables: %3\nOptics: %4\nVests: %5\nOther Items: %6",_weapons,_backpacks,_magazines,_optics,_vests,_items];
