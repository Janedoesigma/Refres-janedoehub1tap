local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Variaveis de Estado (Configurações)
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

local PosiçãoOriginal = nil

-- Atalho para os Remotes Atualizados (.pesde/sleitnick_net)
local NetPath = ReplicatedStorage:WaitForChild("Packages"):WaitForChild(".pesde"):WaitForChild("sleitnick_net@0.1.0"):WaitForChild("net")
local REDamage = NetPath:WaitForChild("RE/Damage")
local RFDamage = NetPath:WaitForChild("RF/Damage")
local RECheckProtected = NetPath:WaitForChild("RE/CheckProtected")

----------------------------------------------------------------
-- FUNÇÕES AUXILIARES DE TRAPAÇA (COMBATE E MOVIMENTAÇÃO)
----------------------------------------------------------------

-- Função para simular o ataque completo estruturado nas suas descobertas
local function darDanoNoInimigo(target, dano)
    if RFDamage and RECheckProtected and target:FindFirstChild("Humanoid") then
        task.spawn(function()
            RFDamage:InvokeServer(target, dano)
            RECheckProtected:FireServer(0, false)
        end)
    end
end

-- Pega o inimigo (não-player) válido mais próximo
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
-- CARREGANDO A INTERFACE FLUENT OFICIAL
----------------------------------------------------------------
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "JANE DOE HUB (PIZZA GAME BETA)",
    SubTitle = "by jane doe sigma",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Window:SelectTab(Tabs.Main)

----------------------------------------------------------------
-- SEÇÃO: TAB MAIN (COMBATE / ESP / FARM)
----------------------------------------------------------------

Tabs.Main:AddParagraph({
    Title = "Combate & Proteção",
    Content = "Configurações de automação de dano e imortalidade."
})

Tabs.Main:AddToggle("GodModeToggle", {
    Title = "God Mode",
    Default = false,
    Callback = function(Value)
        GodMode = Value
    end
})

