local id = "pig_bandit"

local function BanditmanagerPostInit(self)
	if not self.disabled then
    	g_obj_control.add(id)
    	self._eventTimer = function()
    	    local config = g_func_mod_config:GetById(id)
    	    if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
				local waitTime = self.deathtime
				if waitTime > 0 then
					waitTime = waitTime + (self.task.nexttick - GetTick()) * GetTickTime()
					if waitTime < config.time then
						g_obj_control.set(id, STRINGS.ACTIONS.CHARGE_UP .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
					else
						g_obj_control.hide(id)
					end
				else
    	            if not self.banditactive then
						local chance = 0
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
							waitTime = (self.task.nexttick - GetTick()) * GetTickTime()
							g_obj_control.set(id, "[" .. chance * 100 .. "%]" .. STRINGS.ACTIONS.GIVE.LOAD .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime)))
					    end
    	            else
						g_obj_control.set(id, STRINGS.ACTIONS.ACTIVATE.GENERIC)
    	            end
    	        end
    	    else
    	        g_obj_control.hide(id)
    	    end
    	end
    	table.insert(g_obj_items, self)
	end
end

g_func_component_init("banditmanager", BanditmanagerPostInit)
