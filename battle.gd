extends Control

signal textbox_closed
@export var enemy: Resource = null

var current_player_health = 0
var current_enemy_health = 0
var is_a_coward = false
var energy = 0
var tough_guy = 0
var rng = RandomNumberGenerator
var i_cant_do_anything = 0
var shimmy = true
var idk = true





func death():
	if current_player_health == 0:
		print("bleh")
		display_text("You fall to the ground") 
		await $AnimationPlayer.animation_finished
		$AnimationPlayer.play("Lol_u_suck")
		await self.textbox_closed
		State.damage = 20
		get_tree().change_scene_to_file("res://death_screen.tscn")
	else:
		pass



func _ready():
	rng = RandomNumberGenerator.new()
	State.scene = "%s" % enemy.balls
	set_health($PP/
	PlayerData/ProgressBar, State.current_health, State.max_health)
	$EP/EnemyData/Marker2D/Enemy.texture = enemy.texture
	current_player_health = State.current_health
	current_enemy_health = enemy.health
	set_health($EP/EnemyData/ProgressBar, current_enemy_health, enemy.health)
	print(current_enemy_health)
	display_text("You approach %s!" % enemy.name)
	await self.textbox_closed
	$AP.show()
	State.minigame_1 = false
	State.minigame_2 = false
	State.minigame_3 = false

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP:%d/%d" % [health, max_health]


func _input(event):
	if Input.is_action_just_pressed("LMB a.k.a. lick my balls") and $TextBox.visible and shimmy == true:
		$TextBox.hide()
		emit_signal('textbox_closed')
		death()

func display_text(text) -> void:
	$AP.position.y = 300
	$Skills_menu.position.y = 300
	$TextBox.show()
	$AnimationPlayer2.play("text_display")
	$TextBox/Label.text = text
	await self.textbox_closed
	$AP.position.y = 133

func enemy_turn():
	if enemy.number == 1:
		enemy.damage = 20
	if enemy.number == 2:
		enemy.damage = 25
	if enemy.number == 3:
		enemy.damage = 35
	idk = true
	if tough_guy > 3:
		tough_guy -= 1
	if is_a_coward == true:
		energy += 2
	else:
		energy += 1
	energy_shit()
	rng.randomize()
	var num = randi_range(0, 2)
	shimmy = false
	if i_cant_do_anything > 1 and idk == true:
		idk = false
		display_text("%s was stunned and could'nt do anything" % enemy.name)
		i_cant_do_anything -= 1
		shimmy = true
		await self.textbox_closed
		
	if i_cant_do_anything == 1 and idk == true:
		idk = false
		display_text("%s was stunned and could'nt do anything" % enemy.name)
		i_cant_do_anything -= 1
		shimmy = true
		await self.textbox_closed
		$EP/EnemyData/Marker2D/Enemy.modulate = Color(1.0, 1.0, 1.0, 1.0)
		display_text("%s is no longer stunned" % enemy.name)
		await self.textbox_closed
		
	if i_cant_do_anything == 0:
		$AnimationPlayer.play("Transition")
		if is_a_coward == false:
			display_text("%s" % enemy.text1)
		if is_a_coward == true:
			display_text("%s" % enemy.text2)
		await $AnimationPlayer.animation_finished
		shimmy = true
		await self.textbox_closed
		$AP.position.y = 300
		if num == 0:
			$Camera2D.position.x = 330
			$Camera2D.position.y = 0
			State.minigame_1 = true
		if num == 1:
			$Camera2D.position.y = -190
			$Camera2D.position.x = 0
			State.minigame_2 = true
		if num == 2:
			$Camera2D.position.x = -330
			$Camera2D.position.y = 0
			State.minigame_3 = true
		await get_tree().create_timer(13.5).timeout
		$Camera2D.position.x = 0
		$Camera2D.position.y = 0
		$AnimationPlayer.play("transition2")
		shimmy = false
		if State.game_won == true:
			display_text("You dodged %s's attack" % enemy.name)
			await $AnimationPlayer.animation_finished
			shimmy = true
			await self.textbox_closed
		if State.game_won == false:
			display_text("%s's attack lands" % enemy.name)
			await $AnimationPlayer.animation_finished
			shimmy = true
			await self.textbox_closed
			if is_a_coward == false:
				
				current_player_health -= enemy.damage
				if current_player_health < 0:
					current_player_health = 0
				set_health($PP/PlayerData/ProgressBar, current_player_health, State.max_health)
				$AnimationPlayer.play("do_u_have_any_ibprofen?(YOU_BE_WHAT??!!)")
				await self.textbox_closed
				display_text("You lost %d health" % enemy.damage)
			elif is_a_coward == true:
				is_a_coward = false
				current_player_health -= enemy.damage /2
				if current_player_health < 0:
					current_player_health = 0
				set_health($PP/PlayerData/ProgressBar, current_player_health, State.max_health)
				$AnimationPlayer.play("do_u_have_any_ibprofen?(YOU_BE_WHAT??!!)_but_less")
				await self.textbox_closed
				display_text("You lost %d health" % enemy.damage)
				await self.textbox_closed




