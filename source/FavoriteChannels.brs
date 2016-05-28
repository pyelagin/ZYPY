
function FavoriteChannels(o)

    o.EPG_OBJ.favorites_Y = o.EPG_OBJ.favorites_Y
    
    total_num = o.EPG_OBJ.FAVORITE_CHANNELS.Count()
    current_num = o.EPG_OBJ.FAVORITE_CHANNELS_INDEX + 1
    
    o.canvas.SetLayer(500, { Color: o.SKIN.SkinData.ChannelSectionBackgroudColor, CompositionMode: "Source", TargetRect:{x:60,y:o.EPG_OBJ.favorites_Y,w:1280,h:17} })
    lbl = {
             Text: "FAVORITE ( " + current_num.ToStr() + " of " + total_num.ToStr() + " )"
             TextAttrs:{Font:o.family_12,
                    HAlign:"Left", VAlign:"Top",
                    Color: o.SKIN.SkinData.ChannelSectionTextColor
                    Direction:"LeftToRight"}
                    TargetRect: {x:70, y:o.EPG_OBJ.favorites_Y, w:100, h:20}
             }
    
    o.canvas.SetLayer(501, lbl)
    
    chArr = []
    
    chArr.push({ Color: o.SKIN.SkinData.ChannelBackgroundColor, CompositionMode: "Source", TargetRect:{x:100,y:o.EPG_OBJ.favorites_Y+22,w:1280,h:39} })
    chArr.push({
                url: o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX].chImg,
                TargetRect: {x:60, y:o.EPG_OBJ.favorites_Y+22, w:162,h:39}
             })
             
    clr = o.SKIN.SkinData.ChannelProgramDefaultColor
    x = 225
    xPos = []
    pNum = 0
    if(o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX].chPlayList <> invalid)
    
        for i = 0 to o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX].chPlayList.Count() - 1
        
             t = o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX].chPlayList[i].videoDuration
             width = calkProgWidth(t.ToInt())
             
             if(width > 0)
             
                if(o.UILEVEL = 1)
                    if(i = o.EPG_OBJ.programIndex) 
                        clr = o.SKIN.SkinData.ChannelSelectedProgramColor
                        activeTitle = o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX].chPlayList[i].videoTitle
                    else
                        clr = o.SKIN.SkinData.ChannelProgramColor
                    end if
                end if
             
                chArr.push({ Color: clr, CompositionMode: "Source", TargetRect:{x:x,y:o.EPG_OBJ.favorites_Y+22,w:width,h:39} })
                t = ""
                if(o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX].chPlayList[i].videoTitle <> invalid)
                    t = o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX].chPlayList[i].videoTitle
                end if
                
                s = shrinkText(o, t, width-10)
                if(Len(s) = 0) s = "."
                chArr.push({
                    Text: s,
                    TextAttrs:{Font:o.family_14,
                        HAlign:"Left", VAlign:"Top",
                        Color: o.SKIN.SkinData.ChannelTextColor
                        Direction:"LeftToRight"}
                        TargetRect: {x:x+5, y:o.EPG_OBJ.favorites_Y+33, w:width-10, h:20}
                 })
                xPos.push(x)
                pNum = i
                x = x + width + 3
             
             end if
             
             o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX].xPos = xPos
             o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX].pNum = pNum
             'y = y + 39 + 5
             
        end for
    
    end if
             
    o.canvas.SetLayer(502,  chArr)

end function

function FavoriteChannels_2(o)

    o.EPG_OBJ.favorites_Y = o.EPG_OBJ.favorites_Y
    
    total_num = o.EPG_OBJ.FAVORITE_CHANNELS.Count()
    current_num = o.EPG_OBJ.FAVORITE_CHANNELS_INDEX + 1
    
    o.canvas.SetLayer(500, { Color: o.SKIN.SkinData.ChannelSectionBackgroudColor, CompositionMode: "Source", TargetRect:{x:60,y:o.EPG_OBJ.favorites_Y,w:1280,h:17} })
    
    '( " + current_num.ToStr() + " of " + total_num.ToStr() + " )
    
    lbl = {
             Text: "FAVORITE"
             TextAttrs:{Font:o.family_12,
                    HAlign:"Left", VAlign:"Top",
                    Color: o.SKIN.SkinData.ChannelSectionTextColor
                    Direction:"LeftToRight"}
                    TargetRect: {x:70, y:o.EPG_OBJ.favorites_Y, w:100, h:20}
             }
    
    o.canvas.SetLayer(501, lbl)
    
    chArr = []
    
    chArr.push({ Color: o.SKIN.SkinData.ChannelBackgroundColor, CompositionMode: "Source", TargetRect:{x:60,y:o.EPG_OBJ.favorites_Y+22,w:1280,h:39} })
    
    clr = o.SKIN.SkinData.ChannelProgramDefaultColor
    x = 60
    
    for i = 0 to o.EPG_OBJ.FAVORITE_CHANNELS.Count() - 1
    
         chArr.push({
                url: o.EPG_OBJ.FAVORITE_CHANNELS[i].chImg,
                TargetRect: {x:x, y:o.EPG_OBJ.favorites_Y+22, w:162,h:39}
             })
         
         if(i = o.EPG_OBJ.FAVORITE_CHANNELS_INDEX and o.UILEVEL = 1)
         
            fav_frame = {
                url: "pkg:/images/fav_frame.png"
                TargetRect: {x:x-5, y:o.EPG_OBJ.favorites_Y+22-5, w:172,h:49}
             }
            o.canvas.SetLayer(599,  fav_frame)
         
         end if
         
         if(o.UILEVEL <> 1) o.canvas.ClearLayer(599)
         
         x = x + 162 + 5
    end for
    
    o.canvas.SetLayer(502,  chArr)

