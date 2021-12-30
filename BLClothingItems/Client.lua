ESX = nil

setupEsx = function()
	while not ESX do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Wait(100)
	end
	while not ESX.IsPlayerLoaded() do Wait(1000) end
end

RegisterNetEvent('BLClothingItems')
AddEventHandler('BLClothingItems', function(number, label)
	local playerPed = GetPlayerPed(-1)
	for k, v in pairs(Config[number].set) do
  SetPedComponentVariation(playerPed, v.c1, v.c2, v.c3, 0)
 end
	ESX.ShowNotification("You've put on " .. label)
end)

Citizen.CreateThread(function()
 setupEsx()
end)