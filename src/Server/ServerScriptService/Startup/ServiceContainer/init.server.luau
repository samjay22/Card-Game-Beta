--!strict
local ServiceContainer = require(game.ReplicatedStorage.ServiceContainer)

for _, module in ipairs(script:GetChildren()) do
    if module:IsA("ModuleScript") then
        ServiceContainer.RegisterService(module.Name, module)
    end
end

--Register topic pool for services
require(game.ServerStorage.ServerTopics)

warn("Loaded Server Services")