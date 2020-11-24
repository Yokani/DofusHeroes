; ==============================================================================================================================================================================
;  Dofus Heroes - a Dofus utility tool
;  https://github.com/Yokani/DofusHeroes
;
;  Author  : Yokani
;  Version : 1.2.1
;  Date    : 2020-11-24
; ==============================================================================================================================================================================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent
#SingleInstance, force
OnExit("ExitFunc")

; Initialization
; ==============================================================================================================================================================================
; Includes, replaced by code in external script
; ================================================================

; determines which features are included in the exe
; 0: all
; 1: only basic
; 2: only basic && no golden rule violation
inclusionMode := 0

#Include, DH_VARS.ahk
#Include, DH_GUI.ahk
#Include, DH_LIB_findtext.ahk
if(inclusionMode = 0){
	#Include, DH_trackNTraveler.ahk
}

goto scriptInit

; Labels
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================

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
		tmp1 := EIni8
		tmp2 := AIni8
		tmp3 := AutoSwitchIni8
		tmp4 := MainCheck8
		GuiControl,mainWindowG:,EIni8, %EIni1%
		GuiControl,mainWindowG:,EIni1, %tmp1%
		GuiControl,mainWindowG:,AIni8, %AIni1%
		GuiControl,mainWindowG:,AIni1, %tmp2%
		GuiControl,mainWindowG:,AutoSwitchIni8, %AutoSwitchIni1%
		GuiControl,mainWindowG:,AutoSwitchIni1, %tmp3%
		GuiControl,mainWindowG:,MainCheck8, %MainCheck1%
		GuiControl,mainWindowG:,MainCheck1, %tmp4%
	}
	else
	{
		tmptmp := tmp - 1
		tmp1 := EIni%tmptmp%
		tmp2 := AIni%tmptmp%
		tmp3 := AutoSwitchIni%tmptmp%
		tmp4 := MainCheck%tmptmp%
		GuiControl,mainWindowG:,EIni%tmptmp%, % EIni%tmp%
		GuiControl,mainWindowG:,EIni%tmp%, %tmp1%
		GuiControl,mainWindowG:,AIni%tmptmp%, % AIni%tmp%
		GuiControl,mainWindowG:,AIni%tmp%, %tmp2%
		GuiControl,mainWindowG:,AutoSwitchIni%tmptmp%, % AutoSwitchIni%tmp%
		GuiControl,mainWindowG:,AutoSwitchIni%tmp%, %tmp3%
		GuiControl,mainWindowG:,MainCheck%tmptmp%, % MainCheck%tmp%
		GuiControl,mainWindowG:,MainCheck%tmp%, %tmp4%
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
		tmp1 := EIni1
		tmp2 := AIni1
		tmp3 := AutoSwitchIni1
		tmp4 := MainCheck1
		GuiControl,mainWindowG:,EIni1, %EIni8%
		GuiControl,mainWindowG:,EIni8, %tmp1%
		GuiControl,mainWindowG:,AIni1, %AIni8%
		GuiControl,mainWindowG:,Aini8, %tmp2%
		GuiControl,mainWindowG:,AutoSwitchIni1, %AutoSwitchIni8%
		GuiControl,mainWindowG:,AutoSwitchIni8, %tmp3%
		GuiControl,mainWindowG:,MainCheck1, %MainCheck8%
		GuiControl,mainWindowG:,MainCheck8, %tmp4%
	}
	else
	{
		tmptmp := tmp + 1
		tmp1 := EIni%tmptmp%
		tmp2 := AIni%tmptmp%
		tmp3 := AutoSwitchIni%tmptmp%
		tmp4 := MainCheck%tmptmp%
		GuiControl,mainWindowG:,EIni%tmptmp%, % EIni%tmp%
		GuiControl,mainWindowG:,EIni%tmp%, %tmp1%
		GuiControl,mainWindowG:,AIni%tmptmp%, % AIni%tmp%
		GuiControl,mainWindowG:,AIni%tmp%, %tmp2%
		GuiControl,mainWindowG:,AutoSwitchIni%tmptmp%, % AutoSwitchIni%tmp%
		GuiControl,mainWindowG:,AutoSwitchIni%tmp%, %tmp3%
		GuiControl,mainWindowG:,MainCheck%tmptmp%, % MainCheck%tmp%
		GuiControl,mainWindowG:,MainCheck%tmp%, %tmp4%
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

checkAnyWin:
	anyWinActive := False
	Loop, %accounts%
	{
		if WinActive(ini%A_Index%)
			anyWinActive := True
	}
	return

startBattle:
	SetKeyDelay, 50, 50
	gosub checkAnyWin
	if(anyWinActive)
	{
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
	gosub checkAnyWin
	if(anyWinActive)
	{
		Loop, %accounts%
		{
			if WinActive(ini%A_Index%)
			{
				if A_Index = %accounts%
					tmp := 1
				else
					tmp := A_Index + 1
				if WinExist(ini%tmp%)
					WinActivate
				return
			}
			sleep 50
		}
	}
	return

switchLast:
	gosub checkAnyWin
	if(anyWinActive)
	{
		Loop, %accounts%
		{
			index := A_Index
			if WinActive(ini%A_Index%)
			{
				if(A_Index = 1)
					tmp := accounts
				else
					tmp := A_Index - 1
				if WinExist(ini%tmp%)
					WinActivate
				return
			}
			sleep 50
		}
	}
	return

HeroesEndOfTurn:
	gosub checkAnyWin
	SetKeyDelay, 50, 50
	if(anyWinActive)
	{
		Loop, %accounts%
		{
			if WinActive(ini%A_Index%)
			{
				if iniAutoSwitch%A_Index%
				{
					if(DofusEndOfTurnButtonDDLCheck){
						ControlSend,, {%DofusEndOfTurnButtonDDL%}
					}
					else{
						ControlSend,, {%DofusEndOfTurnButtonHK%}
					}
					sleep 100
					goto switchNext
				}
				else
				{
					if(DofusEndOfTurnButtonDDLCheck){
						ControlSend,, {%DofusEndOfTurnButtonDDL%}
					}
					else{
						ControlSend,, {%DofusEndOfTurnButtonHK%}
					}
					sleep 100
					return
				}
			}
		}
	}
	return

ClientLeftClick:
	MouseGetPos, xpos, ypos
	gosub checkAnyWin
	if(anyWinActive)
	{
		Loop, %accounts%
		{
			if WinExist(ini%A_Index%)
				ControlClick, x%xpos% y%ypos%,,, L, 1
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
	gosub checkAnyWin
	if(anyWinActive)
	{
		Loop, %accounts%
		{
			if WinExist(ini%A_Index%) and not WinActive(ini%A_Index%)
				ControlClick, x%joinX% y%joinY%,,, L, 1
			sleep, % rand(25, 75)

		}
	}
	return

; hotkey tab help
RunHelp:
	hkexplanation = Hotkey Legend:`n^ : Ctrl/Strg`n! : Alt`n+ : Shift`nXButton1/2 : special mouse buttons, useally on the left side`nLButton/RButton/MButton : Left, right and middle mouse buttons`nFor example !LButton = Alt + Left Mouse Button`n`nBe careful when using special keys like circumflex, caret, insert, delete, etc. - they might not work!`n`nFor a detailed description of features visit`nhttps://github.com/Yokani/DofusHeroes
	MsgBox % hkexplanation
	Return

; initialization stuff
scriptInit:
	Menu, Tray, NoStandard
	Menu, Tray, Icon, utils/dhicon.ico
	Menu, Tray, Add, Settings, loadGUI
	Menu, Tray, Add, Close, mainWindowGuiClose
	Menu, Tray, Default, Settings
	Menu, Tray, Click, 1
	Menu, Tray, Tip, Dofus Heroes

	OnMessage(0x112, "WM_SYSCOMMAND")
	gosub initGUI
	gosub loadGUI
	gosub LoadSettings
	global loadUpFinished := True
	return

; tray icon command
mainWindowGuiClose:
	ExitFunc()
	return

; Functions
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================
; returns a random number between min, max
rand(min, max){
	random, rand, min, max
	return rand
}

; shuts down the application and saves settings, if gui was loaded successfully beforehand
ExitFunc(){
	if(loadUpFinished)
		gosub SaveSettings
	ExitApp
}

; Hotkeys
; =============================
; =============================
	