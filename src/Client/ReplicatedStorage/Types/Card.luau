--!strict
local displayInfo = require(game.ReplicatedStorage.Types.DisplayInfo)
export type Card = {
    Id : string,
    Rarity : number,
    DamageType : string,
    ResistanceType : string,
    WeaknessType : string,
    Variant : string?,

} & displayInfo.DisplayInfo

export type CardEntity = {
    Id : string,
    Rarity : number,
    DamageType : string,
    ResistanceType : string,
    WeaknessType : string,
    Variant : string?,
    Card : Card,

    Health : number,
    DamageAmount : number,
    ResistanceAmount : number,
    WeaknessAmount : number,
}

return 0