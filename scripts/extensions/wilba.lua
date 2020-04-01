local function WilbaPrefabPostInit(inst)
    if g_func_mod_config('Wilba') then
        g_func_add_asset('inventoryimages_2')
        local name = 'turf_fields'
        g_obj_control.add(name)
        inst._eventTimer = function()
            if inst.transform_task then
                local waitTime = (inst.transform_task.nexttick - GetTick()) * GetTickTime()
                g_obj_control.set(name, g_obj_constant.recovery .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
            else
                g_obj_control.hide(name)
            end
        end
        table.insert(g_obj_items, inst)
    end
end

g_func_prefab_init('wilba', WilbaPrefabPostInit)
