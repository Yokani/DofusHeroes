# DofusHeroes
A "small" AHK script for multi account optimization with a GUI, customizable hotkeys and more!
The .exe file can be run on systems that don't have AutoHotkey installed. You can also download/pull the script, take a look at it, change it up and "compile" it on your own!
Autohotkey by default only works on Windows. If you want to make it work on UNIX systems use a wine port like AutoHotkeyX!

This tool uses AutoHotkey to make handling multiple accounts (multiboxing) in the game Dofus easier by sending keyboard/mouse commands to multiple Dofus windows at once. Regarding TOS the tool is not 100% allowed, but it is not 100% forbidden as well. Every action sequence is started by the user via. customizable Hotkeys, hence it is no Bot. It simply exists to simplify window management of different dofus client windows.

Additional info regarding TOS and so on...:
I marked features that are very grey-zonish as (! violates the golden rule !) in this readme. Everything that isn't marked as such is entirely fine to use according to mod statements on the forum and in general (other games as well).
Why? Well it's because of the golden rule: 1 keypress = 1 action in game. This is the case for almost all features of my script and if possible I try to find ways to keep it that way. 

I will not take responsibility for anyone who uses this tool and gets banned for it (in particular if using the grey-zone features). Use at your own risk!

Mind that some Anti-Virus software might think that the .exe (binary) is harmful. A scan of the binary can be found here: 
https://www.virustotal.com/gui/file/8cd6fd0ebaad373497c60c3fa0ed32e4d4754192d29bc389af4e01ac8566d7b9/detection
Zillya, MaxSecure & Cylance are "false-positives". You can google that... it's a common problem they have with AHK binaries. If you're still unsure take a look at the code yourself.

# Release
Current version: v1.2 https://github.com/Yokani/DofusHeroes/releases/
Download directly here: https://github.com/Yokani/DofusHeroes/releases/download/v1.2/dofusheroes.rar

# HowTo:

General Information:

The settings are saved on correct termination (e.g. by pressing the "X" in the window). If you kill it, it won't save!
The settings are saved in a settings.ini file in the utils directory
If the file doesn't exist the program initializes with some preset values for the hotkey configuration.

First Tab (Characters):

<a href="https://ibb.co/30BL2n2"><img src="https://i.ibb.co/Ytpqmxm/screen1.png" alt="screen1" border="0"></a>

1) On the first tab enter the names of your characters according to the initiave order of your team
2) Check isActive? for every character that is logged in
3) Check autoSwitchOn? for every character you wish to switch client windows after his/her turn.
4) Check main? for your main character, who is using the TrackNTraveler feature

opt) Use the arrows on the left to change the initiative order live, for example if one of your characters had low hp

In the example above we have Osaschmodas going first. He uses pets, hence we don't want to switch to the next character automatically after he ends his turn (autoSwitch is off). Jonny-Doe is our Iop. He doesn't use pets so we use the auto-switch feature to switch to our osa after his turn.

Second Tab (Hotkey customization):

<a href="https://ibb.co/K2D7yZC"><img src="https://i.ibb.co/1rMK2VH/screen2.png" alt="screen2" border="0"></a>

On this tab you can set up your custom hotkeys. There mostly are a Drop-Down-List(DDL) and a Hotkey input field for each feature. The DDL is for mouse and other fixed keys that can't be used with the hotkey input field. Check the radio button on the left which of the two you want to use. Customize the hotkey on the right.
For the hotkey input field: Click into the field and press the hotkey you want to use.

1. Hotkey: Dofus-End-Of-Turn hotkey (DEOT): This is the hotkey in your game! Check your game options and enter the correct key here, or else many other features will not work correctly!
2. Hotkey: Heroes-End-Of-Turn hotkey: If you press this key, your DEOT key is sent to the currently active dofus window and if autoSwitchOn? is enabled for the current character the window of the next character in the initiative order is activated.
3. Hotkey: Battle Starter: This key sends your DEOT key to all "isActive?" characters in order to ready them for the fight! (! violates the golden rule !)
4. Hotkey: Left-Click: This key performs a Left-Click in all "isActive?" characters at the current mouse position. (! violates the golden rule !)
5. Hotkey: Right-Click: This key performs a Right-Click in all "isActive?" characters at the current mouse position. (! violates the golden rule and won't work as expected)
6. Hotkey: Switch-Forward: This key switches from the current character window to the next one depending on initiative ordering.
7. Hotkey: Switch-Backward: This key switches from the current character window to the last one depending on initiative ordering.
8. Hotkey: Activate-X: This control key and a number activates the character window with the same number in the initiative ordering, e.g. Key + 2 activates the second characters window.

Third Tab (Infos and advanced stuff)

<a href="https://ibb.co/nj47WP3"><img src="https://i.ibb.co/M7KcXB8/screen3.png" alt="screen3" border="0"></a>

FightJoiner:

With this feature you can enter a fight and make your other characters join without needing to switch to their windows. Follow the instructions in the GUI to set it up correctly.

TrackNTraveler:

For the auto-traveling features you need to have a pre-sentient mount! (feed it a pre-sentient potion from the shop/market)
This feature requires some advanced setup, which i'll try to explain properly via the following guide.

<a href="https://ibb.co/xCM3gw5"><img src="https://i.ibb.co/mDHSydz/screen4.png" alt="screen4" border="0"></a>

The tracker feature enables you to track up to 3 patterns on your active dofus window and save the position where you found it for later use.
For example, you're traveling around via the travel feature, but would like to know if there were any archmonsters on your way, while you are doing something else, like cleaning dishes or something, i don't know your life! *coughs*
It's also possible to make the character stop while traveling if he/she spots the find you're looking for.

Alright, let's get this to work:
1) First we need to find the pattern we're looking for, let's take an archmonster as example (because that's how i'm using it).
<a href="https://imgbb.com/"><img src="https://i.ibb.co/JdRRcwb/screen6.png" alt="screen6" border="0"></a><br /><a target='_blank' href='https://de.imgbb.com/'>fotos im internet speichern</a><br />
Let's take this guy.

