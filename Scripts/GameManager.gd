extends Node

var player
var gamemode = 0

func _ready():
	player = get_tree().get_root().find_node("Player",true)
	pass

func foundPlayer():
	print("Detected player")
	player.beenSpotted()
	get_tree().call_group(0, "Enemies", "followPlayer", player)

func createNoise(position):
	print("Made noise in ", position)

func changeGameMode():
	if(gamemode == 0):
		gamemode = 1
		spawnEnemies()
		player.changeToStealth()

func spawnEnemies():
	#var spawnPlaces = get
	get_tree().call_group(1, "Objects", "spawn_enemies")
	print("It's a terrible night to have a curse!")

func respawnEnemies():
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for ene in enemies:
		ene.remove_from_group("Enemies")
		ene.queue_free()
	spawnEnemies()