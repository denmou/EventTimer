Assets = {
    Asset("IMAGE", "images/customisation.tex" ),
    Asset("ATLAS", "images/customisation.xml" ),
    Asset("IMAGE", "images/customization_shipwrecked.tex" ),
    Asset("ATLAS", "images/customization_shipwrecked.xml" ),
    Asset("IMAGE", "images/customization_porkland.tex" ),
    Asset("ATLAS", "images/customization_porkland.xml" ),
    Asset("IMAGE", "images/ui.tex" ),
    Asset("ATLAS", "images/ui.xml" )
}

local _G = GLOBAL
local Define = _G.require "define"
local Noticebadge = _G.require "widgets/noticebadge"
local Loc = _G.require "languages/loc"

local BADGE_ROOT = nil
local REFRESH_TIME = GetModConfigData("RefreshTime")
local WARNING_TIME = GetModConfigData("WarningTime")
local IDIOM = GetModConfigData("Idiom")
local ABSCISSA = 20
local ORDINATE = -20
local ABSCISSA_SPACING = 210
local ORDINATE_SPACING = -31
local COLUMN_LENGTH = 5
local ROC_TIME = _G.TUNING.SEG_TIME/2
local BADGE_LIST = {}
local BADGE_INDEX = {}
local DISPLAY_TEXT = Define.english
local BAT_ATTACK = false

local function ChangeNoticeBadge()
    local _hideCount = 0
    for i = 1, #BADGE_INDEX do
        local _name = BADGE_INDEX[i]
        if not BADGE_LIST[_name].show then
            _hideCount = _hideCount + 1
        else
            local _abscissa = ABSCISSA + ABSCISSA_SPACING * math.floor((BADGE_LIST[_name].index - _hideCount) / COLUMN_LENGTH)
            local _ordinate = ORDINATE + ORDINATE_SPACING * ((BADGE_LIST[_name].index - _hideCount) % COLUMN_LENGTH)
            if BADGE_LIST[_name].abscissa ~= _abscissa or BADGE_LIST[_name].ordinate ~= _ordinate then
                BADGE_LIST[_name].badge:SetPosition(_abscissa, _ordinate)
                BADGE_LIST[_name].abscissa = _abscissa
                BADGE_LIST[_name].ordinate = _ordinate
            end
        end
    end
end

local function AddNoticeBadge(name)
    if BADGE_ROOT and not BADGE_LIST[name] then
        BADGE_LIST[name] = {
            index = #BADGE_INDEX,
            badge = BADGE_ROOT:AddChild(Noticebadge(name)),
            abscissa = 0,
            ordinate = 0,
            show = true
        }
        table.insert(BADGE_INDEX, name)
        ChangeNoticeBadge()
    end
end

local function HideNoticeBadge(name)
    if BADGE_ROOT and BADGE_LIST[name] and BADGE_LIST[name].show then
        BADGE_LIST[name].badge:Hide()
        BADGE_LIST[name].show = false
        ChangeNoticeBadge()
    end
end

local function ShowNoticeBadge(name)
    if BADGE_ROOT and BADGE_LIST[name] and not BADGE_LIST[name].show then
        BADGE_LIST[name].badge:Show()
        BADGE_LIST[name].show = true
        ChangeNoticeBadge()
    end
end

local function AporkalypsePostInit(self)
    local _name = "aporkalypse"
    self._cycleInterval = 60 * _G.TUNING.TOTAL_DAY_TIME
    self._seasonEnd = 0
    self.inst:DoPeriodicTask(REFRESH_TIME, function()
        if BADGE_ROOT then
            if not BADGE_LIST[_name] then
                AddNoticeBadge(_name)
            end
            local _totalTime = _G.GetClock():GetTotalTime()
            if self:IsActive() then
                ShowNoticeBadge(_name)
                local _normTime = _G.GetClock():GetNormTime()
                local _seasonManager = _G.GetSeasonManager()
                if self._seasonEnd == 0 then
                    self._seasonEnd = (_seasonManager.aporkalypse_length * (1 - _seasonManager.percent_season) - _normTime) * _G.TUNING.TOTAL_DAY_TIME + _totalTime
                end
                BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.end_in .. ": " .. Define:timeFormat(math.ceil(self._seasonEnd - _totalTime)))
            else
                local _waitTime = self.begin_date - _totalTime
                if _waitTime < WARNING_TIME then
                    ShowNoticeBadge(_name)
                    if self._seasonEnd ~= 0 then
                        self._seasonEnd = 0
                    end
                    BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.come .. ": " .. Define:timeFormat(math.ceil(_waitTime)))
                else
                    HideNoticeBadge(_name)
                end
            end
        end
    end)
