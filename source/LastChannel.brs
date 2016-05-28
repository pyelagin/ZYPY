function EPG_DSP_lastChannel(o)
    
    '**** main pannel *****
    
    o.EPG_OBJ.lastWatched_Y =  o.EPG_OBJ.lastWatched_Y
    
    o.canvas.SetLayer(200, { Color: o.SKIN.SkinData.ChannelSectionBackgroudColor, CompositionMode: "Source", TargetRect:{x:60,y:o.EPG_OBJ.lastWatched_Y,w:1280,h:17} })
    lbl = {
             Text: "LAST VIEWED CHANNEL"
             TextAttrs:{Font:o.family_12,
                    HAlign:"Left", VAlign:"Top",
                    Color: o.SKIN.SkinData.ChannelSectionTextColor
                    Direction:"LeftToRight"}
                    TargetRect: {x:70, y:o.EPG_OBJ.lastWatched_Y, w:200, h:20}
             }
    
    o.canvas.SetLayer(201, lbl)
    
    chArr = []
    
    chArr.push({ Color: o.SKIN.SkinData.ChannelBackgroundColor, CompositionMode: "Source", TargetRect:{x:100,y:o.EPG_OBJ.lastWatched_Y+22,w:1280,h:39} })
    chArr.push({
                url: o.EPG_OBJ.LAST_CHANNEL.chImg,
                TargetRect: {x:60, y:o.EPG_OBJ.lastWatched_Y+22, w:162,h:39}
             })
             
    clr = o.SKIN.SkinData.ChannelProgramDefaultColor
    x = 225
    xPos = []
    pNum = 0    
    if(o.EPG_OBJ.LAST_CHANNEL.chPlayList <> invalid)
        
        for i = 0 to o.EPG_OBJ.LAST_CHANNEL.chPlayList.Count() - 1
        
            t = o.EPG_OBJ.LAST_CHANNEL.chPlayList[i].videoDuration
            width = calkProgWidth(t.ToInt())
            if(width > 0)
            
               if(o.UILEVEL = 0)
                    if(i = o.EPG_OBJ.programIndex) 
                        clr = o.SKIN.SkinData.ChannelSelectedProgramColor
                        activeTitle = o.EPG_OBJ.LAST_CHANNEL.chPlayList[i].videoTitle
                    else
                        clr = o.SKIN.SkinData.ChannelProgramColor
                    end if
                end if
            
                chArr.push({ Color: clr, CompositionMode: "Source", TargetRect:{x:x,y:o.EPG_OBJ.lastWatched_Y+22,w:width,h:39} })
                t = ""
                if(o.EPG_OBJ.LAST_CHANNEL.chPlayList[i].videoTitle <> invalid)
                    t = o.EPG_OBJ.LAST_CHANNEL.chPlayList[i].videoTitle
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
                            TargetRect: {x:x+5, y:o.EPG_OBJ.lastWatched_Y+33, w:width-10, h:20}
                     })
                xPos.push(x)
                pNum = i
                x = x + width + 3
            end if
           
         end for
        
        o.EPG_OBJ.LAST_CHANNEL.xPos = xPos
        o.EPG_OBJ.LAST_CHANNEL.pNum = pNum
   else 
        lb = {
             Text: "NO DATA",
             TextAttrs:{Font:o.family_16,
                    HAlign:"CENTER", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:590, y:o.EPG_OBJ.lastWatched_Y+33, w:100, h:20}
             }
        o.canvas.SetLayer(203,  lb)
   end if   
                 
   o.canvas.SetLayer(202,  chArr)
  
end function