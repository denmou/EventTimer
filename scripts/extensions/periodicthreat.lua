local function PeriodicThreatPostInit(self)
    if g_func_mod_config('Worm') then
        local name = 'worm'
        g_obj_control.add(name)
        self._eventTimer = function()
            local worm = self.threats['WORM']
            if worm then
                local waitTime = worm.timer
                local text = nil
                if waitTime < g_str_warning_time then
                    if worm.state == 'wait' then
                        text = g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                    elseif worm.state == 'warn' then
                        text = g_obj_constant.attack .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                    elseif worm.state == 'event' then
                        text = g_obj_constant.generate .. ': ' .. math.floor(worm.numspawned)
                    end
                end
                if text then
                    g_obj_control.set(name, text)
                else
                    g_obj_control.hide(name)
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

g_func_component_init('periodicthreat', PeriodicThreatPostInit)
