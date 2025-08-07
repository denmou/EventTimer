require 'constant/constants'
local Utils = require 'util/utils'

local EXTENSION = EXTENSION_WILBA
local OFFSET_Y = -400

local function WilbaPrefabPostInit(inst)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], inst)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            if e.transform_task and e.transform_task.nexttick then
                local waitTime = (e.transform_task.nexttick - GetTick()) * GetTickTime()
                if e.monster_count > 0 then
                    waitTime = waitTime + (e.monster_count - 1) * e.cooldown_schedule
                end
                if waitTime > 0 then
                    if e.from_food then
                        --local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(e, OFFSET_Y)
                        --notice:SetValue(Utils.SecondFormat(waitTime))
                        GLOBAL_NOTICE_HUD:SetText(ID_WILBA, STRINGS.ACTIONS.GNAW, waitTime)
                    else
                        --local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(e, OFFSET_Y)
                        --notice:SetValue(e.monster_count .. '/2 (' .. Utils.SecondFormat(waitTime) .. ')')
                        GLOBAL_NOTICE_HUD:SetText(ID_WILBA, STRINGS.ACTIONS.FEED .. '(' .. e.monster_count .. '/2)', waitTime)
                    end
                end
            end

        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return WilbaPrefabPostInit
