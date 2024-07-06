require 'constant/constants'
local Utils = require 'util/utils'

local OFFSET_Y = -300

local function StewerPostInit(self)
    table.insert(GLOBAL_SETTING.temporary[ID_STEWER], self.inst)
    local OnRemoveEntity = self.OnRemoveEntity
    self.OnRemoveEntity = function(...)
        if OnRemoveEntity then
            OnRemoveEntity(...)
        end
        for i = #GLOBAL_SETTING.temporary[ID_STEWER], 1, -1 do
            if self.inst.GUID == GLOBAL_SETTING.temporary[ID_STEWER][i].GUID then
                table.remove(GLOBAL_SETTING.temporary[ID_STEWER], i)
            end
        end
        GLOBAL_NOTICE_HUD:RemoveFollowNotice(self.inst)
    end
end

GLOBAL_SETTING.extensionMap[EXTENSION_STEWER] = {
    OnEventReport = function()
        for _, v in ipairs(GLOBAL_SETTING.temporary[ID_STEWER]) do
            local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(v, OFFSET_Y)
            local stewer = v.components.stewer
            local waitTime = stewer:GetTimeToCook()
            if waitTime > 0 then
                notice:SetValue(Utils.SecondFormat(waitTime))
            end
        end
    end
}
print('Add [' .. EXTENSION_STEWER .. '] Extension')

return StewerPostInit
