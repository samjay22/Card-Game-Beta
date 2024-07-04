--!strict
local CardTypes = require(game.ReplicatedStorage.Types.Card)
local MatchTypes = require(game.ReplicatedStorage.Types.MatchTypes)
local ServerServiceTypes = require(game.ReplicatedStorage.Types.ServerServices)
local SharedServiceTypes = require(game.ReplicatedStorage.Types.SharedServices)

local GlobalUpdateService = require(game.ReplicatedStorage.Utility.GlobalUpdateService)
local CardService : ServerServiceTypes.CardService<CardTypes.Card> = shared.Inject("CardService")
local EntityDirectory : SharedServiceTypes.EntityService = shared.Inject("EntityService")
local HttpService : HttpService = shared.Inject("HttpService")

local _ActivePVEMatches : {MatchTypes.PVEMatch} = {}

local Service = {}

local function ConvertDeckToEntityList(deck)
    local entityList = {}
    for _, card in ipairs(deck) do
        local entity = EntityDirectory.GetEntityById(card.Id)
        table.insert(entityList, {
            Id = entity.Id,
            Rarity = entity.Rarity,
            DamageType = entity.DamageType,
            ResistanceType = entity.ResistanceType,
            WeaknessType = entity.WeaknessType,
            Variant = entity.Variant,

            Health = entity.Health,
            DamageAmount = entity.DamageAmount,
            ResistanceAmount = entity.ResistanceAmount,
            WeaknessAmount = entity.WeaknessAmount
        })
    end
    return entityList
end

function Service.StartMatch(matchType : string, userId : number, npcId : string)
    if matchType == "PVE" then
        local newMatch : MatchTypes.PVEMatch = {
            MatchID = HttpService:GenerateGUID(),
            MatchStart = os.clock(),

            DeckData = {
                Player = CardService.GetPlayerCards(userId),
                NPC = EntityDirectory.GetEntityById(npcId).Deck
            }
        }

        table.insert(_ActivePVEMatches, newMatch)

        return newMatch
    end
end

GlobalUpdateService.AddGlobalUpdate(function(dt)
    for _, match in ipairs(_ActivePVEMatches) do

    end
end)

return Service