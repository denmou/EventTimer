local Text = require 'widgets/text'
local Widget = require 'widgets/widget'
local Image = require 'widgets/image'
local ImageButton = require 'widgets/imagebutton'
local Spinner = require 'widgets/spinner'

local ICON_FIX = {
    size = { 43.2, 43.2 },
    offsetX = 36
}
local TITLE_FIX = {
    type = BODYTEXTFONT,
    size = 18,
    offsetX = 132,
    offsetY = 10.8
}
local OPTION_FIX = {
    width = 450,
    height = 64,
    font = BODYTEXTFONT,
    fontSize = 64,
    offsetX = 132,
    offsetY = -10.8,
    scale = .3
}
local MASK_FIX = {
    size = { 204.8, 43.2 },
    offsetX = 116.8,
    alpha = .75
}

local ConfigurationBadge = Class(Widget, function(self, option)
    Widget._ctor(self, 'ConfigurationBadge')
    self.option = option
    self:AddSwitch()
    self:AddIcon()
    self:AddTitle()
    self:AddOptions()
    self:AddMask()
end)

function ConfigurationBadge:AddSwitch()
    if nil ~= self.option.switch then
        self.switch = self:AddChild(ImageButton('images/ui.xml',
                (self.option.switch and 'button_checkbox2.tex') or 'button_checkbox1.tex'))
        self.switch:SetScale(.3)
        self.switch:SetOnClick(function()
            self:OnSwitch()
        end)
    end
end

function ConfigurationBadge:AddIcon()
    self.icon_bg = self:AddChild(Image('images/ui.xml', 'portrait_bg.tex'))
    self.icon_bg:SetSize(ICON_FIX.size, ICON_FIX.size)
    self.icon_bg:Nudge(Vector3(ICON_FIX.offsetX, 0, 0))

    self.icon = self:AddChild(Image(self.option.resource, self.option.icon .. '.tex'))
    self.icon:SetSize(ICON_FIX.size, ICON_FIX.size)
    self.icon:Nudge(Vector3(ICON_FIX.offsetX, 0, 0))
end

function ConfigurationBadge:AddTitle()
    self.title = self:AddChild(Text(TITLE_FIX.type, TITLE_FIX.size))
    self.title:Nudge(Vector3(TITLE_FIX.offsetX, (self.option.options and TITLE_FIX.offsetY) or 0, 0))
    self.title:SetString(self.option.name)
end

function ConfigurationBadge:AddOptions()
    if self.option.options then
        self.options = self:AddChild(Spinner(self.option.options, OPTION_FIX.width, OPTION_FIX.height,
                { font = OPTION_FIX.font, size = OPTION_FIX.fontSize }))
        self.options:Nudge(Vector3(OPTION_FIX.offsetX, OPTION_FIX.offsetY, 0))
        self.options:SetScale(OPTION_FIX.scale)
        for i, v in ipairs(self.option.options) do
            if self.option.value == v.data then
                self.options:SetSelectedIndex(i)
                break
            end
        end
        self.options:SetOnChangedFn(function(value)
            self.option.value = value
        end)
    end
end

function ConfigurationBadge:AddMask()
    self.mask = self:AddChild(Image('images/global.xml', 'square.tex'))
    self.mask:SetSize(MASK_FIX.size)
    self.mask:Nudge(Vector3(MASK_FIX.offsetX, 0, 0))
    self.mask:SetTint(0, 0, 0, MASK_FIX.alpha)
    if nil == self.option.switch or self.option.switch then
        self.mask:Hide()
    else
        self.mask:Show()
    end
end

function ConfigurationBadge:OnSwitch()
    self:SetSwitch(not self.option.switch)
end

function ConfigurationBadge:SetSwitch(switch)
    self.option.switch = switch
    self.switch:SetTextures('images/ui.xml', (self.option.switch and 'button_checkbox2.tex') or 'button_checkbox1.tex')
    if self.mask then
        if self.option.switch then
            self.mask:Hide()
        else
            self.mask:Show()
        end
    end
end

function ConfigurationBadge:SetOption(value)
    self.option.value = value
    for i, v in ipairs(self.option.options) do
        if value == v.data then
            self.options:SetSelectedIndex(i)
            break
        end
    end
end

return ConfigurationBadge
