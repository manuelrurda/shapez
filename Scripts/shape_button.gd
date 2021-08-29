extends Node2D


export var shape_id:int
export var shape_type:String
export var shape_instance_limit:int

onready var SHAPE = preload("res://Scenes/shape.tscn")

	
func _on_Button_button_down():
	
	if self.get_parent().instance_limits[shape_id]:
		var shape = SHAPE.instance()
		shape.init(self.get_node("Sprite").texture, self.position, self.shape_id, self.shape_type)
		get_parent().add_child(shape)
		self.get_parent().instance_limits[shape_id] -= 1
		
	#for shape in get_tree().get_nodes_in_group("shapes"):
		shape.connect("shape_deleted", self, "shape_deleted")
