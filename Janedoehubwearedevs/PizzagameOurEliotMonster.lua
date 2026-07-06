local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Variáveis de Estado (Configurações)
local GodMode = false
local KillAll = false
local AimbotEnabled = false
local AimbotRange = 100
local EspInimigos = false
local EspSouls = false
local SoulTeleport = false
local NoclipEnabled = false
local SpeedHackEnabled = false
local PlayerSpeed = 16

local PosicaoOriginal = nil

-- Atalho para os Remotes (.pesde/sleitnick_net)
local NetPath = ReplicatedStorage:WaitForChild("Packages"):WaitForChild(".pesde"):WaitForChild("sleitnick_net@0.1.0"):WaitForChild("net")
local REDamage = NetPath:WaitForChild("RE/Damage")
local RFDamage = NetPath:WaitForChild("RF/Damage")
local RECheckProtected = NetPath:WaitForChild("RE/CheckProtected")

----------------------------------------------------------------
-- FUNÇÕES AUXILIARES DE TRAPAÇA
----------------------------------------------------------------

local function darDanoNoInimigo(target, dano)
    if RFDamage and RECheckProtected and target:FindFirstChild("Humanoid") then
        task.spawn(function()
            RFDamage:InvokeServer(target, dano)
            RECheckProtected:FireServer(0, false)
        end)
    end
end

local function obterInimigoMaisProximo(raioMaximo)
    local maisProximo = nil
    local menorDistancia = raioMaximo

    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        return nil 
    end
    
    local meuPos = LocalPlayer.Character.HumanoidRootPart.Position

    for _, v in ipairs(Workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and not Players:GetPlayerFromCharacter(v) then
            if v.Humanoid.Health > 0 and v:GetAttribute("State") then
                local distancia = (v.HumanoidRootPart.Position - meuPos).Magnitude
                if distancia < menorDistancia then
                    menorDistancia = distancia
                    maisProximo = v
                end
            end
        end
    end
    return maisProximo
end

----------------------------------------------------------------
-- CARREGANDO A WINDUI E CRIAÇÃO DA JANELA
----------------------------------------------------------------
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "JANE DOE HUB",
    Icon = "pizza", 
    Author = "by jane doe sigma",
    Folder = "JaneDoeHubPizza",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    HideSearchBar = true,
    ScrollBarEnabled = true
})

-- Criando as Abas
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })

----------------------------------------------------------------
-- ELEMENTOS DA ABA: MAIN
----------------------------------------------------------------

MainTab:Paragraph({
    Title = "Combate & Proteção",
    Desc = "Ajustes de imortalidade e eliminação em massa."
})

MainTab:Toggle({
    Title = "God Mode",
    Desc = "Fica imortal contra danos do jogo",
    Icon = "shield",
    Value = false,
    Callback = function(state)
        GodMode = state
    end
})

MainTab:Toggle({
    Title = "Kill All",
    Desc = "Elimina instantaneamente todas as criaturas",
    Icon = "swords",
    Value = false,
    Callback = function(state)
        KillAll = state
        if KillAll then
            task.spawn(function()
                while KillAll do
                    for _, v in ipairs(Workspace:GetChildren()) do
                        if not KillAll then break end
                        if v:IsA("Model") and v:GetAttribute("State") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not Players:GetPlayerFromCharacter(v) then
                            darDanoNoInimigo(v, v.Humanoid.Health)
                        end
                    end
                    task.wait(0.3)
                end
            end)
        end
    end
})

MainTab:Paragraph({
    Title = "Aimbot Legítimo",
    Desc = "Trava sua câmera e corpo nas criaturas automatizadas."
})

MainTab:Toggle({
    Title = "Aimbot Inimigos",
    Desc = "Foca apenas em inimigos próximos",
    Icon = "crosshair",
    Value = false,
    Callback = function(state)
        AimbotEnabled = state
    end
})

MainTab:Slider({
    Title = "Raio do Aimbot (Range)",
    Desc = "Ajusta o limite de distância para travar",
    Step = 1,
    Value = { Min = 50, Max = 500, Default = 100 },
    Callback = function(value)
        AimbotRange = value
    end
})

MainTab:Paragraph({
    Title = "Visualizadores e Farm",
    Desc = "Rastreamento e coleta automática."
})

MainTab:Toggle({
    Title = "ESP Inimigos",
    Desc = "Exibe contorno amarelo e distância sobre criaturas",
    Icon = "eye",
    Value = false,
    Callback = function(state)
        EspInimigos = state
    end
})

MainTab:Toggle({
    Title = "ESP Souls",
    Desc = "Exibe contorno ciano nos itens Soul",
    Icon = "sparkles",
    Value = false,
    Callback = function(state)
        EspSouls = state
    end
})

MainTab:Toggle({
    Title = "Teleporte Soul",
    Desc = "Auto farm de Souls (retorna ao ponto de origem ao limpar)",
    Icon = "zap",
    Value = false,
    Callback = function(state)
        SoulTeleport = state
        if not SoulTeleport and PosicaoOriginal then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = PosicaoOriginal
            end
            PosicaoOriginal = nil
        end
    end
})

----------------------------------------------------------------
-- ELEMENTOS DA ABA: SETTINGS (Configuração da UI inclusa)
----------------------------------------------------------------

SettingsTab:Paragraph({
    Title = "Modificações do Personagem",
    Desc = "Altere físicas do seu personagem"
})

SettingsTab:Toggle({
    Title = "Noclip",
    Desc = "Permite atravessar paredes sem cair pelo chão",
    Icon = "ghost",
    Value = false,
    Callback = function(state)
        NoclipEnabled = state
    end
})

