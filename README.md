# DofusHeroes
A "small" AHK script for multi account optimization with a GUI, customizable hotkeys and more!
The .exe file can be run on systems that don't have AutoHotkey installed. You can also download/pull the script, take a look at it, change it up and "compile" it on your own!
Autohotkey by default only works on Windows. If you want to make it work on UNIX systems use a wine port like AutoHotkeyX!

This tool uses AutoHotkey to make handling multiple accounts (multiboxing) in the game Dofus easier by sending keyboard/mouse commands to multiple Dofus windows at once. Regarding TOS the tool is not 100% allowed, but it is not 100% forbidden as well. Every action sequence is started by the user via. customizable Hotkeys, hence it is no Bot. It simply exists to simplify window management of different dofus client windows.

I will not take responsibility for anyone who uses this tool and gets banned for it. It's a greyzone - use at your own risk!

# Release
Current version: v1.0 https://github.com/Yokani/DofusHeroes/releases/tag/v1.0

# HowTo:

General Information:

If minimized the program lands in tray. Click on the tray button to open it again. 
The settings are saved on correct termination (e.g. by pressing the "X" in the window). If you kill it, it won't save!
The settings are saved in a settings.ini file at the current directory. 
If the file doesn't exist the program initializes with some preset values for the hotkey configuration.

First Tab (Characters):
1) On the first tab enter the names of your characters according to the initiave order of your team
2) Check isActive? for every character that is logged in
3) Check autoSwitchOn? for every character you wish to switch client windows after his/her turn.

opt) Use the arrows on the left to change the initiative order live, for example if one of your characters had low hp

Second Tab (Hotkey customization):

On this tab you can set up your custom hotkeys. There mostly are a Drop-Down-List(DDL) and a Hotkey input field for each feature. The DDL is for mouse and other fixed keys that can't be used with the hotkey input field. Check the radio button on the left which of the two you want to use. Customize the hotkey on the right.
For the hotkey input field: Click into the field and press the hotkey you want to use.

1. Hotkey: Dofus-End-Of-Turn hotkey (DEOT): This is the hotkey in your game! Check your game options and enter the correct key here, or else many other features will not work correctly!
2. Hotkey: Heroes-End-Of-Turn hotkey: If you press this key, your DEOT key is sent to the currently active dofus window and if autoSwitchOn? is enabled for the current character the window of the next character in the initiative order is activated.
3. Hotkey: Battle Starter: This key sends your DEOT key to all "isActive?" characters in order to ready them for the fight!
4. Hotkey: Left-Click: This key performs a Left-Click in all "isActive?" characters at the current mouse position.
5. Hotkey: Right-Click: This key performs a Right-Click in all "isActive?" characters at the current mouse position.
6. Hotkey: Switch-Forward: This key switches from the current character window to the next one depending on initiative ordering.
7. Hotkey: Switch-Backward: This key switches from the current character window to the last one depending on initiative ordering.
8. Hotkey: Activate-X: This control key and a number activates the character window with the same number in the initiative ordering, e.g. Key + 2 activates the second characters window.

Third Tab (Infos and advanced stuff)

Currently only has hotkey information about the terminology used in AHK and the tool, e.g. '!' corresponds to the Alt Key.

FightJoiner:

With this feature you can enter a fight and make your other characters join without needing to switch to their windows. Follow the instructions in the GUI to set it up correctly.
