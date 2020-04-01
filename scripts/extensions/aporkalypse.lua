local function AporkalypsePostInit(self)
    if g_func_mod_config('Aporkalypse') then
        local name = 'aporkalypse'
        local herald = 'ancient_herald'
        g_obj_control.add(name)
        g_obj_control.add(herald)
        self.end_date = 0
        self._eventTimer = function()
            local totalTime = GetClock():GetTotalTime()
            if self:IsActive() then
                local normTime = GetClock():GetNormTime()
                local seasonManager = GetSeasonManager()
                if self.end_date == 0 then
                    local totalDay = seasonManager.aporkalypse_length * (1 - seasonManager.percent_season) - normTime
                    self.end_date = totalDay * TUNING.TOTAL_DAY_TIME + totalTime
                end
                local waitTime = self.end_date - totalTime
                g_obj_control.set(name, g_obj_constant.end_in .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
            else
                self.end_date = 0
                g_str_aporkalypse_bat.time = 0
                g_str_aporkalypse_bat.count = 0
                local waitTime = self.begin_date - totalTime
                if waitTime < g_str_warning_time then
                    g_obj_control.set(name, g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                else
                    g_obj_control.hide(name)
                end
            end
            if self.bat_task then
                g_str_aporkalypse_bat.time = (self.bat_task.nexttick - GetTick()) * GetTickTime()
                g_str_aporkalypse_bat.count = self.bat_amount
            end
            if self.herald_check_task then
                local waitTime = (self.herald_check_task.nexttick - GetTick()) * GetTickTime()
                g_obj_control.set(herald, g_obj_constant.refresh .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
            else
                g_obj_control.hide(herald)
            end
        end
        table.insert(g_obj_items, self)
    end
end

g_func_component_init('aporkalypse', AporkalypsePostInit)
