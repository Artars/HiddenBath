extends Sprite
func _ready():
	add_to_group("interact")
	var id = get_tile_ids()
	var target = get_owner().get_cell(id[0] - 1, id[1])
	print("o")
	if target.is_in_group("door"):
		print("oi")
	set_process(true)
	pass

func interact():
	var id = get_tile_ids()
	var target = get_owner().get_cell(id[0] - 1, id[1])
	target.use()
	pass