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
