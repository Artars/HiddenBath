extends PanelContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var nodeLevelText
export var maxLevel = 10

func _ready():
	nodeLevelText = get_node("VBox/SelectionContainer/Level")
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass


func _on_PlayButton_pressed():
	var textLevel = "Level" + nodeLevelText.get_text() + ".tscn"
	get_tree().change_scene("res://Scenes/"+textLevel)
	pass # replace with function body


func _on_DecreaseB_pressed():
	var levelInt = nodeLevelText.get_text().to_int()
	if(levelInt > 1):
		nodeLevelText.set_text(String(levelInt-1))
	pass # replace with function body


func _on_IncreaseB_pressed():
	var levelInt = nodeLevelText.get_text().to_int()
	if(levelInt < maxLevel):
		nodeLevelText.set_text(String(levelInt+1))

func _on_Credits_pressed():
	get_owner().get_node("CreditsMenu").show()
	pass # replace with function body
