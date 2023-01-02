extends Node


onready var teams := ["Yellow", "Blue"]
onready var current_turn := "Yellow"
onready var game_status := "Running"
onready var grid := [
	["", "", ""],
	["", "", ""],
	["", "", ""],
]
