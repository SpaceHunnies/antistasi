/*
 * Gets arsenal category for an object
 *
 * Arguments:
 * 0: Target item, weapon, backpack or magazine <OBJECT>
 *
 * Return Value: String - e.g. "WEAPON", "MAGAZINE", "NVG", etc
 *
 * Modifies Globals: None
 *
 * Example:
 *
 */

params ["_object"];

if (_object isKindOf ["Rifle", configFile >> "CfgWeapons"]) exitWith { "WEAPON" };
if (_object isKindOf ["Pistol", configFile >> "CfgWeapons"]) exitWith { "WEAPON" };
if (_object isKindOf ["Launcher", configFile >> "CfgWeapons"]) exitWith { "WEAPON" };
if (_object isKindOf ["Throw", configFile >> "CfgWeapons"]) exitWith { "WEAPON" };
if (_object isKindOf ["Put", configFile >> "CfgWeapons"]) exitWith { "WEAPON" };

if (_object isKindOf ["CA_Magazine", configFile >> "CfgMagazines"]) exitWith { "MAGAZINE" };
if (_object isKindOf ["FakeMagazine", configFile >> "CfgMagazines"]) exitWith { "MAGAZINE" }; // Launcher mags

if (_object isKindOf ["BagBase", configFile >> "CfgVehicles"]) exitWith { "BACKPACK" };

if (_object isKindOf ["VestCamoBase", configFile >> "CfgWeapons"]) exitWith { "VEST" };

if (_object isKindOf ["rhs_acc_sniper_base", configFile >> "CfgWeapons"]) exitWith { "OPTIC" };
if (_object isKindOf ["rhsusf_acc_sniper_base", configFile >> "CfgWeapons"]) exitWith { "OPTIC" };

if (_object isKindOf ["NVGoggles", configFile >> "CfgWeapons"]) exitWith { "NVG" };

if (_object isKindOf ["Rangefinder", configFile >> "CfgWeapons"]) exitWith { "RANGEFINDER" };

if (_object isKindOf ["Laserdesignator", configFile >> "CfgWeapons"]) exitWith { "DESIGNATOR" };

// other items
"ITEM"
