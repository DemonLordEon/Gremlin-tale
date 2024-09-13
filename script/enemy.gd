extends CharacterBody2D

@onready var death = get_node("/root/game/Death")

var speed = 40 
var player_chase = false 
var player = null

var health = 100 
var strength = 20

var enemy_dead = false

var gained_experience = 50

var player_inattack_zone = false 
var can_take_damage = true 

var a = 1

func _physics_process(delta):
	deal_with_damadge()
	update_health()
	var animation = $AnimatedSprite2D
	
	if player_chase:
		position += (player.position - position) / speed
		animation.play("walk")
		
		if (player.position.x - position.x) < 0:
			animation.flip_h = true
		else:
			animation.flip_h = false 
	else:
		animation.play("idle")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false 
	
func enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true 

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false 
		
func deal_with_damadge():
	if player_inattack_zone and global.player_current_attack:
		if can_take_damage:
			health -= death.strength
			$take_damage_cooldown.start()
			can_take_damage = false 
			print("slime health = ", health)
			if health <= 0:
				self.queue_free()

func _on_take_damage_cooldown_timeout():
	can_take_damage = true 
	
func update_health():
	var healthbar = $healthbar
	
	healthbar.value = health 
	
	if health >= 100:
		healthbar.visible = false 
	else:
		healthbar.visible = true 
