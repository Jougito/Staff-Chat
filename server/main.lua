-------------------------------------
-- Chat de Reports y Privado Staff --
--           por Jougito           --
-------------------------------------

local nTicket = 0
local Tickets = {}

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

if Config.rActive then

    RegisterCommand(Config.rCommand, function(source, args, rawCommand)

        args = table.concat(args, ' ')

        local uID = source
        local uName = GetPlayerName(uID)

        if args ~= "" then
            nTicket = nTicket + 1
            Tickets['tck' .. nTicket] = {id = nTicket, name = uName, assigned = 0, aName = nil, closed = 0, cName = nil}
            TriggerClientEvent('rc:Message', -1, uID, uName, args, nTicket)
        end

    end, false)

    RegisterCommand(Config.inCommand, function(source, args, rawCommand)

        args = table.concat(args, ' ')

        local uID = source
        local xPlayer = ESX.GetPlayerFromId(uID)
        local uGroup = xPlayer.getGroup()

        if args ~= "" then
            if uGroup ~= 'user' and uGroup ~= nil then
                if Tickets['tck' .. args] then
                    if Tickets['tck' .. args].assigned == 0 and Tickets['tck' .. args].aName == nil then
                        if Tickets['tck' .. args].closed == 0 and Tickets['tck' .. args].cName == nil then
                            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7Ticket ^2" .. args .. " ^7enviado por ^2" .. Tickets['tck' .. args].name .. " ^7está sin asignar y sin cerrar"}, color = Color.Report })
                        elseif Tickets['tck' .. args].closed == 1 and Tickets['tck' .. args].cName ~= nil then
                            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7Ticket ^2" .. args .. " ^7enviado por ^2" .. Tickets['tck' .. args].name .. " ^7está sin asignar y cerrado por ^2 " .. Tickets['tck' .. args].cName}, color = Color.Report })
                        else
                            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7No se ha podido obtener la información del ticket" }, color = Color.Report })
                        end
                    elseif Tickets['tck' .. args].assigned == 1 and Tickets['tck' .. args].aName ~= nil then
                        if Tickets['tck' .. args].closed == 0 and Tickets['tck' .. args].cName == nil then
                            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7Ticket ^2" .. args .. " ^7enviado por ^2" .. Tickets['tck' .. args].name .. " ^7está asignado a ^2" .. Tickets['tck' .. args].aName .. " ^7y sin cerrar"}, color = Color.Report })
                        elseif Tickets['tck' .. args].closed == 1 and Tickets['tck' .. args].cName ~= nil then
                            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7Ticket ^2" .. args .. " ^7enviado por ^2" .. Tickets['tck' .. args].name .. " ^7está asignado a ^2" .. Tickets['tck' .. args].aName .. " ^7y cerrado por ^2" .. Tickets['tck' .. args].cName}, color = Color.Report })
                        else
                            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7No se ha podido obtener la información del ticket" }, color = Color.Report })
                        end
                    else
                        TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7No se ha podido obtener la información del ticket" }, color = Color.Report })
                    end
                else
                    TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7No se ha encontrado el ticket" }, color = Color.Report })
                end
            else
                TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7No tienes permisos para usar este comando" }, color = Color.Report })
            end
        end

    end, false)

    RegisterCommand(Config.acCommand, function(source, args, rawCommand)

        args = table.concat(args, ' ')

        local uID = source
        local xPlayer = ESX.GetPlayerFromId(uID)
        local uName = GetPlayerName(uID)
        local uGroup = xPlayer.getGroup()

        if args ~= "" then
            if uGroup ~= 'user' and uGroup ~= nil then
                if Tickets['tck' .. args] then
                    if Tickets['tck' .. args].assigned == 0 and Tickets['tck' .. args].aName == nil then
                        Tickets['tck' .. args].assigned = 1
                        Tickets['tck' .. args].aName = uName
                        iText = { "[".. Label.Report .."]", "^7Ticket ^2" .. args .. " ^7asignado a ^2" .. uName}
                        TriggerClientEvent('rc:Ticket', -1, uID, iText)
                    else
                        TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7Ese ticket ya ha sido asignado a ^2" .. Tickets['tck' .. args].aName}, color = Color.Report })
                    end
                else
                    TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7No se ha encontrado el ticket" }, color = Color.Report })
                end
            else
                TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7No tienes permisos para usar este comando" }, color = Color.Report })
            end
        end

    end, false)

    RegisterCommand(Config.dnCommand, function(source, args, rawCommand)

        args = table.concat(args, ' ')

        local uID = source
        local xPlayer = ESX.GetPlayerFromId(uID)
        local uGroup = xPlayer.getGroup()

        if args ~= "" then
            if uGroup ~= 'user' and uGroup ~= nil then
                if Tickets['tck' .. args] then
                    if Tickets['tck' .. args].assigned == 1 and Tickets['tck' .. args].aName ~= nil then
                        Tickets['tck' .. args].assigned = 0
                        Tickets['tck' .. args].aName = nil
                        iText = { "[".. Label.Report .."]", "^7Ticket ^2" .. args .. " ^7ya no está asignado a nadie"}
                        TriggerClientEvent('rc:Ticket', -1, uID, iText)
                    else
                        TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7Ese ticket no está asignado a nadie"}, color = Color.Report })
                    end
                else
                    TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7No se ha encontrado el ticket" }, color = Color.Report })
                end
            else
                TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7No tienes permisos para usar este comando" }, color = Color.Report })
            end
        end

    end, false)

    RegisterCommand(Config.dlCommand, function(source, args, rawCommand)

        args = table.concat(args, ' ')

        local uID = source
        local xPlayer = ESX.GetPlayerFromId(uID)
        local uName = GetPlayerName(uID)
        local uGroup = xPlayer.getGroup()

        if args ~= "" then
            if uGroup ~= 'user' and uGroup ~= nil then
                if Tickets['tck' .. args] then
                    Tickets['tck' .. args].closed = 1
                    Tickets['tck' .. args].cName = uName
                    iText = { "[".. Label.Report .."]", "^7Ticket ^2" .. args .. " ^7ha sido cerrado por ^2" .. uName}
                    TriggerClientEvent('rc:Ticket', -1, uID, iText)
                else
                    TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7No se ha encontrado el ticket" }, color = Color.Report })
                end
            else
                TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Report .."]", "^7No tienes permisos para usar este comando" }, color = Color.Report })
            end
        end

    end, false)

end

if Config.sActive then

    RegisterCommand(Config.sCommand, function(source, args, rawCommand)

        args = table.concat(args, ' ')

        local uID = source
        local xPlayer = ESX.GetPlayerFromId(uID)
        local uName = GetPlayerName(uID)
        local uGroup = xPlayer.getGroup()

        if args ~= "" then
            if uGroup ~= 'user' and uGroup ~= nil then
                TriggerClientEvent('rs:Message', -1, uID, uName, args)
            else
                TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7No tienes permisos para hablar por este chat" }, color = Color.Staff })
            end
        end

    end, false)

end

RegisterServerEvent('StaffChat:sGroup')
AddEventHandler('StaffChat:sGroup', function(uID)
    local xPlayer = ESX.GetPlayerFromId(uID)
    local uGroup = xPlayer.getGroup()

    TriggerClientEvent('StaffChat:uGroup', uID, uGroup)
end)

-- Version Checking - DON'T TOUCH THIS

local CurrentVersion = '1.0.4'
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
