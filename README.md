# Common questions/fixes:
**Script not automatically executing itself**
- Put the script in automatic-execution folder in your executor, means your crappy executor has a crappy `queue_on_teleport` function.
**It shows 4 chests collected in debug data but there are barely any items collected**
- Check your inventory for x999 on common items, items are auto-sold when they reach max capacity.
**Script only does Mahito boss, how to choose another boss?**
- Execute the script inside an actual boss fight instead of main game
**Why are there so many maintenances?**
- I'm bored and feel like fucking with something
**How to use the script during maintenance?**
- Copy down the source code at http://stingray-digital.online/script/jji and run the script from source instead of from loadstring
**How to setup Webhook?**
- Tutorial here, replace `https://yourdiscordwebhook.com` with webhook copied from: https://discord.com/channels/1076517723082858598/1298904050221453313/1306556413425745921
**Edit luck boosts to use during boss fights**
- Luck boost configuration site is currently down, DM me your Roblox username and boosts you want to use instead for now.
**Is the script safe to use?**
- Script is relatively safe compared to any other script you find online, all leveling, pvp and gamepass scripts are a guaranteed ban. If you use this and only this script on an account, you are pretty safe from the auto detection, however I can't guarantee anything if admins look through logs and find your account suspicious.
**What is the "Instant Kill" option in debug data and how to enable?**
- Don't enable that unless you are sure your executor is good enough, this requires quick access to network ownership of the boss, it works by setting the health of the boss instantly to 0. This may be detected as you don't have any real damage logs, don't turn this on!!!

**This repository is a collection of separate scripts and not made to be built or ran as a whole**

Any further questions please ask inside the [Discord server](https://discord.gg/SzdQMf9XBB)
