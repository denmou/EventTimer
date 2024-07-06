require 'constant/constants'
local Utils = require 'util/utils'

local OFFSET_Y = -100

local function ChesterEyebonePrefabPostInit(inst)
    table.insert(GLOBAL_SETTING.temporary[ID_CHESTER_EYEBONE], inst)
    inst.OnEventReport = function()
        for _, v in ipairs(GLOBAL_SETTING.temporary[ID_CHESTER_EYEBONE]) do
            if v.respawntime then
                local waitTime = v.respawntime - GetTime()
                if waitTime > 0 then
                    local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(v, OFFSET_Y)
                    notice:SetValue(Utils.SecondFormat(waitTime))
                end
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_CHESTER_EYEBONE] = inst
    print('Add [' .. EXTENSION_CHESTER_EYEBONE .. '] Extension')
end

return ChesterEyebonePrefabPostInit
