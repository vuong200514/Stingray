repeat task.wait() until game:IsLoaded()

setclipboard("https://discord.gg/sWbB6Xfq")

local function CustomKick(Title, Desc, Button)
    game.Players.LocalPlayer:Kick()
    local Prompt = game:GetService("CoreGui"):WaitForChild("RobloxPromptGui"):WaitForChild("promptOverlay")
    Prompt:FindFirstChild("ErrorTitle",true).Text = Title
    Prompt:FindFirstChild("ErrorMessage",true).Text = Desc
    Prompt:FindFirstChild("ButtonText",true).Text = Button
end

CustomKick("Script Maintenance", "Discord copied to clipboard for details\nCheck #Important channel more info", "Leave")
