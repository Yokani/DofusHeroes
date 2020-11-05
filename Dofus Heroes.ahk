#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force
OnExit("ExitFunc")

; Initialization
; ==============================================================================================================================================================================
; Includes, replaced by code in external script
; ================================================================
#Include, findtext.ahk
#Include, DHvariables.ahk
#Include, DHmainFunctions.ahk

goto scriptInit
; Labels
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================
DButton:
	GuiControl,mainWindowG:Focus, DButt
	return

DButtonS:
	GuiControl,amobTracker:Focus, DButtS
	return

loadGUI:
	Gui, mainWindowG:Show, Center AutoSize, %mainWindowTitle%
	return

initGUI:
	Gui, mainWindowG:Font, cBlack s12 norm, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Tab3, x5 y5 w700 Buttons cBlack, Characters|Hotkeys|Advanced|Track-n-Traveler
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
	Gui, mainWindowG:Add, Radio, vDofusEndOfTurnButtonDDLCheck gUpdateVars x10 y40, use fixed
	Gui, mainWindowG:Add, Radio, vDofusEndOfTurnButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vDofusEndOfTurnButtonDDL gUpdateVars x+10 yp-40 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vDofusEndOfTurnButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-30 w450 ReadOnly -E0x200 -VScroll, Your End-Of-Turn Button in Dofus.`nSet it up in the game under Options>Shortcuts>Fight: "End the turn". Then enter the corresponding key here.
	
	Gui, mainWindowG:Add, Radio, vHeroesEndOfTurnButtonDDLCheck gUpdateVars x10 y+20, use fixed
	Gui, mainWindowG:Add, Radio, vHeroesEndOfTurnButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vHeroesEndOfTurnButtonDDL gUpdateVars x+10 yp-40 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vHeroesEndOfTurnButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-30 w450 ReadOnly -E0x200 -VScroll, HeroesEndOfTurnFunctionality:`nThis Hotkey sends your Dofus End-Of-Turn Button (specified above) to the current window. If "autoSwitchOn?" is enabled for the current character the next characters window depending on the initiative order is brought to front automatically.
	
	Gui, mainWindowG:Add, Radio, vStartBattleButtonDDLCheck gUpdateVars x10 y+20, use fixed
	Gui, mainWindowG:Add, Radio, vStartBattleButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vStartBattleButtonDDL gUpdateVars x+10 yp-40 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vStartBattleButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-30 w450 ReadOnly -E0x200 -VScroll, This Hotkey starts the battle for all "isActive?" characters by sending the Dofus-End-Of-Turn key to their windows.

	Gui, mainWindowG:Add, Radio, vLeftClickButtonDDLCheck gUpdateVars x10 y+20, use fixed
	Gui, mainWindowG:Add, Radio, vLeftClickButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vLeftClickButtonDDL gUpdateVars x+10 yp-40 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vLeftClickButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-30 w450 ReadOnly -E0x200 -VScroll, This Hotkey performs a LEFT-CLICK in all "isActive?" character windows at the current mouse position.

	Gui, mainWindowG:Add, Radio, vRightClickButtonDDLCheck gUpdateVars x10 y+30, use fixed
	Gui, mainWindowG:Add, Radio, vRightClickButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vRightClickButtonDDL gUpdateVars x+10 yp-40 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vRightClickButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-30 w450 ReadOnly -E0x200 -VScroll, This Hotkey performs a RIGHT-CLICK in all "isActive?" character windows at the current mouse position.
	
	Gui, mainWindowG:Add, Radio, vSwitchNextButtonDDLCheck gUpdateVars x10 y+30, use fixed
	Gui, mainWindowG:Add, Radio, vSwitchNextButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vSwitchNextButtonDDL gUpdateVars x+10 yp-40 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vSwitchNextButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-30 w450 ReadOnly -E0x200 -VScroll, This Hotkey switches to the next "isActive?" characters window in the initiative order.

	Gui, mainWindowG:Add, Radio, vSwitchLastButtonDDLCheck gUpdateVars x10 y+30, use fixed
	Gui, mainWindowG:Add, Radio, vSwitchLastButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vSwitchLastButtonDDL gUpdateVars x+10 yp-40 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, vSwitchLastButtonHK gUpdateVars xp y+10 w90
	Gui, mainWindowG:Add, Edit, x+10 yp-30 w450 ReadOnly -E0x200 -VScroll, This Hotkey switches to the former "isActive?" characters window in the initiative order.

	Gui, mainWindowG:Add, DropDownList, vControlKey gUpdateVars x10 y+30 w90, Shift|Alt|Ctrl
	Gui, mainWindowG:Add, Edit, x+10 yp w450 ReadOnly -E0x200 -VScroll, This Key + a number brings the corresponding characters window to the front.

	Gui, mainWindowG:Add, Button, vHelpButton gRunHelp x+10 yp w90, Help Me!

	Gui, mainWindowG:Tab
	Gui, mainWindowG:Tab, 3
	; Extras Section
	fjexplanation1 = An automated detection of fight entrace would be against the TOS, hence we use a little workaround: You tell DofusHeroes the position of the message popup that comes up on your other characters when you join a fight and the tool sends a click command to that position on a hotkey specified by you. That way you do not have to switch to the other characters to join your fight on your current character!`n`n
	fjexplanation2 = Use the hotkey below (once!) in order to set the mouse position of the join message popup on one of your characters when someone else of the group enters a fight. Make sure that the Dofus window is focused, because the coordinates are different if not. After setting the right position I suggest clearing the hotkey by clicking the input field and pressing RETURN, so you don't accidently press it again and reset the position!
	Gui, mainWindowG:Add, Button, x0 w0 h0 default vDButt gDButton

	Gui, mainWindowG:Font, cBlack s14 underline, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Text, x20 y40, FightJoiner:
	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, mainWindowG:Add, Edit, x20 y+20 w450 ReadOnly -E0x200 -VScroll, %fjexplanation1%%fjexplanation2%

	Gui, mainWindowG:Add, Text, x20 y+10, Set Coordinates on
	Gui, mainWindowG:Add, Hotkey, x+10 yp w100 vSetButton gUpdateVars

	Gui, mainWindowG:Font, cBlack s12 bold, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Edit, vCoords x+10 yp w450 ReadOnly -E0x200 -VScroll, Currently: %joinX%, %joinY%
	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold
	
	Gui, mainWindowG:Add, Radio, vJoinButtonDDLCheck gUpdateVars x10 y+20, use fixed
	Gui, mainWindowG:Add, Radio, vJoinButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, mainWindowG:Add, DropDownList, vJoinButtonDDL gUpdateVars x+10 yp-40 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, mainWindowG:Add, Hotkey, xp y+10 w90 vJoinButtonHK gUpdateVars
	Gui, mainWindowG:Add, Edit, x+10 yp-30 w350 ReadOnly -E0x200 -VScroll, On this button all characters, whose window is not focused click at the above set mouse position, in order to join the fight of the current character.

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

	Gui, mainWindowG:Add, Text, x40 y+10, Text output of FindText

	Gui, mainWindowG:Font, cBlack s8 norm, Arial
	eLabels := ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", ","]
	Loop, 12
	{
		Gui, mainWindowG:Add, Text, x20 y+1,% eLabels[A_Index]
		Gui, mainWindowG:Add, Edit, vCoordSetupT%A_Index% gQuickUpdateVars x30 yp w600 h20,
	}
	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, mainWindowG:Add, Text, x550 y40, Travel Mode
	Gui, mainWindowG:Add, Radio, vClipBoardMode  gQuickUpdateVars x550 y+10, clipboardMode
	Gui, mainWindowG:Add, Radio, vInsertMode gQuickUpdateVars x550 y+10, insertMode
	Gui, mainWindowG:Add, Text, x465 y100, shortcuts
	Gui, mainWindowG:Add, Text, x475 y+5, chat key
	Gui, mainWindowG:Add, Hotkey, vChatKey gQuickUpdateVars x550 yp w100,
	Gui, mainWindowG:Add, Text, x475 y+5, validate
	Gui, mainWindowG:Add, DropDownList, vValidateKey gQuickUpdateVars x550 yp w100, Enter

	Gui, mainWindowG:Color, a6a6a6, ffffff, 0
	goto LoadSettings

