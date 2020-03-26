 /*-------------------------------------------------------------------------------------------------------------------------
    chat.AddText([ Player ply,] Colour colour, string text, Colour colour, string text, ... )
    Returns: nil
    In Object: None
    Part of Library: chat
    Available On: Server
-------------------------------------------------------------------------------------------------------------------------*/if SERVER then
    chat = { }
    function chat.AddText( ... )if ( type( arg[1] ) == "Player" ) then ply = arg[1] end
        
        umsg.Start( "AddText", ply )
            umsg.Short( #arg )
            for _, v inpairs( arg ) doif ( type( v ) == "string" ) then
                    umsg.String( v )
                elseif ( type ( v ) == "table" ) then
                    umsg.Short( v.r )
                    umsg.Short( v.g )
                    umsg.Short( v.b )
                    umsg.Short( v.a )
                endend
        umsg.End( )
    endelse
    usermessage.Hook( "AddText", function( um )local argc = um:ReadShort( )
        local args = { }
        for i = 1, argc / 2, 1dotable.insert( args, Color( um:ReadShort( ), um:ReadShort( ), um:ReadShort( ), um:ReadShort( ) ) )
            table.insert( args, um:ReadString( ) )
        end
        
        chat.AddText( unpack( args ) )
    end )
end
