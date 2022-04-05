ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local ClothesList = {}

function RegisterClothes()
	for i = 1, #Config do
		ESX.RegisterUsableItem(Config[i].itemName, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.removeInventoryItem(Config[i].itemName, 1)
			TriggerClientEvent('BLClothingItems', source, i, Config[i].label)
			updateClothes(Config[i].itemName, source)
		end)
	end
end

CreateThread(function()
	while not ESX do Wait(0) end
	RegisterClothes()
	print('Items are loaded! Thank you for using BL Clothing Items')
	readClothes()
end)

readClothes = function() MySQL.Async.fetchAll('SELECT * FROM users', {}, function(result) for k, v in pairs(result) do if v.clothing then ClothesList[v.identifier] = v.clothing end end end) end

updateClothes = function(outfit, src)
	local xPlayer = ESX.GetPlayerFromId(src)
	local ident = xPlayer.getIdentifier()
	if ClothesList[ident] then xPlayer.addInventoryItem(ClothesList[ident], 1) end
	ClothesList[ident] = outfit
	MySQL.Async.execute('UPDATE users SET clothes = @clothes WHERE identifier = @identifier', {
		['clothes'] = outfit,
		['identifier'] = ident,
	})
end

ESX.RegisterServerCallback('BLClothingItems:GetClothes', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(ClothesList[xPlayer.getIdentifier()])
end)

RegisterCommand('deleteoutfit', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local ident = xPlayer.getIdentifier()
	if ClothesList[ident] then
		ClothesList[ident] = nil
		MySQL.Async.execute('UPDATE users SET clothes = NULL WHERE identifier = @identifier', {
			['identifier'] = ident,
		})
	end
end)

RegisterNetEvent('BLClothingItems:reset')
AddEventHandler('BLClothingItems:reset', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local ident = xPlayer.getIdentifier()
	if ClothesList[ident] then
  		xPlayer.addInventoryItem(ClothesList[ident], 1)
  		Wait(100)
		ClothesList[ident] = nil
  		Wait(100)
		MySQL.Async.execute('UPDATE users SET clothes = NULL WHERE identifier = @identifier', {
			['identifier'] = ident,
		})
	end
end)
