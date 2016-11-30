/*
 * Returns number of items required to unlock the next item in category
 *
 * Arguments:
 * 0: Category <STRING>
 *
 * Return Value: Boolean
 *
 * Modifies Globals: none
 *
 * Example:
 *
 */

// Coefficent applied to number of factories. FACTORY_BONUS * factories is
// subtracted from unlock requirements.
#define FACTORY_BONUS 2

// Base number required to unlock
#define BASE_MAG_UNLOCK 10
#define BASE_WEP_UNLOCK 10
#define BASE_BACKPACK_UNLOCK 5
#define BASE_VEST_UNLOCK 5
#define BASE_OPTIC_UNLOCK 10
#define BASE_ITEM_UNLOCK 10
#define BASE_NVG_UNLOCK 5
#define BASE_RANGEFINDER_UNLOCK 5
#define BASE_DESIGNATOR_UNLOCK 5

params ["_category"];

_fnc_baseUnlockforCategory = {
  params ["_category"];

  switch(_category) do {
    case "WEAPON": { BASE_WEP_UNLOCK };
    case "MAGAZINE": { BASE_MAG_UNLOCK };
    case "BACKPACK": { BASE_BACKPACK_UNLOCK };
    case "VEST": { BASE_VEST_UNLOCK };
    case "OPTIC": { BASE_OPTIC_UNLOCK };
    case "NVG": { BASE_NVG_UNLOCK };
    case "RANGEFINDER": { BASE_RANGEFINDER_UNLOCK };
    case "DESIGNATOR": { BASE_DESIGNATOR_UNLOCK };
    default { BASE_ITEM_UNLOCK };
  };
};

_fnc_initialUnlockforCategory = {
  params ["_category"];

  switch(_category) do {
    case "WEAPON": { unlockedWeaponsInitial };
    case "MAGAZINE": { unlockedMagazinesInitial };
    case "BACKPACK": { unlockedBackpacksInitial };
    default { unlockedItemsInitial };
  };
};

private _unlockedList = [_category] call fnc_getUnlockedVariableforCategory;
private _baseUnlock = [_category] call _fnc_baseUnlockforCategory;
private _unlockedInitial = [_category] call _fnc_initialUnlockforCategory;
private _fabricas = count (fabricas - mrkAAF);

_baseUnlock + (count _unlockedList) - _unlockedInitial - (FACTORY_BONUS*_fabricas);
