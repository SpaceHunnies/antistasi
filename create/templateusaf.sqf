bluHeliTrans =    ["RHS_MELB_MH6M","RHS_UH60M_d","RHS_CH_47F_light"];
bluHeliTS =     ["RHS_MELB_MH6M"];
bluHeliDis =    ["RHS_UH60M_d"];
bluHeliRope =     ["RHS_CH_47F_light"];

bluAS =       ["rhsusf_f22"];
bluC130 =       ["RHS_C130J"];

bluUAV =      ["B_UAV_02_F"];

planesNATO = bluHeliTrans;
planesNATOTrans = bluHeliTrans;

bluIR =   "rhsusf_acc_anpeq15";

bluFlag =   "Flag_NATO_F";

bluRifle =  [
  "rhs_weap_m16a4_carryhandle",
  "rhs_weap_m4a1_carryhandle",
  "rhs_weap_m4a1_d"
];

bluGL = [
  "rhs_weap_m16a4_carryhandle_M203",
  "rhs_weap_m4a1_carryhandle_m203S",
  "rhs_weap_m4a1_m203s_d"
];

bluSNPR =   [
  "rhs_weap_M107_d",
  "rhs_weap_m24sws",
  "rhs_weap_sr25"
];

bluLMG =  [
  "rhs_weap_m240G",
  "rhs_weap_m249_pip_L_para",
  "rhs_weap_m249_pip_S_vfg"
];

bluSmallWpn =   [
  "rhs_weap_M590_5RD",
  "rhsusf_weap_m1911a1"
];

bluRifleAmmo = [
  "rhs_mag_30Rnd_556x45_Mk318_Stanag",
  "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"
];

bluSNPRAmmo = [
  "rhsusf_mag_10Rnd_STD_50BMG_M33",
  "rhsusf_mag_10Rnd_STD_50BMG_mk211",
  "rhsusf_5Rnd_762x51_m118_special_Mag",
  "rhsusf_20Rnd_762x51_m118_special_Mag",
  "20Rnd_762x51_Mag"
];

bluLMGAmmo = [
  "rhsusf_50Rnd_762x51",
  "rhsusf_100Rnd_762x51_m62_tracer",
  "rhs_200rnd_556x45_M_SAW"
];

bluSmallAmmo = [
  "rhsusf_5Rnd_00Buck",
  "rhsusf_5Rnd_FRAG",
  "rhsusf_mag_7x45acp_MHP"
];

bluAmmo = [
  "rhsusf_mag_10Rnd_STD_50BMG_M33",
  "rhsusf_mag_10Rnd_STD_50BMG_mk211",
  "rhs_mag_30Rnd_556x45_Mk318_Stanag",
  "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",
  "rhsusf_20Rnd_762x51_m118_special_Mag",
  "rhsusf_5Rnd_762x51_m118_special_Mag",
  "rhs_200rnd_556x45_M_SAW",
  "rhsusf_5Rnd_00Buck",
  "rhsusf_5Rnd_FRAG",
  "20Rnd_762x51_Mag",
  "rhsusf_100Rnd_762x51_m61_ap",
  "rhsusf_100Rnd_762x51_m62_tracer",
  "rhsusf_mag_7x45acp_MHP"
];

blu40mm = [
  "rhs_mag_M433_HEDP",
  "1Rnd_HE_Grenade_shell",
  "SmokeShell",
  "SmokeShellGreen",
  "rhs_mag_m576"
];

bluGrenade = [
  "HandGrenade",
  "MiniGrenade"
];

bluAT = [
  "rhs_weap_fgm148",
  "rhs_weap_M136_hedp"
];

bluAA = [
  "rhs_weap_fim92"
];

bluVest = [
  "rhsusf_spc_rifleman",
  "rhsusf_spc_crewman"
];

bluScopes = [
  "rhsusf_acc_LEUPOLDMK4",
  "rhsusf_acc_ACOG3_USMC",
  "rhsusf_acc_eotech_552"
];

bluAttachments = [
  "rhsusf_acc_harris_bipod",
  "muzzle_snds_B",
  "rhsusf_acc_anpeq15A",
  "rhsusf_acc_nt4_black"
];

bluATMissile = [
  "rhs_fgm148_magazine_AT"
];

bluAAMissile = [
  "rhs_fim92_mag"
];

bluItems = bluVest + bluScopes + bluAttachments;

genGL = genGL + bluGL;
genATLaunchers = genATLaunchers + bluAT;
genAALaunchers = genAALaunchers + bluAA;
