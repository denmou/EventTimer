local id = "basehassler"

local function BasehasslerPostInit(self)
    self._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if self.hasslers then
            for name, boss in pairs(self.hasslers) do
                g_obj_control.add(name)
                if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
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
                                    g_obj_constant.attack .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                                )
                            elseif state == self.hassler_states.WAITING then
                                if waitTime < config.time then
                                    g_obj_control.set(
                                        name,
                                        "[" ..
                                            boss.chance * 100 ..
                                                "%]" ..
                                                    g_obj_constant.come ..
                                                        ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                                    )
                                else
                                    g_obj_control.hide(name)
                                end
                            end
                        end
                    end
                else
                    g_obj_control.hide(name)
                end
            end
        else
            local name = self.hasslerprefab
            g_obj_control.add(name)
            if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
                local hassler = TheSim:FindFirstEntityWithTag(self.hasslerprefab)
                if hassler then
                    g_obj_control.set(name, g_obj_constant.rage)
                else
                    if not self.timetoattack then
                        g_obj_control.hide(name)
                    else
                        local waitTime = math.ceil(self.timetoattack)
                        if self.warning then
                            g_obj_control.set(
                                name,
                                g_obj_constant.attack .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                            )
                        elseif waitTime < config.time then
                            g_obj_control.set(
                                name,
                                g_obj_constant.come .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                            )
                        else
                            g_obj_control.hide(name)
                        end
                    end
                end
            else
                g_obj_control.hide(name)
            end
        end
    end
    table.insert(g_obj_items, self)
end

g_func_component_init("basehassler", BasehasslerPostInit)
