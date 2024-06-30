require 'constant/constants'

local function PugaliskFountainPrefabPostInit(inst)
    inst.OnEventReport = function()
        if inst.dry then
            if inst.resettask and inst.resettask.nexttick then
                local waitTime = (inst.resettask.nexttick - GetTick()) * GetTickTime()
                GLOBAL_NOTICE_HUD:SetText(ID_PUGALISK_FOUNTAIN, STRINGS.ACTIONS.RENOVATE, waitTime)
            else
                GLOBAL_NOTICE_HUD:SetText(ID_PUGALISK_FOUNTAIN, STRINGS.CHARACTERS.WALANI.DESCRIBE.LAVASPIT.COOL, NONE_TIME)
            end
        else
            GLOBAL_NOTICE_HUD:SetText(ID_PUGALISK_FOUNTAIN, STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.STORE.GENERIC, NONE_TIME)
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_PUGALISK_FOUNTAIN] = inst
    print('Add [' .. EXTENSION_PUGALISK_FOUNTAIN .. '] Extension')
end

return PugaliskFountainPrefabPostInit
