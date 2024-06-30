local GetDisplayName = EntityScript.GetDisplayName

local id_growth = "growth"
local id_fuel = "fuel"
local id_cookpot = "cookpot"
local id_meatrack = "meatrack"

EntityScript.GetDisplayName = function(self, ...)
    local name = GetDisplayName(self, ...)
    if self.components then
        local config_growth = g_func_mod_config:GetById(id_growth)
        local config_fuel = g_func_mod_config:GetById(id_fuel)
        local config_cookpot = g_func_mod_config:GetById(id_cookpot)
        local config_meatrack = g_func_mod_config:GetById(id_meatrack)
        local pickable = self.components.pickable
        local hackable = self.components.hackable
        local fueled = self.components.fueled
        local dryer = self.components.dryer
        local stewer = self.components.stewer
        local crop = self.components.crop
        if config_growth and config_growth.switch and (g_dlc_mode and config_growth.dlc[g_dlc_mode]) then
            if pickable then
                if self.components.inspectable and self.components.inspectable:GetStatus(self) == "WITHERED" then
                    name = name .. "\n" .. STRINGS.ACTIONS.DRY
                elseif self.components.pickable.paused then
                    name = name .. "\n" .. STRINGS.ACTIONS.SLEEPIN
                elseif pickable.targettime then
                    local currentTime = pickable.targettime - GetTime()
                    name = name .. "\n" .. g_obj_utils.timeFormat(math.ceil(currentTime))
                end
            elseif hackable and hackable.targettime then
                local currentTime = hackable.targettime - GetTime()
                name = name .. "\n" .. g_obj_utils.timeFormat(math.ceil(currentTime))
            elseif crop and not crop.matured then
                if GetSeasonManager():GetTemperature() < TUNING.MIN_CROP_GROW_TEMP then
                    name = name .. "\n" .. STRINGS.ACTIONS.SLEEPIN
                else
                    local currentTime = (1 - crop.growthpercent)/crop.rate
                    name = name .. "\n" .. g_obj_utils.timeFormat(math.ceil(currentTime))
                end
            end
        end
        if config_fuel and config_fuel.switch and (g_dlc_mode and config_fuel.dlc[g_dlc_mode]) then
            if fueled then
                local currentTime = math.ceil(fueled.currentfuel)
                local maxTime = math.ceil(fueled.maxfuel)
                name = name .. "\n" .. g_obj_utils.timeFormat(currentTime) .. "/" .. g_obj_utils.timeFormat(maxTime)
            end
        end
        if config_cookpot and config_cookpot.switch and (g_dlc_mode and config_cookpot.dlc[g_dlc_mode]) then
            if dryer and dryer:IsDrying() then
                local currentTime = dryer:GetTimeToDry()
                name = name .. "\n" .. g_obj_utils.timeFormat(math.ceil(currentTime))
            end
        end
        if config_meatrack and config_meatrack.switch and (g_dlc_mode and config_meatrack.dlc[g_dlc_mode]) then
            if stewer and stewer:GetTimeToCook() > 0 then
                local currentTime = stewer:GetTimeToCook()
                name = name .. "\n" .. g_obj_utils.timeFormat(math.ceil(currentTime))
            end
        end
    end
    if self.respawntime and self.respawntime > 0 then
        local currentTime = self.respawntime - GetTime()
        name = name .. "\n" .. g_obj_utils.timeFormat(math.ceil(currentTime))
    end
    return name
end
