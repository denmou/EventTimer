local id = "nightmareclock"

local PHASE = {
    calm = STRINGS.ACTIONS.CHARGE_UP,
    nightmare = STRINGS.ACTIONS.ACTIVATE.GENERIC,
    warn = STRINGS.ACTIONS.SLEEPIN,
    dawn = STRINGS.ACTIONS.CHECKTRAP
}

local function NightmareClockPostInit(self)
    local name = "fissure"
    g_obj_control.add(name)
    self._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            local waitTime = self:GetTimeLeftInEra()
            if waitTime < config.time then
                g_obj_control.set(name, PHASE[self.phase] .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
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
