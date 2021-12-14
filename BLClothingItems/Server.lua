ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function RegisterClothes()
	for i = 1, #Config do
		ESX.RegisterUsableItem(Config[i].itemName, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.removeInventoryItem(Config[i].itemName, 1)
			TriggerClientEvent('BLClothingItems', source, Config[i].set, Config[i].label)
		end)
	end
end

Citizen.CreateThread(function()
	RegisterClothes()
	Print('Items are loaded! Thank you for using BL Clothing Items')
end)
