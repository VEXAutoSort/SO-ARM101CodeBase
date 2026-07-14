# Training notebooks (Colab)

Real ACT training runs happen on Google Colab (free T4 GPU is enough for a
50-episode single-task dataset; expect a few hours).

Use **`train_act_colab.ipynb`** here — open it in Colab (set runtime to GPU/T4).
It's adapted from LeRobot's official ACT notebook with our dataset names and
Drive checkpointing filled in.

Workflow:
1. Record data locally → it pushes to the HF Hub automatically
2. Open `train_act_colab.ipynb` in Colab, set `DATASET` to `<HF_USER>/<dataset_name>`
3. Train with `--policy.device=cuda`, checkpoint to Drive (Colab disconnects!)
4. It pushes the trained policy to the Hub
5. Pull it locally and run `./scripts/rollout.sh <HF_USER>/<policy_name>`
