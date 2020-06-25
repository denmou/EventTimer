local modname = "EventTimer"

local options = {
    {
        id = "aporkalypse",
        icon = "aporkalypse",
        type = {"NAMES"},
        name = "APORKALYPSE_CLOCK",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24*60
    },
    {
        id = "roc",
        icon = "roc",
        type = {"UI","CUSTOMIZATIONSCREEN","NAMES"},
        name = "ROC",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24*60
    },
    {
        id = "pugalisk_fountain",
        icon = "pugalisk_fountain",
        type = {"NAMES"},
        name = "PUGALISK_FOUNTAIN",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    },
    {
        id = "hayfever",
        icon = "hayfever",
        type = {"UI","CUSTOMIZATIONSCREEN","NAMES"},
        name = "HAYFEVER",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 16*60
    },
    {
        id = "volcano",
        icon = "volcano",
        type = {"NAMES"},
        name = "VOLCANO",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24*60
    },
    {
        id = "chess_monsters",
        icon = "chess_monsters",
        type = {"NAMES"},
        name = "KNIGHTBOAT",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24*60
    },
    {
        id = "basehassler",
        icon = "deerclops",
        type = {"NAMES"},
        name = "DEERCLOPS",
        group = true,
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24*60
    },
    {
        id = "tigershark",
        icon = "tigershark",
        type = {"NAMES"},
        name = "TIGERSHARK",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24*60
    },
    {
        id = "kraken",
        icon = "kraken",
        type = {"NAMES"},
        name = "KRAKEN",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24*60
    },
    {
        id = "hounds",
        icon = "hounds",
        type = {"NAMES"},
        name = "HOUND",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24*60
    },
    {
        id = "vampire_bats",
        icon = "vampire_bats",
        type = {"NAMES"},
        name = "VAMPIREBAT",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24*60
    },
    {
        id = "worm",
        icon = "worm",
        type = {"NAMES"},
        name = "WORM",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24*60
    },
    {
        id = "nightmareclock",
        icon = "fissure",
        type = {"NAMES"},
        name = "NIGHTMARELIGHT",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        },
        time = 24*60
    },
    {
        id = "locomotor",
        icon = "coffee",
        type = {"NAMES"},
        name = "COFFEE",
        group = true,
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    },
    {
        id = "WX78",
        icon = "lightning",
        type = {"NAMES"},
        name = "WX78",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    },
    {
        id = "growthTime",
        icon = "regrowth",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    },
    {
        id = "fuelTime",
        icon = "firepit",
        switch = true,
        dlc = {
            rog = true,
            sw = true,
            ham = true
        }
    }
}

local Configure = Class(function(self)
    self.options = {}
    self.options_active = {}
end)

function Configure:Init()
    local config = KnownModIndex:LoadModConfigurationOptions(modname)
    if not config then
        self.options = deepcopy(options)
        KnownModIndex:SaveConfigurationOptions(function() print("EventTimer: init configuration") end, modname, self.options)
    else
        --self.configuration_options = config
        self.options = deepcopy(config)
    end
    self.options_active = deepcopy(self.options)
end

function Configure:Get()
    return self.options_active
end

function Configure:GetById(id)
    local index
    for i,v in ipairs(self.options_active) do
        if v.id == id then
            index=i
            break
        end
    end
    if index then
        return self.options_active[index]
    else
        return nil
    end
end

function Configure:OnSwitch(id,value,dlc)
    local index
    for i,v in ipairs(self.options) do
        if v.id == id then
            index=i
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

function Configure:UpdateTimeValue(id,value)
    local index
    for i,v in ipairs(self.options) do
        if v.id == id then
            index=i
            break
        end
    end
    if index then
        self.options[index].time = value
    end
end

function Configure:Apply()
    self.options_active = deepcopy(self.options)
    KnownModIndex:SaveConfigurationOptions(function() print("EventTimer: apply configuration") end, modname, self.options)
end

function Configure:Reset()
    self.options = deepcopy(options)
    self.options_active = deepcopy(self.options)
    KnownModIndex:SaveConfigurationOptions(function() print("EventTimer: reset configuration") end, modname, self.options)
end

function Configure:Cancel()
    self.options = deepcopy(self.options_active)
end

return Configure