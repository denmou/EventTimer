local id = "chess_monsters"

local function ChessNavyPostInit(self)
    g_obj_control.add(id)
    self._eventTimer = function()
        local config = g_func_mod_config:GetById(id)
        if config and config.switch and (g_dlc_mode and config.dlc[g_dlc_mode]) then
            local waitTime = self.spawn_timer
            if waitTime and waitTime >= 0 and waitTime < config.time then
                local text = STRINGS.ACTIONS.SLEEPIN
                if waitTime > 0 then
                    text = STRINGS.ACTIONS.REPAIR .. ": " .. g_obj_utils.timeFormat(math.ceil(waitTime))
                end
                g_obj_control.set(id, text)
            else
                g_obj_control.hide(id)
            end
        else
            g_obj_control.hide(id)
        end
    end
    table.insert(g_obj_items, self)
end

g_func_component_init("chessnavy", ChessNavyPostInit)
