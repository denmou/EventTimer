Assets = {
    Asset('IMAGE', 'images/customisation.tex'),
    Asset('ATLAS', 'images/customisation.xml'),
    Asset('IMAGE', 'images/customization_shipwrecked.tex'),
    Asset('ATLAS', 'images/customization_shipwrecked.xml'),
    Asset('IMAGE', 'images/customization_porkland.tex'),
    Asset('ATLAS', 'images/customization_porkland.xml'),
    Asset('IMAGE', 'images/customisation_dst.tex'),
    Asset('ATLAS', 'images/customisation_dst.xml'),
    Asset('IMAGE', 'images/ui.tex'),
    Asset('ATLAS', 'images/ui.xml'),
    Asset('IMAGE', 'images/inventoryimages.tex'),
    Asset('ATLAS', 'images/inventoryimages.xml'),
    Asset('IMAGE', 'images/inventoryimages_2.tex'),
    Asset('ATLAS', 'images/inventoryimages_2.xml'),
    Asset('IMAGE', 'images/resources.tex'),
    Asset('ATLAS', 'images/resources.xml')
}

local _G = GLOBAL
local Define = require 'define'
local Noticebadge = require 'widgets/noticebadge'
local Loc = require 'languages/loc'

local BADGE_ROOT = nil
local REFRESH_TIME = g_func_mod_config('RefreshTime')
local g_str_warning_time = g_func_mod_config('WarningTime')

local g_obj_items = {}
local ABSCISSA = 20
local ORDINATE = -20
local ABSCISSA_SPACING = 210
local ORDINATE_SPACING = -31
local COLUMN_LENGTH = 5
local ROC_TIME = TUNING.SEG_TIME / 2
local BADGE_LIST = {}
local BADGE_INDEX = {}
local g_obj_constant = Define.english
local BAT_ATTACK = false

local function AporkalypsePostInit(self)
    if g_func_mod_config('Aporkalypse') then
        local name = 'aporkalypse'
        g_obj_control.add(name)
        self._seasonEnd = 0
        self._eventTimer = function()
            local _totalTime = GetClock():GetTotalTime()
            if self:IsActive() then
                local _normTime = GetClock():GetNormTime()
                local _seasonManager = GetSeasonManager()
                if self._seasonEnd == 0 then
                    self._seasonEnd =
                        (_seasonManager.aporkalypse_length * (1 - _seasonManager.percent_season) - _normTime) *
                        TUNING.TOTAL_DAY_TIME +
                        _totalTime
                end
                g_obj_control.set(
                    name,
                    g_obj_constant.end_in .. ': ' .. g_obj_utils.timeFormat(math.ceil(self._seasonEnd - _totalTime))
                )
            else
                local waitTime = self.begin_date - _totalTime
                if waitTime < g_str_warning_time then
                    if self._seasonEnd ~= 0 then
                        self._seasonEnd = 0
                    end
                    g_obj_control.set(name, g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                else
                    g_obj_control.hide(name)
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

local function RocmanagerPostInit(self)
    if g_func_mod_config('Roc') then
        local name = 'roc'
        self._arriveTime = 0
        self._eventTimer = function()
            g_obj_control.add(name)
            local _totalTime = GetClock():GetTotalTime()
            if self._arriveTime < _totalTime and self.nexttime > ROC_TIME then
                self._arriveTime = self.nexttime + _totalTime
            end
            if self.roc then
                if
                    self.roc.components.roccontroller.inst.bodyparts and
                        #self.roc.components.roccontroller.inst.bodyparts > 0
                 then
                    g_obj_control.set(name, g_obj_constant.forage)
                else
                    g_obj_control.set(name, g_obj_constant.land)
                end
            else
                local waitTime = self._arriveTime - _totalTime
                if waitTime < g_str_warning_time then
                    if self._arriveTime < _totalTime then
                        g_obj_control.set(name, g_obj_constant.appear)
                    else
                        g_obj_control.set(
                            name,
                            g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(self._arriveTime - _totalTime))
                        )
                    end
                else
                    g_obj_control.hide(name)
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

