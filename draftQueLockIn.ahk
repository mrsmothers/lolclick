#Include lolbase.ahk
 ;;todo:add summonners spell pick
 ;;todo:create a champion configuer
 ;;todo:detemin when the Que is finished
 ;;todo:install intelgent clickers to back up player enlu of auto-clickers
 
draftQueWalkThrough(positions, champions, bans){
   if(!clientOn())
      return
      
   if(!homeButtonAvalible())
      return draft_championSelectionHandle(positions, champions, bans)

   while(!draft_inMatchMaking() AND !draft_acceptMatchButtonAvailable()){ ;;todo:add mor pixle test for match making detettion
      Sleep, 1000
      WinWaitActive ahk_class ApolloRuntimeContentWindow
   }
   
   return draft_matchMakingQueHandle(positions, champions, bans)
}

draft_matchMakingQueHandle(positions, champions, bans){
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
             return draft_championSelectionHandle(positions, champions, bans)    
      }
   }
}

draft_championSelectionHandle(positions, champions, bans){
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
         return draft_matchMakingQueHandle(positions, champions, bans)
      if(draft_playerActive())
         draft_banChampion(bans)
      
      Sleep, 1000
   }
   
   while(TRUE){
      WinWaitActive ahk_class ApolloRuntimeContentWindow 
      if(draft_inMatchMaking() OR draft_acceptMatchButtonAvailable())
         return draft_matchMakingQueHandle(positions, champions, bans)   
      if(draft_playerActive())
         draft_selectChampion(champions, position)
      ;;todo: determen when game starts loading   
      Sleep, 1000
   }
}

draft_inMatchMaking(){
   WinGetPos,,, width, height, A 
   return (pixleDistance(width*0.445, height*0.319, 0x204050) < 80)
}

draft_acceptMatchButtonAvailable(){
   WinGetPos,,, width, height, A 
   return (pixleDistance(width*0.483, height*0.591, 0x0050D0) < 80)
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
   WinGetPos,,, width, height
   while(draft_numberOfBans()=0 AND !draft_inMatchMaking() AND !draft_acceptMatchButtonAvailable() 
            AND !draft_playerActive() AND pixleDistance(width*0.299, height*0.063, 0x302010) > 40){
            
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
