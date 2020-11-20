local GetDisplayName = EntityScript.GetDisplayName

local id_growthTime = "growthTime"
local id_fuelTime = "fuelTime"

EntityScript.GetDisplayName = function(self, ...)
    local name = GetDisplayName(self, ...)
    if self.components then
        local config_growthTime = g_func_mod_config:GetById(id_growthTime)
        local config_fuelTime = g_func_mod_config:GetById(id_fuelTime)
        local pickable = self.components.pickable
        local hackable = self.components.hackable
        local fueled = self.components.fueled
        local dryer = self.components.dryer
        local stewer = self.components.stewer
        local hunger = self.components.hunger
        if config_growthTime and config_growthTime.switch and (g_dlc_mode and config_growthTime.dlc[g_dlc_mode]) then
            if pickable then
                if self.components.inspectable and self.components.inspectable:GetStatus(self) == "WITHERED" then
                    name = name .. "\n" .. g_obj_constant.wither
                elseif self.components.pickable.paused then
                    name = name .. "\n" .. g_obj_constant.stop_grow
                elseif pickable.targettime then
                    local currentTime = pickable.targettime - GetTime()
                    name = name .. "\n" .. g_obj_utils.timeFormat(math.ceil(currentTime))
                end
            elseif hackable and hackable.targettime then
                local currentTime = hackable.targettime - GetTime()
                name = name .. "\n" .. g_obj_utils.timeFormat(math.ceil(currentTime))
            end
        end
        if config_fuelTime and config_fuelTime.switch and (g_dlc_mode and config_fuelTime.dlc[g_dlc_mode]) then
            if fueled then
                local currentTime = math.ceil(fueled.currentfuel)
                local maxTime = math.ceil(fueled.maxfuel)
                name = name .. "\n" .. g_obj_utils.timeFormat(currentTime) .. "/" .. g_obj_utils.timeFormat(maxTime)
            end
            if dryer and dryer:IsDrying() then
                local currentTime = dryer:GetTimeToDry()
                name = name .. "\n" .. g_obj_utils.timeFormat(math.ceil(currentTime))
            end
            if stewer and stewer:GetTimeToCook() > 0 then
                local currentTime = stewer:GetTimeToCook()
                name = name .. "\n" .. g_obj_utils.timeFormat(math.ceil(currentTime))
            end
            if hunger then 
                name = name .. "\n" .. hunger:GetCurrent()
            end
        end
    end
    return name
end
