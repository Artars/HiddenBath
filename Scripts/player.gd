extends Node2D

export var hurrySpeed = 150
var speed = hurrySpeed
var moveType = MOV_RUN
export var dir = Vector2(0,-1)
export var angle = 5
export var stealthSpeed = 75
export var changeDelay = 1
var delay = changeDelay
var animation
enum MovementType {MOV_RUN,MOV_WALK}
export var initialTime = 30
var initialRun = true

func _ready():
	GameManager.player = self
	animation = get_child(1)
	add_to_group("player")
	set_process(true)
	animation.play("Run")
	get_node("ProgressBar").show()
	
	pass
	
func _process(delta):
	initialTime -= delta
	if initialRun:
		if initialTime <= 0:
			get_tree().change_scene("res://Scenes/GameOver.tscn")
		else:
			get_node("ProgressBar").set_value(initialTime/30)
	#Debug --------------------------------
	#delay -= delta
	#if Input.is_action_pressed("ui_select"):
	#	if moveType == 0 and delay <= 0:
	#		changeToStealth()
	#		delay = changeDelay
	#	elif moveType == 1 and delay <= 0:
	#		beenSpotted()
	#		delay = changeDelay
	#Other inputs ---------------------------------------
	#Pause
	if Input.is_action_pressed("ui_cancel"):
		get_tree().set_pause(true)
		var menu = get_owner().get_node("PauseMenu")
		menu.set_pos(get_pos() - Vector2(128, 64))
		menu.show()
	#Diferent types of Movement -------------------------
	#Running movement
	if moveType == MOV_RUN:
		if Input.is_action_pressed("ui_left"):
			rotate(angle * delta)
			dir = dir.rotated(angle * delta)
	
		if Input.is_action_pressed("ui_right"):
			rotate(-angle * delta)
			dir = dir.rotated(-angle * delta)
		
		move(dir * speed * delta)
	#Walking movement ------------------------------------
	elif moveType == MOV_WALK:
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
		move(direction * stealthSpeed * delta)
		if direction.x != 0 or direction.y != 0:
			animation.play("Walk")
			set_rot(atan2(-direction.x,-direction.y))
		else:
			animation.play("Idle")
	pass

func changeToStealth():
	animation.play("Idle")
	moveType = MOV_WALK
	initialRun = false
	get_node("ProgressBar").hide()

func beenSpotted():
	moveType = MOV_RUN
	animation.play("Run")
	var rote = get_rot()
	dir = Vector2(-sin(rote),-cos(rote))