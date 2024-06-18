--!strict
local CardTypes = require(game.ReplicatedStorage.Types.Card)
local PlayerDataTypes = require(game.ReplicatedStorage.Types.PlayerData)
local ServerServiceTypes = require(game.ReplicatedStorage.Types.ServerServices)
local EntityDirectory = require(game.ReplicatedStorage.EntityDirectory)

local PlayerService : ServerServiceTypes.PlayerDataService = shared.Inject("DataService")
local TopicPoolingService : ServerServiceTypes.TopicPoolingService = shared.Inject("TopicPoolingService")
local HttpService : HttpService = shared.Inject("HttpService")

local Controller = {}

function Controller.GetCardsForPlayer(player : Player)
    local cardPackage = {
        Hand = {},
        Inventory = {},
    }

    local Mux = {}
    local playerCards : PlayerDataTypes.PlayerDeck = PlayerService.GetPlayerCards(player.UserId)
    
    local cardHand = coroutine.create(function() 

        --logic to get all of the card data in once struct
        for _, cardMetadata in ipairs(playerCards.CardHand) do
            local card : CardTypes.Card? = EntityDirectory.GetEntityById(cardMetadata.CardId)
            if not card then continue end
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

    local success, response = pcall(coroutine.resume, cardHand)
    if not success then
        warn(response) 
    end

     local cardInventory = coroutine.create(function()
            --logic to get all of the card data in once struct
        for _, invMetadata in ipairs(playerCards.CardInventory) do
            local card : CardTypes.Card? = EntityDirectory.GetEntityById(invMetadata.CardId)
            if not card then continue end
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
            })
        end

        --signal that the task is done
        table.insert(Mux, 2)
     end)

    success, response = pcall(coroutine.resume, cardInventory)
    if not success then
        warn(response) 
    end

    repeat task.wait() until #Mux == 2

    return cardPackage
end

function Controller.RollCard(player : Player)
    local card : CardTypes.Card = TopicPoolingService.PublishToTopic("RollService", {
        RequestID = HttpService:GenerateGUID(),
        EventType = "RollCard",
        UserId = player.UserId,
        Timestamp = os.time()
    })

    local playerCards : PlayerDataTypes.PlayerDeck = PlayerService.GetPlayerCards(player.UserId)
    local playerStats : PlayerDataTypes.PlayerStats = PlayerService.GetPlayerStats(player.UserId)
    
    playerStats.General_Stats.TotalCardsDrawn += 1
    table.insert(playerCards.CardInventory, {
        CardId = card.Id,
        SlotNumber = tostring(#playerCards.CardInventory + 1)
    })
    
    return card
end

return Controller