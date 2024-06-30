require "constants"
local Widget = require "widgets/widget"
local NoticeBadge = require "widget/notice_badge"

local LEFT_POSITION_OFFSET = 0
local LEFT_POSITION_X = 12.5
local RIGHT_POSITION_OFFSET = -180
local RIGHT_POSITION_X = -180
local POSITION_Y = -12.5
local SPACING_X = -180
local SPACING_Y = -25

local NoticeHud = Class(function(self)
    self.top_left_notice_panel = nil
    self.top_right_notice_panel = nil
    self.current_panel = nil
end)

function NoticeHud:Init(root)
    self.top_left_notice_panel = root:AddChild(Widget("top_left_notice_panel"))
    self.top_left_notice_panel:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.top_left_notice_panel:SetHAnchor(ANCHOR_LEFT)
    self.top_left_notice_panel:SetVAnchor(ANCHOR_TOP)
    self.top_right_notice_panel = root:AddChild(Widget("top_right_notice_panel"))
    self.top_right_notice_panel:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.top_right_notice_panel:SetHAnchor(ANCHOR_RIGHT)
    self.top_right_notice_panel:SetVAnchor(ANCHOR_TOP)
    self.noticeMap = {}
    self.spacingX = nil
    self.spacingY = SPACING_Y
    self.positionX = nil
    self.positionY = POSITION_Y
    self.positionOffset = nil
    self:Reset()
    print('Initialize Notification Hub')
end

function NoticeHud:Reset()
    self.top_left_notice_panel:KillAllChildren()
    self.top_right_notice_panel:KillAllChildren()
    self.noticeMap = {}
    print('Clear All Notification')
    local current_panel
    local positionOption = GLOBAL_SETTING:GetActiveOption(ID_POSITION)
    if POSITION_LEFT == positionOption.value then
        self.spacingX = -SPACING_X
        self.positionX = LEFT_POSITION_X
        self.positionOffset = LEFT_POSITION_OFFSET
        current_panel = self.top_left_notice_panel
    else
        self.spacingX = SPACING_X
        self.positionX = RIGHT_POSITION_X
        self.positionOffset = RIGHT_POSITION_OFFSET
        current_panel = self.top_right_notice_panel
    end
    for k, v in pairs(GLOBAL_SETTING.currentOptionMap) do
        local notice = current_panel:AddChild(NoticeBadge(v))
        notice:Hide()
        self.noticeMap[k] = notice
    end
    print('Reset Notification Hub')
end

function NoticeHud:Reload()
    local index = 0
    for _, v in pairs(self.noticeMap) do
        if v:RefreshText() then
            index = index + 1
            local scaleOption = GLOBAL_SETTING:GetActiveOption(ID_SCALE)
            local rowOption = GLOBAL_SETTING:GetActiveOption(ID_ROW)
            local columnIndex = math.floor(index / rowOption.value)
            local rowIndex = index % rowOption.value
            local positionX = self.positionX + columnIndex * self.spacingX
            positionX = positionX * scaleOption.value + self.positionOffset
            local positionY = self.positionY + rowIndex * self.spacingY
            positionY = positionY * scaleOption.value
            v:SetPosition(positionX, positionY)
        end
    end
end

function NoticeHud:SetText(id, value, time)
    self.noticeMap[id]:AddText(value, time)
end

return NoticeHud
