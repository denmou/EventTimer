local function Wx78PrefabPostInit(inst)
    if g_func_mod_config('WX78') then
        local name = 'lightning'
        g_obj_control.add(name)
        inst._eventTimer = function()
            print(inst.charge_time)
            if inst.charge_time and inst.charge_time > 0 then
                local waitTime = inst.charge_time
                g_obj_control.set(name, g_obj_constant.recovery .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
            else
                g_obj_control.hide(name)
            end
        end
        table.insert(g_obj_items, inst)
    end
end

g_func_prefab_init('wx78', Wx78PrefabPostInit)
