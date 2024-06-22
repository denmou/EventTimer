local Text = require 'widgets/text'
local Widget = require 'widgets/widget'
local Image = require 'widgets/image'
local ImageButton = require 'widgets/imagebutton'
local Spinner = require 'widgets/spinner'
local Configure = require 'configure'

local Times = {
    {
        text = '8min',
        data = 8 * 60
    },
    {
        text = '16min',
        data = 16 * 60
    },
    {
        text = '24min',
        data = 24 * 60
    },
    {
        text = '32min',
        data = 32 * 60
    },
    {
        text = '40min',
        data = 40 * 60
    },
    {
        text = '64min',
        data = 64 * 60
    },
    {
        text = '80min',
        data = 80 * 60
    },
    {
        text = '120min',
        data = 120 * 60
    },
    {
        text = '160min',
        data = 160 * 60
    }
}
local Rows = {
    {
        text = '1',
        data = 1
    },
    {
        text = '2',
        data = 2
    },
    {
        text = '3',
        data = 3
    },
    {
        text = '4',
        data = 4
    },
    {
        text = '5',
        data = 5
    },
    {
        text = '6',
        data = 6
    },
    {
        text = '7',
        data = 7
    },
    {
        text = '8',
        data = 8
    }
}

local Scales = {
    {
        text = '0.5',
        data = 0.5
    },
    {
        text = '0.6',
        data = 0.6
    },
    {
        text = '0.7',
        data = 0.7
    },
    {
        text = '0.8',
        data = 0.8
    },
    {
        text = '0.9',
        data = 0.9
    },
    {
        text = '1',
        data = 1
    },
    {
        text = '1.1',
        data = 1.1
    },
    {
        text = '1.2',
        data = 1.2
    },
    {
        text = '1.3',
        data = 1.3
    },
    {
        text = '1.4',
        data = 1.4
    },
    {
        text = '1.5',
        data = 1.5
    },
    {
        text = '1.6',
        data = 1.6
    },
    {
        text = '1.7',
        data = 1.7
    },
    {
        text = '1.8',
        data = 1.8
    },
    {
        text = '1.9',
        data = 1.9
    },
    {
        text = '2',
        data = 2
    }
}

local icon_fix = {
    size = {43.2, 43.2},
    offset_x = 36
}
local font_fix = {
    type = BODYTEXTFONT,
    size = 18,
    offset_x = 132,
    offset_y = 10.8
}
local options_fix = {
    width = 450,
    height = 64,
    font = BODYTEXTFONT,
    font_size = 64,
    offset_x = 132,
    offset_y = -10.8,
    scale = .3
}
local rows_fix = {
    width = 150,
    height = 64,
    font = BODYTEXTFONT,
    font_size = 64,
    offset_x = 137.4,
    offset_y = -10.8,
    scale = .3
}
local scale_fix = {
    width = 200,
    height = 64,
    font = BODYTEXTFONT,
    font_size = 64,
    offset_x = 185.4,
    offset_y = -10.8,
    scale = .3
}
local dlc_fix = {
    position_space = 23.4,
    position_x = 72,
    position_y = -10.8,
    scale = .2
}
local localtion_fix = {
    position_space = 28,
    position_x = 72,
    position_y = -10.8,
    scale = .28
}
local mask_fix = {
    size = {204.8, 43.2},
    offset_x = 116.8,
    alpha = .75
}

local Configurationbadge =
    Class(
    Widget,
    function(self, config)
        Widget._ctor(self, 'Configurationbadge')
        self.config = config
        self:addSwitch()
        self:addIcon()
        if self.config.name then
            self.title_sign = true
            self:addTitle()
        end
        if self.config.time then
            self.options_sign = true
            self:addOptions('time')
        elseif self.config.row then
            self.options_sign = true
            self:addRow()
            self:addScale()
        end
        --if self.config.dlc then
        --    self:addDlc()
        --else
        if self.config.position then
            self:addPosition()
        end
        self:addMask()
    end
)

function Configurationbadge:addSwitch()
    self.swtich_sign = type(self.config.switch) == 'boolean'
    if self.swtich_sign then
        self.switch =
            self:AddChild(
            ImageButton('images/ui.xml', (self.config.switch and 'button_checkbox2.tex') or 'button_checkbox1.tex')
        )
        self.switch:SetScale(.3)
        self.switch:SetOnClick(
            function()
                self:OnSwitch()
            end
        )
    end
end

function Configurationbadge:addIcon()
    self.icon_bg = self:AddChild(Image('images/ui.xml', 'portrait_bg.tex'))
    self.icon_bg:SetSize(icon_fix.size, icon_fix.size)
    self.icon_bg:Nudge(Vector3(icon_fix.offset_x, 0, 0))

    self.icon = self:AddChild(Image('images/resources.xml', self.config.icon .. '.tex'))
    self.icon:SetSize(icon_fix.size, icon_fix.size)
    self.icon:Nudge(Vector3(icon_fix.offset_x, 0, 0))
end

function Configurationbadge:addTitle()
    self.title = self:AddChild(Text(font_fix.type, font_fix.size))
    self.title:Nudge(Vector3(font_fix.offset_x, font_fix.offset_y, 0))
    local nameString
    if self.config.type then
        local localString = STRINGS
        for i, v in ipairs(self.config.type) do
            if localString[v] then
                localString = localString[v]
            end
        end
        nameString = localString[self.config.name]
    else
        nameString = self.config.name
    end
    if self.config.group then
        nameString = '* ' .. nameString .. ' *'
    end
    self.title:SetString(nameString)
end

