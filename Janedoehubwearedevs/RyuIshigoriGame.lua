-- ==================== WINDUI INTERFACE ====================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Ryu Ishigori Hub",
    Icon = "skull",
    Author = "Ryu Ishigori Hub",
    Folder = "RyuIshigoriHub",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.45,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    Background = "rbxassetid://98111119882509",
    User = {
        Enabled = true,
        Anonymous = false,
    },
    KeySystem = {
        Key = { "1234", "5678" },
        Note = "Example Key System.",
        Thumbnail = {
            Image = "rbxassetid://95666152750961",
            Title = "Thumbnail",
        },
        URL = "YOUR LINK TO GET KEY",
        SaveKey = false,
    },
})

WindUI:GetTransparency(false)
WindUI:GetWindowSize(52)

-- ==================== SERVICES ====================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

-- ==================== EVENT REFERENCES ====================
local LarpRE = ReplicatedStorage:FindFirstChild("LarpRE")
local ShopRE = ReplicatedStorage:FindFirstChild("ShopRE")
local RebirthRE = ReplicatedStorage:FindFirstChild("RebirthRE")
local ShakeRE = ReplicatedStorage:FindFirstChild("ShakeRE")

-- ==================== GLOBALS ====================
local larpLoop = nil
local pointsLoop = nil
local rebirthLoop = nil
local antiAFKTask = nil
local cameraShakeBlock = nil
local isAntiAFKActive = false
local antiAFKEnabled = false
local larpEnabled = false
local pointsEnabled = false
local rebirthEnabled = false
local antiCameraEnabled = false

-- Anti-Lag variables
local antiLagConnections = {}
local antiLagActive = false
local antiLagPlayerConnections = {} -- for each player's character added

-- ==================== LARP LOOP (0.1s) ====================
local function startLarpLoop()
    if larpLoop then return end
    larpLoop = task.spawn(function()
        while true do
            if not larpEnabled then break end
            if not antiAFKEnabled or not isAntiAFKActive then
                pcall(function()
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = CFrame.new(-72, 79, -100)
                    end
                    if LarpRE then
                        LarpRE:FireServer(CFrame.new(-17.264760971069, 4.0060005187988, -9.2418718338013, -0.48236966133118, 0, 0.87596774101257, 0, 1, 0, -0.87596774101257, 0, -0.48236966133118))
                    end
                end)
            end
            task.wait(0.1)
        end
    end)
end

local function stopLarpLoop()
    if larpLoop then
        task.cancel(larpLoop)
        larpLoop = nil
    end
end

-- ==================== POINTS LOOP ====================
local function startPointsLoop()
    if pointsLoop then return end
    pointsLoop = task.spawn(function()
        while true do
            if not pointsEnabled then break end
            if not antiAFKEnabled or not isAntiAFKActive then
                pcall(function()
                    if ShopRE then
                        ShopRE:FireServer("Output", true)
                    end
                end)
            end
            task.wait(0.1)
        end
    end)
end

local function stopPointsLoop()
    if pointsLoop then
        task.cancel(pointsLoop)
        pointsLoop = nil
    end
end

-- ==================== REBIRTH LOOP (0.1s) ====================
local function startRebirthLoop()
    if rebirthLoop then return end
    rebirthLoop = task.spawn(function()
        while true do
            if not rebirthEnabled then break end
            if not antiAFKEnabled or not isAntiAFKActive then
                pcall(function()
                    if RebirthRE then
                        RebirthRE:FireServer("REBIRTH")
                    end
                end)
            end
            task.wait(0.1)
        end
    end)
end

local function stopRebirthLoop()
    if rebirthLoop then
        task.cancel(rebirthLoop)
        rebirthLoop = nil
    end
end

-- ==================== ANTI AFK (reset character every 9 minutes) ====================
local function startAntiAFK()
    if antiAFKTask then return end
    antiAFKTask = task.spawn(function()
        while antiAFKEnabled do
            for i = 1, 540 do
                if not antiAFKEnabled then return end
                task.wait(1)
            end
            isAntiAFKActive = true
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    char:BreakJoints()
                end
            end)
            task.wait(2)
            isAntiAFKActive = false
        end
    end)
end

local function stopAntiAFK()
    if antiAFKTask then
        task.cancel(antiAFKTask)
        antiAFKTask = nil
    end
    isAntiAFKActive = false
end

-- ==================== CAMERA SHAKE BLOCK ====================
local function toggleCameraShake(state)
    antiCameraEnabled = state
    if state then
        if ShakeRE then
            cameraShakeBlock = ShakeRE.OnClientEvent:Connect(function()
                pcall(function()
                    local cam = workspace.CurrentCamera
                    if cam then
                        task.spawn(function()
                            local originalCF = cam.CFrame
                            task.wait(0.01)
                            cam.CFrame = originalCF
                        end)
                    end
                end)
            end)
        end
    else
        if cameraShakeBlock then
            cameraShakeBlock:Disconnect()
            cameraShakeBlock = nil
        end
    end
end

