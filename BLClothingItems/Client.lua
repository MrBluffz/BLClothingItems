ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('BLClothingItems')
AddEventHandler('BLClothingItems', function(ConfigTable)
	local playerPed = GetPlayerPed(-1)
	for k, v in pairs(Config[ConfigTable].set) do SetPedComponentVariation(playerPed, v.c1, v.c2, v.c3, 0) end
	ESX.ShowNotification("You've put on " .. Config[ConfigTable].label)
end)
