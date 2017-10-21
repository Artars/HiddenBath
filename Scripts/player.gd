extends Node2D

export var speed = 150
var moveType = 0
var dir = Vector2(0,-1)
export var angle = 5
export var stealthSpeed = 75
export var changeDelay = 1
var delay = changeDelay
var animation

func _ready():
	GameManager.player = self
	animation = get_child(1)
	set_process(true)
	animation.play("Run")
	pass
	
func _process(delta):
	delay -= delta
	if Input.is_action_pressed("ui_select"):
		if moveType == 0 and delay <= 0:
			changeToStealth()
			delay = changeDelay
		elif moveType == 1 and delay <= 0:
			beenSpotted()
			delay = changeDelay
	
	if moveType == 0:
		if Input.is_action_pressed("ui_left"):
			rotate(angle * delta)
			dir = dir.rotated(angle * delta)
	
		if Input.is_action_pressed("ui_right"):
			rotate(-angle * delta)
			dir = dir.rotated(-angle * delta)
		
		set_pos(get_pos() + dir * speed * delta)
	elif moveType == 1:
		var actual_pos = get_pos()
		var direction = Vector2(0,0)
		if Input.is_action_pressed("ui_left"):
			direction.x -= 1
		if Input.is_action_pressed("ui_right"):
			direction.x += 1
		if Input.is_action_pressed("ui_up"):
			direction.y -= 1
		if Input.is_action_pressed("ui_down"):
			direction.y += 1
		if direction.x != 0 or direction.y != 0:
			animation.play("Walk")
			set_rot(atan2(-direction.x,-direction.y))
		else:
			animation.play("Idle")
		set_pos(get_pos() + direction*speed*delta)
	pass

func changeToStealth():
	moveType = 1

func beenSpotted():
	moveType = 0
	animation.play("Run")
	var rote = get_rot()
	dir = Vector2(-sin(rote),-cos(rote))