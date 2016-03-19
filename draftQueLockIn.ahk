#Include lolbase.ahk

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
   if(draft_inMatchMaking()){
      while(!draft_acceptButtonAvalible())
         Sleep, 2000
   }
   click
   ;wait for other players to accept
   ;handle que reentry
   ;call draft_championSelectHandle
}

draft_champianSelectHandle(champions, bans){
  position := draft_findPosition()
  draft_selectChampion("intent", champions, position)
  
  while(draft_numberOfBans()<6){
     if(draft_playerActive()){
        draft_selectChampion("ban", bans
  
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

draft_findPosition(){
 ;prototype
}
