--!strict
local ServiceTypes = require(game.ReplicatedStorage.Types.ServerServices)

local GlobalUpdateService = require(game.ReplicatedStorage.Utility.GlobalUpdateService)
local TopicPoolingService : ServiceTypes.TopicPoolingService = shared.Inject("TopicPoolingService")
local DataService : ServiceTypes.PlayerDataService = shared.Inject("DataService")

GlobalUpdateService.AddGlobalUpdate(function()
    local topicItem = TopicPoolingService.PoolTopic("DataService")
    if topicItem then
        if DataService[topicItem.EventType] then
            local Player = game.Players:GetPlayerByUserId(topicItem.UserId)
            _G[topicItem.RequestID] = DataService[topicItem.EventType](Player, topicItem.Metadata)
        end
    end
end)


return 0