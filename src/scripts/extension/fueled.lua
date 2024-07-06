require 'constant/constants'
local Utils = require 'util/utils'

local OFFSET_Y = 100

local function DryerPostInit(self)
    if not self.inst.components.equippable then
        table.insert(GLOBAL_SETTING.temporary[ID_FUELED], self.inst)
        local OnRemoveEntity = self.OnRemoveEntity
        self.OnRemoveEntity = function(...)
            if OnRemoveEntity then
                OnRemoveEntity(...)
            end
            for i = #GLOBAL_SETTING.temporary[ID_FUELED], 1, -1 do
                if self.inst.GUID == GLOBAL_SETTING.temporary[ID_FUELED][i].GUID then
                    table.remove(GLOBAL_SETTING.temporary[ID_FUELED], i)
                end
            end
            GLOBAL_NOTICE_HUD:RemoveFollowNotice(self.inst)
        end
    end
end

GLOBAL_SETTING.extensionMap[EXTENSION_FUELED] = {
    OnEventReport = function()
        for _, v in ipairs(GLOBAL_SETTING.temporary[ID_FUELED]) do
            local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(v, OFFSET_Y)
            local fueled = v.components.fueled
            local currentTime = fueled.currentfuel
            if currentTime > 0 then
                local maxTime = fueled.maxfuel
                notice:SetValue(Utils.SecondFormat(currentTime) .. '/' .. Utils.SecondFormat(maxTime))
            end
        end
    end
}
print('Add [' .. EXTENSION_FUELED .. '] Extension')

return DryerPostInit
