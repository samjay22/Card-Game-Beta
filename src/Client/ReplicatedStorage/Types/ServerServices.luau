--!strict
local PlayerDataType = require(game.ReplicatedStorage.Types.PlayerData)
local TopicItemTypes = require(game.ReplicatedStorage.Types.Topic)

export type RollService = {
    RollCard : (player : Player) -> (),
    GetCardById : (player : Player, cardId : string) -> (),
    GetCardByName : (player : Player, cardName : string) -> (),
    GetPlayerDeck : (player : Player) -> (),
}

export type PlayerDataService = {
    LoadPlayerData : (player : Player) -> PlayerDataType.PlayerDataType,
    GetPlayerData : (userId : number) -> PlayerDataType.PlayerDataType,
    GetPlayerCards : (userId : number) -> PlayerDataType.PlayerDeck,
    GetPlayerStats : (userId : number) -> PlayerDataType.PlayerStats
}

export type TopicPoolingService = {
    PublishToTopic : (topicName : string, topicItem : TopicItemTypes.TopicItem<any>) -> (any, string?),
    PoolTopic : (topicName : string) -> (TopicItemTypes.TopicItem<any> | nil),
}

return 0