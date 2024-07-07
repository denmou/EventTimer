require 'constant/constants'

local EXTENSION = EXTENSION_BATTED

local function BattedPostInit(self)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local waitTime = e.timetoattack
            local count = e:CountBats()
            local config = GLOBAL_SETTING:GetActiveOption(ID_VAMPIRE_BATS)
            if waitTime < config.value then
                local text = "[" .. count .. "]" .. STRINGS.ACTIONS.RETRIEVE
                GLOBAL_NOTICE_HUD:SetText(ID_VAMPIRE_BATS, text, waitTime)
            end
        end
    end
}

print('Add [' .. EXTENSION .. '] Extension')

return BattedPostInit
