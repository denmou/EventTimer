--[NEW] The name of the mod displayed in the 'mods' screen.
name = "Event Timer"

--[NEW] A description of the mod.
description = "Show event timer"

--[NEW] Who wrote this awesome mod?
author = "Denmou"

--[NEW] A version number so you can ask people if they are running an old version of your mod.
version = "2.2.8"

--[NEW] This lets other players know if your mod is out of date.  This typically needs to be updated every time there's a new game update.
api_version = 6

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{
	{
		name = "Idiom",
		label = "Idiom",
		hover = "Display idioms.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = false,
	},
	{
		name = "RefreshTime",
		label = "Refresh Time",
		hover = "Refresh time of data display",
		options = {
			{ description = "100ms", data = 0.1 },
			{ description = "200ms", data = 0.2 },
			{ description = "500ms", data = 0.5 },
			{ description = "1s", data = 1 }
		},
		default = 0.2,
	},
	{
		name = "WarningTime",
		label = "Warning Time",
		hover = "How much time is left to initiate an alert.",
		options = {
			{ description = "10min", data = 600 },
			{ description = "20min", data = 1200 },
			{ description = "30min", data = 1800 },
			{ description = "40min", data = 2400 },
			{ description = "50min", data = 3000 },
			{ description = "60min", data = 3600 },
			{ description = "120min", data = 7200 }
		},
		default = 2400,
	},
	{
		name = "Aporkalypse",
		label = "Aporkalypse",
		hover = "Display Aporkalypse.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "Roc",
		label = "Roc",
		hover = "Display Roc.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "Volcano",
		label = "Volcano",
		hover = "Display Volcano.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "SeasonBoss",
		label = "Season Boss",
		hover = "Display Season Boss.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "Tigershark",
		label = "Tigershark",
		hover = "Display Tigershark.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "Kraken",
		label = "Kraken",
		hover = "Display Kraken.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "SWOnly",
		label = "SW Only Self",
		hover = "Just show item of SW in shipwrecked.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = false,
	},
	{
		name = "Hound",
		label = "Hound",
		hover = "Display Hound.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "Bat",
		label = "Bat",
		hover = "Display Bat.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "HayfeverTime",
		label = "Hayfever Time",
		hover = "Display hayfever time.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "ChessMonsters",
		label = "Chess Monsters",
		hover = "Chess Monsters Refresh time.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "PugaliskFountain",
		label = "Pugalisk Fountain",
		hover = "Display pugalisk fountain time.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "Worm",
		label = "Depths Worm",
		hover = "Display depths worm time.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "LocoMotor",
		label = "LocoMotor Stage",
		hover = "Display locoMotor stage time.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "NightmareClock",
		label = "Nightmare Phase",
		hover = "Display nightmare phase time.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "GrowthTime",
		label = "Growth Time",
		hover = "Display growth time.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "FuelTime",
		label = "Fuel Time",
		hover = "Display fuel time.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	},
	{
		name = "WX78",
		label = "WX78 Charge",
		hover = "Display wx78 charge time.",
		options = {
			{ description = "TRUE", data = true },
			{ description = "FALSE", data = false }
		},
		default = true,
	}
}

forumthread = ""