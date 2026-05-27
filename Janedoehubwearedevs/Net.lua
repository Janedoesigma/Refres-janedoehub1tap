local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "JANE DOE HUB",
    Icon = "axe", 
    Author = "FORSAKEN [NOS]/ version: 0.1",
    Folder = "JaneDoeHub",
    
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
    
    -- Custom Background
    Background = "rbxassetid://95666152750961", 
    
    User = {
        Enabled = true,
        Anonymous = false,
    },
})

WindUI:GetTransparency(false)
WindUI:GetWindowSize(52)

----------------------------------------------------------------------------------
-- HITBOX EXTENDER CORE LOGIC
----------------------------------------------------------------------------------
local HitboxModule = {}
getgenv().emergency_stop = false

local function StudsIntoPower(studs) return (studs * 6) end

function HitboxModule:Toggle(state)
    if state then
        getgenv().emergency_stop = false
        task.spawn(function()
            local default_studs = 10
            local default_duration = 5
            
            while not getgenv().emergency_stop do
                local distance = StudsIntoPower(default_studs)
                local start = tick()
                
                repeat 
                    game:GetService("RunService").Heartbeat:Wait()
                    local lp = game:GetService("Players").LocalPlayer
                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = lp.Character.HumanoidRootPart
                        local oldVel = hrp.Velocity
                        hrp.Velocity = oldVel * distance + (hrp.CFrame.LookVector * distance)
                        game:GetService("RunService").RenderStepped:Wait()
                        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                            hrp.Velocity = oldVel
                        end
                    end
                until tick() - start > tonumber(default_duration) or getgenv().emergency_stop
                task.wait(0.1)
            end
        end)
    else
        getgenv().emergency_stop = true
    end
end

----------------------------------------------------------------------------------
-- ESP CORE LOGIC
----------------------------------------------------------------------------------
local Players = game.Workspace:FindFirstChild("Players") or game:GetService("Workspace").Players

getgenv().ESP_Killers = false
getgenv().ESP_Survivors = false
getgenv().ESP_Generators = false

local function createOutlineESP(model, outlineColor, fillColor)
    if model:FindFirstChildOfClass("Highlight") then return end
    local highlight = Instance.new("Highlight")
    highlight.Parent = model
    highlight.Adornee = model
    highlight.FillTransparency = 0.75
    highlight.FillColor = fillColor
    highlight.OutlineColor = outlineColor
    highlight.OutlineTransparency = 0 
end

local function clearESPFromModel(model)
    if model then
        for _, highlight in pairs(model:GetChildren()) do
            if highlight:IsA("Highlight") then
                highlight:Destroy()
            end
        end
    end
end

local function clearAllESP()
    for _, folder in pairs(Players:GetChildren()) do
        for _, obj in pairs(folder:GetChildren()) do
            clearESPFromModel(obj)
        end
    end
    local generatorsFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")
    if generatorsFolder then
        for _, obj in pairs(generatorsFolder:GetChildren()) do
            clearESPFromModel(obj)
        end
    end
end

