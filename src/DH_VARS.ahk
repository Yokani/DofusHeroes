
; Global Variables
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================

mainWindowTitle := "Dofus Heroes"
global loadUpFinished := False
inilocation := "utils/settings.ini"
accounts := 0
ini1 := "", ini2 := "", ini3 := "", ini4 := "", ini5 := "", ini6 := "", ini7 := "", ini8 := ""
iniAutoSwitch1 := 0, iniAutoSwitch2 := 0, iniAutoSwitch3 := 0, iniAutoSwitch4 := 0, iniAutoSwitch5 := 0, iniAutoSwitch6 := 0, iniAutoSwitch7 := 0, iniAutoSwitch8 := 0
mainChar := ""
tmp := 0
joinX = 0
joinY = 0
trackerActive := False
trackerTimer := ""
trackerStartTime := ""
tracked1 := []
tracked2 := []
tracked3 := []
guiActive := False
savedCoords := ""
aMobAmount := 0
currentRoute := ""
currentRouteTag := ""
chosenRoute := ""
clipCopied := False
autoTravelBreak := False
autoTravelBreakFinished := False
autoTraveling  := False
toCoordsTrigger := False
skipRouteTrigger := False
skipForceTrigger := False
stopRouteTrigger := False

; astrub areas
astrubForestFR := "0,-15|0,-21|-1,-15|-3,-15|-2,-22|-2,-16|2,-22|2,-29|-2,-29|-2,-23|1,-23|1,-27|-1,-27|-1,-24|0,-26"
astrubCemeteryFR := "-4,-8|-3,-14|2,-14|2,-9|-2,-9|-2,-13|1,-13|1,-10|-1,-10|-1,-12|0,-12|0,-11"
astrubMeadowFR := "2,-8|9,-8|10,-10|11,-11|11,-14|10,-12|8,-14|3,-14|3,-10|8,-10|8,-13|4,-13|6,-11|5,-12|8,-12"
astrubCityFR := "7,-15|1,-15|1,-21|7,-21|7,-16|2,-16|2,-20|6,-20|6,-17|3,-17|3,-19|6,-19|4,-18"
astrubRockyInletFR := "10,-22|12,-22|13,-28|10,-29|8,-29|8,-25|10,-25|11,-23|11,-27|9,-28|10,-26|10,-27"
astrubFieldsFR := "3,-31|3,-22|9,-22|9,-24|4,-23|7,-24|7,-28|6,-30|4,-31|4,-24|5,-24|5,-29"
astrubTainelaFR := "4,-32|1,-29|-1,-29|-2,-32|0,-34|2,-34|3,-33|1,-33|0,-30"

