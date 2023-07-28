-- Loadout Vars
local LB_TO_KG = 0.453592
local Cx_ExTank	= 0.0020065789473684    -- Drag Count of 12.2a
local W_ExTank	= 145.0
local Tank_Capacity = 3965.0 * LB_TO_KG -- 610gal at 6.5lb/gal to kg (3965lb)

local LAU_88_mass  = 211
local LAU_117_mass = 59

local m61_20_heit_red_tracer = {
  category = CAT_SHELLS,
  name = "M61_20_HEIT_RED",
  user_name = _("20mm red tracer"),
  model_name     = "tracer_bullet_red",
  v0             = 1050.0,
  Dv0            = 0.0060,
  Da0            = 0.0015,
  Da1            = 0.0,
  mass           = 0.100,
  round_mass     = 0.260,
  cartridge_mass = 0.120,			-- cases are collected
  explosive      = 0.110,			-- 0.0170 kg in real
  life_time      = 30,
  caliber        = 20.0,
  s              = 0.0,
  j              = 0.0,
  l              = 0.0,
  charTime       = 0,
  cx             = {0.2,1.27,0.65,0.26,2.35},
  k1             = 2.3e-08,
  tracer_off     = 6,
  cartridge      = 0,
}
declare_weapon(m61_20_heit_red_tracer)

local function m61(tbl)

    tbl.category = CAT_GUN_MOUNT
    tbl.name =  "M-61"
    tbl.display_name =  _("M-61")
    tbl.supply      =
    {
        shells = {"M61_20_HEIT_RED", "M61_20_HE_INVIS", "M61_20_PGU28"},
        mixes  = {{3, 3, 3, 3, 1},	-- PGU-28/B SAPHEI
				  {2, 2, 2, 2, 1}},	-- M56 HEI
        count  = 510,
    }
    if tbl.mixes then
       tbl.supply.mixes = tbl.mixes
       tbl.mixes        = nil
    end
    tbl.gun =
    {
        max_burst_length    = 100000,
        rates               = {6000, 4000},
        recoil_coeff        = 0.7*1.3,
        barrels_count       = 1,
    }
    if tbl.rates then
       tbl.gun.rates        =  tbl.rates
       tbl.rates            = nil
    end

    tbl.ejector_pos             = {-0.5, -0.5,  0.0}
    tbl.ejector_pos_connector   = tbl.ejector_pos_connector     or  "Gun_point"
    tbl.ejector_dir             = {-2.0, -5.0,  0.0}
    tbl.supply_position         = {1.5, 0.0, 0.5}
    tbl.aft_gun_mount           = false
    tbl.effective_fire_distance = 2700
    tbl.drop_cartridge          = 0
    tbl.muzzle_pos              = {0,0,0}     -- all position from connector
    tbl.muzzle_pos_connector    = "GUN_POINT" -- all position from connector
    tbl.azimuth_initial         = 0
    tbl.elevation_initial       = 2.0
    tbl.smoke_dir               = {0, 0, 0}
    return declare_weapon(tbl)
end

-- EXTERNAL FUEL TANKS
declare_loadout({
	category		= CAT_FUEL_TANKS,
	name			= "F-15E_Drop_Tank",
	CLSID			= "{F15E_EXTTANK}",
	attribute		=  {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
	Picture			= "PTB.png",
	displayName		= _("Fuel tank 610 gal"),
	Weight_Empty	= W_ExTank,
	Weight			= W_ExTank + Tank_Capacity,
	Capacity    	= Tank_Capacity,
	Cx_pil			= Cx_ExTank,
	shape_table_data =
	{
		{
			name	= "F-15E_Drop_Tank";
			file	= "F-15E_Drop_Tank";
			life	= 1;
			fire	= { 0, 1};
			username	= "F-15E_Drop_Tank";
			index	= WSTYPE_PLACEHOLDER;
		},
	},
	Elements		= {{ShapeName	= "F-15E_Drop_Tank"}},
})

declare_loadout({
	category		= CAT_FUEL_TANKS,
	name			= "F-15E_Drop_Tank_Empty",
	CLSID			= "{F15E_EXTTANK_EMPTY}",
	attribute		=  {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
	Picture			= "PTB.png",
	displayName		= _("Fuel tank 610 gal (Empty)"),
	Weight_Empty	= W_ExTank,
	Weight			= W_ExTank,  -- Tank starts empty
	Capacity    	= Tank_Capacity,  
	Cx_pil			= Cx_ExTank,
	shape_table_data =
	{
		{
			name	= "F-15E_Drop_Tank_Empty";
			file	= "F-15E_Drop_Tank";
			life	= 1;
			fire	= { 0, 1};
			username	= "F-15E_Drop_Tank_Empty";
			index	= WSTYPE_PLACEHOLDER;
		},
	},
	Elements		= {{ShapeName	= "F-15E_Drop_Tank"}},
})

-- TGPs
declare_loadout({
	category 		= CAT_PODS,
	CLSID			= "{F-15E_AAQ-13_LANTIRN}",
	Picture			= "AAQ-13.png",
	attribute		= {4, 15, 44,	WSTYPE_PLACEHOLDER},
	Weight			= 520 * LB_TO_KG,
	Cx_pil			= 0.0015625,  -- Drag Count of 9.5
	displayName		= _("AN/AAQ-13 LANTIRN NAV POD"),

	shape_table_data =
	{
		{
			file = "F-15E_AAQ-13_LANTIRN",
			life = 1,
			fire = { 0, 1},
			username = "F-15E_AAQ-13_LANTIRN",
			index = WSTYPE_PLACEHOLDER,
		},
	},
	
	Elements =
	{
		{ ShapeName = "F-15E_AAQ-13_LANTIRN", }
	},
})

declare_loadout({
	category 		= CAT_PODS,
	CLSID			= "{F-15E_AAQ-14_LANTIRN}",
	Picture			= "AAQ-14.png",
	attribute		= {4, 15, 44,	WSTYPE_PLACEHOLDER},
	Weight			= 621 * LB_TO_KG,
	Cx_pil			= 0.0012171052631579, -- Drag Count of 7.4
	displayName		= _("AN/AAQ-14 LANTIRN TGT Pod"),

	shape_table_data =
	{
		{
			file = "F-15E_AAQ-14_LANTIRN",
			life = 1,
			fire = { 0, 1},
			username = "F-15E_AAQ-14_LANTIRN",
			index = WSTYPE_PLACEHOLDER,
		},
	},
	
	Elements =
	{
		{ ShapeName = "F-15E_AAQ-14_LANTIRN", }
	},
})

declare_loadout({
	category 		= CAT_PODS,
	CLSID			= "{F-15E_AAQ-28_LITENING}",
	Picture			= "AAQ-28.png",
	attribute		= {4, 15, 44,	WSTYPE_PLACEHOLDER},
	Weight			= 466 * LB_TO_KG,
	Cx_pil			= 0.0006907895, -- Drag Count of 4.2
	displayName		= _("AN/AAQ-28 LITENING AT"),

	shape_table_data =
	{
		{
			file = "F-15E_AAQ-28_LITENING",
			life = 1,
			fire = { 0, 1},
			username = "F-15E_AAQ-28_LITENING",
			index = WSTYPE_PLACEHOLDER,
		},
	},
	
	Elements =
	{
		{ ShapeName = "F-15E_AAQ-28_LITENING", }
	},
})

declare_loadout({
	category 		= CAT_PODS,
	CLSID			= "{F-15E_AAQ-33_XR_ATP-SE}",
	Picture			= "AAQ-28.png",
	attribute		= {4, 15, 44,	WSTYPE_PLACEHOLDER},
	Weight			= 452 * LB_TO_KG,
	Cx_pil			= 0.0006907895, -- Drag Count of 4.2
	displayName		= _("AN/AAQ-33 SNIPER"),

	shape_table_data =
	{
		{
			file = "F-15E_AAQ-33_XR_ATP-SE",
			life = 1,
			fire = { 0, 1},
			username = "F-15E_AAQ-33_XR_ATP-SE",
			index = WSTYPE_PLACEHOLDER,
		},
	},
	
	Elements =
	{
		{ ShapeName = "F-15E_AAQ-33_XR_ATP-SE", }
	},
})

declare_loadout({
	category 		= CAT_PODS,
	CLSID	 		= "{AN_AXQ_14}",
	Picture			= "skyshadow.png",
	attribute		= {4, 15, 44, WSTYPE_PLACEHOLDER},
	Weight			= 300,
	Cx_pil			= 0.000756579, -- Drag Count of 4.6
	displayName		= _("AN/AXQ-14 Data Link Pod"),
	
	shape_table_data =
	{
		{
			file = "F-15E_AXQ-14_DATALINK",
			life = 1,
			fire = { 0, 1},
			username = "F-15E_AXQ-14_DATALINK",
			index = WSTYPE_PLACEHOLDER,
		},
	},
	
	Elements  		= 
	{
		{ShapeName = "F-15E_AXQ-14_DATALINK"}
	},
})

-- MAVERICK
local agm65_variants =
{
	["AGM-65D"]  = {display_name = _("AGM-65D - Maverick D (IIR ASM)"),					mass = 218,	wstype	= {4, 4,   8,  77}, shapename = "AGM-65D" },
	["AGM-65G"]  = {display_name = _("AGM-65G - Maverick G (IIR ASM - Lrg Whd)"),		mass = 301,	wstype	= {4, 4,   8, 139}, shapename = "AGM-65G" },
	["AGM-65H"]  = {display_name = _("AGM-65H - Maverick H (CCD Imp ASM)"),				mass = 208,	wstype	= {4, 4,   8, 138}, shapename = "AGM-65H" },
	["AGM-65K"]  = {display_name = _("AGM-65K - Maverick K (CCD Imp ASM)"),				mass = 297,	wstype	= {4, 4,   8,  61}, shapename = "AGM-65K" },
	["TGM-65D"]	 = {display_name = _("TGM-65D - Trg Round for Mav D (IIR)"),			mass = 218,	wstype	= {4, 4, 101, 141}, shapename = "AGM-65D" },
	["TGM-65G"]	 = {display_name = _("TGM-65G - Trg Round for Mav G (IIR)"),			mass = 301,	wstype	= {4, 4, 101, 140}, shapename = "AGM-65G" },
	["TGM-65H"]	 = {display_name = _("TGM-65H - Trg Round for Mav H (CCD)"),			mass = 208,	wstype	= {4, 4, 101, 154}, shapename = "AGM-65H" },
	["CATM-65K"] = {display_name = _("CATM-65K - Captive Trg Round for Mav K (CCD)"),	mass = 297,	wstype	= {4, 4, 101, 142}, shapename = "AGM-65K" },
}

local function lau_117_Maverick(clsid, element)

	local var			= agm65_variants[element] or agm65_variants["AGM-65H"]
	local var_mass		= var.mass or 301.0
	local display_name	= var.display_name or element
	local shape_name	= var.shapename or "AGM-65H"
	
	local ret = {
		category		= CAT_MISSILES,
		CLSID			= clsid,
		Picture			= "agm65.png",
		wsTypeOfWeapon	= var.wstype,
		attribute     	= {4, 4, 32, WSTYPE_PLACEHOLDER},
		Count 			= 1,
		displayName	  	= _("LAU-117/A with").." "..display_name,
		Weight  		= LAU_117_mass + var.mass,
		Cx_pil			= 0.00025 + 0.0009765625,
		Cx_item			= 0.0009765625,
		shape_table_data=
		{
			{
				name		= "F-15E_LAU-117";
				file		= "F-15E_LAU-117";
				life		= 1;
				fire		= {0, 1};
				username	= "F-15E_LAU-117";
				index		= WSTYPE_PLACEHOLDER;
			},
		},
		Elements		= 
		{
			{ 
				ShapeName	= "F-15E_LAU-117",
				IsAdapter	= true 
			}, 
			{
				connector_name	= "Point01",
				ShapeName		= shape_name,
			}
		}
	}

	declare_loadout(ret)
end

local function lau_88_Maverick(clsid, element)
	local var			= agm65_variants[element] or agm65_variants["AGM-65H"]
	local var_mass		= var.mass or 301.0
	local display_name	= var.display_name or element
	local shape_name	= var.shapename or "AGM-65H"
	local agm_count		= 3
	local agm_elements	= {}

	local ret = {
		category		= CAT_MISSILES,
		CLSID			= clsid,
		Picture			= "agm65.png",
		wsTypeOfWeapon	= var.wstype,
		attribute     	= {4, 4, 32, WSTYPE_PLACEHOLDER},
		Count 			= agm_count,
		displayName	  	= _("LAU-88/A with").." "..tostring(agm_count).." x "..display_name,
		Weight  		= LAU_88_mass + var.mass * agm_count,
		Cx_pil			= 0.001887 + 0.0009765625 * agm_count,
		Cx_item			= 0.0009765625,
		shape_table_data=
		{
			{
				name		= "F-15E_LAU-88";
				file		= "F-15E_LAU-88";
				life		= 1;
				fire		= {0, 1};
				username	= "F-15E_LAU-88";
				index		= WSTYPE_PLACEHOLDER;
			},
		},
		Elements		= 
		{
			{ 
				ShapeName	= "F-15E_LAU-88",
				IsAdapter	= true 
			}, 
			{
				connector_name	= "Point03",
				ShapeName		= shape_name,
			},
			{
				connector_name	= "Point01",
				ShapeName		= shape_name,
			},
			{
				connector_name	= "Point02",
				ShapeName		= shape_name,
			}
		}
	}

	declare_loadout(ret)
end

lau_117_Maverick("{LAU_117A_AGM_65D}", "AGM-65D")
lau_117_Maverick("{LAU_117A_AGM_65G}", "AGM-65G")
lau_117_Maverick("{LAU_117A_AGM_65H}", "AGM-65H")
lau_117_Maverick("{LAU_117A_AGM_65K}", "AGM-65K")

lau_117_Maverick("{LAU_117A_TGM_65D}",  "TGM-65D")
lau_117_Maverick("{LAU_117A_TGM_65G}",  "TGM-65G")
lau_117_Maverick("{LAU_117A_TGM_65H}",  "TGM-65H")
lau_117_Maverick("{LAU_117A_CATM_65K}", "CATM-65K")

lau_88_Maverick("{LAU_88A_AGM_65Dx3}",  "AGM-65D")
lau_88_Maverick("{LAU_88A_AGM_65Hx3}",  "AGM-65H")
lau_88_Maverick("{LAU_88A_AGM_65Kx3}",  "AGM-65K")

-- PLACEHOLDERS UNTIL ED DEVELOPS THEM
declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{GBU_15_V_21B}",
	displayName		= _("GBU-15(V)21/B"),
	Picture			= "GBU16.png",
	attribute		= {4, 4, 8, 71},
	Count 			= 1,
	Cx_pil			= 0.00071,
	Weight			= 1140,
	
	Elements  		= {{ShapeName = "AGM-130", DrawArgs = {{1, 0.0}, {4, 0.0}}}},
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{AGM_130A}",
	displayName		= _("AGM-130A"),
	Picture			= "GBU16.png",
	attribute		= {4, 4, 8, 71},
	Count 			= 1,
	Cx_pil			= 0.00071,
	Weight			= 1140,
	Elements  		= {{ShapeName = "AGM-130"}},
})

-- Weapons Alias
local AIM9L		= "{AIM-9L}"
local AIM9M		= "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}"
local AIM9P		= "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}"
local AIM9J		= "{AIM-9J}"
local AIM9X		= "{5CE2FF2A-645A-4197-B48D-8720AC69394F}"
local AIM7M		= "{8D399DDA-FF81-4F14-904D-099B34FE7918}"
local AIM7F		= "{AIM-7F}"
local AIM7H		= "{AIM-7H}"
local AIM120B	= "{C8E06185-7CD6-4C90-959F-044679E90751}"
local AIM120C	= "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}"
local ACMIPOD	= "{AIS_ASQ_T50}"
local CATM9M	= "CATM-9M"

