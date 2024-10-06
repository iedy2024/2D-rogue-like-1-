extends CharacterBody2D
signal damage_taken
@export var Max_Health = 100
@export var Movement_Speed = 300
var Current_Health=Max_Health 
var in_enemy_attack = false
var alive=true
var attack_cooldown=true
@onready var enemy = get_parent().get_node("Bone Hound")

func _ready():
	enemy.connect("bone_hound_attack",Callable(self,"enemy_attack"))

func enemy_attack(damage:int):
	if in_enemy_attack and attack_cooldown==true:
			Current_Health -= damage
			emit_signal('damage_taken',Current_Health)
			print(Current_Health)
			attack_cooldown = false
			$AttackCooldown.start()

func _physics_process(_delta):
		var x=Input.get_action_strength("Right")-Input.get_action_strength("Left")
		var y=Input.get_action_strength("Down")-Input.get_action_strength("Up")
		var direction = Vector2(x,y)
		velocity=direction * Movement_Speed
		enemy_attack(_delta)
		if Current_Health <= 0:
			alive=false
			get_tree().change_scene_to_file("res://death_screen.tscn")
		move_and_slide()

func _on_player_attack_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		in_enemy_attack = true


func _on_player_attack_hitbox_body_exited(body):
	if body.is_in_group("Enemy"):
		in_enemy_attack = false


func _on_attack_cooldown_timeout():
	attack_cooldown=true

func player():
	pass
