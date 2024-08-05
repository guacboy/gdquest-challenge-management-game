extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var timer = $Timer

func _ready() -> void:
	animated_sprite_2d.play("idle")
	
	timer.wait_time = randf_range(2.0, 5.0)
	timer.start()

func _on_timer_timeout():
	animated_sprite_2d.play("walk")
	
	var random_direction_x := randf_range(-50.0, 50.0)
	var random_direction_y := randf_range(-50.0, 50.0)
	
	if random_direction_x < 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
		
	var tween := create_tween()
	tween.tween_property(animated_sprite_2d, "position", Vector2(random_direction_x, random_direction_y), 1.0)
		
	tween.finished.connect(
		func() -> void:
			animated_sprite_2d.play("idle")
	)