func _on_attack_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	$AP.position.y = 300
	display_text("You make a fist and strike %s as hard as you can" % enemy.name)
	await self.textbox_closed
	current_enemy_health = max(0, current_enemy_health - State.damage)
	set_health($EP/EnemyData/ProgressBar, current_enemy_health, enemy.health)
	if i_cant_do_anything > 0:
		display_text("You dealt %d damage" % State.damage) 
		$AnimationPlayer.play("This_sum_bullshit")
		shimmy = false
		await $AnimationPlayer.animation_finished
		shimmy = true
		$EP/EnemyData/Marker2D/Enemy.modulate = Color(1.0, 1.0, 0.0, 1.0)
	else:
		shimmy = false
		display_text("You dealt %d damage" % State.damage) 
		$AnimationPlayer.play("enemy_damage")
		await $AnimationPlayer.animation_finished
		shimmy = true
	await self.textbox_closed
	
	if current_enemy_health == 0:
		print("bleh")
		$AnimationPlayer.play("enemy_dies")
		display_text("%s" % enemy.text3) 
		await self.textbox_closed
		State.damage = 20
		if enemy.number == 1:
			get_tree().change_scene_to_file("res://cutscene_2.tscn")
		if enemy.number == 2:
			get_tree().change_scene_to_file("res://cutscene_3.tscn")
		if enemy.number == 3:
			get_tree().change_scene_to_file("res://cutscene_4.tscn")
	enemy_turn()


func _on_defend_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	is_a_coward = true
	display_text("You curl up and wrap your arms around yourself") 
	await self.textbox_closed
	enemy_turn()
	