startFindTextGUI:
	Run, %A_AHKPath% "findtext.ahk"
	return

UpdateVarsTracker:
	Gui, tracker:Submit, NoHide

	if(TravelRouteDDL = "Astrub")
		chosenRoute := allAstrubRoutes
	if(TravelRouteDDL = "Amakna")
		chosenRoute := allAmaknaSufokiaRoutes
	if(TravelRouteDDL = "Bonta")
		chosenRoute := allBontaRoutes
	if(TravelRouteDDL = "Brakmar")
		chosenRoute := allBrakmarRoutes
	if(TravelRouteDDL = "Cania")
		chosenRoute := allCaniaMainRoutes
	if(TravelRouteDDL = "Koalak")
		chosenRoute := allKoalakRoutes
	return

QuickUpdateVars:
	Gui, mainWindowG:Submit, NoHide
	return

UpdateVars:
	if HeroesEndOfTurnButtonDDL
		Hotkey % HeroesEndOfTurnButtonDDL, HeroesEndOfTurn, off UseErrorLevel
	if HeroesEndOfTurnButtonHK
		Hotkey % HeroesEndOfTurnButtonHK, HeroesEndOfTurn, off UseErrorLevel
	if LeftClickButtonDDL
		Hotkey % LeftClickButtonDDL, ClientLeftClick, off UseErrorLevel
	if LeftClickButtonHK
		Hotkey % LeftClickButtonHK, ClientLeftClick, off UseErrorLevel
	if RightClickButtonDDL
		Hotkey % RightClickButtonDDL, ClientRightClick, off UseErrorLevel
	if RightClickButtonHK
		Hotkey % RightClickButtonHK, ClientRightClick, off UseErrorLevel
	if SwitchNextButtonDDL
		Hotkey % SwitchNextButtonDDL, switchNext, off UseErrorLevel
	if SwitchNextButtonHK
		Hotkey % SwitchNextButtonHK, switchNext, off UseErrorLevel
	if SwitchLastButtonDDL
		Hotkey % SwitchLastButtonDDL, switchLast, off UseErrorLevel
	if SwitchLastButtonHK
		Hotkey % SwitchLastButtonHK, switchLast, off UseErrorLevel
	if StartBattleButtonDDL
		Hotkey % StartBattleButtonDDL, startBattle, off UseErrorLevel
	if StartBattleButtonHK
		Hotkey % StartBattleButtonHK, startBattle, off UseErrorLevel
	if SetButton
		Hotkey % SetButton, SetJoinMsgCoords, off UseErrorLevel
	if JoinButtonDDL
		Hotkey % JoinButtonDDL, FightJoin, off UseErrorLevel
	if JoinButtonHK
		Hotkey % JoinButtonHK, FightJoin, off UseErrorLevel
	
	if ControlKey
	{
		if ControlKey = Shift
			key = +
		if ControlKey = Ctrl
			key = ^
		if ControlKey = Alt
			key = !
		Hotkey, %key%1, showIni1, off UseErrorLevel
		Hotkey, %key%2, showIni2, off UseErrorLevel
		Hotkey, %key%3, showIni3, off UseErrorLevel
		Hotkey, %key%4, showIni4, off UseErrorLevel
		Hotkey, %key%5, showIni5, off UseErrorLevel
		Hotkey, %key%6, showIni6, off UseErrorLevel
		Hotkey, %key%7, showIni7, off UseErrorLevel
		Hotkey, %key%8, showIni8, off UseErrorLevel
	}
	Gui, mainWindowG:Submit, NoHide

	if HeroesEndOfTurnButtonDDL and HeroesEndOfTurnButtonDDLCheck
		Hotkey % HeroesEndOfTurnButtonDDL, HeroesEndOfTurn, on
	if HeroesEndOfTurnButtonHK and HeroesEndOfTurnButtonHKCheck
		Hotkey % HeroesEndOfTurnButtonHK, HeroesEndOfTurn, on
	if LeftClickButtonDDL and LeftClickButtonDDLCheck
		Hotkey % LeftClickButtonDDL, ClientLeftClick, on
	if LeftClickButtonHK and LeftClickButtonHKCheck
		Hotkey % LeftClickButtonHK, ClientLeftClick, on
	if RightClickButtonDDL and RightClickButtonDDLCheck
		Hotkey % RightClickButtonDDL, ClientRightClick, on
	if RightClickButtonHK and RightClickButtonHKCheck
		Hotkey % RightClickButtonHK, ClientRightClick, on
	if SwitchNextButtonDDL and SwitchNextButtonDDLCheck
		Hotkey % SwitchNextButtonDDL, switchNext, on
	if SwitchNextButtonHK and SwitchNextButtonHKCheck
		Hotkey % SwitchNextButtonHK, switchNext, on
	if SwitchLastButtonDDL and SwitchLastButtonDDLCheck
		Hotkey % SwitchLastButtonDDL, switchLast, on
	if SwitchLastButtonHK and SwitchLastButtonHKCheck
		Hotkey % SwitchLastButtonHK, switchLast, on
	if StartBattleButtonDDL and StartBattleButtonDDLCheck
		Hotkey % StartBattleButtonDDL, startBattle, on
	if StartBattleButtonHK and StartBattleButtonHKCheck
		Hotkey % StartBattleButtonHK, startBattle, on
	if SetButton
		Hotkey % SetButton, SetJoinMsgCoords, on
	if JoinButtonDDL and JoinButtonDDLCheck
		Hotkey % JoinButtonDDL, FightJoin, on
	if JoinButtonHK and JoinButtonHKCheck
		Hotkey % JoinButtonHK, FightJoin, on

	if ControlKey
	{
		if ControlKey = Shift
			key = +
		if ControlKey = Ctrl
			key = ^
		if ControlKey = Alt
			key = !
		Hotkey, %key%1, showIni1, on
		Hotkey, %key%2, showIni2, on
		Hotkey, %key%3, showIni3, on
		Hotkey, %key%4, showIni4, on
		Hotkey, %key%5, showIni5, on
		Hotkey, %key%6, showIni6, on
		Hotkey, %key%7, showIni7, on
		Hotkey, %key%8, showIni8, on
	}

	count := 1
	Loop, 8
	{
		if(MainCheck%A_Index%){
			mainChar := EIni%A_Index%
		}
		if AIni%A_Index%
		{
			ini%count% := EIni%A_Index%
			iniAutoSwitch%count% := AutoSwitchIni%A_Index%
			count++
		}
	}
	accounts = %count%
	accounts--
	return

