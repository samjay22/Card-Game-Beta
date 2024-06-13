--!strict
local Players = game:GetService("Players")

game.Players.PlayerAdded:Connect(function(player)
    repeat task.wait() until shared.Inject("DataService")

    shared.Inject("DataService").LoadPlayerData(player)
end)