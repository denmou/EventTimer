require 'constant/constants'

local function HoundedPostInit(self)
    self.OnEventReport = function()
        local text
        local id = ID_HOUNDS
        if GLOBAL_SETTING.currentMode == SW_MODE then
            id = ID_CROCODOG
        end
        local waitTime = self.timetoattack
        local config = GLOBAL_SETTING:GetActiveOption(id)
        if config.switch and waitTime < config.value then
            if waitTime > 0 then
                text = "[" .. self.houndstorelease .. "]" .. STRINGS.ACTIONS.HEAL
                GLOBAL_NOTICE_HUD:SetText(id, text, waitTime)
            else
                text = "[" .. self.houndstorelease .. "]" .. STRINGS.ACTIONS.ATTACK.GENERIC
                GLOBAL_NOTICE_HUD:SetText(id, text, self.timetonexthound)
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_HOUNDED] = self
    print('Add [' .. EXTENSION_HOUNDED .. '] Extension')
end

return HoundedPostInit