trackerStart:
	trackerActive := !trackerActive
	if(trackerActive){
		GuiControl,mainWindowG:,Tracker,tracking...!
		gosub loadTrackGUI
		gosub UpdateVarsTracker
		SetTimer, trackProcess, 250
	}else{
		SetTimer, trackProcess, Off
		GuiControl,mainWindowG:,Tracker,currently not tracking
		gosub clearTracker
		Gui, tracker:Destroy
	}
	Return

loadTrackGUI:
	Gui, tracker:+AlwaysOnTop -SysMenu
	Gui, tracker:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, tracker:Add, Text, x20 y10 w190 h20 vtrackerActive, 
	Gui, tracker:Add, Text, x+20 y10 w200 h20 vdestinationInfo, ClipboardMode Info

	Gui, tracker:Add, Edit, x20 y+5 w257 h25 vFTCoords1 ReadOnly -VScroll -E0x200
	Gui, tracker:Add, Edit, x20 y+1 w257 h25 vFTCoords2 ReadOnly -VScroll -E0x200
	Gui, tracker:Add, Edit, x20 y+1 w257 h25 vFTCoords3 ReadOnly -VScroll -E0x200

	Gui, tracker:Add, Button, x+10 yp-25 h25 gclearTracker, clear history
	Gui, tracker:Add, Button, x20 y+30 h25 vTravelButton gflipTravelBreak, break travel
	Gui, tracker:Add, DropDownList, vTravelRouteDDL gUpdateVarsTracker x+25 yp w90, Amakna|Astrub|Bonta|Brakmar|Koalak|Cania
	GuiControl,tracker:Choose,TravelRouteDDL,Astrub
	Gui, tracker:Add, Button, x+5 yp h25 gstartTravel, start chosen route
	Gui, tracker:Add, Text, x20 y+10 w280 h25 vcAutoRoute, Currently not running any routes...
	Gui, tracker:Add, Button, x20 y+5 w280 h25 gskipTravelRoute vSkipButton, skip current route!
	Gui, tracker:Add, Text, x20 y+0 w280 h20 vpendingInfos, 
	GuiWidth := 415
	Guixpos := A_ScreenWidth - GuiWidth - 5
	Gui, tracker:Color, a6a6a6, ffffff, 0
	Gui, tracker:Show, y0 x%Guixpos% h250 w%GuiWidth%, DH Tracker & Traveler
	return

