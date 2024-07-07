require 'constant/constants'
local Utils = require 'util/utils'

local EXTENSION = EXTENSION_PACKIM_FISHBONE
local OFFSET_Y = -200

local function PackimFishbonePrefabPostInit(inst)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], inst)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            if e.respawntime then
                local waitTime = e.respawntime - GetTime()
                if waitTime >= 0 then
                    local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(e, OFFSET_Y)
                    notice:SetValue(Utils.SecondFormat(waitTime))
                end
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return PackimFishbonePrefabPostInit
