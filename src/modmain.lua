Assets = {
    Asset("IMAGE", "images/resources.tex"),
    Asset("ATLAS", "images/resources.xml")
}

local _G = GLOBAL
local Widget = _G.require "widgets/widget"
local ImageButton = _G.require "widgets/imagebutton"
local EnevtScreen = _G.require "screen/eventscreen"
local Configure = _G.require "configure"
Configure:Init()

_G.g_func_component_init = AddComponentPostInit
_G.g_func_prefab_init = AddPrefabPostInit
_G.g_func_player_init = AddPlayerPostInit

_G.g_func_mod_config = _G.require "configure"
_G.g_obj_control = _G.require "control"
_G.g_obj_utils = _G.require "utils"
_G.g_top_left_notice_panel = nil
_G.g_top_right_notice_panel = nil
_G.g_dlc_mode = nil
_G.g_obj_items = {}
_G.g_obj_asset = {}
_G.g_str_aporkalypse_bat = {}

local Constant = _G.require "constant"
local Loc = _G.require "languages/loc"
local language = Loc.GetLanguage()
if language >= 21 and language <= 23 then
    _G.g_obj_constant = Constant.chinese
else
    _G.g_obj_constant = Constant.english
end

_G.require "extensions/displayName"
_G.require "extensions/player"
--HAM
_G.require "extensions/aporkalypse"
_G.require "extensions/batted"
_G.require "extensions/hayfever"
_G.require "extensions/pugalisk_fountain"
_G.require "extensions/rocmanager"
--ROG
_G.require "extensions/wx78"
_G.require "extensions/hounded"
_G.require "extensions/basehassler"
_G.require "extensions/nightmareclock"
_G.require "extensions/periodicthreat"
--SW
_G.require "extensions/chessnavy"
_G.require "extensions/krakener"
--_G.require "extensions/locomotor"
_G.require "extensions/tigersharker"
_G.require "extensions/volcanomanager"
_G.require "extensions/packim"

local function ControlsPostConstruct(self)
    if not _G.g_top_left_notice_panel or not _G.g_top_right_notice_panel then
        _G.g_top_left_notice_panel = self:AddChild(Widget("top_left_notice_panel"))
        _G.g_top_left_notice_panel:SetScaleMode(_G.SCALEMODE_PROPORTIONAL)
        _G.g_top_left_notice_panel:SetHAnchor(_G.ANCHOR_LEFT)
        _G.g_top_left_notice_panel:SetVAnchor(_G.ANCHOR_TOP)
        _G.g_top_right_notice_panel = self:AddChild(Widget("top_right_notice_panel"))
        _G.g_top_right_notice_panel:SetScaleMode(_G.SCALEMODE_PROPORTIONAL)
        _G.g_top_right_notice_panel:SetHAnchor(_G.ANCHOR_RIGHT)
        _G.g_top_right_notice_panel:SetVAnchor(_G.ANCHOR_TOP)
        --_G.g_obj_panel = self.sidepanel
    end
end

local function PlayerPostInit(player)
    if _G.SaveGameIndex:IsModePorkland() then
        _G.g_dlc_mode = "ham"
    elseif _G.SaveGameIndex:IsModeShipwrecked() then
        _G.g_dlc_mode = "sw"
    else
        _G.g_dlc_mode = "rog"
    end

    player:DoPeriodicTask(
        .5,
        function()
            if _G.g_top_right_notice_panel and _G.g_top_left_notice_panel then
                for i = 1, #_G.g_obj_items do
                    _G.g_obj_items[i]:_eventTimer()
                end
                _G.g_obj_control.ChangeNoticeBadge()
            end
        end
    )
end

local function PauseScreenPostInit(self)
    if self.survived then
        self.survived_setting = self.proot:AddChild(ImageButton('images/resources.xml', "events.tex"))
        self.survived_setting:SetPosition(280, 90, 0)
        self.survived_setting:SetScale(.45)
        self.survived_setting:SetOnClick(function()
            _G.TheFrontEnd:PushScreen(EnevtScreen())
        end)
    end
end

AddClassPostConstruct("screens/pausescreen", PauseScreenPostInit)
AddClassPostConstruct("widgets/controls", ControlsPostConstruct)
AddSimPostInit(PlayerPostInit)