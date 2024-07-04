local Widget = require "widgets/widget"
local ImageButton = require 'widgets/imagebutton'

local ModeBadge = Class(Widget, function(self, id, checked, unchecked, fn)
    Widget._ctor(self, "ModeBadge")
    self.id = id
    self.checked = checked
    self.unchecked = unchecked
    self.button = self:AddChild(ImageButton("images/ui.xml", unchecked))
    self.button:SetOnClick(function()
        fn(self.id)
    end)
end)

function ModeBadge:check(selected)
    if self.id == selected then
        self.button:SetTextures("images/ui.xml", self.checked)
    else
        self.button:SetTextures("images/ui.xml", self.unchecked)
    end
end

return ModeBadge