; amakna  & sufokia areas
cracklerMountainFR := "-5,-9|-4,-6|-2,-5|-3,-4|-4,-2|-3,0|-2,-5|1,-5|1,-8|-2,-8|-2,-6|-1,-6"
amaknaVillageFR := "-2,-4|1,-4|2,-2|4,-1|5,0|4,3|4,1|3,3|-1,2|-2,-1|-1,-3|0,-1|-1,-2|1,-1|3,0|3,2|0,2|0,0"
madrestamHarbourkawaiiRiverFR := "12,2|14,1|13,-3|13,-7|8,-6|6,-4|2,-3|3,-3|5,-3|5,-1|7,-1|7,-3|8,-1|9,-3|11,-1|10,-2"
lowCracklerMountainFR := "-4,0|-3,6|-1,7|-3,10|-2,12"
bworkGoblinVillageFR := "-2,8|-2,11|-3,12|-6,9|-7,7|-6,4|-5,3|-4,2|-3,3|-3,5|-4,7|-5,8|-5,6"
edgeOfEvilForestFR := "-3,13|1,21|2,13|0,13"
amaknaForestFR := "3,12|11,13|9,18|10,20|9,21|3,21|3,13|8,13|6,19|8,19|8,20|4,20|4,16|4,15|6,14|5,19"
banditTerritoryAmaknaCemeteryFR := "10,19|12,15|8,17|12,17|9,15|9,14|10,14|12,13|13,11|14,12|13,13|13,14|15,14|15,21|11,21|12,20|13,19|14,18|14,15"
scaraleafPlainPorcoTerritoryFR := "4,22|-2,22|-1,23|-2,31|-2,34|1,34|1,32|-1,33|5,32|5,28|4,26|3,23|1,23|1,29|4,31|4,29|3,29|2,28|3,27|2,26|2,24"
jellyPeninsulaFR := "6,29|11,28|11,30|10,29|8,31|6,30|7,30"
; Amakna Countryside, Inglasses' Fields, Mushd Corner, Asse Coast, Milicluster, Gobball Corner, Brouce Boulgoure's Clearing
amaknaMainAreaFR := "-1,4|5,4|6,0|9,2|6,4|11,3|13,4|13,5|-1,5|-1,6|13,6|13,7|0,7|0,8|13,8|12,9|0,9|0,10|12,10|12,11|0,11|2,12"
sufokianShorelineFR := "14,22|7,23|5,22|6,23|7,28"
sufokiaFR := "15,22|6,26|7,25|9,24|12,24|9,26|9,27|12,29|16,29|17,29|17,24|16,24|20,25|19,23|21,22|23,24"
dreggonAreaFR := "-2,24|-6,24|-7,25|-1,25|-1,30|-2,29|-3,32|-7,32|-7,26|-3,26|-3,29|-4,29|-4,31|-6,28|-5,27|-4,28"

; cania main areas
caniaLakeFR := "-8,-44|1,-44|1,-38|-5,-38|-5,-33|-8,-33|-8,-43|0,-43|0,-39|-6,-39|-6,-37|-6,-34|-7,-34|-7,-37|-7,-42|-1,-42|-3,-40|-5,-41"
lousyPigPlainFR := "-6,-19|-6,-28|-5,-28|-5,-32|-4,-32|-4,-37|1,-37|1,-35|-1,-34|-3,-23|-4,-23|-4,-19|-5,-19|-5,-27|-4,-24|-3,-36|0,-36"
treechnidForestEdgeFR := "-17,-18|-4,-18|-4,-10|-7,-11|-5,-11|-7,-6|-8,-5|-10,-4|-11,-4|-12,-6|-13,-7|-14,-9|-16,-10|-17,-12|-17,-17"
treechnidForestInnerFR := "-14,-15|-9,-15|-9,-14|-14,-14|-14,-13|-9,-13|-9,-12|-14,-12|-11,-10|-9,-11|-10,-10"
caniaMassifFR := "-18,-19|-7,-19|-18,-20|-19,-23|-18,-25|-16,-25|-17,-21|-7,-21|-9,-22|-9,-28|-7,-19|-7,-32|-6,-32|-6,-29|-8,-29|-9,-31|-9,-36|-10,-36|-10,-33|-11,-29|-16,-35|-12,-37|-13,-36|-9,-36|-11,-35|-12,-22|-11,-22|-12,-25|-13,-32|-14,-31|-14,-22|-17,-23|-15,-24|-17,-24"
caniaBayFR := "-29,-10|-30,-11|-36,-10|-33,-11|-33,-13|-33,-15|-32,-19|-31,-20|-31,-12|-29,-12|-30,-14|-30,-18"
rockyRoadsFR := "-18,-18|-18,-14|-19,-12|-28,-12|-29,-13|-20,-13|-21,-14|-29,-14|-28,-17|-27,-15|-27,-17|-29,-18|-30,-19|-30,-30|-29,-20|-28,-19|-29,-34|-25,-34|-26,-32|-27,-34|-27,-21|-26,-18|-25,-17|-28,-15|-19,-15|-25,-16|-21,-17|-22,-20|-22,-27|-22,-23|-21,-29|-20,-35|-17,-35|-17,-33|-18,-34|-18,-29|-19,-35|-19,-26|-20,-28|-19,-25|-20,-21|-19,-22|-19,-15"

