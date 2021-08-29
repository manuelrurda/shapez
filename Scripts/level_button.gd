extends TextureButton

signal level_btn_pressed

export var level_num:int

func _ready():
	get_node("level_num").text = String(level_num)


func _on_level_button_pressed():
	emit_signal("level_btn_pressed", self)
