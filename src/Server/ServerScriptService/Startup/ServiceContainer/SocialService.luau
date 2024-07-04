--!strict

local DataStoreService : DataStoreService = shared.Inject("DataStoreService")
local HttpService : HttpService = shared.Inject("HttpService")

local Utility = require(game.ReplicatedStorage.Utility.UtilityMethods)

local CodeStore : DataStore = DataStoreService:GetDataStore("CodeStore")

local Service = {}

function Service.RedeemCodeForTwitter(player : Player, code : string)
    local key : string = player.UserId .. code
    local okay, result = Utility.Try(function()
        return CodeStore:GetAsync(key)
    end)

    if okay and result then
        return "Code already redeemed"
    end
    
    local success, result = Utility.Try(function()
        return CodeStore:SetAsync(key, true)
    end)
end


return Service