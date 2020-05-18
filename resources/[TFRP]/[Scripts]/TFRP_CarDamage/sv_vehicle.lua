--[[------------------------------------------------------------------------
	Fix Vehicle 
------------------------------------------------------------------------]]--
AddEventHandler( 'chatMessage', function( source, n, message )
    if ( message == "/testFixCommandKingRichOnlyPRV1" ) then 
    	CancelEvent()
        TriggerClientEvent( 'wk:fixVehicle', source )
    end 
end )