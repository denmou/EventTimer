require 'constant/constants'

local EXTENSION = EXTENSION_HAYFEVER

local function HayfeverPostInit(self)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
end

GLOBAL_SETTING.extensionMap[EXTENSION_HAYFEVER] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local waitTime = e.nextsneeze
            local config = GLOBAL_SETTING:GetActiveOption(ID_HAYFEVER)
            if e.enabled and waitTime < config.value then
                GLOBAL_NOTICE_HUD:SetText(ID_HAYFEVER, STRINGS.UI.CUSTOMIZATIONSCREEN.NAMES.HAYFEVER, waitTime)
            end
        end
    end
}
print('Add [' .. EXTENSION_HAYFEVER .. '] Extension')

return HayfeverPostInit
