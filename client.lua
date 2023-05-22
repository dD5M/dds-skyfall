local QBCore = exports['qbx-core']:GetCoreObject()
local isSkyfall = false

exports('wingsuit', function(data, slot)
	local item = 'wingsuit'
    exports.ox_inventory:useItem(data, function(data)
        if data then
			EquipParachuteAnim()
			if lib.progressBar({
				duration = 2000,
				label = 'Preparing Suit',
				useWhileDead = false,
				canCancel = true,
				disable = {
					car = true,
				},
			}) then
				ApplyWingSuit(item) lib.notify({description = 'Nice suit batman!'}) 
			else
				lib.notify({title = 'There was an issue preparing your suit', type = 'error'})
			end
			TaskPlayAnim(cache.ped, 'clothingshirt', 'exit', 8.0, 1.0, -1, 49, 0, false, false, false)
        end
    end)
end)

exports('wingsuit2', function(data, slot)
	local item = 'wingsuit2'
    exports.ox_inventory:useItem(data, function(data)
        if data then
			EquipParachuteAnim()
			if lib.progressBar({
				duration = 2000,
				label = 'Preparing Suit',
				useWhileDead = false,
				canCancel = true,
				disable = {
					car = true,
				},
			}) then
				ApplyWingSuit(item) lib.notify({description = 'Nice suit batman!'}) 
			else
				lib.notify({title = 'There was an issue preparing your suit', type = 'error'})
			end
			TaskPlayAnim(cache.ped, 'clothingshirt', 'exit', 8.0, 1.0, -1, 49, 0, false, false, false)
        end
    end)
end)

CreateThread(function()
    while true do
		local playerPed = PlayerPedId()
		local GetSuit = LocalPlayer.state.WingSuitType
		if GetSuit and not isSkyfall then
			if IsPedInParachuteFreeFall(playerPed) then --and IsControlJustReleased(0, 45) then
				isSkyfall = true
				lib.notify({title = 'Skyfall Engaged', type = 'success'})

				SetPlayerInvincible(playerPed, true)
				SetEntityProofs(playerPed, true, true, true, true, true, false, 0, false)
	
				while true do
					if isSkyfall then
						local parachutestate = GetPedParachuteState(playerPed)
						if parachutestate <= 0 and not (HasEntityCollidedWithAnything(playerPed) or IsPedSwimming(playerPed)) then
							ApplyForceToEntity(playerPed, true, 0.0, 200.0, 2.5, 0.0, 0.0, 0.0, false, true, false, false, false, true)
						else
							isSkyfall = false
						end
					else
						break
					end
	
					Wait(0)
				end
		
				Wait(3000)
				
				RemoveWeaponFromPed(playerPed, GetHashKey('gadget_parachute'))
				SetPlayerInvincible(playerPed, false)
				SetEntityProofs(playerPed, false, false, false, false, false, false, 0, false)
			end
		end
        Wait(1)
    end
end)

RegisterNetEvent("dds-skyfall:client:ResetWingsuit", function()
	local playerPed = PlayerPedId()
	local GetSuit = LocalPlayer.state.WingSuitType
	if not isSkyfall then
		if GetSuit then
			EquipParachuteAnim()
			if lib.progressBar({
				duration = 2000,
				label = 'Resetting Suit',
				useWhileDead = false,
				canCancel = true,
				disable = {
					car = true,
				},
			}) then 
				GiveWeaponToPed(playerPed, GetHashKey('gadget_parachute'), 1, true, true)
			else
				lib.notify({title = 'There was an issue resetting your suit', type = 'error'}) 
			end
			TaskPlayAnim(cache.ped, 'clothingshirt', 'exit', 8.0, 1.0, -1, 49, 0, false, false, false)
		end
	end
end)

