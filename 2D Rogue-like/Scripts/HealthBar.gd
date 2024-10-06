extends ProgressBar
@onready var damage = get_parent().get_parent().get_node("Player")
@onready var damage_bar = $DamageBar
var health=0
func _ready():
	damage.connect("damage_taken",Callable(self,"_process"))

func _process(new_health):
	var prev_health=min(max_value,new_health)
	value=health
	print(value,prev_health)
	if health <= 0:
		queue_free()
	if health<prev_health:
		$DmgTimer.start()
	else:
		damage_bar.value=health

func max_health(_health):
	health= _health
	max_value = health
	value = health
	$DamageBar.value = health
	$DamageBar.max_value = health

func _on_timer_timeout():
	damage_bar.value=health
