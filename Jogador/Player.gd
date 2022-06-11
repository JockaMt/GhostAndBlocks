extends KinematicBody2D

export(PackedScene) var _popLabel
onready var label = _popLabel

export(NodePath) var _damage
onready var dmg = get_node(_damage) as AudioStreamPlayer

export(NodePath) var _pick
onready var pick = get_node(_pick) as AudioStreamPlayer

export(NodePath) var _life
onready var life = get_node(_life) as AudioStreamPlayer

export(NodePath) var _sprite
onready var spr = get_node(_sprite) as Sprite

export(NodePath) var _sprite_cesta
onready var spr2 = get_node(_sprite_cesta) as Sprite

export(NodePath) var _particulas
onready var part = get_node(_particulas) as CPUParticles2D

var motion = Vector2.ZERO
var speed = 560
const GRAVIDADE = 180
var _right = 0
var _left = 0
var moves = 0

var pontos = 0

func _ready():
	spr.texture = load(Global.skins[Global.skinSelected].skinTexture)
	part.texture = load(Global.skins[Global.skinSelected].skinTexture)
	spr2.texture = load(Global.skins[Global.skinSelected].cesto)

func _physics_process(_delta):
	if get_parent().playing:
		moves = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
		motion.x = clamp(((_right - _left) + moves), -1, 1) * speed
	else:
		motion.x = 0
	if !is_on_floor():
		motion.y += GRAVIDADE
	var velocity = motion
	velocity = move_and_slide(velocity, Vector2.UP)

func _take_damage(amount):
	dmg.play()
	var u = label.instance()
	u.global_position = global_position + Vector2(0, -80)
	u.num = amount
	u.modulate = Color.red
	get_parent().call_deferred("add_child", u)
	if get_parent().vidas > 1:
		get_parent().vidas -= amount
	else:
		get_parent().vidas -= amount
		get_parent().gameover()
	var tw = get_node("Tween")
	tw.interpolate_property(spr, "scale", Vector2(5, 3.5), Vector2(4, 4), 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tw.interpolate_property(spr, "modulate", Color(1, 0, 0), Color(1, 1, 1), 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tw.start()
	
func _take_heal(amount):
	life.play()
	var u = label.instance()
	u.global_position = global_position + Vector2(0, -80)
	u.num = amount
	u.modulate = Color.green
	get_parent().call_deferred("add_child", u)
	get_parent().vidas += amount

func _pickedd():
	pick.play()
	var tw = get_node("Tween")
	tw.interpolate_property(spr2, "scale", Vector2(5.75, 3), Vector2(4.75, 4.75), 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tw.start()

func right(_a_):
	_right = _a_
	
func left(_b_):
	_left = _b_
