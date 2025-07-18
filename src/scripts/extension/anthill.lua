require 'constant/constants'

local EXTENSION = EXTENSION_ANTHILL

local function AnthillPostInit(inst)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], inst)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local tasks = e.pendingtasks
            if tasks then
                for task, _ in pairs(tasks) do
                    if task.period == TUNING.TOTAL_DAY_TIME / 3 then
                        local waitTime = (task.nexttick - GetTick()) * GetTickTime()
                        GLOBAL_NOTICE_HUD:SetText(ID_ANTHILL, STRINGS.ACTIONS.RENOVATE, waitTime)
                    end
                end
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return AnthillPostInit
