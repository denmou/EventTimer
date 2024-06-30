require 'constant/constants'

local function BattedPostInit(self)
    self._batsCount = 0
    local _DoBatAttack = self.DoBatAttack
    self.DoBatAttack = function(inst, ...)
        self._batsCount = #self.batstoattack
        BAT_ATTACK = true
        _DoBatAttack(inst, ...)
    end
    self.OnEventReport = function()
        local waitTime = self.timetoattack
        local count = self:CountBats()
        local config = GLOBAL_SETTING:GetActiveOption(ID_VAMPIRE_BATS)
        if waitTime < config.value then
            if BAT_ATTACK then
                local text = "[" .. self._batsCount .. "]" .. STRINGS.ACTIONS.SPY
                GLOBAL_NOTICE_HUD:SetText(ID_VAMPIRE_BATS, text, NONE_TIME)
            else
                local text = "[" .. count .. "]" .. STRINGS.ACTIONS.HEAL
                GLOBAL_NOTICE_HUD:SetText(ID_VAMPIRE_BATS, text, waitTime)
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_BATTED] = self
    print('Add [' .. EXTENSION_BATTED .. '] Extension')
end

return BattedPostInit
