--!strict

local DataStoreService : DataStoreService = game:GetService("DataStoreService")

local PlayerStats = require(game.ReplicatedStorage.Types.PlayerData)

local _DataCache : {PlayerStats.PlayerDataType} = {}
local Service = {}

function LoadPlayerCards(player : Player, data)
    local cardStoreForPlayer : DataStore = DataStoreService:GetDataStore(`Cards_{player.UserId}`)    
    local playerCards : PlayerStats.PlayerDeck = cardStoreForPlayer:GetAsync("Data_V1")
    if not playerCards then
        playerCards = {
            CardInventory = {},
            CardHand = {}
        }

        -- Save the card data
        cardStoreForPlayer:SetAsync("Data_V1", playerCards)
    end

    data.CardData = playerCards
end

function LoadPlayerStats(player : Player, data)
    local statsStoreForPlayer : DataStore = DataStoreService:GetDataStore(`Stats_{player.UserId}`)    
    local playerStats : PlayerStats.PlayerStats = statsStoreForPlayer:GetAsync("Data_V1")
    if not playerStats then
        playerStats = {
            PVE_Stats = {
                Wins = 0,
                Losses = 0,
                Draws = 0,
                Rating = 0,
                WinRate = 0,
                TotalGames = 0,
                WinStreak = 0,
                LossStreak = 0,
                CurrentStreak = 0,
                MaxStreak = 0,
            },

            PVP_Stats = {
                Wins = 0,
                Losses = 0,
                Draws = 0,
                Rating = 0,
                WinRate = 0,
                TotalGames = 0,
                WinStreak = 0,
                LossStreak = 0,
                CurrentStreak = 0,
                MaxStreak = 0,
            },
            
            General_Stats = {
                TotalDamageDealt = 0,
                TotalDamageReceived = 0,
                TotalCardsDrawn = 0,
                TotalCardsLost = 0,
                TotalCardsDiscarded = 0,
                TotalTimePlayed = 0,
            }
        }
        -- Save the stats data
        statsStoreForPlayer:SetAsync("Data_V1", playerStats)
    end

    data.PlayerStats = playerStats
end

function Service.LoadPlayerData(player : Player)
   local Data : {UserId : number, CardData : any, PlayerStats : any} = {
    UserId = player.UserId,
    CardData = nil,
    PlayerStats = nil
}
    task.spawn(LoadPlayerCards, player, Data)
    task.spawn(LoadPlayerStats, player, Data)

    repeat task.wait() until Data.CardData and Data.PlayerStats

    table.insert(_DataCache, Data)

    return Data
end

function Service.GetPlayerData(userId : number)
    local playerData = nil
    for _, data in ipairs(_DataCache) do
        if data.UserId == userId then
            playerData = data
        end
    end

    return playerData
end

function Service.GetPlayerCards(userId : number) : any?
    local playerData = Service.GetPlayerData(userId)
    if playerData then
        return playerData.CardData
    end

    return nil
end

function Service.GetPlayerStats(userId : number) : any?
    local playerData = Service.GetPlayerData(userId)
    if playerData then
        return playerData.PlayerStats
    end

    return nil
end

return Service