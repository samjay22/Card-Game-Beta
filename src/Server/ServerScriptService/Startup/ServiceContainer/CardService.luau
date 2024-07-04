--!strict
local PlayerDataTypes = require(game.ReplicatedStorage.Types.PlayerData)

local DataStoreService : DataStoreService = shared.Inject("DataStoreService")

local CardDataCache : {[number] : PlayerDataTypes.PlayerDeck} = {}
local Service = {}

function LoadPlayerCards(player : Player, data)
    local cardStoreForPlayer : DataStore = DataStoreService:GetDataStore(`Cards_{player.UserId}`)    
    local playerCards : PlayerDataTypes.PlayerDeck = cardStoreForPlayer:GetAsync("Data_V3")
    if not playerCards then
        playerCards = {
            CardInventory = {
                {
                    CardId = "c387328f-0972-4ff9-8c81-f0c6d0e1zg04",
                    SlotNumber = "1",
                }
            },
            CardHand = {
                {
                    CardId = "c387328f-0972-4ff9-8c81-f0c6d0e1zg04",
                    SlotNumber = "1"
            },
            }
        }

        -- Save the card data
        --cardStoreForPlayer:SetAsync("Data_V3", playerCards)
    end

    warn("Loaded player cards for player: ", player.UserId)

    CardDataCache[player.UserId] = playerCards
    
    data.CardData = playerCards

    return data
end


function Service.LoadPlayerCards(player : Player, metadata : any)
    local data = metadata.playerDataRef
    return LoadPlayerCards(player, data)
end

function Service.GetPlayerCards(userId : number | string) : any?
    return CardDataCache[userId]
end


return Service