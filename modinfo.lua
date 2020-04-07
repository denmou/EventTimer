--[NEW] The name of the mod displayed in the 'mods' screen.
name = 'Event Timer'

--[NEW] A description of the mod.
description = '显示游戏事件的剩余时间\n—By Google Translate\nShow the remaining time for game events'

--[NEW] Who wrote this awesome mod?
author = 'Denmou'

--[NEW] A version number so you can ask people if they are running an old version of your mod.
version = '2.3.2'

--[NEW] This lets other players know if your mod is out of date.  This typically needs to be updated every time there's a new game update.
api_version = 6

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true

icon_atlas = 'modicon.xml'
icon = 'modicon.tex'

configuration_options = {
    {
        name = 'Rows',
        label = 'Rows',
        hover = 'Number of rows per column',
        options = {
            {description = '1', data = 1},
            {description = '2', data = 2},
            {description = '3', data = 3},
            {description = '4', data = 4},
            {description = '5', data = 5},
            {description = '6', data = 6},
            {description = '7', data = 7},
            {description = '8', data = 8},
            {description = '9', data = 9}
        },
        default = 5
    },
    {
        name = 'Multiplier',
        label = 'Display multiplier',
        hover = 'Display multiplier',
        options = {
            {description = '0.5', data = 0.5},
            {description = '0.6', data = 0.6},
            {description = '0.7', data = 0.7},
            {description = '0.8', data = 0.8},
            {description = '0.9', data = 0.9},
            {description = '1.0', data = 1},
            {description = '1.1', data = 1.1},
            {description = '1.2', data = 1.2},
            {description = '1.3', data = 1.3},
            {description = '1.4', data = 1.4},
            {description = '1.5', data = 1.5},
            {description = '1.6', data = 1.6},
            {description = '1.7', data = 1.7},
            {description = '1.8', data = 1.8},
            {description = '1.9', data = 1.9},
            {description = '2.0', data = 2},
            {description = '2.1', data = 2.1},
            {description = '2.2', data = 2.2},
            {description = '2.3', data = 2.3},
            {description = '2.4', data = 2.4},
            {description = '2.5', data = 2.5},
            {description = '2.6', data = 2.6},
            {description = '2.7', data = 2.7},
            {description = '2.8', data = 2.8},
            {description = '2.9', data = 2.9},
            {description = '3.0', data = 3}
        },
        default = 1
    },
    {
        name = 'FontMultiplier',
        label = 'Font multiplier',
        hover = 'Font multiplier',
        options = {
            {description = '0.5', data = 0.5},
            {description = '0.6', data = 0.6},
            {description = '0.7', data = 0.7},
            {description = '0.8', data = 0.8},
            {description = '0.9', data = 0.9},
            {description = '1.0', data = 1},
            {description = '1.1', data = 1.1},
            {description = '1.2', data = 1.2},
            {description = '1.3', data = 1.3},
            {description = '1.4', data = 1.4},
            {description = '1.5', data = 1.5},
            {description = '1.6', data = 1.6},
            {description = '1.7', data = 1.7},
            {description = '1.8', data = 1.8},
            {description = '1.9', data = 1.9},
            {description = '2.0', data = 2},
        },
        default = 1
    },
    {
        name = 'RefreshTime',
        label = 'Refresh Time',
        hover = 'Refresh time of data display',
        options = {
            {description = '100ms', data = 0.1},
            {description = '200ms', data = 0.2},
            {description = '500ms', data = 0.5},
            {description = '1s', data = 1}
        },
        default = 0.2
    },
    {
        name = 'WarningTime',
        label = 'Warning Time',
        hover = 'How much time is left to initiate an alert.',
        options = {
            {description = '10min', data = 600},
            {description = '20min', data = 1200},
            {description = '30min', data = 1800},
            {description = '40min', data = 2400},
            {description = '50min', data = 3000},
            {description = '60min', data = 3600},
            {description = '120min', data = 7200}
        },
        default = 2400
    },
    {
        name = 'Idiom',
        label = 'Idiom',
        hover = 'Display idioms.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = false
    },
    {
        name = 'Aporkalypse',
        label = 'Aporkalypse',
        hover = 'Display Aporkalypse.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'Roc',
        label = 'Roc',
        hover = 'Display Roc.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'Volcano',
        label = 'Volcano',
        hover = 'Display Volcano.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'SeasonBoss',
        label = 'Season Boss',
        hover = 'Display Season Boss.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'Tigershark',
        label = 'Tigershark',
        hover = 'Display Tigershark.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'Kraken',
        label = 'Kraken',
        hover = 'Display Kraken.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'SWOnly',
        label = 'SW Only Self',
        hover = 'Just show item of SW in shipwrecked.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = false
    },
    {
        name = 'Hound',
        label = 'Hound',
        hover = 'Display Hound.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'Bat',
        label = 'Bat',
        hover = 'Display Bat.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'HayfeverTime',
        label = 'Hayfever Time',
        hover = 'Display hayfever time.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'ChessMonsters',
        label = 'Chess Monsters',
        hover = 'Chess Monsters Refresh time.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'PugaliskFountain',
        label = 'Pugalisk Fountain',
        hover = 'Display pugalisk fountain time.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'Worm',
        label = 'Depths Worm',
        hover = 'Display depths worm time.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'LocoMotor',
        label = 'LocoMotor Stage',
        hover = 'Display locoMotor stage time.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'NightmareClock',
        label = 'Nightmare Phase',
        hover = 'Display nightmare phase time.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'GrowthTime',
        label = 'Growth Time',
        hover = 'Display growth time.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'FuelTime',
        label = 'Fuel Time',
        hover = 'Display fuel time.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    },
    {
        name = 'WX78',
        label = 'WX78 Charge',
        hover = 'Display wx78 charge time.',
        options = {
            {description = 'TRUE', data = true},
            {description = 'FALSE', data = false}
        },
        default = true
    }
}

forumthread = ''
