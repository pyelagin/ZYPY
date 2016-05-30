
function EPG_Screen(o)

    print "EPG SCREEN RUNNING"
    
    port = CreateObject("roMessagePort")
    o.canvas = CreateObject("roImageCanvas")
    o.canvas.SetRequireAllImagesToDraw(true)
    o.canvas.SetMessagePort(port)
    canvasRect = o.canvas.GetCanvasRect()
    o.canvas.Show()
    
    loadFavorites(o)
    http_EPG(o)
    http_getSkin(o)
    'loadSkin(o)
    
    '395,462,529
    
    '*****init here
    o.EPG_OBJ.CURRENT_CHANNEL = o.EPG_OBJ.channels[0]
    o.CURRENT_CH_ID = o.EPG_OBJ.channels[0].chID
    o.FIRST_CH_ID = o.EPG_OBJ.channels[0].chID
    
    EPG_UI(o, port)
    VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[o.EPG_OBJ.CURRENT_CHANNEL_PRG_INDEX].videoURL)
    
    
    time_int_sec = 0
    timer = CreateObject("roTimespan")
    timer.Mark()
    
    o.timer_fullview = CreateObject("roTimespan")
    o.timer_fullview.Mark()
    
    while true
    
        event = wait(250, port)
        
        'print "EVENT : "; type(event)
        
        if(event <> invalid and type(event) = "roImageCanvasEvent")
        
            o.timer_fullview.Mark()
        
            msg = event.GetIndex()
         
            'print "MSG : "; msg
            
            if(o.EPG_OBJ.SELECT_MENU = 0)
            
                if(msg = 0)
                    BACK(o)
                    o.VIDEO_OBJ.STATE = "playing"
                    o.VideoPlayer.Resume()
                else if(msg = 2)
                
                    if(o.EPG_OBJ.PLAYER_MOD = "min")
                        if(o.UILEVEL = 2)
                            if(o.CANNELS_INDEX > 0)
                                if(o.EPG_OBJ.CHANNEL_INDEX > 0)
                                    o.EPG_OBJ.CHANNEL_INDEX = o.EPG_OBJ.CHANNEL_INDEX - 1
                                    o.CANNELS_INDEX = o.CANNELS_INDEX - 1
                                     rollOverChannel(o, port)
                                     EPG_DSP_currentChannel(o)
                                     DSP_Channels(o)
                                else
                                    Y_scrooll(o, "up")
                                    o.CANNELS_INDEX = o.CANNELS_INDEX - 1
                                end if
                            else if(o.EPG_OBJ.FAVORITE_CHANNELS.Count() > 0)
                                o.UILEVEL = 1
                                'FavoriteChannels(o) 
                                DSP_Channels(o)
                            else if(o.EPG_OBJ.LAST_CHANNEL.chPlayList <> invalid) 
                                o.UILEVEL = 0
                                DSP_Channels(o)
                            end if
                        else if(o.UILEVEL = 1)
                                if(o.EPG_OBJ.LAST_CHANNEL.chPlayList <> invalid)
                                    o.UILEVEL = 0
                                    rollOverChannel_last(o, port)
                                    DSP_Channels(o)
                                end if    
                        else if(o.UILEVEL = 0)
                            rollOverChannel_last(o, port)
                            DSP_Channels(o) 
                        end if
                    else if(o.EPG_OBJ.PLAYER_MOD = "max")
                        if(o.UILEVEL = 2)
                            if(o.CANNELS_INDEX > 0)
                                if(o.EPG_OBJ.CHANNEL_INDEX > 0)
                                    o.EPG_OBJ.CHANNEL_INDEX = o.EPG_OBJ.CHANNEL_INDEX - 1
                                    o.CANNELS_INDEX = o.CANNELS_INDEX - 1
                                    rollOverChannel(o, port)
                                     'EPG_DSP_currentChannel(o)
                                     'DSP_Channels(o)
                                else
                                    Y_scrooll(o, "up")
                                    o.CANNELS_INDEX = o.CANNELS_INDEX - 1
                                    rollOverChannel_last(o, port)
                                end if
                            else if(o.EPG_OBJ.LAST_CHANNEL.chPlayList <> invalid) 
                                o.UILEVEL = 0
                                'DSP_Channels(o)
                                rollOverChannel_last(o, port)
                            end if
                       
                        else if(o.UILEVEL = 0)
                            rollOverChannel_last(o, port)
                            'dDSP_Channels(o) 
                        end if 
                    end if
                else if(msg = 3)
                    if(o.EPG_OBJ.PLAYER_MOD = "min")
                        if(o.UILEVEL = 0)
                            if(o.EPG_OBJ.FAVORITE_CHANNELS.Count() > 0)
                                o.UILEVEL = 1
                            else 
                                o.UILEVEL = 2
                                rollOverChannel(o, port)
                            end if
                            DSP_Channels(o)    
                        else if(o.UILEVEL = 1)
                            if(o.EPG_OBJ.FAVORITE_CHANNELS.Count() > 0) 
                                o.UILEVEL = 2
                                rollOverChannel(o, port)
                                DSP_Channels(o)    
                            end if    
                        else if(o.UILEVEL = 2)
                            if(o.EPG_OBJ.CHANNEL_INDEX < o.EPG_OBJ.CHANNEL_LIMIT)
                                o.EPG_OBJ.CHANNEL_INDEX = o.EPG_OBJ.CHANNEL_INDEX + 1
                                o.CANNELS_INDEX = o.CANNELS_INDEX + 1
                                rollOverChannel(o, port)
                                EPG_DSP_currentChannel(o)
                                DSP_Channels(o)
                            else
                                if(o.CANNELS_INDEX < o.EPG_OBJ.channels.Count() - 1)
                                    Y_scrooll(o, "down")
                                    o.CANNELS_INDEX = o.CANNELS_INDEX + 1
                                    rollOverChannel(o, port)
                                    EPG_DSP_currentChannel(o)
                                    DSP_Channels(o)
                                end if
                            end if
                        end if
                    else if(o.EPG_OBJ.PLAYER_MOD = "max")
                        if(o.UILEVEL = 0)
                            if(o.EPG_OBJ.FAVORITE_CHANNELS.Count() > 0)
                                o.UILEVEL = 2
                                rollOverChannel(o, port)
                            end if
                            'DSP_Channels(o)      
                        else if(o.UILEVEL = 2)
                            if(o.EPG_OBJ.CHANNEL_INDEX < o.EPG_OBJ.CHANNEL_LIMIT)
                                o.EPG_OBJ.CHANNEL_INDEX = o.EPG_OBJ.CHANNEL_INDEX + 1
                                o.CANNELS_INDEX = o.CANNELS_INDEX + 1
                                rollOverChannel(o, port)
                                'EPG_DSP_currentChannel(o)
                                'DSP_Channels(o)
                            else
                                if(o.CANNELS_INDEX < o.EPG_OBJ.channels.Count() - 1)
                                    Y_scrooll(o, "down")
                                    o.CANNELS_INDEX = o.CANNELS_INDEX + 1
                                    rollOverChannel(o, port)
                                    'EPG_DSP_currentChannel(o)
                                    'DSP_Channels(o)
                                end if
                            end if
                        end if
                    end if
                else if(msg = 4)
                    if(o.EPG_OBJ.PLAYER_MOD = "min")
                        if(o.UILEVEL = 0)
                            X_scroll_last(o, "left")
                        else if(o.UILEVEL = 1)
                            X_scroll_fav_2(o, "left")
                        else if(o.UILEVEL = 2) 
                            X_scroll(o, "left")
                        end if
                    end if
                else if(msg = 5)
                    if(o.EPG_OBJ.PLAYER_MOD = "min")
                        if(o.UILEVEL = 0)
                            X_scroll_last(o, "right")
                        else if(o.UILEVEL = 1)
                            X_scroll_fav_2(o, "right")
                        else if(o.UILEVEL = 2)
                            X_scroll(o, "right")
                        end if
                    end if
                else if(msg = 6)
                    if(o.EPG_OBJ.PLAYER_MOD = "min")
                        o.EPG_OBJ.SELECT_MENU_INDEX = 0
                        o.EPG_OBJ.SELECT_MENU = 1
                        showFavoritesMenu(o)
                        if(o.UILEVEL = 0)
                            'selectChannel_last(o, port)
                        else if(o.UILEVEL = 2)
                            'selectChannel(o, port)
                        end if
                    else if(o.EPG_OBJ.PLAYER_MOD = "max")
                        showInfo(o)
                    end if
                else if(msg = 13)
                    if(o.EPG_OBJ.PLAYER_MOD = "max")
                        if(o.VIDEO_OBJ.STATE = "playing")
                            o.VideoPlayer.Pause()
                            o.VIDEO_OBJ.STATE = "paused"
                            'showBar(o, "show")
                        else if(o.VIDEO_OBJ.STATE = "paused")
                            o.VideoPlayer.Resume()
                            o.VIDEO_OBJ.STATE = "playing"
                            'showBar(o, "hide")
                        end if
                    end if
                end if
                
            else if(o.EPG_OBJ.SELECT_MENU = 1)
               if(msg = 2)
                    if(o.EPG_OBJ.SELECT_MENU_INDEX > 0)
                        o.EPG_OBJ.SELECT_MENU_INDEX = o.EPG_OBJ.SELECT_MENU_INDEX - 1
                        showFavoritesMenu(o)
                    end if
               else if(msg = 3)
                    if(o.EPG_OBJ.SELECT_MENU_INDEX < 2)
                        o.EPG_OBJ.SELECT_MENU_INDEX = o.EPG_OBJ.SELECT_MENU_INDEX + 1
                        showFavoritesMenu(o)
                    end if
               else if(msg = 6)
                    if(o.EPG_OBJ.SELECT_MENU_INDEX = 0)
                        if(o.UILEVEL = 0)
                            selectChannel_last(o, port)
                        else if(o.UILEVEL = 1)
                            selectChannel_fav_2(o, port)
                        else if(o.UILEVEL = 2)
                            selectChannel(o, port)
                        end if
                        o.EPG_OBJ.SELECT_MENU = 0
                    else if(o.EPG_OBJ.SELECT_MENU_INDEX = 1)
                        o.EPG_OBJ.SELECT_MENU = 0
                        if(o.UILEVEL <> 1) 
                            addToFavorites(o)
                        else
                            removeFromFavorites(o)
                        end if
                        EPG_UI(o, port)
                    else if(o.EPG_OBJ.SELECT_MENU_INDEX = 2)
                        o.EPG_OBJ.SELECT_MENU = 0
                        o.canvas.ClearLayer(600)
                    end if
               end if
            end if
        
        else if(event <> invalid)
        
            if(event <> invalid and event.GetMessage() = "end of playlist")
                'print "LOOPING"
                'VideoPlayer(o, port, o.EPG_OBJ.currentURL) 
            else if(event <> invalid and event.GetMessage() = "startup progress")
                'print "LOADING"
                showLoader(o,1)
            else if(event <> invalid and event.GetMessage() = "start of play")
                'print "START PLAYING"
                showLoader(o,0)
            else if(event.isPlaybackPosition())
                o.VIDEO_OBJ.CURRENT_PLAYTIME = event.GetIndex()
                updateMainPlayHead(o, event.GetIndex(), o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[o.EPG_OBJ.CURRENT_CHANNEL_PRG_INDEX].videoDuration)
            else if(event.GetMessage() = "end of playlist")
                if(o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[o.EPG_OBJ.CURRENT_CHANNEL_PRG_INDEX+1].videoURL <> invalid)
                    o.EPG_OBJ.CURRENT_CHANNEL_PRG_INDEX = o.EPG_OBJ.CURRENT_CHANNEL_PRG_INDEX + 1
                    VideoPlayer(o, port, o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[o.EPG_OBJ.CURRENT_CHANNEL_PRG_INDEX].videoURL)
                end if
            end if
            
        end if
     
        if(timer.TotalMilliseconds() > 1290)
            if(o.EPG_OBJ.PLAYER_MOD = "min")
                time_int_sec = time_int_sec + 1
                o.EPG_OBJ.PLAYHEAD_X = o.EPG_OBJ.PLAYHEAD_X + 1
                o.EPG_OBJ.playhead.TargetRect.x = o.EPG_OBJ.PLAYHEAD_X
                'print "X---> "; o.EPG_OBJ.playhead.TargetRect.x
                if(o.EPG_OBJ.PLAYER_MOD = "min" and o.EPG_OBJ.playhead.TargetRect.x < 1211) o.canvas.SetLayer(31, o.EPG_OBJ.playhead)
            else if(o.EPG_OBJ.PLAYER_MOD = "max" and o.EPG_OBJ.info = 1)
                o.canvas.SetLayer(1001, { Color: "#ffffff", CompositionMode: "Source", TargetRect: {x:42+o.VIDEO_OBJ.PLAYHEAD_X, y:550+44 ,w:3,h:15}})
                lb = {
                    Text: gmdate(o.VIDEO_OBJ.CURRENT_PLAYTIME),
                    TextAttrs:{Font:o.family_12,
                        HAlign:"Left", VAlign:"Top",
                        Direction:"LeftToRight"}
                        TargetRect: {x:42+o.VIDEO_OBJ.PLAYHEAD_X+8, y:550+35, w:30, h:20}
                 }
                o.canvas.SetLayer(1003,  lb)
            end if
            timer.Mark()
            if(o.UILEVEL = 0)
                detectVideo_last(o, port)
            else if(o.UILEVEL = 2)
                detectVideo(o, port)
            end if
        end if
        
        if(o.timer_fullview.TotalMilliseconds() > 30000)
            
            if(o.EPG_OBJ.PLAYER_MOD = "min")
                'if(o.UILEVEL = 0)
                    'selectChannel_last(o, port)
                'else if(o.UILEVEL = 1)
                    'selectChannel_fav(o, port)
                'else if(o.UILEVEL = 2)
                    'selectChannel(o, port)
                'end if
                autoFullMode(o)
            end if
            
        end if
        
       ' print "CHANNEL INDEX : "; o.EPG_OBJ.CHANNEL_INDEX
        
    end while
    
