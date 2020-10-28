#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include, findtext.ahk
#Include, DH-GUI.ahk

#SingleInstance, force
OnExit("ExitFunc")

; Variables
; ==============================================================================================================================================================================
accounts := 0
ini1 := "", ini2 := "", ini3 := "", ini4 := "", ini5 := "", ini6 := "", ini7 := "", ini8 := ""
iniAutoSwitch1 := 0, iniAutoSwitch2 := 0, iniAutoSwitch3 := 0, iniAutoSwitch4 := 0, iniAutoSwitch5 := 0, iniAutoSwitch6 := 0, iniAutoSwitch7 := 0, iniAutoSwitch8 := 0
tmp := 0
joinX = 0
joinY = 0
amobTracking := False
guiActive := False
currentAMobs := ""
aMobAmount := 0

; Initialization
; ==============================================================================================================================================================================

IfNotExist, %A_WorkingDir%\settings.ini
{
	IniWrite, v2, settings.ini, currentVersion, version
	IniWrite, F5, settings.ini, general, DofusEndOfTurnButtonDDL
	IniWrite, 1, settings.ini, general, DofusEndOfTurnButtonDDLCheck
	IniWrite, 0, settings.ini, general, DofusEndOfTurnButtonHKCheck
	IniWrite, MButton, settings.ini, general, HeroesEndOfTurnButtonDDL
	IniWrite, 1, settings.ini, general, HeroesEndOfTurnButtonDDLCheck
	IniWrite, 0, settings.ini, general, HeroesEndOfTurnButtonHKCheck
	IniWrite, !LButton, settings.ini, general, LeftClickButtonDDL
	IniWrite, 1, settings.ini, general, LeftClickButtonDDLCheck
	IniWrite, 0, settings.ini, general, LeftClickButtonHKCheck
	IniWrite, !RButton, settings.ini, general, RightClickButtonDDL
	IniWrite, 1, settings.ini, general, RightClickButtonDDLCheck
	IniWrite, 0, settings.ini, general, RightClickButtonHKCheck
	IniWrite, XButton2, settings.ini, general, SwitchNextButtonDDL
	IniWrite, 1, settings.ini, general, SwitchNextButtonDDLCheck
	IniWrite, 0, settings.ini, general, SwitchNextButtonHKCheck
	IniWrite, !XButton2, settings.ini, general, SwitchLastButtonDDL
	IniWrite, 1, settings.ini, general, SwitchLastButtonDDLCheck
	IniWrite, 0, settings.ini, general, SwitchLastButtonHKCheck
	IniWrite, <, settings.ini, general, StartBattleButtonDDL
	IniWrite, 1, settings.ini, general, StartBattleButtonDDLCheck
	IniWrite, 0, settings.ini, general, StartBattleButtonHKCheck

	IniWrite, #, settings.ini, general, SetButton
	IniWrite, XButton1, settings.ini, general, joinButtonDDL
	IniWrite, 1, settings.ini, general, joinButtonDDLCheck
	IniWrite, 0, settings.ini, general, joinButtonHKCheck
	IniWrite, 0, settings.ini, general, joinX
	IniWrite, 0, settings.ini, general, joinY

	IniWrite, Alt, settings.ini, general, ControlKey
	
	Loop, 8
	{
		IniWrite, "", settings.ini, characters, EIni%A_Index%
		IniWrite, 0, settings.ini, characters, AIni%A_Index%
		IniWrite, 0, settings.ini, characters, AutoSwitchIni%A_Index%
	}
}

Menu, Tray, NoStandard
Menu, Tray, Add, Settings, loadGUI
Menu, Tray, Add, Close, mainWindowGuiClose
Menu, Tray, Default, Settings
Menu, Tray, Click, 1
Menu, Tray, Tip, Dofus Heroes

OnMessage(0x112, "WM_SYSCOMMAND")
guiActive := 0
gosub, loadGUI
goto LoadSettings
return

WM_SYSCOMMAND(wParam)
{
	; window minimize button
	If wParam = 0xF020
	{
		gosub SaveSettings
		gosub guiToggle
		Gui, mainWindowG:Destroy
	}
	; window close button
	If wParam = 0xF060
	{
		ExitFunc()
	}
	Return
}

; Labels
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================

guiToggle:
	if (guiActive = 1){
		guiActive := 0
	}else{
		guiActive := 1
	}

DButton:
	GuiControl,mainWindowG:Focus, DButt
	return

doNothing:
	return

