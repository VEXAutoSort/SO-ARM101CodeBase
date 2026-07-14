#!/usr/bin/env bash
# Train ACT locally. NOTE: on a Mac this uses MPS and will be SLOW —
# fine for a sanity-check run, but do real training on Colab (see notebooks/).
# Usage: ./train.sh <dataset_name> [job_name]
set -e
source "$(dirname "$0")/../configs/setup.env"

DATASET_NAME="${1:?Usage: ./train.sh <dataset_name> [job_name]}"
JOB_NAME="${2:-act_${DATASET_NAME}}"

lerobot-train \
  --dataset.repo_id="${HF_USER}/${DATASET_NAME}" \
  --policy.type=act \
  --output_dir="outputs/train/${JOB_NAME}" \
  --job_name="${JOB_NAME}" \
  --policy.device="${DEVICE}" \
  --policy.repo_id="${HF_USER}/${JOB_NAME}" \
  --wandb.enable=false
