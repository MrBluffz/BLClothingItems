ESX = nil

setupEsx = function()
	while not ESX do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Wait(100)
	end
	while not ESX.IsPlayerLoaded() do Wait(1000) end
end

updateClothing = function()
	local playerPed = GetPlayerPed(-1)
	ESX.TriggerServerCallback('BLClothingItems:GetClothes', function(outfitname) for i = 1, #Config do if Config[i].itemName == outfitname then for k, v in pairs(Config[i].set) do SetPedComponentVariation(playerPed, v.c1, v.c2, v.c3, 0) end end end end)
end

RegisterNetEvent('BLClothingItems')
AddEventHandler('BLClothingItems', function(number, label)
	local playerPed = GetPlayerPed(-1)
	for k, v in pairs(Config[number].set) do SetPedComponentVariation(playerPed, v.c1, v.c2, v.c3, 0) end
	ESX.ShowNotification("You've put on " .. label)
end)

Citizen.CreateThread(function()
	setupEsx()
	updateClothing()
end)

RegisterCommand('changeback', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin == nil then
			print("Skin wasn't loaded properly from esx_skin. Report error to Developer Team.")
		else
			TriggerServerEvent('BLClothingItems:reset')
			TriggerEvent('skinchanger:loadSkin', skin)
		end
	end)
end)
