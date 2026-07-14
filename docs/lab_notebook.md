# AutoSort Lab Notebook

Running log of everything. This becomes the backbone of the pitch deck and
any competition writeup — photos and videos of failures included.

---

## Session log

| Date | Who | What we did | Dataset / run | Result | Notes / issues |
|------|-----|-------------|---------------|--------|----------------|
| 2026-06-08 | Henry | Acquired SO-ARM101 from Almond Robotics; setup, calibration, teleop working. Bought camera ($165) | — | Done | |
| 2026-06-11 | All | First in-person meeting @ Henry's | — | | |
| 2026-06-11 | Henry | First recorded dataset (overhead cam, 960x600) | test_v1 | | pilot, checking the pipeline end to end |
| 2026-06-12 | All | Recorded gear task in batches, then merged | gear_v2 (+ b2/b3/b4) → gear_combined_v2 | | merged 4 datasets with lerobot-edit-dataset |

## Training runs

| Date | Dataset | # eps | Policy | Where trained | Steps | Eval result | Notes |
|------|---------|-------|--------|---------------|-------|-------------|-------|
| 2026-06 | gear_combined_v2 | ~200 | act_v1 | | | | first ACT policy, rollout on MPS |

## Failure modes observed

| Date | Failure | How often | Hypothesis | Fix attempted |
|------|---------|-----------|------------|---------------|
| | | | | |

## Spending tracker (for pitch BOM)

| Date | Item | Cost | Notes |
|------|------|------|-------|
| 2026-06 | SO-ARM101 (leader+follower) | $0 | donated by Almond Robotics |
| 2026-06-08 | Camera | $165 | |
