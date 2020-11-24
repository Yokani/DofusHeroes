; skip running this script
goto exTNT

trackerStart:
	trackerActive := !trackerActive
	if(trackerActive){
		GuiControl,mainWindowG:,Tracker,tracking...!
		gosub loadTrackGUI
		gosub UpdateVarsTracker
		trackerStartTime := A_TickCount
		SetTimer, trackProcess, 500
		SetTimer, trackProcess, On
	}else{
		SetTimer, trackProcess, Delete
		GuiControl,mainWindowG:,Tracker,currently not tracking
		gosub clearTracker
		Gui, tracker:Destroy
	}
	Return

loadTrackGUI:
	Gui, tracker:+AlwaysOnTop -SysMenu
	Gui, tracker:Font, cBlack s10 norm, Copperplate Gothic Bold

	Gui, tracker:Add, Text, x20 y10 w190 h20 vtrackerInfo, Currently not tracking...
	Gui, tracker:Add, Text, x+20 y10 w200 h20 vdestinationInfo, ClipboardMode Info

	Gui, tracker:Add, Edit, x20 y+5 w257 h25 vFTCoords1 ReadOnly -VScroll -E0x200
	Gui, tracker:Add, Edit, x20 y+1 w257 h25 vFTCoords2 ReadOnly -VScroll -E0x200
	Gui, tracker:Add, Edit, x20 y+1 w257 h25 vFTCoords3 ReadOnly -VScroll -E0x200

	Gui, tracker:Add, Button, x+10 yp-25 h25 gclearTracker, clear history
	Gui, tracker:Add, Button, x20 y+30 h25 vTravelButton gflipTravelBreak, break travel
	Gui, tracker:Add, DropDownList, vTravelRouteDDL gUpdateVarsTracker x+25 yp w90, Amakna|Astrub|Bonta|Brakmar|Koalak|Cania
	GuiControl,tracker:Choose,TravelRouteDDL,Astrub
	Gui, tracker:Add, Button, x+5 yp h25 gstartAutoTraveling, start chosen route
	Gui, tracker:Add, Text, x20 y+10 w280 h40 vcAutoRoute, Currently not running any routes...
	Gui, tracker:Add, Button, x20 y+5 w180 h25 gskipTravelRoute vSkipButton, skip current route!
	Gui, tracker:Add, Button, x+10 yp w180 h25 gstopTravelRoute, Stop AutoTravel!
	Gui, tracker:Add, Text, x20 y+0 w280 h20 vpendingInfos,
	
	Gui, tracker:Add, Button, x0 w0 h0 default vDButtT gDButtonT
	GuiWidth := 415
	Guixpos := A_ScreenWidth - GuiWidth - 5
	Gui, tracker:Color, a6a6a6, ffffff, 0
	Gui, tracker:Show, y0 x%Guixpos% h250 w%GuiWidth%, DH Tracker & Traveler
	WinSet, Transparent, 200, DH Tracker & Traveler
	return

clearTracker:
	Loop, 3
	{
		tracked%A_Index% := []
		GuiControl,tracker:,FTCoords%A_Index%,
	}
	return

