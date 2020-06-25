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

local font_size = 20
local icon_size = {22,22}
local bg_size = {200,30}
local bg_offset = 82
local text_offset = 93



local Noticebadge =
    Class(
    Widget,
    function(self, name)
        Widget._ctor(self, "Noticebadge")
        self.name = name

        self.bg = self:AddChild(Image("images/ui.xml", "textbox_long.tex"))
        self.bg:SetSize(bg_size)
        self.bg:Nudge(Vector3(bg_offset,0,0))

        --self:SetHAnchor(ANCHOR_LEFT)
        --self:SetVAnchor(ANCHOR_MIDDLE)
        --self:SetMaxPropUpscale(1.25)
        --self:SetHAnchor(ANCHOR_RIGHT)
        --self:SetVAnchor(ANCHOR_BOTTOM)
        --self:SetScaleMode(SCALEMODE_PROPORTIONAL)

        self.icon_bg = self:AddChild(Image("images/ui.xml", "portrait_bg.tex"))
        self.icon_bg:SetSize(icon_size)

        for i, v in ipairs(images) do
            self.icon = self:AddChild(Image(v, name .. ".tex"))
            local w, h = self.icon:GetSize()
            if w > 0 then
                break
            end
        end

        self.icon:SetSize(icon_size)

        self.text = self:AddChild(Text(NUMBERFONT, font_size))
        self.text:SetHAlign(ANCHOR_MIDDLE)
        self.text:Nudge(Vector3(text_offset,0,0))
    end
)

function Noticebadge:GetName()
    return self.name
end

return Noticebadge
