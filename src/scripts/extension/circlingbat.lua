require 'constant/constants'
local Utils = require 'util/utils'

local EXTENSION = EXTENSION_CIRCLINGBAT
local OFFSET_Y = 100

local function CirclingbatPrefabPostInit(inst)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], inst)
    local OnRemoveEntity = inst.OnRemoveEntity
    inst.OnRemoveEntity = function(...)
        if OnRemoveEntity then
            OnRemoveEntity(...)
        end
        for i = #GLOBAL_SETTING.entityMap[EXTENSION], 1, -1 do
            if inst.GUID == GLOBAL_SETTING.entityMap[EXTENSION][i].GUID then
                table.remove(GLOBAL_SETTING.entityMap[EXTENSION], i)
                print('Remove CirclingBat[' .. inst.GUID .. '] Entity')
            end
        end
        GLOBAL_NOTICE_HUD:RemoveFollowNotice(inst)
    end
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local waitTime = (e.task.nexttick - GetTick()) * GetTickTime()
            local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(e, OFFSET_Y)
            notice:SetValue(Utils.SecondFormat(waitTime))
        end
    end
}

print('Add [' .. EXTENSION .. '] Extension')

return CirclingbatPrefabPostInit
