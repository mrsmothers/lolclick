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
         while(!draft_acceptMatchButtonAvalible())
            Sleep, 2000
      }
      if(draft_acceptMatchButtonAvalible())
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
   Sleep, 2000 ;look at this sleep its so seksie
   draft_selectChampion("intent", champions, position)
   
   while(draft_numberOfBans()<6){
      if(draft_inMatchMaking() OR draft_acceptMatchButtonAvalible())
         return draft_matchMakingQueHandle()
      if(draft_playerActive())
         draft_selectChampion("ban", bans)
      
      Sleep, 1000
   }
   
   while(TRUE){
      if(draft_inMatchMaking() OR draft_acceptMatchButtonAvalible())
         return draft_matchMakingQueHandle()   
      if(draft_playerActive())
         draft_selectChampion("championSelection", champions, position)
      Sleep, 1000
   }
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
   bans := 0
   
   loop, 3{
      if(pixleDistance(x1, n1+p*A_Index, 0x______) < 40)
         bans++
      if(pixleDistance(x2, n2+p*A_Index, 0x______) < 40)
         bans++
   }
   
   return bans
}

 ;todo:finish logic
draft_playerActive(){
   loop, 5 {
      if(pixleDistance(9, n+p*A_Index, 0x______) < 40)
         return true
   }
   return false
}

draft_findPosition(){
   while(draft_numberOfBans()=0 AND !draft_inMatchMaking() AND !draft_acceptMatchButtonAvalible() AND !draft_playerActive()){
      if(pixleDistance(x, y, 0x_orange)<50) ;todo complete map and discover proper color of orange
         return "position"
      if(pixleDistance(x, y, 0x_orange)<50) ;todo complete map and discover proper color of orange
         return "position"
      if(pixleDistance(x, y, 0x_orange)<50) ;todo complete map and discover proper color of orange
         return "position"
      if(pixleDistance(x, y, 0x_orange)<50) ;todo complete map and discover proper color of orange
         return "position"
      if(pixleDistance(x, y, 0x_orange)<50) ;todo complete map and discover proper color of orange
         return "position"         
   }
   return "draft_findPosition() Error"
}

draft_selectChampion(gamePhase, champions, position :=""){
   if(gamePhase="intent"){
      for champ in champions {
         if(champ["position"] != position OR  champ["position"] != "fill")
            continue
            
         MouseMove xy             ;;click search bar and enter intent
         Sleep, 500
         if(!clientInFocuse())
            return
         click
         Send %champ["name"]%
         
         MouseMove xy             ;;click champion icon
         Sleep, 500
         if(!clientInFocuse())
            return
         click            
   }
   else if(gamePhase="ban"){
      for ban, value in champions {
         MouseMove xy             ;;click search bar and enter ban
         Sleep, 500
         if(!clientInFocuse())
            return
         click
         Send %ban%
         
         MouseMove xy             ;;click champion icon
         Sleep, 500
         if(!clientInFocuse())
            return
         click         
         
         MouseMove xy             ;;click ban button
         Sleep, 500
         if(!clientInFocuse())
            return
         click             
         
         if(!draft_playActive())       ;ban complete
            return
      }
   }
   else if (gamePhase="championSelection"){
      for champ in champions {
         if(champ["position"] != position OR  champ["position"] != "fill")
            continue
         MouseMove xy             ;;click search bar and enter champion
         Sleep, 500
         if(!clientInFocuse())
            return
         click
         Send %champ["name"]%
         
         MouseMove xy             ;;click champion icon
         Sleep, 500
         if(!clientInFocuse())
            return
         click         
         
         MouseMove xy             ;;click button
         Sleep, 500
         if(!clientInFocuse())
            return
         click             
         
         if(!draft_playActive())       ;champion select complete
            return
      }   
   }
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
   if(primary="jung" OR primary="jungle"){
      click
   }
   if(primary="supp" OR primary="support"){
      click
   }
   if(primary="bot" OR primary="adc"){
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
   if(secondary="jung" OR secondary="jungle"){
      Click
   }
   if(secondary="supp" OR secondary="support"){
      Click
   }
   if(secondary="bot" OR secondary="adc"){
      Click
   }
}