function Configurationbadge:addOptions(type)
    local values = Times
    self.options =
        self:AddChild(
        Spinner(values, options_fix.width, options_fix.height, {font = options_fix.font, size = options_fix.font_size})
    )
    self.options:Nudge(Vector3(options_fix.offset_x, options_fix.offset_y, 0))
    self.options:SetScale(options_fix.scale)
    for i, v in pairs(values) do
        if self.config[type] == v.data then
            self.options:SetSelectedIndex(i)
            break
        end
    end
    self.options:SetOnChangedFn(
        function(value)
            Configure:UpdateValue(self.config.id, type, value)
        end
    )
end

function Configurationbadge:addRow()
    local values = Rows
    self.options =
        self:AddChild(
        Spinner(values, rows_fix.width, rows_fix.height, {font = rows_fix.font, size = rows_fix.font_size})
    )
    self.options:Nudge(Vector3(rows_fix.offset_x, rows_fix.offset_y, 0))
    self.options:SetScale(rows_fix.scale)
    for i, v in pairs(values) do
        if self.config.row == v.data then
            self.options:SetSelectedIndex(i)
            break
        end
    end
    self.options:SetOnChangedFn(
        function(value)
            Configure:UpdateValue(self.config.id, 'row', value)
        end
    )
end

function Configurationbadge:addScale()
    local values = Scales
    self.options =
        self:AddChild(
        Spinner(values, scale_fix.width, scale_fix.height, {font = scale_fix.font, size = scale_fix.font_size})
    )
    self.options:Nudge(Vector3(scale_fix.offset_x, scale_fix.offset_y, 0))
    self.options:SetScale(scale_fix.scale)
    for i, v in pairs(values) do
        if self.config.scale == v.data then
            self.options:SetSelectedIndex(i)
            break
        end
    end
    self.options:SetOnChangedFn(
        function(value)
            Configure:UpdateValue(self.config.id, 'scale', value)
        end
    )
end

function Configurationbadge:addDlc()
    self.dlc = {}
    local count = 0
    local position_space = dlc_fix.position_space
    local position_x = dlc_fix.position_x
    local position_y = dlc_fix.position_y
    local scale = dlc_fix.scale
    if not self.options_sign then
        position_x = position_x + 20
        position_space = position_space * 2
    end
    if not self.title_sign then
        position_y = 0
        scale = .3
    end
    for i, v in pairs(self.config.dlc) do
        self.dlc[i] = self:AddChild(ImageButton('images/ui.xml', i .. '_' .. ((v and 'on') or 'off') .. '.tex'))
        self.dlc[i]:Nudge(Vector3(position_x + position_space * count, position_y, 0))
        self.dlc[i]:SetScale(scale)
        self.dlc[i]:SetOnClick(
            function()
                self:OnSwitchByDlc(i)
            end
        )
        count = count + 1
    end
end

function Configurationbadge:addPosition()
    self.position = {}
    local count = 0
    local position_space = localtion_fix.position_space
    local position_x = localtion_fix.position_x
    local position_y = localtion_fix.position_y
    local scale = localtion_fix.scale
    if not self.options_sign then
        position_x = position_x + 20
        position_space = position_space * 2
    end
    if not self.title_sign then
        position_y = 0
        scale = .3
    end
    for i, v in pairs(self.config.position) do
        self.position[i] =
            self:AddChild(
            ImageButton('images/resources.xml', 'position_' .. i .. '_' .. ((v and 'on') or 'off') .. '.tex')
        )
        self.position[i]:SetScale(scale)
        self.position[i]:Nudge(Vector3(position_x + position_space * count, position_y, 0))
        self.position[i]:SetOnClick(
            function()
                self:OnSwitchByPosition(i)
            end
        )
        count = count + 1
    end
end

function Configurationbadge:addMask()
    if self.swtich_sign then
        self.mask = self:AddChild(Image('images/global.xml', 'square.tex'))
        self.mask:SetSize(mask_fix.size)
        self.mask:Nudge(Vector3(mask_fix.offset_x, 0, 0))
        self.mask:SetTint(0, 0, 0, mask_fix.alpha)
        if self.config.switch then
            self.mask:Hide()
        else
            self.mask:Show()
        end
    end
end

function Configurationbadge:OnSwitch()
    self.config.switch = not self.config.switch
    self.switch:SetTextures('images/ui.xml', (self.config.switch and 'button_checkbox2.tex') or 'button_checkbox1.tex')
    Configure:OnSwitch(self.config.id, self.config.switch)
    if self.mask then
        if self.config.switch then
            self.mask:Hide()
        else
            self.mask:Show()
        end
    end
end

function Configurationbadge:OnSwitchByDlc(dlc_name)
    self.config.dlc[dlc_name] = not self.config.dlc[dlc_name]
    self.dlc[dlc_name]:SetTextures(
        'images/ui.xml',
        dlc_name .. '_' .. ((self.config.dlc[dlc_name] and 'on') or 'off') .. '.tex'
    )
    Configure:OnSwitchDlc(self.config.id, dlc_name, self.config.dlc[dlc_name])
end

function Configurationbadge:OnSwitchByPosition(position)
    if not self.config.position[position] then
        for i, v in pairs(self.config.position) do
            if i == position then
                self.position[i]:SetTextures('images/resources.xml', 'position_' .. i .. '_on.tex')
                self.config.position[i] = true
            else
                self.position[i]:SetTextures('images/resources.xml', 'position_' .. i .. '_off.tex')
                self.config.position[i] = false
            end
        end
        Configure:OnSelectPosition(self.config.id, position)
    end
end

return Configurationbadge
