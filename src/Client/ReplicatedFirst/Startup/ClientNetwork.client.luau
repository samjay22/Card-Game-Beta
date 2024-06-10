--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game.ReplicatedStorage:WaitForChild("ClientNetwork"):WaitForChild("RemoteEvent").OnClientEvent:Connect(function(endpoint : string, data)
    require(ReplicatedStorage.ClientAPI).ProcessRequest(endpoint, data)
end)