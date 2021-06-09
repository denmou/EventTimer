local id = "worm"

local function PeriodicThreatPostInit(self)
    g_obj_control.add(id)
    self._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            local worm = self.threats["WORM"]
            if worm then
                local waitTime = worm.timer
                local text = nil
                if waitTime < config.time then
                    if worm.state == "wait" then
                        text = STRINGS.ACTIONS.CHARGE_UP .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                    elseif worm.state == "warn" then
                        text = STRINGS.ACTIONS.GIVE.LOAD .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                    elseif worm.state == "event" then
                        text = STRINGS.ACTIONS.ACTIVATE.GENERIC .. ": " .. math.floor(worm.numspawned)
                    end
                end
                if text then
                    g_obj_control.set(id, text)
                else
                    g_obj_control.hide(id)
                end
            end
        else
            g_obj_control.hide(id)
        end
    end
    table.insert(g_obj_items, self)
end

g_func_component_init("periodicthreat", PeriodicThreatPostInit)
