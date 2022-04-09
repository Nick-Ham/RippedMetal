extends Node2D

onready var sprite = $AnimatedSprite
onready var particles = $Particles2D
onready var timer = $Timer


func _ready():
	sprite.frame = 0
	sprite.play("default")
	particles.emitting = true
	timer.start()


func _on_Timer_timeout():
	queue_free()

func _on_AnimatedSprite_animation_finished():
	sprite.visible = false
