extends Control

@onready var money_label = $VBoxContainer/MoneyLabel
@onready var click_button := $VBoxContainer/ClickButton
@onready var buy_button := $VBoxContainer/BuyButton

@onready var dinosaur = $Dinosaur

var dinosaur_list := [
	preload("res://Scenes/green_dinosaur.tscn"),
	preload("res://Scenes/red_dinosaur.tscn"),
	preload("res://Scenes/blue_dinosaur.tscn"),
	preload("res://Scenes/yellow_dinosaur.tscn"),
]

var current_currency: int = 0

func _ready() -> void:
	click_button.pressed.connect(give_money)
	buy_button.pressed.connect(buy_dinosaur)

func _process(delta) -> void:
	if current_currency >= 10:
		buy_button.disabled = false
		buy_button.modulate.a = 1.0
	else:
		buy_button.disabled = true
		buy_button.modulate.a = 0.0
		
func show_currency() -> void:
	money_label.text = "[center]$" + str(current_currency) + "[/center]"
	
func give_money() -> void:
	current_currency += 1
	show_currency()
	
func buy_dinosaur() -> void:
	current_currency -= 10
	show_currency()
	
	var viewport_size := get_viewport_rect().size
	var dinosaur_instantiate = dinosaur_list.pick_random().instantiate()
	dinosaur_instantiate.position.y = randf_range(100.0, viewport_size.y - 100)
	dinosaur_instantiate.position.x = randf_range(0.0, viewport_size.x)
	dinosaur.add_child(dinosaur_instantiate)

#func _on_timer_timeout():
	#var number_of_dinosaurs := dinosaur.get_child_count()
	#if number_of_dinosaurs > 0:
		#current_currency += 1 * number_of_dinosaurs
		#show_currency()
