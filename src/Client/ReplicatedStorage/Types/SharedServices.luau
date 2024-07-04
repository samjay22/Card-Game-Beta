--!strict
local FunctionDelegates = require(game.ReplicatedStorage.Types.FunctionDelegates)
local TopicItemTypes = require(game.ReplicatedStorage.Types.Topic)

export type EntityService = {
    GetEntityByName : <T>(name : string) -> T?,
    GetEntityById : <T>(id : string) -> T?,
    AggregateByProperty : <T, E>(filterRule : FunctionDelegates.FilterRule<T>, packageRule : FunctionDelegates.Packagerule<T, E>?) -> {E | T},
}
export type TopicPoolingService = {
    CreateTopicQueue : (TopicName : string, TopicDelegates : any) -> (),
    PublishToTopic : (topicName : string, topicItem : TopicItemTypes.TopicItem<any>) -> (any, string?),
}

return 0