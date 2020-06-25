local id = "locomotor"
local MAP = {
    CAFFEINE = "coffee",
    SURF = "tropicalbouillabaisse"
}

local function LocoMotorPostInit(self, inst)
    if inst:HasTag("player") and self.speed_modifiers_add_timer then
        self._eventTimer = function()
            local config = _G.g_func_mod_config:GetById(id)
            for key, name in pairs(MAP) do
                if config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
                    g_obj_control.add(name)
                    local waitTime = self.speed_modifiers_add_timer[key]
                    if waitTime then
                        g_obj_control.set(
                            name,
                            g_obj_constant.remain .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                        )
                    else
                        g_obj_control.hide(name)
                    end
                else
                    g_obj_control.hide(name)
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

g_func_component_init("locomotor", LocoMotorPostInit)
