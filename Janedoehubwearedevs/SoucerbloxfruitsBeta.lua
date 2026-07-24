--[[This file was beautified by Galactic Tools | https://discord.gg/RNzAwYMj2t]]
local vu1 = select(1, ...) or {
    JoinTeam = "Pirates",
    Translator = true
}
if not game.IsLoaded then
    game.Loaded:Wait()
end
local vu2 = game:GetService("VirtualInputManager")
local vu3 = game:GetService("LocalizationService")
local vu4 = game:GetService("CollectionService")
local vu5 = game:GetService("ReplicatedStorage")
local vu6 = game:GetService("VirtualUser")
local vu7 = game:GetService("HttpService")
local lf_1 = game:GetService("RunService")
local vu9 = game:GetService("Lighting")
local vu10 = game:GetService("Players")
local vu11 = game:GetService("CoreGui")
local vu12 = workspace.CurrentCamera
local vu13 = lf_1.Stepped
local vu14 = vu10.LocalPlayer
local vu15 = vu14:WaitForChild("Data")
vu15:WaitForChild("LastSpawnPoint")
vu15:WaitForChild("SpawnPoint")
local vu16 = vu15:WaitForChild("Fragments")
local vu17 = vu15:WaitForChild("Subclass")
local vu18 = vu15:WaitForChild("FruitCap")
local vu19 = vu15:WaitForChild("Level")
local vu20 = vu15:WaitForChild("Beli")
local vu21 = workspace:WaitForChild("Map")
local vu22 = workspace:WaitForChild("NPCs")
local vu23 = workspace:WaitForChild("Boats")
local vu24 = workspace:WaitForChild("SeaBeasts")
local vu25 = workspace:WaitForChild("Enemies")
local vu26 = workspace:WaitForChild("Characters")
local vu27 = workspace:WaitForChild("_WorldOrigin")
local vu28 = vu27:WaitForChild("Locations")
vu27:WaitForChild("PlayerSpawns")
local vu29 = vu5:WaitForChild("Remotes")
local vu30 = vu5:WaitForChild("Modules")
local vu31 = vu30:WaitForChild("Net")
local vu32 = (getgenv or (getrenv or getfenv))()
local vu33 = game.HttpGet
local vu34 = {}
local vu35 = {}
local vu36 = vu32.rz_Functions or {}
local vu37 = vu32.rz_FarmFunctions or {}
local vu38 = vu32.rz_Settings or {
    AutoBuso = true,
    BringMobs = true,
    BringDistance = 250,
    FarmMode = "Up",
    FarmTool = "Melee",
    FarmDistance = 15,
    FarmPos = Vector3.new(0, 15, 0),
    SeaSkills = {},
    boatSelected = {},
    fishSelected = {}
}
local vu45 = vu32.rz_EnabledOptions or setmetatable({}, {
    __newindex = function(_, p39, p40)
        rawset(vu35, p39, p40 or nil)
        table.clear(vu37)
        local v41, v42, v43 = ipairs(vu36)
        while true do
            local v44
            v43, v44 = v41(v42, v43)
            if v43 == nil then
                break
            end
            if rawget(vu35, v44.Name) then
                table.insert(vu37, v44)
            end
        end
    end,
    __index = vu35
})
local vu46 = vu14.PlayerGui
if not (vu14.Team or vu14:FindFirstChild("Main")) then
    local lf_2 = 0
    local function v53(p48)
        local lf_3 = vu46["Main (minimal)"]:WaitForChild("ChooseTeam")
        local lf_4 = p48:find("pirate") and "Pirates" or "Marines"
        local lf_5 = getconnections(lf_3.Container[lf_4].Frame.TextButton.Activated)
        for v52 = 1, # lf_5 do
            lf_5[v52].Function()
        end
    end
    while not (vu14.Team or vu14:FindFirstChild("Main")) do
        if tick() - lf_2 >= 0.5 then
            pcall(v53, string.lower(vu1.JoinTeam or "Pirates"))
            lf_2 = tick()
        end
        task.wait()
    end
end
if vu32.redz_hub_error then
    vu32.redz_hub_error:Destroy()
end
local vu54 = {
    Owner = "https://raw.githubusercontent.com/newredz/"
}
vu54.Repository = vu54.Owner .. "BloxFruits/refs/heads/main/"
local function vu55()
    return identifyexecutor and identifyexecutor() or "Null"
end
local function vu58(p56)
    vu32.loadedFarm = nil
    vu32.OnFarm = false
    local lf_6 = Instance.new("Message", workspace)
    lf_6.Text = string.gsub(p56, vu54.Owner, "")
    vu32.redz_hub_error = lf_6
    return error(p56, 2)
end
function __httpget(p59, _)
    local v60, v61, v62 = pairs(vu54)
    while true do
        local v63
        v62, v63 = v60(v61, v62)
        if v62 == nil then
            break
        end
        local lf_7 = "{" .. v62 .. "}"
        if p59:find(lf_7) then
            p59 = p59:gsub(lf_7, v63)
        end
    end
    local v65, v66 = pcall(vu33, game, p59)
    if v65 then
        return v66, p59
    else
        return vu58((("[1] [%s] Failed to load script: %s
{{ %s }}"):format(vu55(), p59, v66)))
    end
end
function __loadstring(p67, p68, p69)
    local v70, v71 = __httpget(p67)
    local v72, v73 = loadstring(v70 .. (p68 or ""))
    if type(v72) ~= "function" then
        return vu58((("[2] [%s] sintaxe error: %s
{{ %s }}"):format(vu55(), v71, v73)))
    end
    local v74, v75
    if p69 then
        v74, v75 = pcall(v72, unpack(p69))
    else
        v74, v75 = pcall(v72)
    end
    if v74 then
        return v75
    end
    if type(v75) == "string" then
        ("[3] [%s] Execute error: %s
{{ %s }}"):format(vu55(), v71, v75)
    end
end
vu32.rz_Functions = vu36
vu32.rz_Settings = vu38
vu32.rz_EnabledOptions = vu45
vu32.rz_FarmFunctions = vu37
local vu76 = rz_connections or {}
vu32.rz_connections = vu76
local v77, v78, v79 = ipairs(vu76)
while true do
    local v80
    v79, v80 = v77(v78, v79)
    if v79 == nil then
        break
    end
    v80:Disconnect()
end
table.clear(vu76)
local vu81 = nil
local vu82 = nil
local vu83 = nil
local vu84 = {
    Marines = function()
        vu82.FireRemote("SetTeam", "Marines")
    end,
    Pirates = function()
        vu82.FireRemote("SetTeam", "Pirates")
    end
}
local function v88(p85)
    local vu86 = vu4:GetTagged(p85)
    table.insert(vu76, vu4:GetInstanceAddedSignal(p85):Connect(function(p87)
        table.insert(vu86, p87)
end)
)
    return vu86
end
local vu89 = v88("_ChestTagged")
local vu90 = v88("BerryBush")
local vu101 = {
    RemoveFog = function()
        if vu9:FindFirstChild("LightingLayers") then
            vu9.LightingLayers:Remove()
        end
    end,
    AllCodes = function()
        local lf_8 = __httpget("{Repository}Utils/Codes.txt")
        local lf_9 = string.gsub(lf_8, "
", ""):split(" ")
        for v93 = 1, # lf_9 do
            vu29.Redeem:InvokeServer(lf_9[v93])
        end
    end,
    GetTimer = function(p94)
        local lf_10 = math.floor(p94)
        local lf_11 = math.floor(p94 / 60)
        local lf_12 = math.floor(p94 / 60 / 60)
        local lf_13 = lf_10 - lf_11 * 60
        local lf_14 = lf_11 - lf_12 * 60
        if lf_14 < 10 then
            lf_14 = "0" .. tostring(lf_14) or lf_14
        end
        local lf_15 = ":"
        if lf_13 < 10 then
            lf_13 = "0" .. tostring(lf_13) or lf_13
        end
        return lf_14 .. lf_15 .. lf_13
    end
}
local vu102 = {
    Managers = {}
}
local vu103 = vu102.Managers
local vu104 = 
    local module = {}
    module.__index = module
    local TweenService = game:GetService("TweenService")
    local tweens = {}
    local EasingStyle = Enum.EasingStyle.Linear
    function module.new(obj, time, prop, value)
      local self = setmetatable({}, module)
      self.tween = TweenService:Create(obj, TweenInfo.new(time, EasingStyle), { [prop] = value })
      self.tween:Play()
      self.value = value
      self.object = obj
      if tweens[obj] then
        tweens[obj]:destroy()
      end
      tweens[obj] = self
      return self
    end
    function module:destroy()
      self.tween:Pause()
      self.tween:Destroy()
      tweens[self.object] = nil
      setmetatable(self, nil)
    end
    function module:stop(obj)
      if tweens[obj] then
        tweens[obj]:destroy()
      end
    end
    return module
  ")()
function vu103.PlayerTeleport()
    local vu105 = {
        lastCF = nil,
        lastTP = 0,
        nextNum = 1,
        BypassCooldown = 0,
        GreatTree = CFrame.new(28610, 14897, 105),
        SpawnVector = Vector3.new(0, - 25.2, 0)
    local vu106 = vu82.Inventory.Unlocked
    local vu107 = vu82.GameData.Sea
    local vu108 = vu82.IsAlive
    local vu109 = vu82.FireRemote
    local vu110 = ({
        {
            ["Sky Island 1"] = Vector3.new(- 4652, 873, - 1754),
            ["Sky Island 2"] = Vector3.new(- 7895, 5547, - 380),
            ["Under Water Island"] = Vector3.new(61164, 15, 1820),
            ["Under Water Island Entrace"] = Vector3.new(3865, 20, - 1926)
        },
        {
            ["Flamingo Mansion"] = Vector3.new(- 317, 331, 597),
            ["Flamingo Room"] = Vector3.new(2283, 15, 867),
            ["Cursed Ship"] = Vector3.new(923, 125, 32853),
            ["Zombie Island"] = Vector3.new(- 6509, 83, - 133)
        },
        {
            Mansion = Vector3.new(- 12464, 376, - 7566),
            ["Hydra Island"] = Vector3.new(5651, 1015, - 350),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103),
            ["Sea Castle"] = Vector3.new(- 5090, 319, - 3146),
            ["Great Tree"] = Vector3.new(2953, 2282, - 7217)
    })[vu107]
    local function vu111()
        vu105.NpcDebounce = false
    end
    function vu105.talkNpc(_, p112, p113, ...)
        if vu14:DistanceFromCharacter(p112.Position) < 5 then
            if type(p113) ~= "function" then
                vu109(p113, ...)
            else
                p113()
            end
        end
    end
    function vu105.hasUnlocked(_, p114)
        if vu107 == 3 and (p114 == "Hydra Island" or (p114 == "Sea Castle" or p114 == "Mansion")) then
            return vu106["Valkyrie Helm"]
        end
        if vu107 == 2 then
            if p114 == "Flamingo Mansion" or p114 == "Flamingo Room" then
                return vu106["Swan Glasses"] or vu19.Value >= 1750
            end
            if p114 == "Zombie Island" or p114 == "Cursed Ship" then
                return vu19.Value >= 1000
            end
        end
        return true
    end
    function vu105.GetNearestPortal(p115, p116)
        local lf_16 = math.huge
        local v118, v119, v120 = pairs(vu110)
        local lf_17 = nil
        local lf_18 = nil
        while true do
            local v123
            v120, v123 = v118(v119, v120)
            if v120 == nil then
                break
            end
            if p115:hasUnlocked(v120) then
                local lf_19 = (p116 - v123).Magnitude
                if lf_19 < lf_16 then
                    lf_18 = v120
                    lf_17 = v123
                    lf_16 = lf_19
                end
            end
        end
        return lf_17, lf_18
    end
    function vu105.TeleportToGreatTree(p125)
        p125.new(p125.GreatTree, nil, true)
        p125:talkNpc(p125.GreatTree, "RaceV4Progress", "TeleportBack")
    end
    function vu105.NPCs(p126, p127, p128)
        if vu108(vu14.Character) then
            if p126.NpcDebounce and p127[p126.nextNum] then
                vu83(p127[p126.nextNum] + p126.SpawnVector)
                return nil
            end
            local lf_20 = vu14.Character.PrimaryPart
            if # p127 ~= 1 then
                if # p127 > 1 then
                    if p126.nextNum > # p127 then
                        p126.nextNum = 1
                    end
                    local lf_21 = p127[p126.nextNum]
                    if lf_20 and (lf_20.Position - lf_21.Position).Magnitude < 5 then
                        p126.nextNum = p126.nextNum + 1
                        p126.NpcDebounce = true
                        task.delay(1, vu111)
                    else
                        p126.new(lf_21, p128)
                    end
                end
            else
                p126.new(p127[1], p128)
            end
        end
    end
    function vu105.new(p131, p132, p133, p134)
        local lf_22 = vu105
        if vu108(vu14.Character) and (tick() - lf_22.lastTP >= 1 or p131 ~= lf_22.lastCF) then
            if vu14.Character.PrimaryPart then
                if not p133 then
                    lf_22.lastPosition = p131.Position
                end
                lf_22.lastTP = tick()
                lf_22.lastCF = p131
                local lf_23 = vu14.Character.Humanoid
                local lf_24 = vu14.Character.PrimaryPart
                if lf_23.Sit then
                    lf_23.Sit = false
                    return
                elseif lf_24.Anchored then
                    vu104:stop(lf_24)
                else
                    local lf_25 = vu38.TweenSpeed or 220
                    local lf_26 = p131.Position
                    local lf_27 = (lf_24.Position - lf_26).Magnitude
                    if lf_27 < 150 and not p132 then
                        vu104:stop(lf_24)
                        lf_24.CFrame = p131
                    end
                    local v141, v142 = lf_22:GetNearestPortal(lf_26)
                    local v143
                    if v141 then
                        v143 = (lf_26 - v141).Magnitude + 300
                    else
                        v143 = v141
                    end
                    if v141 and (tick() - lf_22.BypassCooldown >= 8 and v143 < lf_27) then
                        if v142 == "Great Tree" then
                            lf_22:TeleportToGreatTree()
                        else
                            vu104:stop(lf_24)
                            task.wait(0.2)
                            if (lf_26 - v141).Magnitude >= 50 then
                                lf_26 = v141 + (lf_26 - lf_24.Position).Unit * 40
                            end
                            vu109("requestEntrance", lf_26)
                            BypassCooldown = tick()
                        end
                    elseif p132 then
                        vu104.new(lf_24, lf_27 / p132, "CFrame", p131)
                    else
                        if not p134 then
                            local lf_28 = lf_24.Position
                            local lf_29 = CFrame.new(lf_28.X, lf_26.Y, lf_28.Z)
                            if (lf_28 - lf_29.Position).Magnitude > 75 then
                                vu104:stop(lf_24)
                                task.wait(0.1)
                                lf_24.CFrame = lf_29
                                task.wait(0.5)
                            end
                        end
                        if lf_27 < 380 then
                            vu104.new(lf_24, lf_27 / (lf_25 * 2), "CFrame", p131)
                        else
                            vu104.new(lf_24, lf_27 / lf_25, "CFrame", p131)
                        end
                    end
                end
            else
                return nil
            end
        else
            return nil
        end
    end
    vu82.Tween:GetPropertyChangedSignal("Parent"):Connect(function()
        if not vu82.Tween.Parent and vu108(vu14.Character) then
            vu104:stop(vu14.Character.PrimaryPart)
        end
end)
    vu83 = vu105.new
    return vu105
end
function vu103.QuestManager()
        QuestList = {},
        EnemyList = {},
        QuestPos = {},
        Crafts = {},
        Sea = vu82.GameData.Sea,
        takeQuestDebounce = false,
        _Position = CFrame.new(0, 0, 2.5)
    local vu147 = vu14.PlayerGui:WaitForChild("Main").Quest
    local vu148 = vu147.Container.QuestTitle.Title
    local vu149 = "https://raw.githubusercontent.com/newredzBloxFruits/refs/heads/main/GameModules/"
        GuideModule = vu5:WaitForChild("GuideModule"),
        Quests = vu5:WaitForChild("Quests"),
        SkinUtil = vu30:WaitForChild("SkinUtil")
    local function v154(pu151)
        local v152, v153 = pcall(function()
            return require(vu150[pu151])
end)
        if not v152 then
            warn(("falha a o carregar Module [ %s ] [ %s ]"):format(pu151, v153))
        end
        return v152 and v153 and v153 or loadstring(vu33(workspace, vu149 .. pu151 .. ".lua"))()
    end
    local vu155 = v154("GuideModule")
    local lf_30 = v154("Quests")
    local lf_31 = v154("SkinUtil")
    local vu158 = lf_31.AuraSkins or lf_31
    local vu159 = vu82.EnemyLocations
    local gt_ztbbcqqbgnzz = vu82.EnemySpawned
    local vu160 = vu82.IsBoss
        Colors = {
            Context = "GetSkinsInventory"
    local function v169(p162)
        local lf_32 = next
        local lf_33 = p162.Task
        local lf_34 = {}
        while true do
            local v168
            v165, v168 = lf_32(lf_33, v165)
            if v165 == nil then
                break
            end
            v167 = vu159[v165] or {}
            vu159[v165] = v167
            table.insert(lf_34, v165)
        end
        return lf_34, v167
    end
    task.spawn(function()
        if vu155.Data.IsFakeData then
            return nil
        end
        local v170, v171, v172 = pairs(vu155.Data.NPCList)
        while true do
            local v173
            v172, v173 = v170(v171, v172)
            if v172 == nil then
                break
            end
            vu146.QuestPos[v173.NPCName] = CFrame.new(v173.Position)
        end
            __newindex = function(p174, p175, p176)
                vu146.QuestPos[p176.NPCName] = CFrame.new(p176.Position)
                return rawset(p174, p175, p176)
            end
        setmetatable(vu155.Data.NPCList, v177)
end)
    task.spawn(vu82.RunFunctions.Quests, vu146, lf_30, v169)
    function vu146.GetUnlockedHakiColors(p178)
        if not p178.haki_colors or tick() - p178.haki_colors.last_update >= 30 then
            p178.haki_colors = vu31["RF/FruitCustomizerRF"]:InvokeServer(vu161.Colors)
            p178.haki_colors.last_update = tick()
        end
        return p178.haki_colors
    end
    function vu146.GetQuest(p179)
        if p179.oldLevel ~= vu19.Value or not p179.CurrentQuest then
            p179.oldLevel = vu19.Value
            local lf_35 = p179.Sea
            local lf_36 = math.clamp(vu19.Value, 0, lf_35 == 1 and 700 or (lf_35 == 2 and 1500 or vu19.Value))
            local v182, v183, v184 = ipairs(p179.QuestList)
                local v188
                v184, v188 = v182(v183, v184)
                if v184 == nil then
                end
                local lf_37 = v188.Enemy.Level
                local lf_38 = v188.Enemy.Name[1]
                if vu160(lf_38) then
                    if lf_37 <= lf_36 and lf_36 - 50 <= lf_37 then
                        v185 = lf_38
                    else
                        v185 = false
                    end
                    v186 = v188
                else
                    if lf_36 < lf_37 then
                        p179.CurrentQuest = v187
                        p179.oldBossQuest = v186
                        p179.oldBoss = v185
                        return v187
                    end
                    v187 = v188
                end
            end
            p179.CurrentQuest = v187
            p179.oldBossQuest = v186
            p179.oldBoss = v185
            return v187
        elseif p179.oldBoss and vu82.Enemies.IsSpawned(p179.oldBoss) then
            return p179.oldBossQuest
        else
            return p179.CurrentQuest
        end
    end
    function vu146.GetQuestPosition(p191, p192)
        if not vu155.Data.IsFakeData then
            return p191.QuestPos[vu155.Data.LastClosestNPC]
        end
        local lf_39 = vu155.Data.NPCs[p192]
        if lf_39 then
            lf_39 = vu22:FindFirstChild(lf_39) or vu5.NPCs:FindFirstChild(lf_39)
        end
        if lf_39 then
            lf_39 = lf_39:GetPivot()
        end
        return lf_39
    end
    function vu146.VerifyQuest(_, p194)
        if not vu147.Visible then
            return false
        end
        local lf_40 = string.gsub(vu148.Text, "-", ""):lower()
        if type(p194) == "string" then
            return string.find(lf_40, string.gsub(p194, "-", ""):lower())
        end
        local v196, v197, v198 = ipairs(p194)
            local v199
            v198, v199 = v196(v197, v198)
            if v198 == nil then
            end
            if string.find(lf_40, string.gsub(v199, "-", ""):lower()) then
                return v199
            end
        end
    end
    function vu146.StartQuest(p200, p201, p202, p203)
        if p203 and vu14:DistanceFromCharacter(p203.Position) >= 5 then
            vu83(p203 * p200._Position)
            return "Teleporting to NPC: " .. p201
        end
        if not p200.takeQuestDebounce then
            task.wait(0.5)
            vu82.FireRemote("StartQuest", p201, p202)
            return "Getting Quest: " .. p201, task.wait(0.5)
        end
        if p200.Debounce and (tick() - p200.Debounce < 75 and p200.InDebounceQuest == p202 .. p201) then
            return "Quest Debounce: " .. vu101.GetTimer(75 - (tick() - p200.Debounce))
        end
        vu38.RunningMethod = "Getting Quest: " .. p201
        task.wait(0.5)
        vu82.FireRemote("StartQuest", p201, p202)
        local lf_41 = p202 .. p201
        p200.Debounce = tick()
        p200.InDebounceQuest = lf_41
        return vu38.RunningMethod, task.wait(0.5)
    end
    function vu146.GetAuraCraft(_, p205)
        return (vu158[p205] or {}).EtcItems
    end
    function vu146.GetColorsList(_)
        local v206, v207, v208 = pairs(vu158)
            local v210
            v208, v210 = v206(v207, v208)
            if v208 == nil then
            end
            if v210.EtcItems then
                table.insert(v209, v208)
            end
        end
        return v209
    end
    return vu146
end
function vu103.FarmManager()
        NPCs = {},
        CanFarm = {},
        EnemyLocation = {},
        ClickPosition = Vector2.new(),
        axisDebounce = 0
    local vu212 = vu82.IsAlive
    local vu213 = vu82.EnemySpawned
    local vu214 = vu82.EnemyLocations
    local vu215 = vu82.EquipTool
    local vu216 = 0
    vu211.Materials = ({
        {
            "Leather + Scrap Metal",
            "Magma Ore",
            "Fish Tail",
            "Angel Wings"
        },
        {
            "Leather + Scrap Metal",
            "Magma Ore",
            "Mystic Droplet",
            "Radiactive Material",
            "Vampire Fang"
        },
        {
            "Leather + Scrap Metal",
            "Fish Tail",
            "Gunpowder",
            "Mini Tusk",
            "Conjured Cocoa",
            "Dragon Scale"
    })[vu82.GameData.Sea]
    vu211.Enemies = {
        Elites = {
            "Deandre",
            "Diablo",
            "Urban"
        },
        Bones = {
            "Reborn Skeleton",
            "Living Zombie",
            "Demonic Soul",
            "Posessed Mummy"
        },
        Katakuri = {
            "Head Baker",
            "Baking Staff",
            "Cake Guard",
            "Cookie Crafter"
        Ectoplasm = {
            "Ship Deckhand",
            "Ship Engineer",
            "Ship Steward",
            "Ship Officer"
    vu211.FarmModes = {
        Star = function(p217, p218)
            local lf_42 = p218.CFrame + p217:GetNextAxis()
            if vu14:DistanceFromCharacter(lf_42.Position) >= 5 then
                vu83(lf_42)
            end
        end,
        Orbit = function(_, p220, p221)
            local lf_43 = p220.Parent
            local lf_44 = task.wait()
            local lf_45 = vu38.RunningOption
            local lf_46 = 3.5
            local lf_47 = 0
            while (p221 or vu38.FarmMode) == "Orbit" and (vu45[lf_45] and (p220 and vu212(lf_43))) do
                if tick() - vu216 >= 1 then
                    vu215()
                end
                EnableBuso()
                local lf_48 = vu38.FarmDistance
                lf_47 = lf_47 + lf_46 * lf_44
                vu83(CFrame.new(math.cos(lf_47) * lf_48, 8, math.sin(lf_47) * lf_48) + p220.Position)
                lf_44 = task.wait(vu38.SmoothMode and 0.1 or 0)
            end
        end,
        Up = function(_, p228)
            local lf_49 = p228.CFrame + vu38.FarmPos
            if vu14:DistanceFromCharacter(lf_49.Position) >= 5 then
                vu83(lf_49)
            end
        end
        ["Angel Wings"] = {
            CFrame.new(- 7742, 5634, - 1564)
        ["Leather + Scrap Metal"] = {
            CFrame.new(- 1257, 54, 4091),
            CFrame.new(- 1100, 77, 1152),
            CFrame.new(- 364, 116, 5692)
        ["Magma Ore"] = {
            CFrame.new(- 5408, 11, 8456),
            CFrame.new(- 5241, 50, - 4713)
        ["Fish Tail"] = {
            CFrame.new(60931, 19, 1574),
            false,
            CFrame.new(- 10679, 398, - 8975)
        ["Mystic Droplet"] = {
            false,
            CFrame.new(- 3350, 282, - 10527)
        ["Radiactive Material"] = {
            false,
            CFrame.new(- 73, 149, - 112)
        ["Vampire Fang"] = {
            false,
            CFrame.new(- 6030, 6, - 1281)
        Gunpowder = {
            false,
            false,
            CFrame.new(- 394, 135, 5981)
        ["Mini Tusk"] = {
            CFrame.new(- 13510, 584, - 6986)
        ["Conjured Cocoa"] = {
            CFrame.new(400, 81, - 12257)
        ["Dragon Scale"] = {
            CFrame.new(6689, 378, 331)
        ["Leather + Scrap Metal"] = {
                "Pirate",
                "Brute",
                "Scrap Metal",
                "Pirate Millionaire"
                true,
                true,
                true
        ["Angel Wings"] = {
                "Royal Soldier",
                "Royal Squad"
                true,
                false
        ["Magma Ore"] = {
                "Military Soldier",
                "Lava Pirate"
                true,
                true,
                false
        ["Fish Tail"] = {
                "Fishman Warrior",
                "Fishman Captain",
                "Fishman Raider"
                true,
                true
        ["Conjured Cocoa"] = {
                "Cocoa Warrior",
                "Chocolate Bar Battler"
                true
        ["Mystic Droplet"] = {
                "Water Fighter"
                false
        ["Radiactive Material"] = {
                "Factory Staff"
                false
        ["Vampire Fang"] = {
                "Vampire"
                false
        Gunpowder = {
                "Pistol Billionaire"
                true
        ["Mini Tusk"] = {
                "Mythological Pirate"
                true
        ["Dragon Scale"] = {
                "Dragon Crew Archer"
                true
    function vu211.ToolDebounce()
        vu216 = tick()
    end
    function vu211.TargetPosition(p232)
        if typeof(p232) == "CFrame" then
            vu83(p232)
            EnableBuso()
            vu215()
        end
    end
    function vu211.GetNextAxis(p233)
        if tick() - p233.axisDebounce <= 0.4 then
            return p233.nextAxis
        end
        local lf_50 = Vector3[math.random() <= 0.5 and "xAxis" or "zAxis"] * (math.random() <= 0.5 and vu38.FarmDistance or - vu38.FarmDistance) + Vector3.yAxis * 8
        local lf_51 = tick()
        p233.nextAxis = lf_50
        p233.axisDebounce = lf_51
        return lf_50
    end
    function vu211.Mastery(_, p236, p237)
        local lf_52 = p237.Health
        local lf_53 = vu25
        local v240, v241, v242 = ipairs(lf_53:GetChildren())
            local v243
            v242, v243 = v240(v241, v242)
            if v242 == nil then
            end
            if v243.PrimaryPart then
                local lf_54 = v243:FindFirstChild("Humanoid")
                if lf_54 and (lf_54.Health > 0 and lf_54.Health <= lf_52) then
                    lf_52 = lf_54.Health
                    p236 = v243.PrimaryPart
                    p237 = lf_54
                end
            end
        end
        local lf_55 = p236.CFrame + vu38.FarmPos
        local lf_56 = p237.Health / p237.MaxHealth * 100
        vu215(lf_56 <= vu38.mHealth and vu38.mTool or "Melee", true)
        vu82:BringEnemies(p236.Parent)
        EnableBuso()
        if vu14:DistanceFromCharacter(lf_55.Position) >= 2.5 then
            vu83(lf_55)
        end
        if lf_56 <= vu38.mHealth and vu14:DistanceFromCharacter(lf_55.Position) < 5 then
            vu82.Hooking:SetTarget(p236, p236.Parent, true)
            vu82.UseSkills(p236, vu38.MasterySkills)
        end
    end
    function vu211.attack(p247, p248, p249, p250)
        local lf_57 = p247:FindFirstChild("Humanoid")
        if not lf_57 then
            return nil
        end
        if vu45.Mastery and lf_57.MaxHealth < 40000 then
            vu211:Mastery(p247.PrimaryPart, lf_57)
            return true
        end
        if p248 then
            vu82:BringEnemies(p247, p249)
        end
        if tick() - vu216 >= 1 then
            vu215()
        end
        EnableBuso()
        vu211.FarmModes[p250 or vu38.FarmMode](vu211, p247.PrimaryPart, p250)
        if vu38.SmoothMode and ((p250 or vu38.FarmMode) ~= "Orbit" and (task.wait(0.1) and (vu212(p247) and (p247.PrimaryPart and vu45[vu38.RunningOption])))) then
            local lf_58 = vu38
            local lf_59 = vu32
            local lf_60 = "Killing: " .. p247.Name
            lf_59.OnFarm = true
            lf_58.RunningMethod = lf_60
            vu211.attack(p247, p248, p249, p250)
        end
        return true
    end
    function vu211.Material(p255, p256)
        local lf_61 = vu230[p256]
        if lf_61 then
            lf_61 = vu230[p256][vu82.GameData.Sea]
        end
        local lf_62 = vu231[p256]
        if lf_62 then
            local lf_63 = p255.EnemyLocation
            local lf_64 = p255.CanFarm
            if lf_64[p256] == nil then
                if lf_62[2][vu82.GameData.Sea] then
                    lf_64[p256] = true
                else
                    lf_64[p256] = false
                end
            end
            if not lf_64[p256] then
                return nil
            end
            if lf_63[p256] == nil then
                local v261, v262, v263 = ipairs(lf_62[1])
                    local v264
                    v263, v264 = v261(v262, v263)
                    if v263 == nil then
                    end
                    local lf_65 = vu214[v264]
                    if lf_65 and # lf_65 > 0 then
                        lf_63[p256] = lf_65
                    end
                end
                if not lf_63[p256] then
                    lf_63[p256] = false
                end
            end
            local v266, v267, v268 = ipairs(lf_62[1])
                local v269
                v268, v269 = v266(v267, v268)
                if v268 == nil then
                end
                local lf_66 = vu213(v269)
                if lf_66 and lf_66.PrimaryPart then
                    p255.attack(lf_66, true, true)
                    return "Killing: " .. v269
                end
            end
            if lf_63[p256] then
                vu103.PlayerTeleport:NPCs(lf_63[p256])
            else
                vu83(lf_61)
            end
            return "Farming Material: " .. p256
        end
    end
    function vu211.GetNpcPosition(p271, p272)
        if p271.NPCs[p272] then
            return p271.NPCs[p272]:GetPivot()
        end
        local lf_67 = vu22:FindFirstChild(p272) or vu5.NPCs:FindFirstChild(p272)
        if lf_67 then
            p271.NPCs[p272] = lf_67
            local gt_qeaejqagyrys = lf_67.GetPivot
        end
    end
    return vu211
end
function vu103.RaidManager()
    if vu82.GameData.Sea ~= 2 and vu82.GameData.Sea ~= 3 then
    end
    local gt_sxlrnunobhkn = vu82.GameData.Sea ~= 2
    v274.RaidPosition = CFrame.new(- 5033, 315, - 2950)
    v274.requests = {}
    v274.Require = 0
    v274.Timer = vu14.PlayerGui:WaitForChild("Main").Timer
    v274.Button = vu82.GameData.Sea == 2 and "CircleIsland.RaidSummon2.Button.Main" or (vu82.GameData.Sea == 3 and "Boat Castle.RaidSummon2.Button.Main" or false)
    function v274.IsRaiding(_)
        local lf_68 = vu45.Raid
        if lf_68 then
            lf_68 = vu14:GetAttribute("IslandRaiding")
        end
        return lf_68
    end
    function v274.GetRaidIsland(_)
        return vu82:GetRaidIsland()
    end
    function v274.CanStartRaid(_)
        local v276
        if vu19.Value < 1200 then
            v276 = false
        else
            v276 = VerifyTool("Special Microchip")
        end
        return v276
    end
    function v274.start(p277)
        if not p277:IsRaiding() and p277:CanStartRaid() then
            local lf_69 = p277.Button:split(".")
            local lf_70 = vu21
            for v280 = 1, # lf_69 do
                if lf_70 then
                    lf_70 = lf_70:FindFirstChild(lf_69[v280])
                end
            end
            if lf_70 and lf_70:FindFirstChild("ClickDetector") then
                fireclickdetector(lf_70.ClickDetector)
                task.wait(1)
            else
                local gt_nkshgqvuesxe = p277.RaidPosition
            end
        end
    end
    function v274.requestFragment(p281, p282, p283)
        if p281.requests[p282] then
        end
        p281.Require = p281.Require + (p283 or 0)
    end
    return v274
end
function vu103.ItemsQuests()
        CursedDualKatana = {},
        SkullGuitar = {}
    local vu285 = vu82.Enemies.IsSpawned
    local vu286 = vu82.EnemySpawned
    local vu287 = vu82.EnemyLocations
    local vu288 = vu82.EquipTool
    local vu289 = vu82.FireRemote
    if vu82.GameData.Sea == 3 then
        local function vu299()
            if vu290 and vu290.Value > 0 then
                return vu290
            end
            local lf_71 = math.huge
            local v292, v293, v294 = ipairs(vu14.QuestHaze:GetChildren())
                local v296
                v294, v296 = v292(v293, v294)
                if v294 == nil then
                end
                if v296.Value > 0 then
                    local lf_72 = v296:GetAttribute("Position")
                    local v298
                    if typeof(lf_72) ~= "Vector3" then
                        v298 = false
                    else
                        v298 = vu14:DistanceFromCharacter(lf_72)
                    end
                    if v298 then
                        if v298 <= lf_71 then
                            v295 = v296
                            lf_71 = v298
                        end
                    end
                end
            end
            vu290 = v295
            return v295
        end
        local function vu303(p300)
            for v301 = 1, 3 do
                local lf_73 = p300:FindFirstChild("Torch" .. v301)
                if lf_73 then
                    if lf_73:FindFirstChild("ProximityPrompt") then
                        if lf_73.ProximityPrompt.Enabled then
                            return lf_73
                        end
                    end
                end
            end
        end
        local function vu307(p304)
            for v305 = 1, 3 do
                local lf_74 = p304:FindFirstChild("Pedestal" .. v305)
                if lf_74 then
                    if lf_74:FindFirstChild("ProximityPrompt") then
                        if lf_74.ProximityPrompt.Enabled then
                            return lf_74
                        end
                    end
                end
            end
        end
        local function vu316(p308)
            local lf_75 = math.huge
            local v310, v311, v312 = ipairs(vu5.NPCs:GetChildren())
                local v314
                v312, v314 = v310(v311, v312)
                if v312 == nil then
                end
                if v314.Name == "Luxury Boat Dealer" and not p308[v314] then
                    local lf_76 = v314.PrimaryPart
                    if lf_76 and vu14:DistanceFromCharacter(lf_76.Position) <= lf_75 then
                        lf_75 = vu14:DistanceFromCharacter(lf_76.Position)
                        v313 = v314
                    end
                end
            end
            return v313
        end
            function(p317, _)
                if VerifyTool("Yama") then
                    vu288("Yama")
                    local lf_77 = vu286("Forest Pirate")
                    if lf_77 and lf_77.PrimaryPart then
                        vu82.AttackCooldown = tick()
                        vu83(lf_77.PrimaryPart.CFrame * CFrame.new(0, 0, - 2))
                    else
                        vu83(p317.ForestPirate)
                    end
                else
                    vu289("LoadItem", "Yama")
                end
                return true
            end,
            function(_, _)
                local lf_78 = vu14:FindFirstChild("QuestHaze") and vu299()
                if lf_78 then
                    local lf_79 = lf_78.Name
                    local lf_80 = vu286(lf_79)
                    if lf_80 and lf_80.PrimaryPart then
                        vu103.FarmManager.attack(lf_80, true)
                    elseif vu287[lf_79] then
                        vu103.PlayerTeleport:NPCs(vu287[lf_79])
                    else
                        vu83(lf_78:GetAttribute("Position"))
                    end
                    return true
                end
            end,
            function(p322, p323)
                local lf_81 = vu21:FindFirstChild("HellDimension")
                if lf_81 then
                    local lf_82 = vu303(lf_81) or lf_81:FindFirstChild("Exit")
                    if lf_82 and vu14:DistanceFromCharacter(lf_82.Position) <= 600 then
                        local lf_83 = vu286(p322.Hell)
                        if lf_83 and lf_83.PrimaryPart then
                            vu83(lf_83.PrimaryPart.CFrame + vu38.FarmPos)
                            return true, vu82.KillAura(125)
                        end
                        if lf_82.Name == "Exit" or vu14:DistanceFromCharacter(lf_82.Position) >= 5 then
                            vu83(lf_82.CFrame)
                        else
                            fireproximityprompt(lf_82.ProximityPrompt)
                        end
                    end
                    return true
                end
                if not vu285("Soul Reaper") then
                    return p323.SoulReaper() or p323.Bones()
                end
                local lf_84 = vu286("Soul Reaper")
                if lf_84 and lf_84.PrimaryPart and vu14:DistanceFromCharacter(lf_84.PrimaryPart.Position) > 6 then
                    vu83(lf_84.PrimaryPart.CFrame * CFrame.new(0, 0, - 2))
                end
            end
        vu284.CursedDualKatana.Yama = v328
            function(p329, _)
                if vu14:FindFirstChild("BoatQuest") then
                    local lf_85 = p329.CurrentDealer
                    if not lf_85 or p329.BoatsDealer[lf_85] then
                        lf_85 = vu22:FindFirstChild("Luxury Boat Dealer")
                        if not lf_85 or (not lf_85.PrimaryPart or p329.BoatsDealer[lf_85]) then
                            lf_85 = vu316(p329.BoatsDealer)
                        end
                    end
                    if lf_85 and lf_85.PrimaryPart then
                        if p329.CurrentDealer ~= lf_85 then
                            p329.CurrentDealer = lf_85
                        end
                        if vu14:DistanceFromCharacter(lf_85.PrimaryPart.Position) >= 5 then
                            return true, vu83(lf_85.PrimaryPart.CFrame)
                        end
                        if vu289("CDKQuest", "BoatQuest", lf_85, "Check") then
                            vu289("CDKQuest", "BoatQuest", lf_85)
                        end
                        p329.BoatsDealer[lf_85] = true
                    else
                        task.wait(0.5)
                    end
                end
            end,
            function(_, p331)
                return p331.PirateRaid()
            end,
            function(p332, _)
                local lf_86 = vu21:FindFirstChild("HeavenlyDimension")
                if lf_86 then
                    local lf_87 = vu303(lf_86) or lf_86:FindFirstChild("Exit")
                    if lf_87 and vu14:DistanceFromCharacter(lf_87.Position) <= 600 then
                        local lf_88 = vu286(p332.Heaven)
                        if lf_88 and lf_88.PrimaryPart then
                            vu83(lf_88.PrimaryPart.CFrame + vu38.FarmPos)
                            return true, vu82.KillAura(125)
                        end
                        if lf_87.Name == "Exit" or vu14:DistanceFromCharacter(lf_87.Position) >= 5 then
                            vu83(lf_87.CFrame)
                        else
                            fireproximityprompt(lf_87.ProximityPrompt)
                        end
                    end
                end
                if vu285("Cake Queen") then
                    local lf_89 = vu286("Cake Queen")
                    if lf_89 and lf_89.PrimaryPart then
                        vu103.FarmManager.attack(lf_89)
                    else
                        vu83(p332.CakeQueen)
                    end
                end
            end
        vu284.CursedDualKatana.Tushita = v337
        function vu284.CursedDualKatana.FinalQuest(p338, _)
            if VerifyTool("Tushita") or VerifyTool("Yama") then
                if vu285("Cursed Skeleton Boss") then
                    local lf_90 = vu286("Cursed Skeleton Boss")
                    if not (lf_90 and lf_90.PrimaryPart) then
                    end
                    vu288("Sword", true)
                    vu103.FarmManager.ToolDebounce()
                    vu103.FarmManager.attack(lf_90)
                end
                if vu14.PlayerGui.Main.Dialogue.Visible then
                    vu6:ClickButton1(Vector2.new(10000, 10000))
                end
                local lf_91 = vu307(vu21.Turtle.Cursed)
                if lf_91 then
                    if vu14:DistanceFromCharacter(lf_91.Position) >= 5 then
                        vu83(lf_91.CFrame)
                    else
                        fireproximityprompt(lf_91.ProximityPrompt)
                    end
                end
                local lf_92 = vu14:DistanceFromCharacter(p338.CursedSkeleton[1].Position)
                if lf_92 > 6 then
                    vu83(p338.CursedSkeleton[1], lf_92 <= 100 and 40 or false)
                else
                    vu83(p338.CursedSkeleton[2])
                end
                task.wait(0.5)
            end
            vu289("LoadItem", "Yama")
        end
    end
    if vu82.GameData.Sea == 3 then
        local vu342 = CFrame.new(5867, 1208, 872)
        local vu343 = CFrame.new(5771, 1209, 804)
        local vu344 = vu31:WaitForChild("RF/InteractDragonQuest")
        local vu345 = vu82.Inventory.Count
        local vu346 = vu82.Inventory.Unlocked
            Progress = {},
            CurrentBelt = "Null",
            YellowQuest = ToDictionary({
                "Piranha",
                "Shark"
            }),
            RedQuest = ToDictionary({
                "Terrorshark",
                "Sea Beast"
            })
            CheckStart = {
                "CanTransform",
                "CanLearnTether",
                "TetherLearned",
                "AvailableVQuest"
            Complete = {
                NPC = "Dragon Wizard",
                Command = "Ascension",
                Action = "Complete"
            Begin = {
                NPC = "Dragon Wizard",
                Command = "Ascension",
                Action = "Begin"
            LearnTether = {
                NPC = "Dragon Wizard",
                Command = "LearnTether"
            BuyDraco = {
                NPC = "Dragon Wizard",
                Command = "DragonRace"
            DojoClaim = {
                NPC = "Dojo Trainer",
                Command = "ClaimQuest"
            DojoProgress = {
                NPC = "Dojo Trainer",
                Command = "RequestQuest"
            SpeakWizard = {
                NPC = "Dragon Wizard",
                Command = "Speak"
            RaceV3 = ToDictionary({
                "Terrorshark",
                "Sea Beast"
            })
        function vu347.CollectReward(_, p350)
            if vu346["Dojo Belt (" .. p350 .. ")"] then
                vu347.Progress[p350] = nil
            else
                if vu14:DistanceFromCharacter(vu342.Position) > 3 then
                    vu83(vu342)
                else
                    vu344:InvokeServer(vu349.DojoClaim)
                    vu284.CurrentBeltQuest = nil
                end
            end
        end
        function vu347.White(p351, p352)
            if p351.Progress.White < 20 then
                return p352.Level()
            else
                return p351:CollectReward("White")
            end
        end
        function vu347.Green(p353)
            if p353.Progress.Green >= 330 then
                return p353:CollectReward("Green")
            end
            if vu14:GetAttribute("DangerLevel") >= 500 and p353.GreenTimer then
                p353.Progress.Green = p353.Progress.Green + (tick() - p353.GreenTimer)
            end
            p353.GreenTimer = tick()
            if vu103.SeaManager:GetPlayerBoat() then
                vu103.SeaManager:RandomTeleport("inf")
            else
                vu103.SeaManager:BuyNewBoat()
            end
        end
        function vu347.Purple(p354, p355)
            if p354.Progress.Purple >= 3 then
                return p354:CollectReward("Purple")
            end
            if p354.PurpleProgress then
                if p355.EliteHunter() then
                end
                local lf_93 = vu82
                p354.Progress.Purple = p354.StartPurpleProgress + (lf_93:GetProgress("EliteProgress", "EliteHunter", "Progress") - p354.PurpleProgress)
            else
                p354.StartPurpleProgress = p354.Progress.Purple
                p354.PurpleProgress = vu82:GetProgress("EliteProgress", "EliteHunter", "Progress")
            end
        end
        function vu347.Red(p357, p358)
            if p357.Progress.Red < 1 then
                return p358.Sea(p357.RedQuest)
            else
                return p357:CollectReward("Red")
            end
        end
        function vu347.Yellow(p359, p360)
            if p359.Progress.Yellow < 5 then
                return p360.Sea(p359.YellowQuest)
            else
                return p359:CollectReward("Yellow")
            end
        end
        function vu347.Blue(p361, p362)
            if p361.Progress.Blue >= 1 then
                return p361:CollectReward("Blue")
            end
            if vu14.Character then
                local lf_94 = vu14.Character:FindFirstChildOfClass("Tool")
                if lf_94 and (lf_94:FindFirstChild("Fruit") and (lf_94.ToolTip ~= "Blox Fruit" and lf_94:GetAttribute("DroppedBy"))) and lf_94:GetAttribute("DroppedBy"):len() > 0 then
                    p361.Progress.Blue = 1
                end
                local v364, v365, v366 = ipairs(vu14.Backpack:GetChildren())
                    local v367
                    v366, v367 = v364(v365, v366)
                    if v366 == nil then
                    end
                    if v367:IsA("Tool") and (v367:FindFirstChild("Fruit") and (v367.ToolTip ~= "Blox Fruit" and lf_94:GetAttribute("DroppedBy"))) and lf_94:GetAttribute("DroppedBy"):len() > 0 then
                        p361.Progress.Blue = 1
                    end
                end
                local gt_szmtchrtyhfm = p362.Fruits
            end
        end
        function vu347.Black(p368, p369)
            if p368.Progress.Black < 3 then
                if p368.BlackProgress then
                    p368.Progress.Black = vu345["Dinosaur Bones"] - p368.BlackProgress
                    return p369.LavaGolem() or (p369.PrehistoricBones() or p369.PrehistoricIsland())
                else
                    p368.BlackProgress = p368.Progress.Black - vu345["Dinosaur Bones"]
                end
            else
                return p368:CollectReward("Black")
            end
        end
        function vu284.BeltProgress(p370, p371, p372)
            if vu347.CurrentBelt ~= p371 then
                if p370.CurrentDracoQuest and p370.CurrentDracoQuest.AvailableVQuest == "V3InProgress" then
                    p370.KilledTerrorshark = true
                end
            else
                vu347.Progress[p371] = vu347.Progress[p371] + p372
            end
        end
        function vu284.BeltQuest(p373, p374, p375)
            local lf_95 = p374.BeltName
            if vu347[lf_95] then
                if vu346["Dojo Belt (" .. lf_95 .. ")"] then
                    return p373:GetNextBeltQuest()
                end
                if not (vu347.Progress[lf_95] and p374.UpdatedProgress) then
                    local lf_96 = vu347.Progress
                    local lf_97 = p374.Progress
                    p374.UpdatedProgress = true
                    lf_96[lf_95] = lf_97
                end
                vu347.CurrentBelt = lf_95
                if vu347[lf_95](vu347, p375) then
                    return "Belt Quest: " .. lf_95
                end
            end
        end
        function vu284.GetNextBeltQuest(p379)
            if vu14:DistanceFromCharacter(vu342.Position) > 5 then
                vu83(vu342)
            else
                p379.CurrentBeltQuest = vu344:InvokeServer(vu349.DojoProgress)
            end
            return "Getting Belt Quest"
        end
        function vu284.BeltQuests(p380, p381)
            local lf_98 = p380.CurrentBeltQuest
            if type(lf_98) ~= "table" then
                local gt_uxqzmmujvylx = p380.GetNextBeltQuest
            else
                if lf_98.Timeout or lf_98.Completed then
                end
                if lf_98.Quest then
                    return p380:BeltQuest(lf_98.Quest, p381)
                end
            end
        end
        function vu284.SpeakWizard(p383)
            if vu14:DistanceFromCharacter(vu343.Position) > 5 then
                vu83(vu343)
            else
                p383.CurrentDracoQuest = vu344:InvokeServer(vu349.SpeakWizard)
            end
            return "Teleporting to NPC: Dragon Wizard"
        end
        function vu284.TalkNpc(p384, p385, p386, p387)
            if vu14:DistanceFromCharacter(p385.Position) > 5 then
                vu83(p385)
            elseif vu344:InvokeServer(p386) and p387 then
                p384[p387] = nil
            end
            return "Teleporting to NPC: " .. (p386.NPC or "???")
        end
        function vu284.GetDracoRace(p388, p389)
            if not vu346["Dojo Belt (Black)"] then
                return p389.DojoTrainer()
            end
            local lf_99 = p388.CurrentDracoQuest
            if type(lf_99) ~= "table" then
                local gt_alegxwvuvotu = p388.SpeakWizard
            else
                if not (lf_99.TetherLearned or lf_99.CanLearnTether) then
                end
                if not lf_99.FoundPrehistoric then
                    return p389.PrehistoricBones() or p389.PrehistoricEgg() or (p389.LavaGolem() or p389.PrehistoricIsland())
                end
                if vu15.Race.Value ~= "Draco" then
                    if lf_99.CanTransform or lf_99.CanTransformFree then
                        return p388:TalkNpc(vu343, vu348.BuyDraco, "CurrentDracoQuest")
                    elseif lf_99.TetherLearned then
                        if vu346["Dragon Egg"] then
                            return p388:TalkNpc(vu343, vu348.BuyDraco, "CurrentDracoQuest")
                        else
                            return p389.PrehistoricBones() or p389.PrehistoricEgg() or (p389.LavaGolem() or p389.PrehistoricIsland())
                        end
                    else
                        return p388:TalkNpc(vu343, vu348.LearnTether, "CurrentDracoQuest")
                    end
                end
                local lf_100 = lf_99.AvailableVQuest
                if lf_100 == "V2" or lf_100 == "V3" then
                    return p388:TalkNpc(vu343, vu348.Begin, "CurrentDracoQuest")
                end
                if lf_100 == "V2InProgress" then
                    if vu345["Fire Flower"] < 5 then
                        return vu45.EliteHunter and p389.EliteHunter() or (vu45.BerryBush and vu45.BerryBush() or p389.FireFlowers(5))
                    else
                        return p388:TalkNpc(vu343, vu348.Complete, "CurrentDracoQuest")
                    end
                end
                if lf_100 == "V3InProgress" then
                    if p388.KilledTerrorshark then
                        return p388:TalkNpc(vu343, vu348.Complete, "CurrentDracoQuest")
                    else
                        return p389.Sea(vu349.RaceV3)
                    end
                end
                if lf_100 == "V2TurnInReady" then
                    if vu15.Level.Value < 1000000 then
                        return p389.Level()
                    else
                        return p388:TalkNpc(vu343, vu348.Complete, "CurrentDracoQuest")
                    end
                end
                if lf_100 == "V3TurnInReady" then
                    if vu15.Level.Value < 3000000 then
                        return p389.Level()
                    else
                        return p388:TalkNpc(vu343, vu348.Complete, "CurrentDracoQuest")
                    end
                end
            end
        end
    end
    return vu284
end
function vu103.IslandManager()
    return {
        Islands = {},
        GetMirageFruitDealer = function(p392)
            if p392.MirageFruitDealer then
                return p392.MirageFruitDealer
            end
            local lf_101 = vu22:FindFirstChild("Advanced Fruit Dealer") or vu5.NPCs:FindFirstChild("Advanced Fruit Dealer")
            if lf_101 then
                p392.MirageFruitDealer = lf_101
                return lf_101
            end
        end,
        GetMirageGear = function(p394, p395)
            if p394.MirageGear and p394.MirageGear.Parent then
                return p394.MirageGear
            end
            local v396, v397, v398 = ipairs(p395:GetChildren())
                local v399
                v398, v399 = v396(v397, v398)
                if v398 == nil then
                end
                if v399:IsA("MeshPart") and v399.MeshId == "rbxassetid://10153114969" then
                    p394.MirageGear = v399
                    return v399
                end
            end
        end,
        GetMirageTop = function(p400, p401)
            if p400.MirageTop and p400.MirageTop.Parent then
                return p400.MirageTop
            end
            local v402, v403, v404 = ipairs(p401:GetChildren())
                local v405
                v404, v405 = v402(v403, v404)
                if v404 == nil then
                end
                local lf_102 = v405:FindFirstChild("dbz_map1_Cube.012")
                if lf_102 then
                    p400.MirageTop = lf_102
                    return lf_102
                end
            end
        end,
        GetPrehistoricActivationPrompt = function(p407, p408)
            local lf_103 = p407.PrehistoricPrompt
            if lf_103 and lf_103:IsDescendantOf(vu21) then
                return lf_103
            end
            local lf_104 = p408:FindFirstChild("Core")
            if lf_104 and lf_104:FindFirstChild("ActivationPrompt") then
                p407.PrehistoricPrompt = lf_104.ActivationPrompt
                return lf_104.ActivationPrompt
            end
        end,
        GetSpawnedIsland = function(p411, p412)
            local lf_105 = p411.Islands[p412]
            if lf_105 and lf_105.Parent == vu21 then
                return lf_105
            end
            local lf_106 = vu21:FindFirstChild(p412)
            if lf_106 then
                p411.Islands[p412] = lf_106
                return lf_106
            end
        end
end
function vu103.EspManager()
    vu415.__index = vu415
    function vu415.__newindex(p416, p417, p418)
        if p417 == "Enabled" then
            return task.spawn(p416.toggle, p416, p418)
        else
            return rawset(p416, p417, p418)
        end
    end
    local function vu420(p419)
        if p419:FindFirstChild("Humanoid") then
            return p419.PrimaryPart or p419
        elseif p419:FindFirstChild("Handle") then
            return p419.Handle
        else
            return p419
        end
    end
    local function vu422(p421)
        if p421.Object and p421.Section.List[p421.Object] then
            p421.Section.List[p421.Object] = nil
        end
        if p421.EspHandle then
            p421.EspHandle:Destroy()
        end
    end
    local vu423 = vu82.FruitsName
    local vu424 = "%s<font color=\'rgb(160, 160, 160)\'> [ %im ]</font>
<font color=\'rgb(25, 240, 25)\'>[%i/%i]</font>"
    local vu425 = Instance.new("Folder", vu11)
    vu425.Name = "rz_EspFolder"
    local lf_107 = vu11:FindFirstChild(vu425.Name)
    if lf_107 and lf_107 ~= vu425 then
        lf_107:Destroy()
    end
    function vu415.new(p427, p428, p429, p430)
        local lf_108 = setmetatable({}, vu415)
        local lf_109 = Instance.new("Folder", vu425)
        lf_109.Name = p427
        lf_108.List = {}
        lf_108.Name = p427
        lf_108.Folder = lf_109
        lf_108.IsEnabled = p430
        lf_108.Instance = p428
        lf_108.IsEspObject = p429
        return lf_108
    end
    function vu415.clear(p433)
        p433.Folder:ClearAllChildren()
        table.clear(p433.List)
    end
    function vu415.add(pu434, p435, p436, p437, _)
            Section = pu434,
            Color = p436 or Color3.fromRGB(255, 255, 255),
            Name = p437 or p435.Name,
            Object = p435,
            EspHandle = nil
        local lf_110 = Instance.new("BoxHandleAdornment")
        lf_110.Size = Vector3.new(1, 0, 1, 0)
        lf_110.AlwaysOnTop = true
        lf_110.ZIndex = 10
        lf_110.Transparency = 0
        local lf_111 = Instance.new("BillboardGui")
        lf_111.Adornee = p435
        lf_111.Size = UDim2.new(0, 100, 0, 150)
        lf_111.StudsOffset = Vector3.new(0, 2, 0)
        lf_111.AlwaysOnTop = true
        local vu441 = Instance.new("TextLabel")
        vu441.BackgroundTransparency = 1
        vu441.Position = UDim2.new(0, 0, 0, - 50)
        vu441.Size = UDim2.new(0, 100, 0, 100)
        vu441.TextSize = 10
        vu441.TextColor3 = vu438.Color
        vu441.TextStrokeTransparency = 0
        vu441.TextYAlignment = Enum.TextYAlignment.Bottom
        vu441.Text = "..."
        vu441.ZIndex = 15
        vu441.RichText = true
        vu441.Parent = lf_111
        lf_111.Parent = lf_110
        lf_110.Parent = pu434.Folder
        vu438.EspHandle = lf_110
        task.spawn(function()
            local lf_112 = pu434.IsEnabled
            local lf_113 = vu438.EspHandle
            local lf_114 = vu438.Object
                if not (vu38.SmoothMode and task.wait(0.25)) then
                    vu13:Wait()
                end
                if not lf_114 or (not lf_114:IsDescendantOf(workspace) or (not lf_113 or lf_112 and not lf_112(lf_114))) then
                    return vu422(vu438)
                end
                local lf_115 = vu420(lf_114)
                if not lf_115 then
                    return vu422(vu438)
                end
                if lf_115:IsA("Model") then
                    lf_115 = lf_115:GetPivot()
                end
                local lf_116 = vu14
                local lf_117 = math.floor(lf_116:DistanceFromCharacter(lf_115.Position) / 5)
                local lf_118 = lf_114:FindFirstChildOfClass("Humanoid")
                if lf_118 then
                    vu441.Text = vu424:format(vu438.Name, lf_117, math.floor(lf_118.Health), math.floor(lf_118.MaxHealth))
                elseif lf_114.Parent ~= workspace or lf_114.Name ~= "Fruit " then
                    vu441.Text = ("%s < %i >"):format(vu438.Name, lf_117)
                else
                    vu441.Text = "Fruit [ ??? ]"
                    vu441.Text = ("%s < %i >"):format(vu423[lf_114], lf_117)
                end
            end
end)
        return vu438
    end
    function vu415.toggle(p449, p450)
        local lf_119 = "Esp" .. p449.Name
        vu32[lf_119] = p450
        local lf_120 = p449.IsEnabled
        local lf_121 = p449.Instance
        local lf_122 = p449.IsEspObject
        while vu32[lf_119] do
            local v455
            if type(lf_121) ~= "table" or not lf_121 then
                v455 = lf_121:GetChildren()
            else
                v455 = lf_121
            end
            for v456 = 1, # v455 do
                local lf_123 = v455[v456]
                if not p449.List[lf_123] then
                    local v458, v459, v460, v461 = lf_122(lf_123)
                    if v458 then
                        p449.List[lf_123] = p449:add(v461 or lf_123, v459, v460, lf_120)
                    end
                end
            end
            task.wait(0.25)
        end
        p449:clear()
    end
    return vu415
end
function vu103.SeaManager()
    if vu82.GameData.Sea == 1 then
    end
        oldTool = "Melee",
        SeaEvents = {},
        BoatTweenDebounce = 0,
        randomNumber = 1,
        toolDebounce = 0,
        rdDebounce = 0,
        nextNum = 1,
        SeaEnemyVector = Vector3.new(0, 32, 0),
        DodgeVector = Vector3.new(0, 160, 0),
        nextTool = {
            Melee = "Blox Fruit",
            ["Blox Fruit"] = "Sword",
            Sword = "Gun",
            Gun = "Melee"
        BuyBoat = {
            Position = vu82.GameData.Sea == 2 and CFrame.new(94, 10, 2951) or CFrame.new(- 6123, 16, - 2247),
            TikiIsland = CFrame.new(- 16917, 9, 510),
            BoatName = "BeastHunter",
            OthersBoats = {
                "BeastHunter",
                "Guardian",
                "Lantern",
                "Sleigh",
                "PirateGrandBrigade",
                "MarineGrandBrigade"
        RandomPosition = ({
                CFrame.new(- 43, 21, 5054),
                CFrame.new(1744, 21, 4393),
                CFrame.new(1003, 21, 3598),
                CFrame.new(- 935, 21, 3813)
                inf = - 100000000,
                ["6"] = - 43200,
                ["5"] = - 38200,
                ["4"] = - 34000,
                ["3"] = - 30000,
                ["2"] = - 26000,
                ["1"] = - 22000
        })[vu82.GameData.Sea],
        Directions = {
            Vector3.new(60, 0, 0),
            Vector3.new(0, 0, 60),
            Vector3.new(- 60, 0, 0),
            Vector3.new(0, 0, - 60),
            Vector3.new(0, 0, 0)
        TerrorSkills = {
            "FinalSpinAttachment",
            "GroundExplosionSplashStart",
            "SpinSlash",
            "SpinSlash3",
            "SpinSlash4"
    local gt_cfdxnuksixuv = vu82.Inventory.Unlocked
    local vu463 = vu82.Inventory.Count
    local vu464 = vu82.IsAlive
    local vu465 = vu82.UseSkills
    local vu466 = vu82.EquipTool
    local vu467 = vu82.FireRemote
    local vu469 = vu29:WaitForChild("SubclassNetwork")
    if vu82.GameData.Sea == 3 then
        local lf_124 = v462.RandomPosition
        local v471, v472, v473 = pairs(lf_124)
            local v474
            v473, v474 = v471(v472, v473)
            if v473 == nil then
            end
            lf_124[v473] = {
                CFrame.new(v474, 21, 500),
                CFrame.new(v474 - 3000, 21, 500),
                CFrame.new(v474 - 3000, 21, 2000),
                CFrame.new(v474, 21, - 1000)
        end
    end
    function v462.IsOwner(p475)
        local lf_125 = p475:FindFirstChild("Owner")
        if lf_125 then
            lf_125 = p475.Owner.Value.Name == vu14.Name
        end
        return lf_125
    end
    function v462.GetPlayerBoat(p477)
        if vu464(vu14.Character) then
            local lf_126 = p477.PlayerBoat
            if lf_126 and (not lf_126:FindFirstChild("Health") or vu464(lf_126)) and lf_126:IsDescendantOf(vu23) then
                return lf_126
            end
            local lf_127 = vu14.Character.Humanoid.SeatPart
            if lf_127 and lf_127.Name == "VehicleSeat" then
                p477.PlayerBoat = lf_127.Parent
                return p477.PlayerBoat
            end
            local lf_128 = vu23
            local v481, v482, v483 = ipairs(lf_128:GetChildren())
                local v484
                v483, v484 = v481(v482, v483)
                if v483 == nil then
                end
                if (not v484:FindFirstChild("Health") or vu464(v484)) and p477.IsOwner(v484) then
                    if v484.Name ~= p477.BuyBoat.BoatName then
                        p477.BuyBoat.BoatName = v484.Name
                    end
                    p477.PlayerBoat = v484
                    return v484
                end
            end
        end
    end
    function v462.BuyNewBoat(p485)
        if not vu82.IsAlive(vu14.Character) then
        end
        local lf_129 = p485.BuyBoat
        local lf_130 = lf_129.Position
        if vu82.GameData.Sea == 3 then
            local lf_131 = vu14
            if vu14:DistanceFromCharacter(lf_129.TikiIsland.Position) < lf_131:DistanceFromCharacter(lf_130.Position) then
                lf_130 = lf_129.TikiIsland
            end
        end
        if vu14:DistanceFromCharacter(lf_130.Position) >= 10 then
            vu83(lf_130)
        elseif vu467("BuyBoat", lf_129.BoatName) ~= 1 then
            for v489 = 1, # lf_129.OthersBoats do
                local lf_132 = lf_129.OthersBoats[v489]
                if lf_132 ~= lf_129.BoatName then
                    if vu467("BuyBoat", lf_132) == 1 then
                    end
                end
            end
        end
    end
    function v462.teleportBoat(p491, p492, p493, p494)
        if tick() - p491.BoatTweenDebounce >= 0.5 then
            local lf_133 = (p493.Position - p492.Position).Unit
            vu82.Tween.Velocity = lf_133 * (p494 or vu38.BoatSpeed)
            vu82:RemoveBoatCollision(p492.Parent)
            p491.BoatTweenDebounce = tick()
        end
    end
    function v462.StopBoat(_)
        vu82.Tween.Velocity = Vector3.zero
    end
    function v462.GetSelectedLevel(p496, p497)
        return p496.RandomPosition[p497 or vu38.SeaLevel]
    end
    function v462.RandomTeleport(p498, p499)
        if not vu468 or vu468.Health <= 0 then
            local lf_134 = vu14.Character
            if lf_134 then
                lf_134 = vu14.Character:FindFirstChild("Humanoid")
            end
            vu468 = lf_134
        end
        if not vu468.SeatPart then
            return p498:TeleportToBoat()
        end
        local lf_135 = p498:GetPlayerBoat().PrimaryPart
        if not lf_135 then
        end
        local lf_136 = lf_135.Position
        local lf_137 = vu82.GameData.Sea == 3 and p498:GetSelectedLevel(p499) or p498.RandomPosition
        if # lf_137 ~= 1 then
            if # lf_137 > 1 then
                if p498.nextNum > # lf_137 then
                    p498.nextNum = 1
                end
                local lf_138 = lf_137[p498.nextNum]
                if (lf_136 - lf_138.Position).Magnitude >= 100 then
                    p498:teleportBoat(lf_135, lf_138)
                else
                    p498.nextNum = p498.nextNum + 1
                end
            end
        else
            p498:teleportBoat(lf_135, lf_137[1])
        end
    end
    function v462.RandomTool(p505)
        if tick() - p505.toolDebounce < 2 then
            return p505.oldTool
        end
        p505.toolDebounce = tick()
        local lf_139 = p505.nextTool[p505.oldTool]
        local lf_140 = 0
        while not VerifyToolTip(lf_139) do
            lf_139 = p505.nextTool[lf_139]
            lf_140 = lf_140 + 1
            if lf_140 >= 3 then
                p505.oldTool = lf_139
                return lf_139
            end
        end
        p505.oldTool = lf_139
        return lf_139
    end
    function v462.GetSeaEvent(_, p508)
        local lf_141 = vu25
        local v510, v511, v512 = ipairs(lf_141:GetChildren())
            local v513
            v512, v513 = v510(v511, v512)
            if v512 == nil then
            end
            if v513.Name == p508 and vu464(v513) then
                return v513
            end
        end
    end
    function v462.attackBoat(p514, p515)
        local lf_142 = p515.PrimaryPart
        if not lf_142 then
        end
        local lf_143 = lf_142.CFrame + Vector3.new(0, 20, 0)
        EnableBuso()
        vu83(lf_143)
        p514:StopBoat()
        if vu14:DistanceFromCharacter(lf_143.Position) < 50 then
            vu465(lf_142, vu38.SeaSkills)
            vu466(p514:RandomTool(), true)
        end
    end
    function v462.attackFish(p518, p519)
        local lf_144 = p519.PrimaryPart
        if lf_144 then
            if (p519.Name == "Terrorshark" or p519.Name == "Shark") and vu38.DodgeShark then
                local lf_145 = p518.TerrorSkills
                for v522 = 1, # lf_145 do
                    local lf_146 = vu27:FindFirstChild(lf_145[v522])
                    if lf_146 then
                        if (lf_146.Position - lf_144.Position).Magnitude <= 100 then
                            return vu83(lf_144.CFrame + p518.DodgeVector)
                        end
                    end
                end
            end
            vu83(lf_144.CFrame + p518.SeaEnemyVector)
            vu466()
            EnableBuso()
            p518:StopBoat()
        end
    end
    function v462.StartHolding(_, p524)
        if not p524:GetAttribute("Repairing") then
            vu2:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            print("Segurando o mouse")
            p524.AncestryChanged:Wait()
            vu2:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            print("Parou de segurar")
        end
    end
    function v462.RepairBoat(p525, p526)
        local lf_147 = vu38.RepairBoat and vu17.Value == "Shipwright" and (vu463["Wooden Plank"] > 0 and p526:FindFirstChild("Humanoid"))
        if lf_147 and (p526:GetAttribute("__Repair") or lf_147.Value < (p526:GetAttribute("MaxHealth") or lf_147.Value) / 1.2) then
            local lf_148 = (vu14.Character or vu14.CharacterAdded:Wait()):FindFirstChild("_RepairHammer")
            if lf_147.Value >= (p526:GetAttribute("MaxHealth") or lf_147.Value) then
                p526:SetAttribute("__Repair", nil)
            else
                p526:SetAttribute("__Repair", true)
            end
            if not (lf_148 and lf_148:WaitForChild("Marker")) then
                if p526:FindFirstChild("VehicleSeat") then
                    local lf_149 = p526.VehicleSeat.CFrame + Vector3.yAxis * 20
                    if vu14:DistanceFromCharacter(lf_149.Position) > 5 then
                        vu83(lf_149)
                    else
                        vu469.UseSubclass:InvokeServer({
                            Action = "RequestHammer"
                        })
                    end
                end
                return true, p525:StopBoat(p526)
            end
            vu83(lf_148.Marker.Value.WorldCFrame + Vector3.xAxis * 10)
            task.spawn(p525.StartHolding, p525, lf_148)
        end
        if vu17.Value == "Shipwright" and (vu38.RepairBoat and vu14.Character) and vu14.Character:FindFirstChild("_RepairHammer") then
            vu469.UseSubclass:InvokeServer({
                Action = "RequestHammer"
            })
        end
    end
    function v462.attackSeaEvent(p530, p531)
        if p531:GetAttribute("IsBoat") then
            p530:attackBoat(p531)
        else
            p530:attackFish(p531)
        end
    end
    function v462.RandomDirection(p532)
        if tick() - p532.rdDebounce < 1.5 then
            return p532.Directions[p532.randomNumber]
        end
        p532.rdDebounce = tick()
        p532.randomNumber = math.random(# p532.Directions)
        return p532.Directions[p532.randomNumber]
    end
    function v462.attackSeaBeast(p533, p534)
        local lf_150 = p533:RandomDirection()
        local lf_151 = p534:FindFirstChild("HumanoidRootPart")
        if not lf_151 then
        end
        local lf_152 = lf_151.Position
        local lf_153 = CFrame.new(lf_152.X, 25, lf_152.Z) + lf_150
        vu83(lf_153)
        p533:StopBoat()
        vu466(p533:RandomTool(), true)
        vu465(lf_153, vu38.SeaSkills)
    end
    function v462.GetSeaBeast(p539)
        local lf_154 = p539.SeaBeast
        if lf_154 and (lf_154.Parent == vu24 and vu464(lf_154)) then
            return lf_154
        end
        local lf_155 = math.huge
        local lf_156 = vu24
        local v543, v544, v545 = ipairs(lf_156:GetChildren())
            local v547
            v545, v547 = v543(v544, v545)
            if v545 == nil then
            end
            if v547:IsA("Model") then
                local lf_157 = vu14:DistanceFromCharacter(v547:GetPivot().Position)
                if vu464(v547) then
                    if lf_157 < lf_155 then
                        v546 = v547
                        lf_155 = lf_157
                    end
                end
            end
        end
        p539.SeaBeast = v546
        return v546
    end
    function v462.TeleportToBoat(p549)
        if not vu468 or vu468.Health <= 0 or not vu468:IsDescendantOf(vu26) then
            local lf_158 = vu14.Character
            if lf_158 then
                lf_158 = vu14.Character:FindFirstChild("Humanoid")
            end
            vu468 = lf_158
        end
        local lf_159 = p549.VehicleSeat
        if lf_159 and lf_159:IsDescendantOf(p549.PlayerBoat) then
            if vu468.SeatPart and vu468.SeatPart ~= lf_159 then
                vu468.Sit = false
            elseif vu14:DistanceFromCharacter(lf_159.Position) >= 150 then
                vu83(lf_159.CFrame)
            else
                lf_159:Sit(vu468)
            end
            task.wait(0.25)
        elseif p549.PlayerBoat then
            p549.VehicleSeat = p549.PlayerBoat:FindFirstChild("VehicleSeat")
        end
    end
    return v462
end
function vu103.FruitManager()
        RandomDebounce = 0,
        MoneyToReroll = 0
    local vu553 = vu82.IsAlive
    local gt_epztcturxzhq = vu82.FruitsName
    local vu554 = vu82.Inventory.Count
    local gt_lcpttsmuqcrt = vu82.Inventory.Unlocked
    function v552.GetRealFruitName(_, p555)
        local lf_160 = string.gsub(p555.Name, " Fruit", "")
        return lf_160 .. "-" .. lf_160
    end
    function v552.CanStoreFruit(p557, p558)
        return vu554[p557:GetRealFruitName(p558)] < vu18.Value
    end
    function v552.StoreFruit(p559, p560)
        return vu82.FireRemote("StoreFruit", p559:GetRealFruitName(p560), p560)
    end
    function v552.IsFruit(_, p561)
        local v562
        if string.sub(p561.Name, - 6, - 1) ~= " Fruit" then
            v562 = false
        else
            v562 = p561:GetAttribute("DroppedBy")
        end
        return v562
    end
    function v552.GetInventoryItems(_)
        local lf_161 = vu14.Backpack:GetChildren()
        local lf_162 = vu14.Character:FindFirstChildOfClass("Tool")
        if lf_162 then
            table.insert(lf_161, lf_162)
        end
        return lf_161
    end
    function v552.CanBuyMicrochip(p565)
        if not vu553(vu14.Character) then
            return false
        end
        if vu14:GetAttribute("IslandRaiding") then
            return false
        end
        if vu14.Backpack:FindFirstChild("Microchip") or vu14.Character:FindFirstChild("Microchip") then
            return false
        end
        local v566, v567, v568 = ipairs(p565:GetInventoryItems())
            local v569
            v568, v569 = v566(v567, v568)
            if v568 == nil then
            end
            if v569:IsA("Tool") and p565:IsFruit(v569) then
            end
        end
        return - 1
    end
    function v552.GetStorableFruit(p570, p571)
        if not vu553(vu14.Character) then
            return false
        end
        local v572, v573, v574 = ipairs(p570:GetInventoryItems())
        repeat
            local v575
            v574, v575 = v572(v573, v574)
        until v574 == nil or v575.Name ~= p571 and not vu553(vu14.Character)
    end
    function v552.RerollRandomFruit(p576)
        if vu19.Value < 50 then
            return vu19:GetPropertyChangedSignal("Value"):Wait()
        end
        if vu20.Value < p576.MoneyToReroll then
            return vu20:GetPropertyChangedSignal("Value"):Wait()
        end
        if tick() - p576.RandomDebounce >= 1 then
            local lf_163 = vu82.FireRemote("Cousin", "Buy")
            if lf_163 == 1 then
                p576.RandomDebounce = tick() + 7200
            elseif lf_163 == 2 then
                local gt_zyktbdbtawbi, _, v578 = vu82.FireRemote("Cousin", "Check")
                p576.MoneyToReroll = v578 or 0
            elseif type(lf_163) ~= "string" or not lf_163:match("%d%d:%d%d") then
                p576.RandomDebounce = tick() + 5
            else
                local v579, v580 = lf_163:match("(%d+):(%d+)")
                local lf_164 = tonumber(v579)
                local lf_165 = tonumber(v580)
                if lf_164 and lf_165 then
                    local lf_166 = lf_164 * 60 * 60
                    local lf_167 = lf_165 * 60
                    p576.RandomDebounce = tick() + (lf_166 + lf_167)
                end
            end
        end
    end
    return v552
end
function vu102.RunModules(p585)
    local lf_168 = next
    local lf_169 = p585.Managers
        local v589
        v588, v589 = lf_168(lf_169, v588)
        if v588 == nil then
        end
        local v590, v591 = pcall(v589)
        if v590 then
            p585.Managers[v588] = v591
            vu32[v588] = v591
        else
            vu32[v588] = nil
            warn("falha ao carregar Module [ redz hub ]: " .. v588 .. " : " .. v591)
        end
    end
end
function vu102.Initialize(p592)
    vu81 = __loadstring(vu1.LibraryUrl or "{Owner}RedzLibV5/refs/heads/main/Source.lua")
    vu82 = __loadstring(vu1.ModuleUrl or "{Repository}Utils/Module.luau", " return Module", {
        vu38,
        vu76
    })
    p592.IsCustomUrl = (vu1.LibraryUrl or (vu1.ModuleUrl or vu1.CustomFunctions)) and true or false
    vu102:RunModules()
end
function vu102.LoadTabs(_, p593)
    return {
        Discord = p593:MakeTab({
            "Discord",
            "Info"
        }),
        MainFarm = p593:MakeTab({
            "Farm",
            "Home"
        }),
        Sea = p593:MakeTab({
            "Sea",
            "Waves"
        }),
        RaceV4 = p593:MakeTab({
            "Race-V4",
            ""
        }),
        Islands = p593:MakeTab({
            "Islands",
            "PalmTree"
        }),
        Items = p593:MakeTab({
            "Quests/Items",
            "Swords"
        }),
        FruitRaid = p593:MakeTab({
            "Fruit/Raid",
            "Cherry"
        }),
        Stats = p593:MakeTab({
            "Stats",
            "Signal"
        }),
        Teleport = p593:MakeTab({
            "Teleport",
            "Locate"
        }),
        Status = p593:MakeTab({
            "Status",
            "scroll"
        }),
        Visual = p593:MakeTab({
            "Visual",
            "User"
        }),
        Shop = p593:MakeTab({
            "Shop",
            "ShoppingCart"
        }),
        Misc = p593:MakeTab({
            "Misc",
            "Settings"
        })
end
function vu102.InstallPlugin(_)
    return {
        Toggle = vu82.RunFunctions.LibraryToggle(vu45, vu34)
end
function vu102.GetTranslation(_, p594)
        BR = "Portuguese.json",
        VN = "Vietnamese.json",
        TH = "Thai.json"
    if v595[p594] then
        local gt_emakidvydlzs = vu7.JSONDecode
        local gt_jbifzmzpgtim = __httpget
        local gt_dkvqisbvhkqj = "{Owner}BloxFruits/refs/heads/main/Translator/" .. v595[p594]
    end
end
function vu102.Translator(p596, p597)
    if not vu1.Translator then
        return p597
    end
    local v600, v601, v602 = pcall(function()
        local lf_170 = readfile
        if lf_170 then
            lf_170 = pcall(readfile, "PlayerCountry.txt")
        end
        if lf_170 and type(v599) == "string" then
            return v599, true
        else
            return vu3:GetCountryRegionForPlayerAsync(vu14)
        end
end)
    if v600 and (v601 and (v602 ~= true and writefile)) then
        pcall(writefile, "PlayerCountry.txt", v601)
    end
    if v600 then
        v600 = p596:GetTranslation(v601)
    end
    if v600 then
        local gt_twgimrygopkq = vu82.RunFunctions.Translator
    end
    return p597
end
function vu102.DisableOption(_)
    if vu38.RunningOption and vu34[vu38.RunningOption] then
        vu34[vu38.RunningOption]:Set(false, true)
    end
end
function vu102.LoadLibrary(pu603)
    local lf_171 = vu81:MakeWindow({
        "redz Hub : Blox Fruits",
        "by real_redz",
        "redzHub-BloxFruits.json"
    })
    pu603:Translator(lf_171)
    local lf_172 = pu603:InstallPlugin(lf_171)
    local lf_173 = pu603:LoadTabs(lf_171)
    local vu607 = pu603.Managers.FruitManager
    local lf_174 = pu603.Managers.QuestManager
    local lf_175 = pu603.Managers.FarmManager
    local vu610 = vu82.FireRemote
    local vu611 = vu82.Inventory.Count
    local vu612 = vu82.Inventory.Unlocked
    local lf_176 = vu82.GameData.Sea
    local lf_177 = lf_172.Toggle
    lf_171:SelectTab(lf_173.MainFarm)
    lf_171:AddMinimizeButton({
        Button = {
            Image = "rbxassetid://15298567397",
            BackgroundTransparency = 0
        Corner = {
            CornerRadius = UDim.new(0, 6)
    })
    local lf_178 = lf_173.Discord
    lf_178:AddDiscordInvite({
        Name = "redz Hub | Community",
        Description = "Join our discord community to receive information about the next update",
        Logo = "rbxassetid://17382040552",
        Invite = "https://discord.gg/7aR7kNVt4g"
    })
    lf_178:AddSection("")
    lf_178:AddParagraph({
        "Mentions:
 Honorable Mention: acsu123
 Honorable Mention 2: XFister"
    })
    local lf_179 = lf_173.MainFarm
        Bigger = 380,
        Large = 450,
        Medium = 620,
        Small = 760
            "Z",
            "X",
            "C",
            "V",
            "F"
        ToDictionary({
            "Z",
            "X",
            "C",
            "V"
        })
    local function v620(p619)
        pcall(vu81.SetScale, vu81, vu617[p619] or 450)
    end
    local function v623(p621)
        vu32.TradeBones = p621
        while vu32.TradeBones do
            task.wait()
            local lf_180 = vu611.Bones
            if lf_180 >= 50 then
                vu610("Bones", "Buy", 1, 1)
                if lf_180 == vu611.Bones then
                    task.wait(5)
                end
            else
                task.wait(0.5)
            end
        end
    end
    local function v630()
        local v625, v626, v627 = pairs(vu82.Bosses)
            local v629
            v627, v629 = v625(v626, v627)
            if v627 == nil then
            end
            if vu82.Enemies.IsSpawned(v627) then
                table.insert(v628, v627)
            end
        end
        vu624:Set(v628)
    end
    lf_179:AddDropdown({
        "Select Tool",
            "Melee",
            "Sword",
            "Blox Fruit",
            "Gun"
        "Melee",
            vu38,
            "FarmTool"
        "FarmTool"
    })
    lf_179:AddDropdown({
        "UI Scale",
            "Small",
            "Medium",
            "Large",
            "Bigger"
        "Large",
        v620,
        "UIScale"
    })
    lf_179:AddSection("Farm")
    lf_177(lf_179, {
        "Auto Farm Level",
        "Level Farm"
    }, "Level")
    lf_177(lf_179, {
        "Auto Farm Nearest",
        "Farm Nearest Mobs"
    }, "Nearest")
    if lf_176 ~= 1 then
        if lf_176 == 2 then
            lf_177(lf_179, {
                "Auto Factory",
                "Spawns Every 1:30 [hours, minutes]"
            }, "Factory")
            lf_179:AddSection("Ectoplasm")
            lf_177(lf_179, {
                "Auto Farm Ectoplasm"
            }, "Ectoplasm")
        elseif lf_176 == 3 then
            lf_177(lf_179, {
                "Auto Pirates Sea",
                "Auto Finish Pirate Raid in Sea Castle"
            }, "PirateRaid")
            lf_179:AddSection("Bones")
            lf_177(lf_179, {
                "Auto Farm Bones"
            }, "Bones")
                "Auto Kill Soul Reaper"
            }, "SoulReaper")
            lf_179:AddToggle({
                "Auto Trade Bones",
                v623,
                "TradeBones"
            })
        end
    end
    lf_179:AddSection("Chest")
        "Auto Chest [ Tween ]"
    }, "ChestTween")
    lf_179:AddSection("Bosses")
    lf_179:AddButton({
        "Update Boss List",
        v630
    })
    vu624 = lf_179:AddDropdown({
        "Boss List",
        {},
            vu38,
            "BossSelected"
        "B-Selected"
    })
    v630()
        "Auto Kill Boss Selected",
        "Kill boss Selected"
    }, "BossSelected")
        "Auto Farm All Bosses",
        "Kill all bosses Spawned"
    }, "AllBosses")
    lf_179:AddToggle({
        "Take Boss Quest",
            vu38,
            "BossQuest"
        "B-Quest"
    })
    lf_179:AddSection("Material")
    local lf_181 = lf_179.AddDropdown
        vu38,
        "fMaterial"
    __set_list(v632, 1, {
        "Material List",
        lf_175.Materials,
        v633,
        "S-Material"
    })
    lf_181(lf_179, v632)
        "Auto Farm Material",
        "Farm material Selected"
    }, "Material")
    lf_179:AddSection("Mastery")
    lf_179:AddSlider({
        "Select Enemy Health [ % ]",
        10,
        100,
        1,
        25,
            vu38,
            "mHealth"
        "M-Health"
    })
    lf_179:AddDropdown({
        "Select Tool",
            "Blox Fruit",
            "Gun"
            "Blox Fruit"
            "mTool"
        "M-Tool"
    })
    local lf_182 = lf_179.AddDropdown
    local lf_183 = v618[1]
    local lf_184 = v618[2]
        "MasterySkills"
    v635.MultiSelect = true
    __set_list(v635, 1, {
        "Select Skills",
        lf_183,
        lf_184,
        v638,
        "M-Skills"
    })
    lf_182(lf_179, v635)
        "Auto Farm Mastery"
    }, "Mastery")
    local lf_185 = lf_173.Sea
    if lf_176 == 1 then
        lf_185:Destroy()
    elseif lf_176 == 2 then
                "Sea Beast",
                "PirateBrigade"
            ToDictionary({
                "Sea Beast"
            })
                "Z",
                "X",
                "C",
                "V",
                "F"
            ToDictionary({
                "Z",
                "X",
                "C",
                "V"
            })
        lf_185:AddSection("Farm")
        lf_177(lf_185, {
            "Auto Farm Sea"
        }, "Sea")
        lf_185:AddSection("Farm Select")
        local lf_186 = lf_185.AddDropdown
        local lf_187 = v640[1]
        local lf_188 = v640[2]
            "seaEnemy"
        v643.MultiSelect = true
        __set_list(v643, 1, {
            "Enemies",
            lf_187,
            lf_188,
            v646,
            "S-Enemies"
        })
        lf_186(lf_185, v643)
        local lf_189 = lf_185.AddDropdown
        local lf_190 = v641[1]
        local lf_191 = v641[2]
            "SeaSkills"
        v648.MultiSelect = true
        __set_list(v648, 1, {
            "Select Skills",
            lf_190,
            lf_191,
            v651,
            "S-Skills"
        })
        lf_189(lf_185, v648)
        lf_185:AddSection("Configs")
        lf_185:AddSlider({
            "Boat Tween Speed",
            100,
            300,
            10,
            250,
                "BoatSpeed"
            "S-BoatSpeed"
        })
        lf_185:AddToggle({
            "Auto Repair Boat [ BETA ]",
                "RepairBoat"
            "S-RepairBoat"
        })
    elseif lf_176 == 3 then
                "Z",
                "X",
                "C",
                "V",
                "F"
            ToDictionary({
                "Z",
                "X",
                "C",
                "V"
            })
                "Sea Beast",
                "Terrorshark",
                "Fish Crew Member",
                "Piranha",
                "Shark"
            ToDictionary({
                "Terrorshark",
                "Fish Crew Member",
                "Piranha",
                "Shark"
            })
            ["Shipwright Teacher"] = CFrame.new(- 16526, 76, 309),
            ["Shark Hunter"] = CFrame.new(- 16526, 108, 752),
            ["Beast Hunter"] = CFrame.new(- 16281, 73, 263),
            Spy = CFrame.new(- 16471, 528, 539)
        local function v657(p656)
            vu32.teleporting = p656
            while vu32.teleporting do
                task.wait()
                if vu38.selectedNpc then
                    vu83(vu655[vu38.selectedNpc])
                end
            end
            if p656 and vu654 then
                vu654:Set(false, true)
            end
        end
        local function v661(p658)
            if p658 then
                local lf_192 = pu603.Managers.PlayerTeleport
                local lf_193 = math.huge
                    task.wait()
                    if lf_192.lastPosition then
                        lf_193 = vu14:DistanceFromCharacter(lf_192.lastPosition)
                    end
                    if not vu32.teleporting or lf_193 < 15 then
                        vu32.teleporting = false
                    end
                end
            else
                return
            end
        end
        lf_185:AddSection("Sea")
        lf_177(lf_185, {
            "Auto Farm Sea"
        }, "Sea")
        lf_185:AddToggle({
            "Auto Drive Boat",
                "aTweenBoat"
            "A-TweenBoat"
        })
        lf_185:AddSection("Farm Select")
        local lf_194 = lf_185.AddDropdown
        local lf_195 = v653[1]
        local lf_196 = v653[2]
            "fishSelected"
        v663.MultiSelect = true
        __set_list(v663, 1, {
            "Fish",
            lf_195,
            lf_196,
            v666,
            "S-Fish"
        })
        lf_194(lf_185, v663)
        local lf_197 = lf_185.AddDropdown
            "boatSelected"
        v668.MultiSelect = true
        __set_list(v668, 1, {
            "Boats",
                "PirateBrigade",
                "PirateGrandBrigade",
                "GhostShip",
                "FishBoat"
            nil,
            v669,
            "S-Boat"
        })
        lf_197(lf_185, v668)
        local lf_198 = lf_185.AddDropdown
        local lf_199 = v652[1]
        local lf_200 = v652[2]
            "SeaSkills"
        v671.MultiSelect = true
        __set_list(v671, 1, {
            "Select Skills",
            lf_199,
            lf_200,
            v674,
            "S-Skills"
        })
        lf_198(lf_185, v671)
        lf_185:AddSection("Configs")
        lf_185:AddDropdown({
            "Sea Level",
                "1",
                "2",
                "3",
                "4",
                "5",
                "6",
                "inf"
            "6",
                "SeaLevel"
            "S-SeaLevel"
        })
        lf_185:AddSlider({
            "Boat Tween Speed",
            100,
            300,
            10,
            250,
                "BoatSpeed"
            "S-BoatSpeed"
        })
        lf_185:AddToggle({
            "Auto Repair Boat [ BETA ]",
                "RepairBoat"
            "S-RepairBoat"
        })
        lf_185:AddSection("NPCs")
        lf_185:AddDropdown({
            "Select NPC",
                "Shipwright Teacher",
                "Shark Hunter",
                "Beast Hunter",
                "Spy"
            "Spy",
                "selectedNpc"
        })
        vu654 = lf_185:AddToggle({
            "Teleport to NPC",
            v657
        })
        local lf_201 = vu654
        vu654.Callback(lf_201, v661)
        lf_185:AddSection("Quests/Items")
        lf_177(lf_185, {
            "Auto Unlock Shipwright Subclass [ BETA ]"
        }, "Shipwright")
    end
    local vu676 = lf_173.Stats
    if vu19.Value >= vu82.GameData.MaxLevel then
        vu676:Destroy()
    else
        local vu678 = vu15:WaitForChild("Points")
        local vu679 = vu15:WaitForChild("Stats")
        local function v686(p680)
            vu32.AutoStats = p680
            while task.wait() and vu32.AutoStats do
                local lf_202 = vu678.Value
                if lf_202 > 0 then
                    local v682, v683, v684 = pairs(vu677)
                        local v685
                        v684, v685 = v682(v683, v684)
                        if v684 == nil then
                        end
                        if v685 and vu679[v684].Level.Value < vu82.GameData.MaxLevel then
                            vu610("AddPoint", v684, (math.clamp(math.clamp(vu38.StatsPoints or 3, 0, lf_202), 0, vu82.GameData.MaxLevel)))
                        end
                    end
                end
            end
        end
        local function v688(_, p687)
            vu676:AddToggle({
                p687,
                    vu677,
                    p687
                "Stats-" .. p687
            })
        end
        vu676:AddSlider({
            "Points Amount",
            1,
            100,
            1,
            3,
                "StatsPoints"
            "P-Stats"
        })
        vu676:AddToggle({
            "Auto Stats",
            v686,
            "A-Stats"
        })
        vu676:AddSection("Select Stats")
        table.foreach({
            "Melee",
            "Defense",
            "Gun",
            "Sword",
            "Demon Fruit"
        }, v688)
    end
    local lf_203 = lf_173.RaceV4
    if lf_176 == 4 then
        lf_203:AddSection("Race V4")
        lf_177(lf_203, {
            "Auto Finish Trial"
        }, "TrialV4")
        lf_177(lf_203, {
            "Auto Kill Players in Trial"
        }, "KillPlayersV4")
        lf_177(lf_203, {
            "Auto Train Race"
        }, "TrainV4")
    else
        lf_203:Destroy()
    end
    local vu690 = lf_173.Islands
    if lf_176 == 3 then
        local function v693(p691)
            vu32.LookMoon = p691
            while vu32.LookMoon do
                local lf_204 = vu9
                vu12.CFrame = CFrame.new(vu12.CFrame.Position, lf_204:GetMoonDirection() + vu12.CFrame.Position)
                task.wait()
            end
        end
        local function v695(p694)
            vu32.TradeAzure = p694
            while vu32.TradeAzure do
                if vu9:GetAttribute("IsBlueMoon") and (not vu9:GetAttribute("BlueMoonEnded") and vu611["Azure Ember"] >= vu38.Azure) then
                    vu31["RF/KitsuneStatuePray"]:InvokeServer()
                end
                task.wait(1)
            end
        end
        local function v701(p696, p697)
            local lf_205 = vu690:AddParagraph({
                p696 .. " : not Spawn"
            })
            while task.wait() do
                local lf_206 = vu21:FindFirstChild(p697)
                if lf_206 then
                    local lf_207 = vu14
                    lf_205:SetTitle(p696 .. " : Spawned | Distance : " .. math.floor(lf_207:DistanceFromCharacter(lf_206.WorldPivot.Position) / 5))
                else
                    lf_205:SetTitle(p696 .. " : not Spawn")
                    vu21.ChildAdded:Wait()
                end
            end
        end
        vu690:AddSection("Islands Stats")
        task.spawn(v701, "Mirage Island", "MysticIsland")
        task.spawn(v701, "Kitsune Island", "KitsuneIsland")
        task.spawn(v701, "Prehistoric Island", "PrehistoricIsland")
        vu690:AddSection("Prehistoric Island")
        lf_177(vu690, {
            "Auto Craft Volcanic Magnet"
        }, "CraftVolcanicMagnet")
        lf_177(vu690, {
            "Auto Prehistoric Island"
        }, "PrehistoricIsland")
        lf_177(vu690, {
            "Auto Kill Lava Golem"
        }, "LavaGolem")
        lf_177(vu690, {
            "Auto Collect Dinosaur Bones"
        }, "PrehistoricBones")
        lf_177(vu690, {
            "Auto Collect Dragon Egg"
        }, "PrehistoricEgg")
        vu690:AddToggle({
            "Reset after finishing",
                "ResetPrehistoric"
            "P-Reset"
        })
        vu690:AddSection("Leviathan [ BETA ]")
        lf_177(vu690, {
            "Auto Attack Leviathan"
        }, "Leviathan")
        vu690:AddSection("Kitsune Island")
        vu690:AddSlider({
            "Trade Azure Ember Amount",
            10,
            25,
            5,
            20,
                "Azure"
            "A-Amount"
        })
        vu690:AddToggle({
            "Auto Trade Azure Ember",
            v695
        }, "Trade-Azure")
            "Auto Kitsune Island"
        }, "KitsuneIsland")
        vu690:AddSection("Mirage Island")
            "Teleport To Gear"
        }, "MirageGear")
            "Teleport To Mirage"
        }, "TeleportMirage")
            "Teleport To Fruit Dealer"
        }, "MirageFruitDealer")
            "Collect Mirage Chests"
        }, "MirageChests")
        vu690:AddToggle({
            "Look To Moon",
            v693,
            "MirageLookMoon"
        })
    else
        vu690:Destroy()
    end
    local lf_208 = lf_173.FruitRaid
        "Rocket",
        "Spin",
        "Blade",
        "Spring",
        "Bomb",
        "Smoke",
        "Spike"
    local lf_209 = "Only on Sea 2 and 3"
    local vu705 = true
    local function v710(p707)
        vu32.auto_store = p707
        while vu32.auto_store do
            task.wait(vu38.SmoothMode and 0.3 or 0.2)
            vu705 = false
            local lf_210 = not vu14:GetAttribute("IslandRaiding") and vu32.unstore_common_fruits
            if lf_210 then
                lf_210 = vu706
            end
            local lf_211 = vu607:GetStorableFruit(lf_210)
            if lf_211 then
                vu607:StoreFruit(lf_211)
                vu706 = nil
            else
                vu705 = true
            end
        end
        vu705 = true
    end
    local function v712(p711)
        vu32.random_fruit = p711
        while vu32.random_fruit do
            vu607:RerollRandomFruit()
            task.wait(0.1)
        end
    end
    local function v714(p713)
        vu32.raid_microchip = p713
        while vu32.raid_microchip do
            if vu705 then
                if vu607:CanBuyMicrochip() then
                    vu610("RaidsNpc", "Select", vu38.SelectedChip)
                else
                    task.wait(0.1)
                end
            else
                task.wait()
            end
        end
    end
    local function v719(p715)
        vu32.unstore_common_fruits = p715
        while vu32.unstore_common_fruits do
            if vu607:CanBuyMicrochip() == - 1 and vu705 then
                for v716 = 1, # vu703 do
                    local lf_212 = vu703[v716]
                    local lf_213 = lf_212 .. "-" .. lf_212
                    if vu14.Character:FindFirstChild(lf_213) or vu14.Backpack:FindFirstChild(lf_213) then
                    end
                end
            end
            task.wait(0.25)
        end
    end
    lf_208:AddSection("Fruits")
    lf_208:AddToggle({
        "Auto Store Fruits",
        v710,
        "F-AutoStore"
    })
    lf_177(lf_208, {
        "Teleport To Fruits"
    }, "Fruits")
    lf_208:AddToggle({
        "Auto Random Fruit",
        v712,
        "F-RandomFruit"
    })
    lf_208:AddSection("Raid")
    if lf_176 == 2 or lf_176 == 3 then
        local lf_214 = lf_208.AddDropdown
            "SelectedChip"
        __set_list(v721, 1, {
            "Select Chip",
            vu82.RaidList,
            "",
            v722,
            "R-RaidChip"
        })
        lf_214(lf_208, v721)
        lf_177(lf_208, {
            "Auto Farm Raid",
            "Kill Aura, Start & Awaken"
        }, "Raid")
        lf_208:AddToggle({
            "Auto Buy Chip",
            v714,
            "R-BuyChip"
        })
        lf_208:AddToggle({
            "Unstore Common Fruits",
            v719,
            "R-Unstore"
        })
    else
        lf_208:AddParagraph({
            lf_209
        })
    end
    local lf_215 = lf_173.Teleport
    local vu725 = CFrame.new(28286, 14897, 103)
    local lf_216 = ({
            "WindMill",
            "Marine",
            "Middle Town",
            "Jungle",
            "Pirate Village",
            "Desert",
            "Snow Island",
            "MarineFord",
            "Colosseum",
            "Sky Island 1",
            "Sky Island 2",
            "Sky Island 3",
            "Prison",
            "Magma Village",
            "Under Water Island",
            "Fountain City"
            "The Cafe",
            "Frist Spot",
            "Dark Area",
            "Flamingo Mansion",
            "Flamingo Room",
            "Green Zone",
            "Zombie Island",
            "Two Snow Mountain",
            "Punk Hazard",
            "Cursed Ship",
            "Ice Castle",
            "Forgotten Island",
            "Ussop Island"
            "Mansion",
            "Port Town",
            "Great Tree",
            "Castle On The Sea",
            "Hydra Island",
            "Floating Turtle",
            "Haunted Castle",
            "Ice Cream Island",
            "Peanut Island",
            "Cake Island",
            "Candy Cane Island",
            "Tiki Outpost"
    })[lf_176]
        ["Middle Town"] = CFrame.new(- 688, 15, 1585),
        MarineFord = CFrame.new(- 4810, 21, 4359),
        Marine = CFrame.new(- 2728, 25, 2056),
        WindMill = CFrame.new(889, 17, 1434),
        Desert = CFrame.new(1054, 53, 4490),
        ["Snow Island"] = CFrame.new(1298, 87, - 1344),
        ["Pirate Village"] = CFrame.new(- 1173, 45, 3837),
        Jungle = CFrame.new(- 1614, 37, 146),
        Prison = CFrame.new(4870, 6, 736),
        ["Under Water Island"] = CFrame.new(61164, 5, 1820),
        Colosseum = CFrame.new(- 1535, 7, - 3014),
        ["Magma Village"] = CFrame.new(- 5290, 9, 8349),
        ["Sky Island 1"] = CFrame.new(- 4814, 718, - 2551),
        ["Sky Island 2"] = CFrame.new(- 4652, 873, - 1754),
        ["Sky Island 3"] = CFrame.new(- 7895, 5547, - 380),
        ["Fountain City"] = CFrame.new(5041, 1, 4101),
        ["The Cafe"] = CFrame.new(- 382, 73, 290),
        ["Frist Spot"] = CFrame.new(- 11, 29, 2771),
        ["Dark Area"] = CFrame.new(3494, 13, - 3259),
        ["Flamingo Mansion"] = CFrame.new(- 317, 331, 597),
        ["Flamingo Room"] = CFrame.new(2285, 15, 905),
        ["Green Zone"] = CFrame.new(- 2258, 73, - 2696),
        ["Zombie Island"] = CFrame.new(- 5552, 194, - 776),
        ["Two Snow Mountain"] = CFrame.new(752, 408, - 5277),
        ["Punk Hazard"] = CFrame.new(- 5897, 18, - 5096),
        ["Cursed Ship"] = CFrame.new(919, 125, 32869),
        ["Ice Castle"] = CFrame.new(5505, 40, - 6178),
        ["Forgotten Island"] = CFrame.new(- 3050, 240, - 10178),
        ["Ussop Island"] = CFrame.new(4816, 8, 2863),
        Mansion = CFrame.new(- 12471, 374, - 7551),
        ["Port Town"] = CFrame.new(- 334, 7, 5300),
        ["Castle On The Sea"] = CFrame.new(- 5073, 315, - 3153),
        ["Hydra Island"] = CFrame.new(5666, 1013, - 310),
        ["Great Tree"] = CFrame.new(2683, 275, - 7008),
        ["Floating Turtle"] = CFrame.new(- 12528, 332, - 8658),
        ["Haunted Castle"] = CFrame.new(- 9517, 142, 5528),
        ["Ice Cream Island"] = CFrame.new(- 902, 79, - 10988),
        ["Peanut Island"] = CFrame.new(- 2062, 50, - 10232),
        ["Cake Island"] = CFrame.new(- 1897, 14, - 11576),
        ["Candy Cane Island"] = CFrame.new(- 1038, 10, - 14076),
        ["Tiki Outpost"] = CFrame.new(- 16224, 9, 439)
    local function v728()
        for _ = 1, 10 do
            vu14.Character:SetPrimaryPartCFrame(vu725)
        end
    end
    local function v730(p729)
        vu32.teleporting = p729
        while vu32.teleporting do
            if vu727[vu32.SelectedIsland] then
                vu83(vu727[vu32.SelectedIsland])
            end
        end
        if p729 and vu724 then
            vu724:Set(false, true)
        end
    end
    local function v734(p731)
        if p731 then
            local lf_217 = pu603.Managers.PlayerTeleport
                if lf_217.lastPosition then
                    v733 = vu14:DistanceFromCharacter(lf_217.lastPosition)
                end
                if not vu32.teleporting or v733 < 15 then
                    vu32.teleporting = false
                end
            end
        else
            return
        end
    end
    lf_215:AddSection("Travel")
    local lf_218 = lf_215.AddButton
    local function v737()
        vu82:TravelTo(1)
    end
    v736.Desc = "Main"
    __set_list(v736, 1, {
        "Teleport to Sea 1",
        v737
    })
    lf_218(lf_215, v736)
    local lf_219 = lf_215.AddButton
    local function v740()
        vu82:TravelTo(2)
    end
    v739.Desc = "Dressrosa"
    __set_list(v739, 1, {
        "Teleport to Sea 2",
        v740
    })
    lf_219(lf_215, v739)
    local lf_220 = lf_215.AddButton
    local function v743()
        vu82:TravelTo(3)
    end
    v742.Desc = "Zou"
    __set_list(v742, 1, {
        "Teleport to Sea 3",
        v743
    })
    lf_220(lf_215, v742)
    lf_215:AddSection("Islands")
    lf_215:AddDropdown({
        "Select Island",
        lf_216,
        "",
            vu32,
            "SelectedIsland"
    })
    vu724 = lf_215:AddToggle({
        "Teleport to Island",
        v730
    })
    local lf_221 = vu724
    vu724.Callback(lf_221, v734)
    if lf_176 == 3 then
        lf_215:AddSection("Race V4")
        lf_215:AddButton({
            "Teleport to Temple of Time",
            v728
        })
    end
    local vu745 = lf_173.Status
    local vu746 = lf_176
    local gt_isrmklilhbaa = lf_175.Enemies.Elites
    local vu747 = vu82.Enemies.IsSpawned
    local vu749 = "�����"
    local vu750 = "�����"
    local vu752 = 0
    local function v758(p753, p754)
        if p754 or p754 == nil then
            local lf_222 = table.insert
            local lf_223 = vu751
                Paragraph = vu745:AddParagraph({
                    ""
                }),
                Function = p753
            lf_222(lf_223, v757)
        end
    end
    v758(function()
        local lf_224 = vu82:GetProgress("EliteProgress", "EliteHunter", "Progress")
        local lf_225 = vu82.Enemies:GetEnemyByTag("Elite")
        if lf_225 then
            return ("Elite Progress: %i
Elite Hunter: %s %s"):format(lf_224, lf_225.Name, vu749)
        else
            return ("Elite Progress: %i
Elite Hunter: %s"):format(lf_224, (vu748 and 600 - (tick() - vu748) >= 0 and (vu101.GetTimer(600 - (tick() - vu748) or "00:00") or "") or "") .. vu750)
        end
    end, vu746 == 3)
    v758(function()
        local lf_226 = vu747("Cake Prince") and "Cake Prince"
        if not lf_226 then
            local lf_227 = vu747("Dough King")
            lf_226 = lf_227 and "Dough King" or lf_227
        end
        if lf_226 then
            return ("Katakuri: %s %s"):format(lf_226, vu749)
        end
        local lf_228 = vu82
        local lf_229 = string.gsub(lf_228:GetProgress("Katakuri", "CakePrinceSpawner", true), "%D", "")
        return "Katakuri: " .. (lf_229:len() == 0 and ("0" or lf_229) or lf_229)
    end, vu746 == 3)
    v758(function()
        local lf_230 = vu82:GetProgress("Sword Dealer", "LegendarySwordDealer", "1")
        if type(lf_230) ~= "string" then
            return ("Sword Dealer: %s"):format(vu750)
        else
            return ("Sword Dealer: %s %s"):format(lf_230, vu749)
        end
    end, vu746 == 2)
    v758(function()
        local v766, v767 = vu82:GetProgress("BaristaCousin", "ColorsDealer", "1")
        if type(v766) ~= "string" then
            return "Barista Cousin: " .. vu750
        else
            return ("Barista Cousin: %s [ %s ] %s"):format(v766, 3 <= v767 and "LEGENDARY" or "Rare", vu749)
        end
end)
    v758(function()
        if workspace:FindFirstChild("Fruit ") then
            return ("Devil Fruit: %s %s"):format(vu82.FruitsName[workspace["Fruit "] ], vu749)
        else
            return "Devil Fruit: " .. vu750
        end
end)
    v758(function()
        for v769 = 1, # vu90 do
            if v769 % 10 == 0 then
                task.wait(0.1)
            end
            local lf_231 = vu90[v769]
            local v771, v772, v773 = pairs(lf_231:GetAttributes())
                local v774
                v773, v774 = v771(v772, v773)
                if v773 == nil then
                end
                table.insert(v768, v774)
            end
        end
        if # v768 <= 0 then
            return "Berries: " .. vu750
        else
            return ("Berries: #%i [ %s ] %s"):format(# v768, table.concat(v768, ", "), vu749)
        end
end)
        return "Players: " .. # vu10:GetPlayers() .. "/12"
end)
        return ("Enabled Options: %i/%i
Farm Status: %s [ %s ]"):format(# vu37, # vu36, vu38.RunningOption or "Null", vu38.RunningMethod or "Null")
end)
        return "Is Private Server: " .. (vu5.PrivateServerOwnerId.Value ~= 0 and vu749 or vu750)
end)
    local vu775 = 1
    vu776 = vu13:Connect(function()
        if not (vu745 and vu745.Cont) then
            return vu776:Disconnect()
        end
        if vu746 == 3 and (vu775 == 1 and tick() - vu752 >= 1) then
            if not vu745.Cont.Parent then
                vu752 = tick()
            end
            if vu82.Enemies:GetEnemyByTag("Elite") then
                vu748 = tick()
            end
        end
        if tick() - vu752 >= 1 and vu745.Cont.Parent then
            local lf_232 = vu751[vu775]
            vu775 = (vu775 >= # vu751 and 0 or vu775) + 1
            if vu775 >= # vu751 then
                vu752 = tick()
            end
            if lf_232 and not lf_232.Updating then
                lf_232.Updating = true
                lf_232.Paragraph:SetTitle(lf_232.Function())
                lf_232.Updating = false
            end
        end
end)
    local lf_233 = lf_173.Visual
    local lf_234 = pu603.Managers.EspManager
    local vu780 = vu1.EspColors or {
        Players = Color3.fromRGB(220, 220, 220),
        Fruits = Color3.fromRGB(255, 0, 0),
        Islands = Color3.fromRGB(0, 255, 255),
        Berries = Color3.fromRGB(255, 255, 0),
        Chests = {
            Chest1 = Color3.fromRGB(150, 150, 150),
            Chest2 = Color3.fromRGB(255, 255, 0),
            Chest3 = Color3.fromRGB(0, 255, 255),
            Null = Color3.fromRGB(150, 0, 255)
        Players = lf_234.new("Player", vu26, function(p781)
            if p781 ~= vu14.Character then
                return true, vu780.Players
            end
end)
,
        Islands = lf_234.new("Island", vu28, function(p782)
            if p782.Name ~= "Sea" then
                return true, vu780.Islands
            end
end)
,
        Fruits = lf_234.new("Fruit", workspace, function(p783)
            if p783:IsA("Model") and p783:GetPivot().Position == Vector3.zero then
            end
            if string.sub(p783.Name, - 6, - 1) == " Fruit" or p783.Name == "Fruit " then
                return true, vu780.Fruits, p783:FindFirstChild("Handle") or p783
            end
end)
,
        Flowers = lf_234.new("Flower", workspace, function(p784)
            if p784:IsA("BasePart") and p784.Name:find("Flower") then
                return true, p784.Color
            end
end)
,
        Chests = lf_234.new("Chests", vu89, function(p785)
            return not p785:GetAttribute("IsDisabled"), vu780.Chests[p785.Name]
        end, function(p786)
            return not p786:GetAttribute("IsDisabled")
end)
,
        Berries = lf_234.new("Berries", vu90, function(p787)
            local v788, v789, v790 = pairs(p787:GetAttributes())
            local v791, v792 = v788(v789, v790)
            if v791 ~= nil then
                return true, vu780.Berries, v792, p787.Parent
            end
        end, function(p793)
            if p793:FindFirstChild("Berries") then
                local v794, v795, v796 = pairs(p793.Berries:GetAttributes())
                local v797, _ = v794(v795, v796)
                if v797 ~= nil then
                end
            end
end)
    if not vu82:IsBlacklistedExecutor() then
        lf_233:AddSection("Aimbot Nearest")
        lf_233:AddToggle({
            "Aimbot Gun",
                vu32,
                "AimBot_Gun"
        })
        lf_233:AddToggle({
            "Aimbot Tap",
                vu32,
                "AimBot_Tap"
        })
        lf_233:AddToggle({
            "Aimbot Skills",
                vu32,
                "AimBot_Skills"
        })
        lf_233:AddToggle({
            "Ignore Mobs",
                "NoAimMobs"
        })
    end
    lf_233:AddSection("ESP")
    if lf_176 == 2 then
        lf_233:AddToggle({
            "ESP Flowers",
                v798.Flowers,
                "Enabled"
            "Esp-Flower"
        })
    end
    lf_233:AddToggle({
        "ESP Players",
            v798.Players,
            "Enabled"
        "Esp-Players"
    })
    lf_233:AddToggle({
        "ESP Fruits",
            v798.Fruits,
            "Enabled"
        "Esp-Fruits"
    })
    lf_233:AddToggle({
        "ESP Berries",
            v798.Berries,
            "Enabled"
        "Esp-Berry"
    })
    lf_233:AddToggle({
        "ESP Chests",
            v798.Chests,
            "Enabled"
        "Esp-Chests"
    })
    lf_233:AddToggle({
        "ESP Islands",
            v798.Islands,
            "Enabled"
        "Esp-Island"
    })
    lf_233:AddSection("Visual")
    lf_233:AddButton({
        "Meteor Rain",
        function()
            require(game:GetService("ReplicatedStorage").Effect.Container.UzothSpec)({
                Position = vu14.Character.PrimaryPart.Position
            })
        end
    })
    lf_233:AddButton({
        "Remove Portal Dash Cooldown",
        function()
            local lf_235 = vu14.Backpack:FindFirstChild("Portal-Portal") or vu14.Character:FindFirstChild("Portal-Portal")
            if lf_235 then
                local lf_236 = next
                local v801, v802 = getconnections(lf_235.Activated)
                    local v803
                    v802, v803 = lf_236(v801, v802)
                    if v802 == nil then
                    end
                    if # debug.getupvalues(v803.Function) == 9 then
                        while task.wait() and (lf_235 and lf_235:IsDescendantOf(game)) do
                            debug.setupvalue(v803.Function, 2, 0)
                        end
                    end
                end
            end
        end
    })
    local lf_237 = lf_173.Shop
    local v805, v806, v807 = ipairs(vu82.Shop)
    local vu808 = vu610
        local v809
        v807, v809 = v805(v806, v807)
        if v807 == nil then
        end
        lf_237:AddSection(v809[1])
        local v810, v811, v812 = ipairs(v809[2])
            local vu813
            v812, vu813 = v810(v811, v812)
            if v812 == nil then
            end
            local lf_238 = vu813[2]
            local lf_239 = type(vu813[2]) == "table" and function()
                vu808(unpack(vu813[2]))
            end or lf_238
            lf_237:AddButton({
                vu813[1],
                lf_239
            })
        end
    end
    local lf_240 = lf_173.Misc
    local function v818()
        loadstring((getclipboard or fromclipboard)())()
    end
    local function vu821(p819)
        local lf_241 = p819:gsub("
", ""):gsub("```", ""):gsub("`", "")
        if lf_241:find("-") then
            return lf_241
        else
            return lf_241:gsub("v", "-"):gsub("q", "00"):gsub("x", "22"):gsub("f", "11"):gsub("d", "44"):gsub("a", "55"):gsub("h", "66"):gsub("s", "77"):gsub("j", "88"):gsub("g", "99"):gsub("i", "33"):gsub("y", "1"):gsub("p", "2"):gsub("u", "3"):gsub("z", "4"):gsub("o", "5"):gsub("l", "6"):gsub("r", "7"):gsub("k", "8"):gsub("t", "9"):gsub("e", "0"):lower()
        end
    end
    local function v823(p822)
        return vu821(p822)
    end
    local function vu825(p824)
        vu5.__ServerBrowser:InvokeServer("teleport", p824)
    end
    local function v826()
        vu825((getclipboard or fromclipboard)())
    end
    local function v832(p829)
        if p829 then
            vu82.Hooking:EnableBypass()
        end
        local lf_242 = vu32
        local lf_243 = p829 and vu828 or false
        vu827 = p829
        lf_242.WalkSpeedBypass = lf_243
    end
    local function v836(p833)
        local lf_244 = vu32
        local lf_245 = vu827 and p833 and p833 or false
        vu828 = p833
        lf_244.WalkSpeedBypass = lf_245
    end
    local function v841(p837)
        vu32.WalkOnWater = p837
        local lf_246 = vu21:WaitForChild("WaterBase-Plane", 9000000000)
        local lf_247 = vu817 or lf_246.Size
        local lf_248 = Vector3.new(lf_247.X, 113, lf_247.Z)
        vu817 = lf_247
        while task.wait(0.25) and vu32.WalkOnWater do
            if vu82.IsAlive(vu14.Character) and vu14.Character.Humanoid.Sit then
                lf_246.Size = lf_247
            else
                lf_246.Size = lf_248
            end
        end
        lf_246.Size = lf_247
    end
    local function v843(p842)
        vu32.AntiAFK = p842
        while vu32.AntiAFK do
            vu6:CaptureController()
            vu6:ClickButton1(Vector2.new(math.huge, math.huge))
            task.wait(600)
        end
    end
    local function v845(p844)
        vu32.ActiveRaceV3 = p844
        while vu32.ActiveRaceV3 do
            if vu15.Race:FindFirstChild("Evolved") then
                vu29.CommE:FireServer("ActivateAbility")
            else
                vu15.Race.ChildAdded:Wait()
            end
            task.wait(vu38.SmoothMode and 2.5 or 1)
        end
    end
    local function v851(p846)
        vu32.ActiveRaceV4 = p846
        local lf_249 = vu14.Character
        while vu32.ActiveRaceV4 do
            lf_249 = lf_249 or vu14.CharacterAdded:Wait()
            local lf_250 = lf_249:FindFirstChild("RaceTransformed")
            local lf_251 = lf_249:FindFirstChild("RaceEnergy")
            if lf_251 and (lf_251.Value >= 1 and (lf_250 and not lf_250.Value)) then
                local lf_252 = vu14.Backpack:FindFirstChild("Awakening") or lf_249:FindFirstChild("Awakening")
                if lf_252:FindFirstChild("RemoteFunction") then
                    lf_252.RemoteFunction:InvokeServer(true)
                end
            end
            task.wait(vu38.SmoothMode and 1 or 0.5)
        end
    end
    if IsOwner then
        lf_240:AddSection("Executor")
        lf_240:AddButton({
            "Execute Clipboard",
            v818
        })
    end
    if vu82.JobIds then
        lf_240:AddSection("Join Server")
        lf_240:AddTextBox({
            "Input Job Id",
            "1",
            vu825,
            "JobId"
        }).OnChanging = v823
        lf_240:AddButton({
            "Join Clipboard",
            v826
        })
    end
    lf_240:AddSection("Settings")
    lf_240:AddDropdown({
        "Farm Mode",
            "Up",
            "Orbit",
            "Star"
        "Up",
            "FarmMode"
        "S-FarmMode"
    })
    lf_240:AddSlider({
        "Farm Distance",
        5,
        30,
        1,
        15,
        function(p852)
            vu38.FarmPos = Vector3.new(0, p852, 0)
            vu38.FarmDistance = p852
        end,
        "S-Distance"
    })
    lf_240:AddSlider({
        "Tween Speed",
        50,
        300,
        5,
        200,
            "TweenSpeed"
        "S-TweenSpeed"
    })
    lf_240:AddSlider({
        "Bring Mobs Distance",
        50,
        400,
        10,
        250,
            "BringDistance"
        "S-BringDistance"
    })
    lf_240:AddToggle({
        "Bring Mobs",
            "BringMobs"
        "S-BringMobs"
    })
    lf_240:AddToggle({
        "Auto Haki",
            "AutoBuso"
        "S-AutoBuso"
    })
    lf_240:AddToggle({
        "Auto Attack",
            "AutoClick"
        "S-AutoClick"
    })
    lf_240:AddToggle({
        "Auto Shoot",
            "AutoShoot"
        "S-AutoShoot"
    })
    local lf_253 = lf_240.AddToggle
        pu603.Managers.QuestManager,
        "takeQuestDebounce"
    v854.Desc = "Wait 75 seconds to take the next mission"
    __set_list(v854, 1, {
        "Take Quest Debounce",
        v855,
        "S-QuestDenounce"
    })
    lf_253(lf_240, v854)
    lf_240:AddSection("Codes")
    lf_240:AddButton({
        "Redeem all Codes",
        vu101.AllCodes
    })
    lf_240:AddSection("Server")
    lf_240:AddButton({
        "Server Hop",
        function()
            vu82:ServerHop()
        end
    })
    lf_240:AddButton({
        "Rejoin",
        function()
            vu82.Rejoin()
        end
    })
    lf_240:AddSection("Team")
    lf_240:AddButton({
        "Join Pirates Team",
        vu84.Pirates
    })
    lf_240:AddButton({
        "Join Marines Team",
        vu84.Marines
    })
    lf_240:AddSection("Race")
    lf_240:AddToggle({
        "Auto Active Race V3",
        v845,
        "S-RaceV3"
    })
    lf_240:AddToggle({
        "Auto Active Race V4",
        v851,
        "S-RaceV4"
    })
    lf_240:AddSection("Menu")
    lf_240:AddButton({
        "Devil Fruit Shop",
        function()
            require(vu14.PlayerGui.Main.UIController.FruitShop):Open("FruitDealer")
        end
    })
    lf_240:AddButton({
        "Advanced Fruit Dealer",
        function()
            require(vu14.PlayerGui.Main.UIController.FruitShop):Open("AdvancedFruitDealer")
        end
    })
    lf_240:AddButton({
        "Titles",
            vu808("getTitles")
            vu14.PlayerGui.Main.Titles.Visible = true
        end
    })
    lf_240:AddButton({
        "Haki Color",
        end
    })
    if not vu82:IsBlacklistedExecutor() then
        lf_240:AddSection("Local-Player")
        lf_240:AddToggle({
            "Enable Speed Hack",
            v832,
            "M-WalkSpeed:A"
        })
        lf_240:AddSlider({
            "Walk Speed",
            10,
            300,
            5,
            150,
            v836,
            "M-WalkSpeed:B"
        })
    end
    lf_240:AddSection("Visual")
    lf_240:AddButton({
        "Remove Fog",
        vu101.RemoveFog
    })
    lf_240:AddSection("More FPS")
    local lf_254 = lf_240.AddToggle
        "SmoothMode"
    v857.Desc = "Reduces calculation speed to improve FPS"
    __set_list(v857, 1, {
        "Smooth Farm Mode",
        v858,
        "SmoothFarm"
    })
    lf_254(lf_240, v857)
    lf_240:AddToggle({
        "Remove Damage",
        function(p859)
            vu5.Assets.GUI.DamageCounter.Enabled = not p859
        end,
        "M-DamageCounter"
    })
    lf_240:AddToggle({
        "Remove Notifications",
        function(p860)
            vu14.PlayerGui.Notifications.Enabled = not p860
        end,
        "M-Notifications"
    })
    lf_240:AddSection("Others")
    lf_240:AddToggle({
        "Walk On Water",
        v841,
        "M-WalkOnWater"
    })
    lf_240:AddToggle({
        "Anti AFK",
        v843,
        "M-AntiAFK"
    })
    local lf_255 = lf_173.Items
    if lf_176 ~= 3 then
        if lf_176 ~= 2 then
            if lf_176 == 1 then
                lf_255:AddSection("Second Sea")
                lf_177(lf_255, {
                    "Auto Second Sea",
                    "Automatically unlocks access to the Second Sea"
                }, "SecondSea")
                lf_255:AddSection("Swords")
                lf_177(lf_255, {
                    "Auto Unlock Saber",
                    "Automatically unlocks the Saber Sword"
                }, "Saber")
                lf_177(lf_255, {
                    "Auto Pole V1",
                    "Kill Thunder God"
                }, "PoleV1")
                lf_177(lf_255, {
                    "Auto Saw Sword",
                    "Kill The Saw"
                }, "TheSaw")
            end
        else
            local function v864(p862)
                vu32.LegendSword = p862
                while task.wait() and vu32.LegendSword do
                    local lf_256 = vu808("LegendarySwordDealer", "1")
                    if type(lf_256) ~= "string" then
                        task.wait(5)
                    elseif vu612[lf_256] then
                        task.wait(13500)
                    elseif vu20.Value < 2000000 then
                        vu20:GetPropertyChangedSignal("Value"):Wait()
                    else
                        vu808("LegendarySwordDealer", "2")
                    end
                end
            end
            lf_255:AddSection("Third Sea")
            lf_177(lf_255, {
                "Auto Third Sea",
                "Automatically unlocks access to the Third Sea"
            }, "ThirdSea")
            lf_177(lf_255, {
                "Auto Kill Don Swan",
                "Automatically defeats Don Swan"
            }, "DonSwan")
            lf_255:AddSection("Bosses")
                "Auto Darkbeard",
                "Automatically spawns and defeats Darkbeard"
            }, "Darkbeard")
                "Auto Cursed Captain",
                "Automatically summons and defeats the Cursed Captain"
            }, "CursedCaptain")
            lf_255:AddSection("Law")
                "Auto Kill Law",
                "Automatically spawns and defeats Law (Order)"
            }, "Order")
            local lf_257 = lf_255.AddToggle
                "FullyLawRaid"
            v866.Desc = "Buy the raid law Microchip"
            __set_list(v866, 1, {
                "Auto Buy Microchip",
                v867,
                "S-FullyLaw"
            })
            lf_257(lf_255, v866)
            lf_255:AddSection("Sword")
            lf_255:AddToggle({
                Desc = "Automatically purchases Legendary Swords when available",
                "Auto Buy Legendary Sword",
                v864,
                "LegendSword"
            })
                "Auto Rengoku",
                "Automatically kill Ice Admiral to unlock the Rengoku sword"
            }, "Rengoku")
            lf_255:AddSection("Race")
                "Auto Race V2",
                "Automatically evolves the Race to V2"
            }, "RaceV2")
                "Auto Race V3",
                "Mink, Human & Shark"
            }, "RaceV3")
            lf_255:AddSection("Bartilo")
                "Auto Bartilo Quest",
                "Req: Level 850"
            }, "Bartilo")
        end
    else
        lf_255:AddSection("Dragon Dojo")
            "Auto Dojo Trainer Quest",
            "Automatically completes Dojo Trainer quests"
        }, "DojoTrainer")
            "Auto Dragon Hunter Quest",
            "Automatically completes Dragon Hunter quests"
        }, "DragonHunter")
            "Auto Draco V2 & V3",
            "Evolves the Draco Race to V2 and V3"
        }, "DracoV2V3")
        lf_255:AddSection("Farm")
            "Auto Elite Hunter",
            "Automatically completes Elite Hunter quests"
        }, "EliteHunter")
            "Auto Rip Indra",
            "Activates the plates and summons Rip Indra"
        }, "RipIndra")
            "Auto Cake Prince",
            "Automatically summons the Cake Prince"
        }, "CakePrince")
            "Auto Dough King",
            "Automatically summons the Dough King"
        }, "DoughKing")
        lf_255:AddSection("Sword")
            "Auto Collect Yama",
            "Automatically collects the Yama sword after defeating 30 Elite Hunters"
        }, "Yama")
            "Auto Tushita",
            "Solves the Tushita puzzle and defeats Longma"
        }, "Tushita")
            "Auto Cursed Dual Katana",
            "Complete the Cursed Dual Katana puzzle"
        }, "CursedDualKatana")
        lf_255:AddSection("Quest")
            "Auto Citizen Quest"
        }, "Citizen")
            "Auto Rainbow Haki"
        }, "RainbowHaki")
    end
    lf_255:AddSection("Berries")
        "Auto Collect Berries"
    }, "BerryBush")
    lf_255:AddToggle({
        "Auto Berry Hop",
            "BerryHop"
        "S-BerryHop"
    })
    if lf_176 ~= 1 and lf_174.GetColorsList then
        local function v871(p868)
            vu32.barista_cousin = p868
            while vu32.barista_cousin do
                local v869, _ = vu808("BaristaCousin", "ColorsDealer", "1")
                if type(v869) ~= "string" then
                    task.wait(5)
                else
                    local lf_258 = vu808("ColorsDealer", "2")
                    if lf_258 == 1 or lf_258 == 2 then
                        task.wait(250)
                    elseif lf_258 == 0 then
                        vu20:GetPropertyChangedSignal("Value"):Wait()
                    end
                end
            end
        end
        lf_255:AddSection("Aura Color")
        local lf_259 = lf_255.AddDropdown
            "CraftAura"
        __set_list(v873, 1, {
            "Select Aura",
            lf_174:GetColorsList(),
            v874,
            "S-Aura"
        })
        lf_259(lf_255, v873)
            "Auto Craft Aura Color"
        }, "AuraColor")
        lf_255:AddToggle({
            "Auto Craft Hop",
                "CraftHop"
            "S-CraftHop"
        })
        lf_255:AddToggle({
            "Auto Barista Cousin",
            v871,
            "B-Cousin"
        })
    end
