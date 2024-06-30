local id = "locomotor"
local ACTIVATOR = {
    CAFFEINE = {name = "up", desc = {'ACTIONS','DRY'}},
    SURF = {name = "coffee", desc = STRINGS.ACTIONS.ACTIVATE.GENERIC},
    AUTODRY = {name = "tropicalbouillabaisse", desc = STRINGS.ACTIONS.ACTIVATE.GENERIC}
}
local LUMINOUS = {
    wormlight = "wormlight",
    dragoonheart = "dragoonheart",
    rainbowjellylight = "rainbowjellyfish_dead"
}

local function PlayerPostInit(player)
    local eventTimer = player._eventTimer
    player._eventTimer = function()
        if eventTimer then
            eventTimer()
        end
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            local locomotor = player.components.locomotor
            if locomotor and locomotor.speed_modifiers_add_timer and locomotor.speed_modifiers_add then
                for key, item in pairs(ACTIVATOR) do
                    g_obj_control.add(item.name)
                    local waitTime = locomotor.speed_modifiers_add_timer[key]
                    local power = locomotor.speed_modifiers_add[key]
                    if waitTime and power ~= 0 then
                        if power > 0 then
                            power = "[+" .. string.format("%.1f", power) .. "]"
                        else
                            power = "[" .. string.format("%.1f", power) .. "]"
                        end
                        waitTime = g_obj_utils.timeFormat(math.ceil(waitTime))
                        g_obj_control.set(item.name, power .. item.desc .. ": " .. waitTime)
                    else
                        g_obj_control.hide(item.name)
                    end
                end
            end
            for key, name in pairs(LUMINOUS) do
                g_obj_control.add(name)
                local light = player[key]
                if light then
                    local waitTime = light.components.spell.duration - light.components.spell.lifetime
                    if waitTime >= 0 then
                        g_obj_control.set(name, STRINGS.UI.OPTIONS.BLOOM .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                    else
                        g_obj_control.hide(name)
                    end
                else
                    g_obj_control.hide(name)
                end
            end
        else
            for key, name in pairs(ACTIVATOR) do
                g_obj_control.hide(name)
            end
            for key, name in pairs(LUMINOUS) do
                g_obj_control.hide(name)
            end
        end
    end
    table.insert(GLOBAL_SETTING.extensionMap, player)
end

return PlayerPostInit
