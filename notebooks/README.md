# Training notebooks (Colab)

Real ACT training runs happen on Google Colab (free T4 GPU is enough for a
50-episode single-task dataset; expect a few hours).

Start from LeRobot's official ACT training notebook (linked from their docs
"notebooks" page), then save a copy here with our dataset names filled in.

Workflow:
1. Record data locally → it pushes to the HF Hub automatically
2. Open the Colab notebook, point it at `<HF_USER>/<dataset_name>`
3. Train with `--policy.device=cuda`, checkpoint to Drive (Colab disconnects!)
4. Push the trained policy to the Hub
5. Pull it locally and run `./scripts/rollout.sh <HF_USER>/<policy_name>`
