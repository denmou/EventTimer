Assets = {
    Asset("IMAGE", "images/resources.tex"),
    Asset("ATLAS", "images/resources.xml")
}

local Settings = GLOBAL.require 'util/settings'
GLOBAL.GLOBAL_SETTING = Settings()

GLOBAL.require 'constant/constants'

local componentExtensions = { 'banditmanager', 'volcanomanager', 'tigersharker', 'rocmanager', 'nightmareclock', 'krakener', 'hounded', 'hayfever', 'chessnavy' }
--local componentExtensions = { 'aporkalypse', 'basehassler', 'batted' }
--local prefabExtensions = { 'vampirebat'}
local prefabExtensions = { 'wilba', 'wx78', 'pugalisk_fountain', 'packim', 'cave' }
--GLOBAL.require 'extension/displayName'

for _, name in ipairs(componentExtensions) do
    AddComponentPostInit(name, GLOBAL.require('extension/' .. name))
end
for _, name in ipairs(prefabExtensions) do
    AddPrefabPostInit(name, GLOBAL.require('extension/' .. name))
end
--AddPlayerPostInit(GLOBAL.require 'extension/player')

local NoticeHud = GLOBAL.require 'screen/notice_hud'
local SettingHud = GLOBAL.require 'screen/setting_hud'

local ImageButton = GLOBAL.require "widgets/imagebutton"

GLOBAL.GLOBAL_NOTICE_HUD = NoticeHud()

local function ControlsPostConstruct(self)
    GLOBAL.GLOBAL_SETTING:Init()
    GLOBAL.GLOBAL_NOTICE_HUD:Init(self)
end

local function PauseScreenPostInit(self)
    self.settingButton = self.title:AddChild(ImageButton('images/resources.xml', "events.tex"))
    self.settingButton:SetPosition(280, 0, 0)
    self.settingButton:SetScale(.45)
    --self.settingButton:SetOnClick(function() GLOBAL.TheFrontEnd:PushScreen(SettingHud()) end)
    self.settingButton:SetOnClick(function()
        self.settingPanel:Show()
    end)
    self.settingPanel = self:AddChild(SettingHud())
end

local function SimPostInit(inst)
    inst:DoPeriodicTask(1 / 2, function()
        for _, v in ipairs(GLOBAL.GLOBAL_SETTING.currentExtensionList) do
            v:OnEventReport()
        end
        GLOBAL.GLOBAL_NOTICE_HUD:Reload()
    end)
end

AddClassPostConstruct("widgets/controls", ControlsPostConstruct)
AddClassPostConstruct("screens/pausescreen", PauseScreenPostInit)
AddSimPostInit(SimPostInit)
