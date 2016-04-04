#Include lolbase.ahk
 ;;todo:add summonners spell pick
 ;;todo:create a champion configuer
 ;;todo:detemin when the Que is finished
 ;;todo:install intelgent clickers to back up player enlu of auto-clickers
 
draftQueInit(){
   ;if(playButtonAvalible()){
   ;   if(gameType="Ranked")
   ;      startDraftRanked()
   ;   else if(gameType="Normal")
   ;      startDraftNormal()
   ;   else 
   ;      return

   ;   draft_selectPositions(position[1], position[2])
   ;}
   ;else 
   ;   waitForMatchMaking := true
         
   ;if(waitForMatchMaking){}
   ;}
   ;else{
   ;   WinGetPos,,, width, height, A 
   ;   while(pxlDistance(0.467*width, 0.891*height, 0x0060E0)< 40 ){                                     ;;Queue Up Button
   ;      Sleep, 500
   ;      WinWaitActive ahk_class ApolloRuntimeContentWindow
   ;   }
   ;   MouseClick, Left, 0.467*width, 0.891*height
   ;}   
}
draftQueWalkThrough(gameType, positions, champions, bans, waitForMatchMaking:=0){
   if(!clientOn())
      return
      
   if(draft_inMatchMaking() OR draft_acceptMatchButtonAvailable())
      return draft_matchMakingQueHandle(champions, bans, positions)
   if(!homeButtonAvalible())
      return draft_championSelectionHandle(champions, bans, positions)
      

   while(!draft_inMatchMaking() AND !draft_acceptMatchButtonAvailable()){ ;;add mor pixle test for match making detettion
      Sleep, 1000
      WinWaitActive ahk_class ApolloRuntimeContentWindow
   }

   
   return draft_matchMakingQueHandle(champions, bans, positions)
}

draft_matchMakingQueHandle(champions, bans, positions){
   loop {
       WinWaitActive ahk_class ApolloRuntimeContentWindow
       if(draft_acceptMatchButtonAvailable()){
          Sleep, 2000
          WinGetPos,,, width, height, A 
          if(draft_acceptMatchButtonAvailable())
             MouseCLick, Left, width*0.483, height*0.591
          ;todo:wait for other players to accept
          ;while((pixleDistance(x,y,0x______) < 40) AND !draft_inMatchMaking() AND !draft_acceptMatchButtonAvailable()){
          ;   WinWaitActive ahk_class ApolloRuntimeContentWindow
          ;   Sleep, 500
          ;}
          Sleep, 4000
          if(!draft_inMatchMaking() AND !draft_acceptMatchButtonAvailable())   
             return draft_championSelectionHandle(champions, bans, positions)    
      }
   }
}

draft_championSelectionHandle(champions, bans, positions){
   position := draft_findPosition() ;;todo:tighten this shit up
   if(position="")
      position := positions[1]
   else{
      Sleep, 4000
      draft_selectChampionIntent(champions, position)
   }
   
   while(draft_numberOfBans()<6){
      WinWaitActive ahk_class ApolloRuntimeContentWindow 
      if(draft_inMatchMaking() OR draft_acceptMatchButtonAvailable())
         return draft_matchMakingQueHandle(champions, bans, positions)
      if(draft_playerActive())
         draft_banChampion(bans)
      
      Sleep, 1000
   }
   
   while(TRUE){
      WinWaitActive ahk_class ApolloRuntimeContentWindow 
      if(draft_inMatchMaking() OR draft_acceptMatchButtonAvailable())
         return draft_matchMakingQueHandle(champions, bans, positions)   
      if(draft_playerActive())
         draft_selectChampion(champions, position)
      ;;todo: determen when game starts loading   
      Sleep, 1000
   }
}

draft_inMatchMaking(){
   WinGetPos,,, width, height, A 
   return (pixleDistance(width*0.445, height*0.319, 0x263D4B) < 80)
}

draft_acceptMatchButtonAvailable(){
   WinGetPos,,, width, height, A 
   return (pixleDistance(width*0.483, height*0.591, 0x0053CA) < 80)
}

