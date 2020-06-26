local modname = 'enevt_timer'
local path

local options = {
    {
        id = 'aporkalypse',
        icon = 'aporkalypse',
        type = {'NAMES'},
        name = 'APORKALYPSE_CLOCK',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24 * 60
    },
    {
        id = 'roc',
        icon = 'roc',
        type = {'UI', 'CUSTOMIZATIONSCREEN', 'NAMES'},
        name = 'ROC',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24 * 60
    },
    {
        id = 'pugalisk_fountain',
        icon = 'pugalisk_fountain',
        type = {'NAMES'},
        name = 'PUGALISK_FOUNTAIN',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    },
    {
        id = 'hayfever',
        icon = 'hayfever',
        type = {'UI', 'CUSTOMIZATIONSCREEN', 'NAMES'},
        name = 'HAYFEVER',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 16 * 60
    },
    {
        id = 'volcano',
        icon = 'volcano',
        type = {'NAMES'},
        name = 'VOLCANO',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24 * 60
    },
    {
        id = 'chess_monsters',
        icon = 'chess_monsters',
        type = {'NAMES'},
        name = 'KNIGHTBOAT',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24 * 60
    },
    {
        id = 'basehassler',
        icon = 'deerclops',
        type = {'NAMES'},
        name = 'DEERCLOPS',
        group = true,
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24 * 60
    },
    {
        id = 'tigershark',
        icon = 'tigershark',
        type = {'NAMES'},
        name = 'TIGERSHARK',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24 * 60
    },
    {
        id = 'kraken',
        icon = 'kraken',
        type = {'NAMES'},
        name = 'KRAKEN',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24 * 60
    },
    {
        id = 'hounds',
        icon = 'hounds',
        type = {'NAMES'},
        name = 'HOUND',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24 * 60
    },
    {
        id = 'vampire_bats',
        icon = 'vampire_bats',
        type = {'NAMES'},
        name = 'VAMPIREBAT',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24 * 60
    },
    {
        id = 'worm',
        icon = 'worm',
        type = {'NAMES'},
        name = 'WORM',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24 * 60
    },
    {
        id = 'nightmareclock',
        icon = 'fissure',
        type = {'NAMES'},
        name = 'NIGHTMARELIGHT',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24 * 60
    },
    {
        id = 'locomotor',
        icon = 'coffee',
        type = {'NAMES'},
        name = 'COFFEE',
        group = true,
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    },
    {
        id = 'WX78',
        icon = 'lightning',
        type = {'NAMES'},
        name = 'WX78',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    },
    {
        id = 'growthTime',
        icon = 'regrowth',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    },
    {
        id = 'fuelTime',
        icon = 'firepit',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    }
}

local Configure =
    Class(
    function(self)
        self.options = {}
        self.options_active = {}
    end
)

function Configure:Init()
    path = KnownModIndex:GetModConfigurationPath(modname)
    TheSim:GetPersistentString(
        path,
        function(load_success, str)
            local config
            if load_success == true then
                local success, savedata = RunInSandbox(str)
                if success and string.len(str) > 0 then
                    config = savedata
                end
            end
            if not config then
                self.options = deepcopy(options)
                self:Save(
                    function()
                        print('EventTimer: init configuration')
                    end
                )
            else
                self.options = deepcopy(config)
            end
            self.options_active = deepcopy(self.options)
        end
    )
end

function Configure:Save(cb)
    local data = DataDumper(self.options, nil, false)
    SavePersistentString(path, data, ENCODE_SAVES, cb)
end

function Configure:Get()
    return self.options_active
end

function Configure:GetById(id)
    local index
    for i, v in ipairs(self.options_active) do
        if v.id == id then
            index = i
            break
        end
    end
    if index then
        return self.options_active[index]
    else
        return nil
    end
end

function Configure:OnSwitch(id, value, dlc)
    local index
    for i, v in ipairs(self.options) do
        if v.id == id then
            index = i
            break
        end
    end
    if index then
        if dlc then
            self.options[index].dlc[dlc] = value
        else
            self.options[index].switch = value
        end
    end
end

function Configure:UpdateTimeValue(id, value)
    local index
    for i, v in ipairs(self.options) do
        if v.id == id then
            index = i
            break
        end
    end
    if index then
        self.options[index].time = value
    end
end

function Configure:Apply()
    self.options_active = deepcopy(self.options)
    self:Save(
        function()
            print('EventTimer: apply configuration')
        end
    )
end

function Configure:Reset()
    self.options = deepcopy(options)
    self.options_active = deepcopy(self.options)
    self:Save(
        function()
            print('EventTimer: reset configuration')
        end
    )
end

function Configure:Cancel()
    self.options = deepcopy(self.options_active)
end

return Configure
