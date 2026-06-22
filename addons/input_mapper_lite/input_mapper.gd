extends Node

const MAX_ACTIONS: int = 8

signal binding_changed(action: String)

var _defaults: Dictionary = {}

func register(action: String) -> bool:
	if _defaults.size() >= MAX_ACTIONS and not _defaults.has(action):
		push_warning("InputMapper Lite: max %d actions. Upgrade to PRO." % MAX_ACTIONS)
		return false
	if not InputMap.has_action(action):
		push_warning("InputMapper: action '%s' not in InputMap." % action)
		return false
	if not _defaults.has(action):
		_defaults[action] = _snapshot_events(action)
	return true

func rebind_key(action: String, new_key: Key) -> bool:
	if not InputMap.has_action(action):
		return false
	_clear_keyboard_events(action)
	var ev := InputEventKey.new()
	ev.keycode = new_key
	InputMap.action_add_event(action, ev)
	emit_signal("binding_changed", action)
	return true

func reset(action: String) -> void:
	if not _defaults.has(action):
		return
	InputMap.action_erase_events(action)
	for ev in _defaults[action]:
		InputMap.action_add_event(action, ev)
	emit_signal("binding_changed", action)

func reset_all() -> void:
	for action in _defaults.keys():
		reset(action)

func get_key(action: String) -> Key:
	if not InputMap.has_action(action):
		return KEY_NONE
	for ev in InputMap.action_get_events(action):
		if ev is InputEventKey:
			return ev.keycode
	return KEY_NONE

func get_display_name(action: String) -> String:
	var k := get_key(action)
	if k == KEY_NONE:
		return "—"
	return OS.get_keycode_string(k)

func is_registered(action: String) -> bool:
	return _defaults.has(action)

func registered_actions() -> Array:
	return _defaults.keys()

func save_state() -> Dictionary:
	var data: Dictionary = {}
	for action in _defaults.keys():
		data[action] = {"key": get_key(action)}
	return data

func load_state(data: Dictionary) -> void:
	for action in data.keys():
		if data[action].has("key") and InputMap.has_action(action):
			rebind_key(action, data[action]["key"])

func _snapshot_events(action: String) -> Array:
	var result: Array = []
	for ev in InputMap.action_get_events(action):
		result.append(ev.duplicate())
	return result

func _clear_keyboard_events(action: String) -> void:
	var to_remove: Array = []
	for ev in InputMap.action_get_events(action):
		if ev is InputEventKey:
			to_remove.append(ev)
	for ev in to_remove:
		InputMap.action_erase_event(action, ev)
