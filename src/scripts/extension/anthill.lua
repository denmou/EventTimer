require 'constant/constants'

local EXTENSION = EXTENSION_ANTHILL

local function AnthillPostInit(inst)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], inst)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local tasks = e.pendingtasks
            if tasks and #tasks > 0 then
                local task = tasks[1]
                local waitTime = (task.nexttick - GetTick()) * GetTickTime()
                GLOBAL_NOTICE_HUD:SetText(ID_ANTHILL, STRINGS.ACTIONS.RENOVATE, waitTime)
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return AnthillPostInit
