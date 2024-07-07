require 'constant/constants'

local EXTENSION = EXTENSION_VOLCANOMANAGER

local function VolcanomanagerPostInit(self)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            if not e:IsDormant() then
                if e:IsFireRaining() then
                    GLOBAL_NOTICE_HUD:SetText(ID_VOLCANO, STRINGS.ACTIONS.LAUNCH, e.firerain_timer)
                else
                    local eruptionSeg = e:GetNumSegmentsUntilEruption()
                    if eruptionSeg then
                        local normTime = GetClock():GetNormTime()
                        local curSeg = normTime * 16 % 1
                        local waitTime = (eruptionSeg - curSeg) * TUNING.SEG_TIME
                        local config = GLOBAL_SETTING:GetActiveOption(ID_VOLCANO)
                        print('config Time: ' ..  config.value)
                        if waitTime < config.value then
                            print('waitTime: ' .. waitTime .. ' < ' .. config.value)
                            GLOBAL_NOTICE_HUD:SetText(ID_VOLCANO, STRINGS.ACTIONS.RENOVATE, waitTime)
                        end
                    end
                end
            end

        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return VolcanomanagerPostInit
