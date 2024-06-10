--!strict
local displayInfo = require(game.ReplicatedStorage.Types.DisplayInfo)
export type Card = {
    Id : string,
    Rarity : string,
    Probability : number,

    DamageType : string,
    DamageAmount : number,

    ResistanceType : string,
    ResistanceAmount : number,

    WeaknessType : string,
    WeaknessAmount : number,

    CurrentHealth : number?,
    MaxHeath : number,
} & displayInfo.DisplayInfo

return 0