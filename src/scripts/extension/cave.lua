require 'constant/constants'

local EXTENSION = EXTENSION_CAVE

local function CavePostInit(inst)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], inst)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            if e.components.periodicthreat and e.components.periodicthreat.threats then
                local wormThreat = e.components.periodicthreat.threats["WORM"]
                if wormThreat then
                    local waitTime = wormThreat.timer
                    local config = GLOBAL_SETTING:GetActiveOption(ID_WORM)
                    if waitTime < config.value then
                        if wormThreat.state == "wait" then
                            GLOBAL_NOTICE_HUD:SetText(ID_WORM, STRINGS.ACTIONS.HEAL, waitTime)
                        elseif wormThreat.state == "warn" then
                            local text = '[' .. wormThreat.numtospawnfn() .. ']' .. STRINGS.ACTIONS.ATTACK.GENERIC
                            GLOBAL_NOTICE_HUD:SetText(ID_WORM, text, waitTime)
                        elseif wormThreat.state == "event" then
                            GLOBAL_NOTICE_HUD:SetText(ID_WORM, STRINGS.ACTIONS.RETRIEVE, waitTime)
                        end
                    end
                end
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return CavePostInit
