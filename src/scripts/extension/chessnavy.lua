require 'constant/constants'

local function ChessNavyPostInit(self)
    self.OnEventReport = function()
        local waitTime = self.spawn_timer
        local config = GLOBAL_SETTING:GetActiveOption(ID_CHESS_MONSTERS)
        if waitTime and waitTime >= 0 and waitTime < config.value then
            if waitTime > 0 then
                GLOBAL_NOTICE_HUD:SetText(ID_CHESS_MONSTERS, STRINGS.ACTIONS.REPAIR, waitTime)
            else
                GLOBAL_NOTICE_HUD:SetText(ID_CHESS_MONSTERS, STRINGS.ACTIONS.SLEEPIN, NONE_TIME)
            end
        end
    end
    GLOBAL_SETTING.extensionMap[EXTENSION_CHESSNAVY] = self
    print('Add [' .. EXTENSION_CHESSNAVY .. '] Extension')
end

return ChessNavyPostInit
