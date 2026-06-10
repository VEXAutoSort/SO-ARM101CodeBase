#!/usr/bin/env bash
# Find the USB port for each arm. Run this once per arm:
# it will ask you to unplug the arm so it can detect which port disappears.
set -e
echo "== LeRobot port finder =="
echo "Plug in ONE arm at a time. Follow the prompts."
lerobot-find-port
