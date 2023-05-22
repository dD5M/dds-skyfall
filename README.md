# dds-skyfall
Wingsuits for your FiveM server.  A more realistic, and FREE implementation of wingsuits.

# Discord for more releases and support [dDStudio] https://discord.gg/P9ZzdzYaqm

# Instructions
Deploy the items to ox_inventory data/items.lua.  Use the item, and jump from somewhere high.  Have fun!

# Config
Configure your desired outfit to change into when item is used.  Wing suit webbing is included in stream folder as replacement vest.  Blacklist in your respective character customization.

# Admin Skyfall
Admins can use the command /skyfall command to initiate skyfall with or without wingsuit wardrobe.

# ox_inventory
		["wingsuit"] = {
			label = "Vibrant Wingsuit",
			weight = 500,
			stack = false,
			close = true,
			description = "Fancy Wingsuit",
			consume = 1,
			client = {
				export = 'dds-skyfall.wingsuit',
				image = "",
			},
		},

		["wingsuit2"] = {
			label = "Blackout Wingsuit",
			weight = 500,
			stack = false,
			close = true,
			description = "Fancy Wingsuit",
			consume = 1,
			client = {
				export = 'dds-skyfall.wingsuit2',
				image = "",
			},
		},