end

local function RocmanagerPostInit(self)
    local _name = "roc"
    self._arriveTime = 0
    self.inst:DoPeriodicTask(REFRESH_TIME, function()
        if BADGE_ROOT then
            if not BADGE_LIST[_name] then
                AddNoticeBadge(_name)
            end
            local _totalTime = _G.GetClock():GetTotalTime()
            if self._arriveTime < _totalTime and self.nexttime > ROC_TIME then
                self._arriveTime = self.nexttime + _totalTime
            end
            if self.roc then
                ShowNoticeBadge(_name)
                if self.roc.components.roccontroller.inst.bodyparts and #self.roc.components.roccontroller.inst.bodyparts > 0 then
                    BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.forage)
                else
                    BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.land)
                end
            else
                local _waitTime = self._arriveTime - _totalTime
                if _waitTime < WARNING_TIME then
                    ShowNoticeBadge(_name)
                    if self._arriveTime < _totalTime then
                        BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.appear)
                    else
                        BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.come .. ": " .. Define:timeFormat(math.ceil(self._arriveTime - _totalTime)))
                    end
                else
                    HideNoticeBadge(_name)
                end
            end
        end
    end)
end

local function VolcanomanagerPostInit(self)
    local _name = "volcano"
    self.inst:DoPeriodicTask(REFRESH_TIME, function()
        if BADGE_ROOT then
            if not BADGE_LIST[_name] then
                AddNoticeBadge(_name)
            end
            if self:IsDormant() then
                HideNoticeBadge(_name)
            else
                if self:IsFireRaining() then
                    ShowNoticeBadge(_name)
                    BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.end_in .. ": " .. Define:timeFormat(math.ceil(self.firerain_timer)))
                else
                    local _eruptionSeg = self:GetNumSegmentsUntilEruption()
                    local _normtime = _G.GetClock():GetNormTime()
                    local _curSeg= _normtime * 16 % 1
                    local _waitTime = (_eruptionSeg - _curSeg) * _G.TUNING.SEG_TIME
                    if _waitTime < WARNING_TIME then
                        ShowNoticeBadge(_name)
                        BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.come .. ": " .. Define:timeFormat(math.ceil(_waitTime)))
                    else
                        HideNoticeBadge(_name)
                    end
                end
            end
        end
    end)
end

local function BasehasslerPostInit(self)
    self.inst:DoPeriodicTask(REFRESH_TIME, function()
        if self.hasslers then
            for _name,_boss in pairs(self.hasslers) do
                if not BADGE_LIST[_name] then
                    AddNoticeBadge(_name)
                end
                local _hassler = _G.TheSim:FindFirstEntityWithTag(_boss.prefab)
                if _hassler then
                    if not self._hassler then
                        ShowNoticeBadge(_name)
                        BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.rage)
                    end
                else
                    self._hassler = nil
                    local _state = self:GetHasslerState(_name)
                    if  _state == self.hassler_states.DORMANT then
                        HideNoticeBadge(_name)
    	    	    else
                        local _waitTime = math.ceil(_boss.timer)
                        if _state == self.hassler_states.WARNING then
                            ShowNoticeBadge(_name)
                            BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.attack .. ": " .. Define:timeFormat(math.ceil(_waitTime)))
                        elseif _state == self.hassler_states.WAITING then
                            if _waitTime < WARNING_TIME then
                                ShowNoticeBadge(_name)
                                BADGE_LIST[_name].badge.text:SetString("[" .. _boss.chance * 100 .. "%]" .. DISPLAY_TEXT.come .. ": " .. Define:timeFormat(math.ceil(_waitTime)))
                            else
                                HideNoticeBadge(_name)
                            end
                        end
                    end
                end
            end
        else
            local _name = self.hasslerprefab
            if not BADGE_LIST[_name] then
                AddNoticeBadge(_name)
            end
            local _hassler = _G.TheSim:FindFirstEntityWithTag(self.hasslerprefab)
            if _hassler then
                if not self._hassler then
                    ShowNoticeBadge(_name)
                    BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.rage)
                end
            else
                self._hassler = nil
                print()
                if not self.timetoattack then
                    HideNoticeBadge(_name)
                else
                    local _waitTime = math.ceil(self.timetoattack)
                    print(_waitTime)
                    if self.warning then
                        ShowNoticeBadge(_name)
                        BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.attack .. ": " .. Define:timeFormat(math.ceil(_waitTime)))
                    elseif _waitTime < WARNING_TIME then
                        ShowNoticeBadge(_name)
                        BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.come .. ": " .. Define:timeFormat(math.ceil(_waitTime)))
                    else
                        HideNoticeBadge(_name)
                    end
                end
            end
        end
    end)
