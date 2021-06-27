local id = "Wilba"

local function WilbaPrefabPostInit(inst)
    local name = "wilba"
    g_obj_control.add(name)
    inst._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) and inst.transform_task and inst.transform_task.nexttick then
            local waitTime = (inst.transform_task.nexttick - GetTick()) * GetTickTime()
            if inst.monster_count > 0 then
                waitTime = waitTime + (inst.monster_count - 1) * inst.cooldown_schedule
            end
            if waitTime > 0 then
                if inst.ready_to_transform then
                    g_obj_control.set(name, STRINGS.ACTIONS.ACTIVATE.GENERIC .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                else
                    g_obj_control.set(name, STRINGS.ACTIONS.CHARGE_UP .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                end
            else
                g_obj_control.hide(name)
            end
        else
            g_obj_control.hide(name)
        end
    end
    table.insert(g_obj_items, inst)
end

g_func_prefab_init('wilba', WilbaPrefabPostInit)
