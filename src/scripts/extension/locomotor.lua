require 'constant/constants'
local Utils = require 'util/utils'

local EXTENSION = EXTENSION_LOCOMOTOR
local OFFSET_Y = 35
local FONT_SIZE = 16

local ADDITIVES = {
    CAFFEINE = "cane",
    SURF = "surfboard_item",
    AUTODRY = "rainhat"
}
local LUMINOUS = {
    wormlight = "wormlight",
    dragoonheart = "dragoonheart",
    rainbowjellylight = "rainbowjellyfish_dead"
}

local function LocomotorPostInit(self)
    if self.speed_modifiers_add_timer and self.inst:HasTag('character') then
        table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self.inst)
        local OnRemoveEntity = self.OnRemoveEntity
        self.OnRemoveEntity = function(...)
            if OnRemoveEntity then
                OnRemoveEntity(...)
            end
            for i = #GLOBAL_SETTING.entityMap[EXTENSION], 1, -1 do
                if self.inst.GUID == GLOBAL_SETTING.entityMap[EXTENSION][i].GUID then
                    table.remove(GLOBAL_SETTING.entityMap[EXTENSION], i)
                    print('Remove Locomotor[' .. self.inst.GUID .. '] Entity')
                end
            end
            GLOBAL_NOTICE_HUD:RemoveFollowNotice(self.inst)
        end
    end
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            for k, t in pairs(e.components.locomotor.speed_modifiers_add_timer) do
                local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(e, OFFSET_Y, FONT_SIZE)
                if t then
                    --local text = Utils.SecondFormat(t)
                    local atlas = GetInventoryItemAtlas(ADDITIVES[k] .. '.tex')
                    --notice:SetValueById(k, text, atlas, ADDITIVES[k])
                    GLOBAL_NOTICE_HUD:SetIconText(ADDITIVES[k], atlas, STRINGS.ACTIONS.ACTIVATE.GENERIC, t)
                end
            end
            for k, m in pairs(LUMINOUS) do
                local light = e[k]
                if light then
                    --local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(e, OFFSET_Y, FONT_SIZE)
                    local waitTime = light.components.spell.duration - light.components.spell.lifetime
                    if waitTime >= 0 then
                        local atlas = GetInventoryItemAtlas(m .. '.tex')
                        GLOBAL_NOTICE_HUD:SetIconText(m, atlas, STRINGS.ACTIONS.ACTIVATE.GENERIC, waitTime)
                        --notice:SetValueById(k, Utils.SecondFormat(waitTime), atlas, m)
                    end
                end
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return LocomotorPostInit
