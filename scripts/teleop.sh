#!/usr/bin/env bash
# Teleoperate the follower arm with the leader arm, with live camera view.
set -e
source "$(dirname "$0")/../configs/setup.env"

lerobot-teleoperate \
  --robot.type=so101_follower \
  --robot.port="${FOLLOWER_PORT}" \
  --robot.id="${FOLLOWER_ID}" \
  --robot.cameras="${CAMERAS}" \
  --teleop.type=so101_leader \
  --teleop.port="${LEADER_PORT}" \
  --teleop.id="${LEADER_ID}" \
  --display_data=true
