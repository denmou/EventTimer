require 'constant/constants'
local Option = require 'structure/option'
local Utils = require 'util/utils'

local DEFAULT_OPTIONS = {
    {
        id = ID_APORKALYPSE,
        extension = { EXTENSION_APORKALYPSE },
        icon = 'aporkalypse',
        name = 'STRINGS.NAMES.APORKALYPSE_CLOCK',
        switch = true,
        mode = { HAM_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_ANCIENT_HERALD,
        extension = { EXTENSION_APORKALYPSE },
        icon = 'ancient_herald',
        name = 'STRINGS.NAMES.ANCIENT_HERALD',
        switch = true,
        mode = { HAM_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_ROC,
        extension = { EXTENSION_ROCMANAGER },
        icon = 'roc',
        name = 'STRINGS.UI.CUSTOMIZATIONSCREEN.NAMES.ROC',
        switch = true,
        mode = { HAM_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_PUGALISK_FOUNTAIN,
        extension = { EXTENSION_PUGALISK_FOUNTAIN },
        icon = 'pugalisk_fountain',
        name = 'STRINGS.NAMES.PUGALISK_FOUNTAIN',
        switch = true,
        mode = { HAM_MODE },
        value = nil,
        describe = {}
    },
    {
        id = ID_HAYFEVER,
        extension = { EXTENSION_HAYFEVER },
        icon = 'hayfever',
        name = 'STRINGS.UI.CUSTOMIZATIONSCREEN.NAMES.HAYFEVER',
        switch = true,
        mode = { HAM_MODE },
        value = SIXTEEN_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_VOLCANO,
        extension = { EXTENSION_VOLCANOMANAGER },
        icon = 'volcano',
        name = 'STRINGS.NAMES.VOLCANO',
        switch = true,
        mode = { SW_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_CHESS_MONSTERS,
        extension = { EXTENSION_CHESSNAVY },
        icon = 'chess_monsters',
        name = 'STRINGS.NAMES.KNIGHTBOAT',
        switch = true,
        mode = { SW_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_GOOSEMOOSE,
        extension = { EXTENSION_BASEHASSLER },
        icon = 'goosemoose',
        name = 'STRINGS.NAMES.MOOSE1',
        switch = true,
        mode = { ROG_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_DRAGONFLY,
        extension = { EXTENSION_BASEHASSLER },
        icon = 'dragonfly',
        name = 'STRINGS.NAMES.DRAGONFLY',
        switch = true,
        mode = { ROG_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_BEARGER,
        extension = { EXTENSION_BASEHASSLER },
        icon = 'bearger',
        name = 'STRINGS.NAMES.BEARGER',
        switch = true,
        mode = { ROG_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_DEERCLOPS,
        extension = { EXTENSION_BASEHASSLER },
        icon = 'deerclops',
        name = 'STRINGS.NAMES.DEERCLOPS',
        switch = true,
        mode = { ROG_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_TWISTER,
        extension = { EXTENSION_BASEHASSLER },
        icon = 'twister',
        name = 'STRINGS.NAMES.TWISTER',
        switch = true,
        mode = { SW_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_TIGERSHARK,
        extension = { EXTENSION_TIGERSHARKER },
        icon = 'tigershark',
        name = 'STRINGS.NAMES.TIGERSHARK',
        switch = true,
        mode = { SW_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_KRAKEN,
        extension = { EXTENSION_KRAKENER },
        icon = 'kraken',
        name = 'STRINGS.NAMES.KRAKEN',
        switch = true,
        mode = { SW_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_HOUNDS,
        extension = { EXTENSION_HOUNDED },
        icon = 'hounds',
        name = 'STRINGS.NAMES.HOUND',
        switch = true,
        mode = { ROG_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_CROCODOG,
        extension = { EXTENSION_HOUNDED },
        icon = 'crocodog',
        name = 'STRINGS.NAMES.CROCODOG',
        switch = true,
        mode = { SW_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_VAMPIRE_BATS,
        extension = { EXTENSION_BATTED },
        icon = 'vampire_bats',
        name = 'STRINGS.NAMES.VAMPIREBAT',
        switch = true,
        mode = { HAM_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_WORM,
        extension = { EXTENSION_CAVE },
        icon = 'worm',
        name = 'STRINGS.NAMES.WORM',
        switch = true,
        mode = { ROG_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_NIGHTMARECLOCK,
        extension = { EXTENSION_NIGHTMARECLOCK },
        icon = 'fissure',
        name = 'STRINGS.NAMES.NIGHTMARELIGHT',
        switch = true,
        mode = { ROG_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_PIG_BANDIT,
        extension = { EXTENSION_BANDITMANAGER },
        icon = 'pig_bandit',
        name = 'STRINGS.NAMES.PIGBANDIT',
        switch = true,
        mode = { HAM_MODE },
        value = TWENTY_FOUR_MINUTE,
        options = OPTIONS_TIMES,
        describe = {}
    },
    {
        id = ID_WX78,
        extension = { EXTENSION_WX78 },
        icon = 'wx78',
        name = 'STRINGS.NAMES.WX78',
        switch = true,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = nil,
        describe = {}
    },
    {
        id = ID_WILBA,
        extension = { EXTENSION_WILBA },
        icon = 'wilba',
        name = 'STRINGS.NAMES.WILBA',
        switch = true,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = nil,
        describe = {}
    },
    {
        id = ID_SPEED,
        extension = { EXTENSION_PLAYER },
        icon = 'coffee',
        name = 'STRINGS.NAMES.COFFEE',
        switch = true,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = nil,
        describe = {}
    },
    {
        id = ID_DRY,
        extension = { EXTENSION_PLAYER },
        icon = 'farm',
        name = 'STRINGS.ACTIONS.DRY',
        switch = true,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = nil,
        describe = {}
    },
    {
        id = ID_SURF,
        extension = { EXTENSION_PLAYER },
        icon = 'farm',
        name = 'STRINGS.ACTIONS.SURFTO',
        switch = true,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = nil,
        describe = {}
    },
    {
        id = ID_GROWTH,
        extension = {},
        icon = 'herbology',
        name = 'STRINGS.ACTIONS.HARVEST',
        switch = true,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = nil,
        describe = {}
    },
    {
        id = ID_FUEL,
        extension = {},
        icon = 'fire',
        name = 'STRINGS.ACTIONS.ADDFUEL.GENERIC',
        switch = true,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = nil,
        describe = {}
    },
    {
        id = ID_COOKPOT,
        extension = {},
        icon = 'cookpot',
        name = 'STRINGS.ACTIONS.STORE.COOK',
        switch = true,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = nil,
        describe = {}
    },
    {
        id = ID_MEATRACK,
        extension = { EXTENSION_PLAYER },
        icon = 'meatrack',
        name = 'STRINGS.NAMES.MEATRACK',
        switch = true,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = nil,
        describe = {}
    },
    {
        id = ID_PACKIM,
        extension = { EXTENSION_PACKIM },
        icon = 'packim',
        name = 'STRINGS.NAMES.PACKIM',
        switch = true,
        mode = { SW_MODE, HAM_MODE },
        value = nil,
        describe = {}
    },
    {
        id = ID_POSITION,
        extension = {},
        icon = 'mods',
        name = 'STRINGS.UI.OPTIONS.DISPLAY_AREA_LABEL',
        switch = nil,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = POSITION_RIGHT,
        options = OPTIONS_POSITIONS,
        describe = {}
    },
    {
        id = ID_ROW,
        extension = {},
        icon = 'mods',
        name = 'STRINGS.STACKMOD',
        switch = nil,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = DEFAULT_ROWS,
        options = OPTIONS_ROWS,
        describe = {}
    },
    {
        id = ID_SCALE,
        extension = {},
        icon = 'mods',
        name = 'STRINGS.UI.HELP.ZOOM_IN',
        switch = nil,
        mode = { ROG_MODE, SW_MODE, HAM_MODE },
        value = DEFAULT_SCALE,
        options = OPTIONS_SCALES,
        describe = {}
    }
}

local Settings = Class(function(self)
    self.optionMap = {}
    self.activeOptionMap = {}
    self.configurationPath = KnownModIndex:GetModConfigurationPath(MOD_NAME)
    print('Configuration Path: ' .. self.configurationPath)
    self.currentMode = nil
    self.extensionMap = {}
    self.currentExtensionList = {}
    self.currentOptionMap = {}
    print('Initialize Setting')
end)

function Settings:Init()
    if SaveGameIndex:IsModePorkland() then
        self.currentMode = HAM_MODE
    elseif SaveGameIndex:IsModeShipwrecked() then
        self.currentMode = SW_MODE
    else
        self.currentMode = ROG_MODE
    end
    for _, v in ipairs(DEFAULT_OPTIONS) do
        self.optionMap[v.id] = Option(v.id, v.name, v.icon, v.switch, v.mode, v.value, v.options, v.extension, v.resource)
        self.activeOptionMap[v.id] = Option(v.id, v.name, v.icon, v.switch, v.mode, v.value, v.options, v.extension, v.resource)
    end
    TheSim:GetPersistentString(self.configurationPath, function(loadResult, str)
        local config
        if loadResult and string.len(str) > 0 then
            local convertResult, data = RunInSandbox(str)
            if convertResult and data then
                config = data
                print('Load Local Settings : ' .. str)
            end
        end
        if config then
            for k, v in pairs(self.optionMap) do
                if config[k] then
                    if nil ~= config[k].switch then
                        v.switch = config[k].switch
                        self.activeOptionMap[k].switch = config[k].switch
                    end
                    if nil ~= config[k].value then
                        v.value = config[k].value
                        self.activeOptionMap[k].value = config[k].value
                        print('Set ' ..  k .. ' : ' .. config[k].value)
                    end
                end
            end
        end
        self:RefreshCurrentExtension()
        print('Load Settings')
    end)
end

function Settings:Reset()
    for _, v in ipairs(DEFAULT_OPTIONS) do
        self.optionMap[v.id].switch = v.switch
        self.optionMap[v.id].value = v.value
    end
end

function Settings:Save()
    local data = {}
    for k, v in pairs(self.optionMap) do
        data[k] = {
            switch = v.switch,
            value = v.value
        }
    end
    local value = DataDumper(data, nil, false)
    print('Save Config : ' .. value)
    SavePersistentString(self.configurationPath, value, ENCODE_SAVES)
end

function Settings:Apply()
    for k, v in pairs(self.optionMap) do
        self.activeOptionMap[k].switch = v.switch
        self.activeOptionMap[k].value = v.value
    end
    self:RefreshCurrentExtension()
    self:Save()
end

function Settings:Cancel()
    for k, v in pairs(self.optionMap) do
        v.switch = self.activeOptionMap[k].switch
        v.value = self.activeOptionMap[k].value
    end
end

function Settings:GetActiveOption(id)
    return self.activeOptionMap[id]
end

function Settings:UpdateOptionSwitch(id, switch)
    if self.optionMap[id] then
        self.optionMap[id].switch = switch
    end
end

function Settings:UpdateOptionValue(id, value)
    if self.optionMap[id] then
        self.optionMap[id].value = value
    end
end

function Settings:RefreshCurrentExtension()
    self.currentExtensionList = {}
    print('Clear All Extension')
    for _, v in pairs(self.optionMap) do
        if Utils.contains(v.mode, self.currentMode) then
            if v.switch and v.extension then
                self.currentOptionMap[v.id] = v
                for _, e in ipairs(v.extension) do
                    if self.extensionMap[e] then
                        table.insert(self.currentExtensionList, self.extensionMap[e])
                        print('Enable [' .. e .. '] Extension')
                    end
                end
            end
        end
    end
end

return Settings
