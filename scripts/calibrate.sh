#!/usr/bin/env bash
# Calibrate an arm. Run once per arm on a new machine (or after a rebuild).
# Usage: ./calibrate.sh follower | leader
set -e
source "$(dirname "$0")/../configs/setup.env"

case "${1:-}" in
  follower)
    lerobot-calibrate \
      --robot.type=so101_follower \
      --robot.port="${FOLLOWER_PORT}" \
      --robot.id="${FOLLOWER_ID}"
    ;;
  leader)
    lerobot-calibrate \
      --teleop.type=so101_leader \
      --teleop.port="${LEADER_PORT}" \
      --teleop.id="${LEADER_ID}"
    ;;
  *)
    echo "Usage: ./calibrate.sh follower | leader"
    exit 1
    ;;
esac
