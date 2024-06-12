--!strict
local cardType = require(game.ReplicatedStorage.Types.Card)
return {
    {
        Id = "c387328f-0972-4ff9-8c81-f0c6d0e1zg04",
        Rarity = "Common",
        Probability = 1/2,

        DamageType = "c387328f-0972-4zz9-9881-f0c6d0e1zg04",
        DamageAmount = 1,

        ResistanceType = "c4182c2e-7101-42b2-b0db-98f961d4c0ed",
        ResistanceAmount = 1 / 2,

        WeaknessType = "z387528f-0972-4ff9-8s81-fgc6d0e1ff04",
        WeaknessAmount = 1 / 4,

        MaxHeath = 25,

        --Display Info
        Type = "Card",
        ImageUrl = "",
        SystemName = "EXAMPLE_CARD",
        DisplayName = "Example Card",
        TextDisplayColor = Color3.fromRGB(255, 255, 255),
        Description = "Example Description",

    },
} :: {cardType.Card}