resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
dependency "vrp"

server_scripts {
	'@vrp/lib/utils.lua',
	'config.lua',
	'server.lua',
}

client_scripts {
	'@vrp/client/Tunnel.lua',
	'config.lua',
	'client.lua',
}