clearTracker:
	Loop, 3
	{
		tracked%A_Index% := []
		GuiControl,tracker:,FTCoords%A_Index%,
	}
	return

trackProcess:
	; only track if main character is logged in and no gui window is focused
	if(WinExist(mainChar))
	{
		if(WinActive("DH Tracker & Traveler") or WinActive("Dofus Heroes")){
			GuiControl,tracker:,trackerActive, Not tracking! (GUI focus)
			return
		}
	}else{
		GuiControl,tracker:,trackerActive,Not tracking! (main off)
		return
	}
	GuiControl,tracker:,trackerActive,Tracking stuff...

	Loop, 3
	{
		if(FTCheck%A_Index% and FTScan%A_Index% and FTRange%A_Index%){
			ok := CheckForThis(FTScan%A_Index%, FTRange%A_Index%, FTError%A_Index%)
			if(ok){
				whatFound := ok.1.id
				if(!autoTravelBreak and autoTraveling and StopIfFound){
					gosub flipTravelBreak
				}
				gosub getCurrentCoords
				if(HasVal(tracked%A_Index%, result) > 0)
					return
				tracked%A_Index%.Push(result)
				if(tracked%A_Index%.MaxIndex() = 4)
					tracked%A_Index%.RemoveAt(1)
				message := (tracked%A_Index%.MaxIndex() > 0 ? whatFound ": " tracked%A_Index%[1] : "") (tracked%A_Index%.MaxIndex() > 1 ? ", " tracked%A_Index%[2] : "") (tracked%A_Index%.MaxIndex() > 2 ? ", " tracked%A_Index%[3] : "")
				GuiControl,tracker:,FTCoords%A_Index%, %message%
			}else{
				; do nothing...
			}
		}
	}
	Return

