@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_autoload_singleton("InputMapper", "res://addons/input_mapper_lite/input_mapper.gd")

func _exit_tree() -> void:
	remove_autoload_singleton("InputMapper")