local function VolcanomanagerPostInit(self)
    if g_func_mod_config('Volcano') then
        local name = 'volcano'
        self._eventTimer = function()
            g_obj_control.add(name)
            if self:IsDormant() then
                g_obj_control.hide(name)
            else
                if self:IsFireRaining() then
                    g_obj_control.set(
                        name,
                        g_obj_constant.end_in .. ': ' .. g_obj_utils.timeFormat(math.ceil(self.firerain_timer))
                    )
                else
                    local _eruptionSeg = self:GetNumSegmentsUntilEruption()
                    if _eruptionSeg then
                        local _normtime = GetClock():GetNormTime()
                        local _curSeg = _normtime * 16 % 1
                        local waitTime = (_eruptionSeg - _curSeg) * TUNING.SEG_TIME
                        if waitTime < g_str_warning_time then
                            g_obj_control.set(
                                name,
                                g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                            )
                        else
                            g_obj_control.hide(name)
                        end
                    end
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

local function BasehasslerPostInit(self)
    if g_func_mod_config('SeasonBoss') then
        self._eventTimer = function()
            if self.hasslers then
                for name, _boss in pairs(self.hasslers) do
                    g_obj_control.add(name)
                    local _hassler = TheSim:FindFirstEntityWithTag(_boss.prefab)
                    if _hassler then
                        if not self._hassler then
                            g_obj_control.set(name, g_obj_constant.rage)
                        end
                    else
                        self._hassler = nil
                        local _state = self:GetHasslerState(name)
                        if _state == self.hassler_states.DORMANT then
                            g_obj_control.hide(name)
                        else
                            local waitTime = math.ceil(_boss.timer)
                            if _state == self.hassler_states.WARNING then
                                g_obj_control.set(
                                    name,
                                    g_obj_constant.attack .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                                )
                            elseif _state == self.hassler_states.WAITING then
                                if waitTime < g_str_warning_time then
                                    g_obj_control.set(
                                        name,
                                        '[' ..
                                            _boss.chance * 100 ..
                                                '%]' ..
                                                    g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                                    )
                                else
                                    g_obj_control.hide(name)
                                end
                            end
                        end
                    end
                end
            else
                local name = self.hasslerprefab
                g_obj_control.add(name)
                local _hassler = TheSim:FindFirstEntityWithTag(self.hasslerprefab)
                if _hassler then
                    if not self._hassler then
                        g_obj_control.set(name, g_obj_constant.rage)
                    end
                else
                    self._hassler = nil
                    print()
                    if not self.timetoattack then
                        g_obj_control.hide(name)
                    else
                        local waitTime = math.ceil(self.timetoattack)
                        print(waitTime)
                        if self.warning then
                            g_obj_control.set(
                                name,
                                g_obj_constant.attack .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                            )
                        elseif waitTime < g_str_warning_time then
                            g_obj_control.set(
                                name,
                                g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                            )
                        else
                            g_obj_control.hide(name)
                        end
                    end
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