SettingsTab:Toggle({
    Title = "Speed Hack",
    Desc = "Ativa a modificação de velocidade contínua",
    Icon = "gauge",
    Value = false,
    Callback = function(state)
        SpeedHackEnabled = state
        if not SpeedHackEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

SettingsTab:Slider({
    Title = "Velocidade do Player",
    Desc = "Velocidade de movimento customizada",
    Step = 1,
    Value = { Min = 16, Max = 100, Default = 16 },
    Callback = function(value)
        PlayerSpeed = value
    end
})

SettingsTab:Paragraph({
    Title = "Aparência da Interface",
    Desc = "Customização do WindUI"
})

SettingsTab:Dropdown({
    Title = "Theme",
    Desc = "Mude o tema de cores",
    Values = (function()
        local names = {}
        for name in pairs(WindUI:GetThemes()) do
            table.insert(names, name)
        end
        table.sort(names)
        return names
    end)(),
    Value = { "Dark" },
    Multi = false,
    Callback = function(selected)
        WindUI:SetTheme(selected)
    end
})

SettingsTab:Toggle({
    Title = "Transparent",
    Desc = "Ativa o visual acrílico translúcido",
    Icon = "blend",
    Value = true,
    Callback = function(state)
        Window:ToggleTransparency(state)
    end
})

SettingsTab:Keybind({
    Title = "Toggle UI Key",
    Desc = "Escolha o botão para esconder ou abrir o menu",
    Value = "RightShift",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

----------------------------------------------------------------
-- LOOPS INTERNOS (RUNSERVICE / ASYNC TICKERS)
----------------------------------------------------------------

RunService.RenderStepped:Connect(function()
    local Char = LocalPlayer.Character
    if not Char then return end

    -- Speed Hack
    if SpeedHackEnabled and Char:FindFirstChild("Humanoid") then
        Char.Humanoid.WalkSpeed = PlayerSpeed
    end

    -- Noclip
    if NoclipEnabled then
        for _, parte in ipairs(Char:GetChildren()) do
            if parte:IsA("BasePart") and parte.Name ~= "HumanoidRootPart" then
                parte.CanCollide = false
            end
        end
    end

    -- Aimbot Dinâmico
    if AimbotEnabled then
        local alvo = obterInimigoMaisProximo(AimbotRange)
        if alvo and alvo:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, alvo.HumanoidRootPart.Position)
            local lookPos = Vector3.new(alvo.HumanoidRootPart.Position.X, Char.HumanoidRootPart.Position.Y, alvo.HumanoidRootPart.Position.Z)
            Char.HumanoidRootPart.CFrame = CFrame.new(Char.HumanoidRootPart.Position, lookPos)
        end
    end
end)

task.spawn(function()
    while true do
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChild("Humanoid") then
            
            -- God Mode Duplo (Usa seus novos remotes)
            if GodMode and REDamage and RECheckProtected then
                REDamage:FireServer(Char, -1)
                RECheckProtected:FireServer(0)
            end

            -- Teleporte Soul inteligente
            if SoulTeleport and Char:FindFirstChild("HumanoidRootPart") then
                local alvoSoul = Workspace:FindFirstChild("Soul", true) or Workspace:FindFirstChild("soul", true)
                if alvoSoul and alvoSoul:IsA("BasePart") then
                    if not PosicaoOriginal then
                        PosicaoOriginal = Char.HumanoidRootPart.CFrame
                    end
                    Char.HumanoidRootPart.CFrame = alvoSoul.CFrame
                elseif PosicaoOriginal then
                    Char.HumanoidRootPart.CFrame = PosicaoOriginal
                    PosicaoOriginal = nil
                end
            end

            -- Manipulação de ESP em tempo real
            for _, item in ipairs(Workspace:GetChildren()) do
                -- Inimigos
                if item:IsA("Model") and item:FindFirstChild("Humanoid") and item:GetAttribute("State") and not Players:GetPlayerFromCharacter(item) then
                    local highlight = item:FindFirstChild("JaneDoeESP")
                    if EspInimigos and item.Humanoid.Health > 0 then
                        if not highlight then
                            highlight = Instance.new("Highlight")
                            highlight.Name = "JaneDoeESP"
                            highlight.FillTransparency = 0.6
                            highlight.FillColor = Color3.fromRGB(255, 255, 0)
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                            highlight.Parent = item
                        end
                    else
                        if highlight then highlight:Destroy() end
                    end
                end
                
                -- Souls
                if item.Name == "Soul" or item.Name == "soul" then
                    local highlight = item:FindFirstChild("JaneDoeSoulESP")
                    if EspSouls then
                        if not highlight and item:IsA("BasePart") then
                            highlight = Instance.new("Highlight")
                            highlight.Name = "JaneDoeSoulESP"
                            highlight.FillTransparency = 0.3
                            highlight.FillColor = Color3.fromRGB(0, 255, 255)
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.Parent = item
                        end
                    else
                        if highlight then highlight:Destroy() end
                    end
                end
            end
        end
        task.wait(0.2)
    end
end)

Workspace.ChildAdded:Connect(function(child)
    if KillAll and child:IsA("Model") and child:GetAttribute("State") and child:WaitForChild("Humanoid", 2) then
        task.wait(0.1)
        if child.Humanoid.Health > 0 then
            darDanoNoInimigo(child, child.Humanoid.Health)
        end
    end
end)

-- Notificação Inicial da WindUI
WindUI:Notify({
    Title = "JANE DOE HUB",
    Content = "Carregado com sucesso na WindUI!",
    Duration = 4,
    Icon = "pizza"
})
