--!strict
local CardType = require(game.ReplicatedStorage.Types.Card)

export type PlayerDeck = {
    CardInventory : {{Card : CardType.Card, Quantity : number, SlotNumber : string}},
    CardHand : {CardType.Card},
}

export type PlayerDataType = {
    UserId : number,
    CardData : PlayerDeck,
    PlayerStats : PlayerStats
}

--General stats
type playerStats = {
    Wins : number,
    Losses : number,
    Draws : number,
    Rating : number,
    WinRate : number,
    TotalGames : number,
    WinStreak : number,
    LossStreak : number,
    CurrentStreak : number,
    MaxStreak : number,
}

export type PlayerStats = {
    PVE_Stats : playerStats,
    PVP_Stats : playerStats,
    General_Stats : {
        TotalDamageDealt : number,
        TotalDamageReceived : number,
        TotalCardsDrawn : number,
        TotalCardsLost : number,
        TotalCardsDiscarded : number,
        TotalTimePlayed : number,
    }
}

return 0