task.spawn(function()
    while true do
        if getgenv().ESP_Killers or getgenv().ESP_Survivors or getgenv().ESP_Generators then
            local killersGroup = Players:FindFirstChild("Killers")
            if killersGroup then
                if getgenv().ESP_Killers then
                    for _, obj in pairs(killersGroup:GetChildren()) do
                        if obj:FindFirstChildOfClass("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                            createOutlineESP(obj, Color3.new(1, 0, 0), Color3.new(1, 0.5, 0.5))
                        end
                    end
                else
                    for _, obj in pairs(killersGroup:GetChildren()) do clearESPFromModel(obj) end
                end
            end

            local survivorsGroup = Players:FindFirstChild("Survivors")
            if survivorsGroup then
                if getgenv().ESP_Survivors then
                    for _, obj in pairs(survivorsGroup:GetChildren()) do
                        if obj:FindFirstChildOfClass("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                            createOutlineESP(obj, Color3.new(0, 1, 0), Color3.new(0.5, 1, 0.5))
                        end
                    end
                else
                    for _, obj in pairs(survivorsGroup:GetChildren()) do clearESPFromModel(obj) end
                end
            end

            if getgenv().ESP_Generators then
                local generatorsFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")
                if generatorsFolder then
                    for _, obj in pairs(generatorsFolder:GetChildren()) do
                        if obj:IsA("Model") and obj.Name == "Generator" then
                            createOutlineESP(obj, Color3.new(1, 1, 0), Color3.new(1, 1, 0.5))
                        end
                    end
                end
            else
                local generatorsFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")
                if generatorsFolder then
                    for _, obj in pairs(generatorsFolder:GetChildren()) do
                        if obj.Name == "Generator" then clearESPFromModel(obj) end
                    end
                end
            end
        else
            clearAllESP()
        end
        task.wait(2)
    end
end)

----------------------------------------------------------------------------------
-- HOME TAB
----------------------------------------------------------------------------------
local HomeTab = Window:Tab({
    Title = "Home",
    Icon = "home",
})

HomeTab:Section({ Title = "Combat Exploits" })

HomeTab:Toggle({
    Title = "Hitbox Extender",
    Desc = "Automatically amplifies attack range",
    Value = false,
    Callback = function(state)
        HitboxModule:Toggle(state)
    end
})

HomeTab:Slider({
    Title = "Aim Bot Meter",
    Step = 0.5,
    Value = { Min = 0, Max = 100.5, Default = 50 },
    Callback = function(v)
        print("Aim Meter set to: " .. v)
    end
})

HomeTab:Section({ Title = "Stamina & Movement" })

local Sprinting = game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting
local stamina = require(Sprinting)

local s_max = 100
local s_min = -20
local s_gain = 100
local s_loss = 5
local s_speed = 40
local sprintToggleState = false

HomeTab:Slider({
    Title = "Max Stamina",
    Value = { Min = 0, Max = 500, Default = 100 },
    Callback = function(v) 
        s_max = v 
        if sprintToggleState then stamina.MaxStamina = v end
    end
})

HomeTab:Slider({
    Title = "Sprint Speed",
    Value = { Min = 16, Max = 200, Default = 40 },
    Callback = function(v) 
        s_speed = v 
        if sprintToggleState then stamina.SprintSpeed = v end
    end
})

HomeTab:Toggle({
    Title = "Sprint Speed / Infinite Stamina",
    Desc = "Applies customized speed and stamina stats",
    Value = false,
    Callback = function(state)
        sprintToggleState = state
        if state then
            stamina.MaxStamina = s_max
            stamina.MinStamina = s_min
            stamina.StaminaGain = s_gain
            stamina.StaminaLoss = s_loss
            stamina.SprintSpeed = s_speed
            stamina.StaminaLossDisabled = true
        else
            stamina.MaxStamina = 100
            stamina.MinStamina = 0
            stamina.StaminaLossDisabled = false
            stamina.SprintSpeed = 25 
        end
    end
})

----------------------------------------------------------------------------------
-- ESP TAB
----------------------------------------------------------------------------------
local ESPTab = Window:Tab({
    Title = "ESP",
    Icon = "eye",
})

ESPTab:Section({ Title = "Visuals & Wallhacks" })

ESPTab:Toggle({
    Title = "ESP Killers",
    Desc = "Highlights killers through walls in Red",
    Value = false,
    Callback = function(state)
        getgenv().ESP_Killers = state
    end
})

ESPTab:Toggle({
    Title = "ESP Survivors",
    Desc = "Highlights survivors through walls in Green",
    Value = false,
    Callback = function(state)
        getgenv().ESP_Survivors = state
    end
})

ESPTab:Toggle({
    Title = "ESP Generators",
    Desc = "Highlights objectives and generators in Yellow",
    Value = false,
    Callback = function(state)
        getgenv().ESP_Generators = state
    end
})

----------------------------------------------------------------------------------
-- SETTINGS TAB
----------------------------------------------------------------------------------
local ConfigTab = Window:Tab({
    Title = "Settings",
    Icon = "settings",
})

ConfigTab:Section({ Title = "Interface Customization" })

ConfigTab:Toggle({
    Title = "Transparent UI",
    Value = true,
    Callback = function(state)
        Window:ToggleTransparency(state)
    end
})

ConfigTab:Keybind({
    Title = "Toggle UI Key",
    Value = "RightShift",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

-- Welcome Notification
WindUI:Notify({
    Title = "Jane Doe Hub",
    Content = "Successfully loaded! Press RightShift to hide/show.",
    Duration = 4,
    Icon = "check"
})
