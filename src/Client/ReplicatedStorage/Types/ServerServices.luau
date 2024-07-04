--!strict
local FunctionDelegates = require(game.ReplicatedStorage.Types.FunctionDelegates)
local PlayerDataType = require(game.ReplicatedStorage.Types.PlayerData)
local CardType = require(game.ReplicatedStorage.Types.Card)

export type RollService<T> = {
    RollCard : (player : Player, metadata : T) -> (CardType.Card),
}

export type PlayerStatsService = {
    LoadPlayerStats : (player : Player) -> PlayerDataType.PlayerDataType,
    GetPlayerStats : (userId : number) -> PlayerDataType.PlayerStats
}

export type CardService<E> = {
    GetPlayerCards : (userId : number) -> PlayerDataType.PlayerDeck,
    GetCardByFilterRule : (userId : number, FunctionDelegates.FilterRule<CardType.Card>) -> CardType.Card,
    GetCardsByFilterRule : (userId : number, FunctionDelegates.FilterRule<CardType.Card>, FunctionDelegates.Packagerule<CardType.Card, E>?) -> {E},
    LoadPlayerCards : (player : Player, metadata : any) -> PlayerDataType.PlayerDeck,
}


return 0