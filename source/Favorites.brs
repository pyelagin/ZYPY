function EPG_DSP_favorites(o)
    
    
    o.canvas.SetLayer(232, { Color: "#230c5f", CompositionMode: "Source", TargetRect:{x:10,y:o.EPG_OBJ.favorites_Y,w:1280,h:17} })
    
    lbl = {
             Text: "FAVORITES"
             TextAttrs:{Font:o.family_12,
                    HAlign:"Left", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:17, y:o.EPG_OBJ.favorites_Y, w:100, h:20}
             }
    
    o.canvas.SetLayer(233, lbl)
    '151515 h:40
    
    o.canvas.SetLayer(234, { Color: "#151515", CompositionMode: "Source", TargetRect:{x:10,y:o.EPG_OBJ.favorites_Y+22,w:1280,h:39} })
    
    icon = {
            url: "pkg:/images/ch_icon_2.png",
            TargetRect: {x:10, y:o.EPG_OBJ.favorites_Y+22, w:162,h:39}
         }
    o.canvas.SetLayer(235, icon)
    
    'programs
    
    x = 162
    lblArr = []
    clr = "#323232"
    if(o.EPG_OBJ.LEVEL = 1) clr = "#752b9f"
    for i = 0 to 2
    
        if(i <> o.EPG_OBJ.programIndex and o.EPG_OBJ.LEVEL = 1) clr = "#4f198c"
    
        o.canvas.SetLayer(236+i, { Color: clr, CompositionMode: "Source", TargetRect:{x:x,y:o.EPG_OBJ.favorites_Y+22,w:400,h:39} })
        
        lblArr.push({
             Text: "Headline News"
             TextAttrs:{Font:o.family_16,
                    HAlign:"Left", VAlign:"Top",
                    Direction:"LeftToRight"}
                    TargetRect: {x:x+10, y:o.EPG_OBJ.favorites_Y+32, w:100, h:20}
             })
        o.canvas.SetLayer(337+i,  lblArr[i])
        
        x = x + 400 + 2
        
        if(o.EPG_OBJ.LEVEL = 1) clr = "#752b9f"
    end for
    
    
end function