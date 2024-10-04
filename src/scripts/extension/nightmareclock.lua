require 'constant/constants'
local Utils = require 'util/utils'

local EXTENSION = EXTENSION_NIGHTMARECLOCK
local PHASE = {
    calm = 'STRINGS.ACTIONS.ADDFUEL.REPAIR',
    warn = 'STRINGS.ACTIONS.GIVE.READY',
    nightmare = 'STRINGS.ACTIONS.ACTIVATE.GENERIC',
    dawn = 'STRINGS.ACTIONS.RETRIEVE'
}

local function NightmareClockPostInit(self)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local waitTime = e:GetTimeLeftInEra()
            local config = GLOBAL_SETTING:GetActiveOption(ID_NIGHTMARECLOCK)
            if waitTime < config.value then
                GLOBAL_NOTICE_HUD:SetText(ID_NIGHTMARECLOCK, Utils.loadStrings(PHASE[e.phase]), waitTime)
            end

        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return NightmareClockPostInit
