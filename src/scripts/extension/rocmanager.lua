require 'constant/constants'

local EXTENSION = EXTENSION_ROCMANAGER
local ROC_TIME = TUNING.SEG_TIME / 2

local function RocmanagerPostInit(self)
    self._arriveTime = 0
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local totalTime = GetClock():GetTotalTime()
            if e._arriveTime < totalTime and e.nexttime > ROC_TIME then
                e._arriveTime = e.nexttime + totalTime
            end
            if e.roc then
                local rocController = e.roc.components.roccontroller
                if rocController.inst.bodyparts and #rocController.inst.bodyparts > 0 then
                    GLOBAL_NOTICE_HUD:SetText(ID_ROC, STRINGS.BORE_TALK_FIND_MEAT[4], NONE_TIME)
                else
                    GLOBAL_NOTICE_HUD:SetText(ID_ROC, STRINGS.BORE_TALK_FIND_MEAT[1], NONE_TIME)
                end
            else
                local waitTime = e._arriveTime - totalTime
                local config = GLOBAL_SETTING:GetActiveOption(ID_ROC)
                if waitTime < config.value then
                    if e._arriveTime < totalTime then
                        GLOBAL_NOTICE_HUD:SetText(ID_ROC, STRINGS.BORE_TALK_LOOKATWILSON[1], NONE_TIME)
                    else
                        GLOBAL_NOTICE_HUD:SetText(ID_ROC, STRINGS.ACTIONS.TRAVEL, waitTime)
                    end
                end
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return RocmanagerPostInit
