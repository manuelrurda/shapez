extends Sprite

# when a shape enteres the grid
func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("shapes"):
		area.get_parent().in_grid = true

# when a shape leaves the grid
func _on_Area2D_area_exited(area):
	if area.get_parent().is_in_group("shapes"):
		area.get_parent().in_grid = false
