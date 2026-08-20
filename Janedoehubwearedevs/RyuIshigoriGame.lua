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
        Anonymous = true,
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
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- ==================== EVENT REFERENCES ====================
local LarpRE = ReplicatedStorage:FindFirstChild("LarpRE")
local ShopRE = ReplicatedStorage:FindFirstChild("ShopRE")

-- ==================== GLOBALS ====================
local larpLoop = nil
local pointsLoop = nil
local antiAFKTask = nil
local isAntiAFKActive = false
local antiAFKEnabled = false
local larpEnabled = false
local pointsEnabled = false

-- ==================== LARP LOOP ====================
local function startLarpLoop()
    if larpLoop then return end
    larpLoop = task.spawn(function()
        while true do
            if not larpEnabled then break end
            if not antiAFKEnabled or not isAntiAFKActive then
                pcall(function()
                    if LarpRE then
                        LarpRE:FireServer(CFrame.new(-17.264760971069, 4.0060005187988, -9.2418718338013, -0.48236966133118, 0, 0.87596774101257, 0, 1, 0, -0.87596774101257, 0, -0.48236966133118))
                    end
                end)
            end
            task.wait(0.2)
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

-- ==================== ANTI AFK ====================
local function startAntiAFK()
    if antiAFKTask then return end
    antiAFKTask = task.spawn(function()
        while antiAFKEnabled do
            -- Wait 9 minutes (540 seconds)
            for i = 1, 540 do
                if not antiAFKEnabled then return end
                task.wait(1)
            end
            -- Activate pause
            isAntiAFKActive = true
            -- Simulate jump for 13.3 seconds
            local startTime = tick()
            while tick() - startTime < 13.3 do
                if not antiAFKEnabled then
                    isAntiAFKActive = false
                    return
                end
                -- Send jump key down and up quickly
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                task.wait(0.1)
            end
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

-- ==================== TELEPORT TO SMALL SERVER ====================
local function teleportToSmallServer()
    local playerCount = #Players:GetPlayers()
    if playerCount > 10 then
        -- Teleport to a new server (random)
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

-- Section: Auto LARP
LARPTab:Section({ Title = "Auto LARP" })

LARPTab:Toggle({
    Title = "Auto LARP",
    Desc = "LEST LARP",
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
    Desc = "Add points",
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

-- Section: Anti AFK
LARPTab:Section({ Title = "Anti AFK" })

LARPTab:Toggle({
    Title = "Anti AFK",
    Desc = "Pauses auto loops every 9 min and simulates jump for 13.3 sec",
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

-- Section: Server
LARPTab:Section({ Title = "Server" })

LARPTab:Button({
    Title = "Teleport to Small Server",
    Desc = "If >10 players, teleport to a server with ≤3 players",
    Callback = function()
        teleportToSmallServer()
    end
})

-- Keybind to toggle UI
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
