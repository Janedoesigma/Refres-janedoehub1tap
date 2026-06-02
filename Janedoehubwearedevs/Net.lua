local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "JANE DOE HUB",
    Icon = "axe", 
    Author = "FORSAKEN [NOS]/ version: 0.1.5",
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
    
    Background = "rbxassetid://98866268394739", 
    
    User = {
        Enabled = true,
        Anonymous = true,
    },
})

WindUI:GetTransparency(false)
WindUI:GetWindowSize(52)

-- Global variables & Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local NetworkRemote = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent")

----------------------------------------------------------------------------------
-- CONFIGURATION STATES
----------------------------------------------------------------------------------
getgenv().emergency_stop = false
getgenv().ESP_Killers = false
getgenv().ESP_Survivors = false
getgenv().ESP_Generators = false

-- Aim Bot Configs
local aimBotActive = false
local aimBotMeter = 50.0
local aimBotStuds = 50.0
local aimBotSmoothness = 0.5
local antiBaitActive = false
local currentWeapon = "punch"

-- Automations Configs
local autoTrickActive = false
local studsWallLimit = 10
local antiStunActive = false

-- Environment Configs
local fullLightActive = false
local removeSkyActive = false
local lowGraphicsActive = false
local originalLightingSettings = {
    Ambient = Lighting.Ambient,
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime
}

----------------------------------------------------------------------------------
-- WALL CHECK & TARGET FILTER LOGIC (ANTI-BAIT)
----------------------------------------------------------------------------------
local function isTargetVisible(targetPart)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return false end
    
    local origin = LocalPlayer.Character.HumanoidRootPart.Position
    local direction = targetPart.Position - origin
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, targetPart.Parent, Workspace:FindFirstChild("Players")}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    
    local raycastResult = Workspace:Raycast(origin, direction, raycastParams)
    
    -- If nothing solid blocks the path, return true (target is clear/visible)
    if not raycastResult then
        return true
    end
    return false
end

local function getClosestTarget(maxDistance)
    local closestTarget = nil
    local shortestDistance = maxDistance

    local playersFolder = Workspace:FindFirstChild("Players")
    if playersFolder then
        for _, group in pairs(playersFolder:GetChildren()) do
            -- Target identification matching Killer patterns
            if string.find(group.Name, "Killer") or string.find(group.Name, "Ki") or group.Name == "Killers" then
                for _, target in pairs(group:GetChildren()) do
                    if target:IsA("Model") and target:FindFirstChild("HumanoidRootPart") and target ~= LocalPlayer.Character then
                        local hrp = target.HumanoidRootPart
                        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                        
                        if distance < shortestDistance then
                            -- Apply Anti-Bait visibility wall obstruction check filter
                            if antiBaitActive then
                                if isTargetVisible(hrp) then
                                    shortestDistance = distance
                                    closestTarget = target
                                end
                            else
                                shortestDistance = distance
                                closestTarget = target
                            end
                        end
                    end
                end
            end
        end
    end
    return closestTarget
end

----------------------------------------------------------------------------------
-- CORE ATTACK & LOCK-ON LOOP ENGINE
----------------------------------------------------------------------------------
task.spawn(function()
    local lastAttack = 0
    while true do
        RunService.RenderStepped:Wait()
        if aimBotActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local target = getClosestTarget(aimBotStuds)
            if target and target:FindFirstChild("HumanoidRootPart") then
                local myHrp = LocalPlayer.Character.HumanoidRootPart
                local targetHrp = target.HumanoidRootPart
                
                -- Dynamic Tracking Alignments
                local targetLookPos = Vector3.new(targetHrp.Position.X, myHrp.Position.Y, targetHrp.Position.Z)
                myHrp.CFrame = myHrp.CFrame:Lerp(CFrame.new(myHrp.Position, targetLookPos), aimBotSmoothness)
                
                local camera = Workspace.CurrentCamera
                camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, targetHrp.Position), aimBotSmoothness)
                
                -- Attack triggers execution parameters
                local exactDistance = (myHrp.Position - targetHrp.Position).Magnitude
                if exactDistance <= 8 and (tick() - lastAttack) >= 1.5 then
                    lastAttack = tick()
                    
                    task.spawn(function()
                        for i = 1, 6 do
                            -- Exit instantly if target gets hidden behind wall mid-execution while anti-bait is true
                            if antiBaitActive and not isTargetVisible(targetHrp) then break end
                            
                            local args = {}
                            if currentWeapon == "Shandkys" then
                                args = { "UseActorAbility", { buffer.fromstring("\003\005\000\000\000Slash") } }
                            elseif currentWeapon == "axe" then
                                args = { "UseActorAbility", { buffer.fromstring("\003\003\000\000\00Hatchet") } }
                            elseif currentWeapon == "Crystal" then
                                args = { "UseActorAbility", { buffer.fromstring("\003\005\000\000\000Crystal Pitch") } }
                            elseif currentWeapon == "punch" then
                                args = { "UseActorAbility", { buffer.fromstring("\003\003\000\000\000Punch") } }
                            end
                            
                            if #args > 0 then
                                NetworkRemote:FireServer(unpack(args))
                            end
                            task.wait(0.2)
                        end
                    end)
                end
            end
        end
    end
