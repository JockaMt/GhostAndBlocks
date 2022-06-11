extends Node

var nickname = ""
var highscore = 0
var music_muted = false
var sfx_muted = false
var skinSelected = 0
var skins = {
	0 : {
		"name" : "Ghost",
		"skin" : "res://Sprites/player.png",
		"price" : 0,
		"skinTexture" : "res://Sprites/player.png",
		"cesto" : "res://Sprites/cesto.png"
	},
	1 : {
		"name" : "Batman",
		"skin" : "res://Jogador/skins/Batman/BatmanSkinIcon.png",
		"price" : 50,
		"skinTexture" : "res://Jogador/skins/Batman/BatmanSkin.png",
		"cesto" : "res://Sprites/cesto.png"
	},
	2 : {
		"name" : "Mew",
		"skin" : "res://Jogador/skins/Mew/MewSkinIcon.png",
		"price" : 80,
		"skinTexture" : "res://Jogador/skins/Mew/MewSkin.png",
		"cesto" : "res://Sprites/cesto.png"
	},
	3 : {
		"name" : "Panda",
		"skin" : "res://Jogador/skins/Panda/PandaSkinIcon.png",
		"price" : 140,
		"skinTexture" : "res://Jogador/skins/Panda/PandaSkin.png",
		"cesto" : "res://Jogador/skins/Panda/cestoBamboo.png"
	},
	4 : {
		"name" : "Frogit",
		"skin" : "res://Jogador/skins/Frogit/FrogitSkinIcon.png",
		"price" : 230,
		"skinTexture" : "res://Jogador/skins/Frogit/FrogitSkin.png",
		"cesto" : "res://Sprites/cesto.png"
	}
}

func save():
	var save_dict = {
		"high_score" : highscore
	}
	return save_dict

func save_game():
	var _save_game = File.new()
	if _save_game.open("user://save.save", File.WRITE) == OK:
		_save_game.store_var(save()["high_score"])
		_save_game.close()

func load_game():
	var load_game = File.new()
	if load_game.open("user://save.save", File.READ) == OK:
		highscore = load_game.get_var(save()["high_score"])
		load_game.close()

func _ready():
	load_game()

func mute_music(mute):
	music_muted = mute
	AudioServer.set_bus_mute(1, mute)

func mute_sxf(mute):
	sfx_muted = mute
	AudioServer.set_bus_mute(2, mute)
