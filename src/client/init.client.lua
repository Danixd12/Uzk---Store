-- GUI 
local player = game.Players.LocalPlayer
local gui = player.PlayerGui:WaitForChild("Money"):WaitForChild("Frame"):WaitForChild("money_text")

local currency = require(game.ReplicatedStorage.Common.Config)
local currency_value = player:WaitForChild("leaderstats"):WaitForChild(currency.currency)

while wait() do
    gui.Text = "Money: "..currency_value.Value
end

