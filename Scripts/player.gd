extends Node2D

export var hurrySpeed = 150
var speed = hurrySpeed
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
	add_to_group("player")
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
		
		move(dir * speed * delta)
	elif moveType == 1:
		var actual_pos = get_pos()
		var direction = Vector2(0,0)
		if Input.is_action_pressed("ui_left"):
			move(Vector2(-1,0) * stealthSpeed * delta)
		if Input.is_action_pressed("ui_right"):
			move(Vector2(1,0) * stealthSpeed * delta)
		if Input.is_action_pressed("ui_up"):
			move(Vector2(0,-1) * stealthSpeed * delta)
		if Input.is_action_pressed("ui_down"):
			move(Vector2(0,1) * stealthSpeed * delta)
		#precisa consertar
	pass

func changeToStealth():
	animation.play("Idle")
	moveType = 1

func beenSpotted():
	moveType = 0
	animation.play("Run")
	var rote = get_rot()
	dir = Vector2(-sin(rote),-cos(rote))