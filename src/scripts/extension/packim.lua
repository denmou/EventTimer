require 'constant/constants'

local function PackimPrefabPostInit(inst)
    inst.OnEventReport = function()
        local current = inst.components.hunger.current
        if (inst.PackimState == "NORMAL" or inst.PackimState == "FAT") and inst:HasTag("companion") and current > 0 then
            local hunger = inst.components.hunger
            if inst.PackimState == "NORMAL" then
                local text = STRINGS.ACTIONS.FEED .. ": " .. current .. " / " .. hunger.max
                GLOBAL_NOTICE_HUD:SetText(ID_PACKIM, text, NONE_TIME)
            else
                local waitTime = current / (hunger.hungerrate * hunger:GetBurnRate() * hunger.period)
                GLOBAL_NOTICE_HUD:SetText(ID_PACKIM, STRINGS.ACTIONS.MAKEBALLOON, waitTime)
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_PACKIM] = inst
    print('Add [' .. EXTENSION_PACKIM .. '] Extension')
end

return PackimPrefabPostInit