local MK82LD	= "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"
local MK82SE	= "{Mk82SNAKEYE}"
local MK82AR	= "{Mk82AIR}"
local MK84LD	= "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}"
local MK84AR	= "{Mk_84AIR_GP}"
local CBU087	= "{CBU-87}"
local CBU097	= "{5335D97A-35A5-4643-9D9B-026C75961E52}"
local CBU100	= "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}"
local CBU103	= "{CBU_103}"
local CBU105	= "{CBU_105}"
local GBU010	= "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}"
local GBU012	= "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"
local GBU15B	= "{GBU_15_V_31B}"
local GBU024	= "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}"
local GBU027	= "{EF0A9419-01D6-473B-99A3-BEBDB923B14D}"
local GBU028	= "{F06B775B-FC70-44B5-8A9F-5B5E2EB839C7}"
local GBU31A	= "{GBU-31}"
local GBU31B	= "{GBU-31V3B}"
local GBU31C	= "{GBU_31_V_2B}"
local GBU31D	= "{GBU_31_V_4B}"
local GBU038	= "{GBU-38}"
local GBU054	= "{GBU_54_V_1B}"
local AGM130	= "{AGM_130A}"
local AGM154A	= "{AGM-154A}"
local AGM154B	= "{AGM-154B}"
local AGM154C	= "{AGM-154C}"
local BLU107	= "{752B9781-F962-11d5-9190-00A0249B6F00}"

-- Practice Bombs
local BDU50LD	= "{BDU-50LD}"
local BDU50HD	= "{BDU-50HD}"
local BDU50LGB	= "{BDU-50LGB}"
local BDU56AR	= "{Mk_84AIR_TP}"

-- AGM-65 on LAU-117
local AGM65D	= "{LAU_117A_AGM_65D}"
local AGM65G	= "{LAU_117A_AGM_65G}"
local AGM65H	= "{LAU_117A_AGM_65H}"
local AGM65K	= "{LAU_117A_AGM_65K}"

-- AGM-65 on LAU-88
local AGM65DX3	= "{LAU_88A_AGM_65Dx3}"
local AGM65HX3	= "{LAU_88A_AGM_65Hx3}"
local AGM65KX3	= "{LAU_88A_AGM_65Kx3}"

-- TGM-65 on LAU-117
local TGM65D	= "{LAU_117A_TGM_65D}"
local TGM65G	= "{LAU_117A_TGM_65G}"
local TGM65H	= "{LAU_117A_TGM_65H}"
local CATM65K	= "{LAU_117A_CATM_65K}"

-- Pods
local AAQ28R		= "{A111396E-D3E8-4b9c-8AC9-2432489304D5}"
local AAQ13RZ		= "{F-15E_AAQ-13_LANTIRN}"
local AAQ14RZ		= "{F-15E_AAQ-14_LANTIRN}"
local AAQ28RZ		= "{F-15E_AAQ-28_LITENING}"
local AAQ33RZ		= "{F-15E_AAQ-33_XR_ATP-SE}"
local AXQ014		= "{AN_AXQ_14}"
local MXU648		= "MXU-648-TP"
local EXTTNK		= "{F15E_EXTTANK}"
local EXTTNK_EMPTY	= "{F15E_EXTTANK_EMPTY}"
local NOPYLON		= "<CLEAN>"

local CFT_L1 = "Pylon7"
local CFT_L2 = "Pylon8"
local CFT_L3 = "Pylon9"
local CFT_L4 = "Pylon4"
local CFT_L5 = "Pylon5"
local CFT_L6 = "Pylon6"

local CFT_R1 = "Pylon11"
local CFT_R2 = "Pylon15"
local CFT_R3 = "Pylon13"
local CFT_R4 = "Pylon14"
local CFT_R5 = "Pylon12"
local CFT_R6 = "Pylon16"

local CFT_Rack_Bombs = function (CLSID, user_name, wsType, mass_single, cx_single, connectors, _shapename, pic_)
	local elements = {}
	for i,o in ipairs(connectors) do
		elements[i] = {DrawArgs	= {{1,1},{2,1}}, ShapeName = _shapename, connector_name = o}
	end
	
	local count = #connectors
	local disp_name = user_name
	
	if count > 1 then
		disp_name = user_name .. " * " .. tostring(count)
	end
	
	declare_loadout({
		category			= CAT_BOMBS,
		CLSID				= CLSID,
		------------------------------------
		DistributeOverCarrierDirectly = true,
		------------------------------------
		displayName			= disp_name,
		wsTypeOfWeapon		= wsType,
		attribute			= wsType,
		Count				= count,
		Picture				= pic_,
		Weight_Empty		= 0,
		Weight				= mass_single * count,
		Cx_pil				= cx_single * count,
		Elements			= elements,
	})
end

local CFTL_2StaL = { CFT_L1, CFT_L3 }
local CFTL_2StaH = { CFT_L6, CFT_L3 }
local CFTL_3Sta	 = { CFT_L2, CFT_L3, CFT_L1 }
local CFTL_4Sta	 = { CFT_L6, CFT_L4, CFT_L3, CFT_L1 }
local CFTL_6Sta	 = { CFT_L5, CFT_L2, CFT_L6, CFT_L4, CFT_L3, CFT_L1 }

local CFTR_2StaL = { CFT_R1, CFT_R3 }
local CFTR_2StaH = { CFT_R6, CFT_R3 }
local CFTR_3Sta	 = { CFT_R5, CFT_R3, CFT_R1 }
local CFTR_4Sta	 = { CFT_R6, CFT_R4, CFT_R3, CFT_R1 }
local CFTR_6Sta	 = { CFT_R2, CFT_R5, CFT_R6, CFT_R4, CFT_R3, CFT_R1 }

-------------------
-- LEFT CFT
-------------------
CFT_Rack_Bombs("{CFT_L_MK82LD_x_2}",	"Mk-82",			{4, 5, 9,  31}, 241.0, 0.00016,		CFTL_2StaL,	"MK-82",			"mk82.png")
CFT_Rack_Bombs("{CFT_L_MK82LD_x_3}",	"Mk-82",			{4, 5, 9,  31}, 241.0, 0.00016,		CFTL_3Sta,	"MK-82",			"mk82.png")
CFT_Rack_Bombs("{CFT_L_MK82LD_x_6}",	"Mk-82",			{4, 5, 9,  31}, 241.0, 0.00016,		CFTL_6Sta,	"MK-82",			"mk82.png")
CFT_Rack_Bombs("{CFT_L_MK82SE_x_2}",	"Mk-82 SnakeEye",	{4, 5, 9,  79}, 241.0, 0.000186,	CFTL_2StaL,	"MK-82_Snakeye",	"mk82AIR.png")
CFT_Rack_Bombs("{CFT_L_MK82SE_x_3}",	"Mk-82 SnakeEye",	{4, 5, 9,  79}, 241.0, 0.000186,	CFTL_3Sta,	"MK-82_Snakeye",	"mk82AIR.png")
CFT_Rack_Bombs("{CFT_L_MK82SE_x_6}",	"Mk-82 SnakeEye",	{4, 5, 9,  79}, 241.0, 0.000186,	CFTL_6Sta,	"MK-82_Snakeye",	"mk82AIR.png")
CFT_Rack_Bombs("{CFT_L_MK82AR_x_2}",	"Mk-82 AIR",		{4, 5, 9,  75}, 241.0, 0.000186,	CFTL_2StaL,	"MK-82AIR",			"mk82AIR.png")
CFT_Rack_Bombs("{CFT_L_MK82AR_x_3}",	"Mk-82 AIR",		{4, 5, 9,  75}, 241.0, 0.000186,	CFTL_3Sta,	"MK-82AIR",			"mk82AIR.png")
CFT_Rack_Bombs("{CFT_L_MK82AR_x_6}",	"Mk-82 AIR",		{4, 5, 9,  75}, 241.0, 0.000186,	CFTL_6Sta,	"MK-82AIR",			"mk82AIR.png")
CFT_Rack_Bombs("{CFT_L_MK84LD_x_2}",	"Mk-84",			{4, 5, 9,  33}, 894.0, 0.000357,	CFTL_2StaL,	"MK-84",			"mk84.png")
CFT_Rack_Bombs("{CFT_L_MK84AR_x_2}",	"Mk-84 AIR",		{4, 5, 9, 412}, 894.0, 0.000357,	CFTL_2StaL,	"mk-84air",			"mk84.png")

-- Rocket Bombs
CFT_Rack_Bombs("{CFT_L_BLU107_x_3}",	"BLU-107",			{4, 5, 37, 62},	219.0, 0.0006,		CFTL_3Sta,	"DURANDAL",			"blu107.png")
CFT_Rack_Bombs("{CFT_L_BLU107_x_6}",	"BLU-107",			{4, 5, 37, 62},	219.0, 0.0006,		CFTL_6Sta,	"DURANDAL",			"blu107.png")

-- Cluster Bombs
CFT_Rack_Bombs("{CFT_L_CBU_87_x_3}",	"CBU-87",			{4, 5, 38, 77},	430.0, 0.000265,	CFTL_3Sta,	"CBU-97",			"CBU.png")
CFT_Rack_Bombs("{CFT_L_CBU_87_x_6}",	"CBU-87",			{4, 5, 38, 77},	430.0, 0.000265,	CFTL_6Sta,	"CBU-97",			"CBU.png")
CFT_Rack_Bombs("{CFT_L_CBU_97_x_3}",	"CBU-97",			{4, 5, 38, 35},	417.0, 0.000265,	CFTL_3Sta,	"CBU-97",			"CBU.png")
CFT_Rack_Bombs("{CFT_L_CBU_97_x_6}",	"CBU-97",			{4, 5, 38, 35},	417.0, 0.000265,	CFTL_6Sta,	"CBU-97",			"CBU.png")
CFT_Rack_Bombs("{CFT_L_CBU_100_x_3}",	"Mk-20 Rockeye",	{4,	5, 38, 45},	222.0, 0.000413,	CFTL_3Sta,	"ROCKEYE",			"Mk20.png")
CFT_Rack_Bombs("{CFT_L_CBU_100_x_6}",	"Mk-20 Rockeye",	{4, 5, 38, 45},	222.0, 0.000413,	CFTL_6Sta,	"ROCKEYE",			"Mk20.png")
CFT_Rack_Bombs("{CFT_L_CBU_103_x_3}",	"CBU-103",			{4, 5, 38, 88},	430.0, 0.000265,	CFTL_3Sta,	"CBU-97",			"CBU.png")
CFT_Rack_Bombs("{CFT_L_CBU_105_x_3}",	"CBU-105",			{4, 5, 38, 87},	417.0, 0.000265,	CFTL_3Sta,	"CBU-97",			"CBU.png")

-- Guided Bombs
CFT_Rack_Bombs("{CFT_L_GBU_12_x_2}",	"GBU-12",			{4, 5, 36, 38}, 275.0, 0.000365,	CFTL_2StaH,	"GBU-12",			"GBU12.png")
CFT_Rack_Bombs("{CFT_L_GBU_12_x_4}",	"GBU-12",			{4, 5, 36, 38}, 275.0, 0.000365,	CFTL_4Sta,	"GBU-12",			"GBU12.png")
CFT_Rack_Bombs("{CFT_L_GBU_10_x_2}",	"GBU-10",			{4, 5, 36, 36}, 959.0, 0.000508,	CFTL_2StaL,	"GBU-10", 			"GBU10.png")

-- Smart Weapons
CFT_Rack_Bombs("{CFT_L_GBU_31_x_2}",	"GBU-31(V)1/B",		{4, 5, 36, 85},  894.0,	0.00170,	CFTL_2StaL, "GBU-31",				"GBU31.png")
CFT_Rack_Bombs("{CFT_L_GBU_31V2B_x_2}",	"GBU-31(V)2/B",		{4, 5, 36, 278}, 934.0,	0.00264,	CFTL_2StaL, "GBU-31",				"GBU31.png")
CFT_Rack_Bombs("{CFT_L_GBU_31V3B_x_2}",	"GBU-31(V)3/B",		{4, 5, 36, 92},  981.0,	0.00170,	CFTL_2StaL, "GBU31_V_3B_BLU109",	"GBU-31V3B.png")
CFT_Rack_Bombs("{CFT_L_GBU_31V4B_x_2}",	"GBU-31(V)4/B",		{4, 5, 36, 279}, 970.0,	0.00264,	CFTL_2StaL, "GBU31_V_3B_BLU109",	"GBU-31V3B.png")
CFT_Rack_Bombs("{CFT_L_GBU_38_x_3}",	"GBU-38",			{4, 5, 36, 86},  241.0,	0.00074,	CFTL_3Sta,	"GBU-38",				"GBU38.png")
CFT_Rack_Bombs("{CFT_L_GBU_54_x_3}",	"GBU-54B",			"weapons.bombs.GBU_54_V_1B", 253.0,	0.00074,	CFTL_3Sta,	"GBU-54",	"GBU54.png")

-- Practice Bombs
CFT_Rack_Bombs("{CFT_L_BDU50LD_x_2}",	"BDU-50LD",			{4, 5, 9, 70}, 232.0, 0.00016,		CFTL_2StaL,	"BDU-50LD",				"BDU-50LD.png")
CFT_Rack_Bombs("{CFT_L_BDU50LD_x_3}",	"BDU-50LD",			{4, 5, 9, 70}, 232.0, 0.00016,		CFTL_3Sta,	"BDU-50LD",				"BDU-50LD.png")
CFT_Rack_Bombs("{CFT_L_BDU50LD_x_6}",	"BDU-50LD",			{4, 5, 9, 70}, 232.0, 0.00016,		CFTL_6Sta,	"BDU-50LD",				"BDU-50LD.png")
CFT_Rack_Bombs("{CFT_L_BDU50HD_x_2}",	"BDU-50HD",			{4, 5, 9, 71}, 232.0, 0.000186,		CFTL_2StaL,	"BDU-50HD",				"BDU-50HD.png")
CFT_Rack_Bombs("{CFT_L_BDU50HD_x_3}",	"BDU-50HD",			{4, 5, 9, 71}, 232.0, 0.000186,		CFTL_3Sta,	"BDU-50HD",				"BDU-50HD.png")
CFT_Rack_Bombs("{CFT_L_BDU50HD_x_6}",	"BDU-50HD",			{4, 5, 9, 71}, 232.0, 0.000186,		CFTL_6Sta,	"BDU-50HD",				"BDU-50HD.png")
CFT_Rack_Bombs("{CFT_L_BDU50LGB_x_2}",	"BDU-50LGB",		{4, 5, 9, 72}, 280.0, 0.000365,		CFTL_2StaH,	"BDU-50LGB",			"GBU12.png")
CFT_Rack_Bombs("{CFT_L_BDU50LGB_x_4}",	"BDU-50LGB",		{4, 5, 9, 72}, 280.0, 0.000365,		CFTL_4Sta,	"BDU-50LGB",			"GBU12.png")
CFT_Rack_Bombs("{CFT_L_BDU56AR_x_2}",	"Mk-84 AIR TP",		{4, 5, 9, 413}, 894.0, 0.000357,	CFTL_2StaL,	"mk-84air",				"mk84.png")