end

local function TigersharkerPostInit(self)
    local _name = "tigershark"
    self.inst:DoPeriodicTask(REFRESH_TIME, function()
        if BADGE_ROOT then
            if not BADGE_LIST[_name] then
                AddNoticeBadge(_name)
            end
            if self.shark then
                ShowNoticeBadge(_name)
                BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.rage)
            else
                local _tag = "reset"
                local _respawnTime = self:TimeUntilRespawn()
                local _appearTime = self:TimeUntilCanAppear()
                local _waitTime = _respawnTime
                if _appearTime > _respawnTime then
                    _waitTime = _appearTime
                    _tag = "escape"
                end
                if _waitTime < WARNING_TIME then
                    ShowNoticeBadge(_name)
                    if _waitTime > 0 then
                        BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT[_tag] .. ": " .. Define:timeFormat(math.ceil(_waitTime)))
                    else
                        BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.ready)
                    end
                else
                    HideNoticeBadge(_name)
                end
            end
        end
    end)
end

local function KrakenerPostInit(self)
    local _name = "kraken"
    self.inst:DoPeriodicTask(REFRESH_TIME, function()
        if BADGE_ROOT then
            if not BADGE_LIST[_name] then
                AddNoticeBadge(_name)
            end
            if self.kraken then
                ShowNoticeBadge(_name)
                BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.rage)
            else
                local _waitTime = self:TimeUntilCanSpawn()
                if _waitTime < WARNING_TIME then
                    ShowNoticeBadge(_name)
                    if _waitTime > 0 then
                        BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.reset .. ": " .. Define:timeFormat(math.ceil(_waitTime)))
                    else
                        BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.ready)
                    end
                else
                    HideNoticeBadge(_name)
                end
            end
        end
    end)
end

local function HoundedPostInit(self)
    local _name = "hounds"
    self.inst:DoPeriodicTask(REFRESH_TIME, function()
        if BADGE_ROOT then
            if not BADGE_LIST[_name] then
                AddNoticeBadge(_name)
            end
            local _waitTime = self.timetoattack
            if _waitTime < WARNING_TIME then
                ShowNoticeBadge(_name)
                if _waitTime > 0 then
                    BADGE_LIST[_name].badge.text:SetString("[" .. self.houndstorelease .. "]" .. DISPLAY_TEXT.come .. ": " .. Define:timeFormat(math.ceil(_waitTime)))
                else
                    BADGE_LIST[_name].badge.text:SetString("[" .. self.houndstorelease .. "]" .. DISPLAY_TEXT.attack .. ": " .. Define:timeFormat(math.ceil(self.timetonexthound)))
                end
            else
                HideNoticeBadge(_name)
            end
        end
    end)
end

local function BattedPostInit(self)
    local _name = "vampire_bats"
    self._batsCount = 0
    local _DoBatAttack = self.DoBatAttack
    self.DoBatAttack = function(inst,...)
        if #self.batstoattack > 0 then
            self._batsCount = self._batsCount + #self.batstoattack
            BAT_ATTACK = true
        end
        _DoBatAttack(inst,...)
    end
    self.inst:ListenForEvent("_vampire_bat_attacked", function(inst, data) 
        self._batsCount = 0
    end)
    self.inst:DoPeriodicTask(REFRESH_TIME, function()
        if BADGE_ROOT then
            if not BADGE_LIST[_name] then
                AddNoticeBadge(_name)
            end
            local _waitTime = self.timetoattack
            if _waitTime < WARNING_TIME then
                ShowNoticeBadge(_name)
                if BAT_ATTACK then
                    local _count = self._batsCount
                    BADGE_LIST[_name].badge.text:SetString("[" .. _count .. "]" .. DISPLAY_TEXT.circle)
                else
                    BADGE_LIST[_name].badge.text:SetString("[" .. self:CountBats() .. "]" .. DISPLAY_TEXT.come .. ": " .. Define:timeFormat(math.ceil(_waitTime)))
                end
            else
                HideNoticeBadge(_name)
            end
        end
    end)
end

local function VampirebatPrefabPostInit(inst)
    inst:ListenForEvent("attacked", function()
        BAT_ATTACK = false
    end)
end

