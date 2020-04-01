local function HoundedPostInit(self)
    if g_func_mod_config('Hound') then
        local name = 'hounds'
        g_obj_control.add(name)
        self._eventTimer = function()
            local waitTime = self.timetoattack
            if waitTime < g_str_warning_time then
                if waitTime > 0 then
                    g_obj_control.set(
                        name,
                        '[' ..
                            self.houndstorelease ..
                                ']' .. g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                    )
                else
                    g_obj_control.set(
                        name,
                        '[' ..
                            self.houndstorelease ..
                                ']' ..
                                    g_obj_constant.attack ..
                                        ': ' .. g_obj_utils.timeFormat(math.ceil(self.timetonexthound))
                    )
                end
            else
                g_obj_control.hide(name)
            end
        end
        table.insert(g_obj_items, self)
    end
end

g_func_component_init('hounded', HoundedPostInit)
