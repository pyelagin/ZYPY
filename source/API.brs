
function http_EPG(o)

     print "HTTP EPG RUNNING"
     
    'http://talyn.asoshared.com/~sommersm/backend/allroku/zypytv
     
    'url = "http://www.mtatechnosys.com/vimeo2/backend/allroku/zypytv/?r="+Rnd(100).toStr()
    
    url = "http://www.mtatechnosys.com/vimeo2/zypychannel/allroku/zypytv"
     
    print "URL: "; url
     
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.SetMessagePort(port)
    request.SetUrl(url)
    
    o.EPG_OBJ.channels = []
    
    if(request.AsyncGetToString())
    
        while (true)
        
            msg = wait(0, port)
            if(type(msg) = "roUrlEvent")
            
                if(type(msg) = "roUrlEvent")
                
                    code = msg.GetResponseCode()
                    print "STATUS: "; code
                    json = ParseJSON(msg.GetString())
                    
                    if(code = 200)
                        'print "----> "; json
                        for each item in json.info
                        
                            'print "---> "; type(item["playlist"]) <> "String"  
                        
                            'if(item["playlist"]) 
                            
                                CHANNEL = CreateObject("roAssociativeArray")
                                'print "CHANNEL : "; item["channel"]
                                CHANNEL.chNum = item["channel"]["channelNumber"]
                                CHANNEL.chName = item["channel"]["channelName"]
                                CHANNEL.chType = item["channel"]["channelType"]
                                CHANNEL.chDesc = item["channel"]["rokuDescription"]
                                CHANNEL.chDate = item["channel"]["rokuDescription"]
                                CHANNEL.chPosti = item["channel"]["posti"]
                                CHANNEL.chID = item["channel"]["id"]
                                CHANNEL.chThumb = item["channel"]["thumbmail"]
                                CHANNEL.chImg = item["channel"]["channelStrip"]
                                CHANNEL.chPlayList = []
                                CHANNEL.chAdds = []
                                
                                inc = 0
                                prgnum = 0
                                print " ----- > "; item["playlist"]
                                for each i in item["playlist"]
                                    print "API PLAY LIST : "; type(i)
                                    'if(type(i) <> "String" and i <> invalid)
                                    'print "---LIST ITEM : "; i.videoTitle
                                    'print "playlist ---> "; type(i) = "String"
                                    if(type(i) <> "String")
                                       if(i["videoDuration"] <> "0") 
                                            CHANNEL.chPlayList.push(i)
                                        end if
                                        print "SKIP ----- > "; 
                                    end if
                                    
                                end for
                                for each i in item["ads"]
                                    CHANNEL.chAdds.push(i)
                                end for
                                
                                if(CHANNEL.chPlayList.Count() > 0)
                                    o.EPG_OBJ.channels.push(CHANNEL)
                                end if
                                print "CHANNEL CONTENT LENGTH : "; o.EPG_OBJ.channels.Count()
                            
                            'end if
                        end for
                    end if
                
                end if
            
            end if
            exit while
        end while
        'print "CH NUM : "; o.EPG_OBJ.channels.Count()
        'print "------- : "; o.EPG_OBJ.channels[0].chPlayList[0]
        
        if(o.EPG_OBJ.channels[0].chPlayList[0] <> invalid)
            o.EPG_OBJ.programTitle = o.EPG_OBJ.channels[0].chPlayList[0].videoTitle
        else
            o.EPG_OBJ.programTitle = "None"
        end if
        'o.EPG_OBJ.programTitle = "--"
    end if

end function

function HTTP_getFavorites(o, IDs)

    print "LOADING FAVORITES"

    url = "http://www.mtatechnosys.com/vimeo2/zypychannel/allroku/zypytv"
     
    print "URL: "; url
     
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.SetMessagePort(port)
    request.SetUrl(url)
    
    if(request.AsyncGetToString())  
     
        while (true)
        
              msg = wait(0, port)
    
              if(type(msg) = "roUrlEvent")
                
                    code = msg.GetResponseCode()
                    print "STATUS --- >: "; code
                    json = ParseJSON(msg.GetString())
                    
                    if(code = 200)
                        
                        print "ID LIST : "; IDs
                        
                        for each item in json.info
                        
                            if(IDs.Instr(item["channel"]["id"]) > -1)
                            
                                print "LOADING FAVORITE ---> : "; item["channel"]["id"]
                            
                                CHANNEL = CreateObject("roAssociativeArray")
                                'print "CHANNEL : "; item["channel"]
                                CHANNEL.chNum = item["channel"]["channelNumber"]
                                CHANNEL.chName = item["channel"]["channelName"]
                                CHANNEL.chType = item["channel"]["channelType"]
                                CHANNEL.chDesc = item["channel"]["rokuDescription"]
                                CHANNEL.chDate = item["channel"]["rokuDescription"]
                                CHANNEL.chPosti = item["channel"]["posti"]
                                CHANNEL.chID = item["channel"]["id"]
                                CHANNEL.chThumb = item["channel"]["thumbmail"]
                                CHANNEL.chImg = item["channel"]["channelStrip"]
                                CHANNEL.chPlayList = []
                                CHANNEL.chAdds = []
                                
                                inc = 0
                                prgnum = 0
                                print " ----- > "; item["playlist"]
                                for each i in item["playlist"]
                                    print "API PLAY LIST : "; type(i)
                                    'if(type(i) <> "String" and i <> invalid)
                                    'print "---LIST ITEM : "; i.videoTitle
                                    'print "playlist ---> "; type(i) = "String"
                                    if(type(i) <> "String")
                                       if(i["videoDuration"] <> "0") 
                                            CHANNEL.chPlayList.push(i)
                                        end if
                                        print "SKIP ----- > "; 
                                    end if
                                    
                                end for
                                for each i in item["ads"]
                                    CHANNEL.chAdds.push(i)
                                end for
                                
                                if(CHANNEL.chPlayList.Count() > 0)
                                    o.EPG_OBJ.FAVORITE_CHANNELS.push(CHANNEL)
                                end if
                                
                            end if
                        
                        end for
                    
                    end if
                    
                  end if
                  
                  'o.EPG_OBJ.FAVORITE_CHANNELS_INDEX =  o.EPG_OBJ.FAVORITE_CHANNELS.Count() - 1
                  
                  exit while
            
            end while
            
     end if

end function

function http_getSkin(o)

    print "LOADING SKIN"

    url = "http://mtatechnosys.com/vimeo2/zypyskin.json"
     
    print "URL: "; url
     
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.SetMessagePort(port)
    request.SetUrl(url)
    
    if(request.AsyncGetToString())
    
         while (true)
        
              msg = wait(0, port)
    
              if(type(msg) = "roUrlEvent")
              
                    code = msg.GetResponseCode()
                    print "STATUS --- >: "; code
                    print msg.GetString()
                    json = ParseJSON(msg.GetString())
                    
                    if(json <> invalid)
                        print "skin 1"
                        loadSkin(o)
                    else
                        print "skin 2"
                        o.SKIN = ParseJson(json)
                    end if
              
              end if
         exit while     
         end while
    
    end if
    
end function

