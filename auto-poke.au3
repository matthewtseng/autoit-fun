; Hotkeys to manually take over
HotKeySet("{F1}", "_exit")
HotKeySet("{F2}", "_runBattle")

; TODO: Check small boxes every 60 minutes and collect,
;		need to take screenshots of each position

; Colors
Global $g_colorHealth = 0x19AC36
Global $g_shinyPixel = 0xFFF200
Global $g_femalePixel = 0xE67BD8

; Monitor
; Assuming first monitor resolution is 1920 x 1080
; *** MAKE SURE TO CHANGE THIS ***
Global $g_isMainMonitor = True;

; Array to store current encounter pixels
Global $g_aCurrentEncounter[2]
$g_aCurrentEncounter[0] = 0
$g_aCurrentEncounter[1] = 0

WinActivate("PokeOne")

If $g_isMainMonitor Then
   MsgBox(0,"Starting","Automation set for the main monitor, top left.")
Else
   MsgBox(0,"Starting","Automation set for the second monitor, top left.")
EndIf

While (1)
   ; Move user around to encounter Pokemon
   _moveUser()

   ; Check if encountered a Pokemon
   If _checkPokemonEncounter() Then
	  ; Check if it shiny Pokemon
	  If _checkShiny() Then
		 _exitShiny()
	  Else
		 _runBattle()
		 ;_killPokemon()
	  EndIf
   EndIf

   ;If _checkGift() Then
;_claimGift()
   ;EndIf
WEnd

; *********************************
;	POKEMON ENCOUNTER FUNCTIONS
; *********************************

; Function Name: _checkShiny
; Purpose: To check if an encounted Pokemon is shiny
Func _checkShiny()
   If $g_isMainMonitor Then
	  $g_aCurrentEncounter = PixelSearch(11, 37, 138, 57, $g_shinyPixel, 5)
   Else
	  $g_aCurrentEncounter = PixelSearch(1931, 117, 2031, 141, $g_shinyPixel, 5)
   EndIf

   If Not @error Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

; Function Name: _checkPokemonEncounter
; Purpose: To check if encountered a Pokemon
Func _checkPokemonEncounter()
   If $g_isMainMonitor Then
	  ; For main monitor, top left
	  ; Might be better to use PixelSearch because health bar composes different shades of green
	  If PixelGetColor(106, 77) == $g_colorHealth Then
		 Return True
	  EndIf
   Else
	  ; For second monitor, top left
	  If PixelGetColor(2094, 161) == $g_colorHealth Then
		 Return True
	  EndIf
   EndIf
   Return False
EndFunc

; Function Name: _runBattle
; Purpose: Click the 'Run' button when in a battle
Func _runBattle()
   If $g_isMainMonitor Then
	  MouseClick("left", 689, 761, 1, 1)
   Else
	  MouseClick("left", 2609, 845, 1, 1)
   EndIf
EndFunc

; Function Name: _moveUser
; Purpose: Move the User around to encounter Pokemon
Func _moveUser()
   ;Move User right
   Send("{RIGHT down}")
   Sleep(1000)
   Send("{RIGHT up}")

   ;Move User down
   Send("{DOWN down}")
   Sleep(600)
   Send("{DOWN up}")

   ;Move User left
   Send("{LEFT down}")
   Sleep(1000)
   Send("{LEFT up}")

   ;Move User up
   Send("{UP down}")
   Sleep(300)
   Send("{UP up}")
EndFunc

; *********************************
;		LOOT BOX FUNCTIONS
; *********************************

Func _checkGift()
   If Then
	  Return True
   EndIf
   Return False
EndFunc

Func _claimGift()
   ; Click on the gift and close screen
EndFunc

; *********************************
;			EXIT FUNCTIONS
; *********************************

; Function Name: _exit
; Purpose: Exit script
Func _exit()
   msgbox(0, "Exiting", "Bot is quitting")
   Exit
EndFunc

; Function Name: _exitShiny
; Purpose: Exit script when a shiny is found
Func _exitShiny()
   msgbox(0, "Exiting", "Shiny was found")
   Exit
EndFunc