-- ==================== ANTI LAG (Map & Players) ====================
local function applyAntiLag(state)
    antiLagActive = state

    -- Helper: hide all BaseParts in an instance
    local function hideAllParts(instance)
        for _, child in ipairs(instance:GetDescendants()) do
            if child:IsA("BasePart") then
                child.Transparency = 1
            end
        end
    end

    -- Helper: restore all BaseParts in an instance
    local function restoreAllParts(instance)
        for _, child in ipairs(instance:GetDescendants()) do
            if child:IsA("BasePart") then
                child.Transparency = 0
            end
        end
    end

    if state then
        -- Hide existing parts in workspace
        hideAllParts(workspace)

        -- Hide existing players' characters
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then
                hideAllParts(player.Character)
            end
            -- Connect to CharacterAdded for future characters
            local conn = player.CharacterAdded:Connect(function(char)
                hideAllParts(char)
            end)
            table.insert(antiLagPlayerConnections, conn)
        end

        -- Watch for new parts added to workspace
        local connWorkspace = workspace.DescendantAdded:Connect(function(desc)
            if desc:IsA("BasePart") then
                desc.Transparency = 1
            end
        end)
        table.insert(antiLagConnections, connWorkspace)

        -- Watch for new players
        local connPlayer = Players.PlayerAdded:Connect(function(player)
            -- Hide character when it appears
            local charConn = player.CharacterAdded:Connect(function(char)
                hideAllParts(char)
            end)
            table.insert(antiLagPlayerConnections, charConn)
            -- If already has character, hide it
            if player.Character then
                hideAllParts(player.Character)
            end
        end)
        table.insert(antiLagConnections, connPlayer)

    else
        -- Restore visibility
        restoreAllParts(workspace)
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then
                restoreAllParts(player.Character)
            end
        end

        -- Disconnect workspace connections
        for _, conn in ipairs(antiLagConnections) do
            conn:Disconnect()
        end
        antiLagConnections = {}

        -- Disconnect player CharacterAdded connections
        for _, conn in ipairs(antiLagPlayerConnections) do
            conn:Disconnect()
        end
        antiLagPlayerConnections = {}
    end
end

-- ==================== TELEPORT TO SMALL SERVER ====================
local function teleportToSmallServer()
    local playerCount = #Players:GetPlayers()
    if playerCount > 10 then
        TeleportService:Teleport(game.PlaceId)
        WindUI:Notify({
            Title = "Teleporting",
            Content = "Current server has " .. playerCount .. " players. Teleporting to a smaller server...",
            Duration = 3,
            Icon = "zap"
        })
    else
        WindUI:Notify({
            Title = "Server OK",
            Content = "Current server has " .. playerCount .. " players. No need to teleport.",
            Duration = 3,
            Icon = "check-circle"
        })
    end
end

-- ==================== UI ====================
local LARPTab = Window:Tab({ Title = "LARP", Icon = "home" })

LARPTab:Section({ Title = "Auto LARP" })

LARPTab:Toggle({
    Title = "Auto LARP",
    Desc = "Lest Larp...",
    Value = false,
    Callback = function(state)
        larpEnabled = state
        if state then
            startLarpLoop()
        else
            stopLarpLoop()
        end
    end
})

LARPTab:Toggle({
    Title = "Auto LARP Points",
    Desc = "add points",
    Value = false,
    Callback = function(state)
        pointsEnabled = state
        if state then
            startPointsLoop()
        else
            stopPointsLoop()
        end
    end
})

LARPTab:Toggle({
    Title = "Auto REBIRTH",
    Desc = "recommend",
    Value = false,
    Callback = function(state)
        rebirthEnabled = state
        if state then
            startRebirthLoop()
        else
            stopRebirthLoop()
        end
    end
})

LARPTab:Section({ Title = "Anti AFK" })

LARPTab:Toggle({
    Title = "Anti AFK",
    Desc = "Resets character every 9 minutes to prevent AFK kick (recommend)",
    Value = false,
    Callback = function(state)
        antiAFKEnabled = state
        if state then
            startAntiAFK()
        else
            stopAntiAFK()
        end
    end
})

LARPTab:Section({ Title = "Server" })

LARPTab:Button({
    Title = "Teleport to Small Server",
    Desc = "If >10 players, teleport to a server with ≤3 players",
    Callback = function()
        teleportToSmallServer()
    end
})

-- Visual Tab
local VisualTab = Window:Tab({ Title = "Visual", Icon = "eye" })

VisualTab:Section({ Title = "Camera" })

VisualTab:Toggle({
    Title = "Anti movimento de câmera",
    Desc = "Blocks camera shake from ShakeRE (experimental)",
    Value = false,
    Callback = function(state)
        toggleCameraShake(state)
    end
})

VisualTab:Section({ Title = "Performance" })

VisualTab:Toggle({
    Title = "Anti Lag Map/Player",
    Desc = "Makes map and players invisible (not deleted) to reduce lag",
    Value = false,
    Callback = function(state)
        applyAntiLag(state)
    end
})

-- Keybind to toggle UI (on LARP tab)
LARPTab:Keybind({
    Title = "Toggle UI Key",
    Desc = "Key to open/close the interface",
    Value = "RightShift",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

-- ==================== NOTIFICATION ====================
WindUI:Notify({
    Title = "Ryu Ishigori Hub",
    Content = "Script loaded! Enjoy your LARP experience.",
    Duration = 5,
    Icon = "zap"
})

-- Default toggle key
Window:SetToggleKey(Enum.KeyCode.RightShift)