loadGUI:
	if (guiActive = 1){
		return
	}
	Gui, mainWindowG:Font, cBlack s12 norm, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Tab3, x5 y5 w700 Buttons cBlack, Characters|Hotkeys|Advanced
	Gui, mainWindowG:Tab, 1
	
	; Character Initiative Section
	Gui, mainWindowG:Font, cBlack s14 norm, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Text, x100 y50, Characters by Initiative Order
	Gui, mainWindowG:Font, cBlack s12 norm, Copperplate Gothic Bold

	Loop, 8
	{
		if A_Index = 1
			Gui, mainWindowG:Add, Button, x10 y+20 gUp%A_Index%, 🡅
		else
			Gui, mainWindowG:Add, Button, x10 y+45 gUp%A_Index%, 🡅
		Gui, mainWindowG:Add, Button, x+10 yp gDown%A_Index%, 🡇
		Gui, mainWindowG:Add, Text, x+10 yp, %A_Index%.
		Gui, mainWindowG:Font, cBlack s12 norm, Cambria
		Gui, mainWindowG:Add, Edit, vEIni%A_Index% gUpdateVars -WantReturn -VScroll limit20 x+10 yp w300 h40
		Gui, mainWindowG:Font, cBlack s12 norm, Copperplate Gothic Bold
		Gui, mainWindowG:Add, CheckBox, vAIni%A_Index% gUpdateVars x+10 yp, active?
		Gui, mainWindowG:Add, CheckBox, vAutoSwitchIni%A_Index% gUpdateVars x+20 yp, autoSwitch?
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

	; archmonster section
	Gui, mainWindowG:Font, cBlack s14 underline, Copperplate Gothic Bold
	Gui, mainWindowG:Add, Text, x10 y+10, ArchMonster Tracker:
	Gui, mainWindowG:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, mainWindowG:Add, Button, x10 y+10 gamobTracking, Start / Stop archmonster tracking
	Gui, mainWindowG:Add, Text, x+10 yp+5 vTracker, Currently not tracking

	Gui, mainWindowG:Color, a6a6a6, ffffff, 0
	Gui, mainWindowG:Show, Center AutoSize, Dofus Heroes
	guiActive := 1
	goto LoadSettings

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

amobtracking:
	SetTimer, archProcess, % (amobTracking := !amobTracking) ? 1000 : "Off"
	if %amobTracking%{
		GuiControl,mainWindowG:,Tracker,tracking...!
		Gui, amobtrack:+AlwaysOnTop -SysMenu
		Gui, amobtrack:Font, cBlack s11 norm, Lucida Sans Unicode
		Gui, amobtrack:Add, Edit, x20 y20 w180 vArchMobs ReadOnly -VScroll -E0x200
		GuiWidth := 200
		Guixpos := A_ScreenWidth - GuiWidth
		Gui, amobtrack:Color, a6a6a6, ffffff, 0
		Gui, amobtrack:Show, y0 x%Guixpos% h200 w200, archmonsters
	}else{
		GuiControl,mainWindowG:,Tracker,currently not tracking
		currentAMobs := ""
		GuiControl,amobtrack:,ArchMobs,%currentAMobs%
		Gui, amobtrack:Destroy
	}
	Return

archProcess:
	checke := CheckArchMonster()
	if %checke%{
		; Get & Write Pos to GUI
		result := getCoords()
		coords = [%result%]
		IfInString, currentAMobs, %coords%
			Return
		if %currentAMobs%{
			aMobAmount += 1
			if (Mod(aMobAmount, 2) = 0){
				currentAMobs=%currentAMobs% , `n%coords%
			}else{
				currentAMobs=%currentAMobs% , %coords%
			}
		}else{
			currentAMobs=%coords%
		}
		GuiControl,amobtrack:,ArchMobs,%currentAMobs%
	}
	Return

RunHelp:
	hkexplanation = Hotkey Legend:`n^ : Ctrl/Strg`n! : Alt`n+ : Shift`nXButton1/2 : special mouse buttons, useally on the left side`nLButton/RButton/MButton : Left, right and middle mouse buttons`nFor example !LButton = Alt + Left Mouse Button`n`nFor a detailed description of features visit`nhttps://github.com/Yokani/DofusHeroes
	MsgBox % hkexplanation
	Return

Up1:
	tmp := 1
	Goto Up
Up2:
	tmp := 2
	Goto Up
Up3:
	tmp := 3
	Goto Up
Up4:
	tmp := 4
	Goto Up
Up5:
	tmp := 5
	Goto Up
Up6:
	tmp := 6
	Goto Up
Up7:
	tmp := 7
	Goto Up
Up8:
	tmp := 8
	Goto Up
Up:
	Gui, mainWindowG:Submit, NoHide
	if tmp = 1
	{	
		tmp1 = %EIni8%
		tmp2 = %AIni8%
		tmp3 = %AutoSwitchIni8%
		GuiControl,mainWindowG:,EIni8, %EIni1%
		GuiControl,mainWindowG:,EIni1, %tmp1%
		GuiControl,mainWindowG:,AIni8, %AIni1%
		GuiControl,mainWindowG:,AIni1, %tmp2%
		GuiControl,mainWindowG:,AutoSwitchIni8, %AutoSwitchIni1%
		GuiControl,mainWindowG:,AutoSwitchIni1, %tmp3%
	}
	else
	{
		tmptmp = %tmp%
		tmptmp--
		tmp1 = % EIni%tmptmp%
		tmp2 = % AIni%tmptmp%
		tmp3 = % AutoSwitchIni%tmptmp%
		GuiControl,mainWindowG:,EIni%tmptmp%, % EIni%tmp%
		GuiControl,mainWindowG:,EIni%tmp%, %tmp1%
		GuiControl,mainWindowG:,AIni%tmptmp%, % AIni%tmp%
		GuiControl,mainWindowG:,AIni%tmp%, %tmp2%
		GuiControl,mainWindowG:,AutoSwitchIni%tmptmp%, % AutoSwitchIni%tmp%
		GuiControl,mainWindowG:,AutoSwitchIni%tmp%, %tmp3%
	}
	Goto UpdateVars

Down1:
	tmp := 1
	Goto Down
Down2:
	tmp := 2
	Goto Down
Down3:
	tmp := 3
	Goto Down
Down4:
	tmp := 4
	Goto Down
Down5:
	tmp := 5
	Goto Down
Down6:
	tmp := 6
	Goto Down
Down7:
	tmp := 7
	Goto Down
Down8:
	tmp := 8
	Goto Down
Down:
	Gui, mainWindowG:Submit, NoHide
	if tmp = 8
	{	
		tmp1 = %EIni1%
		tmp2 = %AIni1%
		tmp3 = %AutoSwitchIni1%
		GuiControl,mainWindowG:,EIni1, %EIni8%
		GuiControl,mainWindowG:,EIni8, %tmp1%
		GuiControl,mainWindowG:,AIni1, %AIni8%
		GuiControl,mainWindowG:,Aini8, %tmp2%
		GuiControl,mainWindowG:,AutoSwitchIni1, %AutoSwitchIni8%
		GuiControl,mainWindowG:,AutoSwitchIni8, %tmp3%
	}
	else
	{
		tmptmp = %tmp%
		tmptmp++
		tmp1 = % EIni%tmptmp%
		tmp2 = % AIni%tmptmp%
		tmp3 = % AutoSwitchIni%tmptmp%
		GuiControl,mainWindowG:,EIni%tmptmp%, % EIni%tmp%
		GuiControl,mainWindowG:,EIni%tmp%, %tmp1%
		GuiControl,mainWindowG:,AIni%tmptmp%, % AIni%tmp%
		GuiControl,mainWindowG:,AIni%tmp%, %tmp2%
		GuiControl,mainWindowG:,AutoSwitchIni%tmptmp%, % AutoSwitchIni%tmp%
		GuiControl,mainWindowG:,AutoSwitchIni%tmp%, %tmp3%
	}
	Goto UpdateVars

showIni1:
	if WinExist(ini1)
		WinActivate
	return

showIni2:
	if WinExist(ini2)
		WinActivate
	return

showIni3:
	if WinExist(ini3)
		WinActivate
	return

showIni4:
	if WinExist(ini4)
		WinActivate
	return

showIni5:
	if WinExist(ini5)
		WinActivate
	return

showIni6:
	if WinExist(ini6)
		WinActivate
	return

showIni7:
	if WinExist(ini7)
		WinActivate
	return

showIni8:
	if WinExist(ini8)
		WinActivate
	return

startBattle:
	SetKeyDelay, 10, 10
	anyWinActive = false
	cc = 0
	Loop, %accounts%
	{
		if WinActive(ini%A_Index%)
			cc++
		sleep 10
	}
	if cc = 1
		anyWinActive = true
	if anyWinActive{
		Loop, %accounts%
		{
			if WinExist(ini%A_Index%)
			{
				if DofusEndOfTurnButtonDDLCheck
					ControlSend,, {%DofusEndOfTurnButtonDDL%}
				else
					ControlSend,, {%DofusEndOfTurnButtonHK%}
			}
			sleep, % rand(25, 125)
		}
	}
	return

switchNext:
	anyWinActive = false
	cc = 0
	Loop, %accounts%
	{
		if WinActive(ini%A_Index%)
			cc++
		sleep 10
	}
	if cc = 1
		anyWinActive = true
	if anyWinActive{
		Loop, %accounts%
		{
			if WinActive(ini%A_Index%)
			{
				if A_Index = %accounts%
				{
					tmp = 1
				}
				else
				{
					tmp = %A_Index%
					tmp++
				}
				if WinExist(ini%tmp%)
					WinActivate
				return
			}
			sleep 50
		}
	}
	return

switchLast:
	anyWinActive = false
	cc = 0
	Loop, %accounts%
	{
		if WinActive(ini%A_Index%)
			cc++
		sleep 10
	}
	if cc = 1
		anyWinActive = true
	if anyWinActive{
		Loop, %accounts%
		{
			index := A_Index
			if WinActive(ini%index%)
			{

				if index = 1
				{
					if WinExist(ini%accounts%)
					{
						WinActivate
						return
					}
				}
				else
				{
					tmp = %index%
					tmp--
				}
				if WinExist(ini%tmp%)
					WinActivate
				return
			}
			sleep 50
		}
	}
	return

HeroesEndOfTurn:
	anyWinActive = false
	cc = 0
	Loop, %accounts%
	{
		if WinActive(ini%A_Index%)
			cc++
		sleep 10
	}
	if cc = 1
		anyWinActive = true
	if anyWinActive{
		Loop, %accounts%
		{
			if WinActive(ini%A_Index%)
			{
				if iniAutoSwitch%A_Index%
				{
					if DofusEndOfTurnButtonDDLCheck
						ControlSend,, {%DofusEndOfTurnButtonDDL%}
					else
						ControlSend,, {%DofusEndOfTurnButtonHK%}
					sleep 100
					goto switchNext
				}
				else
				{
					if DofusEndOfTurnButtonDDLCheck
						ControlSend,, {%DofusEndOfTurnButtonDDL%}
					else
						ControlSend,, {%DofusEndOfTurnButtonHK%}
					sleep 100
					return
				}
			}
			else
			{
				sleep, % rand(25, 100)
			}
		}
	}
	return

ClientLeftClick:
	MouseGetPos, xpos, ypos
	anyWinActive = false
	cc = 0
	Loop, %accounts%
	{
		if WinActive(ini%A_Index%)
			cc++
		sleep 10
	}
	if cc = 1
		anyWinActive = true
	if anyWinActive{
		Loop, %accounts%
		{
			if WinExist(ini%A_Index%)
				ControlClick, x%xpos% y%ypos%,,, L, 1
			sleep, % rand(25, 75)

		}
	}
	return

ClientRightClick:
	MouseGetPos, xpos, ypos
	anyWinActive = false
	cc = 0
	Loop, %accounts%
	{
		if WinActive(ini%A_Index%)
			cc++
		sleep 10
	}
	if cc = 1
		anyWinActive = true
	if anyWinActive{
		Loop, %accounts%
		{
			if WinExist(ini%A_Index%)
				ControlClick, x%xpos% y%ypos%,,, R, 1
			sleep, % rand(25, 75)
		}
	}
	return

SetJoinMsgCoords:
	MouseGetPos, joinX, joinY
	if joinX <= 0 or joinY <= 0
	{
		joinX := 0
		joinY := 0
	}
	GuiControl,mainWindowG: Text, Coords, Currently: %joinX%, %joinY%
	return

FightJoin:
	anyWinActive = false
	cc = 0
	Loop, %accounts%
	{
		if WinActive(ini%A_Index%)
			cc++
		sleep 10
	}
	if cc = 1
		anyWinActive = true
	if anyWinActive{
		Loop, %accounts%
		{
			if WinExist(ini%A_Index%) and not WinActive(ini%A_Index%)
				ControlClick, x%joinX% y%joinY%,,, L, 1
			sleep, % rand(25, 75)

		}
	}
	return

InviteMyCharacters:
	anyWinActive = false
	cc = 0
	Loop, %accounts%
	{
		if WinActive(ini%A_Index%)
			cc++
		sleep 10
	}
	if cc = 1
		anyWinActive = true
	if anyWinActive{
		Loop, %accounts%
		{
			if WinExist(ini%A_Index%) and not WinActive(ini%A_Index%)
				
			sleep, % rand(25, 75)

		}
	}
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

	IniWrite, % ControlKey, settings.ini, general, ControlKey

	Loop, 8
	{
		IniWrite, % EIni%A_Index%, settings.ini, characters, EIni%A_Index%
		IniWrite, % AIni%A_Index%, settings.ini, characters, AIni%A_Index%
		IniWrite, % AutoSwitchIni%A_Index%, settings.ini, characters, AutoSwitchIni%A_Index%
	}
	return

LoadSettings:
	IniRead, tmp, settings.ini, general, DofusEndOfTurnButtonDDL
	GuiControl,mainWindowG: Choose, DofusEndOfTurnButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, DofusEndOfTurnButtonHK
	GuiControl,mainWindowG:, DofusEndOfTurnButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, DofusEndOfTurnButtonDDLCheck
	GuiControl,mainWindowG:, DofusEndOfTurnButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, DofusEndOfTurnButtonHKCheck
	GuiControl,mainWindowG:, DofusEndOfTurnButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonDDL
	GuiControl,mainWindowG: Choose, HeroesEndOfTurnButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonHK
	GuiControl,mainWindowG:, HeroesEndOfTurnButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonDDLCheck
	GuiControl,mainWindowG:, HeroesEndOfTurnButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonHKCheck
	GuiControl,mainWindowG:, HeroesEndOfTurnButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, LeftClickButtonDDL
	GuiControl,mainWindowG: Choose, LeftClickButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, LeftClickButtonHK
	GuiControl,mainWindowG:, LeftClickButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, LeftClickButtonDDLCheck
	GuiControl,mainWindowG:, LeftClickButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, LeftClickButtonHKCheck
	GuiControl,mainWindowG:, LeftClickButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, RightClickButtonDDL
	GuiControl,mainWindowG: Choose, RightClickButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, RightClickButtonHK
	GuiControl,mainWindowG:, RightClickButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, RightClickButtonDDLCheck
	GuiControl,mainWindowG:, RightClickButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, RightClickButtonHKCheck
	GuiControl,mainWindowG:, RightClickButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, SwitchNextButtonDDL
	GuiControl,mainWindowG: Choose, SwitchNextButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, SwitchNextButtonHK
	GuiControl,mainWindowG:, SwitchNextButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, SwitchNextButtonDDLCheck
	GuiControl,mainWindowG:, SwitchNextButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, SwitchNextButtonHKCheck
	GuiControl,mainWindowG:, SwitchNextButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, SwitchLastButtonDDL
	GuiControl,mainWindowG: Choose, SwitchLastButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, SwitchLastButtonHK
	GuiControl,mainWindowG:, SwitchLastButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, SwitchLastButtonDDLCheck
	GuiControl,mainWindowG:, SwitchLastButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, SwitchLastButtonHKCheck
	GuiControl,mainWindowG:, SwitchLastButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, StartBattleButtonDDL
	GuiControl,mainWindowG: Choose, StartBattleButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, StartBattleButtonHK
	GuiControl,mainWindowG:, StartBattleButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, StartBattleButtonDDLCheck
	GuiControl,mainWindowG:, StartBattleButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, StartBattleButtonHKCheck
	GuiControl,mainWindowG:, StartBattleButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, SetButton
	GuiControl,mainWindowG:, SetButton, %tmp%
	IniRead, tmp, settings.ini, general, joinButtonDDL
	GuiControl,mainWindowG: Choose, joinButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, joinButtonHK
	GuiControl,mainWindowG:, joinButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, joinButtonDDLCheck
	GuiControl,mainWindowG:, joinButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, joinButtonHKCheck
	GuiControl,mainWindowG:, joinButtonHKCheck, %tmp%

	IniRead, joinX, settings.ini, general, joinX
	IniRead, joinY, settings.ini, general, joinY
	GuiControl,mainWindowG: Text, Coords, Currently: %joinX%, %joinY%

	IniRead, tmp, settings.ini, general, ControlKey
	GuiControl,mainWindowG: Choose, ControlKey, %tmp%

	Loop, 8
	{	
		IniRead, tmp1, settings.ini, characters, EIni%A_Index%
		IniRead, tmp2, settings.ini, characters, AIni%A_Index%
		IniRead, tmp3, settings.ini, characters, AutoSwitchIni%A_Index%
		GuiControl,mainWindowG:,EIni%A_Index%, %tmp1%
		GuiControl,mainWindowG:,AIni%A_Index%, %tmp2%
		GuiControl,mainWindowG:,AutoSwitchIni%A_Index%, %tmp3%
	}
	goto UpdateVars


mainWindowGuiClose:
	ExitFunc()
	return

; Functions
; =============================
; =============================

CheckArchMonster(){
	x = 0
	y = 0
	a1 = amob1.png
	a2 = amob2.png
	a3 = amob3.png
	a4 = amob4.png
	transparency := 75
	Loop 2{
		ImageSearch, x, y, 0, 0, 2600, 1400, *%transparency% %a1%
		If !(!x or !y){
			Return True
		}

		ImageSearch, x, y, 0, 0, 2600, 1400, *%transparency% %a2%
		If !(!x or !y){
			Return True
		}

		ImageSearch, x, y, 0, 0, 2600, 1400, *%transparency% %a3%
		If !(!x or !y){
			Return True
		}

		ImageSearch, x, y, 0, 0, 2600, 1400, *%transparency% %a4%
		If !(!x or !y){
			Return True
		}
		transparency += 25
	}
	Return False
}

getCoords(){ ; Gets the current map coordinates by scanning the upper left screen
	; For identification, we need to create a text library,
	; Of course, the following text library is not strong enough,
	; Perhaps in other computers, other screen resolutions,
	; Other browser magnification, different fonts, need to regenerate.
	; You can add the newly generated to the following existing text library,
	; To enhance the generality of this text library.
	Text:="|<->*105$10.zy0M1U60TzU"
	Text.="|<,>*106$8.zy7VsS7VsQD3VwTzU"
	Text.="|<0>*107$17.zzzw1zk1z01w01sC3kw71w63sA7kMDUkT1Uy31w63sA7kMDUkT1Uy31w73kS3Uw01w07w0Tw1zzzw"
	Text.="|<1>*104$12.zzztzVw1k1U1U1X1j1z1z1z1z1z1z1z1z1z1z1z1z1z1z1z1z1z1zzU"
	Text.="|<2>*107$17.zzzy1zk0z00w01sC3kS31w63sDzkTz1zy3zsDzkTz1zw3zkDzUzy3zs7zUTz1zw00s01k03U07zzw"
	Text.="|<3>*108$17.zzzw1zk0z01w01sC3ky3zw7zsDzkzz1zU7z0Ty0zw0zzUzzUzz1zy31w63sC3UQ01w03s0Dw1zzzw"
	Text.="|<4>*106$17.zzzzkTz0zy1zs3zk7z0Dy0Ts0zl1z23yA7sMDkkT3Uy71sS3k01U0300600Dz1zy3zw7zsDzkTzzw"
	Text.="|<5>*107$17.zzzk0DU0T00y01wDzsTzUzz1zy3zw07s07k07UkDvkTzkTzUzz1zy31w73sC3Uw01w07w0Tw1zzzw"
	Text.="|<6>*108$16.zzzz3zkDy0zk3y1zkDz1zwDzUly01s03U0C1UMD1Uw63sMDVUy63sMD1kQ700y03w0Ts7zzzU"
	Text.="|<7>*105$17.zzz00600A00M00zz1zy7zsDzkTzVzy3zw7zkTzUzz3zw7zsDzkzz1zy3zsDzkTzUzy3zw7zkDzzzw"
	Text.="|<8>*107$16.zzzk7y07k0T00s63UwC3kMD3UwD1Uw07s0zk3w07kMC3ksD1Uw63kMD1Uw600w03s0Tk3zzzU"
	Text.="|<9>*107$16.zzzs7y0Dk0T01sC3UwC3kMT1Vw67kMD1Uw61UQ01k07U0TX3zwDzUzw7zUTk3z0Tw3zkzzzzU"

	t1:=A_TickCount
	;------------------------------
	OCR:=FindTextOCR(0, 90, 250, 130, 0.05, 0.05, Text)
	len := StrLen(OCR)
	testchar := SubStr(OCR, len, len)
	IfInString, testchar, `,
		OCR := SubStr(OCR, 1, len-1)
	;------------------------------
	t1:=A_TickCount-t1
	;MsgBox, 4096, OCR, OCR Result: [%OCR%] in %t1% ms.
	Return %OCR%
}

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
    ; Update nX and nW for next search
    nX:=Left_X+Left_W-1, nW:=Right_X-nX+1
  }
  Return, OCR
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