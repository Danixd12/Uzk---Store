-- DISCORD WEBHOOK
local settings = require(game.ReplicatedStorage.Common.Config)

local http = game:GetService("HttpService")
local url = settings.webhook_url

-- DATASTORE
local config = require(game.ReplicatedStorage.Common.Config) -- config file

local DataStoreService = game:GetService("DataStoreService")
local money_data = DataStoreService:GetDataStore("Currency")

game.Players.PlayerAdded:Connect(function(player)
	
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	money = Instance.new("IntValue")
	money.Name = config.currency
	money.Parent = leaderstats
	

	money.Value = money_data:GetAsync(player.UserId)

    print("Loaded money for "..player.Name)


		while wait(config.money_giver.waitTime) do

			money.Value = money.Value + config.money_giver.addMoney
		end

end)


game.Players.PlayerRemoving:connect(function(Player)

    money_data:SetAsync(Player.UserId, money.Value)

        print("Data successfully saved for "..Player.Name.."\n Currency: "..money.Value)

		-- sending webhook message

		local message = {
			["content"] = "",
			["embeds"] = {{
				["author"] = {
					["name"] = Player.Name.. " left",
					["icon_url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..Player.UserId.."&width=150&height=150&format=png/",
				},
				["title"] = "**Balance** ",
				["description"] = "\n Money: "..money.Value,
				["color"] = tonumber(0xc3962a),
				["type"] = "rich",
				["thumbnail"] = {
					["url"] = "https://www.roblox.com/library/7812154403/ukrania"
				}
	
			}}
		}
		message = http:JSONEncode(message)
	
		http:PostAsync(url, message)

end)


