--!strict
local CardTypes = require(game.ReplicatedStorage.Types.Card)
local PlayerDataTypes = require(game.ReplicatedStorage.Types.PlayerData)
local ServerServiceTypes = require(game.ReplicatedStorage.Types.ServerServices)
local SharedServiceTypes = require(game.ReplicatedStorage.Types.SharedServices)

local PlayerStatsService : ServerServiceTypes.PlayerStatsService = shared.Inject("PlayerStatsService")
local TopicPoolingService : SharedServiceTypes.TopicPoolingService = shared.Inject("TopicPoolingService")
local CardService : ServerServiceTypes.CardService<CardTypes.Card> = shared.Inject("CardService")
local EntityDirectory : SharedServiceTypes.EntityService = shared.Inject("EntityService")
local HttpService : HttpService = shared.Inject("HttpService")

local Controller = {}

function Controller.GetCardsForPlayer(player : Player)
    local cardPackage = {
        Hand = {},
        Inventory = {},
    }

    local Mux = {}
    local playerCards : PlayerDataTypes.PlayerDeck = CardService.GetPlayerCards(player.UserId)
    
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
                ResistanceType = EntityDirectory.GetEntityById(card.ResistanceType),
                WeaknessType = EntityDirectory.GetEntityById(card.WeaknessType),

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
                ResistanceType = EntityDirectory.GetEntityById(card.ResistanceType),
                WeaknessType = EntityDirectory.GetEntityById(card.WeaknessType),

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
    local onCompleted : BindableEvent = shared.NewInstance("BindableEvent", 5)
    local cardToReturn : CardTypes.Card = nil
    onCompleted.Event:Once(function(okay : boolean, response : any)
       if okay then
            cardToReturn = response
       else
           warn(response)
       end

    end)

    TopicPoolingService.PublishToTopic("RollService", {
        RequestID = HttpService:GenerateGUID(),
        EventType = "RollCard",
        UserId = player.UserId,
        Timestamp = os.time(),

        OnTopicCompleted = onCompleted,
    })

    repeat task.wait() until cardToReturn

    return cardToReturn
end

return Controller