; koalak areas
dragoturkeyTerritoryFR := "-11,1|-11,-2|-22,-2|-23,1|-23,3|-22,2|-22,7|-21,9|-21,-2|-20,-2|-20,9|-19,8|-19,-1|-18,7|-18,8|-12,8|-18,6|-12,5|-12,-1"
enchantedLakesFR := "-11,-3|-21,-3|-21,-4|-17,-4|-12,-4|-12,-5|-21,-5|-20,-6|-13,-6|-14,-7|-20,-7|-19,-7|-19,-8|-17,-7|-14,-8|-15,-8|-16,-8|-18,-9|-18,-8|-19,-11|-17,-10|-18,-13"
nauseatingSwampsFR := "-4,13|-6,12|-5,11|-6,10|-8,11|-8,7|-7,5|-9,7|-10,5|-9,3|-9,2|-7,-5|-5,-5|-5,-4|-7,-2|-6,3|-8,-2|-7,3|-8,2|-8,1|-9,2"
kaliptusForestFR := "-11,2|-11,12|-9,14|-6,14|-8,13|-7,12|-9,9|-10,11|-10,6"

; bonta areas
bontaCityWallsFR := "-38,-50|-30,-49|-28,-48|-25,-55|-24,-48|-24,-62|-25,-58|-25,-65|-22,-64|-24,-63|-28,-65|-30,-62|-31,-64|-32,-65|-33,-63"
bontaFR := "-26,-61|-26,-49|-27,-49|-27,-56|-27,-57|-28,-61|-28,-49|-29,-48|-29,-62|-30,-61|-30,-50|-31,-50|-31,-61|-32,-60|-32,-50|-33,-50|-33,-53|-33,-60|-34,-61|-34,-50|-35,-51|-35,-55|-35,-61|-36,-57|-37,-51|-38,-53|-37,-58|-37,-54"
caniaFieldsFR := "-24,-35|-31,-35|-31,-36|-21,-36|-21,-37|-31,-37|-32,-38|-21,-38|-21,-39|-36,-39|-36,-40|-21,-40|-21,-41|-36,-41|-36,-42|-31,-42|-21,-42|-21,-43|-36,-43|-32,-44|-21,-44|-22,-45|-36,-45|-39,-46|-23,-46|-24,-47|-39,-47|-38,-48|-39,-49|-31,-48"
rockyPlainsFR := "-23,-56|-16,-56|-23,-55|-23,-54|-16,-53|-23,-52|-16,-52|-16,-51|-23,-51|-23,-50|-16,-50|-23,-49|-23,-48|-16,-47|-23,-47|-22,-46|-16,-46|-21,-45"
eltnegWoodFR := "-15,-59|-15,-45|-14,-45|-14,-54|-13,-59|-13,-47|-12,-47|-12,-57|-12,-59|-11,-56|-11,-59"
crowDomainFR := "-15,-60|-11,-60|-11,-62|-15,-62|-15,-61|-12,-61"
heroesCemeteryFR := "-16,-57|-23,-57|-23,-62|-16,-62|-16,-58|-22,-58|-22,-61|-17,-61|-17,-59|-21,-59|-21,-60|-18,-60"
stonetuskDesertFR := "-8,-49|1,-49|1,-50|-8,-50|-7,-51|1,-51|4,-57|-3,-52|-4,-52|-5,-52|-8,-52|-8,-53|-3,-54|-4,-54|-5,-54|-6,-54|-8,-55|-3,-55|-1,-56|-6,-57|-1,-57|-2,-58|-6,-59|-2,-59|-3,-60|-6,-60"

