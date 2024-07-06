local Text = require "widgets/text"
local Widget = require "widgets/widget"
local Image = require "widgets/image"

local DEFAULT_FONT = {
    font = BODYTEXTFONT,
    size = 20,
    offset = 22,
}
local DEFAULT_ICON = {
    size = 20
}

local IconText = Class(Widget, function(self, size)
    Widget._ctor(self, "IconText")
    self.icon = self:AddChild(Image())
    self.position = self.icon:GetPosition()
    self.size = size

    self.text = self:AddChild(Text(DEFAULT_FONT.font, self.size or DEFAULT_FONT.size))

    self.value = nil
end)

function IconText:SetIcon(atlas, image)
    self.icon:SetTexture(atlas, image .. ".tex")
    self.icon:SetSize({ self.size or DEFAULT_ICON.size, self.size or DEFAULT_ICON.size })
    self.text:SetPosition(self.position + Vector3(10, 0, 0))
    self.icon:SetPosition(self.position - Vector3(15, 0, 0))
end

function IconText:SetValue(value)
    self.value = value
end

function IconText:RefreshText()
    local value = self.value
    if value then
        self.text:SetString(value)
        if not self:IsVisible() then
            self:Show()
        end
        self.value = nil
    elseif self:IsVisible() then
        self:Hide()
    end
    return nil ~= value
end

return IconText
