--!strict
local ServiceContainer = require(game.ReplicatedStorage.Utility:WaitForChild("ServiceContainerInit"))

for _, module in ipairs(script:GetChildren()) do
    if module:IsA("ModuleScript") then
        ServiceContainer.RegisterService(module.Name, module)
    end
end

warn("Loaded Server Services")