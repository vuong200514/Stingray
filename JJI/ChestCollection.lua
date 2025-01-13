repeat
    task.wait()
until game:IsLoaded()

print("Script Loading")
if not getgenv().StingrayLoaded then
getgenv().StingrayLoaded = true
print("Script Loaded")

-- Init --
local StartTime = tick()
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Load Configs--

-- Webhook
pcall(function()
    if getgenv().Webhook then
        writefile("JJI_Webhook.txt", getgenv().Webhook)
    end
    if readfile("JJI_Webhook.txt") then
        getgenv().Webhook = readfile("JJI_Webhook.txt")
    end
end)


-- Luck Boosts
getgenv().LuckBoosts = {}
local Used,LuckError = pcall(function()
    local LuckConfigs = 
        game:HttpGet("http://www.stingray-digital.online/jji/getconfig?username="..LocalPlayer.Name)
    if LuckConfigs ~= "None Found" then
        for Item in string.gmatch(LuckConfigs, "([^,]+)") do
            Item = string.gsub(Item, "^%s+","")
            table.insert(getgenv().LuckBoosts, Item)
        end
    else
         getgenv().LuckBoosts = {"Luck Vial"}
    end
end)
if not Used then
    print("Luck Boosts Error:",LuckError)
end


-- Constants
local Cats = {"Withered Beckoning Cat", "Wooden Beckoning Cat", "Polished Beckoning Cat"}
local Loti = {"White Lotus","Sapphire Lotus","Jade Lotus","Iridescent Lotus"} -- Did you know the plural of Lotus is Loti 
local Highlight = {"5 Demon Fingers","Maximum Scroll","Domain Shard","Iridescent Lotus","Polished Beckoning Cat","Sapphire Lotus","Fortune Gourd","Demon Finger","Energy Nature Scroll","Purified Curse Hand","Jade Lotus","Cloak of Inferno","Split Soul","Soul Robe","Playful Cloud","Ocean Blue Sailor's Vest","Deep Black Sailor's Vest","Demonic Tobi","Demonic Robe","Rotten Chains"}

local QueueSuccess = "False"
if Toggle == "ON" then
    local Queued, QueueFail = pcall(function()
        queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Manta/Stingray/refs/heads/main/JJI/ChestCollection.lua"))()')()
    end)
    if not Queued then
        print("Put this script inside your auto-execution folder:", QueueFail)
        QueueSuccess = QueueFail
    else
        print("Queue success")
        QueueSuccess = "True"
    end
end

repeat
    task.wait()
until LocalPlayer.Character
local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart")


local Objects = workspace:WaitForChild("Objects")
local Mobs = Objects:WaitForChild("Mobs")
local Spawns = Objects:WaitForChild("Spawns")
local Drops = Objects:WaitForChild("Drops")
local Effects = Objects:WaitForChild("Effects")
local Destructibles = Objects:WaitForChild("Destructibles")

local LootUI = LocalPlayer.PlayerGui:WaitForChild("Loot")
local Flip = LootUI:WaitForChild("Frame"):WaitForChild("Flip")
local Replay = LocalPlayer.PlayerGui:WaitForChild("ReadyScreen"):WaitForChild("Frame"):WaitForChild("Replay")

-- Destroy fx --
Effects.ChildAdded:Connect(function(Child)
    if Child.Name ~= "DomainSphere" then
        game:GetService("Debris"):AddItem(Child, 0)
    end
end)

game:GetService("Lighting").ChildAdded:Connect(function(Child)
    game:GetService("Debris"):AddItem(Child, 0)
end)

Destructibles.ChildAdded:Connect(function(Child)
    game:GetService("Debris"):AddItem(Child, 0)
end)

-- Uh, ignore this spaghetti way of determining screen center --
local MouseTarget = Instance.new("Frame", LocalPlayer.PlayerGui:FindFirstChildWhichIsA("ScreenGui"))
MouseTarget.Size = UDim2.new(0, 0, 0, 0)
MouseTarget.Position = UDim2.new(0.5, 0, 0.5, 0)
MouseTarget.AnchorPoint = Vector2.new(0.5, 0.5)
local X, Y = MouseTarget.AbsolutePosition.X, MouseTarget.AbsolutePosition.Y

-- Funcs -- 
local function OpenChest()
    for i, v in ipairs(Drops:GetChildren()) do
        if v:FindFirstChild("Collect") then
            fireproximityprompt(v.Collect)
        end
    end
end


