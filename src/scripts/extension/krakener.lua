require 'constant/constants'

local EXTENSION = EXTENSION_KRAKENER

local function KrakenerPostInit(self)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            if e.kraken then
                GLOBAL_NOTICE_HUD:SetText(ID_KRAKEN, STRINGS.BORE_TALK_FIGHT[1], NONE_TIME)
            else
                local waitTime = e:TimeUntilCanSpawn()
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
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return KrakenerPostInit
