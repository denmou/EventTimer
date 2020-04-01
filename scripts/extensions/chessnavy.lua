local function ChessNavyPostInit(self)
    local WORLD = SaveGameIndex:GetCurrentMode()
    if g_func_mod_config('ChessMonsters') and not g_func_mod_config('SWOnly') or WORLD == 'shipwrecked' then
        local name = 'chess_monsters'
        g_obj_control.add(name)
        self._eventTimer = function()
            local waitTime = self.spawn_timer
            if waitTime and waitTime >= 0 then
                local text = g_obj_constant.sleep
                if waitTime > 0 then
                    text = g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                end

                g_obj_control.set(name, text)
            else
                g_obj_control.hide(name)
            end
        end
        table.insert(g_obj_items, self)
    end
end

g_func_component_init('chessnavy', ChessNavyPostInit)