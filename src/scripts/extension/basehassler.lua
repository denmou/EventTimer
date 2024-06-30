local goosemoose_id = "goosemoose"
local dragonfly_id = "dragonfly"
local bearger_id = "bearger"
local deerclops_id = "deerclops"

local twister_id = "twister"

local function BasehasslerPostInit(self)
    self._eventTimer = function()
        local config
        local id
        if self.hasslers then
            for name, boss in pairs(self.hasslers) do
                id = string.lower(name)
                config = g_func_mod_config:GetById(id)
                if config then
                    g_obj_control.add(id)
                    if config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
                        local hassler = TheSim:FindFirstEntityWithTag(boss.prefab)
                        if hassler then
                            g_obj_control.set(id, STRINGS.ACTIONS.ACTIVATE.GENERIC)
                        else
                            local state = self:GetHasslerState(name)
                            if state == self.hassler_states.DORMANT then
                                g_obj_control.hide(id)
                            else
                                local waitTime = math.ceil(boss.timer)
                                if state == self.hassler_states.WARNING then
                                    g_obj_control.set(id, STRINGS.ACTIONS.GIVE.LOAD .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                                elseif state == self.hassler_states.WAITING then
                                    if waitTime < config.time then
                                        g_obj_control.set(id, "[" .. boss.chance * 100 .. "%]" .. STRINGS.ACTIONS.CHARGE_UP .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                                    else
                                        g_obj_control.hide(id)
                                    end
                                end
                            end
                        end
                    else
                        g_obj_control.hide(id)
                    end
                end
            end
        else
            id = string.lower(self.hasslerprefab)
            config = g_func_mod_config:GetById(id)
            if config then
                g_obj_control.add(id)
                if config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
                    local hassler = TheSim:FindFirstEntityWithTag(self.hasslerprefab)
                    if hassler then
                        g_obj_control.set(id, STRINGS.ACTIONS.ACTIVATE.GENERIC)
                    else
                        if not self.timetoattack then
                            g_obj_control.hide(id)
                        else
                            local waitTime = math.ceil(self.timetoattack)
                            if self.warning then
                                g_obj_control.set(id,
                                    STRINGS.ACTIONS.GIVE.LOAD .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                            elseif waitTime < config.time then
                                g_obj_control.set(id,
                                    STRINGS.ACTIONS.CHARGE_UP .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                            else
                                g_obj_control.hide(id)
                            end
                        end
                    end
                else
                    g_obj_control.hide(id)
                end
            end
        end
    end
    table.insert(GLOBAL_SETTING.extensionMap, self)
end

return BasehasslerPostInit
