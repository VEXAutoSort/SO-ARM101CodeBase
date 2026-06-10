# AutoSort 🤖🔩

Autonomous robotic arm system that sorts small VEX hardware (screws, nuts, standoffs, spacers...) into bins, so no human ever has to again.

**Team 11101B** — Henry, Vihaan, Aditya

**Stack:** SO-ARM101 (leader + follower) · [LeRobot](https://github.com/huggingface/lerobot) · ACT policy · imitation learning from teleop demos

---

## Repo layout

```
autosort/
├── configs/
│   └── setup.env          # YOUR machine's ports, arm IDs, camera indices (edit this first!)
├── scripts/
│   ├── find_ports.sh      # Find USB ports for the arms
│   ├── teleop.sh          # Teleoperate (with camera view)
│   ├── record.sh          # Record a dataset of demos
│   ├── train.sh           # Train ACT (local, for small tests — use Colab for real runs)
│   └── rollout.sh         # Run a trained policy on the robot
├── docs/
│   ├── data_collection_protocol.md   # READ BEFORE RECORDING ANY DATA
│   └── lab_notebook.md               # Running log: every session, every training run
└── notebooks/             # Colab training notebooks live here
```

## One-time setup (macOS)

LeRobot requires **Python 3.12+** and **git-lfs**.

```bash
# 1. Homebrew deps
brew install python@3.12 git-lfs
git lfs install

# 2. Clone LeRobot (separate repo, lives next to this one)
git clone https://github.com/huggingface/lerobot.git ~/lerobot
cd ~/lerobot

# 3. Virtual environment
python3.12 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -e ".[feetech]"

# 4. Verify
python -c "import lerobot; print('LeRobot OK')"

# 5. Log in to Hugging Face (needed to push datasets/models)
pip install -U "huggingface_hub[cli]"
hf auth login
```

## Every time you work on this

```bash
cd ~/lerobot && source .venv/bin/activate
cd ~/autosort   # (or wherever you cloned this repo)
```

## First time on a new machine / new location

USB port names change when arms are re-plugged or you switch computers:

```bash
./scripts/find_ports.sh        # run once per arm, follow the prompts
```

Then edit `configs/setup.env` with your ports and camera indices.

> **Arm IDs:** the `id` for each arm (e.g. `autosort_follower`) names its calibration
> file. Use the SAME ids everywhere on a given machine, or you'll trigger
> recalibration. They're set once in `configs/setup.env`.

## Usage

```bash
./scripts/teleop.sh                          # practice driving the arm
./scripts/record.sh my_dataset_name 10      # record 10 episodes
./scripts/train.sh my_dataset_name           # small local test run (slow on Mac)
./scripts/rollout.sh path/to/policy          # deploy a trained policy
```

**Real training runs happen on Google Colab** (free T4 GPU) — see `notebooks/`.
LeRobot has an official ACT training notebook; ours with our settings goes in that folder.

## Rules

1. **Read `docs/data_collection_protocol.md` before recording anything.** Bad data = wasted GPU hours.
2. **Log every session in `docs/lab_notebook.md`.** Date, what you did, what broke, success rates.
3. Don't move the cameras or bins mid-dataset. Ever.
