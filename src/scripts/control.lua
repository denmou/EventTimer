local Noticebadge = require "widgets/noticebadge"

local id = 'setting'

local BADGE_LIST = {}
local BADGE_INDEX = {}
local Control = {}

local left_position_x = -1562
local right_position_x = -350
local position_y = 40
local spacing_x = -225
local spacing_y = -30

local function ChangeNoticeBadge()
    if g_obj_panel then
        local config = g_func_mod_config:GetById(id)
        local row = config.row
        local local_position_x = right_position_x
        local local_spacing_x = spacing_x
        if config.position.left then
            local_spacing_x = -local_spacing_x
            local_position_x = left_position_x
        end
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
                local column_index = math.floor((i - hideCount) / (row + 1))
                local item_x = local_position_x + column_index * local_spacing_x
                local item_y = position_y + (i - hideCount - 1) % row * spacing_y
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
