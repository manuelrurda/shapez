extends Node2D

signal level_btn_pressed

var level_scene = preload("res://Scenes/level.tscn")
var hint_scene = preload("res://Scenes/hint.tscn")
var how_to_play_scene = preload("res://Scenes/how_to_play.tscn")

func _ready():
	get_node("level_buttons").global_position = Vector2(globals.window_width, 100)
	get_node("main_menu/title").set_global_position(Vector2(globals.window_width/2 - get_node("main_menu/title").rect_size.x/2, 300))
	get_node("main_menu/play_btn").set_global_position(Vector2(globals.window_width/2 - get_node("main_menu/play_btn").rect_size.x/2, globals.window_height/2 + 300))	
	get_node("main_menu/how_to_btn").set_global_position(Vector2(globals.window_width/2 - get_node("main_menu/how_to_btn").rect_size.x/2, 
															get_node("main_menu/play_btn").get_global_position().y + 200))	
	get_node("main_menu/main_menu_animation").set_global_position(Vector2(globals.window_width/2,
																	   globals.window_height/2 - 100))
	for btn in get_tree().get_nodes_in_group("level_btns"):
		btn.connect("level_btn_pressed", self, "level_btn_pressed")


func level_btn_pressed(level_btn):
	
	var new_level = generate_level(level_btn)
	self.hide()
	
	generate_hints(level_btn, new_level)
	

func generate_level(level_btn):
	var level = level_scene.instance()
	level.solution = globals.levels[level_btn.level_num - 1]["solution"]
	level.global_position = Vector2(globals.window_width/2, globals.window_height/2 + OS.get_screen_size().y * .06)
	get_tree().get_root().add_child(level)
	return level


func generate_hints(level_btn, level):
	var num_of_hints = len(globals.levels[level_btn.level_num - 1]["hints"])
	var num_of_rows = ceil(num_of_hints/3.0)
	var hints_remaining = num_of_hints
	var hint_size = 776
	var scale_size = 0.37-(0.04*num_of_rows)
	var new_size = hint_size*scale_size
	for i in range(num_of_rows):
		var num_of_cols = hints_remaining - 3*(3-(i+4-num_of_rows))
		for j in range(num_of_cols):
			var hint = hint_scene.instance()
			hint.init(globals.levels[level_btn.level_num - 1]["hints"][num_of_hints-hints_remaining])
			hint.scale = Vector2(scale_size, scale_size)
			hint.global_position = Vector2(globals.window_width * (j+1)/(num_of_cols + 1) - new_size/2, 
				globals.window_height * (i+1)/(num_of_rows + 4 + (1 * num_of_rows)) - new_size/2 + OS.get_screen_size().y * .1)
			
			# Offset
			hint.global_position += Vector2(-globals.window_width/2, -(globals.window_height/2 + new_size))
			level.add_child(hint)
			hints_remaining -= 1



func _on_play_btn_pressed():
	get_node("level_buttons").move(Vector2(0, 0))
	get_node("main_menu").move(Vector2(-globals.window_width, 0))
	get_node("main_menu/main_menu_animation").get_node("square").rotating = false
	get_node("main_menu/main_menu_animation").get_node("triangle").rotating = false


func _on_back_button_pressed():
	get_node("level_buttons").move(Vector2(globals.window_width, 0))
	get_node("main_menu").move(Vector2(0, 0))
	get_node("main_menu/main_menu_animation").get_node("square").rotating = true
	get_node("main_menu/main_menu_animation").get_node("triangle").rotating = true
	get_node("main_menu/main_menu_animation").get_node("square").rotate_animation()
	get_node("main_menu/main_menu_animation").get_node("triangle").rotate_animation()


func _on_how_to_btn_pressed():
	var hwtoplay = how_to_play_scene.instance()
	hwtoplay.global_position += Vector2(0, 100)
	self.add_child(hwtoplay)
