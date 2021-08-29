extends Node2D

func _ready():
	get_node("back_button").rect_position = Vector2(64, 100)
	
func move(target:Vector2):
	var moveTween:Tween = get_node("move_tween")
	moveTween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	moveTween.start()
