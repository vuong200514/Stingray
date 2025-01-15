setclipboard("https://discord.gg/6qjtVkwD")
local function CustomKick(Title, Desc, Button)
    game.Players.LocalPlayer:Kick()
    local Prompt = game:GetService("CoreGui"):WaitForChild("RobloxPromptGui"):WaitForChild("promptOverlay")
    Prompt:FindFirstChild("ErrorTitle",true).Text = Title
    Prompt:FindFirstChild("ErrorMessage",true).Text = Desc
    Prompt:FindFirstChild("ButtonText",true).Text = Button
end

CustomKick("Unexpected Script Maintenance", "Discord server copied to clipboard for details\n(Migrated, please join new server and leave old)\nCheck #Important for info", "Leave")
