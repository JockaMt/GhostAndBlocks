extends VBoxContainer

var id = 0
var imagem = null
var item_name = null
var item_price = null

export(NodePath) var _imagem
onready var img = get_node(_imagem) as TextureRect

export(NodePath) var _target
onready var imgtgt = get_node(_target) as TextureRect

export(NodePath) var _name
onready var item = get_node(_name) as Label

export(NodePath) var _price
onready var price = get_node(_price) as Label

func _ready():
	img.texture = load(imagem)
	item.text = item_name
	price.text = str(item_price)

func _process(_delta):
	imgtgt.visible = (Global.skinSelected == self.id)

func _on_Button_pressed():
	if Global.highscore >= item_price:
		Global.skinSelected = self.id
	