end function

function EPG_UI(o, port)
    
    'print "EPG UI RUNNING : "; o.EPG_OBJ.PLAYER_MOD
    'w:700,h:330
    
    o.canvas.Clear()
    
    o.canvas.SetLayer(2, { Color: "#01000000", CompositionMode: "Source", TargetRect: {x:0,y:0,w:1280,h:720}})
    
    if(o.EPG_OBJ.PLAYER_MOD = "min")
    
        o.canvas.SetLayer(3, { Color:o.SKIN.SkinData.EPGBackgroundColor, CompositionMode: "Source", TargetRect: {x:0, y:290 ,w:1280,h:700}})
        
        o.EPG_OBJ.bg = {
                url: o.SKIN.SkinData.BackgroundImage,
                TargetRect: {x:0, y:0 ,w:1280,h:292}
             }
             
        o.canvas.SetLayer(12, o.EPG_OBJ.bg)
        
        o.EPG_OBJ.logo = {
                url: "pkg:/images/logo.png",
                TargetRect: {x:100, y:60 ,w:111,h:23}
             }
        
        'o.canvas.SetLayer(13, o.EPG_OBJ.logo)
    
    
        EPG_DSP_timeLine(o)
        'EPG_DSP_lastChannel(o)
        EPG_DSP_currentChannel(o)
        'FavoriteChannels(o)
        'EPG_DSP_channels_2(o)
        
        DSP_Channels(o)
        
        o.VIDEO_OBJ.x = 103
        o.VIDEO_OBJ.y = 80
        o.VIDEO_OBJ.w = 333
        o.VIDEO_OBJ.h = 190
        
        '249 148
        'showBar(o, "hide")
        if(o.VideoPlayer <> invalid)
            targetrect = { x:o.VIDEO_OBJ.x, y:o.VIDEO_OBJ.y, w:o.VIDEO_OBJ.w, h:o.VIDEO_OBJ.h }
            o.VideoPlayer.SetDestinationRect(targetrect)
        end if
        
        o.canvas.SetLayer(5010, { Color:o.SKIN.SkinData.EPGBackgroundColor, CompositionMode: "Source", TargetRect: {x:1229,y:332,w:500,h:720}})
    else
        o.VIDEO_OBJ.x = 0
        o.VIDEO_OBJ.y = 0
        o.VIDEO_OBJ.w = 1280
        o.VIDEO_OBJ.h = 720
        
        o.EPG_OBJ.ch_title = {
             Text: o.EPG_OBJ.CURRENT_CHANNEL.chName
             TextAttrs:{Font:o.family_32,
                    HAlign:"Left", VAlign:"Top",
                    Color: o.SKIN.SkinData.ChannelNameColor
                    Direction:"LeftToRight"}
                    TargetRect: {x:60, y:45, w:500, h:50}
             }    
       o.canvas.SetLayer(14, o.EPG_OBJ.ch_title)
        
        
        'showBar(o, "show")
        
        'print "IDS -----> : "; o.EPG_OBJ.CURRENT_CHANNEL.chID; "---> "; o.CURRENT_CH_ID
        print "IDS -----> : "; o.EPG_OBJ.CURRENT_CHANNEL.chID = o.CURRENT_CH_ID
        
        if(o.VideoPlayer <> invalid)
            targetrect = { x:o.VIDEO_OBJ.x, y:o.VIDEO_OBJ.y, w:o.VIDEO_OBJ.w, h:o.VIDEO_OBJ.h }
            o.VideoPlayer.SetDestinationRect(targetrect)
        end if
    end if
    
    
