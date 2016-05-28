
function INIT_AppData()

    o = CreateObject("roAssociativeArray")
    
    o.FontInterface=CreateObject("roFontRegistry") 'create global font access
    o.Fontinterface.Register("pkg:/font/ProximaNova.otf")
    
    o.SCREEN_WIDTH = getScreenSize("w")
    o.SCREEN_HIGHT = getScreenSize("h")
    
    o.family_43 = o.FontInterface.Get("Proxima Nova Alt Cn Lt",43, true, false)
    o.family_32 = o.FontInterface.Get("Proxima Nova Alt Cn Lt",32, true, false)
    o.family_25 = o.FontInterface.Get("Proxima Nova Alt Cn Lt",25, true, false)
    o.family_21 = o.FontInterface.Get("Proxima Nova Alt Cn Lt",21, true, false)
    o.family_18 = o.FontInterface.Get("Proxima Nova Alt Cn Lt",18, true, false)
    o.family_16 = o.FontInterface.Get("Proxima Nova Alt Cn Lt",16, true, false)
    o.family_14 = o.FontInterface.Get("Proxima Nova Alt Cn Lt",14, true, false)
    o.family_12 = o.FontInterface.Get("Proxima Nova Alt Cn Lt",12, true, false)
    
    o.SKIN = invalid
    
    '********EPG Screeen***********
    
    o.EPG_OBJ = CreateObject("roAssociativeArray")
    
    
    '67 inc
    
    'last 395
    'favorite 462
    'channels 531
    
    o.EPG_OBJ.lastWatched_Y = 335
    o.EPG_OBJ.favorites_Y = 402
    o.EPG_OBJ.channels_Y = 469
    
    o.EPG_OBJ.channelIndex = 0
    o.EPG_OBJ.LEVEL = 0
    o.EPG_OBJ.min_level = 0
    o.EPG_OBJ.programIndex = 0
    
    o.EPG_OBJ.channels = []
    o.EPG_OBJ.favorites = []
    o.EPG_OBJ.lastviewed = []
    
    o.EPG_OBJ.time_lb = []
    o.EPG_OBJ.time_vl = []
    
    o.EPG_OBJ.programTitle = ""
    
    o.EPG_OBJ.currentURL = invalid
    o.EPG_OBJ.currentPrgID = invalid
    o.EPG_OBJ.currentPrgPosArr = invalid
    o.EPG_OBJ.currentPrgIndx = 0
    o.EPG_OBJ.currentPrgTitle = invalid
    
    o.EPG_OBJ.chLayers = []
    
    o.EPG_OBJ.loader = 0
    
    o.EPG_OBJ.info = 0
    
    
    '********CHANNEL OBJECTS************
    o.EPG_OBJ.currentChannel = CreateObject("roAssociativeArray")
    o.EPG_OBJ.LAST_CHANNEL = CreateObject("roAssociativeArray")
    o.EPG_OBJ.LAST_CHANNEL_PRG_INDEX = 0
    
    o.EPG_OBJ.CURRENT_CHANNEL = CreateObject("roAssociativeArray")
    o.EPG_OBJ.CURRENT_CHANNEL_PRG_INDEX = 0
    
    o.EPG_OBJ.FAVORITE_CHANNELS = []
    o.EPG_OBJ.FAVORITE_CHANNEL_PRG_INDEX = 0
    o.EPG_OBJ.FAVORITE_CHANNELS_INDEX = 0
    
    o.EPG_OBJ.PLAYER_MOD = "min"
    o.EPG_OBJ.PLAYHEAD_X = 221
    
    o.EPG_OBJ.CHANNEL_INDEX = 0
    o.EPG_OBJ.CHANNEL_LIMIT = 0
    
    
    
    o.EPG_OBJ.SELECT_MENU_INDEX = 0
    o.EPG_OBJ.SELECT_MENU = 0
    
    
    '********PLAYER ******************
    o.VIDEO_OBJ = CreateObject("roAssociativeArray")
    o.VIDEO_OBJ.x = 863
    o.VIDEO_OBJ.y = 100
    o.VIDEO_OBJ.w = 201
    o.VIDEO_OBJ.h = 229
    o.VIDEO_OBJ.STATE = "playing"
    o.VIDEO_OBJ.PLAYHEAD_X = 0
    o.VIDEO_OBJ.CURRENT_PLAYTIME = 1
    
    '*******OTHER**********
    o.CURRENT_CH_ID = 0
    o.UILEVEL = 2
    o.FIRST_CH_ID = 0
    o.CANNELS_INDEX = 0
    o.TIMEARR = []
    
    '**********************
    'o.SKIN = CreateObject("roAssociativeArray")
    'o.SKIN.SkinData = CreateObject("roAssociativeArray")
    'o.SKIN.SkinData.BackgroundImage = "pkg:/images/epg_bg_4.png"
    'o.SKIN.SkinData.ChannelNameColor = "#FFFFFF"
    'o.SKIN.SkinData.ChannelDescriptionColor = "#b5b5b7"
    'o.SKIN.SkinData.ProgramNameColor = "#b5b5b7"
    'o.SKIN.SkinData.TimelineTextColor = "#FFFFFF"
    'o.SKIN.SkinData.EPGBackgroundColor = "#311b92"
    'o.SKIN.SkinData.ChannelSectionBackgroudColor = "#230c5f"
    'o.SKIN.SkinData.ChannelSectionTextColor = "#FFFFFF"
    'o.SKIN.SkinData.ChannelBackgroundColor = "#151515"
    'o.SKIN.SkinData.ChannelProgramDefaultColor = "#323232"
    'o.SKIN.SkinData.ChannelProgramColor = "#4f198c"
    'o.SKIN.SkinData.ChannelSelectedProgramColor = "#752b9f"
    'o.SKIN.SkinData.ChannelTextColor = "#FFFFFF"
    
    'loadSkin(o)
    
    return o

end function

Function RegRead(key,section=invalid)
    If section=invalid section="Default"
    sec=CreateObject("roRegistrySection",section)
    If sec.Exists(key) Return sec.Read(key)
    Return invalid
End Function

Function RegWrite(key,val,section=invalid)
    If section=invalid section="Default"
    sec=CreateObject("roRegistrySection",section)
    sec.Write(key,val)
    sec.Flush() 'commit it
End Function

Function RegDelete(key,section=invalid)
    If section=invalid section="Default"
    sec=CreateObject("roRegistrySection",section)
    sec.Delete(key)
    sec.Flush()
    print "ID FLASHED"
End Function

function loadSkin(o)
    
    configDeatils = ReadAsciiFile("pkg:/skin/zypyskin.json")
    o.SKIN = ParseJson(configDeatils)
    
    'print "SKIN DATA: "; o.SKIN.SkinData.BackgroundImage
    
end function