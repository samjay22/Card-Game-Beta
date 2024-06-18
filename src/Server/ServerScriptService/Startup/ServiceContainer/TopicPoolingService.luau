--!strict
local TopicItemTypes = require(game.ReplicatedStorage.Types.Topic)

local Service = {}
local TopicQueues = {}

function Service.PoolTopic(topicName : string)
    if not TopicQueues[topicName] then return end
    return table.remove(TopicQueues[topicName], 1)
end

function Service.PublishToTopic(topicName : string, topicItem : TopicItemTypes.TopicItem<any>)
    if not TopicQueues[topicName] then
        TopicQueues[topicName] = {}
    end

    table.insert(TopicQueues[topicName], topicItem)

    local timeout : number = os.clock() + 5
    repeat task.wait() until _G[topicItem.RequestID] or timeout < os.clock()

    --lets gc
    task.delay(5, function()
        _G[topicItem.RequestID] = nil
    end)

    return _G[topicItem.RequestID]
end

return Service