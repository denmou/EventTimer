require 'constant/constants'

local EXTENSION = EXTENSION_CHESSNAVY

local function ChessNavyPostInit(self)
    table.insert(GLOBAL_SETTING.entityMap[EXTENSION], self)
end

GLOBAL_SETTING.extensionMap[EXTENSION] = {
    OnEventReport = function()
        for _, e in ipairs(GLOBAL_SETTING.entityMap[EXTENSION]) do
            local waitTime = e.spawn_timer
            local config = GLOBAL_SETTING:GetActiveOption(ID_CHESS_MONSTERS)
            if waitTime and waitTime >= 0 and waitTime < config.value then
                if waitTime > 0 then
                    GLOBAL_NOTICE_HUD:SetText(ID_CHESS_MONSTERS, STRINGS.ACTIONS.REPAIR, waitTime)
                else
                    GLOBAL_NOTICE_HUD:SetText(ID_CHESS_MONSTERS, STRINGS.ACTIONS.SLEEPIN, NONE_TIME)
                end
            end
        end
    end
}
print('Add [' .. EXTENSION .. '] Extension')

return ChessNavyPostInit
