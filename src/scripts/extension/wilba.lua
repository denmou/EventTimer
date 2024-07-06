require 'constant/constants'
local Utils = require 'util/utils'

local OFFSET_Y = -400

local function WilbaPrefabPostInit(inst)
    inst.OnEventReport = function()
        if inst.transform_task and inst.transform_task.nexttick then
            local waitTime = (inst.transform_task.nexttick - GetTick()) * GetTickTime()
            if inst.monster_count > 0 then
                waitTime = waitTime + (inst.monster_count - 1) * inst.cooldown_schedule
            end
            if waitTime > 0 then
                if inst.from_food then
                    local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(inst, OFFSET_Y)
                    notice:SetValue(Utils.SecondFormat(waitTime))
                else
                    local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(inst, OFFSET_Y)
                    notice:SetValue(inst.monster_count .. '/2 (' .. Utils.SecondFormat(waitTime) .. ')')
                end
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_WILBA] = inst
    print('Add [' .. EXTENSION_WILBA .. '] Extension')
end

return WilbaPrefabPostInit
