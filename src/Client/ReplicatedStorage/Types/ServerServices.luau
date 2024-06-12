--!strict
local PlayerDataType = require(game.ReplicatedStorage.Types.PlayerData)
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

return 0