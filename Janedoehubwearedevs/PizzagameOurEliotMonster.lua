-- ==================== SERVIÇOS ====================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ==================== INTERFACE FLUENT ====================
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Fluent, SaveManager, InterfaceManager = loadstring(Game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "JANE DOE HUB (PIZZA GAME BETA)",
    SubTitle = "by jane doe sigma",
    TabWidth = 138,
    Size = UDim2.fromOffset(460, 450),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- ==================== FUNÇÃO SEGURA PARA OBTER REMOTES ====================
local function getRemotes()
    local ok, REDamage, RFDamage, RECheckProtected
    ok = pcall(function()
        local NetPath = ReplicatedStorage:WaitForChild("Packages"):WaitForChild(".pesde"):WaitForChild("sleitnick_net@0.1.0"):WaitForChild("net")
        REDamage = NetPath:WaitForChild("RE/Damage")
        RFDamage = NetPath:WaitForChild("RF/Damage")
        RECheckProtected = NetPath:WaitForChild("RE/CheckProtected")
    end)
    if not ok then return nil, nil, nil end
    return REDamage, RFDamage, RECheckProtected
end

-- ==================== ABA MAIN ====================
Tabs.Main:AddParagraph({ Title = "Combat & Protection", Content = "Immortality and quick escapes." })

-- GOD MODE
Tabs.Main:AddToggle("GodModeToggle", {
    Title = "God Mode",
    Default = false,
    Callback = function(Value)
        if Value then
            local REDamage, _, RECheckProtected = getRemotes()
            if not REDamage then return end
            _G.GodLoop = task.spawn(function()
                while Options.GodModeToggle.Value do
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        pcall(function() REDamage:FireServer(char, -1) RECheckProtected:FireServer(0) end)
                    end
                    task.wait(0.033)
                end
            end)
            local function curar(character)
                if character and character:FindFirstChild("Humanoid") then
                    pcall(function() REDamage:FireServer(character, -1) RECheckProtected:FireServer(0) end)
                end
            end
            _G.GodCharAdded = LocalPlayer.CharacterAdded:Connect(function(char)
                local humanoid = char:WaitForChild("Humanoid", 10)
                if humanoid then
                    _G.GodHealthConn = humanoid.HealthChanged:Connect(function() curar(char) end)
                    curar(char)
                end
            end)
            if LocalPlayer.Character then
                local char = LocalPlayer.Character
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid then
                    _G.GodHealthConn = humanoid.HealthChanged:Connect(function() curar(char) end)
                    curar(char)
                end
            end
        else
            if _G.GodLoop then task.cancel(_G.GodLoop) end
            if _G.GodCharAdded then _G.GodCharAdded:Disconnect() end
            if _G.GodHealthConn then _G.GodHealthConn:Disconnect() end
            _G.GodLoop, _G.GodCharAdded, _G.GodHealthConn = nil, nil, nil
        end
    end
})

-- TELEPORT EXIT (FUNCIONANDO)
Tabs.Main:AddButton({
    Title = "Teleport Exit (in boss it doesn't work)",
    Description = "Teleports exactly onto the Exit part use noclip recomended.",
    Callback = function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
            Fluent:Notify({ Title = "Error", Content = "No character to teleport.", Duration = 2 })
            return
        end

        local targetPart = nil

        -- 1. Tenta o caminho exato fornecido
        local map = Workspace:FindFirstChild("Map")
        if map then
            local exitFolder = map:FindFirstChild("Exit")
            if exitFolder then
                local roomModel = exitFolder:FindFirstChild("RoomModel")
                if roomModel then
                    targetPart = roomModel:FindFirstChild("Exit")  -- pode ser parte ou modelo
                end
            end
        end

        -- 2. Se encontrou um modelo, pega o PrimaryPart; se for parte, usa direto
        if targetPart then
            if targetPart:IsA("Model") and targetPart.PrimaryPart then
                targetPart = targetPart.PrimaryPart
            elseif not targetPart:IsA("BasePart") then
                targetPart = nil
            end
        end

        -- 3. Fallback: busca genérica por qualquer BasePart chamada "Exit"
        if not targetPart then
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name == "Exit" and obj:IsA("BasePart") then
                    targetPart = obj
                    break
                elseif obj.Name == "Exit" and obj:IsA("Model") and obj.PrimaryPart then
                    targetPart = obj.PrimaryPart
                    break
                end
            end
        end

        if targetPart and targetPart:IsA("BasePart") then
            -- Posiciona EXATAMENTE em cima, elevado 5 studs
            char.HumanoidRootPart.CFrame = CFrame.new(targetPart.Position) + Vector3.new(0, 5, 0)
            Fluent:Notify({ Title = "Teleported", Content = "You are now on the Exit.", Duration = 2 })
        else
            Fluent:Notify({ Title = "Not Found", Content = "The Exit part was not located.", Duration = 3 })
        end
    end
})

-- ==================== ABA SETTINGS ====================
Tabs.Settings:AddParagraph({ Title = "Character Modifications", Content = "Movement and physics tweaks." })

-- NOCLIP (atravessa tudo)
Tabs.Settings:AddToggle("NoclipToggle", {
    Title = "Noclip",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.NoclipConnection = RunService.RenderStepped:Connect(function()
                local char = LocalPlayer.Character
                if not char then return end
                for _, parte in ipairs(char:GetDescendants()) do
                    if parte:IsA("BasePart") then
                        parte.CanCollide = false
                    end
                end
            end)
        else
            if _G.NoclipConnection then _G.NoclipConnection:Disconnect() end
            _G.NoclipConnection = nil
            if LocalPlayer.Character then
                for _, parte in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if parte:IsA("BasePart") then
                        parte.CanCollide = true
                    end
                end
            end
        end
    end
})

-- SPEED HACK
Tabs.Settings:AddSlider("SpeedSlider", {
    Title = "Walk Speed",
    Description = "Base speed 16",
    Default = 16, Min = 16, Max = 100, Rounding = 0,
    Callback = function() end
})

Tabs.Settings:AddToggle("SpeedToggle", {
    Title = "Speed Hack",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.SpeedConnection = RunService.RenderStepped:Connect(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid.WalkSpeed = Options.SpeedSlider.Value
                end
            end)
        else
            if _G.SpeedConnection then _G.SpeedConnection:Disconnect() end
            _G.SpeedConnection = nil
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end
    end
})

-- INFINITE YIELD
Tabs.Settings:AddButton({
    Title = "Execute Infinite Yield",
    Description = "Loads the Infinite Yield admin script.",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        Fluent:Notify({ Title = "Success", Content = "Infinite Yield loaded!", Duration = 3 })
    end
})

-- ==================== ADDONS ====================
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "JANE DOE HUB",
    Content = "Ready works",
    Duration = 5
})

SaveManager:LoadAutoloadConfig()
