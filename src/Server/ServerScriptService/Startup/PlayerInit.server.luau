--!strict
local PlayerDataTypes = require(game.ReplicatedStorage.Types.PlayerData)

local Players : Players = shared.Inject("Players")
local HttpService = shared.Inject("HttpService")

local _PlayerDataCache : {PlayerDataTypes.PlayerDataType} = {}

local function ResponseHandler(okay : boolean, response : string | any)
    if not okay then
        warn("Error loading player data: ", response)
        return
    end

   if response.CardData and response.PlayerStats then
       table.insert(_PlayerDataCache, data)
       warn("Player data loaded for player: ", data.UserId)
   end 

end

Players.PlayerAdded:Connect(function(player)
    repeat task.wait() until shared.Loaded
    
    local data : {UserId : number, CardData : any, PlayerStats : any} = {
        UserId = player.UserId,
        CardData = nil,
        PlayerStats = nil
    }

    local onCompleted : BindableEvent = shared.NewInstance("BindableEvent", 5)
    onCompleted.Event:Once(ResponseHandler)
    shared.Inject("TopicPoolingService").PublishToTopic("PlayerStatsService", {
        RequestID = HttpService:GenerateGUID(),
        EventType = "LoadPlayerStats",
        UserId = player.UserId,
        Timestamp = os.time(),
        Metadata = {
            playerDataRef = data
        },

       OnTopicCompleted = onCompleted
    })

    local onCompleted : BindableEvent = shared.NewInstance("BindableEvent", 5)
    onCompleted.Event:Once(ResponseHandler)
    shared.Inject("TopicPoolingService").PublishToTopic("CardService", {
        RequestID = HttpService:GenerateGUID(),
        EventType = "LoadPlayerCards",
        UserId = player.UserId,
        Timestamp = os.time(),
        Metadata = {
            playerDataRef = data
        },
       
         OnTopicCompleted = onCompleted
    })
end)