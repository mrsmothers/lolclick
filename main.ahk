#Include draftQueLockIn.ahk
#Include classicQueLockIn.ahk
#Include lolBase.ahk

userName := "mr5mother5"
userPassword := ""

^5::
   InputBox, pass, Password,,HIDE
   login(userName, pass)

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
   if(!WinExist("ahk_class ApolloRuntimeContentWindow")){
      if(!WinExist("ahk_class LOLPATCHER")){
         Run, "C:\Riot Games\League of Legends\lol.launcher.exe"
         while(!WinExist("ahk_class LOLPATCHER")){
            if(winExist("ahk_class #32770")){
               WinActivate, ahk_class #32770
               Send, {ENTER}
               Sleep, 100 
               break
            }
         } 
      }
      WinActivate, ahk_class LOLPATCHER
      while(pixleDistance(599, 21, 0x1070C0) > 40 ) ;todo:OR imageMatch(<! >)
         sleep, 500
      Click 599, 21
      WinWaitActive, ahk_class ApolloRuntimeContentWindow
      Sleep, 8500
    }
  WinActivate, ahk_class ApolloRuntimeContentWindow
  ;click x,y
  Send, %name%{TAB}%password%{ENTER}
}

pixleDistance(x,y, c1){
 ; function by [VxE], return value range = [0, 441.67295593006372]
  pixelGetColor, c2, x, y 
   r1 := c1 >> 16
   g1 := c1 >> 8 & 255
   b1 := c1 & 255
   r2 := c2 >> 16
   g2 := c2 >> 8 & 255
   b2 := c2 & 255
   return Sqrt( (r1-r2)**2 + (g1-g2)**2 + (b1-b2)**2 )
}
 
