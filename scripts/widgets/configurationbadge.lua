local Text = require 'widgets/text'
local Widget = require 'widgets/widget'
local Image = require 'widgets/image'
local ImageButton = require 'widgets/imagebutton'
local Spinner = require 'widgets/spinner'
local Configure = require 'configure'

local images = {
    'images/customization_porkland.xml',
    'images/customization_shipwrecked.xml',
    'images/customisation.xml',
    'images/customisation_dst.xml',
    'images/inventoryimages.xml',
    'images/resources.xml'
}

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

local Configurationbadge =
    Class(
    Widget,
    function(self, config)
        Widget._ctor(self, 'Configurationbadge')
        self.config = config
        local switch_icon = 'button_checkbox1.tex'
        if config.switch then
            switch_icon = 'button_checkbox2.tex'
        end
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

        local icon_size = RESOLUTION_Y * .06
        self.icon_bg = self:AddChild(Image('images/ui.xml', 'portrait_bg.tex'))
        self.icon_bg:SetSize(icon_size, icon_size)
        self.icon_bg:Nudge(Vector3(RESOLUTION_Y * .05, 0, 0))

        for i, v in ipairs(images) do
            self.icon = self:AddChild(Image(v, self.config.icon .. '.tex'))
            local w, h = self.icon:GetSize()
            if w > 0 then
                break
            end
        end
        self.icon:SetSize(icon_size, icon_size)
        self.icon:Nudge(Vector3(RESOLUTION_Y * .05, 0, 0))

        self.dlc = {}
        local dlc_count = 0

        if self.config.name then
            self.title = self:AddChild(Text(NUMBERFONT, RESOLUTION_Y * .025))
            self.title:SetSize(RESOLUTION_X * .15 - RESOLUTION_Y * .06, RESOLUTION_Y * .03)
            self.title:Nudge(Vector3(RESOLUTION_X * .075 + RESOLUTION_Y * .05, RESOLUTION_Y * .015, 0))
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
            if self.config.time then
                for i, v in pairs(self.config.dlc) do
                    self.dlc[i] =
                        self:AddChild(ImageButton('images/ui.xml', i .. '_' .. ((v and 'on') or 'off') .. '.tex'))
                    self.dlc[i]:SetScale(.2)
                    self.dlc[i]:Nudge(Vector3(RESOLUTION_Y * (.1 + .0325 * dlc_count), -RESOLUTION_Y * .015, 0))
                    self.dlc[i]:SetOnClick(
                        function()
                            self:OnSwitchByDlc(i)
                        end
                    )
                    dlc_count = dlc_count + 1
                end
                self.options = self:AddChild(Spinner(Times, 300, 64, {font = NUMBERFONT, size = 64}))
                self.options:Nudge(
                    Vector3(RESOLUTION_X * .075 - RESOLUTION_Y * .0825 + RESOLUTION_Y * .19, -RESOLUTION_Y * .015, 0)
                )
                self.options:SetScale(.3)
                for i, v in pairs(Times) do
                    if self.config.time == v.data then
                        self.options:SetSelectedIndex(i)
                        break
                    end
                end
                self.options:SetOnChangedFn(
                    function(value)
                        Configure:UpdateTimeValue(self.config.id, value)
                    end
                )
            else
                for i, v in pairs(self.config.dlc) do
                    self.dlc[i] =
                        self:AddChild(ImageButton('images/ui.xml', i .. '_' .. ((v and 'on') or 'off') .. '.tex'))
                    self.dlc[i]:SetScale(.2)
                    self.dlc[i]:Nudge(Vector3(RESOLUTION_Y * (.125 + .065 * dlc_count), -RESOLUTION_Y * .015, 0))
                    self.dlc[i]:SetOnClick(
                        function()
                            self:OnSwitchByDlc(i)
                        end
                    )
                    dlc_count = dlc_count + 1
                end
            end
        else
            for i, v in pairs(self.config.dlc) do
                self.dlc[i] = self:AddChild(ImageButton('images/ui.xml', i .. '_' .. ((v and 'on') or 'off') .. '.tex'))
                self.dlc[i]:SetScale(.3)
                self.dlc[i]:Nudge(Vector3(RESOLUTION_Y * (.13 + .065 * dlc_count), 0, 0))
                self.dlc[i]:SetOnClick(
                    function()
                        self:OnSwitchByDlc(i)
                    end
                )
                dlc_count = dlc_count + 1
            end
        end

        self.mask = self:AddChild(Image('images/global.xml', 'square.tex'))
        self.mask:SetSize(RESOLUTION_X * .16, RESOLUTION_Y * .06)
        self.mask:Nudge(Vector3(RESOLUTION_X * .08 + RESOLUTION_Y * .02, 0, 0))
        self.mask:SetTint(0, 0, 0, .75)
        if self.config.switch then
            self.mask:Hide()
        else
            self.mask:Show()
        end
    end
)

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
    Configure:OnSwitch(self.config.id, self.config.dlc[dlc_name], dlc_name)
end

return Configurationbadge
