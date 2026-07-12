local SupportedIds = {
    [16281075967] = true,
    [5617640646] = true
}

if not SupportedIds[game.PlaceId] then
    game:GetService("Players").LocalPlayer:Kick("Game not supported. Please join Pizza Game.")
    return
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/Janedoesigma/Refres-janedoehub1tap/main/Janedoehubwearedevs/Minimaizepizzagamem.lua"))()
