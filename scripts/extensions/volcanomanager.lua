local function VolcanomanagerPostInit(self)
    if g_func_mod_config('Volcano') then
        local name = 'volcano'
        g_obj_control.add(name)
        self._eventTimer = function()
            if self:IsDormant() then
                g_obj_control.hide(name)
            else
                if self:IsFireRaining() then
                    g_obj_control.set(
                        name,
                        g_obj_constant.end_in .. ': ' .. g_obj_utils.timeFormat(math.ceil(self.firerain_timer))
                    )
                else
                    local eruptionSeg = self:GetNumSegmentsUntilEruption()
                    if eruptionSeg then
                        local normtime = GetClock():GetNormTime()
                        local curSeg = normtime * 16 % 1
                        local waitTime = (eruptionSeg - curSeg) * TUNING.SEG_TIME
                        if _waitTime < g_str_warning_time then
                            g_obj_control.set(
                                name,
                                g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                            )
                        else
                            g_obj_control.hide(name)
                        end
                    end
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

g_func_component_init('volcanomanager', VolcanomanagerPostInit)