; brakmar areas
brakmarCityWallsFR := "-18,40|-19,37|-19,34|-18,36|-20,32|-19,31|-20,29|-32,29|-34,30|-35,31|-35,36|-35,37|-34,38|-33,38|-32,35|-33,34|-32,31|-32,34|-31,33|-26,30|-25,30|-21,30"
brakmarFR := "-20,33|-20,42|-18,41|-19,38|-21,41|-21,31|-23,31|-30,31|-31,35|-32,36|-31,38|-31,37|-30,36|-29,38|-29,40|-29,37|-29,32|-22,32|-22,41|-26,41|-28,40|-25,39|-24,40|-24,33|-23,40|-22,40|-22,33|-25,34|-25,38|-28,38|-28,34|-26,34|-27,37|-27,35"
cemeteryOfTheTorturedFR := "-17,35|-17,39|-17,41|-16,35|-9,35|-9,36|-15,36|-10,38|-11,39|-12,37|-12,41|-15,41|-13,40|-13,39|-13,37|-14,38|-15,37|-15,38"
desolationOfSidimoteFR := "-27,15|-20,15|-20,18|-20,25|-20,28|-28,28|-26,27|-23,27|-21,26|-21,16|-28,16|-28,21|-26,23|-25,25|-22,25|-22,22|-22,17|-27,17|-27,18|-22,18|-26,19|-22,20|-22,21|-25,21|-26,21|-28,21|-28,20|-22,20"
howlingHeightsFR := "-23,0|-29,-1|-23,-1|-23,-2|-28,-2|-27,-3|-23,-3|-23,-4|-27,-4|-27,-5|-22,-5|-21,-6|-27,-6|-27,-7|-21,-7|-21,-8|-27,-8|-28,-9|-20,-9|-20,-11|-28,-11|-28,-10|-21,-10"

; islands...
otomaiFR := ""
moonFR := ""
pandalaFR := ""

allAstrubRoutes := {"astrubForestFR":astrubForestFR,"astrubCemeteryFR":astrubCemeteryFR,"astrubMeadowFR":astrubMeadowFR,"astrubFieldsFR":astrubFieldsFR,"astrubTainelaFR":astrubTainelaFR}
allAmaknaSufokiaRoutes := {"cracklerMountainFR":cracklerMountainFR,"madrestamHarbourkawaiiRiverFR":madrestamHarbourkawaiiRiverFR,"lowCracklerMountainFR":lowCracklerMountainFR,"bworkGoblinVillageFR":bworkGoblinVillageFR,"edgeOfEvilForestFR":edgeOfEvilForestFR,"amaknaForestFR":amaknaForestFR,"banditTerritoryAmaknaCemeteryFR":banditTerritoryAmaknaCemeteryFR,"scaraleafPlainPorcoTerritoryFR":scaraleafPlainPorcoTerritoryFR,"jellyPeninsulaFR":jellyPeninsulaFR,"amaknaMainAreaFR":amaknaMainAreaFR,"sufokianShorelineFR":sufokianShorelineFR,"sufokiaFR":sufokiaFR,"dreggonAreaFR":dreggonAreaFR}
allCaniaMainRoutes := {"caniaLakeFR":caniaLakeFR,"lousyPigPlainFR":lousyPigPlainFR,"treechnidForestEdgeFR":treechnidForestEdgeFR,"treechnidForestInnerFR":treechnidForestInnerFR,"caniaMassifFR":caniaMassifFR,"caniaBayFR":caniaBayFR,"rockyRoadsFR":rockyRoadsFR}
allKoalakRoutes := {"dragoturkeyTerritoryFR":dragoturkeyTerritoryFR,"enchantedLakesFR":enchantedLakesFR,"nauseatingSwampsFR":nauseatingSwampsFR,"kaliptusForestFR":kaliptusForestFR}
allBontaRoutes := {"bontaCityWallsFR":bontaCityWallsFR,"bontaFR":bontaFR,"caniaFieldsFR":caniaFieldsFR,"rockyPlainsFR":rockyPlainsFR,"eltnegWoodFR":eltnegWoodFR,"crowDomainFR":crowDomainFR,"heroesCemeteryFR":heroesCemeteryFR,"stonetuskDesertFR":stonetuskDesertFR}
allBrakmarRoutes := {"brakmarCityWallsFR":brakmarCityWallsFR,"brakmarFR":brakmarFR,"cemeteryOfTheTorturedFR":cemeteryOfTheTorturedFR,"desolationOfSidimoteFR":desolationOfSidimoteFR,"howlingHeightsFR":howlingHeightsFR}
allMainIslandRoutes := {}
for key, val in allAstrubRoutes
	allMainIslandRoutes[key] := 
