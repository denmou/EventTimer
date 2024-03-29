local id = 'pugalisk_fountain'

local function PugaliskFountainPrefabPostInit(inst)
    g_obj_control.add(id)
    inst._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            if inst.dry then
                if inst.resettask and inst.resettask.nexttick then
                    local waitTime = (inst.resettask.nexttick - GetTick()) * GetTickTime()
                    g_obj_control.set(id, STRINGS.ACTIONS.CHARGE_UP .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                else
                    g_obj_control.set(id, STRINGS.ACTIONS.SLEEPIN)
                end
            else
                g_obj_control.set(id, STRINGS.ACTIONS.ACTIVATE.GENERIC)
            end
        else
            g_obj_control.hide(id)
        end
    end
    table.insert(g_obj_items, inst)
end

g_func_prefab_init('pugalisk_fountain', PugaliskFountainPrefabPostInit)