end)

----------------------------------------------------------------------------------
-- EXPLOIT FUNCTIONS (HITBOX, TRICK VERONICA, ANTI STUN)
----------------------------------------------------------------------------------
local HitboxModule = {}
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
                    RunService.Heartbeat:Wait()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = LocalPlayer.Character.HumanoidRootPart
                        local oldVel = hrp.Velocity
                        hrp.Velocity = oldVel * distance + (hrp.CFrame.LookVector * distance)
                        RunService.RenderStepped:Wait()
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
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

-- Trick Veronica Core Loop
task.spawn(function()
    while true do
        RunService.Heartbeat:Wait()
        if autoTrickActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            
            -- Checks explicitly if character is active and moving physically
            if humanoid and humanoid.MoveDirection.Magnitude > 0.1 then
                local raycastParams = RaycastParams.new()
                raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, Workspace:FindFirstChild("Players")}
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                
                local rayDirection = hrp.CFrame.LookVector * studsWallLimit
                local raycastResult = Workspace:Raycast(hrp.Position, rayDirection, raycastParams)
                
                -- Flat wall execution trigger check
                if raycastResult and math.abs(raycastResult.Normal.Y) < 0.1 then 
                    local sk8Args = { "UseActorAbility", { buffer.fromstring("\003\003\000\000\000Sk8") } }
                    NetworkRemote:FireServer(unpack(sk8Args))
                    
                    task.wait(0.1)
                    
                    local trickEventName = "FIAT_HACK1" .. LocalPlayer.Name .. "SkateTrick"
                    NetworkRemote:FireServer(trickEventName, {})
                    task.wait(1.5)
                end
            end
        end
    end
end)

-- Anti Stun State Loop
task.spawn(function()
    while true do
        task.wait(0.2)
        if antiStunActive and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                if humanoid.PlatformStand == true then humanoid.PlatformStand = false end
                if humanoid:GetState() == Enum.HumanoidStateType.StrafingNoPhysics or humanoid:GetState() == Enum.HumanoidStateType.Physics then
                    humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
                end
            end
        end
    end
end)

----------------------------------------------------------------------------------
-- VISUALS & PERFORMANCE MANAGER (ESP / GRAPHICS / LIGHTS)
----------------------------------------------------------------------------------
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
            if highlight:IsA("Highlight") then highlight:Destroy() end
        end
    end
end

task.spawn(function()
    while true do
        local PlayersFolder = Workspace:FindFirstChild("Players")
        if PlayersFolder and (getgenv().ESP_Killers or getgenv().ESP_Survivors or getgenv().ESP_Generators) then
            local killersGroup = PlayersFolder:FindFirstChild("Killers")
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

            local survivorsGroup = PlayersFolder:FindFirstChild("Survivors")
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
        end
        task.wait(2)
    end
end)

-- Environment Loop Handler
task.spawn(function()
    while true do
        task.wait(1)
        if fullLightActive then
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
        end
        if removeSkyActive then
            for _, obj in pairs(Lighting:GetChildren()) do
                if obj:IsA("Sky") then obj:Destroy() end
            end
        end
    end
end)

local originalMaterials = {}
local function toggleGraphicsEngine(state)
    if state then
        for _, desc in pairs(Workspace:GetDescendants()) do
            if desc:IsA("BasePart") and not desc:IsA("MeshPart") then
                originalMaterials[desc] = desc.Material
                desc.Material = Enum.Material.SmoothPlastic
            end
        end
    else
        for part, mat in pairs(originalMaterials) do
            if part and part.Parent then part.Material = mat end
        end
        table.clear(originalMaterials)
    end
end

----------------------------------------------------------------------------------
-- HOME TAB
----------------------------------------------------------------------------------
local HomeTab = Window:Tab({ Title = "Home", Icon = "home" })

HomeTab:Section({ Title = "Combat Exploits" })

HomeTab:Toggle({
    Title = "Hitbox Extender (kick chance or ban not recommended)",
    Desc = "Automatically amplifies attack range boundaries safely",
    Value = false,
    Callback = function(state) HitboxModule:Toggle(state) end
})

HomeTab:Slider({
    Title = "Aim Bot Meter",
    Step = 0.5,
    Value = { Min = 0, Max = 100.5, Default = 50 },
    Callback = function(v) aimBotMeter = v end
})

HomeTab:Section({ Title = "Stamina & Movement Modifications" })

local Sprinting = game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting
local stamina = require(Sprinting)

local s_max, s_min, s_gain, s_loss, s_speed = 100, -20, 100, 5, 40
local sprintToggleState = false

