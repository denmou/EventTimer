require 'constant/constants'

local function TigersharkerPostInit(self)
    self.OnEventReport = function()
        if self.shark then
            GLOBAL_NOTICE_HUD:SetText(ID_TIGERSHARK, STRINGS.BORE_TALK_FIGHT[1], NONE_TIME)
        else
            local tag = STRINGS.ACTIONS.HEAL
            local respawnTime = self:TimeUntilRespawn()
            local appearTime = self:TimeUntilCanAppear()
            local waitTime = respawnTime
            if appearTime > respawnTime then
                waitTime = appearTime
                tag = STRINGS.ACTIONS.GOHOME
            end
            local config = GLOBAL_SETTING:GetActiveOption(ID_TIGERSHARK)
            if waitTime < config.value then
                if waitTime > 0 then
                    GLOBAL_NOTICE_HUD:SetText(ID_TIGERSHARK, tag, waitTime)
                else
                    GLOBAL_NOTICE_HUD:SetText(ID_TIGERSHARK, STRINGS.ACTIONS.SLEEPIN, NONE_TIME)
                end
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_TIGERSHARKER] = self
    print('Add [' .. EXTENSION_TIGERSHARKER .. '] Extension')
end

return TigersharkerPostInit
