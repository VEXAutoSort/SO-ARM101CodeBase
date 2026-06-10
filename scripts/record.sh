#!/usr/bin/env bash
# Record a teleop dataset and push it to the Hugging Face Hub.
# Usage: ./record.sh <dataset_name> <num_episodes> ["task description"]
# Example: ./record.sh screws_pilot_v1 50 "Pick up a screw and drop it in the sorter"
set -e
source "$(dirname "$0")/../configs/setup.env"

DATASET_NAME="${1:?Usage: ./record.sh <dataset_name> <num_episodes> [task]}"
NUM_EPISODES="${2:?Usage: ./record.sh <dataset_name> <num_episodes> [task]}"
TASK="${3:-Pick up a screw and drop it in the screw sorter}"

echo ">> Recording ${NUM_EPISODES} episodes -> ${HF_USER}/${DATASET_NAME}"
echo ">> Task: ${TASK}"
echo ">> READ docs/data_collection_protocol.md FIRST. Press enter to continue."
read -r

lerobot-record \
  --robot.type=so101_follower \
  --robot.port="${FOLLOWER_PORT}" \
  --robot.id="${FOLLOWER_ID}" \
  --robot.cameras="${CAMERAS}" \
  --teleop.type=so101_leader \
  --teleop.port="${LEADER_PORT}" \
  --teleop.id="${LEADER_ID}" \
  --display_data=true \
  --dataset.repo_id="${HF_USER}/${DATASET_NAME}" \
  --dataset.num_episodes="${NUM_EPISODES}" \
  --dataset.single_task="${TASK}" \
  --dataset.episode_time_s="${EPISODE_TIME_S}" \
  --dataset.reset_time_s="${RESET_TIME_S}" \
  --dataset.fps="${FPS}"
