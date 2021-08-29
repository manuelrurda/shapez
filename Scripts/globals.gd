extends Node2D

# switch for mobile build
var window_width = OS.get_screen_size().x
var window_height = OS.get_screen_size().y

var circle = preload("res://Sprites/PH_Circle.png")
var square = preload("res://Sprites/PH_Square.png")
var triangle = preload("res://Sprites/PH_Triangle.png")

var red = preload("res://Sprites/PH_Red.png")
var green = preload("res://Sprites/PH_Green.png")
var blue = preload("res://Sprites/PH_Blue.png")

var r_square = preload("res://Sprites/PH_RedSq.png")
var r_circle = preload("res://Sprites/PH_RedCir.png")
var r_triangle = preload("res://Sprites/PH_RedTri.png")

var g_square = preload("res://Sprites/PH_GreenSq.png")
var g_circle = preload("res://Sprites/PH_GreenCir.png")
var g_triangle = preload("res://Sprites/PH_GreenTri.png")

var b_square = preload("res://Sprites/PH_BlueSq.png")
var b_circle = preload("res://Sprites/PH_BlueCir.png")
var b_triangle = preload("res://Sprites/PH_BlueTri.png")

var shapes = {
	square : 2,
	triangle : 3,
	circle : 4,
	
	red : 5,
	green : 6,
	blue : 7,
	
	r_square : 10,
	r_triangle : 15,
	r_circle : 20,
	
	g_square : 12,
	g_triangle : 18,
	g_circle : 24,
	
	b_square : 14,
	b_triangle : 21, 
	b_circle : 28,
}

# get JSON data

var levels
func _ready():
	var levels_file = File.new()
	levels_file.open("res://Data/levels.json", File.READ)
	var levels_json = JSON.parse(levels_file.get_as_text())
	levels_file.close()
	levels = levels_json.result

func get_shape_from_id(id):
	for key in shapes.keys():
		if shapes[key] == id:
			return key
	return -1

