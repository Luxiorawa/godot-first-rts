class_name Unit
extends CharacterBody2D

@export var isSelected := false
@onready var selected: Panel = $Selected
@onready var animation: AnimationPlayer = $AnimationPlayer

@onready var target := position
var follow_cursor := false
var speed := 50

func _ready() -> void:
	set_selected(isSelected)
	add_to_group("units", true)
	
func set_selected(value: bool) -> void:
	selected.visible = value
	isSelected = value

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	
	if event.is_action_released("RightClick"):
		follow_cursor = false

func _physics_process(_delta: float) -> void:
	if follow_cursor == true:
		if isSelected:
			target = get_global_mouse_position()
			animation.play("Walk Down")
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()
	else:
		animation.stop()
