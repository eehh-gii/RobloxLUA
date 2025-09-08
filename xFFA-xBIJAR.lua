local games = {
    [82244791980790] = "https://raw.githubusercontent.com/eehh-gii/RobloxLUA/refs/heads/main/kampung-halaman.lua",
    [112249475259380] = "https://raw.githubusercontent.com/eehh-gii/RobloxLUA/refs/heads/main/indo-chat.lua",
    [106540876172687] = "https://github.com/eehh-gii/RobloxLUA/raw/refs/heads/main/pinggir-laut.lua",
}

local currentID = game.PlaceId
local scriptURL = games[currentID]

if scriptURL then
    loadstring(game:HttpGet(scriptURL))()
else
    game.Players.LocalPlayer:Kick("xFFA HUB : Sorry! This game ain't on the list.\nCheck the Discord for whitelisted games, homie.")
end
