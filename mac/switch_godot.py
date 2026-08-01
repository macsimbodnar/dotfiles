#!/usr/bin/env python3

import json
import sys
from pathlib import Path

GODOT_46 = "/Applications/Godot-4.6.app/Contents/MacOS/Godot"
GODOT_DEFAULT = "/Applications/Godot.app/Contents/MacOS/Godot"

CLAUDE_CONFIG = Path.home() / ".claude.json"


def load_config():
    with open(CLAUDE_CONFIG) as f:
        return json.load(f)


def get_current(config):
    return config["mcpServers"]["godot"]["env"]["GODOT_PATH"]


def status():
    current = get_current(load_config())
    print(f"Current: {current}")


def switch():
    config = load_config()
    current = get_current(config)
    new = GODOT_DEFAULT if current == GODOT_46 else GODOT_46
    config["mcpServers"]["godot"]["env"]["GODOT_PATH"] = new
    with open(CLAUDE_CONFIG, "w") as f:
        json.dump(config, f, indent=2)
    print(f"Switched: {current} -> {new}")
    print("Restart Claude Code to apply.")


if __name__ == "__main__":
    commands = {"status": status, "switch": switch}
    if len(sys.argv) != 2 or sys.argv[1] not in commands:
        print("Usage: switch_godot.py {status|switch}")
        sys.exit(1)
    commands[sys.argv[1]]()
