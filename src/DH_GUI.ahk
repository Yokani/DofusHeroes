; skip running this script
goto exGUI

; Labels
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================

DButton:
	GuiControl,mainWindowG:Focus, DButt
	return

DButtonT:
	GuiControl,tracker:Focus, DButtT
	return

loadGUI:
	Gui, +LastFound
	
	Gui, mainWindowG:Show
	WinSet, Transparent, 230, %mainWindowTitle%
	return

initGUI:
	Gui, mainWindowG:Font, cBlack s12 norm, Copperplate Gothic Bold
	if(inclusionMode = 0){
		Gui, mainWindowG:Add, Tab3, x5 y5 w700 Buttons cBlack, Characters|Hotkeys|Optimizer|Track-n-Traveler
	}else if(inclusionMode = 1){
		Gui, mainWindowG:Add, Tab3, x5 y5 w700 Buttons cBlack, Characters|Hotkeys|Optimizer
	}else{
		Gui, mainWindowG:Add, Tab3, x5 y5 w700 Buttons cBlack, Characters|Hotkeys
	}

	Gui, mainWindowG:Tab, 1
	
	; Character Initiative Section
	Gui, mainWindowG:Font, cBlack s14 norm, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Text, x100 y50, Characters by Initiative Order
	Gui, mainWindowG:Font, cBlack s12 norm, Copperplate Gothic Bold

	Loop, 8
	{
		Gui, mainWindowG:Add, Button, x10 y+20 h40 gUp%A_Index%, 🡅
		Gui, mainWindowG:Add, Button, x+10 yp h40 gDown%A_Index%, 🡇
		Gui, mainWindowG:Add, Text, x+10 yp h40 0x200, %A_Index%.
		Gui, mainWindowG:Font, cBlack s12 norm, Cambria
		Gui, mainWindowG:Add, Edit, vEIni%A_Index% gUpdateVars -WantReturn +hwndHEDIT -VScroll limit40 0x201 x+5 yp w250 h40
		Edit_VCENTER(HEDIT)
		Gui, mainWindowG:Font, cBlack s12 norm, Copperplate Gothic Bold
	}
	Loop, 8
	{
		if(A_Index = 1){
			Gui, mainWindowG:Add, CheckBox, vAIni%A_Index% gUpdateVars x450 y90 h40, active?
			Gui, mainWindowG:Add, CheckBox, vAutoSwitchIni%A_Index% gUpdateVars x+10 yp h40, autoSwitch?
		}else{
			Gui, mainWindowG:Add, CheckBox, vAIni%A_Index% gUpdateVars x450 y+20 h40, active?
			Gui, mainWindowG:Add, CheckBox, vAutoSwitchIni%A_Index% gUpdateVars x+10 yp h40, autoSwitch?
		}
	}
	Loop, 8
	{
		if A_Index = 1
			Gui, mainWindowG:Add, Radio, vMainCheck%A_Index% gUpdateVars x360 y90 h40, main?
		else
			Gui, mainWindowG:Add, Radio, vMainCheck%A_Index% gUpdateVars x360 y+20 h40, main?
	}

	Gui, mainWindowG:Tab, 2
	; Hotkey Section
	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, mainWindowG:Add, GroupBox, x5 y40 w680 h90, Dofus End-Of-Turn Shortcut
	Gui, mainWindowG:Add, Radio, vDofusEndOfTurnButtonDDLCheck gUpdateVars xp+5 yp+25, use fixed
	Gui, mainWindowG:Add, Radio, vDofusEndOfTurnButtonHKCheck gUpdateVars xp y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vDofusEndOfTurnButtonDDL gUpdateVars x+10 yp-35 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vDofusEndOfTurnButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-30 w450 ReadOnly -E0x200 -VScroll, Your End-Of-Turn Button in Dofus.`nSet it up in the game under Options>Shortcuts>Fight: "End the turn". Then enter the corresponding key here.
	
	Gui, mainWindowG:Add, GroupBox, x5 y+10 w680 h130, Heroes End-Of-Turn Shortcut
	Gui, mainWindowG:Add, Radio, vHeroesEndOfTurnButtonDDLCheck gUpdateVars xp+5 yp+45, use fixed
	Gui, mainWindowG:Add, Radio, vHeroesEndOfTurnButtonHKCheck gUpdateVars xp y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vHeroesEndOfTurnButtonDDL gUpdateVars x+10 yp-35 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vHeroesEndOfTurnButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-50 w450 ReadOnly -E0x200 -VScroll, HeroesEndOfTurnFunctionality:`nThis Hotkey sends your Dofus End-Of-Turn Button (specified above) to the current window. If "autoSwitch?" is enabled for the current character the next characters window depending on the initiative order is brought to front automatically.

	Gui, mainWindowG:Add, GroupBox, x5 y+5 w680 h90, Next Hero Shortcut
	Gui, mainWindowG:Add, Radio, vSwitchNextButtonDDLCheck gUpdateVars xp+5 yp+25, use fixed
	Gui, mainWindowG:Add, Radio, vSwitchNextButtonHKCheck gUpdateVars xp y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vSwitchNextButtonDDL gUpdateVars x+10 yp-35 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vSwitchNextButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-20 w450 ReadOnly -E0x200 -VScroll, This Hotkey switches to the next "Active?" character window according to the initiative order.

	Gui, mainWindowG:Add, GroupBox, x5 y+15 w680 h90, Former Hero Shortcut
	Gui, mainWindowG:Add, Radio, vSwitchLastButtonDDLCheck gUpdateVars xp+5 yp+25, use fixed
	Gui, mainWindowG:Add, Radio, vSwitchLastButtonHKCheck gUpdateVars xp y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vSwitchLastButtonDDL gUpdateVars x+10 yp-35 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vSwitchLastButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-20 w450 ReadOnly -E0x200 -VScroll, This Hotkey switches to the former "Active?" character window according to the initiative order.

	Gui, mainWindowG:Add, GroupBox, x5 y+15 w550 h70, Certain Hero Shortcut
	Gui, mainWindowG:Add, DropDownList, vControlKey gUpdateVars xp+5 yp+25 w90, Shift|Alt|Ctrl
	Gui, mainWindowG:Add, Edit, x+10 yp w440 ReadOnly -E0x200 -VScroll, This Key + a number brings the corresponding characters window to the front.

	Gui, mainWindowG:Add, Button, vHelpButton gRunHelp x+25 yp w90, Help Me!

	Gui, mainWindowG:Tab
	Gui, mainWindowG:Tab, 3
	; Extras Section
	Gui, mainWindowG:Add, Button, x0 w0 h0 default vDButt gDButton

	Gui, mainWindowG:Add, GroupBox, x5 y40 w680 h90, Heroes Battle Start Shortcut
	Gui, mainWindowG:Add, Radio, vStartBattleButtonDDLCheck gUpdateVars xp+5 yp+25, use fixed
	Gui, mainWindowG:Add, Radio, vStartBattleButtonHKCheck gUpdateVars xp y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vStartBattleButtonDDL gUpdateVars x+10 yp-35 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vStartBattleButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-20 w450 ReadOnly -E0x200 -VScroll, This Hotkey starts the battle for all "Active?" characters by sending the Dofus-End-Of-Turn key to their windows.
	
	Gui, mainWindowG:Add, GroupBox, x5 y+15 w680 h90, Heroes Left Click Shortcut
	Gui, mainWindowG:Add, Radio, vLeftClickButtonDDLCheck gUpdateVars xp+5 yp+25, use fixed
	Gui, mainWindowG:Add, Radio, vLeftClickButtonHKCheck gUpdateVars xp y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vLeftClickButtonDDL gUpdateVars x+10 yp-35 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vLeftClickButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-25 w450 ReadOnly -E0x200 -VScroll, This Hotkey performs a LEFT-CLICK in all "Active?" character windows at the current mouse position.

	fjexplanation2 = Use the hotkey below (once!) in order to set the mouse position of the join message popup on one of your characters when someone else of the group enters a fight.`nMake sure that the Dofus window is focused, because the coordinates are different if not.`nAfter setting the right position I suggest clearing the hotkey by clicking the input field and pressing RETURN, so you don't accidently press it again and reset the position!
	Gui, mainWindowG:Font, cBlack s14 underline, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Text, x20 y+25, FightJoiner:
	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, mainWindowG:Add, Edit, x20 y+20 w600 ReadOnly -E0x200 -VScroll, %fjexplanation2%

	Gui, mainWindowG:Add, Text, x20 y+10, Set Coordinates on
	Gui, mainWindowG:Add, Hotkey, x+10 yp w100 vSetButton gUpdateVars

	Gui, mainWindowG:Font, cBlack s12 bold, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Edit, vCoords x+10 yp w450 ReadOnly -E0x200 -VScroll, Currently: %joinX%, %joinY%
	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold
	
	Gui, mainWindowG:Add, Radio, vJoinButtonDDLCheck gUpdateVars x10 y+20, use fixed
	Gui, mainWindowG:Add, Radio, vJoinButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vJoinButtonDDL gUpdateVars x+10 yp-40 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, xp y+10 w90 vJoinButtonHK gUpdateVars
	Gui, mainWindowG:Add, Edit, x+10 yp-30 w350 ReadOnly -E0x200 -VScroll, On this button all characters, whose windows are not focused click at the above set mouse position, in order to join the fight of the current character.

	; FindText section 
	Gui, mainWindowG:Tab
	Gui, mainWindowG:Tab, 4

	; find stuff section
	Gui, mainWindowG:Font, cBlack s14 underline, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Text, x20 y40, Dofus Heroes Track-n-Traveler:
	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, mainWindowG:Add, Button, x20 y+10 gtrackerStart, Start or Stop  Track-n-Traveler
	Gui, mainWindowG:Add, Text, x+10 yp+5 vTracker, Currently not tracking

	Gui, mainWindowG:Font, cBlack s14 underline, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Text, x20 y+30, FindText script by FeiYue
	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, mainWindowG:Add, Button, x20 y+10 gstartFindTextGUI, Run FindText
	Gui, mainWindowG:Add, CheckBox, vStopIfFound gQuickUpdateVars x+25 yp h25, stop traveling when spotting something

	Gui, mainWindowG:Add, Text, x40 y+10, Text output of FindText
	Gui, mainWindowG:Add, Text, x340 yp, GetRange output
	Gui, mainWindowG:Add, Text, x540 yp, Error
	Gui, mainWindowG:Add, Text, x640 yp, active
	Gui, mainWindowG:Font, cBlack s8 norm, Arial

	Loop, 3
	{
		Gui, mainWindowG:Add, Edit, vFTScan%A_Index% gQuickUpdateVars x20 y+5 w300 h25,
		Gui, mainWindowG:Add, Edit, vFTRange%A_Index% gQuickUpdateVars x+5 yp w200 h25,
		Gui, mainWindowG:Add, Edit, vFTError%A_Index% gQuickUpdateVars x+5 yp w100 h25,
		Gui, mainWindowG:Add, CheckBox, vFTCheck%A_Index% gQuickUpdateVars x+25 yp h25,
	}
	Gui, mainWindowG:Font, cBlack s12 underline, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Text, x70 y+20, Coordinate Setup
	
	

	Gui, mainWindowG:Font, cBlack s8 norm, Arial
	Gui, mainWindowG:Add, Button, x+10 yp h20 gtestCurrentCoords, test it!
	Gui, mainWindowG:Add, Edit, vCoordSetupRange gQuickUpdateVars x325 yp w200 h20,
	Gui, mainWindowG:Add, Edit, vCoordSetupError gQuickUpdateVars x+5 yp w100 h20,
	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, mainWindowG:Add, Text, x40 y+10, Text output of FindText for coordinate detection

	Gui, mainWindowG:Font, cBlack s8 norm, Arial
	eLabels := ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", ","]
	Loop, 12
	{
		if(Mod(A_index, 2) = 1){
			nIDX := A_Index + 1
			Gui, mainWindowG:Add, Text, x20 y+1 w10 h20,% eLabels[A_Index]
			Gui, mainWindowG:Add, Edit, x30 yp w250 h20 vCoordSetupT%A_Index% gQuickUpdateVars,
			Gui, mainWindowG:Add, Text, x+10 yp w10 h20,% eLabels[nIDX]
			Gui, mainWindowG:Add, Edit, xp+10 yp w250 h20 vCoordSetupT%nIDX% gQuickUpdateVars,
		}
	}
	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, mainWindowG:Add, Text, x40 y+10, Text output of FindText for GPS-Window detection

	Gui, mainWindowG:Font, cBlack s8 norm, Arial

	Gui, mainWindowG:Add, Text, x20 y+1 w20 h20, GPS
	Gui, mainWindowG:Add, Edit, vGPST gQuickUpdateVars x+5 yp w300 h20,
	Gui, mainWindowG:Add, Edit, vGPSRange gQuickUpdateVars x+5 yp w200 h20,

	Gui, mainWindowG:Add, Text, x20 y+1 w20 h20, OK
	Gui, mainWindowG:Add, Edit, vOKT gQuickUpdateVars x+5 yp w300 h20,
	Gui, mainWindowG:Add, Edit, vOKRange gQuickUpdateVars x+5 yp w200 h20,

	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, mainWindowG:Add, Text, x550 y40, Travel Mode
	Gui, mainWindowG:Add, Radio, vClipBoardMode  gQuickUpdateVars x550 y+10, clipboardMode
	Gui, mainWindowG:Add, Radio, vInsertMode gQuickUpdateVars x550 y+10, insertMode
	Gui, mainWindowG:Add, Text, x465 y100, shortcuts
	Gui, mainWindowG:Add, Text, x475 y+5, chat key
	Gui, mainWindowG:Add, Hotkey, vChatKey gQuickUpdateVars x550 yp w100,
	Gui, mainWindowG:Add, Text, x475 y+5, validate
	Gui, mainWindowG:Add, DropDownList, vValidateKey gQuickUpdateVars x550 yp w100, Enter

	Gui, mainWindowG:Color, 73b528, dfff80
	Gui, mainWindowG:Show, Center AutoSize Hide, %mainWindowTitle%
	
	return

