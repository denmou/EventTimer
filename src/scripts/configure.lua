local modname = 'enevt_timer'
local path

local options = {
    {
        id = 'aporkalypse',
        icon = 'aporkalypse_clock',
        type = {'NAMES'},
        name = 'APORKALYPSE_CLOCK',
        switch = true,
        group = true,
        dlc = {
            rog = false,
            sw = false,
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
            rog = false,
            sw = false,
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
            rog = false,
            sw = false,
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
            rog = false,
            sw = false,
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
            rog = false,
            sw = true,
            ham = false
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
            rog = false,
            sw = true,
            ham = false
        },
        time = 24 * 60
    },
    {
        id = 'basehassler',
        icon = 'boss',
        type = {'NAMES'},
        name = 'DEERCLOPS',
        group = true,
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = false
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
            rog = false,
            sw = true,
            ham = false
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
            rog = false,
            sw = true,
            ham = false
        },
        time = 24 * 60
    },
    {
        id = 'hounds',
        icon = 'dog',
        type = {'NAMES'},
        name = 'HOUND',
        group = true,
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = false
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
            rog = false,
            sw = false,
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
            sw = false,
            ham = false
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
            sw = false,
            ham = false
        },
        time = 24 * 60
    },
    {
        id = 'locomotor',
        icon = 'food',
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
        icon = 'wx78',
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
        icon = 'grow',
        type = {'NAMES'},
        name = 'FAST_FARMPLOT',
        group = true,
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
        type = {'NAMES'},
        name = 'FIRE',
        group = true,
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    },
    {
        id = 'packim',
        icon = 'packims',
        type = {'NAMES'},
        name = 'PACKIM',
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    },
    {
        id = 'setting',
        icon = 'mods',
        type = {'UI', 'HUD'},
        name = 'DEPLOY',
        position = {
            left = false,
            right = true
        },
        row = 6,
        scale = 1
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
            self.options = deepcopy(options)
            local config
            if load_success == true then
                local success, savedata = RunInSandbox(str)
                if success and string.len(str) > 0 then
                    config = savedata
                end
            end
            if config then
                for n, option in ipairs(self.options) do
                    for m, item in ipairs(config) do
                        if item.id == option.id then
                            option.switch = item.switch
                            if item.time then
                                option.time = item.time
                            end
                            if item.row then
                                option.row = item.row
                            end
                            if item.scale then
                                option.scale = item.scale
                            end
                            if option.dlc then
                                for key, v in pairs(option.dlc) do
                                    option.dlc[key] = item.dlc[key]
                                end
                            end
                            if option.position then
                                for key, v in pairs(option.position) do
                                    option.position[key] = item.position[key]
                                end
                            end
                            break
                        end
                    end
                end
            else
                self:Save(
                    function()
                        print('EventTimer: init configuration')
                    end
                )
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

function Configure:OnSwitch(id, value)
    local index
    for i, v in ipairs(self.options_active) do
        if v.id == id then
            index = i
            break
        end
    end
    if index then
        self.options_active[index].switch = value
    end
end

function Configure:OnSwitchDlc(id, dlc, value)
    local index
    for i, v in ipairs(self.options_active) do
        if v.id == id then
            index = i
            break
        end
    end
    if index then
        self.options_active[index].dlc[dlc] = value
    end
end

function Configure:OnSelectPosition(id, selected)
    local index
    for i, v in ipairs(self.options_active) do
        if v.id == id then
            index = i
            break
        end
    end
    if index then
        for i, v in pairs(self.options_active[index].position) do
            if i == selected then
                self.options_active[index].position[i] = true
            else
                self.options_active[index].position[i] = false
            end
        end
    end
end

function Configure:UpdateValue(id, field, value)
    local index
    for i, v in ipairs(self.options_active) do
        if v.id == id then
            index = i
            break
        end
    end
    if index then
        if self.options_active[index][field] then
            self.options_active[index][field] = value
        end
    end
end

function Configure:Apply()
    self.options = deepcopy(self.options_active)
    self:Save(
        function()
            print('EventTimer: apply configuration')
        end
    )
end

function Configure:Reset()
    self.options_active = deepcopy(options)
end

function Configure:Cancel()
    self.options_active = deepcopy(self.options)
end

return Configure
