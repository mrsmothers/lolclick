login(name, password){
   if(!WinExist("<!ahk_class name lol client>")){
      if(!WinExist("ahk_class LOLPATCHER")){
         Run, "<!location of lol client>"
         while(!WinExist("ahk_class LOLPATCHER"){
            if(winExist("<!rads error msg>")){
               WinAcitivte, <!rads error msg>
               Send, {ENTER}
               Sleep, 100 
               break
            }
         } 
      }
      WinActivate, ahk_class LOLPATCHER
      while(pixleDistance(599, 21, 0x1070C0) > .1 OR imageMatch(<! >))
         sleep, 500
      Click x,y
      WinWaitActive, <!ahk_class name lol client>
      Sleep, 8500
    }
  WinActivate, <!ahk_class name lol client>
  ;click x,y
  Send, %name%{TAB}%password%{ENTER}
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

pixleDistance(x,y, color){
 ;prototype
}

imageMatch(x, y, imgSrc){
 ;prototype
}
