--!strict
local Players = game:GetService("Players")
Players.PlayerAdded:Connect(function(player)
    repeat task.wait() until shared.Loaded
    
    local HttpService = shared.Inject("HttpService")
    local data = shared.Inject("TopicPoolingService").PublishToTopic("DataService", {
        RequestID = HttpService:GenerateGUID(),
        EventType = "LoadPlayerData",
        UserId = player.UserId,
        Timestamp = os.time()
    })

    warn(data)
end)