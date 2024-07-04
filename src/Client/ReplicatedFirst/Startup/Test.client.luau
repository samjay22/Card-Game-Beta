--!strict
task.wait(5)


local a : number = 0
for i = 0, 5 do
    task.spawn(function()
        require(game.ReplicatedStorage.ClientNetwork).PostAsync("GetCardsForPlayer", function(data) a += 1 warn(data) end)
    end)
end

-- for i = 0, 2500 do
--     task.spawn(function()
--         require(game.ReplicatedStorage.ClientNetwork).PostAsync("RollCard", function(data) a += 1 warn(data) end)
--     end)
-- end