local function Click(Button)
    Button.AnchorPoint = Vector2.new(0.5, 0.5)
    Button.Size = UDim2.new(50, 0, 50, 0)
    Button.Position = UDim2.new(0.5, 0, 0.5, 0)
    Button.ZIndex = 20
    Button.ImageTransparency = 1
    for i, v in ipairs(Button:GetChildren()) do
        if v:IsA("TextLabel") then
            v:Destroy()
        end
    end
    local VIM = game:GetService("VirtualInputManager")
    VIM:SendMouseButtonEvent(X, Y, 0, true, game, 0)
    task.wait()
    VIM:SendMouseButtonEvent(X, Y, 0, false, game, 0)
    task.wait()
end


-- Farm start --
local ScriptLoading = tostring(math.floor((tick()-StartTime)*10)/10)

repeat task.wait() until Mobs:FindFirstChildWhichIsA("Model")
local Boss = Mobs:FindFirstChildWhichIsA("Model").Name

-- Use boosts --
local LotusActive = LocalPlayer.ReplicatedData.chestOverride
local CatActive = LocalPlayer.ReplicatedData.luckBoost
local LotusValue,CatValue = 0,0
task.spawn(function()
    for _, Item in pairs(getgenv().LuckBoosts) do
        task.wait()
        if table.find(Loti,Item) and LotusActive.Value == 0 then
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Data")
                :WaitForChild("EquipItem"):InvokeServer(Item)
            print(Item.." used")
        end
        task.wait(0.5)
        if LotusActive.Value == 0 then
            if (not table.find(Cats, Item)) or CatActive.duration.Value == 0 then
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Data")
                    :WaitForChild("EquipItem"):InvokeServer(Item)
                print(Item.." used")
            end
        end
    end
    LotusValue = LotusActive.Value
    CatValue = CatActive.amount.Value
end)

repeat
    task.wait()
until Drops:FindFirstChild("Chest") -- Could have used WaitForChild here, but I felt it feels cursed not assigning WaitForChild to a variable, then I don't want an unusused variable...

local Items = "| "
game:GetService("ReplicatedStorage").Remotes.Client.Notify.OnClientEvent:Connect(function(Message)
    local Item = string.match(Message, '">(.-)</font>')
    print(Message)
    if not (string.find(Item,"Stat Point") or string.find(Item,"Level")) then
        if table.find(Highlight,Item) then
            Item = "**"..Item.."**"
        end
        Items = Items .. Item .. " | "
    end
end)

-- Overwrite chest collection function --
local ChestsCollected = 0
local s, e = pcall(function()
    game:GetService("ReplicatedStorage").Remotes.Client.CollectChest.OnClientInvoke = function(Chest)
        if Chest then
            ChestsCollected = ChestsCollected + 1
            print("Chest Collected")
        end
        return {}
    end
end)

task.spawn(function()
    while Drops:FindFirstChild("Chest") or LootUI.Enabled do
        if not LootUI.Enabled then
            OpenChest()
        else
            repeat
                Click(Flip)
            until not LootUI.Enabled
        end
        task.wait()
    end
end)

repeat
    task.wait()
until not (Drops:FindFirstChild("Chest") or LootUI.Enabled)

-- Send webhook message --
local Sent,Error = pcall(function()
    if getgenv().Webhook then
        print("Sending webhook")
        task.wait(2)
        local Executor = (identifyexecutor() or "None Found")
        task.wait()
        local embed = {
            ["title"] = LocalPlayer.Name .. " has defeated " .. Boss .. " in " ..
                tostring(math.floor((tick() - StartTime) * 10) / 10) .. " seconds",
            ['description'] = "Collected Items: " .. Items,
            ["color"] = tonumber(000000)
        }
        local a = request({
            Url = getgenv().Webhook,
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = game:GetService("HttpService"):JSONEncode({
                ['embeds'] = {embed},
                ['content'] = "-# [Debug Data] "..
                    "Executor: "..Executor..
                    " | Script Loading Time: "..tostring(ScriptLoading)..
                    " | Chests Collected: "..tostring(ChestsCollected)..
                    " | Cat Boost: "..tostring(CatValue)..
                    "x | Lotus Boost: "..tostring(LotusValue).." | Send a copy of this data to Manta if there's any issues",
                ['avatar_url'] = "https://cdn.discordapp.com/attachments/1089257712900120576/1105570269055160422/archivector200300015.png"
            }),
            Method = "POST"
        })
        print("Webhook sent!")
    end
end)
-- Click replay --
task.wait()
    for i = 1, 10, 1 do
        Click(Replay)
        task.wait(1)
    end
end
