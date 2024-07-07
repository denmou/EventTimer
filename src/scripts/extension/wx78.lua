require 'constant/constants'
local Utils = require 'util/utils'

local EXTENSION = EXTENSION_WX78
local OFFSET_Y = -350

local function Wx78PrefabPostInit(inst)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], inst)
end

GLOBAL_SETTING.extensionMap[EXTENSION_WX78] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            if e.charge_time and e.charge_time > 0 then
                local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(e, OFFSET_Y)
                notice:SetValue(Utils.TimeFormat(e.charge_time))
            end

        end
    end
}
print('Add [' .. EXTENSION_WX78 .. '] Extension')

return Wx78PrefabPostInit
