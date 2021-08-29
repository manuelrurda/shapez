extends Node2D


var solution:Array

export var instance_limits = {
	2: 3,
	3: 3,
	4: 3,
	5: 3,
	6: 3,
	7: 3
}

# Set buttons textures
func _ready():
	get_node("circle/Sprite").texture = globals.circle
	get_node("square/Sprite").texture = globals.square
	get_node("triangle/Sprite").texture = globals.triangle
	
	get_node("red/Sprite").texture = globals.red
	get_node("blue/Sprite").texture = globals.blue
	get_node("green/Sprite").texture = globals.green
	
	get_node("reset_button").rect_global_position = Vector2(globals.window_width - 128, 100)
	get_node("back_button").rect_global_position = Vector2(64, 100)


func check_solution():
	print(solution)
	for i in range(9):
		if get_tree().get_nodes_in_group("drop_zones")[i].shape_held != null:
			if solution[i] != get_tree().get_nodes_in_group("drop_zones")[i].shape_held.shape_id:
				return false
		else:
			return false
	return true
	
func init(_solution:Array):
	solution = _solution


func _on_reset_button_pressed():
	for drop_zone in get_node("grid").get_tree().get_nodes_in_group("drop_zones"):
		if drop_zone.shape_held:
			drop_zone.shape_held.destroy_shape(drop_zone.shape_held)
		


func _on_back_button_pressed():
	get_tree().get_root().get_node("level_selection").show()
	self.queue_free()
	
func color_filter(color):
	var color_rect = ColorRect.new()
	color_rect.set_size(Vector2(globals.window_width + 100, globals.window_height + 200))
	color_rect.set_global_position(Vector2(0, - 200) - color_rect.get_size()/2)
	self.add_child(color_rect)
	get_node("colortween").interpolate_property(color_rect, "color", color, Color(0.0, 0.0, 0.0, 0.0), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	get_node("colortween").start()
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	color_rect.queue_free()


func _on_TextureButton_pressed():
	print("----------------------")
	if check_solution():
		print("CORRECT!")
		color_filter(Color(0.0, 1, 0.0, 0.7))
		get_node("Label").text = "CORRECT"
	else:
		print("WRONG!")
		get_node("Label").text = "WRONG"
		color_filter(Color(1, 0.0, 0.0, 0.7))
