local Define = require "define"

local _rocTime = TUNING.SEG_TIME/2

local InfoRule = {
	infoPanel = nil,
	constants = nil
}

function InfoRule:SetInfoPanel(_infoPanel, _language)
	self.infoPanel = _infoPanel
	if _language >= 21 and _language <= 23 then
		self.constants = Define.chinese
	else
		self.constants = Define.english
	end
end

function InfoRule:AddAporkalypseTimer(inst)
    local node = self.constants.aporkalypse
    local aporkalypse_time = inst:GetBeginDate()
    local time = GetClock():GetTotalTime()
    time =  math.ceil(aporkalypse_time - time)
	local aporkalypse_text = node .. ": "
	local color = 0
    if time < 0 then
		aporkalypse_text = aporkalypse_text .. self.constants.happening
		color = 1
    else 
		aporkalypse_text = aporkalypse_text .. Define:timeFormat(time)
		if time < 120 then
			color = 4
		elseif time < 600 then
			color = 3
		end
    end
    self.infoPanel:setText(node, aporkalypse_text, color, 0)
end

function InfoRule:AddRocTimer(inst)
    local node = "roc"
    local totalTime = GetClock():GetTotalTime()
    if not inst._arriveTime or (inst._arriveTime < totalTime and inst.nexttime > _rocTime) then
        inst._arriveTime = inst.nexttime + totalTime
    end
    local roc_text = STRINGS.UI.CUSTOMIZATIONSCREEN.NAMES[string.upper(node)] .. ": "
    local color = 0
	if inst.roc then
		for k,v in pairs(inst.roc) do
			print(k)
		end
        roc_text = roc_text .. self.constants.landing
        color = 4
    elseif inst._arriveTime < totalTime then
        roc_text = roc_text .. self.constants.coming
        color = 3
    else
        local time = math.ceil(inst._arriveTime - totalTime)
        roc_text = roc_text .. Define:timeFormat(time)
        if time <= 120 then
            color = 3
        end
    end
    self.infoPanel:setText(node, roc_text, color, 1)
end

function InfoRule:AddBasehasslerTimer(inst)
    for name,boss in pairs(inst.hasslers) do
        local hassler_text = STRINGS.NAMES[string.upper(name)]
		if not boss._overload then
			boss._overload = 1
			local _onspawnfn = boss.onspawnfn
			boss._GUID = nil
			boss.onspawnfn = function(selfInst, ...)
				boss._GUID = selfInst.GUID
				if _onspawnfn ~= nil then
					return _onspawnfn(selfInst, ...)
				end
			end
		end
		if boss._GUID and not Ents[boss._GUID] then
			boss._GUID = nil
		end
		local state = inst:GetHasslerState(name)
		if boss._GUID then
			hassler_text = hassler_text .. ": " .. self.constants.appearing
			self.infoPanel:setText(name, hassler_text, 1, 2)
        elseif state == inst.hassler_states.DORMANT then
			self.infoPanel:removeText(name)
		else
			local color = 0
            local time = math.ceil(boss.timer)
            if state == inst.hassler_states.WARNING then
				hassler_text = hassler_text .. " [" .. self.constants.attacking .. "]: " .. Define:timeFormat(time)
				color = 4
            elseif state == inst.hassler_states.WAITING then
				hassler_text = hassler_text .. "[" .. boss.chance * 100 .. "%]: " .. Define:timeFormat(time)
				if time <= 120 then
					color = 3
				end
            end
            self.infoPanel:setText(name, hassler_text, color, 2)
        end
    end
end

function InfoRule:AddVolcanomanagerTimer(inst)
    local node = "volcano"
    if inst:IsDormant() then
        self.infoPanel:removeText(node)
    else
        local volcano_text = STRINGS.NAMES[string.upper(node)]
        local color = 0
        if inst:IsFireRaining() then
            time = math.ceil(inst.firerain_timer)
            volcano_text = volcano_text .. " [" .. self.constants.endIn .. "]: " .. Define:timeFormat(time)
            color = 1
        else
            local eruptionSeg = inst:GetNumSegmentsUntilEruption()
            if not eruptionSeg then return end
	        local clock = GetClock()
            local normtime = clock:GetNormTime()
            local curSeg= normtime * 16 % 1
			local time = (eruptionSeg - curSeg) * TUNING.SEG_TIME
			if time <= 120 then
				color = 4
			elseif time <= 300 then
				color = 3
			end
            volcano_text = volcano_text .. ": " .. Define:timeFormat(math.ceil(time))
        end
        self.infoPanel:setText("volcano", volcano_text, color, 1)
    end
end

function InfoRule:AddTigersharkerTimer(inst)
    local node = "tigershark"
    local tigersharker_text = STRINGS.NAMES[string.upper(node)] .. ": "
    local color = 0
    if inst.shark then
        tigersharker_text = tigersharker_text .. self.constants.appearing
        color = 1
    else
        local respawnTime = inst:TimeUntilRespawn()
        local appearTime = inst:TimeUntilCanAppear()
        local time = respawnTime
        if appearTime > respawnTime then
            time = appearTime
        end
        if time > 0 then
            tigersharker_text = tigersharker_text .. Define:timeFormat(math.ceil(time))
        else
            tigersharker_text = tigersharker_text .. self.constants.ready
            color = 4
        end
    end
    self.infoPanel:setText(node, tigersharker_text, color, 3)
end

function InfoRule:AddKrakenerTimer(inst)
    local node = "kraken"
    local krakener_text = STRINGS.NAMES[string.upper(node)] .. ": "
    local time = inst:TimeUntilCanSpawn()
    local color = 0
    if inst.kraken then
        krakener_text = krakener_text .. self.constants.appearing
        color = 1
    else
        if time > 0 then
            krakener_text = krakener_text .. Define:timeFormat(math.ceil(time))
        else
            krakener_text = krakener_text .. self.constants.ready
            color = 4
        end
    end
    self.infoPanel:setText(node, krakener_text, color, 3)
end

function InfoRule:AddHoundedTimer(inst)
    local node = "hound"
    local hounded_text = STRINGS.NAMES[string.upper(node)]
    local time = math.ceil(inst.timetoattack)
    if time > 0 then
        hounded_text = hounded_text .. " [" .. inst.houndstorelease .. "]: " .. Define:timeFormat(time)
    else
        time = math.ceil(inst.timetonexthound)
        hounded_text = hounded_text .. " [" .. self.constants.nextAttacking .. "-" .. inst.houndstorelease .. "]: " .. Define:timeFormat(time)
    end
    self.infoPanel:setText(node, hounded_text, Define:getColorByTime(time))
end

function InfoRule:AddBattedTimer(inst)
    local node = "bat"
    local time = math.ceil(inst.timetoattack)
    local batted_text = STRINGS.NAMES[string.upper(node)] .. "[" .. inst:CountBats() .."] : " .. Define:timeFormat(time)
    self.infoPanel:setText(node, batted_text, Define:getColorByTime(time))
end

return InfoRule