;;performs clicks nesisary to select the two positions befor Que
draft_selectPositions(primary, secondary){
   WinGetPos,,, width, height, A 
   MouseClick,,width*0.468, height*0.641
   Sleep, 700
   
   if(primary="fill"){
      MouseClick,,width*0.473, height*0.755
      return
   }
   if(primary="top")
      MouseClick,,width*0.396, height*0.639
   if(primary="mid")
      MouseClick,,width*0.277, height*0.519
   if(primary="jung")
      MouseClick,,width*0.412, height*0.561
   if(primary="supp")
      MouseClick,,width*0.528, height*0.547
   if(primary="bot")
      MouseClick,,width*0.557, height*0.641
      
   Sleep, 700
   MouseClick,,width*0.529, height*0.634
   Sleep, 700
   
   if(secondary="fill")
      MouseClick,,width*0.532, height*0.705
   if(secondary="top")
      MouseClick,,width*0.458, height*0.642
   if(secondary="mid")
      MouseClick,,width*0.527, height*0.538
   if(secondary="jung")
      MouseClick,,width*0.466, height*0.592
   if(secondary="supp")
      MouseClick,,width*0.609, height*0.564
   if(secondary="bot")
      MouseClick,,width*0.616, height*0.648
      
   Sleep, 700
}
;;iterate throught ban icons and count borders
draft_numberOfBans(){
   WinGetPos,,, width, height, A 
   bans := 0
   
   loop, 3{
      if(pixleDistance(width*(0.042*A_Index + 0.1475), height*0.0625, 0xA0A0A0) < 200)
         bans++
      if(pixleDistance(width*(0.042*A_Index + 0.6895), height*0.0828, 0x507070) < 200)
         bans++
   }
   
   return bans
}
;;iterate through team roster looking for the active player icon
draft_playerActive(){
   WinGetPos,,, width, height, A 
   loop, 5 {
      if(pixleDistance(width*0.007 ,height*(0.096 + 0.08*A_Index), 0x0070F0) < 80)
         return true
   }
   return false
}

draft_findPosition(){ ;;todo:this method must be more sensetive to its operating environment
   while(draft_numberOfBans()=0 AND !draft_inMatchMaking() AND !draft_acceptMatchButtonAvailable() AND !draft_playerActive()){
      WinGetPos,,, width, height, A 
      if(pixleDistance(x, y, 0x_orange)<50) ;todo complete map and discover proper color of orange
         return "top"
      if(pixleDistance(x, y, 0x_orange)<50) ;todo complete map and discover proper color of orange
         return "mid"
      if(pixleDistance(x, y, 0x_orange)<50) ;todo complete map and discover proper color of orange
         return "jung"
      if(pixleDistance(x, y, 0x_orange)<50) ;todo complete map and discover proper color of orange
         return "supp"
      if(pixleDistance(x, y, 0x_orange)<50) ;todo complete map and discover proper color of orange
         return "bot"
      WinWaitActive ahk_class ApolloRuntimeContentWindow 
   }
   return ""
}


draft_selectChampionIntent(champions, position){
   WinGetPos,,, width, height, A 
   for champion in champions {
      if(champion["position"] != position OR  champion["position"] != "fill") 
         continue
      if(!lolClick(0.621, 0.678, 0.166, 0.193, 2, 300, 500))             ;;click search bar and enter intent
         return
      if(!clientInFocuse())
         return
      name := champion.name
      Send, %name%
      lolClick(0.307, 0.358, 0.231, 0.194, 1, 500)             ;;click champion icon
      return
   }
}

draft_banChampion(bans){   
   for ban, value in bans {
      if(!lolClick(0.663, 0.674, 0.121, 0.149, 2, 300, 500))                      ;;click search bar and enter ban
         return
      if(!clientInFocuse())
         return
      Send, %ban%
      if(!lolClick(0.310, 0.350, 0.190, 0.268, 1, 350, 450))                      ;;click champion icon
         return
      if(!lolClick(0.433, 0.568, 0.743, 0.785, 1, 1000))                       ;;click ban button
         return
      if(!draft_playerActive())                                                 ;;ban complete
         return
   }
}

draft_selectChampion(champions, position){
   for champion in champions {
      if(champion["position"] != position OR  champion["position"] != "fill")
         continue
      if(!lolClick(0.621, 0.678, 0.166, 0.193, 2, 300, 500))                      ;;click search bar and enter champion
         return
     name := champion.name
     Send, %name%
     if(!lolClick(0.307, 0.358, 0.231, 0.194, 1, 500))                         ;;click champion icon
         return
      if(!lolClick(0.433, 0.568, 0.743, 0.785, 1, 1000))                           ;;click button
         return
      if(!draft_playerActive())                                                 ;;champion select complete
         return
   }   
}
