--!strict
task.wait(5)
require(game.ReplicatedStorage.ClientNetwork).PostAsync("Test", function(data) warn(data) end, {Help = 2})