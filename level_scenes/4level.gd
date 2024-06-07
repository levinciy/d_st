extends Control

@onready var task = preload("res://tasks.gd").new()

var names = ["тождественный ноль", "тождественная единица", "конъюнкция", "дизъюнкция", "сложение", 
			"штрих Шеффера", "стрелка Пирса", "импликация", "эквивалентность", "коимпликация",
			"обратная импликация", "обратная коимпликация", "функция-переменная", "функция-отрицания"]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in names:
		$choose_name.add_item(i)
		$choose_name.selected = -1
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_button_pressed():
	if $choose_name.selected != -1:
		if (task.fourth_task($choose_name.get_text(), $output_2.get_text())):
			$output_1.set_text("CONGRATS!")
			$right_glitch.visible = true
			$right_glitch.play()
			await get_tree().create_timer(1.0).timeout
			$right_glitch.visible = false
		else:
			$output_1.set_text("WRONG ANSWER")
			$wrong_glitch.visible = true
			$wrong_glitch.play()
			await get_tree().create_timer(1.0).timeout
			$wrong_glitch.visible = false
			
	else:
		$output_1.set_text("write right wtite")



func _on_again_pressed():
	get_tree().change_scene_to_file("res://level_scenes/4level.tscn")


func _on_button_2_pressed():
	$output_2.set_text(task.first_task(2))
