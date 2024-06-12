--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game.ReplicatedStorage:WaitForChild("ClientNetwork"):WaitForChild("RemoteEvent").OnClientEvent:Connect(function(endpoint : string, data)
    require(ReplicatedStorage.ClientAPI).ProcessRequest(endpoint, data)
end)

task.wait(5)

require(game.ReplicatedStorage.ClientNetwork).PostAsync("GetCardsForPlayer", function(data) warn(data) end, {game.Players.LocalPlayer})