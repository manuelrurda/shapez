extends Node2D

signal shape_deleted

var has_combined = false

var dragged = true
var in_grid = false

var curr_drop_zone
var drop_zones = []

var shape_id:int
var shape_type:String

var SHAPE_SCENE = load("res://Scenes/shape.tscn")

func _ready():
	self.drop_zones = get_tree().get_nodes_in_group("drop_zones")


func _on_Area2D_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		if self.curr_drop_zone:
			self.curr_drop_zone.shape_held = null
		self.dragged = true


func _input(event):

		var local_event = make_input_local(event)
		if local_event is InputEventMouseButton and not local_event.pressed:
			
			set_curr_drop_zone()
			
			if !in_grid or !curr_drop_zone:
				destroy_shape(self)
				return
		
			if !self.has_combined:
				self.curr_drop_zone.shape_held = self
			
			# when this is set, the shape will move
			self.dragged = false

			#print("-------DROPPED-------")
			#for drop_zone in drop_zones:
				#print(drop_zone.shape_held)


#if a shape is beign held, set its position to the mouse position
func _physics_process(delta):
	if self.dragged:
		global_position = lerp(global_position, get_global_mouse_position() + Vector2(0,-130), 35 * delta)
	else:
		if self.curr_drop_zone:
			global_position = lerp(global_position, curr_drop_zone.global_position, 40 * delta)
		else:
			#handes if a shape is created and never placed in grid
			destroy_shape(self)


func set_curr_drop_zone():
	var shortest_dist = 90
	for drop_zone in drop_zones:
		var distance = global_position.distance_to(drop_zone.global_position)
		if distance < shortest_dist:
			if drop_zone.shape_held:
				if is_combinable(drop_zone):
					var new_shape = combine(drop_zone.shape_held)
					destroy_shape(drop_zone.shape_held)
					destroy_shape(self)
					get_parent().add_child(new_shape)
					new_shape.curr_drop_zone = drop_zone
					drop_zone.shape_held = new_shape
					print("combined")
					return
				else:
					return
			else:
				self.curr_drop_zone = drop_zone
				shortest_dist = distance
				return


func combine(shape):
	self.has_combined = true
	var new_id = shape.shape_id * self.shape_id 
	var new_shape = SHAPE_SCENE.instance()
	new_shape.init(globals.get_shape_from_id(new_id), Vector2(100,100), new_id, "shape")
	new_shape.dragged = false
	return new_shape


func destroy_shape(shape):
	print(shape_type)
	if shape.curr_drop_zone:
		shape.curr_drop_zone.shape_held = null
	if shape.shape_id in shape.get_parent().instance_limits:
		shape.get_parent().instance_limits[shape.shape_id] += 1
	shape.queue_free()


func is_combinable(drop_zone):
	if (self.shape_type == "color" and drop_zone.shape_held.shape_type == "outline"
		or self.shape_type == "outline" and drop_zone.shape_held.shape_type == "color"):
			return true
	return false


func init(_texture, _position, _shape_id, _shape_type):
	self.get_node("Sprite").texture = _texture
	self.global_position = _position
	self.shape_id = _shape_id
	self.shape_type = _shape_type
