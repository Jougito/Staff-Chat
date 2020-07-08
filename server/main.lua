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

local CurrentVersion = '1.0.1'
local GithubResourceName = 'Staff-Chat'

PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)
    PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGELOG', function(Error, Changes, Header)
        print('\n')
        print('[Staff Chat] Checking for updates...')
        print('')
        print('[Staff Chat] Current version: ' .. CurrentVersion)
        print('[Staff Chat] Updater version: ' .. NewestVersion)
        print('')
        if CurrentVersion ~= NewestVersion then
            print('[Staff Chat] Your script is outdated!')
            print('')
            print('[Staff Chat] CHANGELOG ' .. NewestVersion .. ':')
            print('')
            print(Changes)
            print('')
            print('[Staff Chat] You are not running the newest stable version of Staff Chat. Please update: https://github.com/Jougito/Staff-Chat')
        else
            print('[Staff Chat] Your script is up-to-update')
        end
        print('\n')
    end)
end)
