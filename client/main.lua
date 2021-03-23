-------------------------------------
-- Chat de Reports y Privado Staff --
--           por Jougito           --
-------------------------------------

local group = 'user'

Citizen.CreateThread(function()
    if Config.rActive then
        TriggerEvent('chat:addSuggestion', '/' .. Config.rCommand,  'Manda un reporte al staff', { { name = 'Mensaje', help = 'Mensaje de explicación detallado del reporte' } })
        TriggerEvent('chat:addSuggestion', '/' .. Config.inCommand,  'Muestra la información de un ticket', { { name = 'ID', help = 'ID del ticket' } })
        TriggerEvent('chat:addSuggestion', '/' .. Config.acCommand,  'Asigna un ticket a un staff', { { name = 'ID', help = 'ID del ticket' } })
        TriggerEvent('chat:addSuggestion', '/' .. Config.dnCommand,  'Quita la asignación de un ticket', { { name = 'ID', help = 'ID del ticket' } })
        TriggerEvent('chat:addSuggestion', '/' .. Config.dlCommand,  'Cierra un ticket', { { name = 'ID', help = 'ID del ticket' } })
    end

    if Config.sActive then
        TriggerEvent('chat:addSuggestion', '/' .. Config.sCommand,  'Manda un mensaje en el chat de staff', { { name = 'Mensaje', help = 'Mensaje que quieres enviar al chat de staff (Solo uso para Staff)' } })
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Refresh group

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        local pId = GetPlayerServerId(PlayerId())

        TriggerServerEvent('StaffChat:sGroup', pId)
        Citizen.Wait(60 * 1000)
	end
end)

RegisterNetEvent('StaffChat:uGroup')
AddEventHandler('StaffChat:uGroup', function(uGroup)
    group = uGroup
end)

-- Reportes

RegisterNetEvent('rc:Message')
AddEventHandler('rc:Message', function(uID, uName, args, tId)

    local sId = PlayerId()
    local pId = GetPlayerFromServerId(uID)
    
    if pId == sId then
        TriggerEvent('chat:addMessage', { args = { "[".. Label.Report .." - " .. tId .. "] ".. uName .." (".. uID ..")", "^7".. args .."" }, color = Color.Report })
    elseif group ~= 'user' and pId ~= sId then
        TriggerEvent('chat:addMessage', { args = { "[".. Label.Report .." - " .. tId .. "] ".. uName .." (".. uID ..")", "^7".. args .."" }, color = Color.Report })
    end

end)

RegisterNetEvent('rc:Ticket')
AddEventHandler('rc:Ticket', function(uID, iText)

    local sId = PlayerId()
    local pId = GetPlayerFromServerId(uID)
    
    if pId == sId then
        TriggerEvent('chat:addMessage', { args = iText, color = Color.Report })
    elseif group ~= 'user' and pId ~= sId then
        TriggerEvent('chat:addMessage', { args = iText, color = Color.Report })
    end

end)

-- Radio Staff

RegisterNetEvent('rs:Message')
AddEventHandler('rs:Message', function(uID, uName, args)

    local sId = PlayerId()
    local pId = GetPlayerFromServerId(uID)
    
    if pId == sId then
        TriggerEvent('chat:addMessage', { args = { "[".. Label.Staff .."] ".. uName .." (".. uID ..")", "^7".. args .."" }, color = Color.Staff })
    elseif group ~= 'user' and pId ~= sId then
        TriggerEvent('chat:addMessage', { args = { "[".. Label.Staff .."] ".. uName .." (".. uID ..")", "^7".. args .."" }, color = Color.Staff })
    end

end)
