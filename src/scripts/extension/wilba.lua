require 'constant/constants'

local function WilbaPrefabPostInit(inst)
    inst.OnEventReport = function()
        if inst.transform_task and inst.transform_task.nexttick then
            local waitTime = (inst.transform_task.nexttick - GetTick()) * GetTickTime()
            if inst.monster_count > 0 then
                waitTime = waitTime + (inst.monster_count - 1) * inst.cooldown_schedule
            end
            if waitTime > 0 then
                if inst.ready_to_transform then
                    GLOBAL_NOTICE_HUD:SetText(ID_WILBA, STRINGS.ACTIONS.FEED, waitTime)
                else
                    GLOBAL_NOTICE_HUD:SetText(ID_WILBA, STRINGS.NAMES.DECO_WALLORNAMENT_HUNT, waitTime)
                end
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_WILBA] = inst
    print('Add [' .. EXTENSION_WILBA .. '] Extension')
end

return WilbaPrefabPostInit