end function

function X_scroll(o, dir)
    if(o.EPG_OBJ.PLAYER_MOD = "min")
        print "pnum : "; o.EPG_OBJ.channels[0].pNum
        if(dir = "left")
            if(o.EPG_OBJ.programIndex > 0)
                o.EPG_OBJ.programIndex = o.EPG_OBJ.programIndex - 1
            end if
        else if(dir = "right")
            if(o.EPG_OBJ.programIndex < o.EPG_OBJ.channels[0].pNum)
                o.EPG_OBJ.programIndex = o.EPG_OBJ.programIndex + 1
            end if
        end if
        EPG_DSP_channels_2(o)
    end if
end function

function X_scroll_last(o, dir)
    if(o.EPG_OBJ.PLAYER_MOD = "min")
        print "pnum : "; o.EPG_OBJ.LAST_CHANNEL.pNum
        if(dir = "left")
            if(o.EPG_OBJ.programIndex > 0)
                o.EPG_OBJ.programIndex = o.EPG_OBJ.programIndex - 1
            end if
        else if(dir = "right")
            if(o.EPG_OBJ.programIndex < o.EPG_OBJ.LAST_CHANNEL.pNum)
                o.EPG_OBJ.programIndex = o.EPG_OBJ.programIndex + 1
            end if
        end if
        EPG_DSP_lastChannel(o)
    end if