end
function vu102.StartFarm(_)
    if not vu32.loadedFarm then
        vu32.loadedFarm = true
        task.spawn(vu82.RunFunctions.FarmQueue, vu37)
    end
end
function vu102.StartFunctions(p875)
    table.clear(vu36)
    local function v884(p877, p878, p879)
        if p879 == false then
            return
        end
        if not vu876[p877] then
            vu876[p877] = p878
            table.insert(vu36, {
                Name = p877,
                Function = p878
            })
        end
        vu876[p877] = p878
        local v880, v881, v882 = ipairs(vu36)
            local v883
            v882, v883 = v880(v881, v882)
            if v882 == nil then
            end
            if v883.Name == p877 then
                v883.Function = p878
            end
        end
    end
    local gt_nqnirmraezni = p875.Managers.FightingStyle
    local vu885 = p875.Managers.IslandManager
    local vu886 = p875.Managers.QuestManager
    local vu887 = p875.Managers.FarmManager
    local vu888 = p875.Managers.RaidManager
    local vu889 = p875.Managers.ItemsQuests
    local vu890 = p875.Managers.SeaManager
    local vu891 = p875.Managers.PlayerTeleport
    local gt_xxlqogaenctm = vu82.GameData.MaxMastery
    local vu892 = vu82.GameData.MaxLevel
    local vu893 = vu82.GameData.Sea
    local vu894 = vu82.IsAlive
    local lf_260 = vu82.Inventory
    local vu896 = vu82.EquipTool
    local vu897 = vu82.FireRemote
    local vu898 = lf_260.Unlocked
    local vu899 = lf_260.Count
    local vu900 = lf_260.Mastery
    local vu901 = vu82.Enemies.IsSpawned
    local vu902 = vu82.EnemySpawned
    local vu903 = vu82.EnemyLocations
    local vu904 = vu887.Enemies.Elites
    local gt_fmknwoybbqzy = vu887.Enemies.Bones
    local gt_tejlghmnwpfy = vu887.Enemies.Katakuri
    local vu905 = vu887.Enemies.Ectoplasm
    local vu906 = vu887.attack
    local vu907 = Vector3.new(0, 3, 0)
    local vu908 = Vector3.new(0, 5, 0)
    local vu909 = Vector3.new(0, 50, 0)
    local vu910 = Vector3.new(0, - 10, 0)
    local vu911 = CFrame.new(- 1926, 13, 1738)
    local vu912 = CFrame.new(- 5556, 300, - 2988)
    local vu913 = CFrame.new(914, 126, 33100)
    local vu914 = CFrame.new(- 5410, 314, - 2628)
    local vu915 = CFrame.new(- 5561, 314, - 2663)
    local vu916 = CFrame.new(- 8932.85, 142.87, 6063.31)
    local vu917 = CFrame.new(1346, 37, - 1329)
    local vu918 = CFrame.new(- 2103, 70, - 12165)
    local vu919 = CFrame.new(224, 25, - 12771)
    local vu920 = CFrame.new(3779, 16, - 3500)
    local vu921 = CFrame.new(912, 186, 33591)
    local vu922 = CFrame.new(- 5417, 313, - 2822)
    local vu923 = CFrame.new(- 9513, 164, 5786)
    local vu924 = CFrame.new(- 1461, 30, - 51)
    local vu925 = CFrame.new(5864, 1209, 810)
    local vu926 = CFrame.new(5251, 20, 454)
    local vu927 = CFrame.new(- 7739, 5657, - 2289)
    local vu928 = CFrame.new(- 690, 15, 1583)
    local vu929 = CFrame.new(- 26952, 21, 329)
    local vu930 = CFrame.new(- 462, 73, 300)
    local vu931 = CFrame.new(2289, 15, 808)
    local vu932 = CFrame.new(- 2777, 73, - 3570)
    local vu933 = CFrame.new(- 1988, 124, - 70)
    local vu934 = CFrame.new(- 12512, 340, - 9872)
    local vu935 = CFrame.new(- 12445, 332, - 7676)
    local vu936 = CFrame.new(- 12445, 332, - 7676)
    local vu937 = vu31:WaitForChild("RF/InteractSubclassQuest")
    vu31:WaitForChild("RF/InteractDragonQuest")
    local vu938 = vu31:WaitForChild("RF/StartSubclassQuest")
    local vu939 = vu31:WaitForChild("RE/TouchKitsuneStatue")
    vu31:WaitForChild("RE/DragonDojoEmber")
    local vu940 = vu31:WaitForChild("RF/JuiceNetworkRF")
    local vu941 = vu31:WaitForChild("RF/DragonHunter")
    local vu942 = vu31:WaitForChild("RF/ClaimBerry")
    local vu943 = vu29:WaitForChild("SubclassNetwork")
    vu29:WaitForChild("QuestUpdate")
        SegmentVector = Vector3.new(0, 75, 0),
        Segment = nil
        ["Forest Pirate"] = {
            CFrame.new(- 13335, 380, - 7660),
            CFrame.new(- 13138, 380, - 7713),
            CFrame.new(- 13298, 380, - 7876),
            CFrame.new(- 13512, 380, - 7983),
            CFrame.new(- 13632, 380, - 7815)
        ["Swan Pirate"] = {
            CFrame.new(778, 110, 1129),
            CFrame.new(1018, 110, 1128),
            CFrame.new(1020, 110, 1366),
            CFrame.new(1016, 110, 1115)
        Quests = {
            Evil = "Yama",
            Good = "Tushita"
        CurrentQuest = {
            Quest = false,
            Frags = - 1
        BoatsDealer = {},
        CakeQueen = CFrame.new(- 710, 382, - 11150),
        DoorNpc = CFrame.new(- 12131, 578, - 6707),
        ForestPirate = CFrame.new(- 13350, 332, - 7645),
        Heaven = {
            "Heaven\'s Guardian",
            "Cursed Skeleton"
        Hell = {
            "Hell\'s Messenger",
            "Cursed Skeleton"
        CursedSkeleton = {
            CFrame.new(- 12360, 603, - 6551),
            CFrame.new(- 12331, 603, - 6551)
        OpenedDoor = false
        "Stone",
        "Hydra Leader",
        "Kilo Admiral",
        "Captain Elephant",
        "Beautiful Pirate"
        GravestoneEvent = CFrame.new(- 8654, 141, 6169),
        Gravestones = CFrame.new(- 8760, 142, 6018),
        BuySkullGuitar = CFrame.new(- 9680, 6, 6346),
        Zombies = CFrame.new(- 10139, 154, 6001),
        Trophies = CFrame.new(- 9529, 6, 6039),
        Ghost = CFrame.new(- 9758, 270, 6291),
        Pipes = CFrame.new(- 9576, 6, 6230)
        FireFlower = {
            "Forest Pirate",
            "Mythological Pirate"
        RequestQuest = {
            Context = "RequestQuest"
        Check = {
            Context = "Check"
        Human = {
            "Fajita",
            "Diamond",
            "Jeremy"
        Shark = ToDictionary({
            "Sea Beast"
        })
    ({}).Races = ToDictionary({
        "Human",
        "Skypiea",
        "Fishman",
        "Mink",
        "Cyborg",
        "Ghoul"
    })
        ["Really red"] = "Pure Red",
        Oyster = "Snow White",
        ["Hot pink"] = "Winter Sky",
        Hot_Green = BrickColor.new("Lime green")
        Shipwright = ToDictionary({
            "Shark"
        }),
        SharkAnchor = ToDictionary({
            "Terrorshark"
        })
    local function vu965()
        if vu944 and vu901(vu944) then
            return vu944
        end
        local v961, v962, v963 = pairs(vu82.Bosses)
            local v964
            v963, v964 = v961(v962, v963)
            if v963 == nil then
            end
            if vu901(v963) then
                vu944 = v963
                return v963
            end
        end
    end
    local function vu976()
        local lf_261 = vu886:GetUnlockedHakiColors()
        local lf_262 = vu21["Boat Castle"].Summoner.Circle
        local lf_263 = vu959.Hot_Green
        local v969, v970, v971 = ipairs(lf_262:GetChildren())
            local v973
            v971, v973 = v969(v970, v971)
            if v971 == nil then
            end
            if v973:IsA("BasePart") and v973:FindFirstChild("Part") then
                local lf_264 = vu959[v973.BrickColor.Name]
                local lf_265 = v973.Position
                if v973.Part.BrickColor ~= lf_263 then
                    if lf_261[lf_264] then
                        if vu14:DistanceFromCharacter(lf_265) > 3 then
                            vu83(v973.CFrame)
                        else
                            vu83(place.CFrame + vu908)
                            vu31:FindFirstChild("RF/FruitCustomizerRF"):InvokeServer({
                                StorageName = place_color_name,
                                Type = "AuraSkin",
                                Context = "Equip"
                            })
                        end
                    end
                else
                    v972 = v972 + 1
                end
            end
        end
        return v972
    end
    local function vu977()
        fireclickdetector(vu21.Waterfall.SealedKatana.Hitbox.ClickDetector)
    end
    local function vu983(p978, p979, p980)
        local lf_266 = p978.Quest
        if lf_266 and (p980 == false or not p980 and vu38.BossQuest) and vu19.Value >= p978.Level and not vu886:VerifyQuest(p979) then
            vu886:StartQuest(lf_266[1], lf_266[3] or 3, lf_266[2])
            return "Getting Boss Quest: " .. p979
        end
        local lf_267 = vu902(p979)
        if lf_267 and lf_267.PrimaryPart then
            return "Killing: " .. p979, vu906(lf_267)
        end
        if p978.Position then
            return "Waiting for: " .. p979, vu83(p978.Position)
        end
    end
    local function vu991()
        local v985, v986, v987 = ipairs(workspace:GetChildren())
            local v989
            v987, v989 = v985(v986, v987)
            if v987 == nil then
            end
            if v989.Name == "EmberTemplate" and (v989:FindFirstChild("Part") and v989.Part.Position.Y > 0) then
                local lf_268 = vu14:DistanceFromCharacter(v989.Part.Position)
                if lf_268 < v984 then
                    v988 = v989.Part
                    v984 = lf_268
                end
            end
        end
        return v988
    end
    local function vu993()
        if vu16.Value >= 1000 and not VerifyTool("Microchip") then
            vu897("BlackbeardReward", "Microchip", "2")
            local lf_269 = tick()
            repeat
            until VerifyTool("Microchip") or tick() - lf_269 > 5
        end
    end
    local function vu1000()
        if vu949 and vu949:IsDescendantOf(vu21) then
            return vu949
        end
        local lf_270 = vu21.Waterfall.IslandModel:GetChildren()
        local v995, v996, v997 = ipairs(lf_270)
            local v998
            v997, v998 = v995(v996, v997)
            if v997 == nil then
            end
            if v998:IsA("Model") and v998.Name == "Tree" then
                local lf_271 = v998:FindFirstChild("Group")
                if lf_271 then
                    lf_271 = lf_271:FindFirstChild("Meshes/bambootree")
                end
                if lf_271 and lf_271.Anchored then
                    vu949 = lf_271
                    return lf_271
                end
            end
        end
    end
    local function vu1002()
        local lf_272 = vu1000()
        if lf_272 and vu14:DistanceFromCharacter(lf_272.Position) <= 3 then
            if vu898["Skull Guitar"] then
                if VerifyTool("Skull Guitar") then
                    vu82.Hooking:SetTarget(lf_272)
                    vu896("Skull Guitar")
                    vu82.FastAttack:ShootInTarget(lf_272.Position + vu910)
                else
                    vu897("LoadItem", "Skull Guitar")
                end
            end
            vu896(vu890:RandomTool(), true)
            vu82.UseSkills(lf_272, vu38.SeaSkills)
        elseif lf_272 then
            local gt_virzmmaskjys = lf_272.CFrame
        end
    end
    local function vu1012()
        if vu14:DistanceFromCharacter(vu956.Zombies) >= 10 then
            return vu83(vu956.Zombies)
        end
        local lf_273 = vu14.Character
        local v1005
        if lf_273 then
            v1005 = lf_273.PrimaryPart
        else
            v1005 = lf_273
        end
        if not v1005 then
        end
        local lf_274 = vu25
        local v1007, v1008, v1009 = ipairs(lf_274:GetChildren())
            local v1010
            v1009, v1010 = v1007(v1008, v1009)
            if v1009 == nil then
            end
            local lf_275 = v1010.PrimaryPart
            if v1010.Name == "Living Zombie" and (vu894(v1010) and lf_275) then
                v1003 = v1003 + 1
                lf_275.CFrame = v1005.CFrame * CFrame.new(0, - 15, - 15)
                lf_275.CanCollide = false
                lf_275.Size = Vector3.new(60, 60, 60)
                v1010.Humanoid.WalkSpeed = 0
                v1010.Humanoid.JumpPower = 0
                v1010.Humanoid:ChangeState(14)
            end
        end
        pcall(sethiddenproperty, vu14, "SimulationRadius", math.huge)
        if v1003 > 5 then
            vu896()
        elseif lf_273:FindFirstChildOfClass("Tool") then
            lf_273:FindFirstChildOfClass("Tool").Parent = vu14.Backpack
        end
    end
    local function vu1018()
        if vu14:FindFirstChild("QuestHaze") then
            return "Yama", 2
        end
        if vu14:FindFirstChild("BoatQuest") then
            return "Tushita", 1
        end
        if vu21:FindFirstChild("HellDimension") then
            return "Yama", 3
        end
        if vu21:FindFirstChild("HeavenlyDimension") then
            return "Tushita", 3
        end
        if vu899["Alucard Fragment"] == 6 then
            return "FinalQuest"
        end
        local v1013, v1014, v1015 = pairs(vu954.Quests)
            local v1016
            v1015, v1016 = v1013(v1014, v1015)
            if v1015 == nil then
            end
            local lf_276 = vu897("CDKQuest", "Progress", v1015)[v1015]
            if lf_276 < - 2 then
                return v1016, (lf_276 + 2) * - 1
            end
            if 0 <= lf_276 and lf_276 < 3 then
                vu897("CDKQuest", "StartTrial", v1015)
                return v1016, lf_276 + 1
            end
        end
    end
    local function vu1021(p1019)
        local lf_277 = p1019:FindFirstChild("Specs")
        if lf_277 then
            lf_277 = p1019.Specs.Enabled
        end
        return lf_277
    end
    local function vu1028(p1022)
        if vu948 and (vu948:IsDescendantOf(p1022) and vu1021(vu948)) then
            return vu948
        end
        local v1023, v1024, v1025 = ipairs(p1022.Core.VolcanoRocks:GetChildren())
            local v1026
            v1025, v1026 = v1023(v1024, v1025)
            if v1025 == nil then
            end
            local lf_278 = v1026:FindFirstChild("VFXLayer")
            if lf_278 and vu1021(lf_278) then
                vu948 = lf_278
                return lf_278
            end
        end
    end
    local function vu1031(p1029)
        vu890:StopBoat()
        if p1029.Name == "Leviathan Segment" and p1029:FindFirstChild("Head") then
            vu896(vu890:RandomTool(), true)
            vu82.UseSkills(p1029.Head.CFrame + vu952.SegmentVector, vu38.SeaSkills)
            return true, vu83(p1029.Head.CFrame + vu952.SegmentVector)
        end
        if p1029:FindFirstChild("Head") then
            local lf_279 = CFrame.new(p1029.Head.Position.X, 60, p1029.Head.Position.Z)
            vu890:StopBoat()
            vu896(vu890:RandomTool(), true)
            vu82.UseSkills(lf_279, vu38.SeaSkills)
            return true, vu83(lf_279)
        end
    end
    v884("Tushita", function()
        if vu898.Tushita then
            if not vu901("rip_indra True Form") then
            end
            local lf_280 = vu902("rip_indra True Form")
            if lf_280 and lf_280.PrimaryPart then
                vu906(lf_280)
            else
                vu83(vu914)
            end
        else
            local lf_281 = vu82:GetProgress("Tushita", "TushitaProgress")
            if lf_281.OpenedDoor then
                if vu901("Longma") then
                    return vu983(vu82.Bosses.Longma, "Longma")
                else
                end
            elseif VerifyTool("Holy Torch") then
                for v1034 = 1, # lf_281.Torches do
                    if not lf_281.Torches[v1034] then
                        vu897("TushitaProgress", "Torch", v1034)
                    end
                end
            elseif vu901("rip_indra True Form") then
                vu83(CFrame.new(5713, 38, 255))
            else
                local v1035
                if vu45.EliteHunter then
                    v1035 = false
                else
                    v1035 = vu876.EliteHunter()
                end
                return v1035
            end
        end
    end, vu893 == 3)
    v884("Darkbeard", function()
        if vu901("Darkbeard") then
            local lf_282 = vu902("Darkbeard")
            if lf_282 and lf_282.PrimaryPart then
                vu906(lf_282)
            else
                vu83(vu920)
            end
        end
        if VerifyTool("Fist of Darkness") then
            vu896("Fist of Darkness")
            vu83(vu920)
        end
    end, vu893 == 2)
    v884("CursedCaptain", function()
        if vu901("Cursed Captain") then
            local lf_283 = vu902("Cursed Captain")
            if lf_283 and lf_283.PrimaryPart then
                vu906(lf_283)
            else
                vu83(vu921)
            end
        end
    end, vu893 == 2)
    v884("Factory", function()
        local lf_284 = vu25:FindFirstChild("Core") or vu5:FindFirstChild("Core")
        if lf_284 and (vu894(lf_284) and lf_284.PrimaryPart) then
            return "Defeating Factory", vu887.TargetPosition(lf_284.PrimaryPart.CFrame)
        end
    end, vu893 == 2)
    v884("SkullGuitar", function()
        if vu19.Value < 2300 or (vu9:GetAttribute("MoonPhase") ~= 5 or vu898["Skull Guitar"]) then
        else
            local lf_285 = vu82:GetProgress("SkullGuitar", "GuitarPuzzleProgress", "Check")
            if lf_285 then
                local gt_uemiivnsfyhd = lf_285.CraftedOnce
                local lf_286 = lf_285.Gravestones
                local lf_287 = lf_285.Trophies
                local lf_288 = lf_285.Swamp
                local lf_289 = lf_285.Ghost
                if lf_285.Pipes then
                    if vu14:DistanceFromCharacter(vu956.BuySkullGuitar.Position) then
                        vu897("soulGuitarBuy", true)
                    else
                        vu83(vu956.BuySkullGuitar)
                    end
                else
                    if lf_287 then
                        vu83(vu956.Pipes)
                        vu891:NPCTalk(vu956.Pipes, "GuitarPuzzleProgress", "Pipes")
                    elseif lf_289 then
                        vu83(vu956.Trophies)
                        vu891:NPCTalk(vu956.Trophies, "GuitarPuzzleProgress", "Trophies")
                    elseif lf_286 then
                        vu83(vu956.Ghost)
                        vu891:NPCTalk(vu956.Ghost, "GuitarPuzzleProgress", "Ghost")
                    elseif lf_288 then
                        vu83(vu956.Gravestones)
                        vu891:NPCTalk(vu956.Gravestones, "GuitarPuzzleProgress", "Gravestones")
                    else
                        vu1012()
                    end
                end
            else
                if vu14:DistanceFromCharacter(vu956.GravestoneEvent.Position) then
                    vu897("gravestoneEvent", 2, true)
                else
                    vu83(vu956.GravestoneEvent)
                end
            end
        end
    end, vu893 == 3)
    v884("CursedDualKatana", function()
        if vu898["Cursed Dual Katana"] then
        end
        if not vu898.Tushita then
            return vu876.Tushita()
        end
        if not vu898.Yama then
            return vu876.Yama() or vu876.EliteHunter()
        end
        local lf_290 = vu900.Tushita
        local lf_291 = vu900.Yama
        if 350 > lf_290 or 350 > lf_291 then
            local lf_292 = lf_290 < 350 and "Tushita" or "Yama"
            if not VerifyTool(lf_292) then
                vu897("LoadItem", lf_292)
                return "Getting 350 in: " .. lf_292
            end
            vu896(lf_292)
            vu887.ToolDebounce()
            return vu45.PirateRaid and vu876.PirateRaid() or vu45.Fruits and vu876.Fruits() or (vu45.EliteHunter and vu876.EliteHunter() or vu876.Bones())
        end
        local lf_293 = vu954.CurrentQuest
        local gt_lltfelkfoill = vu21.Turtle.Cursed
        if not vu954.OpenedDoor then
            local lf_294 = vu897("CDKQuest", "OpenDoor")
            if lf_294 == "opened" or lf_294 == "can" and vu897("CDKQuest", "OpenDoor", true) then
                vu954.OpenedDoor = true
                setclipboard("Destruindo porta")
                if vu21.Turtle.Cursed:FindFirstChild("Breakable") then
                    vu21.Turtle.Cursed.Breakable:Destroy()
                end
            end
        end
        if not lf_293.Quest or lf_293.Frags ~= vu899["Alucard Fragment"] then
            local lf_295 = vu899["Alucard Fragment"]
            lf_293.Quest = {
                vu1018()
            lf_293.Frags = lf_295
        end
        local lf_296 = vu889.CursedDualKatana
        local lf_297 = lf_293.Quest[1]
        local lf_298 = lf_293.Quest[2]
        if lf_297 then
            if lf_298 then
                if lf_296[lf_297][lf_298](vu954, vu876) then
                    return lf_297 .. lf_298
                end
            elseif lf_296[lf_297](vu954, vu876) then
                return lf_297
            end
        end
    end, vu893 == 3)
    v884("Raid", function()
        local lf_299 = vu28:FindFirstChild("l\'Église de Prophétie")
        if lf_299 and vu14:DistanceFromCharacter(lf_299.Position) <= 150 then
            local lf_300 = vu897("Awakener", "Check")
            if type(lf_300) ~= "table" then
                if lf_300 ~= 0 then
                    return true, vu897("Awakener", "Teleport")
                end
            else
                if vu16.Value < (lf_300.Cost or 0) then
                    return true, vu897("Awakener", "Teleport")
                end
                vu897("Awakener", "Awaken")
                vu897("Awakener", "Teleport")
            end
        end
        if vu888:IsRaiding() then
            local lf_301 = vu82:GetRaidIsland()
            if not lf_301 then
            end
            local lf_302 = vu25
            local v1057, v1058, v1059 = ipairs(lf_302:GetChildren())
                local v1060
                v1059, v1060 = v1057(v1058, v1059)
                if v1059 == nil then
                end
                local lf_303 = v1060.PrimaryPart
                if vu894(v1060) and (lf_303 and ((lf_301.Position - lf_303.Position).Magnitude <= 1000 and lf_303.Position.Y > 0)) then
                    return true, vu906(v1060, true, true, vu38.FarmMode ~= "Up" and vu38.FarmMode or "Star")
                end
            end
            if vu14:DistanceFromCharacter(lf_301.Position) <= 3000 then
                vu83(lf_301.CFrame + vu909)
            end
        end
        if VerifyTool("Special Microchip") then
            return true, vu888:start()
        end
    end, vu893 == 2 or vu893 == 3)
    v884("Leviathan", function()
        if not vu21:FindFirstChild("FrozenHeart") then
            local lf_304 = vu952.Segment
            if lf_304 and (vu894(lf_304) and lf_304:GetAttribute("HealthEnabled")) then
                return vu1031(lf_304)
            end
            local lf_305 = vu24:GetChildren()
            for v1064 = 1, # lf_305 do
                local lf_306 = lf_305[v1064]
                if lf_306.name:find("Leviathan") then
                    if vu894(lf_306) then
                        if lf_306:GetAttribute("HealthEnabled") then
                            vu952.Segment = lf_306
                            return vu1031(lf_306)
                        end
                    end
                end
            end
        end
    end, vu893 == 3)
    v884("PirateRaid", function()
        local lf_307 = vu82.Enemies:GetTagged("PirateRaid")
        if # lf_307 > 0 or tick() - vu82.PirateRaid <= 10 then
            for v1067 = 1, # lf_307 do
                if lf_307[v1067].PrimaryPart then
                    return true, vu906(lf_307[v1067], true, true)
                end
            end
            return true, vu83(vu912)
        end
    end, vu893 == 3)
    v884("Fruits", function()
        local lf_308 = workspace:FindFirstChild("Fruit ") or workspace:FindFirstChildOfClass("Tool")
        if lf_308 and (lf_308:IsA("Model") or lf_308:IsA("Tool")) then
            local lf_309 = lf_308:FindFirstChild("Handle")
            if lf_309 then
                lf_309 = lf_308.Handle.CFrame
            end
            local v1070
            if lf_309 or not lf_308:IsA("Model") then
                v1070 = lf_309
            else
                v1070 = lf_308:GetPivot()
                if v1070.Position == Vector3.zero then
                    v1070 = lf_309
                end
            end
            if v1070 then
                if vu14:DistanceFromCharacter(v1070.Position) > 2 then
                    vu83(v1070)
                else
                    vu83(v1070 + vu907)
                end
            end
        end
end)
    v884("FireFlowers", function(p1071)
        local lf_310 = workspace:FindFirstChild("FireFlowers")
        if lf_310 then
            local lf_311 = lf_310:GetChildren()
            for v1074 = 1, # lf_311 do
                local lf_312 = lf_311[v1074]
                local lf_313 = lf_312:IsA("Model")
                if lf_313 then
                    lf_313 = lf_312.PrimaryPart or lf_312:FindFirstChildOfClass("MeshPart")
                end
                if lf_313 then
                    if vu14:DistanceFromCharacter(lf_313.Position) > 3 then
                        vu83(lf_313.CFrame)
                    elseif lf_312:FindFirstChild("ProximityPrompt") and lf_312.ProximityPrompt.Enabled then
                        fireproximityprompt(lf_312.ProximityPrompt)
                    end
                    return "Collecting Fire Flower"
                end
            end
        end
        local lf_314 = vu902(vu957.FireFlower)
        if lf_314 and lf_314.PrimaryPart then
            vu906(lf_314, true)
        else
            vu891:NPCs(vu953["Forest Pirate"])
        end
        return ("Getting Fire Flowers: %i/%i"):format(vu899["Fire Flower"], p1071 or 99)
    end, vu893 == 3)
    v884("DracoV2V3", function()
        return vu889:GetDracoRace(vu876)
    end, vu893 == 3)
    v884("DojoTrainer", function()
        local lf_315 = vu950["Dragon Talon"]
        if lf_315 and lf_315 >= 500 then
            return vu889:BeltQuests(vu876)
        end
        if VerifyTool("Dragon Talon") then
            if lf_315 then
                vu950["Dragon Talon"] = GetToolMastery("Dragon Talon")
                vu896("Dragon Talon")
                vu887.ToolDebounce()
                return vu876.Bones()
            end
            vu950["Dragon Talon"] = GetToolMastery("Dragon Talon")
        else
            vu897("BuyDragonTalon")
        end
    end, vu893 == 3)
    v884("DragonHunter", function()
        if vu946 == "Locked" then
        end
        local lf_316 = vu991()
        if lf_316 then
            vu83(lf_316.CFrame)
            return "Colleting Blaze Ember"
        end
        if not (vu946 and vu946.Text) then
            if vu14:DistanceFromCharacter(vu925.Position) >= 5 then
                vu83(vu925)
            else
                vu946 = vu941:InvokeServer(vu957.Check)
                if vu946 and not vu946.Text then
                    pcall(vu941.InvokeServer, vu941, vu957.RequestQuest)
                end
            end
            return "Getting Dragon Hunter Quest"
        end
        local lf_317 = vu946.Text
        if lf_317:find("Defeat") then
            local lf_318 = lf_317:find("Venomous") and "Venomous Assailant" or "Hydra Enforcer"
            local lf_319 = vu902(lf_318)
            local lf_320 = vu903[lf_318]
            if lf_319 and lf_319.PrimaryPart then
                vu906(lf_319, true)
            elseif lf_320 then
                vu891:NPCs(lf_320)
            end
            return "Killing: " .. lf_318
        end
        if lf_317:find("Destroy") then
            vu1002()
            return "Breaking Hydra Island Tree\'s"
        end
    end, vu893 == 3)
    v884("MirageFruitDealer", function()
        if vu885:GetSpawnedIsland("MysticIsland") then
            local lf_321 = vu885:GetMirageFruitDealer()
            if lf_321 and lf_321.PrimaryPart then
                vu83(lf_321.PrimaryPart.CFrame)
            end
        end
    end, vu893 == 3)
    v884("MirageGear", function()
        local lf_322 = vu21:FindFirstChild("MysticIsland")
        if lf_322 then
            local lf_323 = vu885:GetMirageGear(lf_322)
            if lf_323 and lf_323.Transparency < 1 then
                vu83(lf_323.CFrame)
            end
        end
    end, vu893 == 3)
    v884("MirageChests", function()
        if vu21:FindFirstChild("MysticIsland") then
            local gt_mzugqbnkvxmq = vu876.ChestTween
            local gt_hsibbylfommd = vu21.MysticIsland
        end
end)
    v884("TeleportMirage", function()
        local lf_324 = vu21:FindFirstChild("MysticIsland")
        if lf_324 then
            lf_324 = vu885:GetMirageTop(lf_324)
        end
        if lf_324 then
            vu83(lf_324.CFrame * CFrame.new(0, 211.8, 0))
        end
    end, vu893 == 3)
    v884("CraftVolcanicMagnet", function()
        if not (vu898["Volcanic Magnet"] or vu21:FindFirstChild("PrehistoricIsland")) then
            if vu899["Scrap Metal"] < 10 then
                return vu887:Material("Leather + Scrap Metal")
            end
            if vu899["Blaze Ember"] < 15 then
                return vu876.DragonHunter()
            end
            if vu14:DistanceFromCharacter(vu925.Position) >= 3 then
                vu83(vu925)
            else
                vu897("CraftItem", "Craft", "Volcanic Magnet")
            end
        end
    end, vu893 == 3)
    v884("PrehistoricBones", function()
        if vu899["Dinosaur Bones"] >= 99 then
        end
        if vu14:GetAttribute("PrehistoricIslandParticipant") and workspace:FindFirstChild("PrehistoricIsland") then
            local lf_325 = workspace:GetChildren()
            for v1089 = 1, # lf_325 do
                local lf_326 = lf_325[v1089]
                if lf_326.Name == "DinoBone" then
                    if lf_326:IsA("BasePart") then
                        if (lf_326.Position - workspace.PrehistoricIsland:GetPivot().Position).Magnitude <= 1500 then
                            if vu14:DistanceFromCharacter(lf_326.Position) > 3 then
                                vu83(lf_326.CFrame)
                            else
                                vu83(lf_326.CFrame + vu908)
                            end
                            vu945 = tick()
                            return "Collecting Dinosaur Bones"
                        end
                    end
                end
            end
        end
    end, vu893 == 3)
    v884("PrehistoricEgg", function()
        local lf_327 = vu885:GetSpawnedIsland("PrehistoricIsland")
        if lf_327 then
            local lf_328 = lf_327:FindFirstChild("Core")
            if lf_328 then
                lf_328 = lf_328:FindFirstChild("SpawnedDragonEggs")
            end
            if lf_328 and # lf_328:GetChildren() > 0 then
                local lf_329 = lf_328:FindFirstChild("DragonEgg")
                if lf_329 then
                    lf_329 = lf_329:FindFirstChild("Molten")
                end
                if lf_329 and (lf_329:FindFirstChild("ProximityPrompt") and lf_329.ProximityPrompt.Enabled) then
                    if vu14:DistanceFromCharacter(lf_329.Position) >= 3 then
                        vu83(lf_329.CFrame)
                    else
                        fireproximityprompt(lf_329.ProximityPrompt)
                    end
                    vu945 = tick()
                    return "Collecting Dragon Egg"
                end
            end
        end
    end, vu893 == 3)
    v884("LavaGolem", function()
        local lf_330 = vu885:GetSpawnedIsland("PrehistoricIsland")
        if lf_330 and lf_330:GetAttribute("IsMinigameActive") then
            local lf_331 = vu25
            local v1096, v1097, v1098 = ipairs(lf_331:GetChildren())
                local v1099
                v1098, v1099 = v1096(v1097, v1098)
                if v1098 == nil then
                end
                local lf_332 = v1099.PrimaryPart
                if v1099.Name == "Lava Golem" and (lf_332 and lf_332.Position.Y > 0) then
                    vu906(v1099, true)
                    vu945 = tick()
                    return "Defeating Lava Golem"
                end
            end
        end
    end, vu893 == 3)
    v884("PrehistoricIsland", function()
        local lf_333 = vu885:GetSpawnedIsland("PrehistoricIsland")
        if lf_333 then
            local lf_334 = vu885:GetPrehistoricActivationPrompt(lf_333)
            if not lf_334 then
                return true, vu890:StopBoat()
            end
            if lf_334.Parent:FindFirstChild("InteriorLava") then
                lf_334.Parent.InteriorLava:Destroy()
            end
            if lf_333:GetAttribute("IsMinigameActive") then
                local lf_335 = tick()
                RemoveCanTouch = tick()
                vu945 = lf_335
                local lf_336 = vu1028(lf_333)
                if lf_336 then
                    if vu14:DistanceFromCharacter(lf_336.Position) >= 5 then
                        vu83(lf_336.CFrame, false, false, true)
                    else
                        vu896(vu890:RandomTool(), true)
                        vu82.UseSkills(lf_336, vu38.SeaSkills)
                    end
                else
                    vu83(lf_334.CFrame, false, false, true)
                end
                return "Volcano Patch"
            end
            if vu14:DistanceFromCharacter(lf_334.Position) > 3 then
                vu945 = tick()
                vu83(lf_334.CFrame)
                return "Teleporting to Prehistoric Island"
            end
            if lf_334:FindFirstChild("ProximityPrompt") and lf_334.ProximityPrompt.Enabled then
                vu945 = tick()
                fireproximityprompt(lf_334.ProximityPrompt)
                return "Waiting..."
            end
            if vu38.ResetPrehistoric and (tick() - vu945 >= 8 and vu894(vu14.Character)) then
                vu14.Character.Humanoid.Health = 0
                return "Reseting..."
            end
        end
        if vu45.Sea and vu38.aTweenBoat or vu45.KitsuneIsland and vu21:FindFirstChild("KitsuneIsland") then
        end
        if vu890:GetPlayerBoat() then
            vu890:RandomTeleport("inf")
        else
            vu890:BuyNewBoat()
        end
        return "Finding Prehistoric Island"
    end, vu893 == 3)
    v884("KitsuneIsland", function()
        local lf_337 = vu21:FindFirstChild("KitsuneIsland")
        if not lf_337 or vu9:GetAttribute("MoonPhase") ~= 5 then
            if vu45.Sea then
            end
            if vu890:GetPlayerBoat() then
                vu890:RandomTeleport("6")
            else
                vu890:BuyNewBoat()
            end
        end
        if vu9:GetAttribute("IsBlueMoon") and vu9:GetAttribute("BlueMoonEnded") then
        end
        local lf_338 = vu991()
        if lf_338 then
            vu83(lf_338.CFrame)
        end
        local lf_339 = lf_337:FindFirstChild("ShrineDialogPart")
        if lf_339 then
            if vu14:DistanceFromCharacter(lf_339.Position) > 3 then
                vu83(lf_339.CFrame)
            elseif vu9:GetAttribute("MoonPhase") == 5 and not vu9:GetAttribute("IsBlueMoon") then
                vu939:FireServer()
            end
        elseif lf_337.WorldPivot then
            vu83(lf_337.WorldPivot)
        end
    end, vu893 == 3)
    v884("Shipwright", function()
        if vu17.Value == "Shipwright" then
        end
        local v1108, v1109 = vu937:InvokeServer("Shipwright")
        if v1108 == 1 then
            vu938:InvokeServer("Shipwright")
        elseif v1108 == 3 then
            if (tonumber(v1109) or 0) < 20 then
                return vu876.Sea(vu960.Shipwright)
            end
        elseif v1108 == 4 or v1108 == 2 then
            if vu943.GetPlayerData:InvokeServer().Purchased.Shipwright == nil then
                if vu16.Value >= 3000 then
                    vu943.PurchaseSubclass:InvokeServer("Shipwright")
                end
            else
                vu943.EquipSubclass:InvokeServer("Shipwright")
            end
        end
    end, vu893 == 3)
    v884("RaceV2", function()
        if vu15.Race.Value == "Draco" or not vu898["Warrior Helmet"] or vu15.Race:FindFirstChild("Evolved") then
        end
        local lf_340 = vu82:GetProgress("RaceV2", "Alchemist", "1")
        if lf_340 == 0 or lf_340 == 2 then
            if lf_340 ~= 2 or vu20.Value >= 500000 then
                if vu14:DistanceFromCharacter(vu932.Position) >= 5 then
                    vu83(vu932)
                else
                    vu897("Alchemist", lf_340 == 0 and "2" or "3")
                end
            end
        elseif lf_340 == 1 then
            for v1111 = 1, 2 do
                local lf_341 = workspace:FindFirstChild("Flower" .. v1111)
                if lf_341 then
                    if lf_341.Transparency ~= 1 then
                        if not VerifyTool("Flower " .. v1111) then
                            return "Collecting Flower: " .. v1111, vu83(lf_341.CFrame)
                        end
                    end
                end
            end
            if not VerifyTool("Flower 3") then
                local lf_342 = vu902("Swan Pirate")
                if lf_342 and lf_342.PrimaryPart then
                    vu906(lf_342)
                else
                    vu891:NPCs(vu953["Swan Pirate"])
                end
                return "Getting Flower: 3"
            end
        end
    end, vu893 == 2)
    v884("RaceV3", function()
        local lf_343 = vu15.Race.Value
        if lf_343 == "Draco" or (not vu15.Race:FindFirstChild("Evolved") or vu951.RaceV3 and vu951.RaceV3[lf_343]) then
        end
        local lf_344 = vu82:GetProgress("RaceV3", "Wenlocktoad", "1")
        if lf_344 == - 2 then
            if vu951.RaceV3 then
                vu951.RaceV3[lf_343] = true
            else
                vu951.RaceV3 = {
                    [lf_343] = true
            end
        end
        if lf_344 == 0 or lf_344 == 2 then
            if lf_344 ~= 2 or vu20.Value >= 2000000 then
                if vu14:DistanceFromCharacter(vu933.Position) >= 5 then
                    vu83(vu933)
                else
                    vu897("Wenlocktoad", lf_344 == 0 and "2" or "3")
                end
            end
        elseif lf_344 == 1 then
            if lf_343 == "Fishman" then
                return vu876.Sea(vu958.Shark)
            end
            if lf_343 == "Human" then
                local v1116, v1117, v1118 = ipairs(vu958.Human)
                    local v1119
                    v1118, v1119 = v1116(v1117, v1118)
                    if v1118 == nil then
                    end
                    if vu901(v1119) then
                        return vu983(vu82.Bosses[v1119], v1119)
                    end
                end
            elseif lf_343 == "Mink" then
                local gt_ohuvglexmmcr = vu876.ChestTween
            end
        end
    end, vu893 == 2)
    v884("Sea", function(p1120)
        local lf_345 = vu890:GetPlayerBoat()
        if not lf_345 then
            vu890:BuyNewBoat()
        end
        local lf_346 = p1120 or vu38.seaEnemy
        if not lf_346 then
        end
        local lf_347 = lf_346.PirateBrigade and vu890:GetSeaEvent("PirateBrigade")
        if lf_347 then
            vu890:attackSeaEvent(lf_347)
        end
        local lf_348 = lf_346["Sea Beast"] and vu890:GetSeaBeast()
        if lf_348 then
            vu890:attackSeaBeast(lf_348)
        end
        if vu890:RepairBoat(lf_345) then
        end
        if lf_345 then
            vu890:RandomTeleport()
        end
    end, vu893 == 2)
    v884("Sea", function(p1125, p1126)
        local lf_349 = vu890:GetPlayerBoat()
        if not lf_349 then
            vu890:BuyNewBoat()
        end
        local lf_350 = p1126 or vu38.boatSelected
        local lf_351 = p1125 or vu38.fishSelected
        local lf_352 = lf_351["Sea Beast"] and vu890:GetSeaBeast()
        if lf_352 then
            vu890:attackSeaBeast(lf_352)
        end
        local v1131, v1132, v1133 = pairs(lf_351)
            local v1134
            v1133, v1134 = v1131(v1132, v1133)
            if v1133 == nil then
            end
            if v1134 and v1133 ~= "Sea Beast" then
                local lf_353 = vu890:GetSeaEvent(v1133)
                if lf_353 then
                    vu890:attackSeaEvent(lf_353)
                end
            end
        end
        local v1136, v1137, v1138 = pairs(lf_350)
            local v1139
            v1138, v1139 = v1136(v1137, v1138)
            if v1138 == nil then
            end
            if v1139 then
                local lf_354 = vu890:GetSeaEvent(v1138)
                if lf_354 then
                    vu890:attackSeaEvent(lf_354)
                end
            end
        end
        if vu890:RepairBoat(lf_349) then
        end
        if vu38.aTweenBoat and lf_349 then
            vu890:RandomTeleport()
        end
    end, vu893 == 3)
    v884("Rengoku", function()
        if vu898.Rengoku or vu45.Level and vu19.Value < 1350 then
        end
        if VerifyTool("Library Key") then
            return vu897("OpenLibrary")
        end
        if VerifyTool("Hidden Key") then
            return vu897("OpenRengoku")
        end
        if vu901("Awakened Ice Admiral") then
            return vu983(vu82.Bosses["Awakened Ice Admiral"], "Awakened Ice Admiral")
        end
        if vu19.Value >= 1425 or not vu45.Level then
            local lf_355 = vu902("Arctic Warrior", "Snow Lurker")
            if lf_355 and lf_355.PrimaryPart then
                vu906(lf_355)
            end
        end
    end, vu893 == 2)
    v884("Bartilo", function()
        if vu19.Value < 850 or vu898["Warrior Helmet"] then
        end
        local lf_356 = vu82:GetProgress("Bartilo", "BartiloQuestProgress")
        if lf_356.KilledSpring then
            vu897("BartiloQuestProgress", "DidPlates")
        elseif lf_356.KilledBandits then
            if vu901("Jeremy") then
                local lf_357 = vu902("Jeremy")
                if lf_357 and lf_357.PrimaryPart then
                    vu906(lf_357)
                else
                    vu83(CFrame.new(2316, 449, 787))
                end
            end
        elseif not lf_356.KilledBandits then
            local lf_358 = vu886:VerifyQuest("Swan Pirate")
            if lf_358 then
                lf_358 = vu886:VerifyQuest("50")
            end
            if lf_358 then
                local lf_359 = vu902("Swan Pirate")
                if lf_359 and lf_359.PrimaryPart then
                    vu906(lf_359)
                else
                    vu891:NPCs(vu953["Swan Pirate"])
                end
            else
                vu886:StartQuest("BartiloQuest", 1, vu930)
            end
        end
    end, vu893 == 2)
    v884("Yama", function()
        if vu898.Yama then
        end
        if vu82:GetProgress("EliteProgress", "EliteHunter", "Progress") >= 30 then
            if vu14:DistanceFromCharacter(vu926.Position) >= 5 then
                vu83(vu926)
            else
                pcall(vu977)
                task.wait(1)
            end
        end
    end, vu893 == 3)
    v884("Citizen", function()
        if vu19.Value < 1800 or vu898["Musketeer Hat"] then
        end
        local lf_360 = vu82:GetProgress("Citizen", "CitizenQuestProgress")
        if lf_360.FoundTreasure then
        end
        if lf_360.KilledBoss then
            vu83(vu934)
        end
        if not lf_360.KilledBandits then
            local lf_361 = vu886:VerifyQuest("Forest Pirate")
            if lf_361 then
                lf_361 = vu886:VerifyQuest("50")
            end
            if not lf_361 then
                if vu14:DistanceFromCharacter(vu936.Position) < 5 then
                    vu83(vu936)
                else
                    vu897("CitizenQuest", 1)
                end
            end
            local lf_362 = vu902("Forest Pirate")
            if lf_362 and lf_362.PrimaryPart then
                vu906(lf_362, true)
            else
                vu891:NPCs(vu953["Forest Pirate"])
            end
        end
        if vu901("Captain Elephant") then
            if not vu886:VerifyQuest("Captain Elephant") then
                if vu14:DistanceFromCharacter(vu936.Position) < 5 then
                    vu83(vu936)
                else
                    vu897("CitizenQuestProgress", "Citizen")
                end
            end
            local lf_363 = vu902("Captain Elephant")
            if lf_363 and lf_363.PrimaryPart then
                vu906(lf_363)
            else
                vu83(vu935)
            end
        end
    end, vu893 == 3)
    v884("RainbowHaki", function()
        local lf_364 = vu886:VerifyQuest(vu955)
        if lf_364 then
            if vu901(lf_364) then
                return vu983(vu82.Bosses[lf_364], lf_364, true)
            end
        else
            vu897("HornedMan", "Bet")
        end
    end, vu893 == 3)
    v884("EliteHunter", function()
        local lf_365 = vu886:VerifyQuest(vu904)
        if (vu45.DoughKing or (vu45.CakePrince or vu45.RipIndra)) and (vu901("rip_indra True Form") or (vu901("Dough King") or (vu901("Cake Prince") or (VerifyTool("God\'s Chalice") or VerifyTool("Sweet Chalice"))))) then
        end
        if lf_365 then
            local lf_366 = vu902(lf_365)
            if lf_366 and lf_366.PrimaryPart then
                return "Killing Elite Hunter: " .. lf_365, vu906(lf_366)
            end
        else
            local lf_367 = vu82.Enemies:GetEnemyByTag("Elite")
            if lf_367 then
                vu83(vu922)
                vu891:talkNpc(vu922, "EliteHunter")
                return "Getting Elite Quest: " .. lf_367.Name
            end
        end
    end, vu893 == 3)
    v884("AuraColor", function()
        local lf_368 = vu38.CraftAura
        if lf_368 and not vu898[lf_368] then
            local lf_369 = vu886:GetAuraCraft(lf_368)
            if not type(lf_369) ~= "table" then
            end
            local v1156, v1157, v1158 = ipairs(lf_369)
                local v1160
                v1158, v1160 = v1156(v1157, v1158)
                if v1158 == nil then
                end
                if vu899[v1160.Name] < v1160.Amount then
                    table.insert(v1159, v1160.Name)
                end
            end
            if # v1159 <= 0 then
                local lf_370 = vu887:GetNpcPosition("Barista")
                if vu14:DistanceFromCharacter(lf_370.Position) >= 3 then
                    vu83(lf_370)
                else
                    vu940:InvokeServer({
                        StorageName = lf_368,
                        Type = "AuraSkin",
                        Context = "Craft"
                    })
                end
            end
            if vu45.BerryBush then
                v1159 = nil
            end
            if vu876.BerryBush(v1159, vu38.CraftHop) then
            end
            task.wait(0.3)
        end
    end, vu893 ~= 1)
    v884("BerryBush", function(p1162, p1163)
        local lf_371 = vu82.Berry(p1162)
        if lf_371 and lf_371.Parent then
            local v1165, v1166, v1167 = pairs(lf_371:GetAttributes())
            local v1168, v1169 = v1165(v1166, v1167)
            if v1168 ~= nil then
                local lf_372 = lf_371.Parent
                local lf_373 = lf_372:GetPivot() * lf_372:GetAttribute(v1168)
                if vu14:DistanceFromCharacter(lf_373.Position) >= 3 then
                    vu83(lf_373)
                else
                    vu942:InvokeServer(lf_372.Name, v1168)
                end
                return "Collecting Berry: " .. v1169
            end
        elseif p1163 or p1163 == nil and vu38.BerryHop then
            vu82:ServerHop()
        end
end)
    v884("ThirdSea", function()
        if vu19.Value < 1500 or vu19.Value >= 1850 then
        else
            local lf_374 = vu82:GetProgress("Zou1", "ZQuestProgress")
            if vu951.Zou2 or vu82:GetProgress("Zou2", "ZQuestProgress", "Check") then
                if not vu951.Zou2 then
                    vu951.Zou2 = true
                end
                if vu14:DistanceFromCharacter(vu929.Position) < 1200 then
                    local lf_375 = vu25:FindFirstChild("rip_indra")
                    if lf_375 and (lf_375.PrimaryPart and lf_375.PrimaryPart.Position.Y > 0) then
                        vu906(lf_375)
                    end
                end
                if lf_374.KilledIndraBoss then
                    return vu82:TravelTo(3)
                end
                if vu14:DistanceFromCharacter(vu911.Position) < 5 then
                    vu897("ZQuestProgress", "Begin")
                    vu32.OnFarm = false
                    repeat
                    until vu14:DistanceFromCharacter(vu929.Position) < 1200 or not vu45[vu38.RunningOption]
                end
                vu83(vu911)
                return
            elseif vu82:GetProgress("Unlockables", "GetUnlockables").FlamingoAccess then
                return vu876.DonSwan()
            else
            end
        end
    end, vu893 == 2)
    v884("DonSwan", function()
        if not vu898["Warrior Helmet"] then
        end
        if vu901("Don Swan") then
            local lf_376 = vu902("Don Swan")
            if lf_376 and lf_376.PrimaryPart then
                vu906(lf_376)
            else
                vu83(vu931)
            end
        end
    end, vu893 == 2)
    v884("SecondSea", function()
        if vu19.Value < 700 then
        end
        local lf_377 = vu82:GetProgress("Dressrosa", "DressrosaQuestProgress")
        if lf_377.KilledIceBoss then
            return vu82:TravelTo(2)
        end
        if lf_377.TalkedDetective then
            if lf_377.UsedKey then
                if not lf_377.KilledIceBoss then
                    local lf_378 = vu902("Ice Admiral")
                    if lf_378 and lf_378.PrimaryPart then
                        vu906(lf_378)
                    else
                        vu83(vu917)
                    end
                end
            else
                if not VerifyTool("Key") then
                    vu897("DressrosaQuestProgress", "Detective")
                end
                vu896("Key")
                vu897("DressrosaQuestProgress", "UseKey")
            end
        else
            vu897("DressrosaQuestProgress", "Detective")
        end
    end, vu893 == 1)
    v884("Order", function()
        local lf_379 = vu25:FindFirstChild("Order")
        if lf_379 and lf_379.PrimaryPart then
            vu906(lf_379)
        end
        if VerifyTool("Microchip") then
            return fireclickdetector(vu21.CircleIsland.RaidSummon.Button.Main.ClickDetector)
        end
        local gt_jifafnmucxai = vu38.FullyLawRaid
    end, vu893 == 2)
    v884("Saber", function()
        if vu19.Value < 200 or vu898.Saber then
        end
        local lf_380 = vu82:GetProgress("Shanks", "ProQuestProgress")
        if lf_380.UsedRelic then
            if vu82.Enemies.IsSpawned("Saber Expert") then
                local lf_381 = vu902("Saber Expert")
                if lf_381 and lf_381.PrimaryPart then
                    vu906(lf_381)
                else
                    vu83(vu924)
                end
            end
        else
            if lf_380.KilledMob then
                if VerifyTool("Relic") then
                    vu897("ProQuestProgress", "PlaceRelic")
                else
                    vu897("ProQuestProgress", "RichSon")
                end
            end
            if not lf_380.UsedCup then
                if lf_380.UsedTorch then
                    if VerifyTool("Cup") then
                        vu897("ProQuestProgress", "FillCup", vu14.Character and vu14.Character:FindFirstChild("Cup") or vu14.Backpack:FindFirstChild("Cup"))
                    else
                        vu897("ProQuestProgress", "GetCup")
                    end
                    vu897("ProQuestProgress", "SickMan")
                end
                local lf_382 = next
                local lf_383 = lf_380.Plates
                    local v1183
                    v1182, v1183 = lf_382(lf_383, v1182)
                    if v1182 == nil then
                    end
                    if not v1183 then
                        vu897("ProQuestProgress", "Plate", v1182)
                    end
                end
                if VerifyTool("Torch") then
                    vu897("ProQuestProgress", "DestroyTorch")
                else
                    vu897("ProQuestProgress", "GetTorch")
                end
            end
            if not lf_380.TalkedSon then
                return vu897("ProQuestProgress", "RichSon")
            end
            if vu82.Enemies.IsSpawned("Mob Leader") then
                local lf_384 = vu902("Mob Leader")
                if lf_384 and lf_384.PrimaryPart then
                    vu906(lf_384)
                else
                    vu83(CFrame.new(- 2880, 9, 5430))
                end
            end
        end
    end, vu893 == 1)
    v884("PoleV1", function()
        if vu19.Value < 450 or vu898["Pole (1st Form)"] then
        end
        if vu82.Enemies.IsSpawned("Thunder God") then
            local lf_385 = vu902("Thunder God")
            if lf_385 and lf_385.PrimaryPart then
                vu906(lf_385)
            else
                vu83(vu927)
            end
        end
    end, vu893 == 1)
    v884("TheSaw", function()
        if vu19.Value < 100 or vu898["Shark Saw"] then
        end
        if vu82.Enemies.IsSpawned("The Saw") then
            local lf_386 = vu902("The Saw")
            if lf_386 and lf_386.PrimaryPart then
                vu906(lf_386)
            else
                vu83(vu928)
            end
        end
    end, vu893 == 1)
    v884("SoulReaper", function()
        local lf_387 = vu902("Soul Reaper")
        if lf_387 and lf_387.PrimaryPart then
            vu906(lf_387)
        end
        if VerifyTool("Hallow Essence") then
            vu896("Hallow Essence")
            vu83(vu916)
        end
    end, vu893 == 3)
    v884("RipIndra", function()
        if vu901("rip_indra True Form") then
            local lf_388 = vu902("rip_indra True Form")
            if lf_388 and lf_388.PrimaryPart then
                vu906(lf_388)
            else
                vu83(vu914)
            end
            return "Killing: rip_indra True Form"
        end
        if VerifyTool("God\'s Chalice") then
            if vu976() < 3 then
                vu83(vu914)
            else
                vu83(vu915)
            end
            return "God\'s Chalice: rip_indra True Form"
        end
    end, vu893 == 3)
    v884("BossSelected", function()
        local lf_389 = vu38.BossSelected
        local v1190
        if lf_389 then
            v1190 = vu901(lf_389)
        else
            v1190 = lf_389
        end
        if v1190 then
            local gt_rbtwigfvlqzn = vu82.Bosses[lf_389]
        end
end)
    v884("AllBosses", function()
        local lf_390 = vu965()
        if lf_390 then
            local gt_jdsjxxxrkoqd = vu82.Bosses[lf_390]
        end
end)
    v884("DoughKing", function()
        local lf_391 = vu902("Dough King") or vu902("Cake Prince")
        if VerifyTool("Red Key") then
            vu897("CakeScientist", "Check")
        else
            if lf_391 and lf_391.PrimaryPart then
                vu906(lf_391)
            else
                if not VerifyTool("Sweet Chalice") and VerifyTool("God\'s Chalice") then
                    if vu899["Conjured Cocoa"] < 10 then
                        return vu887:Material("Conjured Cocoa")
                    end
                    vu83(vu919)
                    vu891:talkNpc(vu919, "SweetChaliceNpc")
                end
                local lf_392 = vu82.Enemies:GetClosestByTag("CakePrince")
                if lf_392 and lf_392.PrimaryPart then
                    vu906(lf_392, true, true)
                else
                    vu83(vu918)
                end
            end
        end
    end, vu893 == 3)
    v884("CakePrince", function()
        if vu45.DoughKing then
        end
        local lf_393 = vu902("Dough King") or vu902("Cake Prince")
        if lf_393 and lf_393.PrimaryPart then
            vu906(lf_393)
        else
            local lf_394 = vu82.Enemies:GetClosestByTag("CakePrince")
            if lf_394 and lf_394.PrimaryPart then
                vu906(lf_394, true, true)
            else
                vu83(vu918)
            end
        end
    end, vu893 == 3)
    v884("ChestTween", function(p1196, p1197)
        local lf_395 = vu82.Chests()
        if lf_395 then
            local lf_396 = lf_395:GetPivot(p1197)
            if vu14:DistanceFromCharacter(lf_396.Position) >= 3 then
                vu83(lf_396)
            else
                vu83(lf_396 + vu908)
                task.wait(0.15)
            end
            return "Collecting Chest" .. (p1196 or "")
        end
end)
    v884("Ectoplasm", function()
        local lf_397 = vu902(vu905)
        if lf_397 and lf_397.PrimaryPart then
            return "Killing: " .. lf_397.Name, vu906(lf_397, true, true)
        else
            return "Waiting for: Enemy Spawn", vu83(vu913)
        end
    end, vu893 == 2)
    v884("Bones", function()
        if vu45.Level and vu19.Value < vu892 then
        else
            local lf_398 = vu82.Enemies:GetClosestByTag("Bones")
            if lf_398 and lf_398.PrimaryPart then
                return "Killing: " .. lf_398.Name, vu906(lf_398, true, true)
            else
                return "Waiting for: Enemy Spawn", vu83(vu923)
            end
        end
    end, vu893 == 3)
    v884("Level", function()
        local lf_399 = vu886:GetQuest()
        if not lf_399 then
        end
        local lf_400 = lf_399.Enemy.Name
        local lf_401 = lf_399.Enemy.Position
        local lf_402 = vu886:VerifyQuest(lf_400)
        if lf_402 and vu82.IsBoss(lf_402) then
            return vu983(vu82.Bosses[lf_402], lf_402, false)
        end
        if not lf_402 then
            local lf_403 = vu886
            return vu886:StartQuest(lf_399.Name, lf_399.Count, lf_403:GetQuestPosition(lf_399.Name))
        end
        local lf_404 = vu902(lf_402)
        if lf_404 and lf_404.PrimaryPart then
            return "Killing: " .. lf_404.Name, vu906(lf_404, true)
        end
        local lf_405 = vu886:GetQuestPosition(lf_399.Name)
        if # lf_401 <= 0 then
            if lf_405 then
                vu83(lf_405 * vu886._Position)
            end
        else
            vu891:NPCs(lf_401)
        end
        return "Waiting for: " .. lf_402
end)
    v884("Mastery", function()
        if vu893 ~= 3 or vu892 > vu19.Value then
            return vu876.Level()
        else
            return vu876.Bones()
        end
end)
    v884("Material", function()
        if vu38.fMaterial then
            local gt_qecpgfjpgbtu = vu887.Material
            local gt_phayxpupvlhh = vu38.fMaterial
        end
end)
    v884("Nearest", function()
        local lf_406 = vu947
        if lf_406 then
            lf_406 = vu947.PrimaryPart
        end
        if lf_406 and vu894(vu947) and vu14:DistanceFromCharacter(lf_406.Position) < 1500 then
            return "Killing: " .. vu947.Name, vu906(vu947, true, true)
        end
        local v1211, v1212, v1213 = ipairs(v1210:GetChildren())
        local lf_407 = 1500
            local v1216
            v1213, v1216 = v1211(v1212, v1213)
            if v1213 == nil then
            end
            local lf_408 = v1216.PrimaryPart
            if vu894(v1216) and lf_408 then
                local lf_409 = vu14:DistanceFromCharacter(lf_408.Position)
                if lf_409 < lf_407 then
                    v1215 = v1216
                    lf_407 = lf_409
                end
            end
        end
        if v1215 then
            vu947 = v1215
            vu906(v1215, true, true)
        end
        task.wait(0.4)
end)
    local vu1219
    if type(vu1.CustomFunctions) ~= "function" then
        vu1219 = vu897
    else
        local lf_410 = vu1.CustomFunctions({
            Managers = p875.Managers,
            Module = vu82,
            ScriptFunctions = vu876,
            Functions = {
                GetNextBoss = vu965,
                AttackSegment = vu1031,
                GetVolcanoRock = vu1028,
                KillBossByInfo = vu983,
                GetCursedDualKatanaTask = vu1018,
                GetEmberTemplate = vu991,
                BreakTree = vu1002
        })
        local v1221, v1222, v1223 = pairs(lf_410)
        vu1219 = vu897
            local v1224
            v1223, v1224 = v1221(v1222, v1223)
            if v1223 == nil then
            end
            v884(v1223, v1224)
        end
    end
    if vu893 == 3 then
        local vu1225 = "Do you want to open the portal now?"
            ["Obtained <Color=Purple><Mutant Tooth><Color=/> (1x)"] = function()
                vu889:BeltProgress("Red", 1)
            end,
            ["<Color=Yellow><QUEST COMPLETED!><Color=/>"] = function()
                vu889:BeltProgress("White", 8)
            end,
            ["Head back to the Dojo to complete more tasks."] = function()
                vu946 = nil
            end,
            ["Dojo quest abandoned!"] = function()
                vu946 = nil
            end
        table.insert(vu76, vu82.Signals.Notify:Connect(function(p1228)
            local lf_411 = vu1227[p1228]
            if lf_411 then
                return lf_411()
            end
            if p1228:find("Earned <Color=Green>%$%d+<Color=/>") then
                if vu14:GetAttribute("DangerLevel") < 100 then
                    if vu45.DoughKing and VerifyTool("Sweet Chalice") or vu45.CakePrince then
                        vu1226 = tick() + 9000000000
                        local lf_412 = vu1219("CakePrinceSpawner", true) or "Error"
                        if tick() - vu1226 >= 0.25 and string.find(lf_412, vu1225) then
                            vu1219("CakePrinceSpawner")
                        end
                        vu1226 = tick()
                    end
                else
                    vu889:BeltProgress("Yellow", 1)
                end
            end
end)
)
    end
end
function vu102.Webhooks(_)
    if not vu82.IsCustomUrl and vu82.Webhooks then
            vu82
        __loadstring("{Repository}Utils/Webhooks.lua", false, v1231)
    end
end
local function v1234(p1232, ...)
    local lf_413 = tick()
    vu102[p1232](vu102, ...)
    print(p1232, tick() - lf_413)
end
v1234("Initialize")
v1234("StartFarm")
v1234("StartFunctions")
task.spawn(v1234, "LoadLibrary")
task.spawn(v1234, "Webhooks")
