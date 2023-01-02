extends Node2D


# Constants
const BACKGROUND_COLORS := {
	"Yellow" : Color(0.968627, 0.972549, 0.388235),
	"Blue" : Color(0.514893, 0.644051, 0.890625),
}


func _ready() -> void:
	init_game()


func init_game() -> void:
	randomize()
	GameState.game_status = "Running"
	GameState.current_turn = GameState.teams[randi() % len(GameState.teams)]

	for i in range(3):
		GameState.grid[i] = ["", "", ""]

	set_background_color()


func set_background_color() -> void:
	$Background.self_modulate = BACKGROUND_COLORS[GameState.current_turn]


func on_tile_added() -> void:
	var game_result = evaluate_game()

	if game_result:
		GameState.game_status = "Ended"
		var dialog: AcceptDialog = $Hud/AcceptDialog
		dialog.dialog_text = "Player " + GameState.current_turn + " won!"
		dialog.popup_centered()
		return

	if GameState.current_turn == "Yellow":
		GameState.current_turn = "Blue"

	else:
		GameState.current_turn = "Yellow"

	set_background_color()


func evaluate_game() -> String:

	# Evaluate lines
	for i in len(GameState.grid):
		if GameState.grid[i][0] \
		and GameState.grid[i][0] == GameState.grid[i][1] \
		and GameState.grid[i][1] == GameState.grid[i][2]:
			print_debug("Win at row ", i)
			return "Line " + str(i)

	# Evaluate columns
	for i in range(3):
		if GameState.grid[0][i] \
		and GameState.grid[0][i] == GameState.grid[1][i] \
		and GameState.grid[0][i] == GameState.grid[2][i]:
			print_debug("Win at column ", i)
			return "Column " + str(i)

	# Evaluate main diagonal
	if GameState.grid[0][0] \
	and GameState.grid[0][0] == GameState.grid[1][1] \
	and GameState.grid[0][0] == GameState.grid[2][2]:
		print_debug("Win at main diagonal!")
		return "Main diagonal"

	# Evaluate inverted diagonal
	if GameState.grid[0][2] \
	and GameState.grid[0][2] == GameState.grid[1][1] and GameState.grid[0][2] == GameState.grid[2][0]:
		print_debug("Win at inverted diagonal!")
		return "Inverted diagonal"

	return ""


func restart_game() -> void:
	get_tree().reload_current_scene()


func _on_AcceptDialog_confirmed() -> void:
	restart_game()
