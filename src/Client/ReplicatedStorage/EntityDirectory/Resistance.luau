--!strict
local ResistanceType = require(game.ReplicatedStorage.Types.Resistance)

return {
    {
        Id = "c387328f-0972-4ff9-8c81-f0c6d0e1ff04",
        Description = "Reduces the amount of fire damage a card takes from a fire attack.",
        ImageUrl = "rbxassetid://1234567890",
        SystemName = "FIRE_RESISTANCE",
        DisplayName = "Fire Resistance",
        TextDisplayColor = Color3.fromRGB(255, 0, 0),
        Type = "Resistance",
    },
    {
        Id = "c4182c2e-7101-42b2-b0db-98f961d4c0ed",
        Description = "Reduces the amount of toxic damage a card takes from a toxic attack.",
        ImageUrl = "rbxassetid://1234567890",
        SystemName = "TOXIC_RESISTANCE",
        DisplayName = "Toxic Resistance",
        TextDisplayColor = Color3.fromRGB(0, 225, 0),
        Type = "Resistance",
    },
    {
        Id = "2f2b4c92-6538-4258-9dac-acc752dbefe1",
        Description = "Reduces the amount of ice damage a card takes from a ice attack.",
        ImageUrl = "rbxassetid://1234567890",
        SystemName = "ICE_RESISTANCE",
        DisplayName = "Ice Resistance",
        TextDisplayColor = Color3.fromRGB(255, 255, 255),
        Type = "Resistance",
    },
    {
        Id = "5138a7aa-6f64-4f2e-ae17-0ed33d1e0177",
        Description = "Reduces the amount of gas damage a card takes from a gas attack.",
        ImageUrl = "rbxassetid://1234567890",
        SystemName = "GAS_RESISTANCE",
        DisplayName = "Gas Resistance",
        TextDisplayColor = Color3.fromRGB(255, 0, 0),
        Type = "Resistance",
    },
    {
        Id = "5138a7aa-6f64-3f1e-aea7-0ef32d1e0177",
        Description = "Reduces the amount of water damage a card takes from a water attack.",
        ImageUrl = "rbxassetid://1234567890",
        SystemName = "WATER_RESISTANCE",
        DisplayName = "Water Resistance",
        TextDisplayColor = Color3.fromRGB(0, 0, 255),
        Type = "Resistance",
    },
    {
        Id = "140d88b0-e537-46b2-b69c-c7e69a4e0512 ",
        Description = "Reduces the amount of earth damage a card takes from a earth attack.",
        ImageUrl = "rbxassetid://1234567890",
        SystemName = "EARTH_RESISTANCE",
        DisplayName = "EARTH Resistance",
        TextDisplayColor = Color3.fromRGB(34, 29, 0),
        Type = "Resistance",
    },
} :: {ResistanceType.Resistance}