local id = "hounds"

local function HoundedPostInit(self)
    self._eventTimer = function()
        local name = "hounds"
        if g_dlc_mode == "sw" then
            name = "crocodog"
        end
        g_obj_control.add(name)
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            local waitTime = self.timetoattack
            if waitTime < config.time then
                if waitTime > 0 then
                    g_obj_control.set(
                        name,
                        "[" ..
                            self.houndstorelease ..
                                "]" .. g_obj_constant.come .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                    )
                else
                    g_obj_control.set(
                        name,
                        "[" ..
                            self.houndstorelease ..
                                "]" ..
                                    g_obj_constant.attack ..
                                        ": " .. g_obj_utils.timeFormat(math.ceil(self.timetonexthound))
                    )
                end
            else
                g_obj_control.hide(name)
            end
        else
            g_obj_control.hide(name)
        end
    end
    table.insert(g_obj_items, self)
end

g_func_component_init("hounded", HoundedPostInit)
