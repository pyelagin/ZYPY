function EPG_DSP_timeLine(o)

    time = getTime(o)
    'timeScale(o) 'init global time arr
    '350
    
    o.EPG_OBJ.timeline_bg = {
            url: "pkg:/images/timeline_bg.png",
            TargetRect: {x:0, y:290, w:1280,h:40}
         }
         
    o.canvas.SetLayer(18, o.EPG_OBJ.timeline_bg)
    
    o.EPG_OBJ.time_lb = {
             Text: getClock(o)
             TextAttrs:{Font:o.family_18,
                    HAlign:"Center", VAlign:"Center",
                    Color: o.SKIN.SkinData.TimelineTextColor
                    Direction:"LeftToRight"}
                    TargetRect: {x:70, y:302, w:100, h:20}
             }
             
     o.canvas.SetLayer(19, o.EPG_OBJ.time_lb)
     
     TimeMarksArr = []
     x = 221 'inc 250
     for i = 0 to 3
     
        TimeMarksArr.push({ Color: o.SKIN.SkinData.TimelineTextColor, CompositionMode: "Source", TargetRect:{x:x,y:290,w:1,h:30} })
        print "TIME LINE X : "; x
        x = x + 250
     
     end for
     
     o.canvas.SetLayer(20, TimeMarksArr)
     
     'TimeDataArr = ["4:00pm","4:30pm","5:00pm","5:30pm","6:00pm"]
     TimeDataArr = []
     
     ap = "am"
     vl = 0  
     for i = time to time+2
        vl = i
        if(i > 12) 
            ap = "pm"
            vl = vl - 12
        end if
        min = getTime_MIN(o)
        'tm = min.ToStr()
        TimeDataArr.Push(vl.toStr()+":00" + ap)
        o.TIMEARR.push(vl.toStr()+":00" + ap)
        'tm = (min+5).ToStr()
        TimeDataArr.Push(vl.toStr()+":30" + ap)
        o.TIMEARR.push(vl.toStr()+":30" + ap)
        'tm = (min+10).ToStr()
        vl = vl + 1
        TimeDataArr.Push(vl.toStr()+":00" + ap)
        o.TIMEARR.push(vl.toStr()+":00" + ap)
        'tm = (min+15).ToStr()
        TimeDataArr.Push(vl.toStr()+":30" + ap)
        o.TIMEARR.push(vl.toStr()+":30" + ap)
        'tm = (min+20).ToStr()
        TimeDataArr.Push(vl.toStr()+":00" + ap)
        o.TIMEARR.push(vl.toStr()+":00" + ap)
     end for
     
     TimeLabelsArr = []
     x = 231 'inc 250
     for i = 0 to 3
     
        TimeLabelsArr.push({
             Text: TimeDataArr[i]
             TextAttrs:{Font:o.family_16,
                    HAlign:"Left", VAlign:"Center",
                    Color: o.SKIN.SkinData.TimelineTextColor
                    Direction:"LeftToRight"}
                    TargetRect: {x:x, y:305, w:50, h:20}
             })
        x = x + 250
     end for
     
     o.canvas.SetLayer(30, TimeLabelsArr)
     
     o.EPG_OBJ.playhead = {
            url: "pkg:/images/playhead.png",
            TargetRect: {x:o.EPG_OBJ.PLAYHEAD_X, y:320, w:13,h:338}
         }
     o.canvas.SetLayer(31, o.EPG_OBJ.playhead)
     
end function


function getTime(o)

    date = CreateObject("roDateTime")
    date.ToLocalTime()
    print "Time is now - Hours : "; date.GetHours()
    
    return date.GetHours()

end function

function getTime_MIN(o)

    date = CreateObject("roDateTime")
    date.ToLocalTime()
    return date.GetMinutes()

end function

function getClock(o)

    date = CreateObject("roDateTime")
    date.ToLocalTime()
    dArr = ["Sun","Mon","Tue","Wed","Thu", "Fri", "Sat"]
    day = dArr[date.GetDayOfWeek()]
    hh = date.GetHours()
    mm = date.GetMinutes()
    dt = "AM"
    if(hh > 12) 
        dt = "PM"
        hh = hh - 12
    end if
    
    min = mm.toStr()
    
    if(Len(min) = 1) min = "0" + min
    
    tStr = day + " " + hh.toStr() + ":" + min + dt
    
    return tStr

end function
