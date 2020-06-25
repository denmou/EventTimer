local Noticebadge = require "widgets/noticebadge"

local BADGE_LIST = {}
local BADGE_INDEX = {}
local Control = {}

local position_x = -120
local position_y = 110
local spacing = 30

local function ChangeNoticeBadge()
    if g_obj_panel then
        local hideCount = 0
        for i = 1, #BADGE_INDEX do
            local name = BADGE_INDEX[i]
            local item = BADGE_LIST[name]
            if not item.value then
                hideCount = hideCount + 1
                if item.badge then
                    item.badge:Hide()
                end
            else
                if not item.badge then
                    item.badge = g_obj_panel:AddChild(Noticebadge(name))
                end
                item.badge.text:SetString(item.value)
                item.badge:Show()
                local value = position_y+(item.index-hideCount-1)*spacing
                if item.y ~= value then
                    item.badge:SetPosition(position_x, value)
                    item.y = value
                end
            end
        end
    end
end

function Control.add(name)
    if not BADGE_LIST[name] then
        BADGE_LIST[name] = {
            index = #BADGE_INDEX,
            badge = nil,
            value = nil,
            y = 0
            --abscissa = 0,
            --ordinate = 0
        }
        table.insert(BADGE_INDEX, name)
    end
end

function Control.hide(name)
    if BADGE_LIST[name] then
        BADGE_LIST[name].value = nil
        ChangeNoticeBadge()
    end
end

function Control.set(name, value)
    if BADGE_LIST[name] then
        BADGE_LIST[name].value = value
        ChangeNoticeBadge()
    end
end

return Control
