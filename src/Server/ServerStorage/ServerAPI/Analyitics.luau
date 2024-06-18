local HttpService = game:GetService("HttpService")

--!strict
local HttpService : HttpService = shared.Inject("HttpService")
local DataStoreService : DataStoreService = shared.Inject("DataStoreService")
local CachedStores = {}

return {
    Analytics = function(player : Player, payload : any)
        if not CachedStores[player.UserId] then
            CachedStores[player.UserId] = {
                LastUpdate = 0,
                Store = DataStoreService:GetDataStore(`Analytics_{player.UserId}`),
                AnalyticsFeed = {payload},
            }
        end

        if player.UserId == 0 then
            return
        end

        table.insert(CachedStores[player.UserId].AnalyticsFeed, payload)
        --To early to award        
        if CachedStores[player.UserId].LastUpdate > os.clock() then return end
        CachedStores[player.UserId].LastUpdate = os.clock() + 6
        CachedStores[player.UserId].Store:UpdateAsync("Analytics", function(old)
            local dataToSave = CachedStores[player.UserId].AnalyticsFeed

            if old then
                old = HttpService:JSONDecode(old)
                for _, v in dataToSave do
                    table.insert(old, v)
                end

                dataToSave = old
            end
            
            CachedStores[player.UserId].AnalyticsFeed = {}

            return HttpService:JSONEncode(dataToSave)
        end)
    end
}