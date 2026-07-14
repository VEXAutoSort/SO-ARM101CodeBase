#!/usr/bin/env bash
# Record a teleop dataset and push it to the Hugging Face Hub.
# Usage: ./record.sh <dataset_name> <num_episodes> ["task"] [resume]
# Example: ./record.sh gear_v2 50
#          ./record.sh gear_v2 50 "pick up gear and place in container" resume
set -e
source "$(dirname "$0")/../configs/setup.env"

DATASET_NAME="${1:?Usage: ./record.sh <dataset_name> <num_episodes> [task] [resume]}"
NUM_EPISODES="${2:?Usage: ./record.sh <dataset_name> <num_episodes> [task] [resume]}"
TASK="${3:-${DEFAULT_TASK}}"
RESUME=false
[ "${4:-}" = "resume" ] && RESUME=true

echo ">> Recording ${NUM_EPISODES} episodes -> ${HF_USER}/${DATASET_NAME} (resume=${RESUME})"
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
  --dataset.fps="${FPS}" \
  --dataset.push_to_hub=true \
  --resume="${RESUME}"