getCurrentCoords:
	txtCoord := ""
	Loop, 12
	{
		txt := CoordSetupT%A_Index%
		StringReplace , txt, txt, %A_Space%,,All
		StringReplace , txt, txt, `",,All
		StringReplace , txt, txt, Text:=,,All
		txtCoord := txtCoord txt
	}
	raCoord := CoordSetupRange
	StringReplace , raCoord, raCoord, %A_Space%,,All
	raCoord := StrSplit(raCoord, ",")
	errCoord := CoordSetupError
	if(errCoord = "")
		errCoord := 0.0
	result := getCoords(txtCoord, raCoord, errCoord)
	return

testCurrentCoords:
	gosub getCurrentCoords
	MsgBox, Are your current coordinates [%result%] ?
	return

startTravel:
	keys := []
	for key, value in chosenRoute
	{
		keys.Push(key)
	}
	Loop
	{
		min := 1
		max := keys.MaxIndex()
		randomIDX := rand(min, max)
		currentRoute := chosenRoute[keys[randomIDX]]
		c:=keys[randomIDX]
		guiMessage := "Now running: "c
		GuiControl,tracker:,cAutoRoute, % guiMessage
		keys.Remove(randomIDX)
		autoTraveling  := True
		gosub autoTravel
		autoTraveling  := False
		GuiControl,tracker:,cAutoRoute,Currently not running any routes...
		GuiControl,tracker:,pendingInfos, 
		skipRouteTrigger := False
		skipForceTrigger := False
		GuiControl,tracker:,SkipButton, skip current route!
		if(min = max){
			break
		}
	}
	return

autoTravel:
	Loop, Parse, currentRoute, |
	{
		if(autoTravelBreak)
			gosub autoTravelBreaking

		target := A_LoopField
		cmd:="/travel " target

		if(ClipBoardMode){
			Clipboard := cmd
			guiMSG := "new target in clipboard!"
			GuiControl,tracker:,destinationInfo,% guiMSG
		}else{
			toCoords(target, ChatKey, ValidateKey, mainChar)
		}

		oldCoords := ""
		noChangeCounter := 0
		
		Loop {
			if(skipForceTrigger)
				return
			if(autoTravelBreak){
				gosub autoTravelBreaking
				continue
			}
			if(autoTravelBreakFinished){
				autoTravelBreakFinished := False
				sleep  500
				if(ClipBoardMode){
					Clipboard := cmd
				}else{
					toCoords(target, ChatKey, ValidateKey, mainChar)
				}
			}
			gosub getCurrentCoords
			if(result = oldCoords)
				noChangeCounter := noChangeCounter + 1
			else
				noChangeCounter := 0
			if(noChangeCounter = 10){
				noChangeCounter := 0
				if(ClipBoardMode){
					Clipboard := cmd
				}else{
					toCoords(target, ChatKey, ValidateKey, mainChar)
				}
			}
			if(result = target){
				if(ClipBoardMode){
					guiMSG := "wait..."
					GuiControl,tracker:,destinationInfo,% guiMSG
				}
				; target reached, doing next coordinates or anything else pending...
				if(skipRouteTrigger)
					return
				break
			}
			sleep 1000
			if(ClipBoardMode){
				clipCopied := InStr(Clipboard, cmd) > 0
				guiMSG := (clipCopied ? "already in clipboard!": "wait...")
				GuiControl,tracker:,destinationInfo,% guiMSG
			}
			oldCoords := result
		}
		sleep 1000
	}
	return

skipTravelRoute:
	if(skipRouteTrigger)
		skipForceTrigger := True
	GuiControl,tracker:,SkipButton, Skip now!
	GuiControl,tracker:,pendingInfos, Skipping after reaching current destination...
	skipRouteTrigger := True
	return

autoTravelBreaking:
	Loop{
		if(!autoTravelBreak)
			break
		sleep 2000
		}
	autoTravelBreakFinished := True
	return

flipTravelBreak:
	autoTravelBreak := !autoTravelBreak
	if(autoTravelBreak){
		stopAutoTravel(mainChar, ChatKey, ValidateKey)
		sleep, % rand(50, 150)
		stopAutoTravel(mainChar, ChatKey, ValidateKey)
		sleep, % rand(50, 150)
		stopAutoTravel(mainChar, ChatKey, ValidateKey)
		GuiControl,tracker:,TravelButton, continue?
	}else{
		GuiControl,tracker:,TravelButton, break travel
	}
	Return

RunHelp:
	hkexplanation = Hotkey Legend:`n^ : Ctrl/Strg`n! : Alt`n+ : Shift`nXButton1/2 : special mouse buttons, useally on the left side`nLButton/RButton/MButton : Left, right and middle mouse buttons`nFor example !LButton = Alt + Left Mouse Button`n`nBe careful when using special keys like circumflex, caret, insert, delete, etc. - they might not work!`n`nFor a detailed description of features visit`nhttps://github.com/Yokani/DofusHeroes
	MsgBox % hkexplanation
	Return

scriptInit:
	Menu, Tray, NoStandard
	Menu, Tray, Icon, dhicon.ico
	Menu, Tray, Add, Settings, loadGUI
	Menu, Tray, Add, Close, mainWindowGuiClose
	Menu, Tray, Default, Settings
	Menu, Tray, Click, 1
	Menu, Tray, Tip, Dofus Heroes

	OnMessage(0x112, "WM_SYSCOMMAND")
	gosub initGUI
	gosub loadGUI
	gosub LoadSettings
	return

SaveSettings:
	IniWrite, % DofusEndOfTurnButtonDDL, settings.ini, general, DofusEndOfTurnButtonDDL
	IniWrite, % DofusEndOfTurnButtonHK, settings.ini, general, DofusEndOfTurnButtonHK
	IniWrite, % DofusEndOfTurnButtonDDLCheck, settings.ini, general, DofusEndOfTurnButtonDDLCheck
	IniWrite, % DofusEndOfTurnButtonHKCheck, settings.ini, general, DofusEndOfTurnButtonHKCheck

	IniWrite, % HeroesEndOfTurnButtonDDL, settings.ini, general, HeroesEndOfTurnButtonDDL
	IniWrite, % HeroesEndOfTurnButtonHK, settings.ini, general, HeroesEndOfTurnButtonHK
	IniWrite, % HeroesEndOfTurnButtonDDLCheck, settings.ini, general, HeroesEndOfTurnButtonDDLCheck
	IniWrite, % HeroesEndOfTurnButtonHKCheck, settings.ini, general, HeroesEndOfTurnButtonHKCheck

	IniWrite, % LeftClickButtonDDL, settings.ini, general, LeftClickButtonDDL
	IniWrite, % LeftClickButtonHK, settings.ini, general, LeftClickButtonHK
	IniWrite, % LeftClickButtonDDLCheck, settings.ini, general, LeftClickButtonDDLCheck
	IniWrite, % LeftClickButtonHKCheck, settings.ini, general, LeftClickButtonHKCheck

	IniWrite, % RightClickButtonDDL, settings.ini, general, RightClickButtonDDL
	IniWrite, % RightClickButtonHK, settings.ini, general, RightClickButtonHK
	IniWrite, % RightClickButtonDDLCheck, settings.ini, general, RightClickButtonDDLCheck
	IniWrite, % RightClickButtonHKCheck, settings.ini, general, RightClickButtonHKCheck

	IniWrite, % SwitchNextButtonDDL, settings.ini, general, SwitchNextButtonDDL
	IniWrite, % SwitchNextButtonHK, settings.ini, general, SwitchNextButtonHK
	IniWrite, % SwitchNextButtonDDLCheck, settings.ini, general, SwitchNextButtonDDLCheck
	IniWrite, % SwitchNextButtonHKCheck, settings.ini, general, SwitchNextButtonHKCheck

	IniWrite, % SwitchLastButtonDDL, settings.ini, general, SwitchLastButtonDDL
	IniWrite, % SwitchLastButtonHK, settings.ini, general, SwitchLastButtonHK
	IniWrite, % SwitchLastButtonDDLCheck, settings.ini, general, SwitchLastButtonDDLCheck
	IniWrite, % SwitchLastButtonHKCheck, settings.ini, general, SwitchLastButtonHKCheck

	IniWrite, % StartBattleButtonDDL, settings.ini, general, StartBattleButtonDDL
	IniWrite, % StartBattleButtonHK, settings.ini, general, StartBattleButtonHK
	IniWrite, % StartBattleButtonDDLCheck, settings.ini, general, StartBattleButtonDDLCheck
	IniWrite, % StartBattleButtonHKCheck, settings.ini, general, StartBattleButtonHKCheck

	IniWrite, % SetButton, settings.ini, general, SetButton
	IniWrite, % JoinButtonDDL, settings.ini, general, JoinButtonDDL
	IniWrite, % JoinButtonHK, settings.ini, general, JoinButtonHK
	IniWrite, % JoinButtonDDLCheck, settings.ini, general, JoinButtonDDLCheck
	IniWrite, % JoinButtonHKCheck, settings.ini, general, JoinButtonHKCheck

	IniWrite, % joinX, settings.ini, general, joinX
	IniWrite, % joinY, settings.ini, general, joinY

	IniWrite, % StopIfFound, settings.ini, findtextstuff, StopIfFound
	IniWrite, % ClipBoardMode, settings.ini, findtextstuff, ClipBoardMode
	IniWrite, % InsertMode, settings.ini, findtextstuff, InsertMode
	IniWrite, % ValidateKey, settings.ini, findtextstuff, ValidateKey
	IniWrite, % ChatKey, settings.ini, findtextstuff, ChatKey
	Loop, 3
	{
		IniWrite, % FTScan%A_Index%, settings.ini, findtextstuff, FTScan%A_Index%
		IniWrite, % FTRange%A_Index%, settings.ini, findtextstuff, FTRange%A_Index%
		IniWrite, % FTError%A_Index%, settings.ini, findtextstuff, FTError%A_Index%
		IniWrite, % FTCheck%A_Index%, settings.ini, findtextstuff, FTCheck%A_Index%
	}
	IniWrite, % CoordSetupRange, settings.ini, findtextstuff, CoordSetupRange
	IniWrite, % CoordSetupError, settings.ini, findtextstuff, CoordSetupError
	Loop, 12
	{
		IniWrite, % CoordSetupT%A_Index%, settings.ini, findtextstuff, CoordSetupT%A_Index%
	}
	
	IniWrite, % ControlKey, settings.ini, general, ControlKey

	Loop, 8
	{
		IniWrite, % EIni%A_Index%, settings.ini, characters, EIni%A_Index%
		IniWrite, % AIni%A_Index%, settings.ini, characters, AIni%A_Index%
		IniWrite, % MainCheck%A_Index%, settings.ini, characters, MainCheck%A_Index%
		IniWrite, % AutoSwitchIni%A_Index%, settings.ini, characters, AutoSwitchIni%A_Index%
	}
	return

LoadSettings:
	tmp := ""
	IniRead, tmp, settings.ini, general, DofusEndOfTurnButtonDDL,
	GuiControl,mainWindowG:Choose, DofusEndOfTurnButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, DofusEndOfTurnButtonHK,
	GuiControl,mainWindowG:, DofusEndOfTurnButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, DofusEndOfTurnButtonDDLCheck,0
	GuiControl,mainWindowG:, DofusEndOfTurnButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, DofusEndOfTurnButtonHKCheck,1
	GuiControl,mainWindowG:, DofusEndOfTurnButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonDDL,
	GuiControl,mainWindowG:Choose, HeroesEndOfTurnButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonHK,
	GuiControl,mainWindowG:, HeroesEndOfTurnButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonDDLCheck,0
	GuiControl,mainWindowG:, HeroesEndOfTurnButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonHKCheck,1
	GuiControl,mainWindowG:, HeroesEndOfTurnButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, LeftClickButtonDDL,
	GuiControl,mainWindowG:Choose, LeftClickButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, LeftClickButtonHK,
	GuiControl,mainWindowG:, LeftClickButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, LeftClickButtonDDLCheck,0
	GuiControl,mainWindowG:, LeftClickButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, LeftClickButtonHKCheck,1
	GuiControl,mainWindowG:, LeftClickButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, RightClickButtonDDL,
	GuiControl,mainWindowG:Choose, RightClickButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, RightClickButtonHK,
	GuiControl,mainWindowG:, RightClickButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, RightClickButtonDDLCheck,0
	GuiControl,mainWindowG:, RightClickButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, RightClickButtonHKCheck,1
	GuiControl,mainWindowG:, RightClickButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, SwitchNextButtonDDL,
	GuiControl,mainWindowG:Choose, SwitchNextButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, SwitchNextButtonHK,
	GuiControl,mainWindowG:, SwitchNextButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, SwitchNextButtonDDLCheck,0
	GuiControl,mainWindowG:, SwitchNextButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, SwitchNextButtonHKCheck,1
	GuiControl,mainWindowG:, SwitchNextButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, SwitchLastButtonDDL,
	GuiControl,mainWindowG:Choose, SwitchLastButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, SwitchLastButtonHK,
	GuiControl,mainWindowG:, SwitchLastButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, SwitchLastButtonDDLCheck,0
	GuiControl,mainWindowG:, SwitchLastButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, SwitchLastButtonHKCheck,1
	GuiControl,mainWindowG:, SwitchLastButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, StartBattleButtonDDL,
	GuiControl,mainWindowG:Choose, StartBattleButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, StartBattleButtonHK,
	GuiControl,mainWindowG:, StartBattleButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, StartBattleButtonDDLCheck,0
	GuiControl,mainWindowG:, StartBattleButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, StartBattleButtonHKCheck,1
	GuiControl,mainWindowG:, StartBattleButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, SetButton,
	GuiControl,mainWindowG:, SetButton, %tmp%

	IniRead, tmp, settings.ini, general, joinButtonDDL,
	GuiControl,mainWindowG:Choose, joinButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, joinButtonHK,
	GuiControl,mainWindowG:, joinButtonHK, %tmp%

	IniRead, tmp, settings.ini, general, joinButtonDDLCheck,0
	GuiControl,mainWindowG:, joinButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, joinButtonHKCheck,1
	GuiControl,mainWindowG:, joinButtonHKCheck, %tmp%

	IniRead, joinX, settings.ini, general, joinX,0
	IniRead, joinY, settings.ini, general, joinY,0
	GuiControl,mainWindowG:, Coords, Currently: %joinX%, %joinY%

	IniRead, tmp, settings.ini, general, ControlKey,
	GuiControl,mainWindowG:Choose, ControlKey, %tmp%

	IniRead, tmp, settings.ini, findtextstuff, StopIfFound,0
	GuiControl,mainWindowG:, StopIfFound, %tmp%
	Loop, 3
	{
		IniRead, tmp1, settings.ini, findtextstuff, FTScan%A_Index%,%A_Space%
		IniRead, tmp2, settings.ini, findtextstuff, FTRange%A_Index%,%A_Space%
		IniRead, tmp3, settings.ini, findtextstuff, FTError%A_Index%,%A_Space%
		IniRead, tmp4, settings.ini, findtextstuff, FTCheck%A_Index%,0
		GuiControl,mainWindowG:,FTScan%A_Index%, %tmp1%
		GuiControl,mainWindowG:,FTRange%A_Index%, %tmp2%
		GuiControl,mainWindowG:,FTError%A_Index%, %tmp3%
		GuiControl,mainWindowG:,FTCheck%A_Index%, %tmp4%
	}
	IniRead, tmp, settings.ini, findtextstuff, CoordSetupRange,%A_Space%
	GuiControl,mainWindowG:, CoordSetupRange, %tmp%
	IniRead, tmp, settings.ini, findtextstuff, CoordSetupError,%A_Space%
	GuiControl,mainWindowG:, CoordSetupError, %tmp%
	Loop, 12
	{
		IniRead, tmp1, settings.ini, findtextstuff, CoordSetupT%A_Index%,%A_Space%
		GuiControl,mainWindowG:,CoordSetupT%A_Index%, %tmp1%
	}

	IniRead, tmp, settings.ini, findtextstuff, ClipBoardMode,1
	GuiControl,mainWindowG:, ClipBoardMode, %tmp%
	IniRead, tmp, settings.ini, findtextstuff, InsertMode,0
	GuiControl,mainWindowG:, InsertMode, %tmp%
	IniRead, tmp, settings.ini, findtextstuff, ChatKey,
	GuiControl,mainWindowG:, ChatKey, %tmp%
	IniRead, tmp, settings.ini, findtextstuff, ValidateKey,Enter
	GuiControl,mainWindowG:Choose, ValidateKey, %tmp%

	Loop, 8
	{	
		IniRead, tmp1, settings.ini, characters, EIni%A_Index%,%A_Space%
		IniRead, tmp2, settings.ini, characters, AIni%A_Index%,0
		IniRead, tmp3, settings.ini, characters, AutoSwitchIni%A_Index%,0
		IniRead, tmp4, settings.ini, characters, MainCheck%A_Index%,0
		GuiControl,mainWindowG:,EIni%A_Index%, %tmp1%
		GuiControl,mainWindowG:,AIni%A_Index%, %tmp2%
		GuiControl,mainWindowG:,AutoSwitchIni%A_Index%, %tmp3%
		GuiControl,mainWindowG:,MainCheck%A_Index%, %tmp4%
	}
	goto UpdateVars

mainWindowGuiClose:
	ExitFunc()
	return
  
; Functions
; =============================
; =============================
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

HasVal(haystack, needle) {
    for index, value in haystack
        if (value = needle)
            return index
    if !(IsObject(haystack))
        throw Exception("Bad haystack!", -1, haystack)
}

; Checks the screen for the given pattern
CheckForThis(textFieldString, rangeString, err){
	if(!err or err = "")
		err := 0.0
	if(!textFieldString or !rangeString)
		return False
	txt := textFieldString
	StringReplace , txt, txt, %A_Space%,,All
	StringReplace , txt, txt, `",,All
	StringReplace , txt, txt, Text:=,,All
	ra := rangeString
	StringReplace , ra, ra, %A_Space%,,All
	ra := StrSplit(ra, ",")
	if(ra.MaxIndex() != 4)
		return False
	return FindText(ra[1], ra[2], ra[3], ra[4], err, err, txt)
}

; Gets the current map coordinates
getCoords(coordText, coordRange, coordError){ 

	;------------------------------
	OCR:=FindTextOCR(coordRange[1], coordRange[2], coordRange[3], coordRange[4], coordError, coordError, coordText)
	len := StrLen(OCR)
	testchar := SubStr(OCR, len, len)
	IfInString, testchar, `,
		OCR := SubStr(OCR, 1, len-1)
	;------------------------------
	Return %OCR%
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


; Helper function for getCoords
FindTextOCR(nX, nY, nW, nH, err1, err0, Text, Interval=20){
  OCR:="", Right_X:=nX+nW-1
  While (ok:=FindText(nX, nY, nW, nH, err1, err0, Text))
  {
    ; For multi text search, This is the number of text images found
    Loop, % ok.MaxIndex()
    {
      ; X is the X coordinates of the upper left corner
      ; and W is the width of the image have been found
      i:=A_Index, x:=ok[i].1, y:=ok[i].2
        , w:=ok[i].3, h:=ok[i].4, comment:=ok[i].id
      ; We need the leftmost X coordinates
      if (A_Index=1 or x<Left_X){
        Left_X:=x, Left_W:=w, Left_OCR:=comment
      }
    }
    ; If the interval exceeds the set value, add "*" to the result
    OCR.=(A_Index>1 and Left_X-nX-1>Interval ? "*":"") . Left_OCR
    IfInString, OCR, *
    {
    	len := StrLen(OCR)
    	OCR := SubStr(OCR, 1, len-2)
    	break
    }
    ; Update nX and nW for next search
    nX:=Left_X+Left_W-1, nW:=Right_X-nX+1
  }
  Return, OCR
}

; travel to the given coordinates
toCoords(coords, chatKey, validateKey, windowName){
	insertChatCommand(windowName, "travel "coords, chatKey, validateKey)
	sleep, % rand(1000, 2000)
	if(WinExist(windowName))
	{
		ControlSend,, {%validateKey%}
		sleep, % rand(100, 200)
	}
}

insertChatCommand(windowName, command, chatKey, validateKey){
	if(WinExist(windowName))
	{
		if(!WinActive(windowName))
			WinActivate
		ControlSend,, {%chatKey%}
		sleep, % rand(25, 75)
		SendInput, ^a
		sleep, % rand(5, 25)
		ControlSend,, {Return}
		oldCP := Clipboard
		Clipboard := "/"command
		SendInput, ^v
		sleep, % rand(25, 100)
		;Clipboard := oldCP
		ControlSend,, {%validateKey%}
		sleep, % rand(25, 100)
	}
}

fastChatCommand(windowName, command, chatKey, validateKey){
	if(WinExist(windowName))
	{
		if(!WinActive(windowName))
			WinActivate
		ControlSend,, {%chatKey%}
		sleep, % rand(5, 25)
		SendInput, ^a
		sleep, % rand(5, 25)
		oldCP := Clipboard
		Clipboard := "/"command
		SendInput, ^v
		sleep, % rand(5, 25)
		Clipboard := oldCP
		ControlSend,, {%validateKey%}
		sleep, % rand(5, 25)
	}
}

stopAutoTravel(windowName, chatKey, validateKey){
	fastChatCommand(windowName, "sit", chatKey, validateKey)
	return
}

rand(min, max){
	random, rand, min, max
	return rand
}

ExitFunc(){
	gosub SaveSettings
	ExitApp
}

; Hotkeys
; =============================
; =============================

F5::
	gosub getCurrentCoords
	perimeter := "|"
	savedCoords = %savedCoords%%result%%perimeter%
	Return
;F6::
;	Clipboard := savedCoords
;	savedCoords := ""
;	Return