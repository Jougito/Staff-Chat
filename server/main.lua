-------------------------------------
-- Chat de Reports y Privado Staff --
--           por Jougito           --
-------------------------------------

if Config.rActive then

    RegisterCommand(Config.rCommand, function(source, args, rawCommand)

        args = table.concat(args, ' ')

        local uID = source
        local uName = GetPlayerName(uID)

        TriggerClientEvent("rc:Message", -1, uID, uName, args)

    end, false)

end

if Config.sActive then

    RegisterCommand(Config.sCommand, function(source, args, rawCommand)

        args = table.concat(args, ' ')

        local uID = source
        local uName = GetPlayerName(uID)
        local uGroup = GetIdentity(uID)

        if uGroup.group ~= 'user' then
            TriggerClientEvent("rs:Message", -1, uID, uName, args)
        else
           TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7No tienes permisos para hablar por este chat" }, color = Color.Staff })
        end

    end, false)

end

-- Funciones

function GetIdentity(source)

    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    
    if result[1] ~= nil then
    
        local identity = result[1]

        return {
            identifier = identity['identifier'],
            name = identity['name'],
            firstname = identity['firstname'],
            lastname = identity['lastname'],
            dateofbirth = identity['dateofbirth'],
            sex = identity['sex'],
            height = identity['height'],
            job = identity['job'],
            group = identity['group']
        }
    else
        return nil
    end
end

-- Version Checking - DON'T TOUCH THIS

local CurrentVersion = '1.0.2'
local GithubResourceName = 'Staff-Chat'

PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)
    PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGELOG', function(Error, Changes, Header)
        print('^0')
        print('^6[Staff Chat]^0 Checking for updates...')
        print('^0')
        print('^6[Staff Chat]^0 Current version: ^5' .. CurrentVersion .. '^0')
        print('^6[Staff Chat]^0 Updater version: ^5' .. NewestVersion .. '^0')
        print('^0')
        if CurrentVersion ~= NewestVersion then
            print('^6[Staff Chat]^0 Your script is ^8outdated^0!')
            print('^0')
            print('^6[Staff Chat] ^3CHANGELOG ^5' .. NewestVersion .. ':^0')
            print('^3')
            print(Changes)
            print('^0')
            print('^6[Staff Chat]^0 You ^8are not^0 running the newest stable version of ^5Staff Chat^0. Please update: https://github.com/Jougito/Staff-Chat')
        else
            print('^6[Staff Chat]^0 Your script is ^2up to update^0')
        end
        print('^0')
    end)
end)
