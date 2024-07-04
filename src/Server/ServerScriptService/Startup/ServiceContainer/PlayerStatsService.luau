--!strict
local DataStoreService : DataStoreService = shared.Inject("DataStoreService")
local PlayerStats = require(game.ReplicatedStorage.Types.PlayerData)

local _PlayerStatsCache : {[number] : PlayerStats.PlayerStats} = {}
local Service = {}

function LoadPlayerStats(player : Player, data)
    local statsStoreForPlayer : DataStore = DataStoreService:GetDataStore(`Stats_{player.UserId}`)    
    local playerStats : PlayerStats.PlayerStats = statsStoreForPlayer:GetAsync("Data_V3")
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
        --statsStoreForPlayer:SetAsync("Data_V3", playerStats)
    end

    warn("Loaded player stats for player: ", player.UserId)

    data.PlayerStats = playerStats

    _PlayerStatsCache[player.UserId] = playerStats

    return data
end

function Service.LoadPlayerStats(player : Player, metadata)
    local data = metadata.playerDataRef
    return LoadPlayerStats(player, data)
end


function Service.GetPlayerStats(userId : number) : any?
   return _PlayerStatsCache[userId]
end

return Service