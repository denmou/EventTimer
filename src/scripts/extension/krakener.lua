require 'constant/constants'

local function KrakenerPostInit(self)
    self.OnEventReport = function()
        if self.kraken then
            GLOBAL_NOTICE_HUD:SetText(ID_KRAKEN, STRINGS.BORE_TALK_FIGHT[1], NONE_TIME)
        else
            local waitTime = self:TimeUntilCanSpawn()
            local config = GLOBAL_SETTING:GetActiveOption(ID_KRAKEN)
            if waitTime < config.value then
                if waitTime > 0 then
                    GLOBAL_NOTICE_HUD:SetText(ID_KRAKEN, STRINGS.ACTIONS.HEAL, waitTime)
                else
                    GLOBAL_NOTICE_HUD:SetText(ID_KRAKEN, STRINGS.ACTIONS.SLEEPIN, NONE_TIME)
                end
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_KRAKENER] = self
    print('Add [' .. EXTENSION_KRAKENER .. '] Extension')
end

return KrakenerPostInit
