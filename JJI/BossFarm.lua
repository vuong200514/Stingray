local Script = request({
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
print(Script)
writefile("Stingray_JJI.txt",Script)
loadstring(Script)()
