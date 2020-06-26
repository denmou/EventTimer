local Noticebadge = require "widgets/noticebadge"

local BADGE_LIST = {}
local BADGE_INDEX = {}
local Control = {}

local position_x = -350
local position_y = 40
local spacing_x = -225
local spacing_y = -30
local column_size = 6

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
                local column_index = math.floor((i - hideCount) / (column_size + 1))
                local item_x = position_x + column_index * spacing_x
                local item_y = position_y + (i - hideCount - 1) % column_size * spacing_y
                if item.y ~= item_y or item.x ~= item_x then
                    item.badge:SetPosition(item_x, item_y)
                    item.x = item_x
                    item.y = item_y
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
            x = 0,
            y = 0
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
