#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include draftQueLockIn.ahk
#Include classicQueLockIn.ahk
#Include lolBase.ahk

userName := ""
userPassword := ""
 ;;todo:defeat the eula
^5::
   if(userPassword="")
      InputBox,pass, AHK LOL Script, Password for %userName%,,HIDE
   else
      pass := userPassword
      
   login(userName, pass)
Return

^t::
   kog := Champion("kog","bot","heal","flash")
   jinx := Champion("jinx", "bot", "heal", "flash")
   champ2 := Champion("lulu","supp","exhaust","flash")
   leona := Champion("leona", "supp", "egnight", "flash")
   phill := Champion("kog", "fill", "heal", "flash")
   
   positions := ["adc", "supp"]
   champions := [kog, jinx, champ2, leona, phill]
   bans      := ["mundo", "yas", "blitz"]
   
   draftQueLockIn("Normal", positions, champions, bans, false)
Return

 ;;include eule detection
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
      WinGetPos,,, width, height, A 
      while(pixleDistance(.5*width, 0.04*height, 0x1070C0) > 80 ) ;todo:OR imageMatch(<! >)
         sleep, 500
      MouseClick, Left, 0.5*width, 0.04*height, 1
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
