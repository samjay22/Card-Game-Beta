--!strict
local _services = {}
local _containerMethods = {}

_containerMethods.Inject = function(serviceName : string)
    return _services[serviceName]
end
                                          
_containerMethods.RegisterService = function(serviceName : string, module : ModuleScript)
    _services[serviceName] = require(module)
end


--Roblox does not allow us to write to the globals, so, we have to use _G or shared.
local sharedMemorySpace = {__index = _containerMethods}
local sharedMetatable = setmetatable(_G, sharedMemorySpace)
setmetatable(shared, {__index = sharedMetatable})
return _containerMethods