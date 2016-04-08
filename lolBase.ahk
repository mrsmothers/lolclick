clientOn(){
  if WinExist(" ahk_class ApolloRuntimeContentWindow") {
     WinActivate ahk_class ApolloRuntimeContentWindow
     return true
  }
  else
     return false
}

clientInFocuse(){
   IfWinActive ahk_class ApolloRuntimeContentWindow
      return true
   else 
      return false
}

clickHomeButton(){
   WinGetPos,,,width, height, A
   MouseClick,,0.034*width, 0.041*height
}

clickPlayButton(){
  WinGetPos,,,width, height, A
  MouseClick,,.5*width,0.05*height
}

homeButtonAvalible(){
   WinGetPos,,,width, height, A
   return (pixleDistance(0.0342*width, 0.0406*height, 0x5BA1B6) < 80)
}

playButtonAvalible(){
   WinGetPos,,,width,height, A
   return (pixleDistance(0.459*width, 0.0344*height, 0x1440B8) < 80)
}

startDraftQue(gameType, position){
   if(playButtonAvalible())
   
   if(gameType="Ranked")
      startDraftRanked()
   else if(gameType="Normal")
      startDraftNormal()
   else 
      return

   draft_selectPositions(position[1], position[2])

   WinGetPos,,, width, height, A 
   while(pxlDistance(0.467*width, 0.891*height, 0x0060E0)< 40 ){                                     ;;Queue Up Button
      Sleep, 500
      WinWaitActive ahk_class ApolloRuntimeContentWindow
   }
   MouseClick, Left, 0.467*width, 0.891*height
}

;;performs clicks nesisary to select the two positions befor Que
draft_selectPositions(primary, secondary){
   WinGetPos,,, width, height, A 
   MouseClick,,width*0.468, height*0.641
   Sleep, 700
   
   if(primary="fill"){
      MouseClick,,width*0.473, height*0.755
      return
   }
   if(primary="top")
      MouseClick,,width*0.396, height*0.639
   if(primary="mid")
      MouseClick,,width*0.277, height*0.519
   if(primary="jung")
      MouseClick,,width*0.412, height*0.561
   if(primary="supp")
      MouseClick,,width*0.528, height*0.547
   if(primary="bot")
      MouseClick,,width*0.557, height*0.641
      
   Sleep, 700
   MouseClick,,width*0.529, height*0.634
   Sleep, 700
   
   if(secondary="fill")
      MouseClick,,width*0.532, height*0.705
   if(secondary="top")
      MouseClick,,width*0.458, height*0.642
   if(secondary="mid")
      MouseClick,,width*0.527, height*0.538
   if(secondary="jung")
      MouseClick,,width*0.466, height*0.592
   if(secondary="supp")
      MouseClick,,width*0.609, height*0.564
   if(secondary="bot")
      MouseClick,,width*0.616, height*0.648
      
   Sleep, 700
}

Champion(name, position, summoners1, summoners2){
   return { "name":name, "position":position, "summoners1":summoners1, "summoners2":summoners2}
}

lolclick(x1, x2, y1, y2, numClicks:=1, minTime:=0, maxTime:=0){
   WinGetPos,,, width, height, A 
   Random, x, x1*width, x2*width
   Random, y, y1*height, y2*height
   MouseMove x, y   
   
   if(maxTime=0)
      slpTime:=minTime
   else
      Random, slpTime, minTime, maxTime         
   Sleep, slpTime
   IFWinNotActive ahk_class ApolloRuntimeContentWindow
      return false
   MouseClick,, x, y, numClicks
}

pixleDistance(x,y, c1){
 ; function by [VxE], return value range = [0, 441.67295593006372]
  pixelGetColor, c2, x, y 
   r1 := c1 >> 16
   g1 := c1 >> 8 & 255
   b1 := c1 & 255
   r2 := c2 >> 16
   g2 := c2 >> 8 & 255
   b2 := c2 & 255
   return Sqrt( (r1-r2)**2 + (g1-g2)**2 + (b1-b2)**2 )
}

imageMatch(x, y, imgSrc){
 ;prototype
}