startFindTextGUI:
	Run, %A_AHKPath% "src/DH_LIB_findtext.ahk"
	return

; Functions
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================

; catches minimize or close commands
WM_SYSCOMMAND(wParam){
	; window minimize button
	If wParam = 0xF020
	{
		Gui, mainWindowG:Hide
	}
	; window close button
	If wParam = 0xF060
	{
		ExitFunc()
	}
	Return
}

; Helper function for vertical aligned text
Edit_VCENTER(hWnd){
    static EM_GETRECT := 0x00B2    ; <- msdn.microsoft.com/en-us/library/bb761596(v=vs.85).aspx
    static EM_SETRECT := 0x00B3    ; <- msdn.microsoft.com/en-us/library/bb761657(v=vs.85).aspx
    VarSetCapacity(RC, 16, 0)
    DllCall("user32\GetClientRect", "ptr", hWnd, "ptr", &RC)
    CLHeight := NumGet(RC, 12, "int")
    DllCall("user32\SendMessage", "ptr", hWnd, "uint", EM_GETRECT, "ptr", 0, "ptr", &RC, "ptr")
    RCHeight := NumGet(RC, 12, "int") - NumGet(RC, 4, "int")
    DY := (CLHeight - RCHeight) + 5
    NumPut(NumGet(RC, 4, "int") + DY, RC, 4, "int")
    NumPut(NumGet(RC, 12, "int") + DY, RC, 12, "int")
    DllCall("user32\SendMessage", "ptr", hWnd, "uint", EM_SETRECT, "ptr", 0, "ptr", &RC, "ptr")
    return True
}

; weak stop of current auto travel by running the sit command
stopAutoTravel(windowName, chatKey, validateKey){
	fastChatCommand(windowName, "sit", chatKey, validateKey)
	return
}

; ==============================================================================================================================================================================

exGUI:
	; skip