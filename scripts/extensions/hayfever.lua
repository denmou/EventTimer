local function HayfeverPostInit(self)
    if g_func_mod_config('HayfeverTime') then
        local name = 'hayfever'
        g_obj_control.add(name)
        self._eventTimer = function()
            local waitTime = self.nextsneeze
            if waitTime < g_str_warning_time and self.enabled then
                g_obj_control.set(name, g_obj_constant.sneeze .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
            else
                g_obj_control.hide(name)
            end
        end
        table.insert(g_obj_items, self)
    end
end

g_func_component_init('hayfever', HayfeverPostInit)
