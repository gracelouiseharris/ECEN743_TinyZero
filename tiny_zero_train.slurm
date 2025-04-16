#!/bin/bash
#SBATCH --job-name=tiny-zero-train
#SBATCH --output=logs/%x_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1   
#SBATCH --gres=gpu:a100:1           # Adjust to the number of GPUs you need
#SBATCH --cpus-per-task=4           # Adjust CPU per GPU requirement
#SBATCH --mem=80G                   # Memory requirement
#SBATCH --time=10:00:00             # Max time (hh:mm:ss)
#SBATCH --partition=gpu             # Or whatever partition your cluster uses

# Load modules or conda
module load CUDA/12.1
source ~/.bashrc
#source ~/miniconda3/etc/profile.d/conda.sh
conda activate zero

# environment variables
export N_GPUS=1
export BASE_MODEL=/scratch/user/grace.harris/zerodir/TinyZero/models/qwen2.5-0.5b
export DATA_DIR=/scratch/user/grace.harris/zerodir/TinyZero/data/countdown
#export BASE_MODEL=/scratch/user/trishabh1999/projects/TinyZero/models/qwen2.5-0.5b
#export DATA_DIR=/scratch/user/trishabh1999/projects/TinyZero/data/countdown
export ROLLOUT_TP_SIZE=1
export EXPERIMENT_NAME=countdown-qwen2.5-0.5b
export VLLM_ATTENTION_BACKEND=XFORMERS
# for weights and biases logging, also setting it offline as compute node have no internet
export WANDB_API_KEY=e3ec1086d17fcd30cb51a04db8da265a1646813f #group key
#export WANDB_API_KEY=991a69738a190c351e1906881719e2fc9f6a1537
export WANDB_MODE=offline

# Create log dir if not exists
mkdir -p logs

# Run your training script
bash ./scripts/train_tiny_zero.sh
