#!/usr/bin/env python3

import os
import subprocess
import sys
from pathlib import Path

# Constants
LOCK_FILE = Path("/tmp/pomodoro_popup_visible")
STATE_FILE = Path("/tmp/sketchybar_pomodoro_state")
IMG_WORK = "󰄉"
IMG_BREAK = "󱎫"
ITEM = "pomodoro"
POPUP = "pomodoro_popup"
PRESETS = [("25", "5"), ("50", "10"), ("90", "20")]

is_shown = False


def format_time(seconds: int) -> str:
    return f"{seconds // 60}:{seconds % 60:02}"


def save_state(state: dict):
    with open(STATE_FILE, "w") as f:
        for k, v in state.items():
            f.write(f"{k}={v}\n")


def load_state() -> dict:
    state = {
        "work_minutes": "25",
        "break_minutes": "5",
        "mode": "work",
        "paused": "true",
        "remaining": str(25 * 60),
    }
    if STATE_FILE.exists():
        with open(STATE_FILE) as f:
            for line in f:
                if "=" in line:
                    k, v = line.strip().split("=", 1)
                    state[k] = v
    return state


def update_timer(state: dict) -> dict:
    if state["paused"] == "false":
        remaining = int(state["remaining"]) - 1
        if remaining <= 0:
            if state["mode"] == "work":
                state["mode"] = "break"
                remaining = int(state["break_minutes"]) * 60
            else:
                state["mode"] = "work"
                remaining = int(state["work_minutes"]) * 60
        state["remaining"] = str(remaining)
    return state


def toggle_pause(state: dict) -> dict:
    state["paused"] = "false" if state["paused"] == "true" else "true"
    return state


def set_preset(state: dict, work: str, brk: str) -> dict:
    state["work_minutes"] = work
    state["break_minutes"] = brk
    state["mode"] = "work"
    state["paused"] = "true"
    state["remaining"] = str(int(work) * 60)
    return state


def draw_bar(state: dict):
    icon = IMG_BREAK if state["mode"] == "break" else IMG_WORK
    label = format_time(int(state["remaining"]))
    color = "0xffa6e3a1" if state["mode"] == "break" else "0xfff38ba8"
    subprocess.run(["sketchybar", "--set", POPUP, "drawing=off"])
    subprocess.run(
        [
            "sketchybar",
            "--set",
            ITEM,
            f"icon={icon}",
            f"label={label}",
            f"icon.color={color}",
        ]
    )


def draw_popup():
    if LOCK_FILE.exists():
        # Popup is open, close it
        subprocess.run(
            ["sketchybar", "--set", "pomodoro_controller", "popup.drawing=off"]
        )
        LOCK_FILE.unlink()
        return

    # Mark as open
    LOCK_FILE.touch()

    # Clear previous items
    subprocess.run(["sketchybar", "--remove", "/pomodoro_preset_.*/"])

    for i, (w, b) in enumerate(PRESETS):
        item = f"pomodoro_preset_{i}"
        label = f"{w}m Work / {b}m Break"
        # Close popup on click
        cmd = f"/usr/bin/env python3 {__file__} preset {w} {b} && sketchybar --set pomodoro_controller popup.drawing=off && rm -f {LOCK_FILE}"

        subprocess.run(
            ["sketchybar", "--add", "item", item, "popup.pomodoro_controller"]
        )
        subprocess.run(["sketchybar", "--add", "bracket", item + "_bracket", item])
        subprocess.run(
            [
                "sketchybar",
                "--set",
                item + "_bracket",
                "background.color=0xff634a4a",
                "background.corner_radius=8",
                "background.height=20",
                "background.padding_left=10",
                "background.padding_right=10",
            ]
        )
        subprocess.run(
            [
                "sketchybar",
                "--set",
                item,
                f"label={label}",
                f"click_script={cmd}",
                "drawing=on",
            ]
        )

    subprocess.run(["sketchybar", "--set", "pomodoro_controller", "popup.drawing=on"])


def main():
    args = sys.argv[1:]
    state = load_state()

    if args:
        if args[0] == "preset" and len(args) == 3:
            work, brk = args[1], args[2]
            state = set_preset(state, work, brk)
            save_state(state)
            draw_bar(state)
            return

        elif args[0] == "popup":
            draw_popup()
            return

        elif args[0] == "toggle":
            state = toggle_pause(state)
            save_state(state)
            draw_bar(state)
            return

    # Default mode: update on interval
    state = update_timer(state)
    save_state(state)
    draw_bar(state)


if __name__ == "__main__":
    main()
