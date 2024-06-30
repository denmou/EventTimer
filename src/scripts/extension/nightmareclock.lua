require 'constant/constants'
local Utils = require 'util/utils'

local PHASE = {
    calm = 'STRINGS.ACTIONS.ADDFUEL.REPAIR',
    warn = 'STRINGS.ACTIONS.GIVE.READY',
    nightmare = 'STRINGS.ACTIONS.ACTIVATE.GENERIC',
    dawn = 'STRINGS.ACTIONS.RETRIEVE'
}

local function NightmareClockPostInit(self)
    self.OnEventReport = function()
        local waitTime = self:GetTimeLeftInEra()
        local config = GLOBAL_SETTING:GetActiveOption(ID_NIGHTMARECLOCK)
        if waitTime < config.value then
            GLOBAL_NOTICE_HUD:SetText(ID_NIGHTMARECLOCK, Utils.loadStrings(PHASE[self.phase]), waitTime)
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_NIGHTMARECLOCK] = self
    print('Add [' .. EXTENSION_NIGHTMARECLOCK .. '] Extension')
end

return NightmareClockPostInit