local function HayfeverPostInit(self)
    local _name = "hayfever"
    self.inst:DoPeriodicTask(REFRESH_TIME, function()
        if BADGE_ROOT then
            if not BADGE_LIST[_name] then
                AddNoticeBadge(_name)
            end
            local _waitTime = self.nextsneeze
            if _waitTime < WARNING_TIME and self.enabled then
                ShowNoticeBadge(_name)
                BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.sneeze .. ": " .. Define:timeFormat(math.ceil(_waitTime)))
            else
                HideNoticeBadge(_name)
            end
        end
    end)
end

local function PugaliskFountainPrefabPostInit(inst) 
    inst._resetTime = 0
    local _name = "pugalisk_fountain"
    inst:DoPeriodicTask(REFRESH_TIME, function()
        if BADGE_ROOT then
            if not BADGE_LIST[_name] then
                AddNoticeBadge(_name)
            end
            if inst.dry then
                if inst.resettaskinfo then
                    if not inst._resetTimeTask then
                        inst._resetTime = inst.resettaskinfo.time
                        inst._resetTimeTask = inst:DoPeriodicTask(REFRESH_TIME, function()
                            inst._resetTime = inst._resetTime - REFRESH_TIME
                            if inst._resetTime <= 0 then
                                inst._resetTimeTask:Cancel()
                                inst._resetTimeTask = nil
                            end
                        end)
                    end
                    BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.reset .. ": " .. Define:timeFormat(math.ceil(inst._resetTime)))
                else
                    BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.dry)
                end
            else
                BADGE_LIST[_name].badge.text:SetString(DISPLAY_TEXT.flow)
            end
        end
    end)
end

local function ControlsPostConstruct(self)
    if not BADGE_ROOT then
        BADGE_ROOT = self.left_root
        if IDIOM then 
            DISPLAY_TEXT = Define.idiom
        else
            local _language = Loc.GetLanguage()
	        if _language >= 21 and _language <= 23 then
	        	DISPLAY_TEXT = Define.chinese
            end
        end
    end
end

local GetDisplayName = _G.EntityScript.GetDisplayName

_G.EntityScript.GetDisplayName = function(self,...)
    local _name = GetDisplayName(self,...)
    if GetModConfigData("GrowthTime") and self.components and self.components.pickable and self.components.pickable.targettime then
        if self.components.inspectable and self.components.inspectable:GetStatus(self) == "WITHERED" then
            _name = _name .. "\nWITHERED"
        elseif self.components.pickable.paused then
            _name = _name .. "\nStop Growing"
        elseif self.components.pickable:CanBePicked() then
            _name = _name .. "\nPICKED"
        else
            local _currentTime = math.ceil(self.components.pickable.targettime - _G.GetTime())
            _name = _name .. "\n" .. Define:timeFormat(_currentTime)
        end
    elseif GetModConfigData("FuelTime") and self.components and self.components.fueled then
        local _currentTime = math.ceil(self.components.fueled.currentfuel)
        local _maxTime = math.ceil(self.components.fueled.maxfuel)
        _name = _name .. "\n" .. Define:timeFormat(_currentTime) .. "/" .. Define:timeFormat(_maxTime)
    end
    return _name
end

AddClassPostConstruct("widgets/controls", ControlsPostConstruct)
if GetModConfigData("Aporkalypse") then
    AddComponentPostInit("aporkalypse", AporkalypsePostInit)
end
if GetModConfigData("Roc") then
    AddComponentPostInit("rocmanager", RocmanagerPostInit)
end
if GetModConfigData("Volcano") then
    AddComponentPostInit("volcanomanager", VolcanomanagerPostInit)
end
if GetModConfigData("SeasonBoss") then
    AddComponentPostInit("basehassler", BasehasslerPostInit)
end
if GetModConfigData("Tigershark") then
    AddComponentPostInit("tigersharker", TigersharkerPostInit)
end
if GetModConfigData("Kraken") then
    AddComponentPostInit("krakener", KrakenerPostInit)
end
if GetModConfigData("Hound") then
    AddComponentPostInit("hounded", HoundedPostInit)
end
if GetModConfigData("Bat") then
    AddPrefabPostInit("vampirebat", VampirebatPrefabPostInit)
    AddComponentPostInit("batted", BattedPostInit)
end
if GetModConfigData("HayfeverTime") then
    AddComponentPostInit("hayfever", HayfeverPostInit)
end
if GetModConfigData("PugaliskFountain") then
    AddPrefabPostInit("pugalisk_fountain", PugaliskFountainPrefabPostInit)
end