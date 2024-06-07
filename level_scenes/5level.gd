extends Control

@onready var task = preload("res://tasks.gd").new()
var s = ""
var v = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_button_pressed():
	s = ""
	if $X1_sush/X1_sush.button_pressed:
		s += '1'
	if $X2_sush/X2_sush.button_pressed:
		s += '2'
	if $X3_sush/X3_sush.button_pressed:
		s += '3'
	if $X4_sush/X4_sush.button_pressed:
		s += '4'
	if $X5_sush/X5_sush.button_pressed:
		s += '5'
	if v != "":
		if task.fifth_task(v, s, int($input_1.get_text())):
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
	v = task.first_task(int($input_1.get_text()))
	$output_2.set_text(str(v))
	$TxtClosed.hide()
	$SprClosed.hide()
	
	$X1_sush.hide(); $X1_sush/X1_sush.hide(); $X1_sush.button_pressed = false; $X1_sush/X1_sush.button_pressed = false;
	$X2_sush.hide(); $X2_sush/X2_sush.hide(); $X2_sush.button_pressed = false; $X2_sush/X2_sush.button_pressed = false;
	$X3_sush.hide(); $X3_sush/X3_sush.hide(); $X3_sush.button_pressed = false; $X3_sush/X3_sush.button_pressed = false;
	$X4_sush.hide(); $X4_sush/X4_sush.hide(); $X4_sush.button_pressed = false; $X4_sush/X4_sush.button_pressed = false;
	$X5_sush.hide(); $X5_sush/X5_sush.hide(); $X5_sush.button_pressed = false; $X5_sush/X5_sush.button_pressed = false;

	if int($input_1.get_text()) > 4:
		$X5_sush.show(); $X5_sush/X5_sush.show()
	if int($input_1.get_text()) > 3:
		$X4_sush.show(); $X4_sush/X4_sush.show()
	if int($input_1.get_text()) > 2:
		$X3_sush.show(); $X3_sush/X3_sush.show()
	if int($input_1.get_text()) > 1:
		$X2_sush.show(); $X2_sush/X2_sush.show()
	
	$X1_sush.show(); $X1_sush/X1_sush.show()

func _on_button_2_pressed():
	$TxtClosed.show()
	$SprClosed.show()
	$X1_sush.hide(); $X1_sush/X1_sush.hide();
	$X2_sush.hide(); $X2_sush/X2_sush.hide(); 
	$X3_sush.hide(); $X3_sush/X3_sush.hide();
	$X4_sush.hide(); $X4_sush/X4_sush.hide();
	$X5_sush.hide(); $X5_sush/X5_sush.hide();
	$output_1.set_text("")
	$output_2.set_text("")
	$input_1.set_text("")
