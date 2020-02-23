#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force
OnExit("ExitFunc")

; Initialization
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================
; ===============================================================================================================================================================================================

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
Menu, Tray, Add, Close, GuiClose
Menu, Tray, Default, Settings
Menu, Tray, Click, 1
Menu, Tray, Tip, Dofus Heroes

accounts := 0
ini1 := "", ini2 := "", ini3 := "", ini4 := "", ini5 := "", ini6 := "", ini7 := "", ini8 := ""
iniAutoSwitch1 := 0, iniAutoSwitch2 := 0, iniAutoSwitch3 := 0, iniAutoSwitch4 := 0, iniAutoSwitch5 := 0, iniAutoSwitch6 := 0, iniAutoSwitch7 := 0, iniAutoSwitch8 := 0
tmp := 0
joinX = 0
joinY = 0

OnMessage(0x112, "WM_SYSCOMMAND")
Gosub, loadGUI
goto LoadSettings
return

WM_SYSCOMMAND(wParam)
{
	If wParam = 61472
	{
		gosub SaveSettings
		Gui, Destroy
	}
}

; Labels
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================
DButton:
	GuiControl, Focus, DButt
	return

doNothing:
	return

loadGUI:
	Gui, Add, Tab3, x5 y5 w700 Buttons cBlack, Characters|Hotkeys|Guide/AdvancedSection
	Gui, Tab, 1
	
	; Character Initiative Section
	Gui, Font, cBlack s14 underline, Lucida Sans Unicode
	Gui, Add, Text, x20 y40, Characters by Initiative Order
	Gui, Font, cBlack s12 norm, Lucida Sans Unicode

	Loop, 8
	{
		Gui, Add, Button, x10 y+20 gUp%A_Index%, 🡅
		Gui, Add, Button, x+10 yp gDown%A_Index%, 🡇
		Gui, Add, Text, x+10 yp, %A_Index%.
		Gui, Add, Edit, vEIni%A_Index% gUpdateVars -WantReturn limit20 x+10 yp w200
		Gui, Add, CheckBox, vAIni%A_Index% gUpdateVars x+10 yp, isActive?
		Gui, Add, CheckBox, vAutoSwitchIni%A_Index% gUpdateVars x+20 yp, autoSwitchOn?
	}

	Gui, Tab, 2
	; Hotkey Section
	Gui, Font, cBlack s10 norm, Lucida Sans Unicode
	Gui, Add, Radio, vDofusEndOfTurnButtonDDLCheck gUpdateVars x10 y40, use fixed
	Gui, Add, Radio, vDofusEndOfTurnButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, Add, DropDownList, vDofusEndOfTurnButtonDDL gUpdateVars x+10 y40 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, Add, Hotkey, vDofusEndOfTurnButtonHK gUpdateVars xp y+10 w90
	Gui, Add, Edit, x+10 y40 w450 ReadOnly -E0x200 -VScroll, Your End-Of-Turn Button in Dofus.`nSet it up in the game under Options>Shortcuts>Fight: "End the turn". Then enter the corresponding key here.
	
	Gui, Add, Radio, vHeroesEndOfTurnButtonDDLCheck gUpdateVars x10 y110, use fixed
	Gui, Add, Radio, vHeroesEndOfTurnButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, Add, DropDownList, vHeroesEndOfTurnButtonDDL gUpdateVars x+10 y110 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, Add, Hotkey, vHeroesEndOfTurnButtonHK gUpdateVars xp y+10 w90
	Gui, Add, Edit, x+10 y100 w450 ReadOnly -E0x200 -VScroll, HeroesEndOfTurnFunctionality:`nThis Hotkey sends your Dofus End-Of-Turn Button (specified above) to the current window. If "autoSwitchOn?" is enabled for the current character the next characters window depending on the initiative order is brought to front automatically.
	
	Gui, Add, Radio, vStartBattleButtonDDLCheck gUpdateVars x10 y195, use fixed
	Gui, Add, Radio, vStartBattleButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, Add, DropDownList, vStartBattleButtonDDL gUpdateVars x+10 y195 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, Add, Hotkey, vStartBattleButtonHK gUpdateVars xp y+10 w90
	Gui, Add, Edit, x+10 y195 w450 ReadOnly -E0x200 -VScroll, This Hotkey starts the battle for all "isActive?" characters by sending the Dofus-End-Of-Turn key to their windows.

	Gui, Add, Radio, vLeftClickButtonDDLCheck gUpdateVars x10 y280, use fixed
	Gui, Add, Radio, vLeftClickButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, Add, DropDownList, vLeftClickButtonDDL gUpdateVars x+10 y280 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, Add, Hotkey, vLeftClickButtonHK gUpdateVars xp y+10 w90
	Gui, Add, Edit, x+10 y280 w450 ReadOnly -E0x200 -VScroll, This Hotkey performs a LEFT-CLICK in all "isActive?" character windows at the current mouse position.

	Gui, Add, Radio, vRightClickButtonDDLCheck gUpdateVars x10 y350, use fixed
	Gui, Add, Radio, vRightClickButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, Add, DropDownList, vRightClickButtonDDL gUpdateVars x+10 y350 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, Add, Hotkey, vRightClickButtonHK gUpdateVars xp y+10 w90
	Gui, Add, Edit, x+10 y350 w450 ReadOnly -E0x200 -VScroll, This Hotkey performs a RIGHT-CLICK in all "isActive?" character windows at the current mouse position.
	
	Gui, Add, Radio, vSwitchNextButtonDDLCheck gUpdateVars x10 y430, use fixed
	Gui, Add, Radio, vSwitchNextButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, Add, DropDownList, vSwitchNextButtonDDL gUpdateVars x+10 y430 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, Add, Hotkey, vSwitchNextButtonHK gUpdateVars xp y+10 w90
	Gui, Add, Edit, x+10 y430 w450 ReadOnly -E0x200 -VScroll, This Hotkey switches to the next "isActive?" characters window in the initiative order.

	Gui, Add, Radio, vSwitchLastButtonDDLCheck gUpdateVars x10 y500, use fixed
	Gui, Add, Radio, vSwitchLastButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, Add, DropDownList, vSwitchLastButtonDDL gUpdateVars x+10 y500 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|MButton|^MButton|!MButton|+MButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, Add, Hotkey, vSwitchLastButtonHK gUpdateVars xp y+10 w90
	Gui, Add, Edit, x+10 y500 w450 ReadOnly -E0x200 -VScroll, This Hotkey switches to the former "isActive?" characters window in the initiative order.

	Gui, Add, DropDownList, vControlKey gUpdateVars x10 y+30 w90, Shift|Alt|Ctrl
	Gui, Add, Edit, x+10 yp w450 ReadOnly -E0x200 -VScroll, This Key + a number brings the corresponding characters window to the front.

	Gui, Tab
	Gui, Tab, 3
	; Extras Section
	Gui, Font, cBlack s14 underline, Lucida Sans Unicode
	Gui, Add, Text, x20 y40, Hotkey Explanation:
	Gui, Font, cBlack s10 norm, Lucida Sans Unicode

	fjexplanation1 = An automated detection of fight entrace would be against the TOS, hence we use a little workaround: You tell DofusHeroes the position of the message popup that comes up on your other characters when you join a fight and the tool sends a click command to that position on a hotkey specified by you. That way you do not have to switch to the other characters to join your fight on your current character!`n`n
	fjexplanation2 = Use the hotkey below (once!) in order to set the mouse position of the join message popup on one of your characters when someone else of the group enters a fight. Make sure that the Dofus window is focused, because the coordinates are different if not. After setting the right position I suggest clearing the hotkey by clicking the input field and pressing RETURN, so you don't accidently press it again and reset the position!
	hkexplanation = ^ : Ctrl/Strg,  ! : Alt,  + : Shift`nXButton1/2 : special mouse buttons, useally on the left side`nLButton/RButton/MButton : Left, right and middle mouse buttons`nFor example !LButton reads Alt + Left Mouse Button`n
	Gui, Add, Edit, x20 y80 w550 ReadOnly -E0x200 -VScroll, %hkexplanation%
	Gui, Add, Button, x0 w0 h0 default vDButt gDButton

	Gui, Font, cBlack s14 underline, Lucida Sans Unicode
	Gui, Add, Text, x20 y160, FightJoiner:
	Gui, Font, cBlack s10 norm, Lucida Sans Unicode

	Gui, Add, Edit, x20 y+20 w450 ReadOnly -E0x200 -VScroll, %fjexplanation1%%fjexplanation2%

	Gui, Add, Text, x20 y+10, Set Coordinates on
	Gui, Add, Hotkey, x+10 yp w100 vSetButton gUpdateVars

	Gui, Font, cBlack s12 bold, Lucida Sans Unicode
	Gui, Add, Edit, vCoords x+10 yp w450 ReadOnly -E0x200 -VScroll, Currently: %joinX%, %joinY%
	Gui, Font, cBlack s10 norm, Lucida Sans Unicode
	
	Gui, Add, Radio, vJoinButtonDDLCheck gUpdateVars x10 y480, use fixed
	Gui, Add, Radio, vJoinButtonHKCheck gUpdateVars x10 y+20, use custom
	Gui, Add, DropDownList, vJoinButtonDDL gUpdateVars x+10 y480 w90, XButton1|XButton2|Space|^LButton|!LButton|+LButton|^RButton|!RButton|+RButton|^XButton1|!XButton1|+XButton1|^XButton2|!XButton2|+XButton2
	Gui, Add, Hotkey, xp y+10 w90 vJoinButtonHK gUpdateVars
	Gui, Add, Edit, x+10 y480 w350 ReadOnly -E0x200 -VScroll, On this button all characters, whose window is not focused click at the above set mouse position, in order to join the fight of the current character.

	Gui, Color, 748218, b4ca24, cfc63a
	Gui +LastFound
	Winset, Transparent, 240

	Gui, Show, Center AutoSize, Dofus Heroes

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
	Gui, Submit, NoHide

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
	Gui, Submit, NoHide
	if tmp = 1
	{	
		tmp1 = %EIni8%
		tmp2 = %AIni8%
		tmp3 = %AutoSwitchIni8%
		GuiControl,,EIni8, %EIni1%
		GuiControl,,EIni1, %tmp1%
		GuiControl,,AIni8, %AIni1%
		GuiControl,,AIni1, %tmp2%
		GuiControl,,AutoSwitchIni8, %AutoSwitchIni1%
		GuiControl,,AutoSwitchIni1, %tmp3%
	}
	else
	{
		tmptmp = %tmp%
		tmptmp--
		tmp1 = % EIni%tmptmp%
		tmp2 = % AIni%tmptmp%
		tmp3 = % AutoSwitchIni%tmptmp%
		GuiControl,,EIni%tmptmp%, % EIni%tmp%
		GuiControl,,EIni%tmp%, %tmp1%
		GuiControl,,AIni%tmptmp%, % AIni%tmp%
		GuiControl,,AIni%tmp%, %tmp2%
		GuiControl,,AutoSwitchIni%tmptmp%, % AutoSwitchIni%tmp%
		GuiControl,,AutoSwitchIni%tmp%, %tmp3%
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
	Gui, Submit, NoHide
	if tmp = 8
	{	
		tmp1 = %EIni1%
		tmp2 = %AIni1%
		tmp3 = %AutoSwitchIni1%
		GuiControl,,EIni1, %EIni8%
		GuiControl,,EIni8, %tmp1%
		GuiControl,,AIni1, %AIni8%
		GuiControl,,Aini8, %tmp2%
		GuiControl,,AutoSwitchIni1, %AutoSwitchIni8%
		GuiControl,,AutoSwitchIni8, %tmp3%
	}
	else
	{
		tmptmp = %tmp%
		tmptmp++
		tmp1 = % EIni%tmptmp%
		tmp2 = % AIni%tmptmp%
		tmp3 = % AutoSwitchIni%tmptmp%
		GuiControl,,EIni%tmptmp%, % EIni%tmp%
		GuiControl,,EIni%tmp%, %tmp1%
		GuiControl,,AIni%tmptmp%, % AIni%tmp%
		GuiControl,,AIni%tmp%, %tmp2%
		GuiControl,,AutoSwitchIni%tmptmp%, % AutoSwitchIni%tmp%
		GuiControl,,AutoSwitchIni%tmp%, %tmp3%
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
	GuiControl, Text, Coords, Currently: %joinX%, %joinY%
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
	GuiControl, Choose, DofusEndOfTurnButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, DofusEndOfTurnButtonHK
	GuiControl,, DofusEndOfTurnButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, DofusEndOfTurnButtonDDLCheck
	GuiControl,, DofusEndOfTurnButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, DofusEndOfTurnButtonHKCheck
	GuiControl,, DofusEndOfTurnButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonDDL
	GuiControl, Choose, HeroesEndOfTurnButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonHK
	GuiControl,, HeroesEndOfTurnButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonDDLCheck
	GuiControl,, HeroesEndOfTurnButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, HeroesEndOfTurnButtonHKCheck
	GuiControl,, HeroesEndOfTurnButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, LeftClickButtonDDL
	GuiControl, Choose, LeftClickButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, LeftClickButtonHK
	GuiControl,, LeftClickButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, LeftClickButtonDDLCheck
	GuiControl,, LeftClickButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, LeftClickButtonHKCheck
	GuiControl,, LeftClickButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, RightClickButtonDDL
	GuiControl, Choose, RightClickButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, RightClickButtonHK
	GuiControl,, RightClickButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, RightClickButtonDDLCheck
	GuiControl,, RightClickButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, RightClickButtonHKCheck
	GuiControl,, RightClickButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, SwitchNextButtonDDL
	GuiControl, Choose, SwitchNextButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, SwitchNextButtonHK
	GuiControl,, SwitchNextButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, SwitchNextButtonDDLCheck
	GuiControl,, SwitchNextButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, SwitchNextButtonHKCheck
	GuiControl,, SwitchNextButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, SwitchLastButtonDDL
	GuiControl, Choose, SwitchLastButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, SwitchLastButtonHK
	GuiControl,, SwitchLastButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, SwitchLastButtonDDLCheck
	GuiControl,, SwitchLastButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, SwitchLastButtonHKCheck
	GuiControl,, SwitchLastButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, StartBattleButtonDDL
	GuiControl, Choose, StartBattleButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, StartBattleButtonHK
	GuiControl,, StartBattleButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, StartBattleButtonDDLCheck
	GuiControl,, StartBattleButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, StartBattleButtonHKCheck
	GuiControl,, StartBattleButtonHKCheck, %tmp%

	IniRead, tmp, settings.ini, general, SetButton
	GuiControl,, SetButton, %tmp%
	IniRead, tmp, settings.ini, general, joinButtonDDL
	GuiControl, Choose, joinButtonDDL, %tmp%
	IniRead, tmp, settings.ini, general, joinButtonHK
	GuiControl,, joinButtonHK, %tmp%
	IniRead, tmp, settings.ini, general, joinButtonDDLCheck
	GuiControl,, joinButtonDDLCheck, %tmp%
	IniRead, tmp, settings.ini, general, joinButtonHKCheck
	GuiControl,, joinButtonHKCheck, %tmp%

	IniRead, joinX, settings.ini, general, joinX
	IniRead, joinY, settings.ini, general, joinY
	GuiControl, Text, Coords, Currently: %joinX%, %joinY%

	IniRead, tmp, settings.ini, general, ControlKey
	GuiControl, Choose, ControlKey, %tmp%

	Loop, 8
	{	
		IniRead, tmp1, settings.ini, characters, EIni%A_Index%
		IniRead, tmp2, settings.ini, characters, AIni%A_Index%
		IniRead, tmp3, settings.ini, characters, AutoSwitchIni%A_Index%
		GuiControl,,EIni%A_Index%, %tmp1%
		GuiControl,,AIni%A_Index%, %tmp2%
		GuiControl,,AutoSwitchIni%A_Index%, %tmp3%
	}
	goto UpdateVars

GuiClose:
	ExitApp
	return

; Functions
; =============================
; =============================
rand(min, max){
	random, rand, min, max
	return rand
}

ExitFunc(ExitReason, ExitCode){
	gosub SaveSettings
	return
}

; Hotkeys
; =============================
; =============================