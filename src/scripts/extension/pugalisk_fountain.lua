require 'constant/constants'

local EXTENSION = EXTENSION_PUGALISK_FOUNTAIN

local function PugaliskFountainPrefabPostInit(inst)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], inst)
end

GLOBAL_SETTING.extensionMap[EXTENSION_PUGALISK_FOUNTAIN] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            if e.dry then
                if e.resettask and e.resettask.nexttick then
                    local waitTime = (e.resettask.nexttick - GetTick()) * GetTickTime()
                    GLOBAL_NOTICE_HUD:SetText(ID_PUGALISK_FOUNTAIN, STRINGS.ACTIONS.RENOVATE, waitTime)
                else
                    GLOBAL_NOTICE_HUD:SetText(ID_PUGALISK_FOUNTAIN, STRINGS.CHARACTERS.WALANI.DESCRIBE.LAVASPIT.COOL, NONE_TIME)
                end
            else
                GLOBAL_NOTICE_HUD:SetText(ID_PUGALISK_FOUNTAIN, STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.STORE.GENERIC, NONE_TIME)
            end
        end
    end
}
print('Add [' .. EXTENSION_PUGALISK_FOUNTAIN .. '] Extension')

return PugaliskFountainPrefabPostInit
