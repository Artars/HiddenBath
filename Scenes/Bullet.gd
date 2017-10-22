extends Area2D

var speed = 0
var frontDir = Vector2(0, -1)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func LockAndFire(direction, spd):
	var angle = frontDir.angle_to(direction)
	frontDir = frontDir.rotated(angle)
	set_rot(get_rot() + angle)
	speed = spd
	set_process(true)
	pass
	
func _process(delta):
	set_pos(get_pos() + frontDir * speed * delta)
	pass
