--!strict
local CardTypes = require(game.ReplicatedStorage.Types.Card)
local PlayerDataTypes = require(game.ReplicatedStorage.Types.PlayerData)
local ServerServiceTypes = require(game.ReplicatedStorage.Types.ServerServices)
local EntityDirectory = require(game.ReplicatedStorage.EntityDirectory)

local PlayerService : ServerServiceTypes.PlayerDataService = shared.Inject("DataService")

local Controller = {}

function Controller.GetCardsForPlayer(player : Player)
    local cardPackage = {
        Hand = {},
        Inventory = {},
    }

    local Mux = {}
    local playerCards : PlayerDataTypes.PlayerDeck = PlayerService.GetPlayerCards(player.UserId)
    
    task.spawn(function()
        --logic to get all of the card data in once struct
        for _, cardMetadata in ipairs(playerCards.CardHand) do
            local card : CardTypes.Card? = EntityDirectory.GetEntityById(cardMetadata.CardId)
            if not card then return end
            table.insert(cardPackage.Hand, {
                Id = card.Id,
                Rarity = card.Rarity,
                Probability = card.Probability,

                DamageType = EntityDirectory.GetEntityById(card.DamageType),
                DamageAmount = card.DamageAmount,

                ResistanceType = EntityDirectory.GetEntityById(card.ResistanceType),
                ResistanceAmount = card.ResistanceAmount,

                WeaknessData = EntityDirectory.GetEntityById(card.WeaknessType),
                WeaknessAmount = card.WeaknessAmount,

                MaxHealth = card.MaxHeath,
                Type = card.Type,
                ImageUrl = card.ImageUrl,
                SystemName = card.SystemName,
                DisplayName = card.DisplayName,
                TextDisplayColor = card.TextDisplayColor,
                Description = card.Description
            })
        end

        --signal that the task is done
        table.insert(Mux, 1)
    end)

     task.spawn(function()
            --logic to get all of the card data in once struct
        for _, invMetadata in ipairs(playerCards.CardInventory) do
            local card : CardTypes.Card? = EntityDirectory.GetEntityById(invMetadata.CardId)
            if not card then return end
            table.insert(cardPackage.Inventory, {
                Id = card.Id,
                Rarity = card.Rarity,
                Probability = card.Probability,
                
                DamageType = EntityDirectory.GetEntityById(card.DamageType),
                DamageAmount = card.DamageAmount,

                ResistanceType = EntityDirectory.GetEntityById(card.ResistanceType),
                ResistanceAmount = card.ResistanceAmount,

                WeaknessData = EntityDirectory.GetEntityById(card.WeaknessType),
                WeaknessAmount = card.WeaknessAmount,

                MaxHealth = card.MaxHeath,
                --DisplayInfo
                Type = card.Type,
                ImageUrl = card.ImageUrl,
                SystemName = card.SystemName,
                DisplayName = card.DisplayName,
                TextDisplayColor = card.TextDisplayColor,
                Description = card.Description,
                Slot = invMetadata.SlotNumber,
                Quantity = invMetadata.Quantity
            })
        end

        --signal that the task is done
        table.insert(Mux, 2)
     end)

    repeat task.wait() until #Mux == 2

    return cardPackage
end

return Controller