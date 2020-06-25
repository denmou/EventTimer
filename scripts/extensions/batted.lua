local BAT_ATTACK = false

local id = "vampire_bats"

local function BattedPostInit(self)
    g_obj_control.add(id)
    self._batsCount = 0
    local _DoBatAttack = self.DoBatAttack
    self.DoBatAttack = function(inst, ...)
        self._batsCount = #self.batstoattack
        BAT_ATTACK = true
        _DoBatAttack(inst, ...)
    end
    self._eventTimer = function()
        local config = _G.g_func_mod_config:GetById(id)
        if config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            local waitTime = self.timetoattack
            local count = self:CountBats()
            if g_str_aporkalypse_bat.time and g_str_aporkalypse_bat.time > 0 and waitTime > g_str_aporkalypse_bat.time then
                waitTime = g_str_aporkalypse_bat.time
                count = g_str_aporkalypse_bat.count
            end
            if waitTime < config.time then
                if BAT_ATTACK then
                    g_obj_control.set(id, "[" .. self._batsCount .. "]" .. g_obj_constant.circle)
                else
                    g_obj_control.set(
                        id,
                        "[" ..
                            count .. "]" .. g_obj_constant.come .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                    )
                end
            else
                g_obj_control.hide(id)
            end
        else
            g_obj_control.hide(id)
        end
    end
    table.insert(g_obj_items, self)
end

local function VampirebatPrefabPostInit(inst)
    inst:ListenForEvent(
        "wingdown",
        function()
            BAT_ATTACK = false
        end
    )
end

g_func_prefab_init("vampirebat", VampirebatPrefabPostInit)
g_func_component_init("batted", BattedPostInit)
