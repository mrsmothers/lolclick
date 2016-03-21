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
   
   return draft_matchMakingQueHandle(champions, bans)
}

draft_matchMakingQueHandle(champions, bans){
   loop {
      if(draft_inMatchMaking()){
         while(!draft_acceptButtonAvalible())
            Sleep, 2000
      }
      if(draft_acceptButtonAvalible())
         click
      ;todo:wait for other players to accept
      while(!draft_inMatchMaking() AND !draft_enteringChampionSelect())
         Sleep, 200
      if(draft_enteringChampionSelect())
         return draft_champianSelectionHandle(champions, bans)
   }
}

draft_champianSelectionHandle(champions, bans){
   position := draft_findPosition()
   draft_selectChampion("intent", champions, position)
   
   while(draft_numberOfBans()<6){
      if(draft_playerActive()){
         draft_selectChampion("ban", bans)
      }
      Sleep, 1000
   }
   
   while(TRUE){
      if(draft_playerActive())
         draft_selectChampion("championSelection", champions, position)
}

draft_selectPositions(primary, secondary(){
 ;prototype
}

draft_inMatchMaking(){
 ;prototype
}

draft_acceptMatchButtonAvaliable(){
 ;prototype
}

draft_enteringChampionSelect(){
 ;prototype
}

draft_numberOfBans(){
 ;prototype
}
draft_findPosition(){
 ;prototype
}
