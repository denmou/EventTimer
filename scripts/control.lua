local Noticebadge = require 'widgets/noticebadge'

local multiplier = g_func_mod_config('Multiplier')
local ABSCISSA = 20 * multiplier
local ORDINATE = -20 * multiplier
local ABSCISSA_SPACING = 210 * multiplier
local ORDINATE_SPACING = -31 * multiplier
local COLUMN_LENGTH = g_func_mod_config('Rows')
local BADGE_LIST = {}
local BADGE_INDEX = {}

local Control = {}

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
                local abscissa = ABSCISSA + ABSCISSA_SPACING * math.floor((item.index - hideCount) / COLUMN_LENGTH)
                local ordinate = ORDINATE + ORDINATE_SPACING * ((item.index - hideCount) % COLUMN_LENGTH)
                if item.abscissa ~= abscissa or item.ordinate ~= ordinate then
                    item.badge:SetPosition(abscissa, ordinate)
                    item.abscissa = abscissa
                    item.ordinate = ordinate
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
            abscissa = 0,
            ordinate = 0
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
