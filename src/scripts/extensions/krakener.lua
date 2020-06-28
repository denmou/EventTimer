local id = "kraken"

local function KrakenerPostInit(self)
    g_obj_control.add(id)
    self._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            if self.kraken then
                g_obj_control.set(id, g_obj_constant.rage)
            else
                local waitTime = self:TimeUntilCanSpawn()
                if waitTime < config.time then
                    if waitTime > 0 then
                        g_obj_control.set(
                            id,
                            g_obj_constant.reset .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                        )
                    else
                        g_obj_control.set(id, g_obj_constant.ready)
                    end
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

g_func_component_init("krakener", KrakenerPostInit)
