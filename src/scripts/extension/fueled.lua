require 'constant/constants'
local Utils = require 'util/utils'

local OFFSET_Y = 100

local function DryerPostInit(self)
    table.insert(GLOBAL_SETTING.temporary[ID_FUELED], self.inst)
    self.OnEventReport = function()
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
    GLOBAL_SETTING.extensionMap[EXTENSION_FUELED] = self
    print('Add [' .. EXTENSION_FUELED .. '] Extension')
end

return DryerPostInit