-------------------
-- RIGHT CFT
-------------------
CFT_Rack_Bombs("{CFT_R_MK82LD_x_2}",	"Mk-82",			{4, 5, 9, 31},	241.0, 0.00016,		CFTR_2StaL,	"MK-82",				"mk82.png")
CFT_Rack_Bombs("{CFT_R_MK82LD_x_3}",	"Mk-82",			{4, 5, 9, 31},	241.0, 0.00016,		CFTR_3Sta,	"MK-82",				"mk82.png")
CFT_Rack_Bombs("{CFT_R_MK82LD_x_6}",	"Mk-82",			{4, 5, 9, 31},	241.0, 0.00016,		CFTR_6Sta,	"MK-82",				"mk82.png")
CFT_Rack_Bombs("{CFT_R_MK82SE_x_2}",	"Mk-82 SnakeEye",	{4, 5, 9, 79},	241.0, 0.000186,	CFTR_2StaL,	"MK-82_Snakeye",		"mk82AIR.png")
CFT_Rack_Bombs("{CFT_R_MK82SE_x_3}",	"Mk-82 SnakeEye",	{4, 5, 9, 79},	241.0, 0.000186,	CFTR_3Sta,	"MK-82_Snakeye",		"mk82AIR.png")
CFT_Rack_Bombs("{CFT_R_MK82SE_x_6}",	"Mk-82 SnakeEye",	{4, 5, 9, 79},	241.0, 0.000186,	CFTR_6Sta,	"MK-82_Snakeye",		"mk82AIR.png")
CFT_Rack_Bombs("{CFT_R_MK82AR_x_2}",	"Mk-82 AIR",		{4, 5, 9, 75},	241.0, 0.000186,	CFTR_2StaL,	"MK-82AIR",				"mk82AIR.png")
CFT_Rack_Bombs("{CFT_R_MK82AR_x_3}",	"Mk-82 AIR",		{4, 5, 9, 75},	241.0, 0.000186,	CFTR_3Sta,	"MK-82AIR",				"mk82AIR.png")
CFT_Rack_Bombs("{CFT_R_MK82AR_x_6}",	"Mk-82 AIR",		{4, 5, 9, 75},	241.0, 0.000186,	CFTR_6Sta,	"MK-82AIR",				"mk82AIR.png")
CFT_Rack_Bombs("{CFT_R_MK84LD_x_2}",	"MK-84",			{4, 5, 9, 33},	894.0, 0.000357,	CFTR_2StaL,	"MK-84",				"mk84.png")
CFT_Rack_Bombs("{CFT_R_MK84AR_x_2}",	"Mk-84 AIR",		{4, 5, 9, 412}, 894.0, 0.000357,	CFTR_2StaL,	"mk-84air",				"mk84.png")

-- Rocket Bombs
CFT_Rack_Bombs("{CFT_R_BLU107_x_3}",	"BLU-107",			{4, 5, 37, 62},	219.0, 0.0006,		CFTR_3Sta,	"DURANDAL",				"blu107.png")
CFT_Rack_Bombs("{CFT_R_BLU107_x_6}",	"BLU-107",			{4, 5, 37, 62},	219.0, 0.0006,		CFTR_6Sta,	"DURANDAL",				"blu107.png")

-- Cluster Bombs
CFT_Rack_Bombs("{CFT_R_CBU_87_x_3}",	"CBU-87",			{4, 5, 38, 77}, 430.0, 0.000265,	CFTR_3Sta,	"CBU-97",				"CBU.png")
CFT_Rack_Bombs("{CFT_R_CBU_87_x_6}",	"CBU-87",			{4, 5, 38, 77}, 430.0, 0.000265,	CFTR_6Sta,	"CBU-97",				"CBU.png")
CFT_Rack_Bombs("{CFT_R_CBU_97_x_3}",	"CBU-97",			{4, 5, 38, 35}, 417.0, 0.000265,	CFTR_3Sta,	"CBU-97",				"CBU.png")
CFT_Rack_Bombs("{CFT_R_CBU_97_x_6}",	"CBU-97",			{4, 5, 38, 35}, 417.0, 0.000265,	CFTR_6Sta,	"CBU-97",				"CBU.png")
CFT_Rack_Bombs("{CFT_R_CBU_100_x_3}",	"Mk-20 Rockeye",	{4,	5, 38, 45},	222.0, 0.000413,	CFTR_3Sta,	"ROCKEYE",				"Mk20.png")
CFT_Rack_Bombs("{CFT_R_CBU_100_x_6}",	"Mk-20 Rockeye",	{4, 5, 38, 45},	222.0, 0.000413,	CFTR_6Sta,	"ROCKEYE",				"Mk20.png")
CFT_Rack_Bombs("{CFT_R_CBU_103_x_3}",	"CBU-103",			{4, 5, 38, 88}, 430.0, 0.000265,	CFTR_3Sta,	"CBU-97",				"CBU.png")
CFT_Rack_Bombs("{CFT_R_CBU_105_x_3}",	"CBU-105",			{4, 5, 38, 87}, 417.0, 0.000265,	CFTR_3Sta,	"CBU-97",				"CBU.png")

-- Guided Bombs
CFT_Rack_Bombs("{CFT_R_GBU_12_x_2}",	"GBU-12",			{4, 5, 36, 38}, 275.0, 0.000365,	CFTR_2StaH,	"GBU-12", "GBU12.png")
CFT_Rack_Bombs("{CFT_R_GBU_12_x_4}",	"GBU-12",			{4, 5, 36, 38}, 275.0, 0.000365,	CFTR_4Sta,	"GBU-12", "GBU12.png")
CFT_Rack_Bombs("{CFT_R_GBU_10_x_2}",	"GBU-10",			{4, 5, 36, 36}, 959.0, 0.000508,	CFTR_2StaL,	"GBU-10", "GBU10.png")
CFT_Rack_Bombs("{CFT_R_GBU_27_x_2}",	"GBU-27",			{4, 5, 36, 43}, 991.0, 0.00071,		CFTR_2StaL,	"GBU-27", "GBU27.png")

-- Smart Bombs
CFT_Rack_Bombs("{CFT_R_GBU_31_x_2}",	"GBU-31(V)1/B",		{4, 5, 36, 85},  894.0,	0.00170,	CFTR_2StaL,	"GBU-31",				"GBU31.png")
CFT_Rack_Bombs("{CFT_R_GBU_31V2B_x_2}",	"GBU-31(V)2/B",		{4, 5, 36, 278}, 894.0,	0.00264,	CFTR_2StaL,	"GBU-31",				"GBU31.png")
CFT_Rack_Bombs("{CFT_R_GBU_31V3B_x_2}",	"GBU-31(V)3/B",		{4, 5, 36, 92},  981.0,	0.00170,	CFTR_2StaL,	"GBU31_V_3B_BLU109",	"GBU-31V3B.png")
CFT_Rack_Bombs("{CFT_R_GBU_31V4B_x_2}",	"GBU-31(V)4/B",		{4, 5, 36, 279}, 970.0,	0.00264,	CFTR_2StaL, "GBU31_V_3B_BLU109",	"GBU-31V3B.png")
CFT_Rack_Bombs("{CFT_R_GBU_38_x_3}",	"GBU-38",			{4, 5, 36, 86},  241.0,	0.00264,	CFTR_3Sta,	"GBU-38",				"GBU38.png")
CFT_Rack_Bombs("{CFT_R_GBU_54_x_3}",	"GBU-54B",			"weapons.bombs.GBU_54_V_1B", 253.0,	0.00074,	CFTR_3Sta,	"GBU-54",				"GBU54.png")

-- Practice Bombs
CFT_Rack_Bombs("{CFT_R_BDU50LD_x_2}",	"BDU-50LD",			{4, 5, 9, 70}, 232.0, 0.00016,		CFTR_2StaL,	"BDU-50LD",				"BDU-50LD.png")
CFT_Rack_Bombs("{CFT_R_BDU50LD_x_3}",	"BDU-50LD",			{4, 5, 9, 70}, 232.0, 0.00016,		CFTR_3Sta,	"BDU-50LD",				"BDU-50LD.png")
CFT_Rack_Bombs("{CFT_R_BDU50LD_x_6}",	"BDU-50LD",			{4, 5, 9, 70}, 232.0, 0.00016,		CFTR_6Sta,	"BDU-50LD",				"BDU-50LD.png")
CFT_Rack_Bombs("{CFT_R_BDU50HD_x_2}",	"BDU-50HD",			{4, 5, 9, 71}, 232.0, 0.000186,		CFTR_2StaL,	"BDU-50HD",				"BDU-50HD.png")
CFT_Rack_Bombs("{CFT_R_BDU50HD_x_3}",	"BDU-50HD",			{4, 5, 9, 71}, 232.0, 0.000186,		CFTR_3Sta,	"BDU-50HD",				"BDU-50HD.png")
CFT_Rack_Bombs("{CFT_R_BDU50HD_x_6}",	"BDU-50HD",			{4, 5, 9, 71}, 232.0, 0.000186,		CFTR_6Sta,	"BDU-50HD",				"BDU-50HD.png")
CFT_Rack_Bombs("{CFT_R_BDU50LGB_x_2}",	"BDU-50LGB",		{4, 5, 9, 72}, 280.0, 0.000365,		CFTR_2StaH,	"BDU-50LGB",			"GBU12.png")
CFT_Rack_Bombs("{CFT_R_BDU50LGB_x_4}",	"BDU-50LGB",		{4, 5, 9, 72}, 280.0, 0.000365,		CFTR_4Sta,	"BDU-50LGB",			"GBU12.png")
CFT_Rack_Bombs("{CFT_R_BDU56AR_x_2}",	"Mk-84 AIR TP",		{4, 5, 9, 413}, 894.0, 0.000357,	CFTR_2StaL,	"mk-84air",				"mk84.png")

-- Restrictions
Pylon2_general_restrictions	= {
	{station = 4, loadout = {"{CFT_L_MK82LD_x_6}"}},
	{station = 4, loadout = {"{CFT_L_MK82SE_x_6}"}},
	{station = 4, loadout = {"{CFT_L_MK82AR_x_6}"}},
	{station = 4, loadout = {"{CFT_L_CBU_87_x_6}"}},
	{station = 4, loadout = {"{CFT_L_CBU_97_x_6}"}},
	{station = 4, loadout = {"{CFT_L_GBU_12_x_4}"}},
}
Pylon2_MK80s_restrictions	= {
	{station = 4, loadout = {"{CFT_L_CBU_87_x_6}"}},
	{station = 4, loadout = {"{CFT_L_CBU_97_x_6}"}},
}
Pylon2_GBUs_restrictions = {
	{station = 1}, {station = 3},
	{station = 4, loadout = {"{CFT_L_CBU_87_x_6}"}},
	{station = 4, loadout = {"{CFT_L_CBU_97_x_6}"}},
} 
Pylon2_AGMs_restrictions = {
	{station = 1, loadout = {AIM120B}}, 
	{station = 1, loadout = {AIM120C}}, 
	{station = 3, loadout = {AIM120B}}, 
	{station = 3, loadout = {AIM120C}}, 
	{station = 4},
} 
LCFT_general_restrictions	= {
	{station = 5},
	{station = 6},
	{station =  2, loadout = {AGM65DX3}},
	{station =  2, loadout = {AGM65HX3}},
	{station =  2, loadout = {AGM65KX3}},
	{station =  2, loadout = {GBU028}},
	{station = 14, loadout = {GBU028}}
}
LCFT_MK80sx6_restrictions	= {
	{station = 5},
	{station = 6},
	{station =  2, loadout = {GBU027}},
	{station =  2, loadout = {GBU028}},
	{station = 14, loadout = {GBU028}},
	{station =  2, loadout = {AGM65DX3}},
	{station =  2, loadout = {AGM65HX3}},
	{station =  2, loadout = {AGM65KX3}},
	{station =  2, loadout = {AGM130}},
	{station =  2, loadout = {AGM154A}}
}

Pylon14_general_restrictions	= {
	{station = 12, loadout = {"{CFT_R_MK82LD_x_6}"}},
	{station = 12, loadout = {"{CFT_R_MK82SE_x_6}"}},
	{station = 12, loadout = {"{CFT_R_MK82AR_x_6}"}},
	{station = 12, loadout = {"{CFT_R_CBU_87_x_6}"}},
	{station = 12, loadout = {"{CFT_R_CBU_97_x_6}"}},
	{station = 12, loadout = {"{CFT_R_GBU_12_x_4}"}},
}
Pylon14_MK80s_restrictions	= {
	{station = 12, loadout = {"{CFT_R_CBU_87_x_6}"}},
	{station = 12, loadout = {"{CFT_R_CBU_97_x_6}"}},
}
Pylon14_GBUs_restrictions = {
	{station = 13}, {station = 15},
	{station = 12, loadout = {"{CFT_R_CBU_87_x_6}"}},
	{station = 12, loadout = {"{CFT_R_CBU_97_x_6}"}},
} 
Pylon14_AGMs_restrictions = {
	{station = 13, loadout = {AIM120B}}, 
	{station = 13, loadout = {AIM120C}}, 
	{station = 15, loadout = {AIM120B}}, 
	{station = 15, loadout = {AIM120C}}, 
	{station = 12},
} 

RCFT_general_restrictions	= {
	{station = 10},
	{station = 11},
	{station = 14, loadout = {AGM65DX3}},
	{station = 14, loadout = {AGM65HX3}},
	{station = 14, loadout = {AGM65KX3}},
	{station = 14, loadout = {GBU028}},
	{station =  2, loadout = {GBU028}}
}
RCFT_MK80sx6_restrictions	= {
	{station = 10},
	{station = 11},
	{station = 14, loadout = {GBU027}},
	{station = 14, loadout = {GBU028}},
	{station =  2, loadout = {GBU028}},
	{station = 14, loadout = {AGM65DX3}},
	{station = 14, loadout = {AGM65HX3}},
	{station = 14, loadout = {AGM65KX3}},
	{station = 14, loadout = {AGM130}},
	{station = 14, loadout = {AGM154A}}
}

--External Lights prototypes
ext_lamp_prototypes = {
    LFS_P_27_1000 = { -- landing lamp / combo, 1000 Wt, 540 kcd, 205mm, LFS-PR27-1000+450 / ËÔÑ-ÏÐ27-1000+450
        color = {255, 201, 125, 0.012 * math.sqrt(1000) + 0.024}, range = 0.012 * 540000, angle_max = math.rad(12.0), angle_min = math.rad(12.0 - 4.0), angle_change_rate = math.rad(12.0 * 0.25),
        power_up_t = 3.22,
    },
    LFS_R_27_180 = { -- taxi lamp / combo, 180 Wt, 25 kcd, 205mm, LFS-PR27-600+180 / ËÔÑ-ÏÐ27-600+180
        color = {255, 201, 125, 0.012 * math.sqrt(180) + 0.024}, range = 0.012 * 25000, angle_max = math.rad(27.0), angle_min = math.rad(27.0 * 0.8), angle_change_rate = math.rad(-27.0 * 0.25),
        power_up_t = 0.90,
    },
    SMI_2KM = { -- strobe lamp, red, SMI-2KM / ÑÌÈ-2ÊÌ
        color = {1.0, 0.0, 0.0, 0.012 * math.sqrt(1000)}, range = 48.0, angle_max = math.rad(180.0), angle_min = math.rad(180.0),
        controller = "Strobe", period = 1.33333,
    },
    ANO_3_Bl = { -- position lamp, 44 Wt, white, ANO 3-Bl / ÀÍÎ 3-Áë
        color = {1.0, 1.0, 1.0, 0.155}, range = 30.0, angle_max = math.rad(180.0),
    },
    ANO_3_Kr = { -- position lamp, 44 Wt, red, ANO 3-Kr / ÀÍÎ 3-Êð
        color = {1.0, 0.35, 0.15, 0.12}, range = 22.2, angle_max = math.rad(180.0),
    },
    ANO_3_Zl = { -- position lamp, 44 Wt, green, ANO 3-Zl / ÀÍÎ 3-Çë
        color = {0.0, 0.894, 0.6, 0.12}, range = 22.2, angle_max = math.rad(180.0),
    },
}

--dofile(current_mod_path.."/WEAPONS/F-15E_Weapons.lua")

