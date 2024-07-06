require 'constant/constants'
local Utils = require 'util/utils'

local OFFSET_Y = -450

local function DryerPostInit(self)
    table.insert(GLOBAL_SETTING.temporary[ID_DRYER], self.inst)
    local OnRemoveEntity = self.OnRemoveEntity
    self.OnRemoveEntity = function(...)
        if OnRemoveEntity then
            OnRemoveEntity(...)
        end
        for i = #GLOBAL_SETTING.temporary[ID_DRYER], 1, -1 do
            if self.inst.GUID == GLOBAL_SETTING.temporary[ID_DRYER][i].GUID then
                table.remove(GLOBAL_SETTING.temporary[ID_DRYER], i)
            end
        end
        GLOBAL_NOTICE_HUD:RemoveFollowNotice(self.inst)
    end
end

GLOBAL_SETTING.extensionMap[EXTENSION_DRYER] = {
    OnEventReport = function()
        for _, v in ipairs(GLOBAL_SETTING.temporary[ID_DRYER]) do
            local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(v, OFFSET_Y)
            local dryer = v.components.dryer
            local waitTime = dryer:GetTimeToDry()
            if waitTime > 0 then
                notice:SetValue(Utils.SecondFormat(waitTime))
            end
        end
    end
}
print('Add [' .. EXTENSION_DRYER .. '] Extension')

return DryerPostInit