for key, val in allAmaknaSufokiaRoutes
	allMainIslandRoutes[key] := val
for key, val in allCaniaMainRoutes
	allMainIslandRoutes[key] := val
for key, val in allKoalakRoutes
	allMainIslandRoutes[key] := val
for key, val in allBontaRoutes
	allMainIslandRoutes[key] := val
for key, val in allBrakmarRoutes
	allMainIslandRoutes[key] := val

; Labels
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================
; skip running these labels
goto exVAR

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

activateHotkeys:
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
	return

deactivateHotkeys:
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
	return
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
	return

QuickUpdateVars:
	Gui, mainWindowG:Submit, NoHide
	return

UpdateVars:
	gosub deactivateHotkeys
	Gui, mainWindowG:Submit, NoHide
	gosub activateHotkeys
	c := 1
	Loop, 8
	{
		if(MainCheck%A_Index%){
			mainChar := EIni%A_Index%
		}
		if AIni%A_Index%
		{
			ini%c% := EIni%A_Index%
			ini%c% .= " - Dofus"
			iniAutoSwitch%c% := AutoSwitchIni%A_Index%
			c++
		}
	}
	accounts := c - 1
	return

; save settings as ini file
SaveSettings:
	IniWrite, % DofusEndOfTurnButtonDDL, %inilocation%, general, DofusEndOfTurnButtonDDL
	IniWrite, % DofusEndOfTurnButtonHK, %inilocation%, general, DofusEndOfTurnButtonHK
	IniWrite, % DofusEndOfTurnButtonDDLCheck, %inilocation%, general, DofusEndOfTurnButtonDDLCheck
	IniWrite, % DofusEndOfTurnButtonHKCheck, %inilocation%, general, DofusEndOfTurnButtonHKCheck

	IniWrite, % HeroesEndOfTurnButtonDDL, %inilocation%, general, HeroesEndOfTurnButtonDDL
	IniWrite, % HeroesEndOfTurnButtonHK, %inilocation%, general, HeroesEndOfTurnButtonHK
	IniWrite, % HeroesEndOfTurnButtonDDLCheck, %inilocation%, general, HeroesEndOfTurnButtonDDLCheck
	IniWrite, % HeroesEndOfTurnButtonHKCheck, %inilocation%, general, HeroesEndOfTurnButtonHKCheck

	IniWrite, % LeftClickButtonDDL, %inilocation%, general, LeftClickButtonDDL
	IniWrite, % LeftClickButtonHK, %inilocation%, general, LeftClickButtonHK
	IniWrite, % LeftClickButtonDDLCheck, %inilocation%, general, LeftClickButtonDDLCheck
	IniWrite, % LeftClickButtonHKCheck, %inilocation%, general, LeftClickButtonHKCheck

	IniWrite, % SwitchNextButtonDDL, %inilocation%, general, SwitchNextButtonDDL
	IniWrite, % SwitchNextButtonHK, %inilocation%, general, SwitchNextButtonHK
	IniWrite, % SwitchNextButtonDDLCheck, %inilocation%, general, SwitchNextButtonDDLCheck
	IniWrite, % SwitchNextButtonHKCheck, %inilocation%, general, SwitchNextButtonHKCheck

	IniWrite, % SwitchLastButtonDDL, %inilocation%, general, SwitchLastButtonDDL
	IniWrite, % SwitchLastButtonHK, %inilocation%, general, SwitchLastButtonHK
	IniWrite, % SwitchLastButtonDDLCheck, %inilocation%, general, SwitchLastButtonDDLCheck
	IniWrite, % SwitchLastButtonHKCheck, %inilocation%, general, SwitchLastButtonHKCheck

	IniWrite, % StartBattleButtonDDL, %inilocation%, general, StartBattleButtonDDL
	IniWrite, % StartBattleButtonHK, %inilocation%, general, StartBattleButtonHK
	IniWrite, % StartBattleButtonDDLCheck, %inilocation%, general, StartBattleButtonDDLCheck
	IniWrite, % StartBattleButtonHKCheck, %inilocation%, general, StartBattleButtonHKCheck

	IniWrite, % SetButton, %inilocation%, general, SetButton
	IniWrite, % JoinButtonDDL, %inilocation%, general, JoinButtonDDL
	IniWrite, % JoinButtonHK, %inilocation%, general, JoinButtonHK
	IniWrite, % JoinButtonDDLCheck, %inilocation%, general, JoinButtonDDLCheck
	IniWrite, % JoinButtonHKCheck, %inilocation%, general, JoinButtonHKCheck

	IniWrite, % joinX, %inilocation%, general, joinX
	IniWrite, % joinY, %inilocation%, general, joinY

	IniWrite, % StopIfFound, %inilocation%, findtextstuff, StopIfFound
	IniWrite, % ClipBoardMode, %inilocation%, findtextstuff, ClipBoardMode
	IniWrite, % InsertMode, %inilocation%, findtextstuff, InsertMode
	IniWrite, % ValidateKey, %inilocation%, findtextstuff, ValidateKey
	IniWrite, % ChatKey, %inilocation%, findtextstuff, ChatKey
	Loop, 3
	{
		IniWrite, % FTScan%A_Index%, %inilocation%, findtextstuff, FTScan%A_Index%
		IniWrite, % FTRange%A_Index%, %inilocation%, findtextstuff, FTRange%A_Index%
		IniWrite, % FTError%A_Index%, %inilocation%, findtextstuff, FTError%A_Index%
		IniWrite, % FTCheck%A_Index%, %inilocation%, findtextstuff, FTCheck%A_Index%
	}
	IniWrite, % CoordSetupRange, %inilocation%, findtextstuff, CoordSetupRange
	IniWrite, % CoordSetupError, %inilocation%, findtextstuff, CoordSetupError
	Loop, 12
	{
		IniWrite, % CoordSetupT%A_Index%, %inilocation%, findtextstuff, CoordSetupT%A_Index%
	}

	IniWrite, % GPST, %inilocation%, findtextstuff, GPST
	IniWrite, % GPSRange, %inilocation%, findtextstuff, GPSRange
	IniWrite, % OKT, %inilocation%, findtextstuff, OKT
	IniWrite, % OKRange, %inilocation%, findtextstuff, OKRange
	
	IniWrite, % ControlKey, %inilocation%, general, ControlKey

	Loop, 8
	{
		IniWrite, % EIni%A_Index%, %inilocation%, characters, EIni%A_Index%
		IniWrite, % AIni%A_Index%, %inilocation%, characters, AIni%A_Index%
		IniWrite, % MainCheck%A_Index%, %inilocation%, characters, MainCheck%A_Index%
		IniWrite, % AutoSwitchIni%A_Index%, %inilocation%, characters, AutoSwitchIni%A_Index%
	}
	return

