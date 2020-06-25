local id = "nightmareclock"

local function NightmareClockPostInit(self)
    local name = "fissure"
    g_obj_control.add(name)
    self._eventTimer = function()
        local config = _G.g_func_mod_config:GetById(id)
        if config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            local waitTime = self:GetTimeLeftInEra()
            if waitTime < config.time then
                g_obj_control.set(
                    name,
                    g_obj_constant.phase[self.phase] .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                )
            else
                g_obj_control.hide(name)
            end
        else
            g_obj_control.hide(name)
        end
    end
    table.insert(g_obj_items, self)
end

g_func_component_init("nightmareclock", NightmareClockPostInit)
