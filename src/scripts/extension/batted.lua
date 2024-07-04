require 'constant/constants'

local function BattedPostInit(self)
    self.OnEventReport = function()
        local currentTick = GetTick()
        for i = #GLOBAL_SETTING.temporary[ID_VAMPIRE_BATS], 1, -1 do
            if currentTick > GLOBAL_SETTING.temporary[ID_VAMPIRE_BATS][i] then
                table.remove(GLOBAL_SETTING.temporary[ID_VAMPIRE_BATS], i)
            end
        end
        if 0 < #GLOBAL_SETTING.temporary[ID_VAMPIRE_BATS] then
            table.sort(GLOBAL_SETTING.temporary[ID_VAMPIRE_BATS])
            local waitTime = (GLOBAL_SETTING.temporary[ID_VAMPIRE_BATS][1] - currentTick ) * GetTickTime()
            local text = "[" .. #GLOBAL_SETTING.temporary[ID_VAMPIRE_BATS] .. "]" .. STRINGS.ACTIONS.SPY
            GLOBAL_NOTICE_HUD:SetText(ID_VAMPIRE_BATS, text, waitTime)
        else
            local waitTime = self.timetoattack
            local count = self:CountBats()
            local config = GLOBAL_SETTING:GetActiveOption(ID_VAMPIRE_BATS)
            if waitTime < config.value then
                local text = "[" .. count .. "]" .. STRINGS.ACTIONS.RETRIEVE
                GLOBAL_NOTICE_HUD:SetText(ID_VAMPIRE_BATS, text, waitTime)
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_BATTED] = self
    print('Add [' .. EXTENSION_BATTED .. '] Extension')
end

return BattedPostInit
