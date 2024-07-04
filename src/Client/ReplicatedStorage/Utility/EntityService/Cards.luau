--!strict
local cardType = require(game.ReplicatedStorage.Types.Card)
return {
    {
        Id = "c387328f-0972-4ff9-8c81-f0c6d0e1zg04",
        Rarity = 1/2,

        DamageType = "c387328f-0972-4zz9-9881-f0c6d0e1zg04",
        DamageAmount = 1,

        ResistanceType = "c4182c2e-7101-42b2-b0db-98f961d4c0ed",
        ResistanceAmount = 1 / 2,

        WeaknessType = "z387528f-0972-4ff9-8s81-fgc6d0e1ff04",
        WeaknessAmount = 1 / 4,

        --Display Info
        Type = "Card",
        ImageUrl = "",
        SystemName = "EXAMPLE_CARD",
        DisplayName = "Example Card",
        TextDisplayColor = Color3.fromRGB(255, 255, 255),
        Description = "Example Description",
    },
    {
        Id = "a9d0b6c1-3b68-45e4-a902-9c7292a1c6b2",
        Rarity = 1/4,

        DamageType = "f7b39490-27c7-4e3b-88f4-72253f42f1ee",
        ResistanceType = "ba5b5925-1cb2-49a5-99a2-f06e7b7e6501",
        WeaknessType = "cd5c6ecb-d536-4eb0-9d3e-518b9a8e1d3f",

        --Display Info
        Type = "Card",
        ImageUrl = "",
        SystemName = "EXAMPLE_CARD_2",
        DisplayName = "Example Card 2",
        TextDisplayColor = Color3.fromRGB(255, 255, 255),
        Description = "Example Description 2",
    },
} :: {cardType.Card}