local Widget = require "widgets/widget"
local IconText = require "widget/icon_text"

local POSITION_OFFSET = 5
local DEFAULT_FONT_SIZE = 20

local FollowNoticeBadge = Class(Widget, function(self, fontSize)
    Widget._ctor(self, "FollowNoticeBadge")

    self:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self:SetMaxPropUpscale(1.25)
    self.textMap = {}
    self.position = nil
    self.fontSize = fontSize or DEFAULT_FONT_SIZE
    self.offset = Vector3(0,0,0)
    self.screen_offset = Vector3(0,0,0)

    self:StartUpdating()
end)

function FollowNoticeBadge:GetIconText(id)
    if not self.textMap[id] then
        self.textMap[id] = self:AddChild(IconText(self.fontSize))
        if not self.position then
            self.position = self.textMap[id]:GetPosition()
        end
    end
    return self.textMap[id]
end

function FollowNoticeBadge:SetFontSize(fontSize)
    self.fontSize = fontSize
end

function FollowNoticeBadge:GetDefaultId()
    if self.target then
        return self.target.GUID
    else
        return nil
    end
end

function FollowNoticeBadge:SetValue(value, atlas, image)
    local id = self:GetDefaultId()
    if id then
        self:SetValueById(id, value, atlas, image)
    end
end

function FollowNoticeBadge:SetValueById(id, value, atlas, image)
    local iconText = self:GetIconText(id)
    iconText:SetValue(value)
    if atlas and image then
        iconText:SetIcon(atlas, image)
    end
end

function FollowNoticeBadge:SetIcon(atlas, image)
    local id = self:GetDefaultId()
    if id then
        self:SetIconById(id, atlas, image)
    end
end

function FollowNoticeBadge:SetIconById(id, atlas, image)
    if atlas and image then
        local iconText = self:GetIconText(id)
        iconText:SetIcon(atlas, image)
    end
end

function FollowNoticeBadge:RefreshText()
    local textList = {}
    for _, v in pairs(self.textMap) do
        if v:RefreshText() then
            v:SetPosition(self.position - Vector3(0, (self.fontSize + POSITION_OFFSET) / 2 * #textList, 0))
            table.insert(textList, v)
        end
    end
    return #textList > 0
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
        for _, v in pairs(self.textMap) do
            v:SetScale(scale)
        end

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