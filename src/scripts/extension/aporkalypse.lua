require 'constant/constants'

local function AporkalypsePostInit(self)
    self.endDate = 0
    self.OnEventReport = function()
        local config = GLOBAL_SETTING:GetActiveOption(ID_APORKALYPSE)
        if config.switch then
            local totalTime = GetClock():GetTotalTime()
            if self:IsActive() then
                local normTime = GetClock():GetNormTime()
                local seasonManager = GetSeasonManager()
                if self.endDate == 0 then
                    local totalDay = seasonManager.aporkalypse_length * (1 - seasonManager.percent_season) - normTime
                    self.endDate = totalDay * TUNING.TOTAL_DAY_TIME + totalTime
                end
                local waitTime = self.endDate - totalTime
                GLOBAL_NOTICE_HUD:SetText(ID_APORKALYPSE, STRINGS.ACTIONS.ACTIVATE.GENERIC, waitTime)
            else
                self.endDate = 0
                local waitTime = self.begin_date - totalTime
                if waitTime < config.value then
                    GLOBAL_NOTICE_HUD:SetText(ID_APORKALYPSE, STRINGS.ACTIONS.GIVE.LOAD, waitTime)
                end
            end
        end
        config = GLOBAL_SETTING:GetActiveOption(ID_VAMPIRE_BATS)
        if config.switch and self.bat_task and self.bat_task.nexttick then
            local waitTime = (self.bat_task.nexttick - GetTick()) * GetTickTime()
            local text = '[' .. self.bat_amount .. ']' .. STRINGS.ACTIONS.GIVE.LOAD
            GLOBAL_NOTICE_HUD:SetText(ID_VAMPIRE_BATS, text, waitTime)
        end
        config = GLOBAL_SETTING:GetActiveOption(ID_ANCIENT_HERALD)
        if config.switch then
            if self.herald_check_task then
                local waitTime = (self.herald_check_task.nexttick - GetTick()) * GetTickTime()
                GLOBAL_NOTICE_HUD:SetText(ID_ANCIENT_HERALD, STRINGS.ACTIONS.GIVE.LOAD, waitTime)
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_APORKALYPSE] = self
    print('Add [' .. EXTENSION_APORKALYPSE .. '] Extension')
end

return AporkalypsePostInit
