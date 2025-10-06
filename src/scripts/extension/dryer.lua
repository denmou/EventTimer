require 'constant/constants'
local Utils = require 'util/utils'

local EXTENSION = EXTENSION_DRYER
local OFFSET_Y = -450

local function DryerPostInit(self)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self.inst)
    local OnRemoveEntity = self.OnRemoveEntity
    self.OnRemoveEntity = function(...)
        if OnRemoveEntity then
            OnRemoveEntity(...)
        end
        for i = #GLOBAL_SETTING.entityMap[EXTENSION], 1, -1 do
            if self.inst.GUID == GLOBAL_SETTING.entityMap[EXTENSION][i].GUID then
                table.remove(GLOBAL_SETTING.entityMap[EXTENSION], i)
                print('Remove Dryer[' .. self.inst.GUID .. '] Entity')
            end
        end
        GLOBAL_NOTICE_HUD:RemoveFollowNotice(self.inst)
    end
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        local config = GLOBAL_SETTING:GetActiveOption(ID_DRYER)
        if nil ~= config.value and config.value == DISPLAY_FOLLOW then
            for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
                local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(e, OFFSET_Y)
                local dryer = e.components.dryer
                local waitTime = dryer:GetTimeToDry()
                if waitTime > 0 then
                    notice:SetValue(Utils.SecondFormat(waitTime))
                end
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return DryerPostInit
