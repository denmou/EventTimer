local Noticebadge = require "widgets/noticebadge"

local id = 'setting'
local Control = {}

local badge_index = {}
local left_badge_list = {}
local right_badge_list = {}

local left_position_offset = 0
local left_position_x = 12.5
local right_position_offset = -180
local right_position_x = -180
local position_y = -12.5
local spacing_x = -180
local spacing_y = -25

local function ChangeNoticeBadge()
    if g_top_left_notice_panel and g_top_right_notice_panel then
        local config = g_func_mod_config:GetById(id)
        local row_size = config.row
        local local_position_y = position_y
        local local_position_x = right_position_x
        local local_spacing_x = spacing_x
        local local_spacing_y = spacing_y
        local badge_list = right_badge_list
        local hide_list = left_badge_list
        if config.position.left then
            local_spacing_x = -local_spacing_x
            local_position_x = left_position_x
            badge_list = left_badge_list
            hide_list = right_badge_list
        end
        local_position_x = local_position_x * config.scale
        local_position_y = local_position_y * config.scale
        local_spacing_x = local_spacing_x * config.scale
        local_spacing_y = local_spacing_y * config.scale
        if config.position.left then
            local_position_x = local_position_x + left_position_offset
        else
            local_position_x = local_position_x + right_position_offset
        end
        local hideCount = 0
        for i = 1, #badge_index do
            local name = badge_index[i]
            if hide_list[name] and hide_list[name].badge then
                hide_list[name].badge:Hide()
            end
            local item = badge_list[name]
            if not item.value then
                hideCount = hideCount + 1
                if item.badge then
                    item.badge:Hide()
                end
            else
                if not item.badge then
                    if config.position.left then
                        item.badge = g_top_left_notice_panel:AddChild(Noticebadge(name))
                    else
                        item.badge = g_top_right_notice_panel:AddChild(Noticebadge(name))
                    end
                end
                item.badge.text:SetString(item.value)
                item.badge:SetScale(config.scale)
                item.badge:Show()
                local column_index = math.floor((i - hideCount - 1) / (row_size))
                local item_x = local_position_x + column_index * local_spacing_x
                local item_y = local_position_y + (i - hideCount - 1) % row_size * local_spacing_y
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
    if not left_badge_list[name] then
        left_badge_list[name] = {
            index = #badge_index,
            badge = nil,
            value = nil,
            x = 0,
            y = 0
        }
        right_badge_list[name] = {
            index = #badge_index,
            badge = nil,
            value = nil,
            x = 0,
            y = 0
        }
        table.insert(badge_index, name)
    end
end

function Control.hide(name)
    if left_badge_list[name] then
        left_badge_list[name].value = nil
        right_badge_list[name].value = nil
        ChangeNoticeBadge()
    end
end

function Control.set(name, value)
    if left_badge_list[name] then
        left_badge_list[name].value = value
        right_badge_list[name].value = value
        ChangeNoticeBadge()
    end
end

return Control
