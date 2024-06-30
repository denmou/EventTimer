require 'constant/constants'

local function HayfeverPostInit(self)
    self.OnEventReport = function()
        local waitTime = self.nextsneeze
        local config = GLOBAL_SETTING:GetActiveOption(ID_HAYFEVER)
        if self.enabled and waitTime < config.value then
            GLOBAL_NOTICE_HUD:SetText(ID_HAYFEVER, STRINGS.UI.CUSTOMIZATIONSCREEN.NAMES.HAYFEVER, waitTime)
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_HAYFEVER] = self
    print('Add [' .. EXTENSION_HAYFEVER .. '] Extension')
end

return HayfeverPostInit
