extends Node

export(NodePath) var _Rhythm
onready var rytm = get_node(_Rhythm) as AudioStreamPlayer
export(NodePath) var _Drums
onready var drums = get_node(_Drums) as AudioStreamPlayer

var volume_normal : float = 0
var volume_mute : float = -80
var volume_menu : float = -4
var volme_paused : float = -10

func _ready():
	rytm.volume_db = volume_menu
	drums.volume_db = volume_mute

func unmute():
	var tw = get_node("Tween")
	tw.interpolate_property(rytm, "volume_db", volume_menu, volume_normal, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.interpolate_property(drums, "volume_db", volume_mute, volume_normal, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()

func mute():
	var tw = get_node("Tween")
	tw.interpolate_property(rytm, "volume_db", volume_normal, volume_menu, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.interpolate_property(drums, "volume_db", volume_normal, volume_mute, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()

func paused(pause):
	if pause:
		var tw = get_node("Tween")
		tw.interpolate_property(rytm, "volume_db", rytm.volume_db, volme_paused, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tw.interpolate_property(drums, "volume_db", drums.volume_db, volme_paused, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tw.start()
	else:
		var tw = get_node("Tween")
		tw.interpolate_property(rytm, "volume_db", rytm.volume_db, volume_normal, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tw.interpolate_property(drums, "volume_db", drums.volume_db, volume_normal, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tw.start()