trackProcess:
	; only track if main character is logged in and no guib window is focused
	if(WinExist(mainChar))
	{
		if(WinActive("DH Tracker & Traveler") or WinActive("Dofus Heroes")){
			GuiControl,tracker:,trackerInfo, Not tracking! (GUI focus)
			return
		}
	}else{
		GuiControl,tracker:,trackerInfo,Not tracking! (main off)
		return
	}
	trackerTimer := A_TickCount
	trackingFor := (trackerTimer - trackerStartTime) // 1000
	tSeconds := Mod(trackingFor, 60)
	tMinutes := Mod(trackingFor // 60, 60)
	tHours := (trackingFor // 60) // 60
	GuiControl,tracker:,trackerInfo,Tracking... %tSeconds%s%tMinutes%m%tHours%h

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

; travel the chosen route
startAutoTraveling:
	keys := []
	savedChosenRoute := chosenRoute
	for key, value in savedChosenRoute
	{
		keys.Push(key)
	}
	indixes := []
	max := keys.MaxIndex()
	Loop, %max%
	{
		min := 1
		max := keys.MaxIndex()
		randomIDX := rand(min, max)
		indixes.Push(keys[randomIDX])
		keys.Remove(randomIDX)
	}

	travelStartTime := A_TickCount
	currentRouteIndex := 1
	currentCoordinateIndex := 1
	noChangeCounter := 0
	currentRouteTag := indixes[currentRouteIndex]
	currentRoute := savedChosenRoute[currentRouteTag]
	currentRouteCoordinates := StrSplit(currentRoute, "|")
	autoTraveling  := True
	toCoordsTrigger := True
	guiMessage := "Now running:`n"currentRouteTag
	GuiControl,tracker:,cAutoRoute, % guiMessage

	SetTimer, travelingProcess, 1000
	SetTimer, travelingProcess, On
	return

travelingProcess:
	if(stopRouteTrigger){
		stopRouteTrigger := False
		gosub finishAutoTravel
		SetTimer, travelingProcess, Delete
		return
	}

	travelTimer := A_TickCount
	travelingFor := (travelTimer - travelStartTime) // 1000
	trSeconds := Mod(travelingFor, 60)
	trMinutes := Mod(travelingFor // 60, 60)
	trHours := (travelingFor // 60) // 60

	if(autoTravelBreak){
		guiMessage := "Making a break...: " trSeconds "s" trMinutes "m" trHours "h`n" currentRouteTag 
		GuiControl,tracker:,cAutoRoute, % guiMessage
		return
	}
	if(autoTravelBreakFinished){
		autoTravelBreakFinished := False
		toCoordsTrigger := True
	}

	if(skipForceTrigger){
		skipForceTrigger := False
		skipRouteTrigger := False
		GuiControl,tracker:,SkipButton, Skip current route!
		GuiControl,tracker:,pendingInfos,
		currentRouteIndex++
		if(currentRouteIndex > indixes.MaxIndex()){
			stopRouteTrigger := True
			return
		}
		currentCoordinateIndex := 1
		currentRouteTag := indixes[currentRouteIndex]
		currentRoute := savedChosenRoute[currentRouteTag]
		currentRouteCoordinates := StrSplit(currentRoute, "|")
		toCoordsTrigger := True
	}

	target := currentRouteCoordinates[currentCoordinateIndex]

	; check current coordinates
	gosub getCurrentCoords
	; if destination has been reached
	if(result = target){
		currentCoordinateIndex++
		; all coordinates traveled
		if(skipRouteTrigger or currentCoordinateIndex > currentRouteCoordinates.MaxIndex()){
			skipRouteTrigger := False
			GuiControl,tracker:,pendingInfos,
			currentRouteIndex++
			; all routes traveled
			if(currentRouteIndex > indixes.MaxIndex()){
				stopRouteTrigger := True
				return
			}
			currentCoordinateIndex := 1
			currentRouteTag := indixes[currentRouteIndex]
			currentRoute := savedChosenRoute[currentRouteTag]
			currentRouteCoordinates := StrSplit(currentRoute, "|")
		}
		target := currentRouteCoordinates[currentCoordinateIndex]
		toCoordsTrigger := True
	}

	cmd := "/travel " target

	guiMessage := "Traveling for: " trSeconds "s" trMinutes "m" trHours "h`n" currentRouteTag 
	GuiControl,tracker:,cAutoRoute, % guiMessage

	if(result = oldCoords)
		noChangeCounter++
	else
		noChangeCounter := 0

	if(noChangeCounter = 20){
		noChangeCounter := 0
		if(ClipBoardMode){
			Clipboard := cmd
		}else{
			; trigger traveling again...
			toCoordsTrigger := True
		}
	}

	if(ClipBoardMode){
		Clipboard := cmd
		guiMSG := "new target in clipboard!"
		GuiControl,tracker:,destinationInfo,% guiMSG
	}else{
		; only if not already traveling...
		if(toCoordsTrigger){
			toCoordsTrigger := False
			gosub toCoords
		}
	}
		
	oldCoords := result
	return

; travel to the given coordinates
toCoords:
	insertChatCommand(mainChar, SubStr(cmd, 2), ChatKey, ValidateKey)
	startWait := A_TickCount

	ra1 := GPSRange
	StringReplace , ra1, ra1, %A_Space%,,All
	ra1 := StrSplit(ra1, ",")

	ra2 := OKRange
	StringReplace , ra2, ra2, %A_Space%,,All
	ra2 := StrSplit(ra2, ",")

	Text1 := GPST
	Text2 := OKT
	StringReplace , Text1, Text1, %A_Space%,,All
	StringReplace , Text1, Text1, `",,All
	StringReplace , Text1, Text1, Text:=,,All
	StringReplace , Text2, Text2, %A_Space%,,All
	StringReplace , Text2, Text2, `",,All
	StringReplace , Text2, Text2, Text:=,,All

	Loop
	{
		elapsedTime := A_TickCount - startWait

		ok1 := FindText(ra1[1], ra1[2], ra1[3], ra1[4], 0.1, 0.1, Text1)
		ok2 := FindText(ra2[1], ra2[2], ra2[3], ra2[4], 0.1, 0.1, Text2)
		if(ok1 and ok2){
			if(WinExist(mainChar)){
				ControlSend,, {%validateKey%}
				return
			}
		}else{
			if(elapsedTime > 10000){
				return
			}
		}
		sleep, % rand(500, 1000)
	}
	return

finishAutoTravel:
	autoTraveling  := False
	GuiControl,tracker:,cAutoRoute,Currently not running any routes...
	GuiControl,tracker:,pendingInfos,
	skipRouteTrigger := False
	skipForceTrigger := False
	GuiControl,tracker:,SkipButton, skip current route!
	return

; skip/force skip the currently running route
skipTravelRoute:
	if(skipRouteTrigger)
		skipForceTrigger := True
	GuiControl,tracker:,SkipButton, Skip now!
	GuiControl,tracker:,pendingInfos, Skipping after reaching current destination...
	skipRouteTrigger := True
	return

stopTravelRoute:
	stopRouteTrigger := True
	stopAutoTravel(mainChar, ChatKey, ValidateKey)
	return

; trigger auto travel pause or resume travel
flipTravelBreak:
	autoTravelBreak := !autoTravelBreak
	if(autoTravelBreak){
		stopAutoTravel(mainChar, ChatKey, ValidateKey)
		sleep, % rand(50, 150)
		GuiControl,tracker:,TravelButton, continue?
	}else{
		autoTravelBreakFinished := True
		GuiControl,tracker:,TravelButton, break travel
	}
	Return

; Functions
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================


; check if array contains a certain value
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

; Helper function for getCoords
FindTextOCR(nX, nY, nW, nH, err1, err0, Text, Interval=20){
  OCR:="", Right_X:=nX+nW-1
  startTime := A_TickCount
  While (ok:=FindText(nX, nY, nW, nH, err1, err0, Text))
  {
  	if (A_TickCount - startTime > 5000){
  		Return, OCR
  	}
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

; activates the ingame chat, pastes the command and presses validate
insertChatCommand(windowName, command, chatKey, validateKey){
	if(WinExist(windowName))
	{
		oldCP := Clipboard
		Clipboard := "/"command

		if(!WinActive(windowName)){
			WinActivate
			WinWaitActive
		}

		SetKeyDelay, % rand(10, 30), % rand(10, 30)
		ControlSend,, {%chatKey%}, %windowName%
		SetKeyDelay, % rand(10, 30), % rand(10, 30)
		ControlSend,, {Ctrl down}av{Ctrl up}, %windowName%
		SetKeyDelay, % rand(10, 30), % rand(10, 30)
		ControlSend,, {%validateKey%}, %windowName%

		Clipboard := oldCP
	}
	return
}

; activates the ingame chat, pastes the command and presses validate (with less wait times in between)
fastChatCommand(windowName, command, chatKey, validateKey){
	if(WinExist(windowName))
	{
		oldCP := Clipboard
		Clipboard := "/"command

		if(!WinActive(windowName)){
			WinActivate
			WinWaitActive
		}

		SetKeyDelay, % rand(3, 6), % rand(10, 25)
		ControlSend,, {%chatKey%}, %windowName%
		SetKeyDelay, % rand(3, 6), % rand(10, 25)
		ControlSend,, {Ctrl down}av{Ctrl up}, %windowName%
		SetKeyDelay, % rand(3, 6), % rand(10, 25)
		ControlSend,, {%validateKey%}, %windowName%

		Clipboard := oldCP
	}
	return
}

; ==============================================================================================================================================================================
exTNT:
	; go here on first execution