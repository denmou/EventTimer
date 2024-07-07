require 'constant/constants'

local EXTENSION = EXTENSION_HOUNDED

local function HoundedPostInit(self)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local text
            local id = ID_HOUNDS
            if GLOBAL_SETTING.currentMode == SW_MODE then
                id = ID_CROCODOG
            end
            local waitTime = e.timetoattack
            local config = GLOBAL_SETTING:GetActiveOption(id)
            if config.switch and waitTime < config.value then
                if waitTime > 0 then
                    text = "[" .. e.houndstorelease .. "]" .. STRINGS.ACTIONS.HEAL
                    GLOBAL_NOTICE_HUD:SetText(id, text, waitTime)
                else
                    text = "[" .. e.houndstorelease .. "]" .. STRINGS.ACTIONS.ATTACK.GENERIC
                    GLOBAL_NOTICE_HUD:SetText(id, text, e.timetonexthound)
                end
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return HoundedPostInit
