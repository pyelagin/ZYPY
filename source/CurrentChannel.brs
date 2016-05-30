
function EPG_DSP_currentChannel(o)

    '**** main pannel *****
    if(o.EPG_OBJ.PLAYER_MOD = "min")
    
        o.EPG_OBJ.ch_title = {
                 Text: o.EPG_OBJ.CURRENT_CHANNEL.chName
                 TextAttrs:{Font:o.family_43,
                        HAlign:"Right", VAlign:"Top",
                        Color: o.SKIN.SkinData.ChannelNameColor
                        Direction:"LeftToRight"}
                        TargetRect: {x:675, y:50, w:500, h:50}
                 }    
        o.canvas.SetLayer(14, o.EPG_OBJ.ch_title)
    
        o.EPG_OBJ.ch_icon = {
                url: o.EPG_OBJ.CURRENT_CHANNEL.chThumb,
                TargetRect: {x:1055, y:120 ,w:112,h:109}
             }
        o.canvas.SetLayer(15, o.EPG_OBJ.ch_icon)
        
        o.EPG_OBJ.ch_sub = {
                 Text: o.EPG_OBJ.CURRENT_CHANNEL.chDesc
                 TextAttrs:{Font:o.family_32,
                        HAlign:"Right", VAlign:"Top",
                        Color: o.SKIN.SkinData.ChannelDescriptionColor
                        Direction:"LeftToRight"}
                        TargetRect: {x:430, y:110, w:600, h:50}
                 }   
        o.canvas.SetLayer(16, o.EPG_OBJ.ch_sub)
        
        o.EPG_OBJ.pr_title = {
                 Text: o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[o.EPG_OBJ.LAST_CHANNEL_PRG_INDEX].videoTitle
                 TextAttrs:{Font:o.family_25,
                        HAlign:"Right", VAlign:"Top",
                        Color: o.SKIN.SkinData.ProgramNameColor
                        Direction:"LeftToRight"}
                        TargetRect: {x:430, y:170, w:600, h:50}
                 } 
        o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
    
    end if
    
    x = 225
    xPos = []
    pNum = 0
    for i = 0 to o.EPG_OBJ.CURRENT_CHANNEL.chPlayList.Count() - 1
    
        t = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoDuration
        width = calkProgWidth(t.ToInt())
        if(width > 0)
            xPos.push(x)
            pNum = i
            x = x + width + 3
        end if
    
    end for
    
    o.EPG_OBJ.CURRENT_CHANNEL.xPos = xPos
    o.EPG_OBJ.CURRENT_CHANNEL.pNum = pNum 

end function