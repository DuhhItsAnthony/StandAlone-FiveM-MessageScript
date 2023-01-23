fx_version 'cerulean'
game 'gta5'

description 'MessageScript'
version '1.0.0'

lua54 'yes' -- Add in case you want to use lua 5.4 (https://www.lua.org/manual/5.4/manual.html)

shared_script { 
    'messagescript-config.lua',
}

client_scripts {
    'messagescript-c.lua'
}

server_scripts {
    'messagescript-s.lua'
}

