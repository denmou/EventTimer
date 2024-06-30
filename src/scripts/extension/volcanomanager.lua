require 'constant/constants'

local function VolcanomanagerPostInit(self)
    self.OnEventReport = function()
        if not self:IsDormant() then
            if self:IsFireRaining() then
                GLOBAL_NOTICE_HUD:SetText(ID_VOLCANO, STRINGS.ACTIONS.LAUNCH, self.firerain_timer)
            else
                local eruptionSeg = self:GetNumSegmentsUntilEruption()
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
    GLOBAL_SETTING.extensionMap[EXTENSION_VOLCANOMANAGER] = self
    print('Add [' .. EXTENSION_VOLCANOMANAGER .. '] Extension')
end

return VolcanomanagerPostInit
