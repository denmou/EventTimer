local function KrakenerPostInit(self)
    local WORLD = SaveGameIndex:GetCurrentMode()
    if g_func_mod_config('Kraken') and not g_func_mod_config('SWOnly') or WORLD == 'shipwrecked' then
        local name = 'kraken'
        g_obj_control.add(name)
        self._eventTimer = function()
            if self.kraken then
                g_obj_control.set(name, g_obj_constant.rage)
            else
                local waitTime = self:TimeUntilCanSpawn()
                if waitTime < g_str_warning_time then
                    if waitTime > 0 then
                        g_obj_control.set(
                            name,
                            g_obj_constant.reset .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                        )
                    else
                        g_obj_control.set(name, g_obj_constant.ready)
                    end
                else
                    g_obj_control.hide(name)
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

g_func_component_init('krakener', KrakenerPostInit)
