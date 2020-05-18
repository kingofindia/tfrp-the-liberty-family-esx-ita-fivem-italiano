resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


client_script 'client/client.lua'

server_scripts {

	'server/server.lua',
	'@mysql-async/lib/MySQL.lua'
} 

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/app.js',
	'html/font/edosz.ttf',
	'html/img/bg/moon.png',
	'html/img/icon_money/bank.png',
	'html/img/icon_money/gold.png',
	'html/img/icon_money/offshore.png',
	'html/img/icon_money/ripple.png',
	'html/img/icon_money/society.png',
	'html/img/icon_money/wallet.png',
	'html/img/bg/wallet.png',
	'html/img/bg/legitimation.png',
	'html/img/bg/kreditkort.png',
	'html/img/bg/500kr.jpg',
}