Tabs.Main:AddToggle("KillAllToggle", {
    Title = "Kill All",
    Default = false,
    Callback = function(Value)
        KillAll = Value
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

Tabs.Main:AddParagraph({
    Title = "Aimbot Legítimo",
    Content = "Alvo focado automaticamente em criaturas próximas."
})

Tabs.Main:AddToggle("AimbotToggle", {
    Title = "Aimbot Inimigos",
    Default = false,
    Callback = function(Value)
        AimbotEnabled = Value
    end
})

Tabs.Main:AddSlider("AimbotSlider", {
    Title = "Raio do Aimbot (Range)",
    Description = "Distância máxima para travar o foco",
    Default = 100,
    Min = 50,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        AimbotRange = Value
    end
})

Tabs.Main:AddParagraph({
    Title = "Visualizadores (ESP)",
    Content = "Rastreamento de entidades pelo mapa."
})

Tabs.Main:AddToggle("EspInimigosToggle", {
    Title = "ESP Inimigos",
    Default = false,
    Callback = function(Value)
        EspInimigos = Value
    end
})

Tabs.Main:AddToggle("EspSoulsToggle", {
    Title = "ESP Souls",
    Default = false,
    Callback = function(Value)
        EspSouls = Value
    end
})

Tabs.Main:AddParagraph({
    Title = "Automação",
    Content = "Recolha recursos sem esforço."
})

Tabs.Main:AddToggle("SoulTeleportToggle", {
    Title = "Teleporte Soul",
    Default = false,
    Callback = function(Value)
        SoulTeleport = Value
        if not SoulTeleport and PosiçãoOriginal then
            -- Devolve o player ao local de origem se desligar voluntariamente
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = PosiçãoOriginal
            end
            PosiçãoOriginal = nil
        end
    end
})

----------------------------------------------------------------
-- SEÇÃO: TAB SETTINGS (MIGRAÇÃO DA INTERFACE ORIGINAL FLUENT)
----------------------------------------------------------------

Tabs.Settings:AddParagraph({
    Title = "Modificações do Personagem",
    Content = "Ajustes físicos do seu boneco."
})

Tabs.Settings:AddToggle("NoclipToggle", {
    Title = "Noclip",
    Default = false,
    Callback = function(Value)
        NoclipEnabled = Value
    end
})

Tabs.Settings:AddToggle("SpeedToggle", {
    Title = "Speed Hack",
    Default = false,
    Callback = function(Value)
        SpeedHackEnabled = Value
        if not SpeedHackEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

Tabs.Settings:AddSlider("SpeedSlider", {
    Title = "Velocidade do Player",
    Default = 16,
    Min = 16,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        PlayerSpeed = Value
    end
})

-- Adicionando gerenciadores automáticos de paleta de cores e temas nativos do Fluent
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:BuildConfigSection(Tabs.Settings)

----------------------------------------------------------------
-- LOOPS INTERNOS PRINCIPAIS (TICKERS EM SEGUNDO PLANO)
----------------------------------------------------------------

-- Loop de Renderização Contínua (Aimbot, Noclip, Speed)
RunService.RenderStepped:Connect(function()
    local Char = LocalPlayer.Character
    if not Char then return end

    -- 1. Mecânica de Speed Hack
    if SpeedHackEnabled and Char:FindFirstChild("Humanoid") then
        Char.Humanoid.WalkSpeed = PlayerSpeed
    end

    -- 2. Mecânica de Noclip (Ignora paredes, mantém chão)
    if NoclipEnabled then
        for _, parte in ipairs(Char:GetChildren()) do
            if parte:IsA("BasePart") and parte.Name ~= "HumanoidRootPart" then
                parte.CanCollide = false
            end
        end
    end

    -- 3. Mecânica do Aimbot Dinâmico
    if AimbotEnabled then
        local alvo = obterInimigoMaisProximo(AimbotRange)
        if alvo and alvo:FindFirstChild("HumanoidRootPart") then
            -- Trava a Câmera
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, alvo.HumanoidRootPart.Position)
            -- Força o Boneco a olhar diretamente para o alvo horizontalmente
            local lookPos = Vector3.new(alvo.HumanoidRootPart.Position.X, Char.HumanoidRootPart.Position.Y, alvo.HumanoidRootPart.Position.Z)
            Char.HumanoidRootPart.CFrame = CFrame.new(Char.HumanoidRootPart.Position, lookPos)
        end
    end
end)

-- Loop Secundário (ESP / Curas / Teleportes)
task.spawn(function()
    while true do
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChild("Humanoid") then
            
            -- Executa God Mode baseado nos seus novos logs de dano recebido
            if GodMode and REDamage and RECheckProtected then
                REDamage:FireServer(Char, -1)
                RECheckProtected:FireServer(0)
            end

            -- Gerenciador do Teleporte Soul
            if SoulTeleport and Char:FindFirstChild("HumanoidRootPart") then
                local alvoSoul = Workspace:FindFirstChild("Soul", true) or Workspace:FindFirstChild("soul", true)
                if alvoSoul and alvoSoul:IsA("BasePart") then
                    if not PosiçãoOriginal then
                        PosiçãoOriginal = Char.HumanoidRootPart.CFrame
                    end
                    Char.HumanoidRootPart.CFrame = alvoSoul.CFrame
                elseif PosiçãoOriginal then
                    -- Se sumirem as Souls, volta para onde você estava
                    Char.HumanoidRootPart.CFrame = PosiçãoOriginal
                    PosiçãoOriginal = nil
                end
            end

            -- Atualização dinâmica do ESP (Inimigos e Souls)
            for _, item in ipairs(Workspace:GetChildren()) do
                -- ESP Inimigos
                if item:IsA("Model") and item:FindFirstChild("Humanoid") and item:GetAttribute("State") and not Players:GetPlayerFromCharacter(item) then
                    local highlight = item:FindFirstChild("JaneDoeESP")
                    if EspInimigos and item.Humanoid.Health > 0 then
                        if not highlight then
                            highlight = Instance.new("Highlight")
                            highlight.Name = "JaneDoeESP"
                            highlight.FillTransparency = 0.6
                            highlight.FillColor = Color3.fromRGB(255, 255, 0) -- Amarelo
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                            highlight.Parent = item
                        end
                    else
                        if highlight then highlight:Destroy() end
                    end
                end
                
                -- ESP Souls
                if item.Name == "Soul" or item.Name == "soul" then
                    local highlight = item:FindFirstChild("JaneDoeSoulESP")
                    if EspSouls then
                        if not highlight and item:IsA("BasePart") then
                            highlight = Instance.new("Highlight")
                            highlight.Name = "JaneDoeSoulESP"
                            highlight.FillTransparency = 0.3
                            highlight.FillColor = Color3.fromRGB(0, 255, 255) -- Ciano para diferenciar das criaturas
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

-- Identificação para novos monstros adicionados em tempo real (Foco imediato do Kill All se ativo)
Workspace.ChildAdded:Connect(function(child)
    if KillAll and child:IsA("Model") and child:GetAttribute("State") and child:WaitForChild("Humanoid", 2) then
        task.wait(0.1)
        if child.Humanoid.Health > 0 then
            darDanoNoInimigo(child, child.Humanoid.Health)
        end
    end
end)

-- Inicialização Concluída
Fluent:Notify({
    Title = "JANE DOE HUB",
    Content = "Iniciado com sucesso! Pressione CTRL Esquerdo para ocultar.",
    Duration = 5
})
