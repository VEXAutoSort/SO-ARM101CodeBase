#!/usr/bin/env bash
# Merge several datasets into one new dataset on the Hub.
# Usage: ./merge_datasets.sh <new_dataset_name> <repo_id> [<repo_id> ...]
# Example: ./merge_datasets.sh gear_combined_v2 \
#            Henry-Wang0225/gear_v2 Henry-Wang0225/gear_v2_b2
set -e
source "$(dirname "$0")/../configs/setup.env"

NEW_NAME="${1:?Usage: ./merge_datasets.sh <new_dataset_name> <repo_id> [repo_id ...]}"
shift
[ "$#" -ge 1 ] || { echo "Give at least one source repo_id to merge."; exit 1; }

REPO_LIST="["
for repo in "$@"; do REPO_LIST+="'${repo}', "; done
REPO_LIST="${REPO_LIST%, }]"

lerobot-edit-dataset \
  --new_repo_id "${HF_USER}/${NEW_NAME}" \
  --operation.type merge \
  --operation.repo_ids "${REPO_LIST}"