local function TigersharkerPostInit(self)
    if g_func_mod_config('Tigershark') then
        local name = 'tigershark'
        self._eventTimer = function()
            g_obj_control.add(name)
            if self.shark then
                g_obj_control.set(name, g_obj_constant.rage)
            else
                local _tag = 'reset'
                local _respawnTime = self:TimeUntilRespawn()
                local _appearTime = self:TimeUntilCanAppear()
                local waitTime = _respawnTime
                if _appearTime > _respawnTime then
                    waitTime = _appearTime
                    _tag = 'escape'
                end
                if waitTime < g_str_warning_time then
                    if waitTime > 0 then
                        g_obj_control.set(name, g_obj_constant[_tag] .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                    else
                        g_obj_control.set(name, g_obj_constant.ready)
                    end
                else
                    g_obj_control.hide(name)
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

local function KrakenerPostInit(self)
    local WORLD = SaveGameIndex:GetCurrentMode()
    if g_func_mod_config('Kraken') and not g_func_mod_config('SWOnly') or WORLD == 'shipwrecked' then
        local name = 'kraken'
        self._eventTimer = function()
            g_obj_control.add(name)
            if self.kraken then
                g_obj_control.set(name, g_obj_constant.rage)
            else
                local waitTime = self:TimeUntilCanSpawn()
                if waitTime < g_str_warning_time then
                    if waitTime > 0 then
                        g_obj_control.set(name, g_obj_constant.reset .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
                    else
                        g_obj_control.set(name, g_obj_constant.ready)
                    end
                else
                    g_obj_control.hide(name)
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

local function HoundedPostInit(self)
    if g_func_mod_config('Hound') then
        local name = 'hounds'
        self._eventTimer = function()
            g_obj_control.add(name)
            local waitTime = self.timetoattack
            if waitTime < g_str_warning_time then
                if waitTime > 0 then
                    g_obj_control.set(
                        name,
                        '[' ..
                            self.houndstorelease ..
                                ']' .. g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                    )
                else
                    g_obj_control.set(
                        name,
                        '[' ..
                            self.houndstorelease ..
                                ']' .. g_obj_constant.attack .. ': ' .. g_obj_utils.timeFormat(math.ceil(self.timetonexthound))
                    )
                end
            else
                g_obj_control.hide(name)
            end
        end
        table.insert(g_obj_items, self)
    end
end

local function BattedPostInit(self)
    if g_func_mod_config('Bat') then
        local name = 'vampire_bats'
        self._batsCount = 0
        local _DoBatAttack = self.DoBatAttack
        self.DoBatAttack = function(inst, ...)
            self._batsCount = #self.batstoattack
            BAT_ATTACK = true
            _DoBatAttack(inst, ...)
        end
        self._eventTimer = function()
            g_obj_control.add(name)
            local waitTime = self.timetoattack
            if waitTime < g_str_warning_time then
                if BAT_ATTACK then
                    g_obj_control.set(name, '[' .. self._batsCount .. ']' .. g_obj_constant.circle)
                else
                    g_obj_control.set(
                        name,
                        '[' ..
                            self:CountBats() ..
                                ']' .. g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                    )
                end
            else
                g_obj_control.hide(name)
            end
        end
        table.insert(g_obj_items, self)
    end
end

local function VampirebatPrefabPostInit(inst)
    inst:ListenForEvent(
        'wingdown',
        function()
            BAT_ATTACK = false
        end
    )
end

local function HayfeverPostInit(self)
    if g_func_mod_config('HayfeverTime') then
        local name = 'hayfever'
        self._eventTimer = function()
            g_obj_control.add(name)
            local waitTime = self.nextsneeze
            if waitTime < g_str_warning_time and self.enabled then
                g_obj_control.set(name, g_obj_constant.sneeze .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime)))
            else
                g_obj_control.hide(name)
            end
        end
        table.insert(g_obj_items, self)
    end
end

local function PugaliskFountainPrefabPostInit(inst)
    if g_func_mod_config('PugaliskFountain') then
        inst._resetTime = 0
        local name = 'pugalisk_fountain'
        inst._eventTimer = function()
            g_obj_control.add(name)
            if inst.dry then
                if inst.resettaskinfo then
                    if not inst._resetTimeTask then
                        inst._resetTime = inst.resettaskinfo.time
                        inst._resetTimeTask =
                            inst:DoPeriodicTask(
                            REFRESH_TIME,
                            function()
                                inst._resetTime = inst._resetTime - REFRESH_TIME
                                if inst._resetTime <= 0 then
                                    inst._resetTimeTask:Cancel()
                                    inst._resetTimeTask = nil
                                end
                            end
                        )
                    end
                    g_obj_control.set(
                        name,
                        g_obj_constant.reset .. ': ' .. g_obj_utils.timeFormat(math.ceil(inst._resetTime))
                    )
                else
                    g_obj_control.set(name, g_obj_constant.dry)
                end
            else
                g_obj_control.set(name, g_obj_constant.flow)
            end
        end
        table.insert(g_obj_items, inst)
    end
end

