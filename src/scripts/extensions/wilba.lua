local id = "Wilba"

local function WilbaPrefabPostInit(inst)
    local name = "wilba"
    g_obj_control.add(name)
    inst._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            if inst.transform_task then
                local waitTime = (inst.transform_task.nexttick - GetTick()) * GetTickTime()
                g_obj_control.set(name, g_obj_constant.recovery .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
            else
                g_obj_control.hide(name)
            end
        else
            g_obj_control.hide(name)
        end
    end
    table.insert(g_obj_items, inst)
end

--g_func_prefab_init('wilba', WilbaPrefabPostInit)
