extends Node

var player
var gamemode = 0

func _ready():
	player = get_tree().get_root().find_node("player",true)
	pass

func foundPlayer():
	print("Detected player")
	player.beenSpotted()
	get_tree().call_group(0, "Enemies", "followPlayer", player)

func createNoise(position):
	print("Made noise in ", position)

func changeGameMode():
	gamemode = 1
	spawnEnemies()
	player.changeToStealth()

func spawnEnemies():
	#var spawnPlaces = get
	print("It's a terrible night to have a curse!")