-- Aircraft Definition
F15E_RAZBAM = {
	
	-- General Information
	Name 				= 'F-15ESE',
	DisplayName			= _('F-15E S4+'),
	ViewSettings		= ViewSettings,

	--HumanCockpit 		= true,
	--HumanCockpitPath    = current_mod_path..'/Cockpit/',
	
	Picture 			= "F-15E.png",
	Rate 				= 50, -- RewardPoint in Multiplayer
	Shape 				= "F-15E_Suite4",
	
	-------------------------
	shape_table_data 	=
	{
		{
			file  	 = 'F-15E_Suite4';
			life  	 = 18; 				-- lifebar
			vis   	 = 3; 				-- visibility gain.
			desrt    = 'F15E_destr';			-- Name of destroyed object file name
			fire  	 = { 300, 2};		-- Fire on the ground after destoyed: 300sec 2m
			username = 'F15E';
			index    =  WSTYPE_PLACEHOLDER;
			classname = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  = "F15E_destr";
			file  = "F15E_destr";
			fire  = { 240, 2};
		},

	},
	
	CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),
	
	-------------------------
	-- Model draw args for network transmitting to this draw_args table (32 limit)
	net_animation = 
	{
		38,  -- CANOPY		
		49,  -- NAV_LIGHTS
		51,  -- LANDING_LIGHTS
		83,  -- STROBE_LIGHT_TOP
		88,  -- FORM_LIGHTS
		89,  -- NOZZLE LEFT
		90,  -- NOZZLE RIGHT
		190, -- LEFT_NAV_LIGHT
		191, -- TAIL_NAV_LIGHT
		192, -- RIGHT_NAV_LIGHT
		198, -- ANTI-COLLISION LIGHT LOW
		199, -- ANTI-COLLISION LIGHT BRT
		200, -- FORM_LIGHT_FRONT
		201, -- FORM_LIGHT_AFT
		208, -- LANDING_LIGHT
		209, -- TAXI_LIGHT
		802, -- STRONG_LIGHT_BOTTOM
		274, -- LEFT RAMP
		275, -- RIGHT RAMP
		276, -- LEFT SHOCK
		277, -- RIGHT SHOCK
		278, -- LEFT SURGE
		279, -- RIGHT SURGE
		39,  -- PILOT HEAD HORIZONTAL
		99,  -- PILOT HEAD VERTICAL
		337,  -- WSO HEAD HORIZONTAL
		399,  -- WSO HEAD VERTICAL
		3080, -- EFFECTS HOLDER1
		3090, -- EFFECTS HOLDER2		
	},
	
	-------------------------
	mapclasskey	= "P0091000024",
	
	attribute	= {
		wsType_Air, 
		wsType_Airplane, 
		wsType_Fighter,
		WSTYPE_PLACEHOLDER,
		"Fighters",
		"Refuelable",
		"Datalink",
		"Link16"
	},
	
	Categories	= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor", "15"},
	
	--------- General Characteristics ---------
	length						=	19.43,
	height						=	 5.63,
	wing_area					=	56.5,
	wing_span					=	13.05,
	wing_tip_pos				= 	{-3.9,	0.2,	6.6},
	RCS							=	6,
	air_refuel_receptacle_pos	= 	{1.42503,  0.32304, -1.66084},
	has_speedbrake				=	true,
	brakeshute_name				=	0,
	tanker_type					=	1,
	is_tanker					=	false,
	stores_number				=	25,
	
	fires_pos = 
	{
		[1] = 	{-1.842,	0.563,	 0},		--Center Top		 
		[2] = 	{-1.731,	0.265,	 1.759},	--Wing Left In
		[3] = 	{-1.731,	0.265,	-1.759}, 	--Wing Right In
		[4] = 	{-1.625,	0.265,	 2.787},	--Wing Left Med
		[5] = 	{-1.625,	0.265,	-2.787},	--Wing Right Med
		[6] = 	{-2.196,	0.255,	 4.637},	--Wing Left Out
		[7] = 	{-2.196,	0.255,	-4.637},	--Wing Right Out
		[8] = 	{-5.753,	0.06,	 0.705},	--Enigne1
		[9] = 	{-5.753,	0.06,	-0.705},	--Enigne2
		[10] = 	{-0.992,	0.85,	 0},        --                   
--		[11] = 	{-1.683,	0.507,	-2.91},     --                   
	},
	
	-- HumanOrchestra - Pilot will be able to switch to unoccupied seats and will be transfered
	-- back to their seat automatically if a player occupies this seat.	
	-- CaptainExclusive - Captain will be fixed to their seat while others will be able to transfer 
	-- between free seats. Their multiplayer slot will change accordingly
	-- Hybrid - Unknown behavior (Used by Mi-24P)
	crew_stations = "HumanOrchestra",
	crew_members = 
	{
		[1] = 
		{
			pilot_name		   		= "F-15E_PilotF",
			role 				 	= "pilot",
			role_display_name    	= _("Pilot"),
			can_be_playable			= true,
			g_suit					= 2.0,
			pos 					= {6.512, -0.369, 0},
			pilot_body_arg			= 50,
			ejection_order			= 1,
			ejection_added_speed	= {-5,15,0},
			ejection_seat_name		= "F-15E_Pilot_SeatF",
			drop_canopy_name		= "F-15E_Suite4_Canopy",
			drop_parachute_name		= "F-15E_Pilot_Parachute",
            bailout_arg 			= -1,
			canopy_arg				= 38, 
			canopy_pos				= {0.0,0.0,0.0},
		}, 
		[2] = 
		{
			pilot_name		   		= "F-15E_PilotR",
			role 				 	= "instructor",
			role_display_name    	= _("Weapons Systems Officer"),
			can_be_playable			= true,
			g_suit					= 2.0,
			pos 					= {5.112, -0.369, 0},
			pilot_body_arg			= 472,
			ejection_order			= 2,
			ejection_added_speed	= {-5,15,0},
			ejection_seat_name		= "F-15E_Pilot_SeatR",
			drop_canopy_name		= "F-15E_Suite4_Canopy",
			drop_parachute_name		= "F-15E_Pilot_Parachute",
            bailout_arg 			= -1,
			canopy_arg				= 38, 
			canopy_pos				= {0.0,0.0,0.0},
		}, 
	},
	
	mechanimations = {
		Door0 = {
			{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 0.9, "in", 8.08},},},}, Flags = {"Reversible"},},
			{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "in", 6.743},},},}, Flags = {"Reversible", "StepsBackwards"},},
			{Transition = {"Any", "Bailout"}, Sequence = {{C = {{"JettisonCanopy", 0},},},},},
		},
		Door1 = {DuplicateOf = "Door0"},
		CrewLadder = {
			{Transition = {"Dismantle", "Erect"}, Sequence = {{C = {{"Arg", 91, "to", 0.9, "in", 1.5}}}, {C = {{"Sleep", "for", 5.0}}}}, Flags = {"Reversible"}},
			{Transition = {"Erect", "Dismantle"}, Sequence = {{C = {{"Arg", 91, "to", 0.0, "in", 2.7}}}, {C = {{"Sleep", "for", 0.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
		},
	}, -- end of mechanimations
	
	effects_presets = {		
		{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/F-15E_S4_overwingVapor.lua"},
	},
	
	----- Weight & Fuel Characteristics  ------
    -- Refer to F-15E FM Station Loading for 229 Configuration
	M_empty						=	17661,		-- with pilots and empty CFT, kg
    -- Refer to F-15E FM
    -- (JP-4 at 6.5 lb/gal) 	
	M_fuel_max					=	10245.529841877513,	-- kg (Maximum Internal Fuel Only)
	M_nominal					=	17661 + 10245.529841877513, -- kg (Empty Plus Full Internal Fuel)
    -- Maximum takeoff weight 81,0000 LBS = 36741 KG
	M_max						=	36741,		   -- kg (Maximum Take Off Weight - Rolling)
	H_max						=	18300,		   -- m  (Maximum Operational Ceiling)
    -- Currently around 132 knots - okay?
	CAS_min						=	58,			   -- Minimum CAS speed (m/s) (for AI)
	average_fuel_consumption	=	0.271,
	
	---------- AI Flight Parameters -----------
	V_opt 						=	254,		-- Cruise speed (for AI)* (m/s)
	V_take_off 					=	61, 		-- Take off speed in m/s (for AI)*	(122)
	V_land 						=	71, 		-- Land speed in m/s (for AI)
    -- 1.2 Mach at Sea Level
	V_max_sea_level 			=	411,		-- Max speed at sea level in m/s (for AI)
	V_max_h 					=	736.11 ,	-- Max speed at max altitude in m/s (for AI)
	Vy_max 						=	275, 		-- Max climb speed in m/s (for AI)
	Mach_max 					=	2.45, 	    -- Max speed in Mach (for AI)
	Ny_min 						=	-3, 		-- Min G (for AI)
	Ny_max 						=	8.0,		-- Max G (for AI)
	Ny_max_e 					=	8.0, 		-- ?? Max G (for AI)
	AOA_take_off 				=	0.16,		-- AoA in take off radians (for AI)
	bank_angle_max 				=	60,			-- Max bank angle (for AI)
	flaps_maneuver 				=	1,			-- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
	range 						=	2540,		-- Max range in km (for AI)
	
        
	-------- Suspension Characteristics -------
	tand_gear_max								=  1.0, -- Max 45 in NWS HI
    -- Exact measurement with midpoint between strut compression plus the normal weight stroke offset
    nose_gear_pos								=  {4.59005, -2.307995 + 0.04, 0},
    -- 22" Diameter
	nose_gear_wheel_diameter					=  0.56278, -- Measured exactly from model
    -- Total 0.43116 is Measured in Model
    -- Exact measurements with mid-point for estimated "resting" state
	nose_gear_amortizer_direct_stroke			=  2.52089 - 2.307995,	
	nose_gear_amortizer_reversal_stroke		    =  2.09051 - 2.307995,	
	nose_gear_amortizer_normal_weight_stroke	=  0.0,		
	
    -- Exact measurement with midpoint between strut compression plus the normal weight stroke offset
    main_gear_pos								=  {-0.80592, -2.34217 + 0.1, 1.39953},
    -- 36" Diameter
	main_gear_wheel_diameter					=  0.88825, -- Measured exactly from model
    -- Total 0.22747 is Measured in Model
    -- Exact measurements with mid-point for estimated "resting" state
	main_gear_amortizer_direct_stroke			=  2.45590 - 2.34217,	
	main_gear_amortizer_reversal_stroke		    =  2.22844 - 2.34217,	
	main_gear_amortizer_normal_weight_stroke	=  0.0,		
	
-------------- Engine Characteristics ---------
	has_afteburner				=	true,
    -- FW100-PW-229 Maximum Military 79,000N * 2 Engines = 16111 KG
	thrust_sum_max				=	16111,
    -- FW100-PW-229 Maximum Military 129,700N * 2 Engines = 26451 KG
	thrust_sum_ab				=	26451,
	engines_count				=	2,
	IR_emission_coeff			=	0.91,
	IR_emission_coeff_ab		=	4,
	
    engines_nozzles = 
    {
        [1] = 
        {
            pos = 	{-6.751,	0.067,	-0.705},
            elevation					= 0,
            diameter					= 1.076,
            exhaust_length_ab			= 11.0,
            exhaust_length_ab_K			= 0.76,
			afterburner_circles_count	= 11,
			afterburner_circles_pos		= {0.2, 0.8},
			afterburner_circles_scale	= 1.0,
			afterburner_effect_texture	= "afterburner_F-15E_SE",
            smokiness_level				= 0.1, 
        }, -- end of [1]
        [2] = 
        {
            pos = 	{-6.751,	0.067,	0.705},
            elevation					= 0,
            diameter					= 1.076,
            exhaust_length_ab			= 11.0,
            exhaust_length_ab_K			= 0.76,
			afterburner_circles_count	= 11,
			afterburner_circles_pos		= {0.2, 0.8},
			afterburner_circles_scale	= 1.0,
			afterburner_effect_texture	= "afterburner_F-15E_SE",
            smokiness_level				=  0.1, 
        }, -- end of [2]
    }, -- end of engines_nozzles
    
----------------------------------------------------
----------- SFM Flight Model Characteristics -------
----------------------------------------------------
	SFM_Data =
	{	
		aerodynamics = 
		{
			Cy0			=	0,
			Mzalfa		=	6,
			Mzalfadt	=	1,
			kjx			=	2.95,
			kjz			=	0.00125,
			Czbe		=	-0.016,
			cx_gear		=	0.0268,
			cx_flap		=	0.05,
			cy_flap		=	0.52,
			cx_brk		=	0.06,
            
            -------------------- Drag Polar Coefficients ---------------------------------------
			-- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
			-- It appears this really provides us with a good way to tune turn rate performance
			-- and provides us with how much drag we build up for a given amount of lift we make
			-- Drag polars were tuned from the flight manual and testing with correct max sustained
			table_data = 
			{
                --      M		Cx0			Cya		    B		B4		    Omxmax	Aldop		Cymax
				[1] = 	{0,	    0.0151,	    0.07,	    0.134,	0.0567,	    0.5,	30,	        1.1},
				[2] = 	{0.2,	0.0154,	    0.07,	    0.134,	0.056,	    1.5,	30,	        1.1},
				[3] = 	{0.4,	0.0156,	    0.07,	    0.129,	0.0549,	    2.5,	30,	        1.1},
				[4] = 	{0.6,	0.0164,	    0.073,	    0.12,	0.0474,	    3.5,	30,	        1.1},
				[5] = 	{0.7,	0.0172,	    0.076,	    0.105,	0.052,	    3.5,	28.6666667,	1.091},
				[6] = 	{0.8,	0.0201,	    0.079,	    0.11,	0.0607,	    3.5,	27.3333333,	1.082},
				[7] = 	{0.9,	0.0284,	    0.083,	    0.139,	0.0666,	    3.5,	26,	        1.073},
				[8] = 	{1.0,	0.0387,	    0.085,	    0.174,	0.073,	    3.5,	24.6666667,	1.064},
				[9] = 	{1.05,	0.0416,	    0.0855,	    0.1965,	0.07685,	3.5,	24,	        1.06},
				[10] = 	{1.1,	0.0445,	    0.086,	    0.219,	0.0807,	    3.15,	18,	        1.04},
				[11] = 	{1.2,	0.0462,	    0.083,	    0.3,	0.066,	    2.45,	17,	        1.02},
				[12] = 	{1.3,	0.04536,	0.077,	    0.344,	0.0594,	    1.75,	16,	        1},
				[13] = 	{1.4,	0.0432,	    0.0695,	    0.393,	0.0553,	    1.625,	14.5,	    0.95},
				[14] = 	{1.5,	0.0429,	    0.063625,	0.4505,	0.0521,	    1.5,	13,	        0.9},
				[15] = 	{1.6,	0.0426,	    0.05775,	0.508,	0.0489,	    1.2,	12.5,	    0.8},
				[16] = 	{1.7,	0.04145,	0.051875,	0.615,	0.52445,	0.9,	12,	        0.7},
				[17] = 	{1.8,	0.0403,	    0.046,	    0.722,	1,	        0.86,	11.4,	    0.64},
				[18] = 	{2.2,	0.0377,	    0.034,	    1,	    1,	        0.7,	9,	        0.4},
				[19] = 	{2.35,	0.0377,	    0.033,	    1,	    1,	        0.7,	9,	        0.4},
				[20] = 	{3.9,	0.0377,	    0.033,	    1,	    1,	        0.7,	9,	        0.4},
			}, -- end of table_data
            -- M - Mach number
			-- Cx0 - Coefficient, drag, profile, of the airplane
			-- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
			-- B - Polar quad coeff
			-- B4 - Polar 4th power coeff
			-- Omxmax - roll rate, rad/s
			-- Aldop - Alfadop Max AOA at current M - departure threshold
			-- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
		}, -- end of aerodynamics
		
		engine = 
		{
			Nmg		=	71.6,
			Nominal_RPM		= 14000.0,
			Nominal_Fan_RPM	= 10000.0,
			Startup_Prework = 10.0,
			Startup_Duration = 40.0,
			Shutdown_Duration = 35.0,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	0.965,
			ForsRUD	=	1.000,
			type	=	"TurboFan",
			hMaxEng	=	19,
			dcx_eng	=	0.0114,
			cemax	=	1.24,
			cefor	=	2.56,
			dpdh_m	=	8000,
			dpdh_f	=	17000,
			table_data = 
			{
                --F100-PW-229 Engine Characteristics
                --NOTE: This is the sum of both engines
                -- Roughly 1.22 Factor Improvement over 220 Engine
                --      Mach    Thrust Mil (N)  Thrust AB (N)
				[1] = 	{0,	    1.24 * 114330,	1.22 * 156000},
				[2] = 	{0.2,	1.24 * 108000,	1.22 * 160000},
				[3] = 	{0.4,	1.24 * 98000,	1.22 * 170000},
				[4] = 	{0.6,	1.24 * 105000,	1.22 * 181000},
				[5] = 	{0.7,	1.24 * 110000,	1.22 * 205000},
				[6] = 	{0.8,	1.24 * 118000,	1.22 * 220000},
				[7] = 	{0.9,	1.24 * 124000,	1.22 * 257000},
				[8] = 	{1.0,	1.24 * 130000,	1.22 * 272000},
				[9] = 	{1.1,	1.24 * 130000,	1.22 * 279000},
				[10] = 	{1.2,	1.24 * 125000,	1.22 * 283000},
				[11] = 	{1.3,	1.24 * 123000,	1.22 * 293000},
				[12] = 	{1.4,	1.24 * 130000,	1.22 * 302000},
				[13] = 	{1.6,	1.24 * 132000,	1.22 * 323000},
				[14] = 	{1.8,	1.24 * 128000,	1.22 * 348000},
				[15] = 	{2.2,	1.24 * 110000,	1.22 * 370000},
				[16] = 	{2.5,	1.24 * 82000,	1.22 * 392000},
				[17] = 	{3.9,	1.24 * 82000,	1.22 * 310000},
			}, -- end of table_data
		}, -- end of engine
		
	},-- end of SFM_Data
	
	--------- Sensors Characteristics ---------
	detection_range_max		=	250,
	radar_can_see_ground	=	true,
	
	Sensors = {
		RADAR = "AN/APG-63",
		RWR = "Abstract RWR",
		OPTIC = {"Sniper XR FLIR", "Sniper XR CCD TV"},
	},
	
	---------- Radio Characteristics ----------
	HumanRadio = {
		frequency = 243.0,
		editable = true,
		minFrequency = 30.000,
		maxFrequency = 399.975,
        rangeFrequency = {
			{min = 30.0,  max = 87.975},
			{min = 108.0, max = 115.975},
			{min = 118.0, max = 173.975},
			{min = 225.0, max = 399.975},
		},
		modulation = MODULATION_AM,
	},
	
	panelRadio = {
		[1] = {
			name = _("UHF Radio 1"),
			range = {
				{min = 225.0, max = 399.975}
			},
            channels = {
                [1] = { name = _("Channel 1"),		default = 266.0, modulation = _("AM"), connect = true}, -- Mozdok ATC
                [2] = { name = _("Channel 2"),		default = 264.0, modulation = _("AM")},	-- min. water : 135.0, 264.0
                [3] = { name = _("Channel 3"),		default = 265.0, modulation = _("AM")},	-- nalchik : 136.0, 265.0
                [4] = { name = _("Channel 4"),		default = 256.0, modulation = _("AM")},	-- sochi : 127.0, 256.0
                [5] = { name = _("Channel 5"),		default = 254.0, modulation = _("AM")},	-- maykop : 125.0, 254.0
                [6] = { name = _("Channel 6"),		default = 250.0, modulation = _("AM")},	-- anapa : 121.0, 250.0
                [7] = { name = _("Channel 7"),		default = 270.0, modulation = _("AM")},	-- beslan : 141.0, 270.0
                [8] = { name = _("Channel 8"),		default = 257.0, modulation = _("AM")},	-- krasnodar-pashk. : 128.0, 257.0
                [9] = { name = _("Channel 9"),		default = 255.0, modulation = _("AM")},	-- gelenjik : 126.0, 255.0
                [10] = { name = _("Channel 10"),	default = 262.0, modulation = _("AM")},	-- kabuleti : 133.0, 262.0
                [11] = { name = _("Channel 11"),	default = 259.0, modulation = _("AM")},	-- gudauta : 130.0, 259.0
                [12] = { name = _("Channel 12"),	default = 268.0, modulation = _("AM")},	-- soginlug : 139.0, 268.0
                [13] = { name = _("Channel 13"),	default = 269.0, modulation = _("AM")},	-- vaziani : 140.0, 269.0
                [14] = { name = _("Channel 14"),	default = 260.0, modulation = _("AM")},	-- batumi : 131.0, 260.0
                [15] = { name = _("Channel 15"),	default = 263.0, modulation = _("AM")},	-- kutaisi : 134.0, 263.0
                [16] = { name = _("Channel 16"),	default = 261.0, modulation = _("AM")},	-- senaki : 132.0, 261.0
                [17] = { name = _("Channel 17"),	default = 267.0, modulation = _("AM")},	-- lochini : 138.0, 267.0
                [18] = { name = _("Channel 18"),	default = 251.0, modulation = _("AM")},	-- krasnodar-center : 122.0, 251.0
                [19] = { name = _("Channel 19"),	default = 253.0, modulation = _("AM")},	-- krymsk : 124.0, 253.0
                [20] = { name = _("Channel 20"),	default = 266.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
            }
		},
		[2] = {
			name = _("V/UHF Radio 2"),
			range = {
				{min = 30.0,  max = 87.975},
				{min = 108.0, max = 115.975},
				{min = 118.0, max = 173.975},
				{min = 225.0, max = 399.975},
			},
            channels = {
                [1] = { name = _("Channel 1"),		default = 133.0, modulation = _("AM")}, -- Kobuleti ATC
                [2] = { name = _("Channel 2"),		default = 257.8, modulation = _("AM")},	-- Kobuleti ATC
                [3] = { name = _("Channel 3"),		default = 122.1, modulation = _("AM")},	-- Kobuleti ATC
                [4] = { name = _("Channel 4"),		default = 123.3, modulation = _("AM")},	-- Ground Control Approach
                [5] = { name = _("Channel 5"),		default = 344.0, modulation = _("AM")},	-- Ground Control Approach / Search
                [6] = { name = _("Channel 6"),		default = 385.0, modulation = _("AM")},	-- Ground Control Approach / Final
                [7] = { name = _("Channel 7"),		default = 130.0, modulation = _("AM")},	-- Gudauta ATC
                [8] = { name = _("Channel 8"),		default = 385.4, modulation = _("AM")},	-- Ground Control Approach
                [9] = { name = _("Channel 9"),		default = 139.0, modulation = _("AM")},	-- Tblisi - Soganiug ATC
                [10] = { name = _("Channel 10"),	default = 140.0, modulation = _("AM")},	-- Vazinai ATC
                [11] = { name = _("Channel 11"),	default = 134.0, modulation = _("AM")},	-- Kutaisi - Kopitnari ATC
                [12] = { name = _("Channel 12"),	default = 132.0, modulation = _("AM")},	-- Senaki-Koikhi ATC
                [13] = { name = _("Channel 13"),	default = 131.0, modulation = _("AM")},	-- Batumi ATC
                [14] = { name = _("Channel 14"),	default = 129.0, modulation = _("AM")},	-- Sukhumi - Babushara
                [15] = { name = _("Channel 15"),	default = 138.0, modulation = _("AM")},	-- Tiblisi - Lochini ATC
                [16] = { name = _("Channel 16"),	default = 121.0, modulation = _("AM")},	-- Anapa ATC
                [17] = { name = _("Channel 17"),	default = 126.0, modulation = _("AM")},	-- Gelendzhik ATC
                [18] = { name = _("Channel 18"),	default = 125.0, modulation = _("AM")},	-- Maykop - Khanskaya ATC
                [19] = { name = _("Channel 19"),	default = 128.0, modulation = _("AM")},	-- Krasnodar-Pashkovsky ATC
                [20] = { name = _("Channel 20"),	default = 122.0, modulation = _("AM")}, -- Krasnodar-Center ATC
				[21] = { name = _("Channel 21"),	default = 123.0, modulation = _("AM")}, -- Novorossiysk ATC
				[22] = { name = _("Channel 22"),	default = 124.0, modulation = _("AM")}, -- Krymsk ATC
				[23] = { name = _("Channel 23"),	default = 135.0, modulation = _("AM")}, -- Mineralnye Vody ATC
				[24] = { name = _("Channel 24"),	default = 136.0, modulation = _("AM")}, -- Nalchik ATC
				[25] = { name = _("Channel 25"),	default = 141.0, modulation = _("AM")}, -- Beslan ATC
				[26] = { name = _("Channel 26"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[27] = { name = _("Channel 27"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[28] = { name = _("Channel 28"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[29] = { name = _("Channel 29"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[30] = { name = _("Channel 30"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[31] = { name = _("Channel 31"),	default = 123.0, modulation = _("AM")}, -- Novorossiysk ATC
				[32] = { name = _("Channel 32"),	default = 124.0, modulation = _("AM")}, -- Krymsk ATC
				[33] = { name = _("Channel 33"),	default = 135.0, modulation = _("AM")}, -- Mineralnye Vody ATC
				[34] = { name = _("Channel 34"),	default = 136.0, modulation = _("AM")}, -- Nalchik ATC
				[35] = { name = _("Channel 35"),	default = 141.0, modulation = _("AM")}, -- Beslan ATC
				[36] = { name = _("Channel 36"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[37] = { name = _("Channel 37"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[38] = { name = _("Channel 38"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[39] = { name = _("Channel 39"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[40] = { name = _("Channel 40"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
            }
		},
		--[[
		[3] = {
			name = _("V/UHF Radio 3"),
			range = {
				{min = 30.0,  max = 87.975},
				{min = 108.0, max = 115.975},
				{min = 118.0, max = 173.975},
				{min = 225.0, max = 399.975},
			},
            channels = {
                [1] = { name = _("Channel 1"),		default = 133.0, modulation = _("AM")}, -- Kobuleti ATC
                [2] = { name = _("Channel 2"),		default = 257.8, modulation = _("AM")},	-- Kobuleti ATC
                [3] = { name = _("Channel 3"),		default = 122.1, modulation = _("AM")},	-- Kobuleti ATC
                [4] = { name = _("Channel 4"),		default = 123.3, modulation = _("AM")},	-- Ground Control Approach
                [5] = { name = _("Channel 5"),		default = 344.0, modulation = _("AM")},	-- Ground Control Approach / Search
                [6] = { name = _("Channel 6"),		default = 385.0, modulation = _("AM")},	-- Ground Control Approach / Final
                [7] = { name = _("Channel 7"),		default = 130.0, modulation = _("AM")},	-- Gudauta ATC
                [8] = { name = _("Channel 8"),		default = 385.4, modulation = _("AM")},	-- Ground Control Approach
                [9] = { name = _("Channel 9"),		default = 139.0, modulation = _("AM")},	-- Tblisi - Soganiug ATC
                [10] = { name = _("Channel 10"),	default = 140.0, modulation = _("AM")},	-- Vazinai ATC
                [11] = { name = _("Channel 11"),	default = 134.0, modulation = _("AM")},	-- Kutaisi - Kopitnari ATC
                [12] = { name = _("Channel 12"),	default = 132.0, modulation = _("AM")},	-- Senaki-Koikhi ATC
                [13] = { name = _("Channel 13"),	default = 131.0, modulation = _("AM")},	-- Batumi ATC
                [14] = { name = _("Channel 14"),	default = 129.0, modulation = _("AM")},	-- Sukhumi - Babushara
                [15] = { name = _("Channel 15"),	default = 138.0, modulation = _("AM")},	-- Tiblisi - Lochini ATC
                [16] = { name = _("Channel 16"),	default = 121.0, modulation = _("AM")},	-- Anapa ATC
                [17] = { name = _("Channel 17"),	default = 126.0, modulation = _("AM")},	-- Gelendzhik ATC
                [18] = { name = _("Channel 18"),	default = 125.0, modulation = _("AM")},	-- Maykop - Khanskaya ATC
                [19] = { name = _("Channel 19"),	default = 128.0, modulation = _("AM")},	-- Krasnodar-Pashkovsky ATC
                [20] = { name = _("Channel 20"),	default = 122.0, modulation = _("AM")}, -- Krasnodar-Center ATC
				[21] = { name = _("Channel 21"),	default = 123.0, modulation = _("AM")}, -- Novorossiysk ATC
				[22] = { name = _("Channel 22"),	default = 124.0, modulation = _("AM")}, -- Krymsk ATC
				[23] = { name = _("Channel 23"),	default = 135.0, modulation = _("AM")}, -- Mineralnye Vody ATC
				[24] = { name = _("Channel 24"),	default = 136.0, modulation = _("AM")}, -- Nalchik ATC
				[25] = { name = _("Channel 25"),	default = 141.0, modulation = _("AM")}, -- Beslan ATC
				[26] = { name = _("Channel 26"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[27] = { name = _("Channel 27"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[28] = { name = _("Channel 28"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[29] = { name = _("Channel 29"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[30] = { name = _("Channel 30"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[31] = { name = _("Channel 31"),	default = 123.0, modulation = _("AM")}, -- Novorossiysk ATC
				[32] = { name = _("Channel 32"),	default = 124.0, modulation = _("AM")}, -- Krymsk ATC
				[33] = { name = _("Channel 33"),	default = 135.0, modulation = _("AM")}, -- Mineralnye Vody ATC
				[34] = { name = _("Channel 34"),	default = 136.0, modulation = _("AM")}, -- Nalchik ATC
				[35] = { name = _("Channel 35"),	default = 141.0, modulation = _("AM")}, -- Beslan ATC
				[36] = { name = _("Channel 36"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[37] = { name = _("Channel 37"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[38] = { name = _("Channel 38"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[39] = { name = _("Channel 39"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
				[40] = { name = _("Channel 40"),	default = 127.0, modulation = _("AM")}, -- Sochi Adler ATC
            }
       },
	   --]]
	},
	
	InheriteCommonCallnames = true,
	
	TACAN_AA	= true,
	
	----------- ECM Characteristics -----------
	passivCounterm = {
		CMDS_Edit = true,
		SingleChargeTotal = 240,
		-- RR-170
		chaff = {default = 120, increment = 30, chargeSz = 1},
		-- MJU-7
		flare = {default = 60, increment = 15, chargeSz = 2}
	},
	
	chaff_flare_dispenser 	= {
		{ dir =  {0, -1, 0}, pos =  {1.20589, -0.80452,  0.9748}, },
		{ dir =  {0, -1, 0}, pos =  {1.20589, -0.80452, -0.9748}, },
	},
	
	Countermeasures = {
		ECM = "AN/ALQ-135"
	},
	
	EPLRS = true,
	
	--------- Armament Characteristics ---------
	-- function gun_mount(template_name, ammo_override, mount_override, trigger_override)	
	Guns = {m61({})},
	ammo_type_default = 1, -- interface to set desired ammunition mix in ME (DCSCORE-1104)
	ammo_type ={
			_("PGU-28/B SAPHEI High Explosive Armor Piercing PGU"),
			_("M56 HEI High Explosive Incendiary"),
	},
	
	--[[
  shells = {
				shell_ref("M61_20_HE"),		 	-- 1 XM242 HEI-T
				shell_ref("M61_20_HE_INVIS"),	-- 2 M56 HEI without tracers
				shell_ref("M61_20_AP"),			-- 3 M53 API
				shell_ref("M61_20_TP"),			-- 4 M55 TP target practice
				shell_ref("M61_20_TP_T"),		-- 5 M220 TP-T target practice-tracer
				shell_ref("M61_20_PGU28"),		-- 6 PGU-28/B SAPHEI
				shell_ref("M61_20_PGU27"),		-- 7 PGU-27/B TP target practice
				shell_ref("M61_20_PGU30"),		-- 8 PGU-30/B TP-T target practice-tracer
			}
	--]]
	
	
	Pylons = {
		--          Front/Rear, Up/Down, Left/Right
		--            +   -      +  -      -    +
		-- Left Wing
		
        pylon(1, 0, 0.660000, -0.078000, -3.325000, { connector = "Pylon1",  use_full_connector_position = true, DisplayName = "2A", },
            {
                {	CLSID = AIM9L,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9M,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9P,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9J,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
                --[[
				{	CLSID = AIM9X,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
				--]]
                ----
				{	CLSID = AIM120B,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU15B}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {AGM130}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
				{	CLSID = AIM120C,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU15B}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {AGM130}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
				----
                {	CLSID = CATM9M,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
				--[[
				{	CLSID = ACMIPOD, 
					attach_point_position = {0.30,  0.0,  0.0},
					forbidden = {
						{station =  3, loadout = {ACMIPOD}},
						{station = 13, loadout = {ACMIPOD}},
						{station = 15, loadout = {ACMIPOD}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
				--]]
            }
        ),
		
        pylon(2, 0, -0.155000, -0.343000, -2.944000, { arg = 308, arg_value = 0, connector = "Pylon2",  use_full_connector_position = true, DisplayName = "2", droppable_shape	= "f-15E_Pylon_2", },
            {
				-- Iron Bombs
				{	CLSID = MK82LD, forbidden = Pylon2_MK80s_restrictions },
				{	CLSID = MK82SE, forbidden = Pylon2_MK80s_restrictions },
				{	CLSID = MK82AR, forbidden = Pylon2_MK80s_restrictions },
				{	CLSID = MK84LD, forbidden = Pylon2_MK80s_restrictions },
				{	CLSID = MK84AR, forbidden = Pylon2_MK80s_restrictions },
				
				-- Cluster Bombs
				{	CLSID = CBU087, forbidden = Pylon2_general_restrictions },
				{	CLSID = CBU097, forbidden = Pylon2_general_restrictions },
				{	CLSID = CBU100, forbidden = Pylon2_general_restrictions },
				
				-- Guided Bombs
				{	CLSID = GBU010, 
					forbidden = Pylon2_GBUs_restrictions
				},
				{	CLSID = GBU012, 
					forbidden = Pylon2_GBUs_restrictions
				},
				{	CLSID = GBU024, 
					forbidden = Pylon2_GBUs_restrictions
				},	
				--[[
				{	CLSID = GBU027, 
					forbidden = {
						{station = 1}, loadout = {AIM9L}, 
						{station = 1}, loadout = {AIM9M}, 
						{station = 1}, loadout = {AIM9P}, 
						{station = 1}, loadout = {AIM9X}, 
						{station = 3}, loadout = {AIM9L}, 
						{station = 3}, loadout = {AIM9M}, 
						{station = 3}, loadout = {AIM9P}, 
						{station = 3}, loadout = {AIM9X}, 
						{station = 4, loadout = {"{CFT_L_MK82LD_x_6}"}},
						{station = 4, loadout = {"{CFT_L_MK82SE_x_6}"}},
						{station = 4, loadout = {"{CFT_L_MK82AR_x_6}"}},
						{station = 4, loadout = {"{CFT_L_CBU_87_x_6}"}},
						{station = 4, loadout = {"{CFT_L_CBU_97_x_6}"}},
						{station = 4, loadout = {"{CFT_L_GBU_12_x_4}"}},
					} 
				},
				{	CLSID = GBU028,
					attach_point_position = { 0.14, -0.14, 0.0},
					required = {{station = 14, loadout = {GBU028}}},
					forbidden = {
						{station = 4},
						{station = 8, loadout = {GBU028}},
						{station = 12}
					}
				},
				
				-- TV Guided Bombs
				{	CLSID = GBU15B, 
					required = {{station = 8, loadout = {AXQ014}}},
					forbidden = Pylon2_AGMs_restrictions
				},
				{	CLSID = AGM130, Type = 1,
					required = {{station = 8, loadout = {AXQ014}}},
					forbidden = Pylon2_AGMs_restrictions
				},
				--]]
				-- Smart Weapons
				{	CLSID = GBU31A, forbidden = Pylon2_MK80s_restrictions },
				{	CLSID = GBU31B, forbidden = Pylon2_MK80s_restrictions },
				{	CLSID = GBU038, forbidden = Pylon2_MK80s_restrictions },
				{	CLSID = GBU054, forbidden = Pylon2_MK80s_restrictions },
				--[[
				{	CLSID = AGM154A, Type = 1, forbidden = Pylon2_general_restrictions },
				{	CLSID = CBU103, forbidden = Pylon2_general_restrictions },
				{	CLSID = CBU105, forbidden = Pylon2_general_restrictions },
				
				-- Missiles
				{	CLSID = AGM65D, forbidden = Pylon2_MK80s_restrictions },
				{	CLSID = AGM65H, forbidden = Pylon2_MK80s_restrictions },
				{	CLSID = AGM65K, forbidden = Pylon2_MK80s_restrictions },
				{	CLSID = AGM65G, forbidden = Pylon2_MK80s_restrictions },
				
				{	CLSID = AGM65DX3, forbidden = {{station = 4}} },
				{	CLSID = AGM65HX3, forbidden = {{station = 4}} },
				{	CLSID = AGM65KX3, forbidden = {{station = 4}} },
				
				{	CLSID = TGM65D,  forbidden = Pylon2_MK80s_restrictions  },
				{	CLSID = TGM65H,  forbidden = Pylon2_MK80s_restrictions  },
				{	CLSID = CATM65K, forbidden = Pylon2_MK80s_restrictions  },
				{	CLSID = TGM65G,  forbidden = Pylon2_MK80s_restrictions  },
				--]]
				
				-- Practice
				{ CLSID	= BDU50LD,  forbidden = Pylon2_MK80s_restrictions },
				{ CLSID	= BDU50HD,  forbidden = Pylon2_MK80s_restrictions },
				{ CLSID = BDU50LGB, forbidden = Pylon2_MK80s_restrictions },
				{ CLSID = BDU56AR,  forbidden = Pylon2_MK80s_restrictions },
				
				-- Pods
				{	CLSID = MXU648, forbidden = Pylon2_MK80s_restrictions  },
				
				-- FUEL TANK
				{	CLSID = EXTTNK,			arg_value = 0.20, forbidden = Pylon2_MK80s_restrictions },	-- 610 GAL Fuel Tank
				{	CLSID = EXTTNK_EMPTY,	arg_value = 0.20, forbidden = Pylon2_MK80s_restrictions },	-- 610 GAL Fuel Tank
				
				-- CLEAN 
				{ CLSID = NOPYLON, arg_value = 1, add_mass = -264.44,
					forbidden = {{station = 1}, {station = 3}},
				},
            }
        ),
		
        pylon(3, 0, 0.660000, -0.078000, -2.563000, { connector = "Pylon3", use_full_connector_position = true, DisplayName = "2B", },
            {
                {	CLSID = AIM9L,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9M,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9P,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9J,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
				--[[
                {	CLSID = AIM9X,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
				--]]
				----
                {	CLSID = AIM120B,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU15B}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {AGM130}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
				{	CLSID = AIM120C,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU15B}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {AGM130}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
				----
                {	CLSID = CATM9M,
					forbidden = {
						{station = 2, loadout = {GBU010}},
						{station = 2, loadout = {GBU012}},
						{station = 2, loadout = {GBU024}},
						{station = 2, loadout = {GBU027}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
				--[[
				{	CLSID = ACMIPOD, 
					attach_point_position = {0.30,  0.0,  0.0},
					forbidden = {
						{station =  1, loadout = {ACMIPOD}},
						{station = 13, loadout = {ACMIPOD}},
						{station = 15, loadout = {ACMIPOD}},
						{station = 2, loadout = {NOPYLON}},
					}
				},
				--]]
            }
        ),
		
		------------ 
		
		pylon(4, 0, 0.0, -0.6000, -2.1, { connector = "Pylon8",  use_full_connector_position = false, DisplayName = "L-CFT", },
			{
				{	CLSID	= MK82LD,	connector	= CFT_L2,	forbidden	= LCFT_general_restrictions },
				{	CLSID	= MK82SE,	connector	= CFT_L2,	forbidden	= LCFT_general_restrictions },
				{	CLSID	= MK82AR,	connector	= CFT_L2,	forbidden	= LCFT_general_restrictions },
				{	CLSID	= MK84LD,	connector	= CFT_L2,	forbidden	= LCFT_general_restrictions },
				{	CLSID	= MK84AR,	connector	= CFT_L2,	forbidden	= LCFT_general_restrictions },
				----
				{	CLSID	= "{CFT_L_MK82LD_x_2}",	forbidden	= LCFT_general_restrictions },
				{	CLSID	= "{CFT_L_MK82LD_x_3}",	forbidden	= LCFT_general_restrictions },
				{	CLSID	= "{CFT_L_MK82LD_x_6}",	forbidden	= LCFT_MK80sx6_restrictions },
				{	CLSID	= "{CFT_L_MK82SE_x_2}",	forbidden	= LCFT_general_restrictions },
				{	CLSID	= "{CFT_L_MK82SE_x_3}",	forbidden	= LCFT_general_restrictions },
				{	CLSID	= "{CFT_L_MK82SE_x_6}",	forbidden	= LCFT_MK80sx6_restrictions	},
				{	CLSID	= "{CFT_L_MK82AR_x_2}",	forbidden	= LCFT_general_restrictions },
				{	CLSID	= "{CFT_L_MK82AR_x_3}",	forbidden	= LCFT_general_restrictions },
				{	CLSID	= "{CFT_L_MK82AR_x_6}",	forbidden	= LCFT_MK80sx6_restrictions },
				{	CLSID	= "{CFT_L_MK84LD_x_2}",	forbidden	= LCFT_general_restrictions },
				{	CLSID	= "{CFT_L_MK84AR_x_2}",	forbidden	= LCFT_general_restrictions },
				----
				{	CLSID	= "{CFT_L_BLU107_x_3}",	forbidden	= LCFT_general_restrictions },
				{	CLSID	= "{CFT_L_BLU107_x_6}",	forbidden	= LCFT_general_restrictions },
				{	CLSID	= "{CFT_L_CBU_87_x_3}",	forbidden	= LCFT_general_restrictions },
				{	CLSID	= "{CFT_L_CBU_87_x_6}",	forbidden	= { {station = 5}, {station = 6}, {station = 2}, {station = 14, loadout = {GBU028}} } },
				{	CLSID	= "{CFT_L_CBU_97_x_3}",	forbidden	= LCFT_general_restrictions },
				{	CLSID	= "{CFT_L_CBU_97_x_6}",	forbidden	= { {station = 5}, {station = 6}, {station = 2}, {station = 14, loadout = {GBU028}} } },
				{	CLSID		= "{CFT_L_CBU_100_x_3}",
					forbidden	= LCFT_general_restrictions
				},
				{	CLSID		= "{CFT_L_CBU_100_x_6}", 
					forbidden	= LCFT_general_restrictions
				},
				--[[
				{	CLSID		= "{CFT_L_CBU_103_x_3}",
					forbidden	= LCFT_general_restrictions
				},
				{	CLSID		= "{CFT_L_CBU_105_x_3}",
					forbidden	= LCFT_general_restrictions
				},
				--]]
				{	CLSID		= GBU012,
					connector	= CFT_L3,
					forbidden	= LCFT_general_restrictions
				},
				{	CLSID		= "{CFT_L_GBU_12_x_2}",
					forbidden	= LCFT_general_restrictions
				},
				{	CLSID		= "{CFT_L_GBU_12_x_4}",
					forbidden	= LCFT_MK80sx6_restrictions
				},
				{	CLSID		= GBU010,
					connector	= CFT_L2,
					forbidden	= LCFT_general_restrictions
				},
                {	CLSID		= "{CFT_L_GBU_10_x_2}",
					forbidden	= LCFT_general_restrictions
				},
				{	CLSID		= GBU024,
					connector	= CFT_L2,
					forbidden	= LCFT_general_restrictions
				},
				--[[
				{	CLSID		= GBU027,
					connector	= CFT_L2,
					forbidden	= LCFT_general_restrictions
				},
                {	CLSID		= "{CFT_L_GBU_27_x_2}",
					forbidden	= RLCFT_general_restrictions
				},
				--]]
				{	CLSID = GBU31A,
					connector	= CFT_L2,
					forbidden	= LCFT_general_restrictions
				},
				{	CLSID		= "{CFT_L_GBU_31_x_2}",
					forbidden	= LCFT_general_restrictions
				},
                {	CLSID		= "{CFT_L_GBU_31V3B_x_1}",
					forbidden	= LCFT_general_restrictions
				},
				{	CLSID		= "{CFT_L_GBU_31V3B_x_2}",
					forbidden	= LCFT_general_restrictions
				},
				{	CLSID		= "{CFT_L_GBU_38_x_3}",
					forbidden	= LCFT_general_restrictions
				},
				{	CLSID		= "{CFT_L_GBU_54_x_3}",
					forbidden	= LCFT_general_restrictions
				},
				
				
				-- Practice
				{	CLSID		= BDU50LD,	connector	= CFT_L2,	forbidden	= LCFT_general_restrictions },
				{	CLSID		= BDU50HD,	connector	= CFT_L2,	forbidden	= LCFT_general_restrictions },
				{	CLSID		= BDU50LGB,	connector	= CFT_L3,	forbidden	= LCFT_general_restrictions },
				{	CLSID		= BDU56AR,	connector	= CFT_L3,	forbidden	= LCFT_general_restrictions },
				
				{	CLSID		= "{CFT_L_BDU50LD_x_2}",	forbidden	= LCFT_general_restrictions },
				{	CLSID		= "{CFT_L_BDU50LD_x_3}",	forbidden	= LCFT_general_restrictions },
				{	CLSID		= "{CFT_L_BDU50LD_x_6}",	forbidden	= LCFT_general_restrictions },
				
				{	CLSID		= "{CFT_L_BDU50HD_x_2}",	forbidden	= LCFT_general_restrictions },
				{	CLSID		= "{CFT_L_BDU50HD_x_3}",	forbidden	= LCFT_general_restrictions },
				{	CLSID		= "{CFT_L_BDU50HD_x_6}",	forbidden	= LCFT_general_restrictions },
				
				{	CLSID		= "{CFT_L_BDU50LGB_x_2}",	forbidden	= LCFT_general_restrictions },
				{	CLSID		= "{CFT_L_BDU50LGB_x_4}",	forbidden	= LCFT_general_restrictions },
				
				{	CLSID		= "{CFT_L_BDU56AR_x_2}",	forbidden	= LCFT_general_restrictions },
				
				--Pods
				{	CLSID		= MXU648,
					connector	= CFT_L2,
					forbidden	= LCFT_general_restrictions
				},
			}
		),
		
		------------
		
		pylon(5, 0, 1.9000, -1.10000, -1.75, { connector = CFT_L3, use_full_connector_position = true, DisplayName	= "3C", arg = 316, arg_value = 0, },
            {
				{	CLSID = AIM7M,		Type = 1, arg_value = 0.15, forbidden = {{station = 4}} }, 
				{	CLSID = AIM7F,		Type = 1, arg_value = 0.15, forbidden = {{station = 4}} }, 
				{	CLSID = AIM7H,		Type = 1, arg_value = 0.15, forbidden = {{station = 4}} }, 
                {	CLSID = AIM120B,	Type = 1, arg_value = 0.15, forbidden = {{station = 4}} }, 
				{	CLSID = AIM120C,	Type = 1, arg_value = 0.15, forbidden = {{station = 4}} }, 
				{	CLSID = MXU648,		forbidden = {{station = 4}} }
            }
		),
		
        pylon(6, 0, -3.20000, -0.880000, -1.75, { connector = CFT_L1,  use_full_connector_position = true, DisplayName = "4C", arg = 314, arg_value = 0, },
            {
				{	CLSID = AIM7M,		Type = 1, arg_value = 0.15, forbidden = {{station = 4}} }, 
				{	CLSID = AIM7F,		Type = 1, arg_value = 0.15, forbidden = {{station = 4}} }, 
				{	CLSID = AIM7H,		Type = 1, arg_value = 0.15, forbidden = {{station = 4}} }, 
                {	CLSID = AIM120B,	Type = 1, arg_value = 0.15, forbidden = {{station = 4}} }, 
				{	CLSID = AIM120C,	Type = 1, arg_value = 0.15, forbidden = {{station = 4}} }, 
				{	CLSID = MXU648,		forbidden = {{station = 4}} }
            }
        ),
		
		
		------------
		
        pylon(7, 0, 2.4, -1.1, -1.3, { arg = 309, arg_value = 0, connector = "Pylon20", use_full_connector_position = true, DisplayName = "TGP", },
			{
				{	CLSID = AAQ14RZ, arg_value = 1.0, },
				--{	CLSID = AAQ28RZ, arg_value = 1.0, },
				--{	CLSID = AAQ33RZ, arg_value = 1.0, },
			}
        ),
		
		------------
		
        pylon(8, 0, 0.184000, -1.030000, 0.000000, {arg = 317, arg_value = 0, connector = "Pylon10", use_full_connector_position = true, DisplayName	= "5", droppable_shape	= "f-15E_Pylon_5", },
            {
				-- Iron Bombs
             	{ CLSID = MK82LD },
				{ CLSID = MK82SE },
				{ CLSID = MK82AR },
				{ CLSID = MK84LD },
				{ CLSID = MK84AR },
				
				-- Cluster Bombs
				{ CLSID = CBU087 },
				{ CLSID = CBU097 },
				{ CLSID = CBU100 },			
				--{ CLSID = CBU103 },			
				--{ CLSID = CBU105 },
				
				-- Guided Bombs
				{ CLSID = GBU010 },
				{ CLSID = GBU012 },
				{ CLSID = GBU024 },
				--[[
				{ CLSID = GBU027 },
				{ CLSID = GBU028,	
					attach_point_position = { 0.00, -0.14, 0.0},
					forbidden = {
						{station =  2, loadout = {GBU028}},
						{station = 14, loadout = {GBU028}}
					} 
				},	
				--]]
				{ CLSID = GBU31A },
				{ CLSID = GBU31B },
				{ CLSID = GBU038 },
				{ CLSID = GBU054 },

				--[[
				{ CLSID = AGM154A },
				--]]
				
				-- Practice Bombs
				{ CLSID	= BDU50LD },
				{ CLSID	= BDU50HD },
				{ CLSID = BDU50LGB },
				{ CLSID = BDU56AR },
				
				-- Pods
				{ CLSID	= AXQ014, attach_point_position = { -0.10, 0.0, 0.0}, },
				{ CLSID	= MXU648 },
				
				-- FUEL TANK
				{ CLSID = EXTTNK, arg_value = 0.20, },	-- 610 GAL Fuel Tank
				{ CLSID = EXTTNK_EMPTY, arg_value = 0.20 },	-- 610 GAL Fuel Tank
				
				-- CLEAN 
				{ CLSID = NOPYLON, arg_value = 1, add_mass = -143.335},
            }
        ),
		
		------------
		
        pylon(9, 0, 2.4, -1.1, 1.3, { arg = 321, arg_value = 0, connector = "Pylon21", use_full_connector_position = true, DisplayName = "NVP", },
			{
				{	CLSID = AAQ13RZ, arg_value = 1.0, },
			}
        ),
		
		------------
		
        pylon(10, 0 , -3.20000, -0.880000, 1.75, { connector = CFT_R1, use_full_connector_position = true, DisplayName	= "6C", arg = 318, arg_value = 0, },
            {
				{	CLSID = AIM7M,		Type = 1, arg_value = 0.15, forbidden = {{station = 12}} }, 
				{	CLSID = AIM7F,		Type = 1, arg_value = 0.15, forbidden = {{station = 12}} }, 
				{	CLSID = AIM7H,		Type = 1, arg_value = 0.15, forbidden = {{station = 12}} }, 
                {	CLSID = AIM120B,	Type = 1, arg_value = 0.15, forbidden = {{station = 12}} }, 
				{	CLSID = AIM120C,	Type = 1, arg_value = 0.15, forbidden = {{station = 12}} }, 
				{	CLSID = MXU648,		forbidden = {{station = 12}} }
            }
        ),
		
        pylon(11, 0, 1.9000, -1.10000, 1.75, { connector = CFT_R3, use_full_connector_position = true, DisplayName	= "7C", arg = 320, arg_value = 0, },
            {
				{	CLSID = AIM7M,		Type = 1, arg_value = 0.15, forbidden = {{station = 12}} }, 
				{	CLSID = AIM7F,		Type = 1, arg_value = 0.15, forbidden = {{station = 12}} }, 
				{	CLSID = AIM7H,		Type = 1, arg_value = 0.15, forbidden = {{station = 12}} }, 
                {	CLSID = AIM120B,	Type = 1, arg_value = 0.15, forbidden = {{station = 12}} }, 
				{	CLSID = AIM120C,	Type = 1, arg_value = 0.15, forbidden = {{station = 12}} }, 
				{	CLSID = MXU648,		forbidden = {{station = 12}} }
            }
        ),
		
		------------
		
		pylon(12, 0, 0.0, -0.6000, 2.1, { connector = "Pylon12", use_full_connector_position = false, DisplayName = "R-CFT", },
			{
				{	CLSID	= MK82LD,	connector	= CFT_R5, forbidden	= RCFT_general_restrictions },
				{	CLSID	= MK82SE,	connector	= CFT_R5,	forbidden	= RCFT_general_restrictions },
				{	CLSID	= MK82AR,	connector	= CFT_R5,	forbidden	= RCFT_general_restrictions },
				{	CLSID	= MK84LD,	connector	= CFT_R5,	forbidden	= RCFT_general_restrictions },
				{	CLSID	= MK84AR,	connector	= CFT_R5,	forbidden	= RCFT_general_restrictions },
				----
				{	CLSID	= "{CFT_R_MK82LD_x_2}",	forbidden	= RCFT_general_restrictions },
				{	CLSID	= "{CFT_R_MK82LD_x_3}",	forbidden	= RCFT_general_restrictions },
				{	CLSID	= "{CFT_R_MK82LD_x_6}",	forbidden	= RCFT_MK80sx6_restrictions },
				{	CLSID	= "{CFT_R_MK82SE_x_2}",	forbidden	= RCFT_general_restrictions },
				{	CLSID	= "{CFT_R_MK82SE_x_3}",	forbidden	= RCFT_general_restrictions },
				{	CLSID	= "{CFT_R_MK82SE_x_6}",	forbidden	= RCFT_MK80sx6_restrictions },
				{	CLSID	= "{CFT_R_MK82AR_x_2}",	forbidden	= RCFT_general_restrictions },
				{	CLSID	= "{CFT_R_MK82AR_x_3}",	forbidden	= RCFT_general_restrictions },
				{	CLSID	= "{CFT_R_MK82AR_x_6}",	forbidden	= RCFT_MK80sx6_restrictions },
				{	CLSID	= "{CFT_R_BLU107_x_3}",	forbidden	= RCFT_general_restrictions },
				{	CLSID	= "{CFT_R_BLU107_x_6}",	forbidden	= RCFT_general_restrictions },
				{	CLSID	= "{CFT_R_MK84LD_x_2}",	forbidden	= RCFT_general_restrictions },
				{	CLSID	= "{CFT_R_MK84AR_x_2}",	forbidden	= RCFT_general_restrictions },
				----
				{	CLSID	= "{CFT_R_CBU_87_x_3}",	forbidden	= RCFT_general_restrictions },
				{	CLSID		= "{CFT_R_CBU_87_x_6}", 
					forbidden	= {
						{station = 10},
						{station = 11},
						{station =  2, loadout = {GBU028}},
						{station = 14}
					}
				},
				{	CLSID		= "{CFT_R_CBU_97_x_3}",
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_CBU_97_x_6}", 
					forbidden	= {
						{station = 10},
						{station = 11},
						{station =  2, loadout = {GBU028}},
						{station = 14}
					}
				},
				{	CLSID		= "{CFT_R_CBU_100_x_3}",
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_CBU_100_x_6}", 
					forbidden	= RCFT_general_restrictions
				},
				--[[
				{	CLSID		= "{CFT_R_CBU_103_x_3}",
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_CBU_105_x_3}",
					forbidden	= RCFT_general_restrictions
				},
				--]]
				{	CLSID		= GBU012,
					connector	= CFT_R3,
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_GBU_12_x_2}",
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_GBU_12_x_4}",
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= GBU010,
					connector	= CFT_R5,
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_GBU_10_x_2}",
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= GBU024,
					connector	= CFT_R5,
					forbidden	= RCFT_general_restrictions
				},
				--[[
				{	CLSID		= GBU027,
					connector	= CFT_R5,
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_GBU_27_x_2}",
					forbidden	= RCFT_general_restrictions
				},
				
				{	CLSID		= GBU31A,
					connector	= CFT_R5,
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_GBU_31_x_2}",
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_GBU_31V3B_x_1}",
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_GBU_31V3B_x_2}",
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_GBU_38_x_3}",
					forbidden	= RCFT_general_restrictions
				},
				{	CLSID		= "{CFT_R_GBU_54_x_3}",
					forbidden	= RCFT_general_restrictions
				},
				--]]
				
				-- Practice
				{	CLSID		= BDU50LD,	connector	= CFT_R5, forbidden	= RCFT_general_restrictions },
				{	CLSID		= BDU50HD,	connector	= CFT_R5, forbidden	= RCFT_general_restrictions },
				{	CLSID		= BDU50LGB,	connector	= CFT_R3, forbidden	= RCFT_general_restrictions },
				{	CLSID		= BDU56AR,	connector	= CFT_R3, forbidden	= RCFT_general_restrictions },
				
				{	CLSID		= "{CFT_R_BDU50LD_x_2}",	forbidden = RCFT_general_restrictions },
				{	CLSID		= "{CFT_R_BDU50LD_x_3}",	forbidden = RCFT_general_restrictions },
				{	CLSID		= "{CFT_R_BDU50LD_x_6}",	forbidden = RCFT_MK80sx6_restrictions },
				{	CLSID		= "{CFT_R_BDU50HD_x_2}",	forbidden = RCFT_general_restrictions },
				{	CLSID		= "{CFT_R_BDU50HD_x_3}",	forbidden = RCFT_general_restrictions },
				{	CLSID		= "{CFT_R_BDU50HD_x_6}",	forbidden = RCFT_MK80sx6_restrictions },
				{	CLSID		= "{CFT_R_BDU50LGB_x_2}",	forbidden = RCFT_general_restrictions },
				{	CLSID		= "{CFT_R_BDU50LGB_x_4}",	forbidden = RCFT_general_restrictions },
				{	CLSID		= "{CFT_R_BDU56AR_x_2}",	forbidden = RCFT_general_restrictions },
				
				--Pods
				{	CLSID		= MXU648,
					connector	= CFT_R5,
					forbidden	= RCFT_general_restrictions
				},
			}
		),
		
		------------
		
        pylon(13, 0, 0.660000, -0.078000, 2.563000, { connector = "Pylon17", use_full_connector_position = true, DisplayName	= "8A", },
            {
                {	CLSID = AIM9L,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9M,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9P,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9J,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				--[[
                {	CLSID = AIM9X,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				--]]
				----
                {	CLSID = AIM120B,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				{	CLSID = AIM120C,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				----
                {	CLSID = CATM9M,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				--[[
				{	CLSID = ACMIPOD, 
					attach_point_position = {0.30,  0.0,  0.0},
					forbidden = {
						{station =  1, loadout = {ACMIPOD}},
						{station =  3, loadout = {ACMIPOD}},
						{station = 15, loadout = {ACMIPOD}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				--]]
            }
        ),
		
        pylon(14, 0, -0.155000, -0.343000, 2.944000, { arg = 322, arg_value = 0, connector = "Pylon18", use_full_connector_position = true, DisplayName	= "8", droppable_shape	= "f-15E_Pylon_8", },
            {
				-- Iron Bombs
				{	CLSID = MK82LD, forbidden = Pylon14_MK80s_restrictions },
				{	CLSID = MK82SE, forbidden = Pylon14_MK80s_restrictions },
				{	CLSID = MK82AR, forbidden = Pylon14_MK80s_restrictions },
				{	CLSID = MK84LD, forbidden = Pylon14_MK80s_restrictions },
				{	CLSID = MK84AR, forbidden = Pylon14_MK80s_restrictions },
				
				-- Cluster Bombs
				{	CLSID = CBU087, forbidden = Pylon14_general_restrictions },
				{	CLSID = CBU097, forbidden = Pylon14_general_restrictions },
				{	CLSID = CBU100, forbidden = Pylon14_general_restrictions },
				
				-- Guided Bombs
				{	CLSID = GBU010, 
					forbidden = Pylon14_GBUs_restrictions
				},
				{	CLSID = GBU012, 
					forbidden = Pylon14_GBUs_restrictions
				},
				{	CLSID = GBU024, 
					forbidden = Pylon14_GBUs_restrictions
				},	
				--[[
				{	CLSID = GBU027, 
					forbidden = {
						{station = 13}, loadout = {AIM9L}, 
						{station = 13}, loadout = {AIM9M}, 
						{station = 13}, loadout = {AIM9P}, 
						{station = 13}, loadout = {AIM9X}, 
						{station = 15}, loadout = {AIM9L}, 
						{station = 15}, loadout = {AIM9M}, 
						{station = 15}, loadout = {AIM9P}, 
						{station = 15}, loadout = {AIM9X}, 
						{station = 12, loadout = {"{CFT_L_MK82LD_x_6}"}},
						{station = 12, loadout = {"{CFT_L_MK82SE_x_6}"}},
						{station = 12, loadout = {"{CFT_L_MK82AR_x_6}"}},
						{station = 12, loadout = {"{CFT_L_CBU_87_x_6}"}},
						{station = 12, loadout = {"{CFT_L_CBU_97_x_6}"}},
						{station = 12, loadout = {"{CFT_L_GBU_12_x_4}"}},
					} 
				},
				{	CLSID = GBU028,
					attach_point_position = { 0.14, -0.14, 0.0},
					required = {{station = 2, loadout = {GBU028}}},
					forbidden = {
						{station = 4},
						{station = 8, loadout = {GBU028}},
						{station = 12}
					}
				},
				
				-- TV Guided Bombs
				{	CLSID = GBU15B, 
					required = {{station = 8, loadout = {AXQ014}}},
					forbidden = Pylon14_AGMs_restrictions
				},
				{	CLSID = AGM130,	Type = 1, 
					required = {{station = 8, loadout = {AXQ014}}},
					forbidden = Pylon14_AGMs_restrictions
				},
				
				-- WCMDs
				{	CLSID = CBU103, forbidden = Pylon14_general_restrictions },
				{	CLSID = CBU105, forbidden = Pylon14_general_restrictions },
					--]]
				-- Smart Weapons
				{	CLSID = GBU31A, forbidden = Pylon14_MK80s_restrictions },
				{	CLSID = GBU31B, forbidden = Pylon14_MK80s_restrictions },
				{	CLSID = GBU038, forbidden = Pylon14_MK80s_restrictions },
				{	CLSID = GBU054, forbidden = Pylon14_MK80s_restrictions },
				--[[
				{	CLSID = AGM154A, Type = 1,	forbidden = Pylon14_general_restrictions },
				
				-- Missiles
				{	CLSID = AGM65D, forbidden = Pylon14_MK80s_restrictions },
				{	CLSID = AGM65H, forbidden = Pylon14_MK80s_restrictions },
				{	CLSID = AGM65K, forbidden = Pylon14_MK80s_restrictions },
				{	CLSID = AGM65G, forbidden = Pylon14_MK80s_restrictions },
				
				{	CLSID = AGM65DX3, forbidden = {{station = 12}} },
				{	CLSID = AGM65HX3, forbidden = {{station = 12}} },
				{	CLSID = AGM65KX3, forbidden = {{station = 12}} },
				
				{	CLSID = TGM65D,  forbidden = Pylon14_MK80s_restrictions  },
				{	CLSID = TGM65H,  forbidden = Pylon14_MK80s_restrictions  },
				{	CLSID = CATM65K, forbidden = Pylon14_MK80s_restrictions  },
				{	CLSID = TGM65G,  forbidden = Pylon14_MK80s_restrictions  },
				--]]
				
				-- Practice
				{ CLSID	= BDU50LD,  forbidden = Pylon14_MK80s_restrictions },
				{ CLSID	= BDU50HD,  forbidden = Pylon14_MK80s_restrictions },
				{ CLSID = BDU50LGB, forbidden = Pylon14_MK80s_restrictions },
				{ CLSID = BDU56AR,  forbidden = Pylon14_MK80s_restrictions },
				
				-- Pods
				{	CLSID = MXU648, forbidden = Pylon14_MK80s_restrictions  },
				
				-- FUEL TANK
				{ CLSID = EXTTNK, arg_value = 0.20, forbidden = Pylon14_MK80s_restrictions  },	-- 610 GAL Fuel Tank
				{ CLSID = EXTTNK_EMPTY, arg_value = 0.20 , forbidden = Pylon14_MK80s_restrictions },	-- 610 GAL Fuel Tank
				
				-- CLEAN 
				{ CLSID = NOPYLON, arg_value = 1, add_mass = -264.44,
					forbidden = {{station = 13}, {station = 15}},
				},
            }
        ),
		
        pylon(15, 0, 0.660000, -0.078000, 3.325000, { connector = "Pylon19", use_full_connector_position = true, DisplayName	= "8B", },
            {
                {	CLSID = AIM9L,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9M,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9P,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
                {	CLSID = AIM9J,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				--[[
                {	CLSID = AIM9X,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				--]]
                {	CLSID = AIM120B,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU15B}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {AGM130}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				{	CLSID = AIM120C,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU15B}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {AGM130}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				----
                {	CLSID = CATM9M,
					forbidden = {
						{station = 14, loadout = {GBU010}},
						{station = 14, loadout = {GBU012}},
						{station = 14, loadout = {GBU024}},
						{station = 14, loadout = {GBU027}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				--[[
				{	CLSID = ACMIPOD, 
					attach_point_position = {0.30,  0.0,  0.0},
					forbidden = {
						{station =  1, loadout = {ACMIPOD}},
						{station =  3, loadout = {ACMIPOD}},
						{station = 13, loadout = {ACMIPOD}},
						{station = 14, loadout = {NOPYLON}},
					}
				},
				--]]
            }
        ),
    },

	Tasks = {
        aircraft_task(CAP),
        aircraft_task(Escort),
        aircraft_task(FighterSweep),
        aircraft_task(Intercept),
        aircraft_task(PinpointStrike),
        aircraft_task(CAS),
        aircraft_task(GroundAttack),
        aircraft_task(RunwayAttack),
        aircraft_task(AFAC),
        aircraft_task(Reconnaissance),
    },	
	
	DefaultTask = aircraft_task(GroundAttack),	
	
	------------- Damage Table Reference -------------
	Damage = verbose_to_dmg_properties(
	{
		-- NOSE SECTION
		["NOSE_CENTER"]				= {args = {146},	critical_damage = 3},
		["NOSE_BOTTOM"]				= {args = {148},	critical_damage = 3},
		["NOSE_RIGHT_SIDE"]			= {args = {149, 428},	critical_damage = 3},
		["NOSE_LEFT_SIDE"]			= {args = {150, 428},	critical_damage = 3},
		
		-- COCKPIT
		["COCKPIT"]					= {args = {65},		critical_damage = 1},
		["CABIN_LEFT_SIDE"]			= {args = {298, 428},	critical_damage = 3},
		["CABIN_RIGHT_SIDE"]		= {args = {299, 428},	critical_damage = 3},
		
		-- PYLONS
		["PYLON1"]					= {critical_damage = 3},	-- LEFT WING PYLON
		["PYLON2"]					= {critical_damage = 3},	-- RIGHT WING PYLON
		
		-- CFTs
		
		-- LANDING GEAR
		["WHEEL_F"]					= {critical_damage = 3, args = {134}},	--
		["FRONT_WHEEL"]				= {critical_damage = 3, args = {253}, deps_cells = {"WHEEL_F"}},			-- NOSE GEAR ASSEMBLY
		["FRONT_GEAR_BOX"]			= {critical_damage = 4, args = {265}, deps_cells = {"FRONT_WHEEL"}},		-- NOSE GEAR HOUSING
		["WHEEL_L"]					= {critical_damage = 3, args = {136}},	--
		["LEFT_WHEEL"]				= {critical_damage = 3, args = {259}, deps_cells = {"WHEEL_L"}},			-- LEFT GEAR ASSEMBLY
		["LEFT_GEAR_BOX"]			= {critical_damage = 4, args = {267}, deps_cells = {"LEFT_WHEEL"}},			-- LEFT GEAR HOUSING
		["WHEEL_R"]					= {critical_damage = 3, args = {137}},	--
		["RIGHT_WHEEL"]				= {critical_damage = 3, args = {255}, deps_cells = {"WHEEL_R"}},			-- RIGHT GEAR ASSEMBLY
		["RIGHT_GEAR_BOX"]			= {critical_damage = 4, args = {266}, deps_cells = {"RIGHT_WHEEL"}},		-- RIGHT GEAR HOUSING
		
		-- FUSELAGE SECTION
		["GUN"]						= {args = {160},	critical_damage = 3},
		["FUSELAGE_RIGHT_SIDE"]		= {args = {153},	critical_damage = 3},
		["FUEL_TANK_F"]				= {args = {166},	critical_damage = 3},
		["FUSELAGE_LEFT_SIDE"]		= {args = {154},	critical_damage = 3},
		["FUSELAGE_BOTTOM"]			= {args = {152},	critical_damage = 4},
		["AIR_BRAKE_R"]				= {args = {183},	critical_damage = 3},
		["HOOK"]					= {args = {268}, 	critical_damage = 2},
		
		-- WINGS
		["WING_R_OUT"]				= {args = {213},	critical_damage = 2},
		["WING_R_CENTER"]			= {args = {214},	critical_damage = 4, deps_cells = {"WING_R_OUT", "ELERON_R"}},
		["WING_R_IN"]				= {args = {215},	critical_damage = 5, deps_cells = {"WING_R_CENTER", "WING_R_OUT", "ELERON_R"}},
		["ELERON_R"]				= {args = {216},	critical_damage = 3},
		["FLAP_R_IN"]				= {args = {217},	critical_damage = 3},

		["WING_L_OUT"]				= {args = {223},	critical_damage = 2},
		["WING_L_CENTER"]			= {args = {224}, 	critical_damage = 4, deps_cells = {"WING_L_OUT", "ELERON_L"}},
		["WING_L_IN"]				= {args = {225}, 	critical_damage = 5, deps_cells = {"WING_L_CENTER", "WING_L_OUT", "ELERON_L"}},
		["ELERON_L"]				= {args = {226},	critical_damage = 3},		
		["FLAP_L_IN"]				= {args = {227},	critical_damage = 3},		
			
		-- TAILS
		["ELEVATOR_R_IN"]			= {args = {238},	critical_damage = 2},
		["RUDDER_R"]				= {args = {247},	critical_damage = 1},
		["FIN_R_TOP"]				= {args = {241},	critical_damage = 2, deps_cells = {"RUDDER_R"}},
		["FIN_R_BOTTOM"]			= {args = {243},	critical_damage = 4, deps_cells = {"FIN_R_TOP"}, {"RUDDER_R"}},
		
		["ELEVATOR_L_IN"]			= {args = {240},	critical_damage = 2},
		["RUDDER_L"]				= {args = {248},	critical_damage = 1},
		["FIN_L_TOP"]				= {args = {244},	critical_damage = 2, deps_cells = {"RUDDER_L"}},
		["FIN_L_BOTTOM"]			= {args = {246},	critical_damage = 4, deps_cells = {"FIN_L_TOP"}, {"RUDDER_L"}},
		
		-- ENGINES
		["TAIL_RIGHT_SIDE"]			= {args = {157},	critical_damage = 3},
		["TAIL_LEFT_SIDE"]			= {args = {158},	critical_damage = 3},		
		["ENGINE_R"]				= {args = {161},	critical_damage = 5},
		["TOP_CENTER_RIGHT_ENGINE"]	= {args = {162},	critical_damage = 3},
		["BOTTOM_RIGHT_ENGINE"]		= {args = {163},	critical_damage = 3},
		["ENGINE_L"]				= {args = {167},	critical_damage = 5},
		["TOP_CENTER_LEFT_ENGINE"]	= {args = {168},	critical_damage = 3},
		["BOTTOM_LEFT_ENGINE"]		= {args = {169},	critical_damage = 3},

		["CREW_1"]					= { --[[args = {},]] critical_damage = 1 },
		["CREW_2"]					= { --[[args = {},]] critical_damage = 1 },
		
	}
	),-- end of Damage

	DamageParts 	=
 	{
			[1] = "f-15e-damage-wing-r",
			[2] = "f-15e-damage-wing-l",
	},
	
	--------- Failure Table Reference ----------
	
	----- External Lights Table Reference ------
	-- Must create the connectors in the exernal model for the external lights
	--[[ 
		LIGHT COLLECTION DATA
		WOLALIGHT_STROBES          = 1		--White strobe anti-collision lights.--
		WOLALIGHT_SPOTS            = 2		--Take-off and landing high power headlights.--
		WOLALIGHT_LANDING_LIGHTS   = 2		--Take-off and landing high power headlights.--
		WOLALIGHT_NAVLIGHTS        = 3		--P-Z colored navigation (position) wingtip lights..--
		WOLALIGHT_FORMATION_LIGHTS = 4		--Formation / Logo lights.--
		WOLALIGHT_TIPS_LIGHTS      = 5		--Helicopter-specific: rotor anti-collision tips lights.--
		WOLALIGHT_TAXI_LIGHTS      = 6		--Taxi headlights.--
		WOLALIGHT_BEACONS          = 7		--Rotary anti-collision lights.--
		WOLALIGHT_CABIN_BOARDING   = 8		--Cabin incandescence illumination.--
		WOLALIGHT_CABIN_NIGHT      = 9		--Cabin night time (UV) illumination.--
		WOLALIGHT_REFUEL_LIGHTS    = 10		--Refuel apparatus illumination.--
		WOLALIGHT_PROJECTORS       = 11		--Search lights, direction-controlled.--
		WOLALIGHT_AUX_LIGHTS       = 12		--Signal lights, also all aux. lights not fitting into other categories.--
		WOLALIGHT_IR_FORMATION     = 13		--IR formation strips. Currently not implemented due to engine NVG limitations.--
	]]--
	
	lights_data = 	{
		typename = "collection",
		lights = {
			[WOLALIGHT_NAVLIGHTS] = {
				typename = "Collection",
				lights = {
					{ typename = "argumentlight", argument = 190, },
					{ typename = "argumentlight", argument = 191, },
					{ typename = "argumentlight", argument = 192, },
				}
			},
			[WOLALIGHT_SPOTS] = {
				typename = "Collection",
				lights = {
					{ typename = "argumentlight", argument = 209, },
				}
			},
			[WOLALIGHT_TAXI_LIGHTS] = {
				typename = "Collection",
				lights = {
					{ typename = "argumentlight", argument = 208, },
				}
			},
			[WOLALIGHT_STROBES] = {
				typename = "Collection",
				lights = {
					{typename = "argumentlight", argument = 198, },	-- Dim light
					{typename = "argumentlight",  argument = 199 },
				}
			},
			[WOLALIGHT_FORMATION_LIGHTS] = {
				typename = "Collection",
				lights = {
					{typename = "argumentlight", argument = 200,},
					{typename = "argumentlight", argument = 201,},
					{typename = "argumentlight", argument = 202,},
					{typename = "argumentlight", argument = 203,},
					{typename = "argumentlight", argument = 204,},
					{typename = "argumentlight", argument = 205,},
				}
				
			},
			[WOLALIGHT_TIPS_LIGHTS] = {
				typename = "Collection",
				lights = {
					{typename = "argumentlight", argument = 207,}
				}
			},
			[WOLALIGHT_REFUEL_LIGHTS] = {
				typename = "Collection",
				lights = {
					{typename = "argumentlight", argument = 210,}
				}
			},
		},
	},
	
	
	------ Aircraft Additional Properties ------
	Navpoint_Panel = true,
	
	AddPropAircraft = {
		{ id = "MountNVG", 					control = 'checkbox', label = _('Equip AN/AVS-9 NVG and NVG Filters'), defValue = false},
		{ id = "needsGCAlign", 				control = 'checkbox',   label = _('Cold Aircraft needs GC Alignment'),	playerOnly = true, defValue = false, weightWhenOn = -80},
		{ id = "InitAirborneTime", 			control = 'slider',   	label = _('Time Airborne (minutes)'),			defValue = 0, min = 0.0, max = 180, dimension = 'min' },
		{ id = "InitAlertStatus", 			control = 'checkbox' ,	label = _('Cold Aircraft is in ALERT status'),	playerOnly = true, defValue = false, weightWhenOn = -80},
		{ id = "LaserCode_Label",			control = 'label',    	label = _('GBU LASER CODES'), xLbl = 150,},
        { id = "Sta2LaserCode",  			control = 'spinbox',  	label = _('Laser code for Station 2 1xxx'),		defValue = 688, min = 111, max = 888, dimension = ' ' },
        { id = "LCFTLaserCode",  			control = 'spinbox',  	label = _('Laser code for Left CFT  1xxx'), 	defValue = 688, min = 111, max = 888, dimension = ' ' },
        { id = "Sta5LaserCode",  			control = 'spinbox',  	label = _('Laser code for Station 5 1xxx'), 	defValue = 688, min = 111, max = 888, dimension = ' ' },
        { id = "RCFTLaserCode",  			control = 'spinbox',  	label = _('Laser code for Right CFT 1xxx'), 	defValue = 688, min = 111, max = 888, dimension = ' ' },
        { id = "Sta8LaserCode",  			control = 'spinbox',  	label = _('Laser code for Station 8 1xxx'), 	defValue = 688, min = 111, max = 888, dimension = ' ' },
		{ id = "MC_Label",					control = 'label',		label = _('MULTIPLAYER'), xLbl = 150,},
		{ id = "SoloFlight",				control = 'checkbox' ,	label = _('Solo Flight')			   , 		playerOnly = true, defValue = false, weightWhenOn = -80},
		{ id = "NetCrewControlPriority",	control = 'comboList',	label = _('Aircraft Control Priority'), 		playerOnly = true, 
		  values = {{id =  0, dispName = _("Pilot")},
					{id =  1, dispName = _("WSO")},
					{id = -1, dispName = _("Ask Always")},
					{id = -2, dispName = _("Equally Responsible")}},
		  defValue  = 0,
		  wCtrl     = 150
		},
		{ id = "HumanOrchestra"  , control = 'checkbox', label = _('Disable Multicrew'), defValue = false, playerOnly = true, },	
	},
	
	input_profile_entry = "F-15E",
}

add_aircraft(F15E_RAZBAM)
