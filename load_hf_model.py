import os
from huggingface_hub import snapshot_download

# Use current working directory as base
base_path = os.getcwd()
model_subdir = "models/qwen2.5-1.5b"
LOCAL_MODEL_DIR = os.path.join(base_path, model_subdir)

# Create the directory if it doesn't exist
os.makedirs(LOCAL_MODEL_DIR, exist_ok=True)

# Download the model into the local directory
snapshot_download(
    repo_id="Qwen/Qwen2.5-1.5B",
    cache_dir=LOCAL_MODEL_DIR,  # Optional: cache metadata here
    local_dir=LOCAL_MODEL_DIR,  # Actual directory to store model
    local_dir_use_symlinks=False,
    #ignore_patterns=["*.bin.index.json"]  # optional: skip large unused files
)
