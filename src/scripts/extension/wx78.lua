require 'constant/constants'

local function Wx78PrefabPostInit(inst)
    inst.OnEventReport = function()
        if inst.charge_time and inst.charge_time > 0 then
            GLOBAL_NOTICE_HUD:SetText(ID_WX78, STRINGS.ACTIONS.CHARGE_UP, inst.charge_time)
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_WX78] = inst
    print('Add [' .. EXTENSION_WX78 .. '] Extension')
end

return Wx78PrefabPostInit
