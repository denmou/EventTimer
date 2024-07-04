local Text = require "widgets/text"
local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Utils = require 'util/utils'

local font_size = 20
local icon_size = { 23, 23 }
local bg_size = { 160, 25 }
local bg_offset = 89
local text_offset = 89

local NoticeBadge = Class(Widget, function(self, option)
    Widget._ctor(self, "NoticeBadge")
    self.option = option
    self.textMap = {}

    self.bg = self:AddChild(Image("images/ui.xml", "textbox_long.tex"))
    self.bg:SetSize(bg_size)
    self.bg:Nudge(Vector3(bg_offset, -1, 0))
    self.bg:SetTint(1, 1, 1, .62)

    self.icon_bg = self:AddChild(Image("images/ui.xml", "portrait_bg.tex"))
    self.icon_bg:SetSize(icon_size)

    self.icon = self:AddChild(Image(option.resource, option.icon .. ".tex"))
    self.icon:SetSize(icon_size)

    self.text = self:AddChild(Text(BODYTEXTFONT, font_size))
    self.text:SetHAlign(ANCHOR_MIDDLE)
    self.text:Nudge(Vector3(text_offset, -1, 0))
    self.text:SetAlpha(.62)
    print('Add [' .. option.id .. '] Notification')
end)

function NoticeBadge:AddText(text, time)
    self.textMap[text] = time
end

function NoticeBadge:RefreshText()
    local text
    for k, v in pairs(self.textMap) do
        if not text then
            text = k
        elseif v ~= NONE_TIME and self.textMap[text] > v then
            text = k
        end
    end
    if text then
        local time = self.textMap[text]
        if NONE_TIME ~= time then
            text = text .. ': ' .. Utils.TimeFormat(time)
        end
        self.text:SetString(text)
        if not self:IsVisible() then
            self:Show()
        end
    elseif self:IsVisible() then
        self:Hide()
    end
    self.textMap = {}
    return nil ~= text
end

return NoticeBadge
