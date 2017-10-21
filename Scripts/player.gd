extends Node2D

export var speed = 150
var moveType = 0
var dir = Vector2(0,-1)
export var angle = 5
export var stealthSpeed = 75
export var changeDelay = 1
var delay = changeDelay

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	delay -= delta
	if Input.is_action_pressed("ui_select"):
		if moveType == 0 and delay <= 0:
			moveType = 1
			delay = changeDelay
		elif moveType == 1 and delay <= 0:
			moveType = 0
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
		if Input.is_action_pressed("ui_left"):
			actual_pos.x -= stealthSpeed * delta
		if Input.is_action_pressed("ui_right"):
			actual_pos.x += stealthSpeed * delta
		if Input.is_action_pressed("ui_up"):
			actual_pos.y -= stealthSpeed * delta
		if Input.is_action_pressed("ui_down"):
			actual_pos.y += stealthSpeed * delta
		set_pos(actual_pos)
	pass