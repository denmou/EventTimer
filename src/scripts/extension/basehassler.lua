require 'constant/constants'

local EXTENSION = EXTENSION_BASEHASSLER

local function BasehasslerPostInit(self)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local config
            local id
            if e.hasslers then
                for name, boss in pairs(e.hasslers) do
                    id = string.lower(name)
                    config = GLOBAL_SETTING:GetActiveOption(id)
                    if config and config.switch then
                        local hassler = TheSim:FindFirstEntityWithTag(boss.prefab)
                        if hassler then
                            GLOBAL_NOTICE_HUD:SetText(id, STRINGS.BORE_TALK_FIGHT[1], NONE_TIME)
                        else
                            local state = e:GetHasslerState(name)
                            if state ~= e.hassler_states.DORMANT then
                                local waitTime = boss.timer
                                if state == e.hassler_states.WARNING then
                                    GLOBAL_NOTICE_HUD:SetText(id, STRINGS.ACTIONS.BLINK, waitTime)
                                elseif state == e.hassler_states.WAITING then
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
                id = string.lower(e.hasslerprefab)
                config = GLOBAL_SETTING:GetActiveOption(id)
                if config and config.switch then
                    local hassler = TheSim:FindFirstEntityWithTag(e.hasslerprefab)
                    if hassler then
                        GLOBAL_NOTICE_HUD:SetText(id, STRINGS.BORE_TALK_FIGHT[1], NONE_TIME)
                    else
                        if e.timetoattack then
                            local waitTime = e.timetoattack
                            if e.warning then
                                GLOBAL_NOTICE_HUD:SetText(id, STRINGS.ACTIONS.BLINK, waitTime)
                            elseif waitTime < config.value then
                                GLOBAL_NOTICE_HUD:SetText(id, STRINGS.ACTIONS.SPY, waitTime)
                            end
                        end
                    end
                end
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return BasehasslerPostInit
