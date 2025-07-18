require 'constant/constants'
local Utils = require 'util/utils'

local EXTENSION = EXTENSION_FUELED
local OFFSET_Y = 100

local function FueledPostInit(self)
    if not self.inst.components.equippable then
        table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self.inst)
        local OnRemoveEntity = self.OnRemoveEntity
        self.OnRemoveEntity = function(...)
            if OnRemoveEntity then
                OnRemoveEntity(...)
            end
            for i = #GLOBAL_SETTING.entityMap[EXTENSION], 1, -1 do
                if self.inst.GUID == GLOBAL_SETTING.entityMap[EXTENSION][i].GUID then
                    table.remove(GLOBAL_SETTING.entityMap[EXTENSION], i)
                    print('Remove Fueled[' .. self.inst.GUID .. '] Entity')
                end
            end
            GLOBAL_NOTICE_HUD:RemoveFollowNotice(self.inst)
        end
    end
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(e, OFFSET_Y)
            local fueled = e.components.fueled
            if fueled then
                local currentTime = fueled.currentfuel
                if currentTime > 0 then
                    local maxTime = fueled.maxfuel
                    notice:SetValue(Utils.SecondFormat(currentTime) .. '/' .. Utils.SecondFormat(maxTime))
                end
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return FueledPostInit
