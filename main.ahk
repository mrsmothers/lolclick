userName := "mr5mother5"
userPassword := "mund05m85h"

^5::
   login(userName, userPassword)
Return

^t::
   kog := Champion("kog","adc","heal","flash")
   jinx := Champion("jinx", "adc", "heal", "flash")
   champ2 := Champion("lulu","support","exhaust","flash")
   leona = Champion("leona", "support", "egnight", "flash")
   
   positions := ["adc", "support"]
   champions := [kog, jinx, champ2, leona]
   bans      := ["mundo", "yas", "blitz"]
   
   draftQueLockIn("Normal", positions, champions, bans, false)
Return

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

classicSoloQueLockIn(GameType, champion){
   if(!clientOn())
      return
      
}

draftQueLockIn(gameType, positions, champions, bans, waitForMatchMaking){
   if(!clientOn())
      return
      
   if(gameType="Ranked")
      startDraftRanked()
   else if(gameType="Normal")
      startDraftNormal()
   else 
      return
      
   draft_selectPositions(position[1], position[2])
   
   if(waitForMatchMaking){
      while(!draft_inMatchMaking())
         Sleep, 500
   }
   else{
      while(!imageMatch("<!Queue Up Button>"))
         Sleep, 500
      Click x,y
      while(!draft_inMatchMaking() AND !draft_acceptMatchButtonAvalible())
         Sleep, 100
   }
   
   draft_matchMakingQueHandle(champions, bans)
}

draft_matchMakingQueHandle(champions, bans){
 ;prototype
}

draft_ChampianSelectHandle(champions, bans){
 ;prototype
}

draft_selectPositions(primary, secondary){
 ;prototype
}

draft_inMatchMaking(){
 ;prototype
}

draft_acceptMatchButtonAvaliable(){
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

pixleDistance(x,y, color){
 ;prototype
}

imageMatch(x, y, imgSrc){
 ;prototype
}
