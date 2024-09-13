extends CharacterBody2D

@onready var enemy = get_node("/root/game/enemy")

var enemy_inattack_range = false 
var enemy_attack_cooldown = true 

@export var health = 100
@export var strength = 20
@export var magic = 1

@export var level = 1

var experience = 0
var experience_total = 0
var experience_required = get_experience_required(level + 1)

var player_alive = true 

var attack_ip = false 

const SPEED = 600.0
var current_dir = "idle"
var is_moving = false


func _physics_process(delta):
	player_movement(delta)
	move_and_slide()  # Move the player based on the calculated velocity
	enemy_attack()
	attack()
	update_health()
	
	if health <= 0:
		player_alive = false #add end screen /respan 
		health = 0
		print("player has been killed ")
		self.queue_free()
	
func player_movement(delta):
	is_moving = false
	
	if Input.is_action_pressed("right"):
		current_dir = "right"
		velocity.x = SPEED
		velocity.y = 0
		is_moving = true
	elif Input.is_action_pressed("left"):
		current_dir = "left"
		velocity.x = -SPEED
		velocity.y = 0
		is_moving = true
	elif Input.is_action_pressed("down"):
		current_dir = "down"
		velocity.y = SPEED
		velocity.x = 0
		is_moving = true
	elif Input.is_action_pressed("up"):
		current_dir = "up"
		velocity.y = -SPEED
		velocity.x = 0
		is_moving = true
	else:
		velocity.x = 0
		velocity.y = 0

	play_animation(is_moving)

func play_animation(is_moving):
	var animation = $AnimatedSprite2D
	
	match current_dir:
		"right":
			animation.flip_h = false
			if is_moving:
				animation.play("side_walking")
			else:
				if attack_ip == false:
					animation.play("idle_side")
		"left":
			animation.flip_h = true
			if is_moving:
				animation.play("side_walking")
			else:
				if attack_ip == false:
					animation.play("idle_side")
		"down":
			animation.flip_v = false  # Flip vertically if needed
			if is_moving:
				animation.play("front_walking")
			else:
				if attack_ip == false:
					animation.play("idle_front")
		"up":
			animation.flip_v = false  # Flip vertically if needed
			if is_moving:
				animation.play("back_walking")
			else:
				if attack_ip == false:
					animation.play("idle_back")
			
func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true 


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false 
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - enemy.strength
		enemy_attack_cooldown = false 
		$attack_cooldown.start()
		print(health) 

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true 
	
func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true 
		attack_ip = true 
		if dir == "right":
			$AnimatedSprite2D.flip_h = false 
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir ==  "left":
			$AnimatedSprite2D.flip_h = true  
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "down":  
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()
	
	
func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false 



func update_health():
	var healthbar = $healthbar
	
	healthbar.value = health 
	
	if health >= 100:
		healthbar .visible = false 
	else:
		healthbar.visible = true 
		
func _on_regen_timer_timeout():
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
		
func get_experience_required(lvl):  # Changed 'level' to 'lvl'
	return round(pow(lvl, 1.8) + lvl * 4)
	
func gain_experience(amount):
	experience_total += amount
	experience += amount 
	while experience >= experience_required:
		experience -= experience_required
		level_up()
		
func level_up():
	level += 1
	experience_required = get_experience_required(level)  # No need to add 1 here
	var stats = ['health', 'strength', 'magic']
	var random_stat = stats[randi() % stats.size()]
	set(random_stat, get(random_stat) + randi() % 4 + 2)
