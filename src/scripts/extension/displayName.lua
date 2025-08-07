local GetDisplayName = EntityScript.GetDisplayName
local Utils = require 'util/utils'

EntityScript.GetDisplayName = function(self, ...)
    local name = GetDisplayName(self, ...)
    local config = GLOBAL_SETTING:GetActiveOption(ID_GROWTH)
    if config.switch then
        if self.components then
            local pickable = self.components.pickable
            local hackable = self.components.hackable
            local crop = self.components.crop
            if pickable then
                if self.components.inspectable and self.components.inspectable:GetStatus(self) == "WITHERED" then
                    name = name .. "\n" .. STRINGS.ACTIONS.DRY
                elseif self.components.pickable.paused then
                    name = name .. "\n" .. STRINGS.ACTIONS.SLEEPIN
                elseif pickable.targettime then
                    local currentTime = pickable.targettime - GetTime()
                    name = name .. "\n" .. Utils.TimeFormat(currentTime)
                end
            elseif hackable and hackable.targettime then
                local currentTime = hackable.targettime - GetTime()
                name = name .. "\n" .. Utils.TimeFormat(currentTime)
            elseif crop and not crop.matured then
                if GetSeasonManager():GetTemperature() < TUNING.MIN_CROP_GROW_TEMP then
                    name = name .. "\n" .. STRINGS.ACTIONS.SLEEPIN
                else
                    local currentTime = (1 - crop.growthpercent) / crop.rate
                    name = name .. "\n" .. Utils.TimeFormat(currentTime)
                end
            end
        end
        --if self.respawntime and self.respawntime > 0 then
        --    local currentTime = self.respawntime - GetTime()
        --    name = name .. "\n" .. Utils.TimeFormat(currentTime)
        --end
    end
    return name
end
