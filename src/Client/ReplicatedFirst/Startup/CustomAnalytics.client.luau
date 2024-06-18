--!strict
repeat task.wait() until shared.Loaded

local NetworkClient = require(game.ReplicatedStorage.ClientNetwork)

local GlobalUpdateService = require(game.ReplicatedStorage.Utility.GlobalUpdateService)
local UserInputService : UserInputService = shared.Inject("UserInputService")
local LocalizationService : LocalizationService = shared.Inject("LocalizationService")

local function Device()
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
        return "Mobile"
    elseif not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
        return "Computer"
    else
        return "Other"
    end
end

local lastMove = 0
local timeInGame = 0
local cooldown : number = 0
GlobalUpdateService.AddGlobalUpdate(function(dt : number)
    if cooldown <= 30 then
        cooldown += dt
        return
    end

    cooldown = 0

    NetworkClient.FireServer("Analytics", {
        Timestamp = os.time(),
        UserId = game.Players.LocalPlayer.UserId,
        MousePos = game:GetService("UserInputService"):GetMouseLocation(),
        TimeInGame = timeInGame,
        Device = Device(),
        Country = LocalizationService:GetCountryRegionForPlayerAsync(game.Players.LocalPlayer),
        Language = LocalizationService:GetCountryRegionForPlayerAsync(game.Players.LocalPlayer),
        LastMovement = lastMove,
        LastMoveDifference = os.time() - lastMove
    })

    if game.Players.LocalPlayer.Character then
        local humanoid : Humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid.MoveDirection.Magnitude > 0 then
            lastMove = os.time()
        end
    end

    timeInGame += dt
end) 