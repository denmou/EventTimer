local UIAnim = require 'widgets/uianim'
local Text = require 'widgets/text'
local easing = require 'easing'
local Widget = require 'widgets/widget'
local Image = require 'widgets/image'

local multiplier = g_func_mod_config('Multiplier')
local fontMultiplier = g_func_mod_config('FontMultiplier')

local images = {
    'images/customization_porkland.xml',
    'images/customization_shipwrecked.xml',
    'images/customisation.xml',
    'images/customisation_dst.xml',
    'images/inventoryimages.xml',
    'images/resources.xml'
}

local Noticebadge =
    Class(
    Widget,
    function(self, name)
        Widget._ctor(self, 'Noticebadge')
        self.name = name

        self:SetHAnchor(ANCHOR_LEFT)
        self:SetVAnchor(ANCHOR_TOP)

        self.icon_bg = self:AddChild(Image('images/ui.xml', 'portrait_bg.tex'))
        self.icon_bg:SetSize(30 * multiplier, 30 * multiplier)

        for i, v in ipairs(images) do
            self.icon = self:AddChild(Image(v, name .. '.tex'))
            local w, h = self.icon:GetSize()
            if w > 0 then
                break
            end
        end

        self.icon:SetSize(30 * multiplier, 30 * multiplier)

        self.bg = self:AddChild(Image('images/ui.xml', 'textbox_long.tex'))
        self.bg:SetSize(185 * multiplier, 31.5 * multiplier)
        self.bg:SetPosition(104.5 * multiplier, -.5 * multiplier)

        self.text = self:AddChild(Text(NUMBERFONT, 28 * fontMultiplier))
        self.text:SetHAlign(ANCHOR_MIDDLE)
        self.text:SetPosition(106.5 * multiplier, -.5 * multiplier)
        self.text:SetScale(.8 * multiplier)
    end
)

return Noticebadge
