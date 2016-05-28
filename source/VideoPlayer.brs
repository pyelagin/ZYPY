
function VideoPlayer(o, port, url)

    print "VIDEO PLAYER RUNNING ";
    
    o.VideoPlayer = CreateObject("roVideoPlayer")
    o.VideoPlayer.SetMaxVideoDecodeResolution(1280, 720)
    o.VideoPlayer.SetLoop(false)
    
    streamformat = "MP4"
    
    urlArr = url
    bitratesArr = [0]
    qualityArr = ["SD"]
    
    videoData = CreateObject("roAssociativeArray")
    videoData = CreateObject("roAssociativeArray")
    videoData.StreamBitrates = bitratesArr
    videoData.StreamUrls = urlArr
    videoData.StreamQualities = qualityArr
    videoData.StreamFormat = StreamFormat
    targetrect = { x:o.VIDEO_OBJ.x, y:o.VIDEO_OBJ.y, w:o.VIDEO_OBJ.w, h:o.VIDEO_OBJ.h }
    
    o.VideoPlayer.SetMessagePort(port)
    o.VideoPlayer.SetDestinationRect(targetrect)
    o.VideoPlayer.addContent(videoData)
    
    o.VideoPlayer.SetPositionNotificationPeriod(3)
    o.VideoPlayer.GetPlaybackDuration()
    
    o.VideoPlayer.Play()
    
    o.EPG_OBJ.currentURL = url

end function

function BACK(o)
    o.EPG_OBJ.PLAYER_MOD = "min"
    o.timer_fullview.Mark()
    EPG_UI(o, port)
end function

function showBar(o, prm)

    y = 550
    
    if(prm = "show")
    
       ch_icon = {
            url: o.EPG_OBJ.CURRENT_CHANNEL.chThumb,
            TargetRect: {x:30, y:590 ,w:100,h:97}
         }
        o.canvas.SetLayer(998,  ch_icon)
        
        o.canvas.SetLayer(999, { Color: "#AA000000", CompositionMode: "Source", TargetRect: {x:30, y:y+40 ,w:1220,h:100}})
        o.canvas.SetLayer(1000, { Color: "#ffffff", CompositionMode: "Source", TargetRect: {x:40, y:y+50 ,w:1200,h:3}})
        o.canvas.SetLayer(1001, { Color: "#ffffff", CompositionMode: "Source", TargetRect: {x:42+o.VIDEO_OBJ.PLAYHEAD_X, y:y+44 ,w:3,h:15}})
        endlb = {
                    Text: gmdate(o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[o.EPG_OBJ.CURRENT_CHANNEL_PRG_INDEX].videoDuration.ToInt()),
                    TextAttrs:{Font:o.family_12,
                        HAlign:"Right", VAlign:"Top",
                        Direction:"LeftToRight"}
                        TargetRect: {x:1210, y:y+53, w:30, h:20}
                 }
        o.canvas.SetLayer(1002,  endlb)
        lb = {
                Text: gmdate(o.VIDEO_OBJ.CURRENT_PLAYTIME),
                TextAttrs:{Font:o.family_12,
                    HAlign:"Left", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:42+o.VIDEO_OBJ.PLAYHEAD_X+8, y:y+35, w:30, h:20}
             }
        o.canvas.SetLayer(1003,  lb)
         
        
        
        info = []
        info.push({
                Text: o.EPG_OBJ.CURRENT_CHANNEL.chNum,
                TextAttrs:{Font:o.family_16,
                    HAlign:"Left", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:100, y:y+35+40, w:30, h:20}
             })
        info.push({
                Text: o.EPG_OBJ.CURRENT_CHANNEL.chName  + ": " + o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[o.EPG_OBJ.LAST_CHANNEL_PRG_INDEX].videoTitle,
                TextAttrs:{Font:o.family_18
                    HAlign:"Left", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:100+50, y:y+35+37, w:1000, h:20}
             })
        o.canvas.SetLayer(1004,  info)
         
        time_info = {
                Text: setTimeInfo(o),
                TextAttrs:{Font:o.family_14,
                    HAlign:"Left", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:100+50, y:y+35+37+25, w:600, h:20}
             }
        o.canvas.SetLayer(1005,  time_info)
         
         
    else if(prm = "hide")
        o.canvas.ClearLayer(998)
        o.canvas.ClearLayer(999)
        o.canvas.ClearLayer(1000)
        o.canvas.ClearLayer(1001)
        o.canvas.ClearLayer(1002)
        o.canvas.ClearLayer(1003)
        o.canvas.ClearLayer(1004)
        o.canvas.ClearLayer(1005)
    end if

end function

