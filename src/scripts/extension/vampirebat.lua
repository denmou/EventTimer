local BAT_ATTACK = false

local function VampirebatPrefabPostInit(inst)
    inst:ListenForEvent("wingdown",
            function()
                BAT_ATTACK = false
            end)
end

return VampirebatPrefabPostInit
