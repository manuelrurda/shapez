extends Node2D

export (Array, int) var hint_shapes

func _ready():
	pass

func init(_hint_shapes:Array):
	hint_shapes = _hint_shapes
	for i in range(9):
		if hint_shapes[i] == 1:
			self.get_children()[i].hide()
		else:
			if hint_shapes[i]:
				self.get_children()[i].get_children()[0].texture = globals.get_shape_from_id(hint_shapes[i])
