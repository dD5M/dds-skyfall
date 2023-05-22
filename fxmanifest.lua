fx_version 'adamant'

name 'dds-skyfall'
author 'daddyDUBZ'
description 'Wingsuit for use with ox_inventory/ox_lib'

game 'gta5'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}
