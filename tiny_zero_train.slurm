#!/bin/bash
#SBATCH --job-name=tiny-zero-train
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1         # Adjust to the number of GPUs you need
#SBATCH --cpus-per-task=4    # Adjust CPU per GPU requirement
#SBATCH --mem=32G            # Memory requirement
#SBATCH --time=12:00:00      # Max time (hh:mm:ss)
#SBATCH --partition=gpu      # Or whatever partition your cluster uses

# Load modules or conda
module load cuda/12.1
source ~/miniconda3/etc/profile.d/conda.sh
conda activate zero

# Your environment variables
export N_GPUS=1
export BASE_MODEL=/path/to/your/model
export DATA_DIR=/path/to/your/dataset
export ROLLOUT_TP_SIZE=1
export EXPERIMENT_NAME=countdown-qwen2.5-0.5b
export VLLM_ATTENTION_BACKEND=XFORMERS

# Create log dir if not exists
mkdir -p logs

# Run your training script
bash ./scripts/train_tiny_zero.sh
