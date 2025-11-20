#!/bin/bash 
#SBATCH --job-name=HUMAN_array_s2
#SBATCH --output=diann_s2_%A_%a.out  # Unique output for each job
#SBATCH --error=diann_s2_%A_%a.err   # Unique error log for each job
#SBATCH --cpus-per-task=20
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=20
#SBATCH --partition=production
#SBATCH --array=0-43   # This will be replaced dynamically


# Define paths
DATA_DIR="/share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/Species_specific_folders/HUMAN/Bruker_raw"
LIB_PATH="/share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/Species_specific_folders/HUMAN/DIA-NN/libs/HUMAN_lib_final.parquet"
FASTA_PATH="/share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/fastas/DIA-NN-Predicted_proteomes/UP000005640_9606.fasta"

# Get a list of all .d directories
D_FILES=("$DATA_DIR"/*.d)

# Get the directory corresponding to the current SLURM_ARRAY_TASK_ID
D_PATH="${D_FILES[$SLURM_ARRAY_TASK_ID]}"

# Load required modules (if applicable)
module load singularity/3.6.3

# Ensure the directory exists
if [ -d "$D_PATH" ]; then
    srun singularity exec --bind /share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/:/share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/ /share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/dia-nn/diann-2.0.1.sif /diann-2.0.1/diann-linux --f "$D_PATH" --lib \"$LIB_PATH\" --threads 40 --verbose 1 --qvalue 0.01 --matrices --fasta \"$FASTA_PATH\"--met-excision --cut K*,R* --missed-cleavages 1 --unimod4 --var-mods 1 --mass-acc 15 --mass-acc-ms1 15 --window 18 --rt-profiling --pg-level 1 --quant-ori-names 
else
    echo "Error: Directory $D_PATH does not exist!"
    exit 1
fi


