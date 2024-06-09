--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
--!strict
local Network = require(game.ServerStorage.ServerNetwork)
return {
    ClientResponse = Network.ResponseAsync
}