--!strict
local CardTypes = require(game.ReplicatedStorage.Types.Card)

export type PVEMatch = {
    MatchID : string,
    MatchStartTime : number,
    DeckData : {
        Player : {CardTypes.Card},
        NPC : {CardTypes.Card},
    }
}

return 0