extends Node2D

export var direction:int
export var texture = preload("res://Sprites/PH_BlueSq.png")
onready var TweenNode = get_node("Tween")
var rotating = true

func _ready():
	self.get_node("Sprite").texture = texture
	print(get("rotation_degrees"))
	rotate_animation()

func rotate_animation():
	while(rotating):
		var t = Timer.new()
		t.set_wait_time(2.5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		TweenNode.stop_all()
		TweenNode.interpolate_property(self, "rotation_degrees", rotation_degrees, (rotation_degrees+360)*direction, 1.0, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
		TweenNode.start()
