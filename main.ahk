userName := "mr5mother5"
userPassword := "mund05m85h"

^5::
   login(userName, UserPassword)
Return

login(name, password){
   if(!WinExist("<!ahk_class name lol client>")){
      if(!WinExist("<!ahk_class lolpatcher>")){
         Run, "<!location of lol client>"
         while(!WinExist("<!ahk_class lolpatcher>")
            if(winExist("<!rads error msg>")){
               WinAcitivte, <!rads error msg>
               Send, {ENTER}
               Sleep, 100 
               break
            }
         } 
      }
      WinActivate, <!ahk_class lolpatcher>
      while(!imageMatch(<!image of button>))
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

draftQueLockIn(gameType, primaryPosition, secondaryPosition, waitForMatchMaking, bans, champions)
   if(!clientOn())
      return
      
   if(gameType="Ranked")
      startDraftRankedSolo()
   else if(gameType="Normal")
      startDraftNormalSolo()
   else 
      return
      
   draft_selectPositions(primaryPosition, secondaryPossition)
   
   if(waitForMatchMaking){
      while(!draft_inMatchMaking())
         Sleep, 500
   }
   else{
      while(!imageMatch())
         Sleep, 500
      Click x,y
      while(!draft_inMatchMaking() AND !draft_acceptMatchButtonAvalible())
         Sleep, 100
   }
   
   draft_matchMakingQueHandle(primaryPosition, secondaryPosition, bans, champions)
}

draft_matchMakingQueHandle(primaryPosition, secondaryPosition, bans, champions){
 ;prototype
}

draft_ChampianSelectHandle(primaryPosition, secondaryPosition, bans, champions){
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

imageMatch(x, y, imgSrc){
 ;prototype
}
