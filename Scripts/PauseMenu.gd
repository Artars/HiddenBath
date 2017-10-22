extends PopupPanel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_PopupMenu_item_pressed( ID ):
	if ID == 1:
		get_tree().set_pause(false)
		hide()
	if ID == 3:
		print("Troca de fase")
	pass # replace with function body

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().set_pause(false)
		hide()


func _on_PopupPanel_about_to_show():
	set_process(true)
	pass # replace with function body


func _on_PopupPanel_popup_hide():
	set_process(false)
	pass # replace with function body


func _on_Return_pressed():
	get_tree().set_pause(false)
	hide()
	pass # replace with function body
