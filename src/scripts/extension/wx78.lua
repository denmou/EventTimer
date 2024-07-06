require 'constant/constants'
local Utils = require 'util/utils'

local OFFSET_Y = -350

local function Wx78PrefabPostInit(inst)
    inst.OnEventReport = function()
        if inst.charge_time and inst.charge_time > 0 then
            local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(inst, OFFSET_Y)
            notice:SetValue(Utils.TimeFormat(inst.charge_time))
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_WX78] = inst
    print('Add [' .. EXTENSION_WX78 .. '] Extension')
end

return Wx78PrefabPostInit
