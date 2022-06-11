extends Node2D

var num = 0

func _ready():
	$Label.text = str(num)
	var tween = get_node("Tween")
	tween.interpolate_property(self, "scale",
		Vector2(0.5, 0.5), Vector2(0.7, 0.7), 0.2,
		Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()
	yield(tween,"tween_completed")
	tween.interpolate_property(self, "position",
		Vector2(self.position.x, self.position.y) , Vector2(self.position.x, self.position.y - 90), 0.5,
		Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.interpolate_property(self, "modulate",
		self.modulate.a, self.modulate.a - 1, 1,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	queue_free()
