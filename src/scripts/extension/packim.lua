require 'constant/constants'
local Utils = require 'util/utils'

local EXTENSION = EXTENSION_PACKIM
local OFFSET_Y = -550

local function PackimPrefabPostInit(inst)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], inst)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(e, OFFSET_Y)
            local current = e.components.hunger.current
            local hunger = e.components.hunger
            if e.PackimState == 'NORMAL' then
                local waitTime = math.mod(current, 1) / (hunger.hungerrate * hunger:GetBurnRate() * hunger.period)
                notice:SetValue(math.ceil(current) .. "/" .. hunger.max .. ' (' .. Utils.SecondFormat(waitTime) .. ')')
            elseif e.PackimState == 'FAT' then
                local waitTime = current / (hunger.hungerrate * hunger:GetBurnRate() * hunger.period)
                notice:SetValue(Utils.SecondFormat(waitTime))
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return PackimPrefabPostInit
