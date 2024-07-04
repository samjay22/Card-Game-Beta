--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--!strict
game.ReplicatedStorage:WaitForChild("ClientNetwork"):WaitForChild("RemoteEvent").OnClientEvent:Connect(function(endpoint : string, data)
    warn("Received data from server: " .. endpoint)
    require(ReplicatedStorage.ClientAPI).ProcessRequest(endpoint, data)
end)