end function

function showFavoritesMenu(o)

    arr = []
    arr.push({ Color: "#BA000000", CompositionMode: "Source_Over", TargetRect:{x:520,y:407,w:300,h:200} })
    
    clr = o.SKIN.SkinData.ChannelProgramDefaultColor
    if(o.EPG_OBJ.SELECT_MENU_INDEX = 0) clr = o.SKIN.SkinData.ChannelSelectedProgramColor
    arr.push({ Color: clr, CompositionMode: "Source", TargetRect:{x:540,y:450,w:260,h:30} })
    arr.push({
             Text: "SELECT"
             TextAttrs:{Font:o.family_18,
                    HAlign:"Center", VAlign:"Center",
                    Direction:"LeftToRight"}
                    TargetRect: {x:540, y:452, w:260, h:30}
             })
    
    txt = "ADD TO FAVORITES"
    if(o.UILEVEL = 1)
        txt = "REMOVE FROM FAVORITES"
    end if
    
    clr = o.SKIN.SkinData.ChannelProgramDefaultColor
    if(o.EPG_OBJ.SELECT_MENU_INDEX = 1) clr = o.SKIN.SkinData.ChannelSelectedProgramColor
    arr.push({ Color: clr, CompositionMode: "Source", TargetRect:{x:540,y:490,w:260,h:30} })
    arr.push({
             Text: txt
             TextAttrs:{Font:o.family_18,
                    HAlign:"Center", VAlign:"Center",
                    Direction:"LeftToRight"}
                    TargetRect: {x:540, y:492, w:260, h:30}
             })
             
             
    clr = o.SKIN.SkinData.ChannelProgramDefaultColor 
    if(o.EPG_OBJ.SELECT_MENU_INDEX = 2) clr = o.SKIN.SkinData.ChannelSelectedProgramColor
    arr.push({ Color: clr, CompositionMode: "Source", TargetRect:{x:540,y:530,w:260,h:30} })
    arr.push({
             Text: "CANCEL"
             TextAttrs:{Font:o.family_18,
                    HAlign:"Center", VAlign:"Center",
                    Direction:"LeftToRight"}
                    TargetRect: {x:540, y:532, w:260, h:30}
             })
             
    o.canvas.SetLayer(600,arr)

end function

function addToFavorites(o)
    o.EPG_OBJ.FAVORITE_CHANNELS.push(o.EPG_OBJ.channels[o.EPG_OBJ.CHANNEL_INDEX])
    if(o.EPG_OBJ.FAVORITE_CHANNELS.Count() > 0)
        'o.EPG_OBJ.FAVORITE_CHANNELS_INDEX = o.EPG_OBJ.FAVORITE_CHANNELS.Count() - 1
    end if
    saveFavorites(o)
end function

function removeFromFavorites(o)

    t = o.EPG_OBJ.FAVORITE_CHANNELS.Delete(o.EPG_OBJ.FAVORITE_CHANNELS_INDEX)
    o.EPG_OBJ.FAVORITE_CHANNELS_INDEX = 0
    
    print "TOTAL LEFT : "; o.EPG_OBJ.FAVORITE_CHANNELS.Count()
    
    if(o.EPG_OBJ.FAVORITE_CHANNELS.Count() > 0)
        o.UILEVEL = 1
        DSP_Channels(o)
    else 
        o.UILEVEL = 2
        DSP_Channels(o)
    end if
    
    saveFavorites(o)
    
end function

function saveFavorites(o)

    print "REG WRITE"

    idList = ""
    
    for i = 0 to o.EPG_OBJ.FAVORITE_CHANNELS.Count() - 1
        if(Len(idList) > 0) idList = idList + ","
        idList = idList + o.EPG_OBJ.FAVORITE_CHANNELS[i].chID.ToStr()
    end for
    
    RegWrite("Favorite",idList,"ZYPY")

end function

function loadFavorites(o)
    
    idList = RegRead("Favorite","ZYPY")
    
    print "ID LIST: "; idList
    if(idList <> invalid)
        HTTP_getFavorites(o, idList)
    end if
    
end function