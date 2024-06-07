extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	intro()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func intro():
	$VideoStreamPlayer.play()
	await get_tree().create_timer(4.0).timeout
	$VideoStreamPlayer.visible = false
	$VideoStreamPlayer2.play()
	


func _on_button_pressed():
	#add_child(preload("res://level_scenes/level_sample.tscn").instantiate())
	get_tree().change_scene_to_file("res://level_scenes/level_sample.tscn")
