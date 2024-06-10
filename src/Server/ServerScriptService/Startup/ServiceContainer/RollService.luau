--!strict
local CardType = require(game.ReplicatedStorage.Types.Card)
local ServiceTypes = require(game.ReplicatedStorage.Types.ServerServices)
local CardDirectory = require(game.ReplicatedStorage.EntityDirectory)

local Service = {}

function Service.RollCard(player : Player)
    -- Generate a random number between 0 and 1
    type cardData = {Probability : number, Card : CardType.Card} 
    local cardProbabilities : {cardData} = CardDirectory.AggregateByProperty(
        --Filter rule
        function(value : CardType.Card) : boolean
            return value.Type == "Card"
        end,

    --Package rule
        function(value : CardType.Card) : cardData
        
            return {
                Probability = value.Probability,
                Card = value
            }
        end)

    local rand = math.random()

    -- Sort the card probabilities in descending order
    table.sort(cardProbabilities, function(a, b) return a.Probability > b.Probability end)
    
    local selectedCard : CardType.Card? = nil
    -- Initialize the cumulative probability
    local cumulativeProbability = 0

    -- Loop through the card probabilities
    for i, cardProbability in ipairs(cardProbabilities) do
        -- Add the current card's probability to the cumulative probability
        cumulativeProbability = cumulativeProbability + cardProbability.Probability

        -- If the random number is less than the cumulative probability, return the current card
        if rand < cumulativeProbability then
            selectedCard = cardProbability.Card
        end
    end

    -- If no card is selected (which should not happen if the probabilities are correctly defined), return nil
    if not selectedCard then selectedCard = cardProbabilities[math.random(#cardProbabilities)].Card end

    return selectedCard
end

function Service.GetCardById(player : Player, cardId : string)
    return CardDirectory.GetEntityById(cardId) :: CardType.Card
end

function Service.GetCardByName(player : Player, cardName : string)
    return CardDirectory.GetEntityByName(cardName) :: CardType.Card
end

function Service.GetPlayerDeck(player : Player)
    
end

return Service :: ServiceTypes.RollService