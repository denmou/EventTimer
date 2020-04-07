Assets = {
    Asset('IMAGE', 'images/customisation.tex'),
    Asset('ATLAS', 'images/customisation.xml'),
    Asset('IMAGE', 'images/customization_shipwrecked.tex'),
    Asset('ATLAS', 'images/customization_shipwrecked.xml'),
    Asset('IMAGE', 'images/customization_porkland.tex'),
    Asset('ATLAS', 'images/customization_porkland.xml'),
    Asset('IMAGE', 'images/customisation_dst.tex'),
    Asset('ATLAS', 'images/customisation_dst.xml'),
    Asset('IMAGE', 'images/ui.tex'),
    Asset('ATLAS', 'images/ui.xml'),
    Asset('IMAGE', 'images/inventoryimages.tex'),
    Asset('ATLAS', 'images/inventoryimages.xml'),
    Asset('IMAGE', 'images/resources.tex'),
    Asset('ATLAS', 'images/resources.xml')
}

local _G = GLOBAL
_G.g_func_mod_config = GetModConfigData
_G.g_func_component_init = AddComponentPostInit
_G.g_func_prefab_init = AddPrefabPostInit

_G.g_obj_control = _G.require 'control'
_G.g_obj_utils = _G.require 'utils'
_G.g_obj_panel = nil
_G.g_obj_items = {}
_G.g_obj_asset = {}
_G.g_str_refresh_time = GetModConfigData('RefreshTime')
_G.g_str_warning_time = GetModConfigData('WarningTime')
_G.g_str_aporkalypse_bat = {}

local Constant = _G.require 'constant'
local Loc = _G.require 'languages/loc'
if GetModConfigData('Idiom') then
    _G.g_obj_constant = Constant.idiom
else
    local language = Loc.GetLanguage()
    if language >= 21 and language <= 23 then
        _G.g_obj_constant = Constant.chinese
    else
        _G.g_obj_constant = Constant.english
    end
end

_G.require 'extensions/displayName'
_G.require 'extensions/aporkalypse'
_G.require 'extensions/basehassler'
_G.require 'extensions/batted'
_G.require 'extensions/chessnavy'
_G.require 'extensions/hayfever'
_G.require 'extensions/hounded'
_G.require 'extensions/krakener'
_G.require 'extensions/locomotor'
_G.require 'extensions/nightmareclock'
_G.require 'extensions/periodicthreat'
_G.require 'extensions/pugalisk_fountain'
_G.require 'extensions/rocmanager'
_G.require 'extensions/tigersharker'
_G.require 'extensions/volcanomanager'
_G.require 'extensions/wx78'

local function ControlsPostConstruct(self)
    if not _G.g_obj_panel then
        _G.g_obj_panel = self.left_root
    end
end

local function PlayerPostInit(player)
    player:DoPeriodicTask(
        _G.g_str_refresh_time,
        function()
            if _G.g_obj_panel then
                for i = 1, #_G.g_obj_items do
                    _G.g_obj_items[i]:_eventTimer()
                end
            end
        end
    )
end

AddClassPostConstruct('widgets/controls', ControlsPostConstruct)
AddSimPostInit(PlayerPostInit)
