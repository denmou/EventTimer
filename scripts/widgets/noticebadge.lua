local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local easing = require "easing"
local Widget = require "widgets/widget"
local Image = require "widgets/image"

local images = {
    "images/customization_porkland.xml", 
    "images/customization_shipwrecked.xml", 
    "images/customisation.xml"
}

local Noticebadge = Class(Widget, function(self, name)
    Widget._ctor(self, "Noticebadge")
	self.name = name

    self:SetHAnchor(ANCHOR_LEFT)
    self:SetVAnchor(ANCHOR_TOP)
    
    for i, v in ipairs(images) do
        self.icon = self:AddChild(Image(v, name .. ".tex"))
        local w, h = self.icon:GetSize()
        if w > 0 then
            break
        end
    end

    self.icon:SetSize(30, 30)
	
	self.bg = self:AddChild(Image("images/ui.xml", "textbox_long.tex"))
    self.bg:SetSize(185, 31.5)
    self.bg:SetPosition(104.5, -.5)
	
    self.text = self:AddChild(Text(NUMBERFONT, 28))
    self.text:SetHAlign(ANCHOR_MIDDLE)
    self.text:SetPosition(104.5, -.5)
    self.text:SetScale(.8, .8, .8)
end)

return Noticebadge