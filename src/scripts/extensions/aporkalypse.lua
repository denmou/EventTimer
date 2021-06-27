local id = "aporkalypse"
local herald = "ancient_herald"

local function AporkalypsePostInit(self)
    g_obj_control.add(id)
    g_obj_control.add(herald)
    self.end_date = 0
    self._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            local totalTime = GetClock():GetTotalTime()
            if self:IsActive() then
                local normTime = GetClock():GetNormTime()
                local seasonManager = GetSeasonManager()
                if self.end_date == 0 then
                    local totalDay = seasonManager.aporkalypse_length * (1 - seasonManager.percent_season) - normTime
                    self.end_date = totalDay * TUNING.TOTAL_DAY_TIME + totalTime
                end
                local waitTime = self.end_date - totalTime
                g_obj_control.set(id, STRINGS.ACTIONS.ACTIVATE.GENERIC .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
            else
                self.end_date = 0
                g_str_aporkalypse_bat.time = 0
                g_str_aporkalypse_bat.count = 0
                local waitTime = self.begin_date - totalTime
                if waitTime < config.time then
                    g_obj_control.set(id, STRINGS.ACTIONS.CHARGE_UP .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                else
                    g_obj_control.hide(id)
                end
            end
            if self.bat_task and self.bat_task.nexttick then
                g_str_aporkalypse_bat.time = (self.bat_task.nexttick - GetTick()) * GetTickTime()
                g_str_aporkalypse_bat.count = self.bat_amount
            end
            if self.herald_check_task then
                local waitTime = (self.herald_check_task.nexttick - GetTick()) * GetTickTime()
                g_obj_control.set(herald, STRINGS.ACTIONS.RESETMINE .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
            else
                g_obj_control.hide(herald)
            end
        else
            g_obj_control.hide(id)
            g_obj_control.hide(herald)
        end
    end
    table.insert(g_obj_items, self)
end

g_func_component_init("aporkalypse", AporkalypsePostInit)
