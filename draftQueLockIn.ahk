#Include lolbase.ahk

draftQueLockIn(gameType, positions, champions, bans, waitForMatchMaking:=0){
   if(!clientOn())
      return
      
   if(draft_inMatchMaking() OR draft_acceptButtonAvalible())
      return draft_matchMakingQueHandle()
   if(!homeButtonAvalible())
      return draft_championSelectionHandle()
      
   if(playButtonAvalible()){
      if(gameType="Ranked")
         startDraftRanked()
      else if(gameType="Normal")
         startDraftNormal()
      else 
         return

      draft_selectPositions(position[1], position[2])
   }
   else 
      waitForMatchMaking := true
         
   if(waitForMatchMaking){
      while(!draft_inMatchMaking() AND !draft_acceptButtonAvalible()){
         Sleep, 500
         WinWaitActive ahk_class ApolloRuntimeContentWindow
      }
   }
   else{
      while(pxlDistance(x, y, 0xORANGE)< 40 ){                                     ;;Queue Up Button
         Sleep, 500
         WinWaitActive ahk_class ApolloRuntimeContentWindow
      }
      Click x,y
      while(!draft_inMatchMaking() AND !draft_acceptButtonAvalible())              ;;could this be better
         Sleep, 100
   }
   
   return draft_matchMakingQueHandle(champions, bans)
}

draft_matchMakingQueHandle(champions, bans){
   loop {
      if(draft_inMatchMaking()){
         while(!draft_acceptMatchButtonAvalible()){
            Sleep, 2000
            WinWaitAcive ahk_class ApolloRuntimeContentWindow 
         }
      }
      
      if(draft_acceptMatchButtonAvalible()){
         Click
         ;todo:wait for other players to accept
         while(!draft_inMatchMaking()){
            if(draft_inChampionSelect())       ;; this could be better
               return draft_championSelectionHandle(champions, bans)      
            Sleep, 200
         }
      }
   }
}

draft_championSelectionHandle(champions, bans){
   if(draft_enteringChampionSelect()){
      position := draft_findPosition()
      draft_selectChampion("intent", champions, position)
   }
   
   while(draft_numberOfBans()<6){
      WinWaitAcive ahk_class ApolloRuntimeContentWindow 
      if(draft_inMatchMaking() OR draft_acceptMatchButtonAvalible())
         return draft_matchMakingQueHandle()
      if(draft_playerActive())
         draft_selectChampion("ban", bans)
      
      Sleep, 1000
   }
   
   while(TRUE){
      WinWaitAcive ahk_class ApolloRuntimeContentWindow 
      if(draft_inMatchMaking() OR draft_acceptMatchButtonAvalible())
         return draft_matchMakingQueHandle()   
      if(draft_playerActive())
         draft_selectChampion("championSelection", champions, position)
      ;;todo: determen when game starts loading   
      Sleep, 1000
   }
}

draft_inTeamArrange(){
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

draft_inChampionSelect(){
 ;prototype
}

draft_selectPositions(primary, secondary(){
   click
   if(primary="fill"){
      click ;;phill
      return
   }
   if(primary="top"){
      click
   }
   if(primary="mid"){
      click
   }
   if(primary="jungle"){
      click
   }
   if(primary="support"){
      click
   }
   if(primary="bot"){
      click
   }
   
   Click
   if(secondary="fill"){
      Click ;;phill
   }
   if(secondary="top"){
      Click
   }
   if(secondary="mid"){
      Click
   }
   if(secondary="jungle"){
      Click
   }
   if(secondary="support"){
      Click
   }
   if(secondary="bot"){
      Click
   }
}

draft_numberOfBans(){
   bans := 0
   
   loop, 3{
      if(pixleDistance(x1, n1+p*A_Index, 0x______) < 40)
         bans++
      if(pixleDistance(x2, n2+p*A_Index, 0x______) < 40)
         bans++
   }
   
   return bans
}

draft_playerActive(){
   loop, 5 {
      if(pixleDistance(9, n+p*A_Index, 0x______) < 40)
         return true
   }
   return false
}

draft_findPosition(){
   while(draft_numberOfBans()=0 AND !draft_inMatchMaking() AND !draft_acceptMatchButtonAvalible() AND !draft_playerActive()){
      if(pixleDistance(x, y, 0x_orange)<50){ ;todo complete map and discover proper color of orange
         Sleep, 2000
         return "position"
      }
      if(pixleDistance(x, y, 0x_orange)<50){ ;todo complete map and discover proper color of orange
         Sleep, 2000
         return "position"
      }
      if(pixleDistance(x, y, 0x_orange)<50){ ;todo complete map and discover proper color of orange
         Sleep, 2000
         return "position"
      }
      if(pixleDistance(x, y, 0x_orange)<50){ ;todo complete map and discover proper color of orange
         Sleep, 2000
         return "position"
      }
      if(pixleDistance(x, y, 0x_orange)<50){ ;todo complete map and discover proper color of orange
         Sleep, 2000
         return "position"
      }  
      WinWaitAcive ahk_class ApolloRuntimeContentWindow 
   }
   return "draft_findPosition() Error"
}

draft_selectChampion(gamePhase, champions, position :=""){
   if(gamePhase="intent"){
      for champ in champions {
         if(champ["position"] != position OR  champ["position"] != "fill")
            continue
            
         lolClick(x1, y1, x2, y2, numClicks:=1, minTime, maxTime:=0)             ;;click search bar and enter intent
         Send %champ["name"]%
         lolClick(x1, y1, x2, y2, numClicks:=1, minTime, maxTime:=0)             ;;click champion icon
         return
      }
   }
   else if(gamePhase="ban"){
      for ban, value in champions {
         lolClick(x1, y1, x2, y2, numClicks:=1, minTime, maxTime:=0)             ;;click search bar and enter ban
         Send %ban%
         lolClick(x1, y1, x2, y2, numClicks:=1, minTime, maxTime:=0)             ;;click champion icon
         lolClick(x1, y1, x2, y2, numClicks:=1, minTime, maxTime:=0)             ;;click ban button
         if(!draft_playActive())       ;ban complete
            return
      }
   }
   else if (gamePhase="championSelection"){
      for champ in champions {
         if(champ["position"] != position OR  champ["position"] != "fill")
            continue
         lolClick(x1, y1, x2, y2, numClicks:=1, minTime, maxTime:=0)             ;;click search bar and enter champion
         Send %champ["name"]%
         lolClick(x1, y1, x2, y2, numClicks:=1, minTime, maxTime:=0)             ;;click champion icon
         lolClick(x1, y1, x2, y2, numClicks:=1, minTime, maxTime:=0)             ;;click button
         if(!draft_playActive())       ;champion select complete
            return
      }   
   }
}
