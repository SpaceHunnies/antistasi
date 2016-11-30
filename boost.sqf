if (!isServer) exitWith{};

scriptName "boost";

server setVariable ["hr",20,true];
server setVariable ["resourcesFIA",10000,true];
server setVariable ["prestigeNATO",30,true];


unlockedWeapons pushBackUnique "rhs_weap_ak74m_camo";
unlockedWeapons pushBackUnique "rhs_weap_rpg26";

unlockedMagazines pushBackUnique "rhs_30Rnd_545x39_AK";
unlockedMagazines pushBackUnique "rhs_rpg26_mag";
unlockedMagazines pushBackUnique "rhs_mag_rgd5";

unlockedItems pushBackUnique "ItemGPS";
unlockedItems pushBackUnique "ItemRadio";
unlockedItems pushBackUnique "rhs_acc_1p29";
unlockedItems pushBackUnique "rhs_6b23_digi_rifleman";
unlockedItems pushBackUnique "rhs_6b28_ess_bala";

unlockedItems pushBackUnique "rhs_acc_1p29";

publicVariable "unlockedWeapons";
publicVariable "unlockedMagazines";
publicVariable "unlockedItems";

if (hayXLA) then {
	[caja,unlockedWeapons,true,false] call XLA_fnc_addVirtualWeaponCargo;
	[caja,unlockedMagazines,true,false] call XLA_fnc_addVirtualMagazineCargo;
	[caja,unlockedItems,true,false] call XLA_fnc_addVirtualItemCargo;
} else {
	[caja,unlockedWeapons,true,false] call BIS_fnc_addVirtualWeaponCargo;
	[caja,unlockedMagazines,true,false] call BIS_fnc_addVirtualMagazineCargo;
	[caja,unlockedItems,true,false] call BIS_fnc_addVirtualItemCargo;
};

[unlockedWeapons] call weaponCheck;
