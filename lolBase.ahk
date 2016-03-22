clientOn(){
 ;prototype
}

clientInFocuse(){
 ;prototype
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

waitForClientFocuse(){
 ;prototype
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
