local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local Widget = require "widgets/widget"

local x = 0
local y = -20
local spacing = -25

local function setColor(inst, color)
	if color == 1 then
		inst:SetColour(1, 0, 0, 1)
	elseif color == 2 then
		inst:SetColour(0, 1, 0, 1)
	elseif color == 3 then
		inst:SetColour(0, 0, 1, 1)
	elseif color == 4 then
		inst:SetColour(1, 1, 0, 1)
	elseif color == 5 then
		inst:SetColour(0, 1, 1, 1)
	elseif color == 6 then
		inst:SetColour(1, 0, 1, 1)
	else
		inst:SetColour(1, 1, 1, 1)
	end
end

local InfoPanel = Class(Widget, function(self)
	Widget._ctor(self, "InfoPanel")

    self:SetHAnchor(ANCHOR_MIDDLE)
    self:SetVAnchor(ANCHOR_TOP)
    self:SetClickable(false)
	self:SetPosition(x, y, 0)
	self:SetScale(.9,.9,.9)
	self._texts = {}
end)

function InfoPanel:pushBack(index)
	for i = index, #self._texts do
		self._texts[i]._position = self._texts[i]._position + spacing
		self._texts[i]._text:SetPosition(0, self._texts[i]._position)
	end
end

function InfoPanel:pushForward(index)
		for i = index, #self._texts do 
			self._texts[i]._position = self._texts[i]._position - spacing
			self._texts[i]._text:SetPosition(0, self._texts[i]._position)
		end
end

function InfoPanel:setText(node, text, color, level)
	local item = nil
	local index = 1
	for i = 1, #self._texts do 
		if self._texts[i]._name == node then
			item = self._texts[i]
			index = i
			break
		end
	end
	if not item then
		item = {
			_name = node,
			_text = self:AddChild(Text(NUMBERFONT, 25)),
			_position = 0,
			_level = level
		}
		if level then
			index = 1
			for i = #self._texts, 1, -1  do 
				if self._texts[i]._level ~= -1 and self._texts[i]._level <= level then
					index = i + 1
					item._position = self._texts[i]._position + spacing
					break
				end
			end
			table.insert(self._texts, index, item)
			self:pushBack(index + 1)
		else
			item._position = self._texts[#self._texts]._position + spacing
			item._level = -1
			table.insert(self._texts, item)
		end
		item._text:SetPosition(0, item._position)
	end
	item._text:SetString(text)
	setColor(item._text, color)
end

function InfoPanel:removeText(node)
	local index = 0
	for i = 1, #self._texts do 
		if self._texts[i]._name == node then
			index = i
			break
		end
	end
	if index > 0 then
		self._texts[index]._text:Kill()
		table.remove(self._texts, index)
		self:pushForward(index)
	end
end

function InfoPanel:setColor(node, red, green, blue, alpha)
	local item = nil
	for i = 1, #self._texts do 
		if self._texts[i]._name == node then
			item = self._texts[i]
			self._texts[i]._text:SetColour(red, green, blue, alpha)
			break
		end
	end
end

return InfoPanel