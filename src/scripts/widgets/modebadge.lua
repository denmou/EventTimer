local Text = require "widgets/text"
local Widget = require "widgets/widget"
local Image = require "widgets/image"
local ImageButton = require 'widgets/imagebutton'

local font_size = 20
local icon_size = {40,40}
local bg_size = {160,25}
local bg_offset = 89
local text_offset = 89

local Modebadge =
    Class(
    Widget,
    function(self, id, checked, unchecked, fn)
        Widget._ctor(self, "Modebadge")
        self.id = id
        self.checked = checked
        self.unchecked = unchecked
        self.button = self:AddChild(ImageButton("images/ui.xml", unchecked))
        self.button:SetOnClick(
            function()
                fn(self.id)
            end
        )
    end
)

function Modebadge:GetId()
    return self.id
end

function Modebadge:check(selected)
    if self.id == selected then
        self.button:SetTextures("images/ui.xml", self.checked)
    else
        self.button:SetTextures("images/ui.xml", self.unchecked)
    end
end

return Modebadge
