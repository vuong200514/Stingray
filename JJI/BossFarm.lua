local Script = [[
    print("Post request failure")
]]
local S,E = pcall(function()
    Script = request({
    Url = "http://stingray-digital.online/script/jji",
    Headers = {
        ['Content-Type'] = 'application/json'
    },
    Body = game:GetService("HttpService"):JSONEncode({
        key = tostring(getgenv().Key),
        hwid = game:GetService("RbxAnalyticsService"):GetClientId(),
        username = game:GetService("Players").LocalPlayer.Name
    }),
    Method = "POST"
}).Body
end)
task.wait(1)
if not S then print(E) else print(#Script) end
writefile("Stingray_JJI.txt",Script)
loadstring(Script)()
