extends Node2D


# Resources
var sprite_front_yellow = preload("res://textures/TileYellow.png")
var sprite_front_blue = preload("res://textures/TileBlue.png")
var sprite_back_yellow = preload("res://textures/BackTileYellow.png")
var sprite_back_blue = preload("res://textures/BackTileBlue.png")

# Export variables
export var grid_row := 0
export var grid_column := 0

# Member variables
onready var team := ""

# Constants
const MOUSE_HOVER_ALPHA = 0.5


func _on_Area2D_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:

	if event.is_action_pressed("mouse_left") and not team and GameState.game_status == "Running":
		GameState.grid[grid_row][grid_column] = GameState.current_turn
		team = GameState.current_turn
		set_sprites(GameState.current_turn)
		get_tree().call_group("Game", "on_tile_added")


func set_sprites(target: String) -> void:

	if target == "Yellow":
		$SpriteBack.texture = sprite_back_yellow
		$SpriteFront.texture = sprite_front_yellow

	elif target == "Blue":
		$SpriteBack.texture = sprite_back_blue
		$SpriteFront.texture = sprite_front_blue


func _on_Area2D_mouse_entered() -> void:
	$SpriteBack.modulate.a = MOUSE_HOVER_ALPHA


func _on_Area2D_mouse_exited() -> void:
	$SpriteBack.modulate.a = 1.0

