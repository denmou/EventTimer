local ROC_TIME = TUNING.SEG_TIME / 2

local function RocmanagerPostInit(self)
    if g_func_mod_config('Roc') then
        local name = 'roc'
        g_obj_control.add(name)
        self._arriveTime = 0
        self._eventTimer = function()
            local totalTime = GetClock():GetTotalTime()
            if self._arriveTime < totalTime and self.nexttime > ROC_TIME then
                self._arriveTime = self.nexttime + totalTime
            end
            if self.roc then
                local roccontroller = self.roc.components.roccontroller
                if roccontroller.inst.bodyparts and #roccontroller.inst.bodyparts > 0 then
                    g_obj_control.set(name, g_obj_constant.forage)
                else
                    g_obj_control.set(name, g_obj_constant.land)
                end
            else
                local waitTime = self._arriveTime - totalTime
                if waitTime < g_str_warning_time then
                    if self._arriveTime < totalTime then
                        g_obj_control.set(name, g_obj_constant.appear)
                    else
                        g_obj_control.set(
                            name,
                            g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                        )
                    end
                else
                    g_obj_control.hide(name)
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

g_func_component_init('rocmanager', RocmanagerPostInit)
