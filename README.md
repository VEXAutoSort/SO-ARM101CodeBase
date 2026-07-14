# AutoSort

Autonomous robotic arm system that sorts small VEX hardware (screws, nuts, standoffs, spacers...) into bins, so no human ever has to again.

**Team 11101B** — Henry, Vihaan, Aditya

**Stack:** SO-ARM101 (leader + follower) · [LeRobot](https://github.com/huggingface/lerobot) · ACT policy · imitation learning from teleop demos

## Links

- **Website:** [vexautosort.com](https://vexautosort.com)
- **Research journal:** [Google Doc](https://docs.google.com/document/d/1OEXihUL1jX0aLQL2xZLL2lIpXaZqPyQmFPhNkSJQVyw/edit)
- **Hugging Face org:** [VEXAutoSort](https://huggingface.co/VEXAutoSort) — datasets and trained policies

---

## Repo layout

```
autosort/
├── requirements.txt         # Python dependencies (lerobot[feetech] + hf hub cli)
├── configs/
│   └── setup.env.example    # Template — copy to setup.env, fill in YOUR ports/cameras
├── scripts/
│   ├── install.sh           # One-shot setup: deps + venv (+ --lelab)
│   ├── find_ports.sh        # Find USB ports for the arms
│   ├── calibrate.sh         # Calibrate an arm (follower | leader)
│   ├── teleop.sh            # Teleoperate (with camera view)
│   ├── record.sh            # Record a dataset of demos
│   ├── merge_datasets.sh    # Merge several datasets into one on the Hub
│   ├── train.sh             # Train ACT (local, for small tests — use Colab for real runs)
│   └── rollout.sh           # Run a trained policy on the robot
├── docs/
│   ├── data_collection_protocol.md   # READ BEFORE RECORDING ANY DATA
│   └── lab_notebook.md               # Running log: every session, every training run
└── notebooks/
    └── train_act_colab.ipynb   # ACT training on Colab's free GPU
```

## One-time setup (macOS)

LeRobot requires **Python 3.12+** and **git-lfs**. One command does everything —
system deps, a `.venv`, and all Python dependencies from `requirements.txt`:

```bash
./scripts/install.sh            # add --lelab to also install the LeLab UI
source .venv/bin/activate
hf auth login                   # paste a WRITE token
cp configs/setup.env.example configs/setup.env   # then edit your ports
```

<details>
<summary>What that installs / doing it manually</summary>

```bash
brew install python@3.12 git-lfs && git lfs install
python3.12 -m venv .venv && source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt          # lerobot[feetech] + huggingface_hub[cli]
```

`requirements.txt` pulls the full LeRobot pipeline (`lerobot-find-port`,
`calibrate`, `teleoperate`, `record`, `train`, `rollout`, `edit-dataset`) plus the
ACT policy and OpenCV camera support.
</details>

## Every time you work on this

```bash
source .venv/bin/activate
```

## First time on a new machine / new location

USB port names change when arms are re-plugged or you switch computers:

```bash
./scripts/find_ports.sh        # run once per arm, follow the prompts
```

Then edit `configs/setup.env` with your ports and camera indices.

> **Arm IDs:** the `id` for each arm (e.g. `my_follower`) names its calibration
> file. Use the SAME ids everywhere on a given machine, or you'll trigger
> recalibration. They're set once in `configs/setup.env`.

## Calibrate (once per arm on a new machine)

```bash
./scripts/calibrate.sh follower
./scripts/calibrate.sh leader
```

## Usage

```bash
./scripts/teleop.sh                          # practice driving the arm
./scripts/record.sh gear_v1 50               # record 50 episodes
./scripts/record.sh gear_v1 50 "" resume     # add more episodes to an existing dataset
./scripts/merge_datasets.sh gear_combined \
    Henry-Wang0225/gear_v1 Henry-Wang0225/gear_v2   # merge datasets
./scripts/train.sh gear_v1                    # small local test run (slow on Mac)
./scripts/rollout.sh Henry-Wang0225/act_v1    # deploy a trained policy
```

## Where training actually happens

Local `train.sh` on a Mac (MPS) is only for sanity checks — it's slow. Do real
runs one of two ways:

- **LeLab** — a browser UI over LeRobot for recording/training/eval. Install and run:
  ```bash
  uv tool install git+https://github.com/huggingface/leLab.git && lelab
  ```
- **Google Colab** (free T4 GPU) — see `notebooks/`. Start from LeRobot's official
  ACT training notebook, point it at `<HF_USER>/<dataset_name>`, push the policy
  back to the Hub, then `./scripts/rollout.sh <HF_USER>/<policy_name>` locally.

## Rules

1. **Read `docs/data_collection_protocol.md` before recording anything.** Bad data = wasted GPU hours.
2. **Log every session in `docs/lab_notebook.md`.** Date, what you did, what broke, success rates.
3. Don't move the cameras or bins mid-dataset. Ever.
