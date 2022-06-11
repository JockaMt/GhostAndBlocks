extends Area2D

export(NodePath) var _particles
onready var part = get_node(_particles)
export(NodePath) var _particles_2
onready var part2 = get_node(_particles_2)
export(NodePath) var _sprite
onready var spr = get_node(_sprite)

var point = false
var enemy = false
var life = false
var damage = 0
var lifeAmount = 0
var can_move = true
var speed = 500

#signal _picked

func _physics_process(delta):
	if can_move:
		move(delta)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Floor"):
		spr.visible = false
		part.emitting = true
		part2.emitting = false
		if point:
			if get_parent().playing:
				spr.visible = false
				part.emitting = true
				part2.emitting = false
				get_parent().get_node("Player")._take_damage(1)
				get_node("CollisionShape2D").queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		if point:
			if get_parent().playing:
				area.get_parent()._pickedd()
				get_parent().changePoints(1)
				spr.visible = false
				part.emitting = true
				part2.emitting = false
				get_node("CollisionShape2D").queue_free()
		elif enemy:
			if get_parent().playing:
				spr.visible = false
				part.emitting = true
				part2.emitting = false
				area.get_parent()._take_damage(damage)
				get_node("CollisionShape2D").queue_free()
		elif life:
			if get_parent().playing:
				spr.visible = false
				part.emitting = true
				part2.emitting = false
				area.get_parent()._take_heal(lifeAmount)
				get_node("CollisionShape2D").queue_free()
		
func move(_delta):
	position.y += speed * _delta
