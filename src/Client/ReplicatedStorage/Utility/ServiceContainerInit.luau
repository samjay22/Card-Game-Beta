--!strict
local Debris : Debris = game:GetService("Debris")

local _services = {}
local _containerMethods = {}

--Roblox does not allow us to write to the globals, so, we have to use _G or shared.
local sharedMemorySpace = {__index = _containerMethods}
setmetatable(shared, sharedMemorySpace)
setmetatable(_G, sharedMemorySpace)

_containerMethods.Inject = function(serviceName : string)
    local okay, service = pcall(function()
        return game:GetService(serviceName)
    end)

    if not okay or not service then
        local timeout : number = os.clock() + 5
        repeat task.wait() until _services[serviceName] or timeout < os.clock()
        service = _services[serviceName] 
    end

    return service or warn("Service not found: " .. serviceName)
end

_containerMethods.NewInstance = function(instanceName : string, gcTimeout : number) : Instance
    local instance = Instance.new(instanceName)
    instance.Parent = game
    
    Debris:AddItem(instance, gcTimeout or 30)

    return instance
end
                                          
_containerMethods.RegisterService = function(serviceName : string, module : ModuleScript)
   task.spawn(function()
        local data = require(module)
        _services[serviceName] = data
        _containerMethods.Inject("TopicPoolingService").CreateTopicQueue(serviceName, data)
   end)
end

_containerMethods.RegisterService("EntityService", game.ReplicatedStorage.Utility.EntityService)
_containerMethods.RegisterService("TopicPoolingService", game.ReplicatedStorage.Utility.TopicPoolingService)

shared.Loaded = true
return _containerMethods