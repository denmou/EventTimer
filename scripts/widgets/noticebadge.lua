local Text = require "widgets/text"
local Widget = require "widgets/widget"
local Image = require "widgets/image"

local images = {
    "images/customization_porkland.xml",
    "images/customization_shipwrecked.xml",
    "images/customisation.xml",
    "images/customisation_dst.xml",
    "images/inventoryimages.xml",
    "images/inventoryimages_2.xml",
    "images/resources.xml"
}

local font_size = 25
local icon_size = {28,28}
local bg_size = {200,30}
local bg_offset = 111
local text_offset = 111



local Noticebadge =
    Class(
    Widget,
    function(self, name)
        Widget._ctor(self, "Noticebadge")
        self.name = name

        --self:SetScaleMode(SCALEMODE_PROPORTIONAL)

        self.bg = self:AddChild(Image("images/ui.xml", "textbox_long.tex"))
        self.bg:SetSize(bg_size)
        self.bg:Nudge(Vector3(bg_offset,-1,0))
        self.bg:SetTint(1, 1, 1, .62)

        self.icon_bg = self:AddChild(Image("images/ui.xml", "portrait_bg.tex"))
        self.icon_bg:SetSize(icon_size)
        self.icon_bg:SetTint(1, 1, 1, .62)

        for i, v in ipairs(images) do
            self.icon = self:AddChild(Image(v, name .. ".tex"))
            local w, h = self.icon:GetSize()
            if w > 0 then
                break
            end
        end
        self.icon:SetSize(icon_size)
        self.icon:SetTint(1, 1, 1, .62)

        self.text = self:AddChild(Text(BODYTEXTFONT, font_size))
        self.text:SetHAlign(ANCHOR_MIDDLE)
        self.text:Nudge(Vector3(text_offset,-1,0))
        self.text:SetAlpha(.62)
    end
)

function Noticebadge:GetName()
    return self.name
end

return Noticebadge
