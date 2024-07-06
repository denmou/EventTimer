require 'constant/constants'
local Utils = require 'util/utils'

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
        table.insert(GLOBAL_SETTING.temporary[ID_LOCOMOTOR], self.inst)
        local OnRemoveEntity = self.OnRemoveEntity
        self.OnRemoveEntity = function(...)
            if OnRemoveEntity then
                OnRemoveEntity(...)
            end
            for i = #GLOBAL_SETTING.temporary[ID_LOCOMOTOR], 1, -1 do
                if self.inst.GUID == GLOBAL_SETTING.temporary[ID_LOCOMOTOR][i].GUID then
                    table.remove(GLOBAL_SETTING.temporary[ID_LOCOMOTOR], i)
                end
            end
            GLOBAL_NOTICE_HUD:RemoveFollowNotice(self.inst)
        end
    end
end

GLOBAL_SETTING.extensionMap[EXTENSION_LOCOMOTOR] = {
    OnEventReport = function()
        for _, v in ipairs(GLOBAL_SETTING.temporary[ID_LOCOMOTOR]) do
            for k, t in pairs(v.components.locomotor.speed_modifiers_add_timer) do
                local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(v, OFFSET_Y, FONT_SIZE)
                local power = v.components.locomotor.speed_modifiers_add[k]
                if t then
                    local text = Utils.SecondFormat(t)
                    local atlas = GetInventoryItemAtlas(ADDITIVES[k] .. '.tex')
                    notice:SetValueById(k, text, atlas, ADDITIVES[k])
                end
            end
            for k, m in pairs(LUMINOUS) do
                local light = v[k]
                if light then
                    local notice = GLOBAL_NOTICE_HUD:GetFollowNotice(v, OFFSET_Y, FONT_SIZE)
                    local waitTime = light.components.spell.duration - light.components.spell.lifetime
                    if waitTime >= 0 then
                        local atlas = GetInventoryItemAtlas(m .. '.tex')
                        notice:SetValueById(k, Utils.SecondFormat(waitTime), atlas, m)
                    end
                end
            end
        end
    end
}
print('Add [' .. EXTENSION_LOCOMOTOR .. '] Extension')

return LocomotorPostInit
