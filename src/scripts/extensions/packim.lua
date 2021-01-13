local id = "packim"

local function PackimPrefabPostInit(inst)
    local fat = "packim_fat"
    local normal = "packim"
    g_obj_control.add(normal)
    g_obj_control.add(fat)
    inst._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        local current = inst.components.hunger.current
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) and (inst.PackimState == "NORMAL" or inst.PackimState == "FAT") and current > 0 then
            local hunger = inst.components.hunger
            if inst.PackimState == "NORMAL" then
                g_obj_control.set(normal, g_obj_constant.hunger .. ": " .. current .. " / " .. hunger.max)
                g_obj_control.hide(fat)
            else
                g_obj_control.set(fat, g_obj_constant.recovery .. ": " .. g_obj_utils.timeFormat(math.ceil(current / (hunger.hungerrate * hunger:GetBurnRate() * hunger.period))))
                g_obj_control.hide(normal)
            end
        else
            g_obj_control.hide(normal)
            g_obj_control.hide(fat)
        end
    end
    table.insert(g_obj_items, inst)
end

g_func_prefab_init("packim", PackimPrefabPostInit)
