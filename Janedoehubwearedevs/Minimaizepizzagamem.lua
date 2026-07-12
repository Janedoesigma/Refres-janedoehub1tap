-- ==================== WINDUI INTERFACE ====================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "JANE DOE HUB (PIZZA GAME BETA)",
    Icon = "pizza",
    Author = "by jane doe sigma",
    Folder = "JaneDoeHub",
    Size = UDim2.fromOffset(470, 470),
    MinSize = Vector2.new(470, 470),
    MaxSize = Vector2.new(470, 470),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.39,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    Background = "rbxassetid://90052134506491",  -- mesmo background do seu exemplo
    User = {
        Enabled = true,
        Anonymous = false,
    },
})

WindUI:GetTransparency(false)
WindUI:GetWindowSize(52)

-- ==================== SERVIÇOS ====================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

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

-- ==================== ABA PRINCIPAL ====================
local MainTab = Window:Tab({ Title = "Main", Icon = "ghost" })

MainTab:Section({ Title = "Combat & Protection" })

-- GOD MODE
MainTab:Toggle({
    Title = "God Mode",
    Desc = "Regenerates health extremely fast",
    Value = false,
    Callback = function(state)
        if state then
            local REDamage, _, RECheckProtected = getRemotes()
            if not REDamage then return end
            _G.GodLoop = task.spawn(function()
                while true do
                    if not state then break end
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        pcall(function() REDamage:FireServer(char, -1) RECheckProtected:FireServer(0) end)
                    end
                    task.wait(0.026)
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

-- TELEPORT EXIT (CAMINHO EXATO + FALLBACK)
MainTab:Button({
    Title = "Teleport Exit (in boss it doesn't work)",
    Desc = "Teleports directly onto the nearest Exit part use noclip.",
    Callback = function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
            WindUI:Notify({ Title = "Error", Content = "No character to teleport.", Duration = 4, Icon = "alert-triangle" })
            return
        end

        local targetPart = nil

        -- Tenta o caminho exato
        local map = Workspace:FindFirstChild("Map")
        if map then
            local exitFolder = map:FindFirstChild("Exit")
            if exitFolder then
                local roomModel = exitFolder:FindFirstChild("RoomModel")
                if roomModel then
                    targetPart = roomModel:FindFirstChild("Exit")
                end
            end
        end

        -- Se encontrou um modelo, usa PrimaryPart; se for parte, usa direto
        if targetPart then
            if targetPart:IsA("Model") and targetPart.PrimaryPart then
                targetPart = targetPart.PrimaryPart
            elseif not targetPart:IsA("BasePart") then
                targetPart = nil
            end
        end

        -- Fallback: busca genérica
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
            char.HumanoidRootPart.CFrame = CFrame.new(targetPart.Position) + Vector3.new(0, 5, 0)
            WindUI:Notify({ Title = "Teleported", Content = "You are now on the Exit.", Duration = 2, Icon = "check-circle" })
        else
            WindUI:Notify({ Title = "Not Found", Content = "The Exit part was not located.", Duration = 3, Icon = "x-circle" })
        end
    end
})

-- ==================== ABA SETTINGS ====================
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })

SettingsTab:Section({ Title = "Character Modifications" })

-- NOCLIP (atravessa tudo)
SettingsTab:Toggle({
    Title = "Noclip",
    Desc = "Pass through all walls",
    Value = false,
    Callback = function(state)
        if state then
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
local speedValue = 16
SettingsTab:Slider({
    Title = "Walk Speed",
    Desc = "Base speed 16",
    Step = 1,
    Value = { Min = 16, Max = 100, Default = 16 },
    Callback = function(value)
        speedValue = value
    end
})

SettingsTab:Toggle({
    Title = "Speed Hack",
    Desc = "Apply custom walk speed",
    Value = false,
    Callback = function(state)
        if state then
            _G.SpeedConnection = RunService.RenderStepped:Connect(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid.WalkSpeed = speedValue
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
SettingsTab:Button({
    Title = "Execute Infinite Yield",
    Desc = "Loads the Infinite Yield admin script idk",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        WindUI:Notify({ Title = "Success", Content = "Infinite Yield loaded!", Duration = 3, Icon = "check-circle" })
    end
})

-- TECLA PARA ALTERNAR A UI (opcional)
SettingsTab:Keybind({
    Title = "Toggle UI Key",
    Value = "RightShift",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

-- ==================== NOTIFICAÇÃO FINAL ====================
WindUI:Notify({
    Title = "JANE DOE HUB",
    Content = "God luck for farm Souls",
    Duration = 6,
    Icon = "ghost"
})

-- Tecla padrão para abrir/fechar a UI
Window:SetToggleKey(Enum.KeyCode.RightShift)