end function

function X_scroll_fav_2(o, dir)
    if(o.EPG_OBJ.PLAYER_MOD = "min")
        if(dir = "left")
        
            if(o.EPG_OBJ.FAVORITE_CHANNELS_INDEX > 0)
                o.EPG_OBJ.FAVORITE_CHANNELS_INDEX = o.EPG_OBJ.FAVORITE_CHANNELS_INDEX - 1
            else
                t = o.EPG_OBJ.FAVORITE_CHANNELS.pop()
                o.EPG_OBJ.FAVORITE_CHANNELS.unshift(t)
            end if
            
        else if(dir = "right")
        
            limit = 6
            
            if((o.EPG_OBJ.FAVORITE_CHANNELS.Count() - 1) < limit)
                limit = o.EPG_OBJ.FAVORITE_CHANNELS.Count() - 1
            end if
        
            if(o.EPG_OBJ.FAVORITE_CHANNELS_INDEX < limit)
                o.EPG_OBJ.FAVORITE_CHANNELS_INDEX = o.EPG_OBJ.FAVORITE_CHANNELS_INDEX + 1
            else
                
                if(o.EPG_OBJ.FAVORITE_CHANNELS_INDEX = 6)
                    t = o.EPG_OBJ.FAVORITE_CHANNELS.shift()
                    o.EPG_OBJ.FAVORITE_CHANNELS.push(t)
                end if
                
            end if
            
            FavoriteChannels_2(o)
            
        end if
        FavoriteChannels_2(o)
    end if
end function

function X_scroll_fav(o, dir)
    if(o.EPG_OBJ.PLAYER_MOD = "min")
        if(dir = "left")
            if(o.EPG_OBJ.programIndex > 0)
                'o.EPG_OBJ.FAVORITE_CHANNEL_PRG_INDEX = o.EPG_OBJ.FAVORITE_CHANNEL_PRG_INDEX - 1
                o.EPG_OBJ.programIndex = o.EPG_OBJ.programIndex - 1
            end if
        else if(dir = "right")
            if(o.EPG_OBJ.programIndex < o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX].pNum)
                'o.EPG_OBJ.FAVORITE_CHANNEL_PRG_INDEX = o.EPG_OBJ.FAVORITE_CHANNEL_PRG_INDEX + 1
                o.EPG_OBJ.programIndex = o.EPG_OBJ.programIndex + 1
            end if
        end if
        FavoriteChannels_2(o)
    end if
end function

function Y_scrooll(o, dir)
    if(o.EPG_OBJ.PLAYER_MOD = "min")
        if(dir = "down")
            t = o.EPG_OBJ.channels.shift()
            o.EPG_OBJ.channels.push(t)
        else if(dir = "up")
            t = o.EPG_OBJ.channels.pop()
            o.EPG_OBJ.channels.unshift(t)
        end if
        EPG_DSP_channels_2(o)
        if(o.FIRST_CH_ID = o.EPG_OBJ.channels[0].chID) o.EPG_OBJ.CHANNEL_INDEX = 0
    end if
end function

