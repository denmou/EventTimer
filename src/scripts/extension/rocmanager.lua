require 'constant/constants'

local ROC_TIME = TUNING.SEG_TIME / 2

local function RocmanagerPostInit(self)
    self._arriveTime = 0
    self.OnEventReport = function()
        local totalTime = GetClock():GetTotalTime()
        if self._arriveTime < totalTime and self.nexttime > ROC_TIME then
            self._arriveTime = self.nexttime + totalTime
        end
        if self.roc then
            local rocController = self.roc.components.roccontroller
            if rocController.inst.bodyparts and #rocController.inst.bodyparts > 0 then
                GLOBAL_NOTICE_HUD:SetText(ID_ROC, STRINGS.BORE_TALK_FIND_MEAT[4], NONE_TIME)
            else
                GLOBAL_NOTICE_HUD:SetText(ID_ROC, STRINGS.BORE_TALK_FOLLOWWILSON[4], NONE_TIME)
            end
        else
            local waitTime = self._arriveTime - totalTime
            local config = GLOBAL_SETTING:GetActiveOption(ID_ROC)
            if waitTime < config.value then
                if self._arriveTime < totalTime then
                    GLOBAL_NOTICE_HUD:SetText(ID_ROC, STRINGS.BORE_TALK_LOOKATWILSON[1], NONE_TIME)
                else
                    GLOBAL_NOTICE_HUD:SetText(ID_ROC, STRINGS.ACTIONS.TRAVEL, waitTime)
                end
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_ROCMANAGER] = self
    print('Add [' .. EXTENSION_ROCMANAGER .. '] Extension')
end

return RocmanagerPostInit
