require 'constant/constants'
local Utils = require 'util/utils'

local EXTENSION = EXTENSION_PACKIM
local OFFSET_Y = -550

local function PackimPrefabPostInit(inst)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], inst)
    local OnRemoveEntity = inst.OnRemoveEntity
    inst.OnRemoveEntity = function(...)
        if OnRemoveEntity then
            OnRemoveEntity(...)
        end
        for i = #GLOBAL_SETTING.entityMap[EXTENSION], 1, -1 do
            if inst.GUID == GLOBAL_SETTING.entityMap[EXTENSION][i].GUID then
                table.remove(GLOBAL_SETTING.entityMap[EXTENSION], i)
                print('Remove Packim[' .. inst.GUID .. '] Entity')
            end
        end
        GLOBAL_NOTICE_HUD:RemoveFollowNotice(inst)
    end
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            --local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(e, OFFSET_Y)
            local current = e.components.hunger.current
            local hunger = e.components.hunger
            if e.PackimState == 'NORMAL' then
                if current > 0 then
                    local waitTime = math.mod(current, 1) / (hunger.hungerrate * hunger:GetBurnRate() * hunger.period)
                    GLOBAL_NOTICE_HUD:SetText(ID_PACKIM, STRINGS.ACTIONS.FEED .. '(' .. math.ceil(current) .. "/" .. hunger.max .. ')', waitTime)
                end
                --notice:SetValue(math.ceil(current) .. "/" .. hunger.max .. ' (' .. Utils.SecondFormat(waitTime) .. ')')
            elseif e.PackimState == 'FAT' then
                local waitTime = current / (hunger.hungerrate * hunger:GetBurnRate() * hunger.period)
                if waitTime > 0 then
                    GLOBAL_NOTICE_HUD:SetText(ID_PACKIM, STRINGS.ACTIONS.MAKEBALLOON, waitTime)
                end
                --notice:SetValue(Utils.SecondFormat(waitTime))
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return PackimPrefabPostInit