function selectChannel(o, port)
    
    TEMP_CHANNEL = CreateObject("roAssociativeArray")
    TEMP_CHANNEL = o.EPG_OBJ.CURRENT_CHANNEL
    o.EPG_OBJ.CURRENT_CHANNEL = o.EPG_OBJ.channels[o.EPG_OBJ.CHANNEL_INDEX]
    
    for i = 0 to o.EPG_OBJ.CURRENT_CHANNEL.xPos.Count() - 1
        print "PLAY HEAD X : "; o.EPG_OBJ.playhead.TargetRect.x
        print "pos 1 : "; o.EPG_OBJ.CURRENT_CHANNEL.xPos[i]
        print "pos 2 : "; o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1]
        print "pnum : "; o.EPG_OBJ.CURRENT_CHANNEL.pNum
        if(o.EPG_OBJ.CURRENT_CHANNEL.xPos[i] <> invalid and o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1] <> invalid)
            if(o.EPG_OBJ.playhead.TargetRect.x >= o.EPG_OBJ.CURRENT_CHANNEL.xPos[i]-7 and o.EPG_OBJ.playhead.TargetRect.x <= o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1]-7)
                print "TRIGERING VIDEO"
                o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoTitle
                o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
                'if(o.EPG_OBJ.CURRENT_CHANNEL.chID <> o.CURRENT_CH_ID)
                    o.EPG_OBJ.LAST_CHANNEL = TEMP_CHANNEL
                    'VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoURL)
                    o.CURRENT_CH_ID = o.EPG_OBJ.CURRENT_CHANNEL.chID
                    o.VIDEO_OBJ.PLAYHEAD_X = 0
                    o.VIDEO_OBJ.CURRENT_PLAYTIME = 0
                'end if
                exit for  
            end if
        else if(o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1] = invalid)
            print "TRIGERING VIDEO"
            e = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList.Count()-1
            o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[e].videoTitle
            o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
            'if(o.EPG_OBJ.CURRENT_CHANNEL.chID <> o.CURRENT_CH_ID)
                o.EPG_OBJ.LAST_CHANNEL = TEMP_CHANNEL
                'VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[e].videoURL)
                o.CURRENT_CH_ID = o.EPG_OBJ.CURRENT_CHANNEL.chID
                o.VIDEO_OBJ.PLAYHEAD_X = 0
                o.VIDEO_OBJ.CURRENT_PLAYTIME = 0
            'end if
            exit for
        end if
    end for
    
    o.EPG_OBJ.PLAYER_MOD = "max"
    EPG_UI(o, port)

end function

function rollOverChannel(o, port)

    o.EPG_OBJ.CURRENT_CHANNEL = o.EPG_OBJ.channels[o.EPG_OBJ.CHANNEL_INDEX]
    
    for i = 0 to o.EPG_OBJ.CURRENT_CHANNEL.xPos.Count() - 1
        if(o.EPG_OBJ.CURRENT_CHANNEL.xPos[i] <> invalid and o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1] <> invalid)
            if(o.EPG_OBJ.playhead.TargetRect.x >= o.EPG_OBJ.CURRENT_CHANNEL.xPos[i]-7 and o.EPG_OBJ.playhead.TargetRect.x <= o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1]-7)
                print "TRIGERING VIDEO"
                o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoTitle
                if(o.EPG_OBJ.PLAYER_MOD = "min") o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
                if(o.EPG_OBJ.CURRENT_CHANNEL.chID <> o.CURRENT_CH_ID)
                    'o.EPG_OBJ.LAST_CHANNEL = TEMP_CHANNEL
                    print "LIVE URL : "; o.EPG_OBJ.CURRENT_CHANNEL.streamURL
                    if(o.EPG_OBJ.CURRENT_CHANNEL.streamURL = "")
                        VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoURL)
                    else
                        VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.streamURL, "hls")
                    end if
                    o.CURRENT_CH_ID = o.EPG_OBJ.CURRENT_CHANNEL.chID
                    o.VIDEO_OBJ.PLAYHEAD_X = 0
                    o.VIDEO_OBJ.CURRENT_PLAYTIME = 0
                end if
                exit for  
            end if
        else if(o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1] = invalid)
            print "TRIGERING VIDEO"
            e = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList.Count()-1
            o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[e].videoTitle
            if(o.EPG_OBJ.PLAYER_MOD = "min") o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
            if(o.EPG_OBJ.CURRENT_CHANNEL.chID <> o.CURRENT_CH_ID)
                'o.EPG_OBJ.LAST_CHANNEL = TEMP_CHANNEL
                print "LIVE URL : "; o.EPG_OBJ.CURRENT_CHANNEL.streamURL
                if(o.EPG_OBJ.CURRENT_CHANNEL.streamURL = "")
                    VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[e].videoURL)
                else
                    VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.streamURL, "hls")
                end if
                o.CURRENT_CH_ID = o.EPG_OBJ.CURRENT_CHANNEL.chID
                o.VIDEO_OBJ.PLAYHEAD_X = 0
                o.VIDEO_OBJ.CURRENT_PLAYTIME = 0
            end if
            exit for
        end if
    end for
    
    'EPG_DSP_currentChannel(o)

end function