function showInfo(o)

    y = 550

    if(o.EPG_OBJ.info = 0)
        o.EPG_OBJ.info = 1
        
        o.canvas.SetLayer(997, { Color: "#01000000", CompositionMode: "Source", TargetRect: {x:30, y:y+25 ,w:1220,h:100}})
        
        ch_icon = {
            url: o.EPG_OBJ.CURRENT_CHANNEL.chThumb,
            TargetRect: {x:30, y:575 ,w:103,h:100}
         }
        o.canvas.SetLayer(999,  ch_icon)
        
        o.canvas.SetLayer(998, { Color: "#AA000000", CompositionMode: "Source", TargetRect: {x:30, y:y+25 ,w:1220,h:100}})
        o.canvas.SetLayer(1000, { Color: "#ffffff", CompositionMode: "Source", TargetRect: {x:40, y:y+50 ,w:1200,h:3}})
        o.canvas.SetLayer(1001, { Color: "#ffffff", CompositionMode: "Source", TargetRect: {x:42+o.VIDEO_OBJ.PLAYHEAD_X, y:y+44 ,w:3,h:15}})
        
        endlb = {
                    Text: gmdate(o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[o.EPG_OBJ.CURRENT_CHANNEL_PRG_INDEX].videoDuration.ToInt()),
                    TextAttrs:{Font:o.family_12,
                        HAlign:"Right", VAlign:"Top",
                        Direction:"LeftToRight"}
                        TargetRect: {x:1210, y:y+53, w:30, h:20}
                 }
        o.canvas.SetLayer(1002,  endlb)
        lb = {
                Text: gmdate(o.VIDEO_OBJ.CURRENT_PLAYTIME),
                TextAttrs:{Font:o.family_12,
                    HAlign:"Left", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:42+o.VIDEO_OBJ.PLAYHEAD_X+8, y:y+35, w:30, h:20}
             }
         o.canvas.SetLayer(1003,  lb)
        
        info = []
        info.push({
                Text: o.EPG_OBJ.CURRENT_CHANNEL.chNum,
                TextAttrs:{Font:o.family_16,
                    HAlign:"Left", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:100, y:y+35+40, w:30, h:20}
             })
        info.push({
                Text: o.EPG_OBJ.CURRENT_CHANNEL.chName  + ": " + o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[o.EPG_OBJ.LAST_CHANNEL_PRG_INDEX].videoTitle,
                TextAttrs:{Font:o.family_18
                    HAlign:"Left", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:100+50, y:y+35+37, w:1000, h:20}
             })
        o.canvas.SetLayer(1004,  info)
         
        time_info = {
                Text: setTimeInfo(o),
                TextAttrs:{Font:o.family_14,
                    HAlign:"Left", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:100+50, y:y+35+37+25, w:600, h:20}
             }
        o.canvas.SetLayer(1005,  time_info)
        
    else if(o.EPG_OBJ.info = 1)
        o.EPG_OBJ.info = 0
        o.canvas.ClearLayer(997)
        o.canvas.ClearLayer(998)
        o.canvas.ClearLayer(999)
        o.canvas.ClearLayer(1000)
        o.canvas.ClearLayer(1001)
        o.canvas.ClearLayer(1002)
        o.canvas.ClearLayer(1003)
        o.canvas.ClearLayer(1004)
        o.canvas.ClearLayer(1005)
        
    end if

end function

function setTimeInfo(o)

    'TIME LINE X :  221
    'TIME LINE X :  471
    'TIME LINE X :  721
    'TIME LINE X :  971
    
    if(o.EPG_OBJ.playhead.TargetRect.x > 211 and o.EPG_OBJ.playhead.TargetRect.x < 471)
        return o.TIMEARR[0] + " - " + o.TIMEARR[1]
    else if(o.EPG_OBJ.playhead.TargetRect.x > 471 and o.EPG_OBJ.playhead.TargetRect.x < 721)
        return o.TIMEARR[1] + " - " + o.TIMEARR[2]
    else if(o.EPG_OBJ.playhead.TargetRect.x > 721 and o.EPG_OBJ.playhead.TargetRect.x < 971)
        return o.TIMEARR[2] + " - " + o.TIMEARR[3]
    else if(o.EPG_OBJ.playhead.TargetRect.x > 971)
        return o.TIMEARR[3] + " - " + o.TIMEARR[4]
    end if
    
    'return o.TIMEARR[0]
   
end function

function updateMainPlayHead(o, currentTime, totalTime)

    y = 550

    print "CURRENT TIME : "; type(currentTime)
    print "TOTAL TIME : "; type(totalTime)
    
    'totalTime - 1200
    'currentTime - x
    'x = 1
    if(currentTime > 0)
        o.VIDEO_OBJ.PLAYHEAD_X = Fix((1200 * currentTime) / totalTime.ToInt())
    end if
    print "TYPE : " ; type(x)
    if(o.VIDEO_OBJ.STATE = "paused")
        o.canvas.SetLayer(1001, { Color: "#ffffff", CompositionMode: "Source", TargetRect: {x:42 + o.VIDEO_OBJ.PLAYHEAD_X, y:y+44 ,w:3,h:15}})
        lb = {
                Text: gmdate(o.VIDEO_OBJ.CURRENT_PLAYTIME),
                TextAttrs:{Font:o.family_12,
                    HAlign:"Left", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:42+o.VIDEO_OBJ.PLAYHEAD_X+8, y:y+35, w:30, h:20}
             }
         o.canvas.SetLayer(1003,  lb)
    end if

end function

function getScreenSize(param)
    
    di = CreateObject("roDeviceInfo")
    screen_wh = di.GetDisplaySize()
    
    'print "screen width: "; screen_wh.w 
    'print "screen height: "; screen_wh.h 
    
    if(param = "w")
        return screen_wh.w
    else if(param = "h")
        return screen_wh.h
    else
        return -1
    end if
    
end function

Function gmdate(seconds as Dynamic) as Dynamic
    print "TYPE : "; type(a)
    a   = seconds
    b   = 60
    print "TYPE : "; type(a); "---"; type(b);
    c   = Fix(a / b)
    sec = a - b * c


    a   = Fix(a/60)
    b   = 60
    c   = Fix(a / b)
    min = a - b * c

    a   = Fix(a/60)
    b   = 60
    c   = Fix(a / b)
    hour = a - b * c

   if sec > 9
        sec = sec.toStr()
   else
        sec = "0"+sec.toStr()
   end if 

   if min > 9
        min = min.toStr()
   else
        min = "0"+min.toStr()
   end if 

   if hour > 9
        hour = hour.toStr()
   else
        hour = "0"+hour.toStr()
   end if 
   tmes_string =  hour+":"+min+":"+sec
   return tmes_string
End FUnction