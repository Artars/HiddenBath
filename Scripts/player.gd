extends Area2D

export var speed = 150
var moveType = 0
var dir = Vector2(0,-1)
export var angle = 5

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	if moveType == 0:
		if Input.is_action_pressed("ui_left"):
			rotate(angle * delta)
			dir = dir.rotated(angle * delta)
	
		if Input.is_action_pressed("ui_right"):
			rotate(-angle * delta)
			dir = dir.rotated(-angle * delta)
		
		set_pos(get_pos() + dir * speed * delta)
	
	pass
