require 'constant/constants'

local function CavePostInit(inst)
    inst.OnEventReport = function()
        if inst.components.periodicthreat and inst.components.periodicthreat.threats then
            local wormThreat = inst.components.periodicthreat.threats["WORM"]
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
    GLOBAL_SETTING.extensionMap[EXTENSION_CAVE] = inst
    print('Add [' .. EXTENSION_CAVE .. '] Extension')
end

return CavePostInit
