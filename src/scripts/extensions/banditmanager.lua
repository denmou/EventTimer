local id = "pig_bandit"

local function BanditmanagerPostInit(self)
    g_obj_control.add(id)
    self._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            if self.bandit then
                g_obj_control.set(id, STRINGS.ACTIONS.ACTIVATE.GENERIC)
            else
                local waitTime = self.deathtime
                if waitTime < config.time then
                    if waitTime > 0 then
                        waitTime = self.deathtime + (self.task.nexttick - GetTick()) * GetTickTime()
                        g_obj_control.set(id, STRINGS.ACTIONS.CHARGE_UP .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                    else
                        local chance = 0
                        if not self.banditactive then
                            local player = GetPlayer()
                            local pt = Vector3(player.Transform:GetWorldPosition())
				            local tiletype = GetGroundTypeAtPosition(pt)
				            if tiletype == GROUND.SUBURB or tiletype == GROUND.COBBLEROAD or tiletype == GROUND.FOUNDATION or tiletype == GROUND.LAWN then	
				            	local value = 0
				            	if player.components.inventory then
				            		for k,item in pairs(player.components.inventory.itemslots) do						
				            			local mult = 1
				            			if item.components.stackable then
				            				mult = item.components.stackable:StackSize()
				            			end
				            			if item.oincvalue then
				            				value = value + (item.oincvalue * mult)
				            			end
				            		end
                                
				            	    if player.components.inventory.overflow and player.components.inventory.overflow.components.container then
				            	        for k,item in pairs(player.components.inventory.overflow.components.container.slots) do
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
				            		value = value *1.5
				            	end
				            	if GetWorld().components.clock:IsNight() then
				            		value = value *3
				            	end		
                            
				            	chance = 1/100
				            	if value >= 150 then
				            		chance = 1/5
				            	elseif value >= 100 then
				            		chance = 1/10
				            	elseif value >= 50 then
				            		chance = 1/20
				            	elseif value >= 10 then
				            		chance = 1/40
				            	elseif value == 0 then
				            		chance = 0					
				            	end
				            	chance = chance * self.diffmod
				            end
                        end
                        waitTime = (self.task.nexttick - GetTick()) * GetTickTime()
                        g_obj_control.set(id, "[" .. chance * 100 .. "%]" .. STRINGS.ACTIONS.GIVE.LOAD .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                    end
                else
                    g_obj_control.hide(id)
                end
            end
        else
            g_obj_control.hide(id)
        end
    end
    table.insert(g_obj_items, self)
end

g_func_component_init("banditmanager", BanditmanagerPostInit)