function rollOverChannel_last(o, port)

    o.EPG_OBJ.CURRENT_CHANNEL = o.EPG_OBJ.LAST_CHANNEL
    
    for i = 0 to o.EPG_OBJ.CURRENT_CHANNEL.xPos.Count() - 1
        if(o.EPG_OBJ.CURRENT_CHANNEL.xPos[i] <> invalid and o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1] <> invalid)
            if(o.EPG_OBJ.playhead.TargetRect.x >= o.EPG_OBJ.CURRENT_CHANNEL.xPos[i]-7 and o.EPG_OBJ.playhead.TargetRect.x <= o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1]-7)
                print "TRIGERING VIDEO"
                o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoTitle
                if(o.EPG_OBJ.PLAYER_MOD = "min") o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
                if(o.EPG_OBJ.CURRENT_CHANNEL.chID <> o.CURRENT_CH_ID)
                    'o.EPG_OBJ.LAST_CHANNEL = TEMP_CHANNEL
                    
                    if(o.EPG_OBJ.CURRENT_CHANNEL.streamURL = "")
                        VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoURL)
                    else
                        VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.streamURL, "hls")
                    end if
                    o.CURRENT_CH_ID = o.EPG_OBJ.CURRENT_CHANNEL.chID
                    o.VIDEO_OBJ.PLAYHEAD_X = 0
                    o.VIDEO_OBJ.CURRENT_PLAYTIME = 0
                end if
                exit for  
            end if
        else if(o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1] = invalid)
            print "TRIGERING VIDEO"
            e = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList.Count()-1
            o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[e].videoTitle
            if(o.EPG_OBJ.PLAYER_MOD = "min") o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
            if(o.EPG_OBJ.CURRENT_CHANNEL.chID <> o.CURRENT_CH_ID)
                'o.EPG_OBJ.LAST_CHANNEL = TEMP_CHANNEL
         
                if(o.EPG_OBJ.CURRENT_CHANNEL.streamURL = "")
                    VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[e].videoURL)
                else
                    VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.streamURL, "hls")
                end if
                o.CURRENT_CH_ID = o.EPG_OBJ.CURRENT_CHANNEL.chID
                o.VIDEO_OBJ.PLAYHEAD_X = 0
                o.VIDEO_OBJ.CURRENT_PLAYTIME = 0
            end if
            exit for
        end if
    end for
    
    'EPG_DSP_currentChannel(o)

end function

function selectChannel_last(o, port)
    
    TEMP_CHANNEL = CreateObject("roAssociativeArray")
    TEMP_CHANNEL = o.EPG_OBJ.CURRENT_CHANNEL
    o.EPG_OBJ.CURRENT_CHANNEL = o.EPG_OBJ.LAST_CHANNEL
    
    for i = 0 to o.EPG_OBJ.CURRENT_CHANNEL.xPos.Count() - 1
        print "PLAY HEAD X : "; o.EPG_OBJ.playhead.TargetRect.x
        print "pos 1 : "; o.EPG_OBJ.CURRENT_CHANNEL.xPos[i]
        print "pos 2 : "; o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1]
        print "pnum : "; o.EPG_OBJ.CURRENT_CHANNEL.pNum
        if(o.EPG_OBJ.CURRENT_CHANNEL.xPos[i] <> invalid and o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1] <> invalid)
            if(o.EPG_OBJ.playhead.TargetRect.x >= o.EPG_OBJ.CURRENT_CHANNEL.xPos[i]-7 and o.EPG_OBJ.playhead.TargetRect.x <= o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1]-7)
                print "TRIGERING VIDEO"
                o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoTitle
                o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
                if(o.EPG_OBJ.CURRENT_CHANNEL.chID <> o.CURRENT_CH_ID)
                    'o.EPG_OBJ.LAST_CHANNEL = TEMP_CHANNEL
                    'VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoURL)
                    o.CURRENT_CH_ID = o.EPG_OBJ.CURRENT_CHANNEL.chID
                    o.VIDEO_OBJ.PLAYHEAD_X = 0
                    o.VIDEO_OBJ.CURRENT_PLAYTIME = 0
                end if
                exit for  
            end if
        else if(o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1] = invalid)
            print "TRIGERING VIDEO"
            e = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList.Count() - 1
            o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[e].videoTitle
            o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
            if(o.EPG_OBJ.CURRENT_CHANNEL.chID <> o.CURRENT_CH_ID)
                'o.EPG_OBJ.LAST_CHANNEL = TEMP_CHANNEL
                'VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[e].videoURL)
                o.CURRENT_CH_ID = o.EPG_OBJ.CURRENT_CHANNEL.chID
                o.VIDEO_OBJ.PLAYHEAD_X = 0
                o.VIDEO_OBJ.CURRENT_PLAYTIME = 0
            end if 
            exit for
        end if
    end for
    
    o.EPG_OBJ.PLAYER_MOD = "max"
    EPG_UI(o, port)

end function

function selectChannel_fav_2(o, port)

    o.EPG_OBJ.CURRENT_CHANNEL = o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX]
    
    
    if(o.EPG_OBJ.CURRENT_CHANNEL.streamURL <> "")
        VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[0].videoURL)
    else
        VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.streamURL, "hls")
    end if
    
    o.EPG_OBJ.PLAYER_MOD = "max"
    EPG_UI(o, port)

end function

