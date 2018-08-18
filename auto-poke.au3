; Hotkeys to manually take over
HotKeySet("{F1}", "_exitScript")
HotKeySet("{F2}", "_runBattle")

; Colors
Global $g_colorHealth = 0x19AC36
Global $g_shinyPixel = 0xFFF200
Global $g_femalePixel = 0xE67BD8

; Array to store current encounter pixels
Global $g_aCurrentEncounter[2]
$g_aCurrentEncounter[0] = 0
$g_aCurrentEncounter[1] = 0

WinActivate("PokeOne")

While (1)
   ; Move user around to encounter Pokemon
   _moveUser()

   ; Check if encountered a Pokemon
   If _checkPokemonEncounter() Then
	  ; Check if it shiny Pokemon
	  If _checkShiny() Then
	  _exitScript()
	  Else
	  _runBattle()
	  ;_killPokemon()
	  EndIf
   EndIf
WEnd

; Function Name: _checkShiny
; Purpose: To check if an encounted Pokemon is shiny
Func _checkShiny()
   $g_aCurrentEncounter = PixelSearch(1931, 117, 2031, 141, $g_shinyPixel, 5)
   ;$g_aCurrentEncounter = PixelSearch(2013, 119, 2028, 139, $g_femalePixel, 5)
   If Not @error Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

; Function Name: _checkPokemonEncounter
; Purpose: To check if encountered a Pokemon
Func _checkPokemonEncounter()
   If PixelGetColor(2094, 161) == $g_colorHealth Then
	  Return True
   EndIf
   Return False
EndFunc

; Function Name: _runBattle
; Purpose: Click the 'Run' button when in a battle
Func _runBattle()
   MouseClick("left", 2609, 845, 1, 1)
EndFunc

; Function Name: _moveUser
; Purpose: Move the User around to encounter Pokemon
Func _moveUser()
   ;Move User left
   Send("{LEFT down}")
   Sleep(1000)
   Send("{LEFT up}")

   ;Move User right
   Send("{RIGHT down}")
   Sleep(1000)
   Send("{RIGHT up}")

   ;Move User down
   Send("{LEFT down}")
   Sleep(600)
   Send("{LEFT up}")

   ;Move User up
   Send("{LEFT down}")
   Sleep(300)
   Send("{LEFT up}")
EndFunc

; Function Name: _exitScript
Func _exitScript()
   msgbox(0, "Exiting", "Bot is quitting")
   Exit
EndFunc

