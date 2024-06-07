extends Control

@onready var task = preload("res://tasks.gd").new()

var v = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_button_pressed():
	print($CheckBox.button_pressed)
	if v != []:
		var s = ""
		if !$CheckBox6.button_pressed:
			if $CheckBox.button_pressed:
				s += 'T0'
			if $CheckBox2.button_pressed:
				s += 'T1'
			if $CheckBox3.button_pressed:
				s += 'S'
			if $CheckBox4.button_pressed:
				s += 'M'
			if $CheckBox5.button_pressed:
				s += 'L'
		if (task.eleventh_task(v, s)):
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

func _on_button_3_pressed():
	v = []
	for i in 3:
		v.append(task.first_task(int($input_1.get_text())))
	$output_2.set_text(str(v))

func _on_button_2_pressed():
	$input_1.set_text("")
	$input_2.set_text("")
	$output_1.set_text("")
	$output_2.set_text("")


func _on_check_box_6_pressed():
	$CheckBox.disabled  = !$CheckBox.disabled
	$CheckBox2.disabled = !$CheckBox2.disabled
	$CheckBox3.disabled = !$CheckBox3.disabled
	$CheckBox4.disabled = !$CheckBox4.disabled
	$CheckBox5.disabled = !$CheckBox5.disabled
