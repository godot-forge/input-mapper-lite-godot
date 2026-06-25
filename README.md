# Input Mapper Lite — Godot 4

Free runtime key rebinding for Godot 4 via autoload. Let players remap controls in-game. Lite supports up to 8 actions.

## Features (Lite — Free)

- `register(action)` — track an existing input action
- `rebind_key(action, new_key)` — remap at runtime
- `reset(action)` / `reset_all()`
- `get_key(action)` / `get_display_name(action)`
- `is_registered(action)` / `registered_actions()`
- `save_state()` / `load_state(data)`
- Signal: `binding_changed(action)` · up to 8 actions

## Quick Start

```gdscript
# Add addons/input_mapper_lite/input_mapper.gd as autoload named "InputMapper"
InputMapper.register("jump")
InputMapper.rebind_key("jump", KEY_SPACE)
print(InputMapper.get_display_name("jump"))  # "Space"
```

## Upgrade to PRO

[Input Mapper PRO](https://godot-forge.itch.io/input-mapper-pro-godot) adds unlimited actions, gamepad rebinding, device profiles, conflict detection and save/load.

---
Made with ♥ by [GodotForge](https://itch.io/profile/godot-forge)
