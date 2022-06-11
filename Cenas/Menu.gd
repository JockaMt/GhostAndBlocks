extends Node2D

export(NodePath) var _devScreen
onready var devSc = get_node(_devScreen) as Control

export(NodePath) var _devPop
onready var devPop = get_node(_devPop) as Control

export(NodePath) var _highscore
onready var hs = get_node(_highscore) as Label

export(NodePath) var _highscoreScreen
onready var hsScreen = get_node(_highscoreScreen) as Control

export(NodePath) var _insertNick
onready var insert = get_node(_insertNick) as Control

export(NodePath) var _confirmQuit
onready var quit = get_node(_confirmQuit) as Control

export(NodePath) var _confirmZerar
onready var zerar = get_node(_confirmZerar) as Control

export(NodePath) var _loja
onready var loja = get_node(_loja) as HBoxContainer

export(PackedScene) var _shop_item
onready var item = _shop_item

export(NodePath) var _menu
onready var menu = get_node(_menu) as Control

export(NodePath) var _extra
onready var extra = get_node(_extra) as Control

export(NodePath) var _hint
onready var hint = get_node(_hint)

export(NodePath) var _insertNickPop
onready var insertPop = get_node(_insertNickPop) as Panel
onready var popup = get_node("CanvasLayer/Quit/TextureRect")
onready var popup2 = get_node("CanvasLayer/zerar/TextureRect")

var senha = ""

func _ready():
	SilentWolf.configure({
		"api_key" : "9BzfvvUHA57c47XCOJyVKaRbK6r9HLEx4yR4vMXp",
		"game_id" : "GhostAndBlocksRelease",
		"game_version" : "1.1.0",
		"log_level" : 0
	})
	for i in Global.skins:
		var a = item.instance()
		a.imagem = Global.skins[i].skin
		a.item_name = Global.skins[i].name
		a.item_price = Global.skins[i].price
		a.id = i
		loja.add_child(a)
	hs.text = str(Global.highscore)

func _on_TextureButton_pressed():
	Musics.unmute()
	var _game = get_tree().change_scene("res://Cenas/Main.tscn")

func _on_TextureButton2_pressed():
	popthing(popup)
	quit.show()

func _on_TextureButton3_pressed():
	popthing(popup2)
	zerar.show()

func _on_YES_pressed():
		get_tree().quit()

func _on_NO_pressed():
	quit.hide()

func popthing(thing):
	var tw = get_node("Tween")
	tw.interpolate_property(thing, "rect_scale", Vector2(0.6, 0.3), Vector2(1,1), 0.3,Tween.TRANS_BACK, Tween.EASE_OUT)
	tw.start()

func _on_NO2_pressed():
	zerar.hide()

func _on_YES2_pressed():
	zerar.hide()
	hs.text = str(Global.highscore)
	Global.highscore = 0
	Global.save_game()

func _button_Extra():
	hint.hide()
	var tw = get_node("Tween")
	tw.interpolate_property(menu, "rect_position", menu.rect_position, Vector2(-720, 0), 0.4,Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tw.interpolate_property(extra, "rect_position", extra.rect_position, Vector2(0, 0), 0.4,Tween.TRANS_BACK, Tween.EASE_IN_OUT, 0.1)
	tw.start()

func _on_Button_pressed():
	voltar(extra, menu, 720)
	
func voltar(_atual, _menuPanel, _final_position):
	var tw = get_node("Tween")
	tw.interpolate_property(_atual, "rect_position", _atual.rect_position, Vector2(_final_position, 0), 0.4,Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tw.interpolate_property(_menuPanel, "rect_position", _menuPanel.rect_position, Vector2(0, 0), 0.4,Tween.TRANS_BACK, Tween.EASE_IN_OUT, 0.1)
	tw.start()

func _on_highscore_pressed():
	hint.hide()
	var tw = get_node("Tween")
	tw.interpolate_property(menu, "rect_position", menu.rect_position, Vector2(720, 0), 0.5,Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tw.interpolate_property(hsScreen, "rect_position", hsScreen.rect_position, Vector2(0, 0), 0.5,Tween.TRANS_BACK, Tween.EASE_IN_OUT, 0.1)
	tw.start()


func _on_nickBack_pressed():
	insert.hide()


func _on_nickEnviar_pressed():
	if Global.nickname != "":
		SilentWolf.Scores.persist_score(Global.nickname, Global.highscore)
		hsScreen.clear_leaderboard()
		hsScreen.list_index = 0
		insert.hide()
		yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
		hsScreen._ready()
		hsScreen.hide_message()


func _on_LineEdit_text_changed(new_text):
	Global.nickname = str(new_text)


func _on_hsEnviar_pressed():
	popthing(insertPop)
	insert.show()


func _on_hsVoltar_pressed():
	voltar(hsScreen, menu, -720)


func _on_LineEdit_focus_entered():
	var tw = get_node("Tween")
	tw.interpolate_property(insertPop, "rect_position", Vector2(8.5, 486), Vector2(8.5, 186), 0.4,Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tw.start()


func _on_LineEdit_focus_exited():
	var tw = get_node("Tween")
	tw.interpolate_property(insertPop, "rect_position", Vector2(8.5, 186), Vector2(8.5, 486), 0.4,Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tw.start()

# dev area ---
func _on_LineEditdev_text_changed(new_text):
	senha = str(new_text)


func _on_LineEditdev_focus_entered():
	var tw = get_node("Tween")
	tw.interpolate_property(devPop, "rect_position", Vector2(8.5, 486), Vector2(8.5, 186), 0.4,Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tw.start()


func _on_LineEditdev_focus_exited():
	var tw = get_node("Tween")
	tw.interpolate_property(devPop, "rect_position", Vector2(8.5, 186), Vector2(8.5, 486), 0.4,Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tw.start()


func _on_devBack_pressed():
	devSc.hide()

func _show_mensage(confirm):
	if confirm:
		$CanvasLayer/Extra/DevMensage.text = "Wipe Leaderboard!"
		$CanvasLayer/Extra/DevMensage.modulate = Color.green
	else:
		$CanvasLayer/Extra/DevMensage.text = "Access Denied!"
		$CanvasLayer/Extra/DevMensage.modulate = Color.red
	$CanvasLayer/Extra/DevMensage.visible = true
	var tw = get_node("Tween")
	tw.interpolate_property($CanvasLayer/Extra/DevMensage, "modulate", Color($CanvasLayer/Extra/DevMensage.modulate), Color.transparent, 2,Tween.TRANS_LINEAR, Tween.EASE_IN)
	tw.start()
#	yield(tw, "tween_all_completed")
#	$CanvasLayer/Extra/DevMensage.visible = false
	
func _on_devEnviar_pressed():
	if senha == "Mateus&Ticiane0711":
		SilentWolf.Scores.wipe_leaderboard()
		hsScreen.clear_leaderboard()
		devSc.hide()
		_show_mensage(true)
	else:
		_show_mensage(false)
		devSc.hide()

func _on_WipeLeaderboard_pressed():
	popthing(devPop)
	devSc.show()