2) Alright, next: open up the findText script by FeiYue, press "Run FindText"
<a href="https://ibb.co/4P1bWFz"><img src="https://i.ibb.co/wMcnydV/screen7.png" alt="screen7" border="0"></a>
This will open up.
3) adjust the width and height settings at the top and then hit "Apply" - the window will reopen (i recommend 35x35, so you have a nice square to work with. If it's bigger than what you want to capture, no problem, if smaller you should make it bigger)
4) Next hit "Capture", a rectangle with your defined size will appear around your mouse. Move it, so it frames the thing you want to track, for me it's the archmonster flame icon. If you're content make 2 right clicks to continue.
5) A new window opens up to process the captured image for optimized recognition. This part is very important and will require some trial and error until you reliably recognize the pattern you're searching for!
For me it looks like this:
<a href="https://ibb.co/N7wgF0x"><img src="https://i.ibb.co/FnGkhQ6/screen8.png" alt="screen8" border="0"></a>
5.1) cut the edges using the L,R,U,D buttons on the left. The more you cut the faster it'll be found, however also less reliably so. Follow my example for now...
<a href="https://ibb.co/cggHRGM"><img src="https://i.ibb.co/w00X893/screen9.png" alt="screen9" border="0"></a>
This is fine for me
5.2) apply a color filter. This step is important, because shown colors are often very different and partly transparent etc. everything just messes with proper recogintion, if not properly preprocessed. The ones i useally use are Gray and GrayDiff. Simply press the Gray2Two button and the filter will be applied. It finds a certain value for the field on the left, which can be adjusted by you if the filter was not applied sucessfully. The value corresponds to how harsh the filter is applied (lower values = more harsh).

<a href="https://ibb.co/St5y04F"><img src="https://i.ibb.co/5rG4vgb/screen10.png" alt="screen10" border="0"></a><br /><a target='_blank' href='https://de.imgbb.com/'>gif datei download kostenlos</a><br />
Mine looks like this now. See the little errors on the bottom left side or around the eyes? I could make the filter more harsh so they vanish, or i could check the modify checkbox and correct the issue myself, by deleting the few pixels through clicking on them (or drawing those, that are necessary).
If the result is not pleasing you, hit "Reset" to start from the raw image capture again.
Hit "Close" to return to the former UI and make a new capture
If you're fine what you captured and processed, continue
5.3) Enter a tag in the comment section, which identifies what you're going to look for. For me it's simply "archmob". After that press "OK". Your inputs will now be taken to the main window. In the top you can now see the pattern you're going to look out for. Below is a small testing script so we can try if it actually works.
5.4) Hit "GetRange". you can now pull a rectangle by left clicking with your mouse. Frame the area where you want to look for the given pattern, in my case it's my whole dofus window. When finished the script call below will update after FindText(-your new coordinates are now here-, ...)
5.5) Hit "Test" to check if the pattern can currently be found. For me, it didn't (Found: 0), well that's because we're not completely finished yet!
5.6) In the script below it says if(ok:=FindText( a, b, c, d (your coordinates from GetRange), 0, 0, Text) the both 0 here are error ranges (ranging from 0 to 1) you can apply, so it tries to match something that looks similar and not exactly like your pattern. If you're setting it too high you're most likely getting false results. I'll try 0.2
<a href="https://ibb.co/fX1C7tM"><img src="https://i.ibb.co/D1V7nk4/screen11.png" alt="screen11" border="0"></a><br /><a target='_blank' href='https://de.imgbb.com/'>url link creator</a><br />
This is how it looks for me now. Let's try testing it again!
<a href="https://imgbb.com/"><img src="https://i.ibb.co/fYBBcHw/screen12.png" alt="screen12" border="0"></a>
Success :)
5.7) Now we just need to give Dofus Heroes the input we created. Copy the Text:="|... line and paste it in the text output field. Copy the first few parameters from your GetRange output (in my case 403, 13, 2161, 1411) and paste it in the GetRange output field. Then enter the allowed error you want to use and activate it.

6) Hit "Start or Stop TrackNTraveler" to open op the tracker. A New window will appear, which always remains on top of everything.
<a href="https://imgbb.com/"><img src="https://i.ibb.co/vLkXzLP/screen5.png" alt="screen5" border="0"></a>
