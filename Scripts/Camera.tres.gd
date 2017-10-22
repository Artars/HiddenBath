extends Camera2D

onready var player = get_owner().get_node("player")
export var rotateSpeed = 0.2
var rotating = false
var counter = 0

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	set_pos(player.get_pos())
	if rotating:
		counter -= delta
		if delta > 0:
			rotate(rotateSpeed * delta)
		else:
			set_rot(0)
			rotating = false
	pass

func rotate(time):
	rotating = true
	counter = time