function selectChannel_fav(o, port)

    TEMP_CHANNEL = CreateObject("roAssociativeArray")
    TEMP_CHANNEL = o.EPG_OBJ.CURRENT_CHANNEL
    o.EPG_OBJ.CURRENT_CHANNEL = o.EPG_OBJ.FAVORITE_CHANNELS[o.EPG_OBJ.FAVORITE_CHANNELS_INDEX]
    
    for i = 0 to o.EPG_OBJ.CURRENT_CHANNEL.xPos.Count() - 1
        print "PLAY HEAD X : "; o.EPG_OBJ.playhead.TargetRect.x
        print "pos 1 : "; o.EPG_OBJ.CURRENT_CHANNEL.xPos[i]
        print "pos 2 : "; o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1]
        print "pnum : "; o.EPG_OBJ.CURRENT_CHANNEL.pNum
        if(o.EPG_OBJ.CURRENT_CHANNEL.xPos[i] <> invalid and o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1] <> invalid)
            if(o.EPG_OBJ.playhead.TargetRect.x >= o.EPG_OBJ.CURRENT_CHANNEL.xPos[i]-7 and o.EPG_OBJ.playhead.TargetRect.x <= o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1]-7)
                print "TRIGERING VIDEO"
                o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoTitle
                o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
                if(o.EPG_OBJ.CURRENT_CHANNEL.chID <> o.CURRENT_CH_ID)
                    'o.EPG_OBJ.LAST_CHANNEL = TEMP_CHANNEL
                    VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoURL)
                    o.CURRENT_CH_ID = o.EPG_OBJ.CURRENT_CHANNEL.chID
                    o.VIDEO_OBJ.PLAYHEAD_X = 0
                    o.VIDEO_OBJ.CURRENT_PLAYTIME = 0
                end if
                exit for  
            end if
        else if(o.EPG_OBJ.CURRENT_CHANNEL.xPos[i+1] = invalid)
            print "TRIGERING VIDEO"
            e = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList.Count() - 1
            o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[e].videoTitle
            o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
            if(o.EPG_OBJ.CURRENT_CHANNEL.chID <> o.CURRENT_CH_ID)
                'o.EPG_OBJ.LAST_CHANNEL = TEMP_CHANNEL
                VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[e].videoURL)
                o.CURRENT_CH_ID = o.EPG_OBJ.CURRENT_CHANNEL.chID
                o.VIDEO_OBJ.PLAYHEAD_X = 0
                o.VIDEO_OBJ.CURRENT_PLAYTIME = 0
            end if 
            exit for
        end if
    end for
    
    o.EPG_OBJ.PLAYER_MOD = "max"
    EPG_UI(o, port)
    
end function

function truncateText(n, tStr)

    t = ""

    if(len(tStr) >= n)
        t = left(tStr, n)
        t = t + "..."
    else
        t = tStr
    end if

    return t

end function

function EPG_selectChannel(o, port)
    
    o.EPG_OBJ.programIndex = o.EPG_OBJ.currentPrgIndx
    
    o.EPG_OBJ.currentPrgPosArr = o.EPG_OBJ.channels[0].progPos_s_Arr
    o.EPG_OBJ.currentURL = o.EPG_OBJ.channels[0].progPosUrlArr[o.EPG_OBJ.currentPrgIndx]
    'EPG_DSP_channels(o)
    VideoPlayer(o, port,  o.EPG_OBJ.channels[0].progPosUrlArr[o.EPG_OBJ.currentPrgIndx])
    
    o.EPG_OBJ.ch_icon.url =  o.EPG_OBJ.channels[0].chThumb
    o.canvas.SetLayer(15, o.EPG_OBJ.ch_icon)
  
end function

function EPG_selectChannel_2(o, port)

    playPos = o.EPG_OBJ.playhead.TargetRect.x
    
    o.EPG_OBJ.currentChannel = o.EPG_OBJ.channels[0]
    
    o.EPG_OBJ.ch_icon.url =  o.EPG_OBJ.channels[0].chThumb
    o.canvas.SetLayer(15, o.EPG_OBJ.ch_icon)  
    
    o.EPG_OBJ.ch_title.Text = o.EPG_OBJ.channels[0].chName
    o.canvas.SetLayer(14, o.EPG_OBJ.ch_title)
    o.EPG_OBJ.ch_sub.Text = truncateText(100, o.EPG_OBJ.channels[0].chDesc)
    o.canvas.SetLayer(16, o.EPG_OBJ.ch_sub)
    'o.EPG_OBJ.ch_desc.Text = activeTitle
    'o.canvas.SetLayer(17, o.EPG_OBJ.ch_desc)
    
    for i = 0 to o.EPG_OBJ.channels[0].progPos_s_Arr.Count() - 1
        if(playPos > o.EPG_OBJ.channels[0].progPos_s_Arr[i] and playPos < o.EPG_OBJ.channels[0].progPos_s_Arr[i+1])
             
             o.EPG_OBJ.programIndex = i
             o.EPG_OBJ.currentURL = o.EPG_OBJ.channels[0].progPosUrlArr[i]
             
             o.EPG_OBJ.ch_desc.Text = o.EPG_OBJ.channels[0].progPosTitle[i]
             o.canvas.SetLayer(17, o.EPG_OBJ.ch_desc)
             
             'o.EPG_OBJ.currentURL = o.EPG_OBJ.channels[0].chPlayList[0].videoUrl
             'o.EPG_OBJ.currentPrgID = o.EPG_OBJ.channels[0].chPlayList[0].id
             'o.EPG_OBJ.currentPrgPosArr = o.EPG_OBJ.channels[0].progPos_s_Arr
             
        end if
       
    end for
    
    print "PLAY HEAD POS: "; playPos
    print "PROG INDEX: "; o.EPG_OBJ.programIndex
    print "PROG URL: "; o.EPG_OBJ.currentURL
    
    VideoPlayer(o, port,  o.EPG_OBJ.currentURL)
    
    'EPG_DSP_channels(o)

end function

function EPG_selectProgram(o, dir)
    if(dir = "left")
        if(o.EPG_OBJ.programIndex > 0)
            o.EPG_OBJ.programIndex = o.EPG_OBJ.programIndex - 1
        end if
    else if(dir = "right")
        if(o.EPG_OBJ.programIndex < o.EPG_OBJ.channels[0].chPlayList.Count())
            o.EPG_OBJ.programIndex = o.EPG_OBJ.programIndex + 1
        end if
    end if
    EPG_DSP_channels(o)
