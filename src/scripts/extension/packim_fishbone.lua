require 'constant/constants'
local Utils = require 'util/utils'

local OFFSET_Y = -200

local function PackimFishbonePrefabPostInit(inst)
    table.insert(GLOBAL_SETTING.temporary[ID_PACKIM_FISHBONE], inst)
    inst.OnEventReport = function()
        for _, v in ipairs(GLOBAL_SETTING.temporary[ID_PACKIM_FISHBONE]) do
            if v.respawntime then
                local waitTime = v.respawntime - GetTime()
                if waitTime >= 0 then
                    local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(v, OFFSET_Y)
                    notice:SetValue(Utils.SecondFormat(waitTime))
                end
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_PACKIM_FISHBONE] = inst
    print('Add [' .. EXTENSION_PACKIM_FISHBONE .. '] Extension')
end

return PackimFishbonePrefabPostInit
