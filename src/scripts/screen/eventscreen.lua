require("constants")
local Screen = require "widgets/screen"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Spinner = require "widgets/spinner"
local NumericSpinner = require "widgets/numericspinner"
local Text = require "widgets/text"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Configurationbadge = require "widgets/configurationbadge"
local Modebadge = require "widgets/modebadge"
local Configure = require "configure"

local Columns = 3

local h_position = RESOLUTION_X*.2 - 80
local v_position = RESOLUTION_Y*.35 - 20
local t_position = RESOLUTION_Y*.24
local r_position = RESOLUTION_X*.27
local mode_options = {
    {
        id = 'rog',
        checked = 'DLCicon.tex',
        unchecked = 'DLCicontoggle.tex'
    },
    {
        id = 'sw',
        checked = 'SWicon.tex',
        unchecked = 'SWicontoggle.tex'
    },
    {
        id = 'ham',
        checked = 'HAMicon.tex',
        unchecked = 'pork_icon.tex'
    }
}


local EventScreen = Class(Screen, function(self)
    Widget._ctor(self, "EventScreen")

	self.scaleroot = self:AddChild(Widget("scaleroot"))
    self.scaleroot:SetVAnchor(ANCHOR_MIDDLE)
    self.scaleroot:SetHAnchor(ANCHOR_MIDDLE)
    self.scaleroot:SetPosition(0,0,0)
    self.scaleroot:SetScaleMode(SCALEMODE_PROPORTIONAL)

	--throw up the background
    self.bg = self.scaleroot:AddChild(Image("images/globalpanels.xml", "panel_upsell.tex"))
    self.bg:SetVRegPoint(ANCHOR_MIDDLE)
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
    self.bg:SetScale(.8,.8,.8)
    
	self.applybutton = self.scaleroot:AddChild(ImageButton())
    self.applybutton:SetPosition(-h_position, -v_position, 0)
    self.applybutton:SetScale(.8,.8,.8)
    self.applybutton:SetText(STRINGS.UI.CONTROLSSCREEN.APPLY)
    self.applybutton.text:SetColour(0,0,0,1)
    self.applybutton:SetOnClick( function() self:Apply() end )
    self.applybutton:SetFont(BUTTONFONT)
    self.applybutton:SetTextSize(40)
    --self.applybutton:Hide()

	self.resetbutton = self.scaleroot:AddChild(ImageButton())
    self.resetbutton:SetPosition(0, -v_position, 0)
    self.resetbutton:SetScale(.8,.8,.8)
    self.resetbutton:SetText(STRINGS.UI.CONTROLSSCREEN.RESET)
    self.resetbutton.text:SetColour(0,0,0,1)
    self.resetbutton:SetOnClick( function() self:LoadDefaultControls() end )
    self.resetbutton:SetFont(BUTTONFONT)
    self.resetbutton:SetTextSize(40)
    
	self.cancelbutton = self.scaleroot:AddChild(ImageButton())
    self.cancelbutton:SetPosition(h_position, -v_position, 0)
    self.cancelbutton:SetScale(.8,.8,.8)
    self.cancelbutton:SetText(STRINGS.UI.CONTROLSSCREEN.CANCEL)
    self.cancelbutton.text:SetColour(0,0,0,1)
    self.cancelbutton:SetOnClick( function() self:Cancel() end )
    self.cancelbutton:SetFont(BUTTONFONT)
    self.cancelbutton:SetTextSize(40)

    self.panel = self.scaleroot:AddChild(Widget("panel"))
    self.mode_widgets = {}
    self.configuration_widgets = {}
    self:RefreshConfiguration()
end)

function EventScreen:RefreshConfiguration()
    for k,v in pairs(self.mode_widgets) do
		v:Kill()
	end
    for i,v in pairs(mode_options) do
        local item = self.panel:AddChild(Modebadge(v.id, v.checked, v.unchecked, function(id)
            self:ChangeShowMode(id)
        end))
        item:SetScale(.4,.4,.4)
        item:SetPosition(-RESOLUTION_X*.1 + RESOLUTION_X*.05*i, RESOLUTION_Y*.33, 0)
        table.insert(self.mode_widgets, item)
    end
    self:ChangeShowMode(g_dlc_mode)
end

function EventScreen:ChangeShowMode(id)
    for k,v in pairs(self.mode_widgets) do
		v:check(id)
	end
    for k,v in pairs(self.configuration_widgets) do
		v:Kill()
	end
    local index = 0
    for i, v in pairs(Configure:Get()) do
        if not v.dlc or v.dlc[id] then
            local rows = math.floor(index/Columns)
            local item = self.panel:AddChild(Configurationbadge(v))
            item:SetPosition(-r_position + RESOLUTION_X*.195*(index % Columns), t_position - RESOLUTION_Y*.065*rows, 0)
            table.insert(self.configuration_widgets, item)
            index = index + 1
        end
    end
end

function EventScreen:OnControl(control, down)
    if EventScreen._base.OnControl(self, control, down) then return true end

    if not down and control == CONTROL_CANCEL then self:Cancel() return true end
end

function EventScreen:Apply()
    Configure:Apply()
    self:RefreshConfiguration()
	TheFrontEnd:PopScreen()
end

function EventScreen:LoadDefaultControls()
    Configure:Reset()
    self:RefreshConfiguration()
end

function EventScreen:Cancel()
    Configure:Cancel()
    self:RefreshConfiguration()
	TheFrontEnd:PopScreen()
end

return EventScreen