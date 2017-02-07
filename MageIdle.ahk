;;EQ spell spammer

;; max mana 
;; mana gain = 2 + (meditate / 12)
;; tick rate every 6 seconds
meditateDivder := 12
tickRate := 6
castLastLoop1 := 0
castLastLoop2 := 0
castLastLoop3 := 0
castLastLoop4 := 0

Gui, Add, Text,,  Fill out the form, and then push ok, click on everquest. it will wait 10 seconds and then start casting.

Gui, Add, Text,,  enter your Max Mana:
Gui, Add, Edit, vmanaMax
Gui, Add, Text,,  enter your meditate level:
Gui, Add, Edit, vmeditateLevel
Gui, Add, Text,,  enter your longest spell casting time:
Gui, Add, Edit, vlongestSpell
Gui, Add, Text,,  First Spell Hotkey:
Gui, Add, Edit, vspellHotKey1
Gui, Add, Text,,  First Spell Mana Cost:
Gui, Add, Edit, vspellMana1
Gui, Add, Text,,  Second Spell Hotkey:
Gui, Add, Edit, vspellHotKey2
Gui, Add, Text,,  Second Spell Mana Cost:
Gui, Add, Edit, vspellMana2 
Gui, Add, Text,,  Third Spell Hotkey:
Gui, Add, Edit, vspellHotKey3
Gui, Add, Text,,  Third Spell Mana Cost:
Gui, Add, Edit, vspellMana3
Gui, Add, Text,,  Fourth Spell Hotkey:
Gui, Add, Edit, vspellHotKey4
Gui, Add, Text,,  Fourth Spell Mana Cost:
Gui, Add, Edit, vspellMana4
Gui, Add, Button, default, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Show

return





ButtonOK:
Gui, Submit  ; Save the input from the user to each control's associated variable.

if manaMax <= 0
{
msgbox "your max mana has to be greater than 0"
goto, CloseApp
}
if longestSpell <= 0
{
longestSpell := 6
}else{
longestSpell := longestSpell + 3 ;add some space for recovery
}
manaGain := 2 + (meditateLevel / meditateDivder)
manaSitTimeSeconds := (manaMax / manaGain) * tickRate
manaSitTimeMS := 1000 * manaSitTimeSeconds
manaLeft := manaMax
sitFlag := 0
longestSpellMS := longestSpell * 1000

sleep, 10000

loop
{

	if (castLastLoop1 == 0)
	{
		if (spellMana1 <= manaLeft)
		{
			send, %spellHotkey1%
			castLastLoop1 := 1
			manaLeft := manaLeft - spellMana1
			sleep, %longestSpellMS%
		}else{
		sitFlag := 1
		}
	}
	if (castLastLoop2 == 0)
	{
		if (spellMana2 <= manaLeft)
		{
			send, %spellHotkey2%
			castLastLoop2 := 1
			manaLeft := manaLeft - spellMana2
			sleep, %longestSpellMS%
		}else{
			sitFlag := 1
		}
	}
	if (castLastLoop3 == 0)
	{
		if (spellMana3 <= manaLeft)
		{
			send, %spellHotkey3%
			castLastLoop3 := 1
			manaLeft := manaLeft - spellMana3
			sleep, %longestSpellMS%
		}else{
			sitFlag := 1
		}
	}
	if (castLastLoop4 == 0)
	{
		if (spellMana4 <= manaLeft)
		{
			send, %spellHotkey4%
			castLastLoop4 := 1
			manaLeft := manaLeft - spellMana4
			sleep, %longestSpellMS%
		}else{
			sitFlag := 1
		}
	}
	
	if (sitFlag == 1){
		send, ^s ;sit
		sleep, %manaSitTimeMS%
		send, {w down}
		sleep, 100
		send, {w up}
		sleep, 100
		send, {s down}
		sleep, 100
		send, {s up}
		sitFlag := 0
		manaLeft := manaMax
	}

	if (castLastLoop1 == 1 && castLastLoop2 == 1 && castLastLoop3 == 1 && castLastLoop4 == 1){
		castLastLoop1 := 0
		castLastLoop2 := 0
		castLastLoop3 := 0
		castLastLoop4 := 0
	}

	

}


return

CloseApp:
^!f1::
exitApp
