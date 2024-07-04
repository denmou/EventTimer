require "constants"
require "constant/constants"
local Screen = require "widgets/screen"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local ConfigurationBadge = require "widget/configuration_badge"
local ModeBadge = require "widget/mode_badge"

local COLUMNS = 3

local H_POSITION = RESOLUTION_X * .2 - 80
local V_POSITION = RESOLUTION_Y * .35 - 20
local T_POSITION = RESOLUTION_Y * .24
local R_POSITION = RESOLUTION_X * .27
local MODE_OPTIONS = {
    { mode = ROG_MODE, checked = 'DLCicon.tex', unchecked = 'DLCicontoggle.tex' },
    { mode = SW_MODE, checked = 'SWicon.tex', unchecked = 'SWicontoggle.tex' },
    { mode = HAM_MODE, checked = 'HAMicon.tex', unchecked = 'pork_icon.tex' }
}

local SettingHud = Class(Screen, function(self)
    Widget._ctor(self, "setting_hud")
    self:Hide()
    self.scaleRoot = self:AddChild(Widget("scale_root"))
    self.scaleRoot:SetVAnchor(ANCHOR_MIDDLE)
    self.scaleRoot:SetHAnchor(ANCHOR_MIDDLE)
    self.scaleRoot:SetPosition(0, 0, 0)
    self.scaleRoot:SetScaleMode(SCALEMODE_PROPORTIONAL)

    self.bg = self.scaleRoot:AddChild(Image("images/globalpanels.xml", "panel_upsell.tex"))
    self.bg:SetVRegPoint(ANCHOR_MIDDLE)
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
    self.bg:SetScale(.8, .8, .8)

    self.applybutton = self.scaleRoot:AddChild(ImageButton())
    self.applybutton:SetPosition(-H_POSITION, -V_POSITION, 0)
    self.applybutton:SetScale(.8, .8, .8)
    self.applybutton:SetText(STRINGS.UI.CONTROLSSCREEN.APPLY)
    self.applybutton.text:SetColour(0, 0, 0, 1)
    self.applybutton:SetOnClick(function()
        self:Apply()
    end)
    self.applybutton:SetFont(BUTTONFONT)
    self.applybutton:SetTextSize(40)

    self.resetbutton = self.scaleRoot:AddChild(ImageButton())
    self.resetbutton:SetPosition(0, -V_POSITION, 0)
    self.resetbutton:SetScale(.8, .8, .8)
    self.resetbutton:SetText(STRINGS.UI.CONTROLSSCREEN.RESET)
    self.resetbutton.text:SetColour(0, 0, 0, 1)
    self.resetbutton:SetOnClick(function()
        self:LoadDefaultControls()
    end)
    self.resetbutton:SetFont(BUTTONFONT)
    self.resetbutton:SetTextSize(40)

    self.cancelbutton = self.scaleRoot:AddChild(ImageButton())
    self.cancelbutton:SetPosition(H_POSITION, -V_POSITION, 0)
    self.cancelbutton:SetScale(.8, .8, .8)
    self.cancelbutton:SetText(STRINGS.UI.CONTROLSSCREEN.CANCEL)
    self.cancelbutton.text:SetColour(0, 0, 0, 1)
    self.cancelbutton:SetOnClick(function()
        self:Cancel()
    end)
    self.cancelbutton:SetFont(BUTTONFONT)
    self.cancelbutton:SetTextSize(40)

    self.panelMap = {}
    self.modeList = {}
    self.configurationGroupMap = {}
    for i, v in ipairs(MODE_OPTIONS) do
        local panel = self.scaleRoot:AddChild(Widget(v.mode .. "_panel"))
        self.panelMap[v.mode] = panel
        self.configurationGroupMap[v.mode] = {}
        if GLOBAL_SETTING.currentMode ~= v.mode then
            panel:Hide()
        end
        local badge = self.scaleRoot:AddChild(ModeBadge(v.mode, v.checked, v.unchecked, function(_mode)
            self:SwitchPanel(_mode)
        end))
        badge:SetScale(.4, .4, .4)
        badge:SetPosition(-RESOLUTION_X * .1 + RESOLUTION_X * .05 * i, RESOLUTION_Y * .33, 0)
        table.insert(self.modeList, badge)
    end
    for _, option in ipairs(GLOBAL_SETTING.optionList) do
        for _, mode in ipairs(option.mode) do
            self:AddConfigurationBadge(mode, option)
        end
    end
    self:SwitchPanel(GLOBAL_SETTING.currentMode)
    GLOBAL_SETTING:RefreshCurrentExtension()
    print('Initialize Settings Hub')
end)

function SettingHud:AddConfigurationBadge(mode, config)
    local panel = self.panelMap[mode]
    if panel then
        local configuration = panel:AddChild(ConfigurationBadge(config))
        local index = #self.configurationGroupMap[mode]
        local column = index % COLUMNS
        local row = math.floor(index / COLUMNS)
        configuration:SetPosition(-R_POSITION + RESOLUTION_X * .195 * column, T_POSITION - RESOLUTION_Y * .065 * row, 0)
        table.insert(self.configurationGroupMap[mode], configuration)
    end
end

function SettingHud:SwitchPanel(mode)
    for _, v in ipairs(self.modeList) do
        v:check(mode)
    end
    for k, v in pairs(self.panelMap) do
        if mode ~= k then
            v:Hide()
        else
            v:Show()
        end
    end
end

function SettingHud:Apply()
    GLOBAL_SETTING:Apply()
    GLOBAL_NOTICE_HUD:Reset()
    self:Hide()
    --TheFrontEnd:PopScreen()
end

function SettingHud:LoadDefaultControls()
    GLOBAL_SETTING:Reset()
end

function SettingHud:Cancel()
    GLOBAL_SETTING:Cancel()
    self:Hide()
    --TheFrontEnd:PopScreen()
end

function SettingHud:OnControl(control, down)
    if SettingHud._base.OnControl(self, control, down) then return true end

    if (control == CONTROL_PAUSE or control == CONTROL_CANCEL) and not down then
        self:Cancel()
        return true
    end
end

return SettingHud