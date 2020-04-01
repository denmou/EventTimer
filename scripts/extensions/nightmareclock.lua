local function NightmareClockPostInit(self)
    if g_func_mod_config('NightmareClock') then
        local name = 'fissure'
        g_obj_control.add(name)
        self._eventTimer = function()
            local waitTime = self:GetTimeLeftInEra()
            if waitTime < g_str_warning_time then
                g_obj_control.set(
                    name,
                    g_obj_constant.phase[self.phase] .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                )
            else
                g_obj_control.hide(name)
            end
        end
        table.insert(g_obj_items, self)
    end
end

g_func_component_init('nightmareclock', NightmareClockPostInit)