func energy_shit():
	if energy > 6:
		energy = 6
	if energy < 0:
		energy = 0
	if energy == 0:
		$PP/PlayerData/HBoxContainer/TextureRect.texture = preload("res://Sprites/empty_energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect2.texture = preload("res://Sprites/empty_energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect3.texture = preload("res://Sprites/empty_energy.png")
	elif energy == 1:
		$PP/PlayerData/HBoxContainer/TextureRect.texture = preload("res://Sprites/half_energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect2.texture = preload("res://Sprites/empty_energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect3.texture = preload("res://Sprites/empty_energy.png")
	elif energy == 2:
		$PP/PlayerData/HBoxContainer/TextureRect.texture = preload("res://Sprites/Full energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect2.texture = preload("res://Sprites/empty_energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect3.texture = preload("res://Sprites/empty_energy.png")
	elif energy == 3:
		$PP/PlayerData/HBoxContainer/TextureRect.texture = preload("res://Sprites/Full energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect2.texture = preload("res://Sprites/half_energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect3.texture = preload("res://Sprites/empty_energy.png")
	elif energy == 4:
		$PP/PlayerData/HBoxContainer/TextureRect.texture = preload("res://Sprites/Full energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect2.texture = preload("res://Sprites/Full energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect3.texture = preload("res://Sprites/empty_energy.png")
	elif energy == 5:
		$PP/PlayerData/HBoxContainer/TextureRect.texture = preload("res://Sprites/Full energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect2.texture = preload("res://Sprites/Full energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect3.texture = preload("res://Sprites/half_energy.png")
	elif energy == 6:
		$PP/PlayerData/HBoxContainer/TextureRect.texture = preload("res://Sprites/Full energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect2.texture = preload("res://Sprites/Full energy.png")
		$PP/PlayerData/HBoxContainer/TextureRect3.texture = preload("res://Sprites/Full energy.png")
	

func _on_skills_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	$AP.position.y = -300
	$Skills_menu.position.y = 133
	
	
func no_energy_loser():
	display_text("You don't have enough energy")
	await self.textbox_closed
	

func _on_close_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	$AP.position.y = 133
	$Skills_menu.position.y = -300


func _on_heal_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	if energy >= 4:
		energy -= 4
		energy_shit()
		display_text("You turn the gear on your back")
		await self.textbox_closed
		display_text("You feel rejuvenated")
		await self.textbox_closed
		current_player_health += 35 
		$AnimationPlayer.play("Heal")
		if current_player_health > 100:
			current_player_health = 100
		set_health($PP/PlayerData/ProgressBar, current_player_health, State.max_health)
		display_text("you gain back 35 HP")
		await self.textbox_closed
		enemy_turn()
		$AP.position.y = 133
		$Skills_menu.position.y = -300
	else:
		no_energy_loser()


func _on_shock_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	if energy >= 4:
		energy -= 4
		energy_shit()
		display_text("You turn the gear on your back")
		await self.textbox_closed
		display_text("Lightning shoots out from your arms")
		await self.textbox_closed
		var num = randi_range(0, 1)
		if num == 0:
			display_text("%s dodged the attack" % enemy.name)
			await self.textbox_closed
		if num == 1:
			$AnimationPlayer.play("Zippy_Zap")
			$EP/EnemyData/Marker2D/Enemy.modulate = Color(1.0, 1.0, 0.0, 1.0)
			i_cant_do_anything = 3
			display_text("The lightning hits %s, stunning them" % enemy.name)
			await self.textbox_closed
			
			print("works ig")

		
		enemy_turn()
		$AP.position.y = 133
		$Skills_menu.position.y = -300
	else:
		no_energy_loser()


func _on_attack_up_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	if energy >= 4:
		energy -= 4
		energy_shit()
		display_text("You turn the gear on your back")
		await self.textbox_closed
		display_text("You feel much stronger")
		await self.textbox_closed
		State.damage *= 2
		tough_guy = 3
		$AnimationPlayer.play("Steroids")
		display_text("Your attack was multiplied by 2x")
		await self.textbox_closed
		enemy_turn()
		$AP.position.y = 133
		$Skills_menu.position.y = -300
	else:
		no_energy_loser()


func _on_wish_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	rng.randomize()
	display_text("You prayed to Jayquavious for some assistance")
	await self.textbox_closed
	var num = randi_range(0, 8)
	if num == 0:
		display_text("The wind might of gotten a little stronger, otherwise nothing happend")
		await self.textbox_closed
		enemy_turn()
	if num == 1:
		display_text("Absolutely nothing happend, maybe you shouldve spelt Jaquavieus consistantly")
		await self.textbox_closed
		enemy_turn()
	if num == 2:
		display_text("Both you and %s stub your toe" % enemy.name)
		await self.textbox_closed
		current_player_health -= 5
		set_health($PP/PlayerData/ProgressBar, current_player_health, State.max_health)
		$AnimationPlayer.play("do_u_have_any_ibprofen?(YOU_BE_WHAT??!!)_but_less")
		current_enemy_health -= 5
		set_health($EP/EnemyData/ProgressBar, current_enemy_health, enemy.health)
		$AnimationPlayer.play("enemy_damage")
		display_text("You each take 5 damage")
		await self.textbox_closed
		if current_enemy_health == 0:
			print("bleh")
			$AnimationPlayer.play("enemy_dies")
			display_text("%s" % enemy.text3) 
			State.damage = 20
			get_tree().change_scene_to_file("res://MainMenu.tscn")
		enemy_turn()
	if num == 3:
		display_text("You are both mysteriously repaired")
		await self.textbox_closed
		current_player_health += 40
		if current_player_health > 100:
			current_player_health = 100
		set_health($PP/PlayerData/ProgressBar, current_player_health, State.max_health)
		$AnimationPlayer.play("Heal")
		current_enemy_health += 40
		set_health($EP/EnemyData/ProgressBar, current_enemy_health, enemy.health)
		if current_enemy_health > enemy.health:
			current_enemy_health = enemy.health
		display_text("You both regain 40 HP")
		await self.textbox_closed
		enemy_turn()

	if num == 5:
		display_text("A ball roles by and hits both of you and a medium speed")
		await self.textbox_closed
		current_player_health /= 2
		set_health($PP/PlayerData/ProgressBar, current_player_health, State.max_health)
		$AnimationPlayer.play("do_u_have_any_ibprofen?(YOU_BE_WHAT??!!)")
		current_enemy_health /= 2
		set_health($EP/EnemyData/ProgressBar, current_enemy_health, enemy.health)
		$AnimationPlayer.play("enemy_damage")
		display_text("You both lose half your health")
		await self.textbox_closed
		display_text("It really wasnt moving that fast, you easily could've dodged it")
		await self.textbox_closed
		enemy_turn()
	if num == 6:
		display_text("Theres alot of static electricity in the air")
		await self.textbox_closed
		energy += 6
		energy_shit()
		display_text("Your energy is fully charged, unrelated to the static electricity")
		await self.textbox_closed
		display_text("Is that really how you thought this worked?")
		await self.textbox_closed
		enemy_turn()
	if num == 7:
		display_text("A rock lands on %s" % enemy.name)
		await self.textbox_closed
		current_enemy_health -= 50
		set_health($EP/EnemyData/ProgressBar, current_enemy_health, enemy.health)
		$AnimationPlayer.play("enemy_damage")
		display_text("%s takes 50 damage" % enemy.name)
		await self.textbox_closed
		if current_enemy_health == 0:
			print("bleh")
			$AnimationPlayer.play("enemy_dies")
			display_text("%s" % enemy.text3) 
			await self.textbox_closed
			State.damage = 20
			get_tree().change_scene_to_file("res://MainMenu.tscn")
		enemy_turn()
	if num == 4:
		display_text("Something... patched up your wounds")
		await self.textbox_closed
		current_player_health += 50
		if current_player_health > 100:
			current_player_health = 100
		set_health($PP/PlayerData/ProgressBar, current_player_health, State.max_health)
		$AnimationPlayer.play("Heal")
		display_text("You regain 50 HP")
		await self.textbox_closed
		enemy_turn()
	if num == 8:
		var num1 = randi_range(0, 99)
		if num1 > 0:
			display_text("You feel like something was supposed to happen, but nothing did")
			await self.textbox_closed
		if num1 == 0:
			pass
	enemy_turn()
