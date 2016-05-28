
function EPG_DSP_channels_2(o)

    'o.EPG_OBJ.channels_Y + 20 + 10
    y = o.EPG_OBJ.channels_Y
    
    print "CHANNES Y : "; y
    
    y = o.EPG_OBJ.channels_Y
    
    o.canvas.SetLayer(300, { Color: o.SKIN.SkinData.ChannelSectionBackgroudColor, CompositionMode: "Source", TargetRect:{x:60,y:y,w:1280,h:17} })
    lbl = {
             Text: "FEATURED"
             TextAttrs:{Font:o.family_12,
                    HAlign:"Left", VAlign:"Top",
                    Color: o.SKIN.SkinData.ChannelSectionTextColor
                    Direction:"LeftToRight"}
                    TargetRect: {x:70, y:y, w:100, h:20}
             }
    o.canvas.SetLayer(301, lbl)
    
    y = y + 17 + 5
    
    chArr = []
    limit = 0
    if(o.EPG_OBJ.LAST_CHANNEL.chPlayList <> invalid and o.EPG_OBJ.FAVORITE_CHANNELS.Count() > 0)
        print "#1"
        limit = 3
        o.EPG_OBJ.CHANNEL_LIMIT = limit
    else if(o.EPG_OBJ.LAST_CHANNEL.chPlayList <> invalid or o.EPG_OBJ.FAVORITE_CHANNELS.Count() > 0)
        print "#2"
        limit = 4
        o.EPG_OBJ.CHANNEL_LIMIT = limit
    else if(o.EPG_OBJ.LAST_CHANNEL.chPlayList = invalid and o.EPG_OBJ.FAVORITE_CHANNELS.Count() = 0)
        if(o.EPG_OBJ.channels.Count() > 5)
            print "#3"
            limit = 5
            o.EPG_OBJ.CHANNEL_LIMIT = limit
        else
            print "#4"
            limit = o.EPG_OBJ.channels.Count() - 1
            o.EPG_OBJ.CHANNEL_LIMIT = limit
        end if
    end if
    
    
    for i = 0 to limit
    
        chArr.push({ Color: o.SKIN.SkinData.ChannelBackgroundColor, CompositionMode: "Source", TargetRect:{x:60,y:y,w:1280,h:39} })
        chArr.push({
                url: o.EPG_OBJ.channels[i].chImg,
                TargetRect: {x:60, y:y, w:162,h:39}
             })
             
        clr = o.SKIN.SkinData.ChannelProgramDefaultColor
        x = 225
        xPos = []
        pNum = 0
        for j = 0 to o.EPG_OBJ.channels[i].chPlayList.Count() - 1
        
            t = o.EPG_OBJ.channels[i].chPlayList[j].videoDuration
            width = calkProgWidth(t.ToInt())
            
            if(width > 0)
                'print "PROG WIDTH : "; width
                
                if(o.UILEVEL = 2)
                    if(i = o.EPG_OBJ.CHANNEL_INDEX and j = o.EPG_OBJ.programIndex) 
                        clr = o.SKIN.SkinData.ChannelSelectedProgramColor
                        activeTitle = o.EPG_OBJ.channels[i].chPlayList[j].videoTitle
                    else if(i = o.EPG_OBJ.CHANNEL_INDEX and (j > o.EPG_OBJ.programIndex or j < o.EPG_OBJ.programIndex)) 
                        clr = o.SKIN.SkinData.ChannelProgramColor
                    end if
                end if
                
                chArr.push({ Color: clr, CompositionMode: "Source", TargetRect:{x:x,y:y,w:width,h:39} })
                t = ""
                if(o.EPG_OBJ.channels[i].chPlayList[j].videoTitle <> invalid)
                    t = o.EPG_OBJ.channels[i].chPlayList[j].videoTitle
                end if
                'if(width < 70) t = t.Left(1)
                'if(width > 70 and width < 100) t = truncateText(5, t)
                'if(width < 20) t = "."
                'if(width < 200) t = truncateText(20, t)
                s = shrinkText(o, t, width-10)
                if(Len(s) = 0) s = "."
                chArr.push({
                    Text: s,
                    TextAttrs:{Font:o.family_14,
                        HAlign:"Left", VAlign:"Top",
                        Color: o.SKIN.SkinData.ChannelTextColor
                        Direction:"LeftToRight"}
                        TargetRect: {x:x+5, y:y+11, w:width-10, h:20}
                 })
                xPos.push(x)
                pNum = j
                x = x + width + 3
               
            end if
            
        end for
        o.EPG_OBJ.channels[i].xPos = xPos
        o.EPG_OBJ.channels[i].pNum = pNum
        y = y + 39 + 5
        
    end for
    
    o.EPG_OBJ.playhead.TargetRect.h = y - 350
    
    o.canvas.SetLayer(31, o.EPG_OBJ.playhead)
    
    o.canvas.SetLayer(302,  chArr)

end function

function calkProgWidth(time)

    '250 - 30min
    'x - time
    'x = 250*time/30
    
    '1500 - X
    '
    
    min = Fix(time / 60)
    
    r = Fix((1500 * min) / 30)
    
    return r

end function

function shrinkText(o, tstr, width)
    twidth = 0
    outstr = ""
    'print "-----------------------"
    for i = 0 to Len(tstr) - 1
        ch = tstr.Mid(i,1)
        twidth = twidth + 6
        'print "TWIDTH : "; twidth
        'print "WIDTH : "; width
        if(twidth < width)
            outstr = outstr + ch
        else
            'print "BREAK"
            exit for
        end if
    end for
    'print "-----------------------"
    return outstr
end function

