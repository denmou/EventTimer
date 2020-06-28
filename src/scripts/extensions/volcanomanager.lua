local id = "volcano"

local function VolcanomanagerPostInit(self)
    g_obj_control.add(id)
    self._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            if self:IsDormant() then
                g_obj_control.hide(id)
            else
                if self:IsFireRaining() then
                    g_obj_control.set(
                        id,
                        g_obj_constant.end_in .. ": " .. g_obj_utils.timeFormat(math.ceil(self.firerain_timer))
                    )
                else
                    local eruptionSeg = self:GetNumSegmentsUntilEruption()
                    if eruptionSeg then
                        local normtime = GetClock():GetNormTime()
                        local curSeg = normtime * 16 % 1
                        local waitTime = (eruptionSeg - curSeg) * TUNING.SEG_TIME
                        if waitTime < config.time then
                            g_obj_control.set(
                                id,
                                g_obj_constant.come .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                            )
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
    table.insert(g_obj_items, self)
end

g_func_component_init("volcanomanager", VolcanomanagerPostInit)