local function ChessNavyPostInit(self)
    local WORLD = SaveGameIndex:GetCurrentMode()
    if g_func_mod_config('ChessMonsters') and not g_func_mod_config('SWOnly') or WORLD == 'shipwrecked' then
        local name = 'chess_monsters'
        self._eventTimer = function()
            g_obj_control.add(name)
            local waitTime = self.spawn_timer
            if waitTime and waitTime >= 0 then
                local _text = g_obj_constant.sleep
                if waitTime > 0 then
                    _text = g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                end

                g_obj_control.set(name, _text)
            else
                g_obj_control.hide(name)
            end
        end
        table.insert(g_obj_items, self)
    end
end

local function PeriodicThreatPostInit(self)
    if g_func_mod_config('Worm') then
        local name = 'worms'
        self._eventTimer = function()
            g_obj_control.add(name)
            local worm = self.threats['WORM']
            if worm then
                local waitTime = worm.timer
                local _text = nil
                if waitTime < g_str_warning_time then
                    if worm.state == 'wait' then
                        _text = g_obj_constant.come .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                    elseif worm.state == 'warn' then
                        _text = g_obj_constant.attack .. ': ' .. g_obj_utils.timeFormat(math.ceil(waitTime))
                    elseif worm.state == 'event' then
                        _text = g_obj_constant.generate .. ': ' .. math.floor(worm.numspawned)
                    end
                end
                if _text then
                    g_obj_control.set(name, _text)
                else
                    g_obj_control.hide(name)
                end
            end
        end
        table.insert(g_obj_items, self)
    end
end

local function ControlsPostConstruct(self)
    if not BADGE_ROOT then
        BADGE_ROOT = self.left_root
        if g_func_mod_config('Idiom') then
            g_obj_constant = Define.idiom
        else
            local _language = Loc.GetLanguage()
            if _language >= 21 and _language <= 23 then
                g_obj_constant = Define.chinese
            end
        end
    end
end

local GetDisplayName = EntityScript.GetDisplayName

EntityScript.GetDisplayName = function(self, ...)
    local name = GetDisplayName(self, ...)
    if
        g_func_mod_config('GrowthTime') and self.components and self.components.pickable and
            self.components.pickable.targettime
     then
        if self.components.inspectable and self.components.inspectable:GetStatus(self) == 'WITHERED' then
            name = name .. '\n' .. g_obj_constant.wither
        elseif self.components.pickable.paused then
            name = name .. '\n' .. g_obj_constant.stop_grow
        elseif self.components.pickable:CanBePicked() then
            name = name .. '\n' .. g_obj_constant.pick
        else
            local _currentTime = math.ceil(self.components.pickable.targettime - GetTime())
            name = name .. '\n' .. g_obj_utils.timeFormat(_currentTime)
        end
    elseif g_func_mod_config('FuelTime') and self.components and self.components.fueled then
        local _currentTime = math.ceil(self.components.fueled.currentfuel)
        local _maxTime = math.ceil(self.components.fueled.maxfuel)
        name = name .. '\n' .. g_obj_utils.timeFormat(_currentTime) .. '/' .. g_obj_utils.timeFormat(_maxTime)
    end
    return name
end

AddClassPostConstruct('widgets/controls', ControlsPostConstruct)
g_func_component_init('krakener', KrakenerPostInit)
g_func_component_init('aporkalypse', AporkalypsePostInit)
g_func_component_init('rocmanager', RocmanagerPostInit)
g_func_component_init('volcanomanager', VolcanomanagerPostInit)
g_func_component_init('basehassler', BasehasslerPostInit)
g_func_component_init('tigersharker', TigersharkerPostInit)
g_func_component_init('hounded', HoundedPostInit)
g_func_component_init('hayfever', HayfeverPostInit)
g_func_prefab_init('pugalisk_fountain', PugaliskFountainPrefabPostInit)
g_func_component_init('chessnavy', ChessNavyPostInit)
g_func_prefab_init('vampirebat', VampirebatPrefabPostInit)
g_func_component_init('batted', BattedPostInit)
g_func_component_init('periodicthreat', PeriodicThreatPostInit)

AddSimPostInit(
    function(player)
        player:DoPeriodicTask(
            REFRESH_TIME,
            function()
                if BADGE_ROOT then
                    for i = 1, #g_obj_items do
                        g_obj_items[i]:_eventTimer()
                    end
                end
            end
        )
    end
)