end function

function detectVideo(o, port)
    if(o.EPG_OBJ.PLAYER_MOD = "min")
        for i = 0 to o.EPG_OBJ.CURRENT_CHANNEL.xPos.Count() - 1
            px = o.EPG_OBJ.CURRENT_CHANNEL.xPos[i]
            if(o.EPG_OBJ.playhead.TargetRect.x = (px-7))
                print "TRIGERING VIDEO"
                o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoTitle
                o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
                VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[i].videoURL)   
            end if
        end for
    end if
end function

function detectVideo_last(o, port)
    if(o.EPG_OBJ.PLAYER_MOD = "min" and o.EPG_OBJ.LAST_CHANNEL.chPlayList <> invalid)
        for i = 0 to o.EPG_OBJ.LAST_CHANNEL.xPos.Count() - 1
            px = o.EPG_OBJ.LAST_CHANNEL.xPos[i]
            if(o.EPG_OBJ.playhead.TargetRect.x = (px-7))
                print "TRIGERING VIDEO"
                o.EPG_OBJ.pr_title.Text = o.EPG_OBJ.LAST_CHANNEL.chPlayList[i].videoTitle
                o.canvas.SetLayer(17, o.EPG_OBJ.pr_title)
                VideoPlayer(o, port,  o.EPG_OBJ.LAST_CHANNEL.chPlayList[i].videoURL)   
            end if
        end for
    end if
end function

function showLoader(o,prm)

    '249 148

    if(prm = 1)
         
         if(o.EPG_OBJ.PLAYER_MOD = "min")
             lb = {
             Text: "Loading..."
             TextAttrs:{Font:"o.family_21",
                    HAlign:"Center", VAlign:"Center",
                    Direction:"LeftToRight"}
                    TargetRect: {x:220, y:150, w:100, h:50}
             }
         else
            x = (o.SCREEN_WIDTH / 2) - 20
            y = (o.SCREEN_HIGHT / 2) - 10
            lb = {
             Text: "Loading..."
             TextAttrs:{Font:"LARGE",
                    HAlign:"Center", VAlign:"Center",
                    Direction:"LeftToRight"}
                    TargetRect: {x:620, y:340, w:100, h:50}
             }
         end if
     
         if(o.EPG_OBJ.loader = 0) 
            o.canvas.SetLayer(3000, lb)
            print "LOADER ON"
         end if
         o.EPG_OBJ.loader = 1
    else
         print "LOADER OFF"
         o.canvas.ClearLayer(3000)
         o.EPG_OBJ.loader = 0
    end if

end function

function DSP_Channels(o)

    print "LAST COUNT ----->>>>> : "; o.EPG_OBJ.LAST_CHANNEL.Count()
    
    '335 402 469
    
    if(o.EPG_OBJ.LAST_CHANNEL.chPlayList <> invalid and o.EPG_OBJ.FAVORITE_CHANNELS.Count() > 0)
        
        print "DSP 1"
        
        o.EPG_OBJ.lastWatched_Y = 335
        o.EPG_OBJ.favorites_Y = 402
        o.EPG_OBJ.channels_Y = 469
        EPG_DSP_lastChannel(o)
        FavoriteChannels_2(o)
        EPG_DSP_channels_2(o)
        
    else if(o.EPG_OBJ.LAST_CHANNEL.chPlayList <> invalid)
        '+67
        o.EPG_OBJ.lastWatched_Y = 335
        'o.EPG_OBJ.favorites_Y = 462
        o.EPG_OBJ.channels_Y = 402
        EPG_DSP_lastChannel(o)
        'FavoriteChannels(o)
        EPG_DSP_channels_2(o)
        
    else if(o.EPG_OBJ.FAVORITE_CHANNELS.Count() > 0)
    
        print "DSP 2"
    
        'o.EPG_OBJ.lastWatched_Y = 395
        o.EPG_OBJ.favorites_Y = 335
        o.EPG_OBJ.channels_Y = 402
        'EPG_DSP_lastChannel(o)
        FavoriteChannels_2(o)
        EPG_DSP_channels_2(o)
    else if(o.EPG_OBJ.LAST_CHANNEL.chPlayList = invalid and o.EPG_OBJ.FAVORITE_CHANNELS.Count() = 0)
        
        print "DSP 3"
        
        'o.EPG_OBJ.lastWatched_Y = 395
        'o.EPG_OBJ.favorites_Y = 462
        o.EPG_OBJ.channels_Y = 335
        'EPG_DSP_lastChannel(o)
        'FavoriteChannels(o)
        EPG_DSP_channels_2(o)
    end if
    
end function

function playNext(o, port)
    
    if(o.EPG_OBJ.CHANNEL_INDEX < o.EPG_OBJ.channels.Count() - 1)
        o.EPG_OBJ.CHANNEL_INDEX = o.EPG_OBJ.CHANNEL_INDEX + 1
        o.EPG_OBJ.CURRENT_CHANNEL = o.EPG_OBJ.channels[o.EPG_OBJ.CHANNEL_INDEX]
        VideoPlayer(o, port,  o.EPG_OBJ.CURRENT_CHANNEL.chPlayList[o.EPG_OBJ.CHANNEL_INDEX].videoURL)
    end if

end function

function autoFullMode(o)
    o.EPG_OBJ.PLAYER_MOD = "max"
    EPG_UI(o, port)
end function
