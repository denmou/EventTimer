local id = "WX78"

local function Wx78PrefabPostInit(inst)
    local name = "wx78"
    g_obj_control.add(name)
    inst._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            if inst.charge_time and inst.charge_time > 0 then
                local waitTime = inst.charge_time
                g_obj_control.set(name, STRINGS.ACTIONS.ACTIVATE.GENERIC .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
            else
                g_obj_control.hide(name)
            end
        else
            g_obj_control.hide(name)
        end
    end
    table.insert(g_obj_items, inst)
end

g_func_prefab_init("wx78", Wx78PrefabPostInit)
