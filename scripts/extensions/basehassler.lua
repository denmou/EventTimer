local function BasehasslerPostInit(self)
    if g_func_mod_config('SeasonBoss') then
        self._eventTimer = function()
            if self.hasslers then
                for name, boss in pairs(self.hasslers) do
                    g_obj_control.add(name)
                    local hassler = TheSim:FindFirstEntityWithTag(boss.prefab)
                    if hassler then
                        g_obj_control.set(name, g_obj_constant.rage)
                    else
                        local state = self:GetHasslerState(name)
                        if state == self.hassler_states.DORMANT then
                            g_obj_control.hide(name)
                        else
                            local waitTime = math.ceil(boss.timer)
                            if state == self.hassler_states.WARNING then
                                g_obj_control.set(
                                    name,
                                    g_obj_constant.attack .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                                )
                            elseif state == self.hassler_states.WAITING then
                                if waitTime < g_str_warning_time then
                                    g_obj_control.set(
                                        name,
                                        '[' ..
                                            boss.chance * 100 ..
                                                '%]' ..
                                                    g_obj_constant.come ..
                                                        ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                                    )
                                else
                                    g_obj_control.hide(name)
                                end
                            end
                        end
                    end
                end
            else
                local name = self.hasslerprefab
                g_obj_control.add(name)
                local hassler = TheSim:FindFirstEntityWithTag(self.hasslerprefab)
                if hassler then
                    g_obj_control.set(name, g_obj_constant.rage)
                else
                    if not self.timetoattack then
                        g_obj_control.hide(name)
                    else
                        local waitTime = math.ceil(self.timetoattack)
                        print(waitTime)
                        if self.warning then
                            g_obj_control.set(
                                name,
                                g_obj_constant.attack .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                            )
                        elseif waitTime < g_str_warning_time then
                            g_obj_control.set(
                                name,
                                g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                            )
                        else
                            g_obj_control.hide(name)
                        end
                    end
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

g_func_component_init('basehassler', BasehasslerPostInit)
