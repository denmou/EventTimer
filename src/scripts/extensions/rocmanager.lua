local id = "roc"
local ROC_TIME = TUNING.SEG_TIME / 2

local function RocmanagerPostInit(self)
    g_obj_control.add(id)
    self._arriveTime = 0
    self._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            local totalTime = GetClock():GetTotalTime()
            if self._arriveTime < totalTime and self.nexttime > ROC_TIME then
                self._arriveTime = self.nexttime + totalTime
            end
            if self.roc then
                local roccontroller = self.roc.components.roccontroller
                if roccontroller.inst.bodyparts and #roccontroller.inst.bodyparts > 0 then
                    g_obj_control.set(id, g_obj_constant.forage)
                else
                    g_obj_control.set(id, g_obj_constant.land)
                end
            else
                local waitTime = self._arriveTime - totalTime
                if waitTime < config.time then
                    if self._arriveTime < totalTime then
                        g_obj_control.set(id, g_obj_constant.appear)
                    else
                        g_obj_control.set(
                            id,
                            g_obj_constant.come .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                        )
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

g_func_component_init("rocmanager", RocmanagerPostInit)