HomeTab:Slider({
    Title = "Max Stamina",
    Value = { Min = 0, Max = 500, Default = 100 },
    Callback = function(v) s_max = v if sprintToggleState then stamina.MaxStamina = v end end
})

HomeTab:Slider({
    Title = "Sprint Speed",
    Value = { Min = 16, Max = 200, Default = 40 },
    Callback = function(v) s_speed = v if sprintToggleState then stamina.SprintSpeed = v end end
})

HomeTab:Toggle({
    Title = "Sprint Speed / Infinite Stamina",
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

HomeTab:Section({ Title = "Movement Exploits Break" })

HomeTab:Slider({
    Title = "Studs Wall Limit",
    Step = 1,
    Value = { Min = 1, Max = 15, Default = 10 },
    Callback = function(v) studsWallLimit = v end
})

HomeTab:Toggle({
    Title = "Auto Trick Veronica",
    Value = false,
    Callback = function(state) autoTrickActive = state end
})

HomeTab:Toggle({
    Title = "Anti Stun Engine",
    Value = false,
    Callback = function(state) antiStunActive = state end
})

----------------------------------------------------------------------------------
-- AIM BOTS TAB
----------------------------------------------------------------------------------
local AimTab = Window:Tab({ Title = "Aim Bots", Icon = "crosshair" })

AimTab:Section({ Title = "Target Locking Calibration" })

AimTab:Slider({
    Title = "Aim Bot Meter Override",
    Step = 0.5,
    Value = { Min = 0, Max = 100.5, Default = 50 },
    Callback = function(v) aimBotMeter = v end
})

AimTab:Slider({
    Title = "Aim Bot Studs Range",
    Step = 0.1,
    Value = { Min = 1, Max = 100.9, Default = 50 },
    Callback = function(v) aimBotStuds = v end
})

AimTab:Slider({
    Title = "Precision Smoothness Speed",
    Step = 0.05,
    Value = { Min = 0.05, Max = 1, Default = 0.5 },
    Callback = function(v) aimBotSmoothness = v end
})

AimTab:Dropdown({
    Title = "Equipped Weapon System Selection",
    Values = { "axe", "Crystal", "punch", "Shandkys" },
    Value = { "punch" },
    Callback = function(option) currentWeapon = option[1] or "punch" end
})

AimTab:Toggle({
    Title = "Aim Bot Lock On",
    Value = false,
    Callback = function(state) aimBotActive = state end
})

AimTab:Toggle({
    Title = "Anti Bait Tracking",
    Desc = "Stops targeting or attacking completely if Killer goes behind walls",
    Value = false,
    Callback = function(state) antiBaitActive = state end
})

----------------------------------------------------------------------------------
-- ESP TAB
----------------------------------------------------------------------------------
local ESPTab = Window:Tab({ Title = "ESP", Icon = "eye" })

ESPTab:Section({ Title = "Visuals & Wallhacks" })

ESPTab:Toggle({
    Title = "ESP Killers",
    Value = false,
    Callback = function(state) getgenv().ESP_Killers = state end
})

ESPTab:Toggle({
    Title = "ESP Survivors",
    Value = false,
    Callback = function(state) getgenv().ESP_Survivors = state end
})

ESPTab:Toggle({
    Title = "ESP Generators",
    Value = false,
    Callback = function(state) getgenv().ESP_Generators = state end
})

----------------------------------------------------------------------------------
-- SETTINGS TAB
----------------------------------------------------------------------------------
local ConfigTab = Window:Tab({ Title = "Settings", Icon = "settings" })

ConfigTab:Section({ Title = "Environment Render Performance" })

ConfigTab:Toggle({
    Title = "Full Light / Fullbright Always",
    Value = false,
    Callback = function(state)
        fullLightActive = state
        if not state then
            Lighting.Ambient = originalLightingSettings.Ambient
            Lighting.Brightness = originalLightingSettings.Brightness
            Lighting.ClockTime = originalLightingSettings.ClockTime
        end
    end
})

ConfigTab:Toggle({
    Title = "Remove Sky Textures",
    Value = false,
    Callback = function(state) removeSkyActive = state end
})

ConfigTab:Toggle({
    Title = "Low Graphics Clean Textures",
    Value = false,
    Callback = function(state)
        lowGraphicsActive = state
        toggleGraphicsEngine(state)
    end
})

ConfigTab:Section({ Title = "Interface Customization" })

ConfigTab:Toggle({
    Title = "Transparent UI View",
    Value = true,
    Callback = function(state) Window:ToggleTransparency(state) end
})

ConfigTab:Keybind({
    Title = "Toggle UI Activation Key",
    Value = "RightShift",
    Callback = function(v) Window:SetToggleKey(Enum.KeyCode[v]) end
})

-- Finish Setup Notification
WindUI:Notify({
    Title = "Jane Doe Hub",
    Content = "Initialization Complete! Anti-Bait wall filters are fully primed.",
    Duration = 4,
    Icon = "check"
})
