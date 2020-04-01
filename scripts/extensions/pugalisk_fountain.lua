local function PugaliskFountainPrefabPostInit(inst)
    if g_func_mod_config('PugaliskFountain') then
        local name = 'pugalisk_fountain'
        g_obj_control.add(name)
        inst._eventTimer = function()
            if inst.dry then
                if inst.resettask then
                    local waitTime = (inst.resettask.nexttick - GetTick()) * GetTickTime()
                    g_obj_control.set(name, g_obj_constant.reset .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                else
                    g_obj_control.set(name, g_obj_constant.dry)
                end
            else
                g_obj_control.set(name, g_obj_constant.flow)
            end
        end
        table.insert(g_obj_items, inst)
    end
end

g_func_prefab_init('pugalisk_fountain', PugaliskFountainPrefabPostInit)
