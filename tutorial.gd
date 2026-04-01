extends Control

signal textbox_closed
signal textbox_closed2

func _ready():
	State.scene = "res://Dennys_battle.tscn"
	display_text("Spilsbury, The Royal Fool, teaches you how to fight")
	await self.textbox_closed
	display_text2("Ok so you see your fight button there?")
	await self.textbox_closed2
	display_text2("Ok so you see your fight button there?")
	await self.textbox_closed2
	display_text2("Press it to deal damage, pretty simple")
	$DownArrow.show()
	await self.textbox_closed2
	$DownArrow.hide()
	display_text2("Next is your wish button")
	await self.textbox_closed2
	display_text2("Using it lets you wish upon our god, Jayquayveous.")
	$DownArrow4.show()
	await self.textbox_closed2
	display_text2("It could do different things or possibly just nothing")
	await self.textbox_closed2
	$DownArrow4.hide()
	display_text2("You have a few skills you can use, but...")
	$DownArrow3.show()
	await self.textbox_closed2
	$DownArrow3.hide()
	display_text2("You must have enough energy to cast them")
	$DownArrow5.show()
	await self.textbox_closed2
	$DownArrow5.hide()
	display_text2("Finnaly you can defend")
	await self.textbox_closed2
	display_text2("Which will make the next attack deal half damage and...")
	$DownArrow2.show()
	await self.textbox_closed2
	display_text2("Will grant you a full energy oposed to half")
	await self.textbox_closed2
	$DownArrow2.hide()
	display_text2("I would teach you how to dodge...")
	await self.textbox_closed2
	display_text2('But alot of our funding was cut in the name of "Efficiency"')
	await self.textbox_closed2
	display_text2("(Its actually so our senators can throw those crazy parties)")
	await self.textbox_closed2
	display_text2("...")
	await self.textbox_closed2
	display_text2("You did'nt hear that from me though")
	await self.textbox_closed2
	display_text2("Im sure you'll figure out how to dodge on your own")
	await self.textbox_closed2
	display_text2("Good luck, and may Jaequayvius be on your side")
	await self.textbox_closed2
	get_tree().change_scene_to_file("res://cutscene_1.tscn")

func _input(event):
	if Input.is_action_just_pressed("LMB a.k.a. lick my balls") and $TextBox.visible:
		$TextBox.hide()
		emit_signal('textbox_closed')
	if Input.is_action_just_pressed("LMB a.k.a. lick my balls") and $Textbox.visible:
		$Textbox.hide()
		emit_signal('textbox_closed2')



func display_text(text) -> void:
	$AP.position.y = 300
	$TextBox.show()
	$AnimationPlayer2.play("text_display")
	$TextBox/Label.text = text
	await self.textbox_closed
	$AP.position.y = 133



func display_text2(text) -> void:
	$Textbox.show()
	$AnimationPlayer3.play("text_display")
	$Textbox/Label.text = text
	await self.textbox_closed2
