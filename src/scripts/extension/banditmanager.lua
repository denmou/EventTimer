require 'constant/constants'

local EXTENSION = EXTENSION_BANDITMANAGER

local function BanditmanagerPostInit(self)
    if not self.disabled then
        table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
    end
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local waitTime = e.deathtime
            if waitTime > 0 then
                waitTime = waitTime + (e.task.nexttick - GetTick()) * GetTickTime()
                local config = GLOBAL_SETTING:GetActiveOption(ID_PIG_BANDIT)
                if waitTime < config.value then
                    GLOBAL_NOTICE_HUD:SetText(ID_PIG_BANDIT, STRINGS.ACTIONS.HEAL, waitTime)
                end
            else
                if not e.banditactive then
                    local chance = 0
                    local player = GetPlayer()
                    local pt = Vector3(player.Transform:GetWorldPosition())
                    local tiletype = GetGroundTypeAtPosition(pt)
                    if tiletype == GROUND.SUBURB or tiletype == GROUND.COBBLEROAD or tiletype == GROUND.FOUNDATION or tiletype == GROUND.LAWN then
                        local value = 0
                        if player.components.inventory then
                            for _, item in pairs(player.components.inventory.itemslots) do
                                local mult = 1
                                if item.components.stackable then
                                    mult = item.components.stackable:StackSize()
                                end
                                if item.oincvalue then
                                    value = value + (item.oincvalue * mult)
                                end
                            end

                            if player.components.inventory.overflow and player.components.inventory.overflow.components.container then
                                for _, item in pairs(player.components.inventory.overflow.components.container.slots) do
                                    local mult = 1
                                    if item.components.stackable then
                                        mult = item.components.stackable:StackSize()
                                    end
                                    if item.oincvalue then
                                        value = value + (item.oincvalue * mult)
                                    end
                                end
                            end
                        end

                        if GetWorld().components.clock:IsDusk() then
                            value = value * 1.5
                        elseif GetWorld().components.clock:IsNight() then
                            value = value * 3
                        end

                        chance = 1 / 100
                        if value >= 150 then
                            chance = 1 / 5
                        elseif value >= 100 then
                            chance = 1 / 10
                        elseif value >= 50 then
                            chance = 1 / 20
                        elseif value >= 10 then
                            chance = 1 / 40
                        elseif value == 0 then
                            chance = 0
                        end
                        chance = chance * e.diffmod
                        waitTime = (e.task.nexttick - GetTick()) * GetTickTime()
                        local text = "[" .. chance * 100 .. "%]" .. STRINGS.ACTIONS.PEER
                        GLOBAL_NOTICE_HUD:SetText(ID_PIG_BANDIT, text, waitTime)
                    end
                else
                    GLOBAL_NOTICE_HUD:SetText(ID_PIG_BANDIT, STRINGS.BANDIT_TALK_FIGHT[2], NONE_TIME)
                end
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return BanditmanagerPostInit
