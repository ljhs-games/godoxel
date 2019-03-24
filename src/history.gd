extends Node

#warning-ignore:unused_class_variable
var undo_redo: UndoRedo = UndoRedo.new() setget ,get_undo_redo

func get_undo_redo() -> UndoRedo:
	return undo_redo

func _input(event):
	if event.is_action_pressed("redo"):
#warning-ignore:return_value_discarded
		undo_redo.redo()
	elif event.is_action_pressed("undo"):
#warning-ignore:return_value_discarded
		undo_redo.undo()