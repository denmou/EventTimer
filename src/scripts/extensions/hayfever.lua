local id = "hayfever"

local function HayfeverPostInit(self)
    g_obj_control.add(id)
    self._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            local waitTime = self.nextsneeze
            if waitTime < config.time and self.enabled then
                g_obj_control.set(id, STRINGS.ACTIONS.MAKEBALLOON .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
            else
                g_obj_control.hide(id)
            end
        else
            g_obj_control.hide(id)
        end
    end
    table.insert(g_obj_items, self)
end

g_func_component_init("hayfever", HayfeverPostInit)
