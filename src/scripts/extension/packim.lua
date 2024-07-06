require 'constant/constants'
local Utils = require 'util/utils'

local OFFSET_Y = -550

local function PackimPrefabPostInit(inst)
    table.insert(GLOBAL_SETTING.temporary[ID_PACKIM], inst)
    inst.OnEventReport = function()
        for _, v in ipairs(GLOBAL_SETTING.temporary[ID_PACKIM]) do
            local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(v, OFFSET_Y)
            local current = v.components.hunger.current
            local hunger = v.components.hunger
            if v.PackimState == 'NORMAL' then
                local waitTime = math.mod(current, 1) / (hunger.hungerrate * hunger:GetBurnRate() * hunger.period)
                notice:SetValue(math.ceil(current) .. "/" .. hunger.max .. ' (' .. Utils.SecondFormat(waitTime) .. ')')
            elseif v.PackimState == 'FAT' then
                local waitTime = current / (hunger.hungerrate * hunger:GetBurnRate() * hunger.period)
                notice:SetValue(Utils.SecondFormat(waitTime))
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_PACKIM] = inst
    print('Add [' .. EXTENSION_PACKIM .. '] Extension')
end

return PackimPrefabPostInit
