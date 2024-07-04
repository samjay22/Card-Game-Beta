--!strict
local CardType = require(game.ReplicatedStorage.Types.Card)
local ServiceTypes = require(game.ReplicatedStorage.Types.ServerServices)
local CardDirectory = shared.Inject("EntityService")

local Service = {}

function Service.RollCard(player : Player, metadata : any)
    -- Generate a random number between 0 and 1
    type cardData = {Rarity : number, Card : CardType.Card} 
    local cardProbabilities : {cardData} = CardDirectory.AggregateByProperty(
        --Filter rule
        function(value : CardType.Card) : boolean
            return value.Type == "Card"
        end,

    --Package rule
        function(value : CardType.Card) : cardData
            return {
                Rarity = value.Rarity,
                Card = value
            }
        end)

    -- Sort the card probabilities in descending order
    table.sort(cardProbabilities, function(a, b) return a.Rarity > b.Rarity end)
        
    local rand = math.random()
    local selectedCard : CardType.Card? = nil

    for _, cardData in ipairs(cardProbabilities) do
        if rand < cardData.Rarity then
            selectedCard = cardData.Card
            break
        end
        rand -= cardData.Rarity
    end

    -- If no card is selected (which should not happen if the probabilities are correctly defined), return nil
    if not selectedCard then selectedCard = cardProbabilities[math.random(#cardProbabilities)].Card end
    
    return selectedCard
end

return Service :: ServiceTypes.RollService<CardType.Card>