clientOn(){
  if WinExist ahk_class ApolloRuntimeContentWindow {
     WinActivate ahk_class ApolloRuntimeContentWindow
     return true
  }
  else
     false
}

clientInFocuse(){
   IfWinActive ahk_class ApolloRuntimeContentWindow
      return true
   else 
      return false
}

clickHomeButton(){
 ;prototype
}

clickPlayButton(){
 ;prototype
}

homeButtonAvalible(){
 ;prtotype
}

playButtonAvalible(){
 ;prototype
}

startDraftNormalQue(){
 ;prototype
}

startDraftRankedQue(){
 ;prototype
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
   MouseClick, Left, 0.5*width, 0.04*height, numClicks
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
