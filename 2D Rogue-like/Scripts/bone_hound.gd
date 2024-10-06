extends CharacterBody2D
signal bone_hound_attack
@onready var player=get_parent().get_parent().get_node("Player")
@export var Movement_Speed = 50
@export var damage = 10
var player_chase = false

func _physics_process(_delta):
	if player_chase:
		position += (player.position - position)/Movement_Speed

func _on_player_attack_hitbox_body_entered(body):
	if body.has_method("Player"):
		emit_signal('bone_hound_attack',damage)

func _on_detaction_area_body_entered(body):
	player=body
	player_chase=true
func bone_hound():
	pass

