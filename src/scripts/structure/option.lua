local Utils = require('util/utils')

local Option = Class(function(self, id, name, icon, switch, mode, value, options, extension, resource)
    self.id = id
    self.extension = extension
    self.name = Utils.loadStrings(name)
    self.icon = icon
    self.switch = switch
    self.mode = mode
    self.value = value
    self.options = options
    self.resource = resource or 'images/resources.xml'
end)

return Option
