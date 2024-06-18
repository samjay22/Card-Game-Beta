--!strict
local ServiceTypes = require(game.ReplicatedStorage.Types.ServerServices)

local GlobalUpdateService = require(game.ReplicatedStorage.Utility.GlobalUpdateService)
local TopicPoolingService : ServiceTypes.TopicPoolingService = shared.Inject("TopicPoolingService")
local RollingService : ServiceTypes.RollService = shared.Inject("RollService")

GlobalUpdateService.AddGlobalUpdate(function()
    local topicItem = TopicPoolingService.PoolTopic("RollService")
    if topicItem then
        if RollingService[topicItem.EventType] then
            local Player = game.Players:GetPlayerByUserId(topicItem.UserId)
            _G[topicItem.RequestID] = RollingService[topicItem.EventType](Player, topicItem.Metadata)
        end
    end
end)

return 0