#!/usr/bin/env bash
# Run a trained policy on the robot (no recording).
# Usage: ./rollout.sh <policy_path_or_hub_id> ["task description"] [duration_s]
# Example: ./rollout.sh ${HF_USER}/act_screws_pilot_v1
set -e
source "$(dirname "$0")/../configs/setup.env"

POLICY="${1:?Usage: ./rollout.sh <policy_path_or_hub_id> [task] [duration_s]}"
TASK="${2:-${DEFAULT_TASK}}"
DURATION="${3:-30}"

lerobot-rollout \
  --strategy.type=base \
  --policy.path="${POLICY}" \
  --policy.device="${DEVICE}" \
  --robot.type=so101_follower \
  --robot.port="${FOLLOWER_PORT}" \
  --robot.id="${FOLLOWER_ID}" \
  --robot.cameras="${CAMERAS}" \
  --task="${TASK}" \
  --duration="${DURATION}"
