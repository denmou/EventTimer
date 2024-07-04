local Widget = require "widgets/widget"
local Text = require "widgets/text"
local Image = require "widgets/image"

local FONT_SIZE = 20
local ICON_SIZE = { 20, 20 }

local FollowNoticeBadge = Class(Widget, function(self)
    Widget._ctor(self, "FollowNoticeBadge")

    self:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self:SetMaxPropUpscale(1.25)
    self.value = nil
    self.icon = nil
    self.text = self:AddChild(Text(BODYTEXTFONT, FONT_SIZE))
    self.offset = Vector3(0,0,0)
    self.screen_offset = Vector3(0,0,0)

    self:StartUpdating()
end)

function FollowNoticeBadge:SetValue(value)
    self.value = value
end

function FollowNoticeBadge:SetIcon(resource, image)
    self.icon = self:AddChild(Image(resource, image .. ".tex"))
    self.icon:SetSize(ICON_SIZE)
end

function FollowNoticeBadge:RefreshText()
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

function FollowNoticeBadge:SetTarget(target)
    self.target = target
    self:OnUpdate()
end

function FollowNoticeBadge:SetOffset(offset)
    self.offset = offset
    self:OnUpdate()
end

function FollowNoticeBadge:SetScreenOffset(x,y)
    self.screen_offset.x = x
    self.screen_offset.y = y
    self:OnUpdate()
end

function FollowNoticeBadge:GetScreenOffset()
    return self.screen_offset.x, self.screen_offset.y
end

function FollowNoticeBadge:OnUpdate(dt)
    if self.target and self.target:IsValid() then
        local scale = TheFrontEnd:GetHUDScale()
        self.text:SetScale(scale)

        local world_pos = nil

        if self.target.AnimState then
            world_pos = Vector3(self.target.AnimState:GetSymbolPosition(self.symbol or "", self.offset.x, self.offset.y, self.offset.z))
        else
            world_pos = self.target:GetPosition()
        end

        if world_pos then
            local screen_pos = Vector3(TheSim:GetScreenPos(world_pos:Get())) 

            screen_pos.x = screen_pos.x + self.screen_offset.x
            screen_pos.y = screen_pos.y + self.screen_offset.y
            self:SetPosition(screen_pos)
        end
    end
end

return FollowNoticeBadge