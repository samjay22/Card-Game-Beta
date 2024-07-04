--!strict
local GlobalUpdateService = require(game.ReplicatedStorage.Utility.GlobalUpdateService)
local TopicItemTypes = require(game.ReplicatedStorage.Types.Topic)

local Service = {}
local Topics : {[string] : BindableEvent} = {}

function Service.CreateTopicQueue(TopicName : string, TopicDelegates)
    --I would rather set this in the heap than the stack level.
    local myTopicQueue : {TopicItemTypes.TopicItem<any>} = {}
    _G[TopicName] = myTopicQueue
    
    local myEvent : BindableEvent = Instance.new("BindableEvent")
    Topics[TopicName] = myEvent
    myEvent.Event:Connect(function(event : TopicItemTypes.TopicItem<any>)
        table.insert(myTopicQueue, event)
    end)

    --Register the queue to be processed by the global update service
    GlobalUpdateService.AddGlobalUpdate(function(dt : number)
        local topicItem = table.remove(myTopicQueue, 1)
        if topicItem and TopicDelegates[topicItem.EventType]  then
            local Player = game.Players:GetPlayerByUserId(topicItem.UserId)
            local _ = topicItem.OnTopicCompleted and topicItem.OnTopicCompleted:Fire(pcall(TopicDelegates[topicItem.EventType], Player, topicItem.Metadata))
        end
    end)
end

function Service.PublishToTopic(topicName : string, topicItem : TopicItemTypes.TopicItem<any>)
    if Topics[topicName] then
        Topics[topicName]:Fire(topicItem)
    end
end

return Service