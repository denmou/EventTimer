require 'constant/constants'

local EXTENSION = EXTENSION_APORKALYPSE

local function AporkalypsePostInit(self)
    self.endDate = 0
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        local config = GLOBAL_SETTING:GetActiveOption(ID_APORKALYPSE)
        if config.switch then
            for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
                local totalTime = GetClock():GetTotalTime()
                if e:IsActive() then
                    local normTime = GetClock():GetNormTime()
                    local seasonManager = GetSeasonManager()
                    if e.endDate == 0 then
                        local totalDay = seasonManager.aporkalypse_length * (1 - seasonManager.percent_season) - normTime
                        e.endDate = totalDay * TUNING.TOTAL_DAY_TIME + totalTime
                    end
                    local waitTime = e.endDate - totalTime
                    GLOBAL_NOTICE_HUD:SetText(ID_APORKALYPSE, STRINGS.ACTIONS.ACTIVATE.GENERIC, waitTime)
                else
                    e.endDate = 0
                    local waitTime = e.begin_date - totalTime
                    if waitTime < config.value then
                        GLOBAL_NOTICE_HUD:SetText(ID_APORKALYPSE, STRINGS.ACTIONS.GIVE.LOAD, waitTime)
                    end
                end
            end
        end
        config = GLOBAL_SETTING:GetActiveOption(ID_VAMPIRE_BATS)
        if config.switch then
            for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
                if e.bat_task and e.bat_task.nexttick then
                    local waitTime = (e.bat_task.nexttick - GetTick()) * GetTickTime()
                    local text = '[' .. e.bat_amount .. ']' .. STRINGS.ACTIONS.GIVE.LOAD
                    GLOBAL_NOTICE_HUD:SetText(ID_VAMPIRE_BATS, text, waitTime)
                end
            end
        end
        config = GLOBAL_SETTING:GetActiveOption(ID_ANCIENT_HERALD)
        if config.switch then
            for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
                if e.herald_check_task then
                    local waitTime = (e.herald_check_task.nexttick - GetTick()) * GetTickTime()
                    GLOBAL_NOTICE_HUD:SetText(ID_ANCIENT_HERALD, STRINGS.ACTIONS.GIVE.LOAD, waitTime)
                end
            end
        end
    end
}

print('Add [' .. EXTENSION .. '] Extension')

return AporkalypsePostInit
