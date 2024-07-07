require 'constant/constants'

local EXTENSION = EXTENSION_TIGERSHARKER

local function TigersharkerPostInit(self)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            if e.shark then
                GLOBAL_NOTICE_HUD:SetText(ID_TIGERSHARK, STRINGS.BORE_TALK_FIGHT[1], NONE_TIME)
            else
                local tag = STRINGS.ACTIONS.HEAL
                local respawnTime = e:TimeUntilRespawn()
                local appearTime = e:TimeUntilCanAppear()
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
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return TigersharkerPostInit
