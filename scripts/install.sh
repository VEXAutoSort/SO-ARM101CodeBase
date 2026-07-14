#!/usr/bin/env bash
# One-shot setup for macOS: system deps, Python venv, LeRobot + HF CLI.
# Pass --lelab to also install the LeLab browser UI.
# Usage: ./scripts/install.sh [--lelab]
set -e
cd "$(dirname "$0")/.."

echo ">> System deps (Homebrew)..."
brew install python@3.12 git-lfs
git lfs install

echo ">> Python venv (.venv)..."
python3.12 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
python -c "import lerobot; print('LeRobot OK')"

if [ "${1:-}" = "--lelab" ]; then
  echo ">> LeLab (via uv)..."
  command -v uv >/dev/null 2>&1 || brew install uv
  uv tool install git+https://github.com/huggingface/leLab.git
fi

cat <<'EOF'

>> Done. Next steps:
   source .venv/bin/activate
   hf auth login
   cp configs/setup.env.example configs/setup.env   # then edit your ports
EOF
