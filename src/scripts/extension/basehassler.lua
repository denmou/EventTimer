require 'constant/constants'

local function BasehasslerPostInit(self)
    self.OnEventReport = function()
        local config
        local id
        if self.hasslers then
            for name, boss in pairs(self.hasslers) do
                id = string.lower(name)
                config = GLOBAL_SETTING:GetActiveOption(id)
                if config and config.switch then
                    local hassler = TheSim:FindFirstEntityWithTag(boss.prefab)
                    if hassler then
                        GLOBAL_NOTICE_HUD:SetText(id, STRINGS.BORE_TALK_FIGHT[1], NONE_TIME)
                    else
                        local state = self:GetHasslerState(name)
                        if state ~= self.hassler_states.DORMANT then
                            local waitTime = boss.timer
                            if state == self.hassler_states.WARNING then
                                GLOBAL_NOTICE_HUD:SetText(id, STRINGS.ACTIONS.BLINK, waitTime)
                            elseif state == self.hassler_states.WAITING then
                                if waitTime < config.value then
                                    local text = "[" .. boss.chance * 100 .. "%]" .. STRINGS.ACTIONS.SPY
                                    GLOBAL_NOTICE_HUD:SetText(id, text, waitTime)
                                end
                            end
                        end
                    end
                end
            end
        else
            id = string.lower(self.hasslerprefab)
            config = GLOBAL_SETTING:GetActiveOption(id)
            if config and config.switch then
                local hassler = TheSim:FindFirstEntityWithTag(self.hasslerprefab)
                if hassler then
                    GLOBAL_NOTICE_HUD:SetText(id, STRINGS.BORE_TALK_FIGHT[1], NONE_TIME)
                else
                    if self.timetoattack then
                        local waitTime = self.timetoattack
                        if self.warning then
                            GLOBAL_NOTICE_HUD:SetText(id, STRINGS.ACTIONS.BLINK, waitTime)
                        elseif waitTime < config.value then
                            GLOBAL_NOTICE_HUD:SetText(id, STRINGS.ACTIONS.SPY, waitTime)
                        end
                    end
                end
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_BASEHASSLER] = self
    print('Add [' .. EXTENSION_BASEHASSLER .. '] Extension')
end

return BasehasslerPostInit
