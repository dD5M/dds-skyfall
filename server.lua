lib.addCommand('skyfall', {
    help = 'Skyfall (god)',
	restricted = "qbox.admin",
}, function(source)
    TriggerClientEvent('dds-skyfall:AdminFall', source)
end)

lib.addCommand('packwingsuit', {
    help = 'Repack Wingsuit',

}, function(source)
    TriggerClientEvent('dds-skyfall:client:RemoveWingsuit', source)
end)

lib.addCommand('resetwingsuit', {
    help = 'Pack Wingsuit Parachute',

}, function(source)
    TriggerClientEvent('dds-skyfall:client:ResetWingsuit', source)
end)

lib.callback.register('dds-skyfall:ReturnWingsuit', function(source)
    item = Player(source).state.WingSuitType
	exports.ox_inventory:AddItem(source, item, 1, nil, nil, cb)
	TriggerClientEvent("illenium-appearance:client:reloadSkin", source)
    Player(source).state:set('WingSuitType', nil, true)
	return cb
end)
