local _G = GLOBAL
local require = _G.require
local GetClock = _G.GetClock
local GetTime = _G.GetTime
local GetWorld = _G.GetWorld
local GetPlayer = _G.GetPlayer
local TUNING = _G.TUNING
local STRINGS = _G.STRINGS
local EntityScript = _G.EntityScript
local Ents = _G.Ents

local Define = require "define"
local InfoRule = require "inforule"
local InfoPanel = require "widgets/infopanel"
local loc = require "languages/loc"

local _infoPanel = nil
local _language = 0

local function addInfoPanel(self)
    _infoPanel = self:AddChild(InfoPanel())
    _language = loc.GetLanguage()
    InfoRule:SetInfoPanel(_infoPanel, _language)
end

local GetDisplayName = EntityScript.GetDisplayName

EntityScript.GetDisplayName = function(self,...)
    local name = GetDisplayName(self,...)
    if self._regenName then
        if self.components.inspectable.getstatus(self) == "WITHERED" then
            name = name .. "\nWITHERED"
        elseif self.components.pickable.paused then
            name = name .. "\nStop Growing"
        elseif self.components.pickable:CanBePicked() then
            name = name .. "\nPICKED"
        else
            local time = math.ceil(self.components.pickable.targettime - GetTime())
            name = name .. "\n" .. Define:timeFormat(time)
        end
    elseif self._fueledName then
        local time = math.ceil(self.components.fueled.currentfuel)
        name = name .. "\n" .. Define:timeFormat(time)
    end
    return name
end

function addNettleName(self)
    self._regenName = "Nettle"
end

function addSprinklerName(self)
    self._fueledName = "Sprinkler"
end

AddPrefabPostInit("nettle", addNettleName)

AddPrefabPostInit("sprinkler", addSprinklerName)

local _timeSpacing = 0.1

local function onTimer(player)
    player:DoPeriodicTask(_timeSpacing, function()
        if _infoPanel then
            local _world = GetWorld()
            local _player = GetPlayer()
            local _aporkalypse = _world.components.aporkalypse
            if _aporkalypse then InfoRule:AddAporkalypseTimer(_aporkalypse) end
            local _rocmanager = _world.components.rocmanager
            if _rocmanager then InfoRule:AddRocTimer(_rocmanager) end
            local _volcanomanager = _world.components.volcanomanager
            if _volcanomanager then InfoRule:AddVolcanomanagerTimer(_volcanomanager) end
            local _basehassler = _world.components.basehassler
            if _basehassler then InfoRule:AddBasehasslerTimer(_basehassler) end
            local _tigersharker = _world.components.tigersharker
            if _tigersharker then InfoRule:AddTigersharkerTimer(_tigersharker) end
            local _krakener = _player.components.krakener
            if _krakener then InfoRule:AddKrakenerTimer(_krakener) end
            local _hounded = _world.components.hounded
            if _hounded then InfoRule:AddHoundedTimer(_hounded) end
            local _batted = _world.components.batted
            if _batted then InfoRule:AddBattedTimer(_batted) end
        end
    end)
end

AddClassPostConstruct("widgets/controls", addInfoPanel)

AddSimPostInit(onTimer)