; load settings from ini file
LoadSettings:
	tmp := ""
	IniRead, tmp, %inilocation%, general, DofusEndOfTurnButtonDDL,
	GuiControl,mainWindowG:Choose, DofusEndOfTurnButtonDDL, %tmp%
	IniRead, tmp, %inilocation%, general, DofusEndOfTurnButtonHK,
	GuiControl,mainWindowG:, DofusEndOfTurnButtonHK, %tmp%
	IniRead, tmp, %inilocation%, general, DofusEndOfTurnButtonDDLCheck,0
	GuiControl,mainWindowG:, DofusEndOfTurnButtonDDLCheck, %tmp%
	IniRead, tmp, %inilocation%, general, DofusEndOfTurnButtonHKCheck,1
	GuiControl,mainWindowG:, DofusEndOfTurnButtonHKCheck, %tmp%

	IniRead, tmp, %inilocation%, general, HeroesEndOfTurnButtonDDL,
	GuiControl,mainWindowG:Choose, HeroesEndOfTurnButtonDDL, %tmp%
	IniRead, tmp, %inilocation%, general, HeroesEndOfTurnButtonHK,
	GuiControl,mainWindowG:, HeroesEndOfTurnButtonHK, %tmp%
	IniRead, tmp, %inilocation%, general, HeroesEndOfTurnButtonDDLCheck,0
	GuiControl,mainWindowG:, HeroesEndOfTurnButtonDDLCheck, %tmp%
	IniRead, tmp, %inilocation%, general, HeroesEndOfTurnButtonHKCheck,1
	GuiControl,mainWindowG:, HeroesEndOfTurnButtonHKCheck, %tmp%

	IniRead, tmp, %inilocation%, general, LeftClickButtonDDL,
	GuiControl,mainWindowG:Choose, LeftClickButtonDDL, %tmp%
	IniRead, tmp, %inilocation%, general, LeftClickButtonHK,
	GuiControl,mainWindowG:, LeftClickButtonHK, %tmp%
	IniRead, tmp, %inilocation%, general, LeftClickButtonDDLCheck,0
	GuiControl,mainWindowG:, LeftClickButtonDDLCheck, %tmp%
	IniRead, tmp, %inilocation%, general, LeftClickButtonHKCheck,1
	GuiControl,mainWindowG:, LeftClickButtonHKCheck, %tmp%

	IniRead, tmp, %inilocation%, general, SwitchNextButtonDDL,
	GuiControl,mainWindowG:Choose, SwitchNextButtonDDL, %tmp%
	IniRead, tmp, %inilocation%, general, SwitchNextButtonHK,
	GuiControl,mainWindowG:, SwitchNextButtonHK, %tmp%
	IniRead, tmp, %inilocation%, general, SwitchNextButtonDDLCheck,0
	GuiControl,mainWindowG:, SwitchNextButtonDDLCheck, %tmp%
	IniRead, tmp, %inilocation%, general, SwitchNextButtonHKCheck,1
	GuiControl,mainWindowG:, SwitchNextButtonHKCheck, %tmp%

	IniRead, tmp, %inilocation%, general, SwitchLastButtonDDL,
	GuiControl,mainWindowG:Choose, SwitchLastButtonDDL, %tmp%
	IniRead, tmp, %inilocation%, general, SwitchLastButtonHK,
	GuiControl,mainWindowG:, SwitchLastButtonHK, %tmp%
	IniRead, tmp, %inilocation%, general, SwitchLastButtonDDLCheck,0
	GuiControl,mainWindowG:, SwitchLastButtonDDLCheck, %tmp%
	IniRead, tmp, %inilocation%, general, SwitchLastButtonHKCheck,1
	GuiControl,mainWindowG:, SwitchLastButtonHKCheck, %tmp%

	IniRead, tmp, %inilocation%, general, StartBattleButtonDDL,
	GuiControl,mainWindowG:Choose, StartBattleButtonDDL, %tmp%
	IniRead, tmp, %inilocation%, general, StartBattleButtonHK,
	GuiControl,mainWindowG:, StartBattleButtonHK, %tmp%
	IniRead, tmp, %inilocation%, general, StartBattleButtonDDLCheck,0
	GuiControl,mainWindowG:, StartBattleButtonDDLCheck, %tmp%
	IniRead, tmp, %inilocation%, general, StartBattleButtonHKCheck,1
	GuiControl,mainWindowG:, StartBattleButtonHKCheck, %tmp%

	IniRead, tmp, %inilocation%, general, SetButton,
	GuiControl,mainWindowG:, SetButton, %tmp%

	IniRead, tmp, %inilocation%, general, joinButtonDDL,
	GuiControl,mainWindowG:Choose, joinButtonDDL, %tmp%
	IniRead, tmp, %inilocation%, general, joinButtonHK,
	GuiControl,mainWindowG:, joinButtonHK, %tmp%

	IniRead, tmp, %inilocation%, general, joinButtonDDLCheck,0
	GuiControl,mainWindowG:, joinButtonDDLCheck, %tmp%
	IniRead, tmp, %inilocation%, general, joinButtonHKCheck,1
	GuiControl,mainWindowG:, joinButtonHKCheck, %tmp%

	IniRead, joinX, %inilocation%, general, joinX,0
	IniRead, joinY, %inilocation%, general, joinY,0
	GuiControl,mainWindowG:, Coords, Currently: %joinX%, %joinY%

	IniRead, tmp, %inilocation%, general, ControlKey,
	GuiControl,mainWindowG:Choose, ControlKey, %tmp%

	IniRead, tmp, %inilocation%, findtextstuff, StopIfFound,0
	GuiControl,mainWindowG:, StopIfFound, %tmp%
	Loop, 3
	{
		IniRead, tmp1, %inilocation%, findtextstuff, FTScan%A_Index%,%A_Space%
		IniRead, tmp2, %inilocation%, findtextstuff, FTRange%A_Index%,%A_Space%
		IniRead, tmp3, %inilocation%, findtextstuff, FTError%A_Index%,%A_Space%
		IniRead, tmp4, %inilocation%, findtextstuff, FTCheck%A_Index%,0
		GuiControl,mainWindowG:,FTScan%A_Index%, %tmp1%
		GuiControl,mainWindowG:,FTRange%A_Index%, %tmp2%
		GuiControl,mainWindowG:,FTError%A_Index%, %tmp3%
		GuiControl,mainWindowG:,FTCheck%A_Index%, %tmp4%
	}
	IniRead, tmp, %inilocation%, findtextstuff, CoordSetupRange,%A_Space%
	GuiControl,mainWindowG:, CoordSetupRange, %tmp%
	IniRead, tmp, %inilocation%, findtextstuff, CoordSetupError,%A_Space%
	GuiControl,mainWindowG:, CoordSetupError, %tmp%
	Loop, 12
	{
		IniRead, tmp1, %inilocation%, findtextstuff, CoordSetupT%A_Index%,%A_Space%
		GuiControl,mainWindowG:,CoordSetupT%A_Index%, %tmp1%
	}

	IniRead, tmp, %inilocation%, findtextstuff, GPST,%A_Space%
	GuiControl,mainWindowG:, GPST, %tmp%
	IniRead, tmp, %inilocation%, findtextstuff, GPSRange,%A_Space%
	GuiControl,mainWindowG:, GPSRange, %tmp%
	IniRead, tmp, %inilocation%, findtextstuff, OKT,%A_Space%
	GuiControl,mainWindowG:, OKT, %tmp%
	IniRead, tmp, %inilocation%, findtextstuff, OKRange,%A_Space%
	GuiControl,mainWindowG:, OKRange, %tmp%

	IniRead, tmp, %inilocation%, findtextstuff, ClipBoardMode,1
	GuiControl,mainWindowG:, ClipBoardMode, %tmp%
	IniRead, tmp, %inilocation%, findtextstuff, InsertMode,0
	GuiControl,mainWindowG:, InsertMode, %tmp%
	IniRead, tmp, %inilocation%, findtextstuff, ChatKey,
	GuiControl,mainWindowG:, ChatKey, %tmp%
	IniRead, tmp, %inilocation%, findtextstuff, ValidateKey,Enter
	GuiControl,mainWindowG:Choose, ValidateKey, %tmp%

	Loop, 8
	{	
		IniRead, tmp1, %inilocation%, characters, EIni%A_Index%,%A_Space%
		IniRead, tmp2, %inilocation%, characters, AIni%A_Index%,0
		IniRead, tmp3, %inilocation%, characters, AutoSwitchIni%A_Index%,0
		IniRead, tmp4, %inilocation%, characters, MainCheck%A_Index%,0
		GuiControl,mainWindowG:,EIni%A_Index%, %tmp1%
		GuiControl,mainWindowG:,AIni%A_Index%, %tmp2%
		GuiControl,mainWindowG:,AutoSwitchIni%A_Index%, %tmp3%
		GuiControl,mainWindowG:,MainCheck%A_Index%, %tmp4%
	}
	goto UpdateVars



; Functions
; ==============================================================================================================================================================================
; ==============================================================================================================================================================================


; ==============================================================================================================================================================================

exVAR:
	; skip