/*
 * Gets unlocked variable for category
 *
 * Arguments:
 * 0: Category <STRING>
 *
 * Return Value: Variable <ARRAY>
 *
 * Modifies Globals: None
 *
 * Example:
 *
 */

params ["_category"];

switch(_category) do {
  case "WEAPON": { unlockedWeapons };
  case "MAGAZINE": { unlockedMagazines };
  case "BACKPACK": { unlockedBackpacks };
  default { unlockedItems };
};
