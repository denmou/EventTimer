local function TigersharkerPostInit(self)
    if g_func_mod_config('Tigershark') then
        local name = 'tigershark'
        g_obj_control.add(name)
        self._eventTimer = function()
            if self.shark then
                g_obj_control.set(name, g_obj_constant.rage)
            else
                local tag = 'reset'
                local respawnTime = self:TimeUntilRespawn()
                local appearTime = self:TimeUntilCanAppear()
                local waitTime = respawnTime
                if appearTime > respawnTime then
                    waitTime = appearTime
                    tag = 'escape'
                end
                if waitTime < g_str_warning_time then
                    if waitTime > 0 then
                        g_obj_control.set(
                            name,
                            g_obj_constant[tag] .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
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

g_func_component_init('tigersharker', TigersharkerPostInit)
