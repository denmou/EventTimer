local GetDisplayName = EntityScript.GetDisplayName
local Utils = require 'util/utils'

EntityScript.GetDisplayName = function(self, ...)
    local name = GetDisplayName(self, ...)
    if self.components then
        local growthConfig = GLOBAL_SETTING:GetActiveOption(ID_GROWTH)
        local fueledConfig = GLOBAL_SETTING:GetActiveOption(ID_FUELED)
        local dryerConfig = GLOBAL_SETTING:GetActiveOption(ID_DRYER)
        local stewerConfig = GLOBAL_SETTING:GetActiveOption(ID_STEWER)
        if growthConfig.switch then
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
        if not fueledConfig.value or fueledConfig.value == DISPLAY_INSPECT then
            local fueled = self.components.fueled
            if fueled then
                local currentTime = fueled.currentfuel
                if currentTime > 0 then
                    local maxTime = fueled.maxfuel
                    name = name .. "\n" .. Utils.SecondFormat(currentTime) .. '/' .. Utils.SecondFormat(maxTime)
                end
            end
        end
        if not dryerConfig.value or dryerConfig.value == DISPLAY_INSPECT then
            local dryer = self.components.dryer
            if dryer then
                local waitTime = dryer:GetTimeToDry()
                if waitTime > 0 then
                    name = name .. "\n" .. Utils.SecondFormat(waitTime)
                end
            end
        end
        if not stewerConfig.value or stewerConfig.value == DISPLAY_INSPECT then
            local stewer = self.components.stewer
            if stewer then
                local waitTime = stewer:GetTimeToCook()
                if waitTime > 0 then
                    name = name .. "\n" .. Utils.SecondFormat(waitTime)
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