RegisterNetEvent("dds-skyfall:client:RemoveWingsuit", function()
	local playerPed = PlayerPedId()
	local GetSuit = LocalPlayer.state.WingSuitType
	if not isSkyfall then
		if GetSuit then
			EquipParachuteAnim()
			if lib.progressBar({
				duration = 2000,
				label = 'Removing Suit',
				useWhileDead = false,
				canCancel = true,
				disable = {
					car = true,
				},
			}) then 
				returnsuit = lib.callback.await('dds-skyfall:ReturnWingsuit')
				if returnsuit then
					RemoveWeaponFromPed(playerPed, GetHashKey('gadget_parachute'))
					lib.notify({title = 'Wingsuit Packed', type = 'success'})
				end
			else
				lib.notify({title = 'There was an issue packing your suit', type = 'error'}) 
			end
			TaskPlayAnim(cache.ped, 'clothingshirt', 'exit', 8.0, 1.0, -1, 49, 0, false, false, false)
		end
	end
end)

RegisterNetEvent("dds-skyfall:AdminFall", function()
	if not isSkyfall then
		isSkyfall = true
		
		CreateThread(function()
			local playerPed = PlayerPedId()
			local playerPos = GetEntityCoords(playerPed)

			GiveWeaponToPed(playerPed, GetHashKey('gadget_parachute'), 1, true, true)

			DoScreenFadeOut(3000)

			while not IsScreenFadedOut() do
				Wait(0)
			end

			SetEntityCoords(playerPed, playerPos.x, playerPos.y, playerPos.z + 500.0)

			DoScreenFadeIn(2000)

			Wait(2000)

			lib.notify({title = 'Skyfall Engaged', type = 'success'})

			SetPlayerInvincible(playerPed, true)
			SetEntityProofs(playerPed, true, true, true, true, true, false, 0, false)

			while true do
				if isSkyfall then			
					local parachutestate = GetPedParachuteState(playerPed)
					if parachutestate <= 0 and not (HasEntityCollidedWithAnything(playerPed) or IsPedSwimming(playerPed)) then
						ApplyForceToEntity(playerPed, true, 0.0, 200.0, 2.5, 0.0, 0.0, 0.0, false, true, false, false, false, true)
					else
						isSkyfall = false
					end
				else

					break
				end

				Wait(0)
			end

			RemoveWeaponFromPed(playerPed, GetHashKey('gadget_parachute'))

			Wait(3000)

			SetPlayerInvincible(playerPed, false)
			SetEntityProofs(playerPed, false, false, false, false, false, false, 0, false)
		end)
	end
end)

function EquipParachuteAnim()
    local hasLoaded = lib.requestAnimDict('clothingshirt')
    if not hasLoaded then return end
    TaskPlayAnim(cache.ped, 'clothingshirt', 'try_shirt_positive_d', 8.0, 1.0, -1, 49, 0, false, false, false)
end

function ApplyWingSuit(data)

	local playerPed = PlayerPedId()
	local Player = QBCore.Functions.GetPlayerData()
	if DoesEntityExist(playerPed) then
		if data == 'wingsuit' then
			DataMale = Config.WingsuitWardrobe.Male
			DataFemale = Config.WingsuitWardrobe.Female
		else
			if data == 'wingsuit2' then
				DataMale = Config.Wingsuit2Wardrobe.Male
				DataFemale = Config.Wingsuit2Wardrobe.Female
			end
		end

		if Player.charinfo.gender == 0 then
			TriggerEvent('qb-clothing:client:loadOutfit', DataMale) --Change Here the Clothing resource
		else
			TriggerEvent('qb-clothing:client:loadOutfit', DataFemale) --Change Here the Clothing resource
		end

		SetPedArmour(playerPed, 0)
		ClearPedBloodDamage(playerPed)
		ResetPedVisibleDamage(playerPed)
		ClearPedLastWeaponDamage(playerPed)
		ResetPedMovementClipset(playerPed, 0)

		GiveWeaponToPed(playerPed, GetHashKey('gadget_parachute'), 1, true, true)

		LocalPlayer.state:set('WingSuitType', data, true)
	end
end