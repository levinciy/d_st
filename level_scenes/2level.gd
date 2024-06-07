extends Control

@onready var task = preload("res://tasks.gd").new()
# Called when the node enters the scene tree for the first time.
var second_par = 0
func _ready():
	task.task0([
		[0, 1, 0, 0, 0, 0],
		[1, 0, 1, 1, 0, 0],
		[0, 1, 0, 0, 0, 0],
		[0, 1, 0, 0, 1, 1],
		[0, 0, 0, 1, 0, 0],
		[0, 0, 0, 1, 0, 0]
	])
	task.adj_to_inc([[0, 1, 1, 0], [1, 0, 1, 1], [1, 1, 0, 1], [0, 1, 1, 0]])
	task.prufer_decode([1,1,3,3])
	task.fifth_task("11110000", "23", 3)
	task.fifth_task('1010', '1100', 2)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if Input.is_action_just_pressed("enter_input"):
		#_on_button_pressed()
	

func _on_button_pressed():
	if $input_1.get_text()!= "" && $input_3.get_text() != "":
		$output_1.set_text(task.second_task($input_1.get_text(), second_par, int($input_3.get_text())))
	else:
		$output_1.set_text("write right wtite")


#func _on_input_1_text_changed():
	#$".".set_text($".".get_text().replace("\n", ""))
	#$".".set_caret_column(1000)  #поменять на перевод в конец строки нормально

func _on_check_box_2_pressed():
	second_par = 1

func _on_check_box_pressed():
	second_par = 0

func _on_button_2_pressed():
	$input_1.set_text("")
	$input_3.set_text("")
	$output_1.set_text("")
