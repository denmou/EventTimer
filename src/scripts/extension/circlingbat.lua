require 'constant/constants'

local function CirclingbatPrefabPostInit(inst)
    if GLOBAL_SETTING.temporary[ID_VAMPIRE_BATS] then
        table.insert(GLOBAL_SETTING.temporary[ID_VAMPIRE_BATS], inst.task.nexttick)
    end
end

return CirclingbatPrefabPostInit
