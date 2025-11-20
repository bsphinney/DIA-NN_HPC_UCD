#!/bin/bash 
#SBATCH --job-name=DEROT_combine
#SBATCH -o comb_DEROT-%j.output
#SBATCH -e combdin_DEROT-%j.output
#SBATCH --cpus-per-task=20
#SBATCH --time=24:00:00
#SBATCH --partition=production



# Define paths
DATA_DIR="/share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/Species_specific_folders/HUMAN/Bruker_raw"
LIB_PATH="/share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/fastas/DIA-NN-Predicted_proteomes/HumanUniprot.speclib"
FASTA_PATH="/share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/fastas/DIA-NN-Predicted_proteomes/fastas/UP000005640_9606.fasta"
OUT_DIR="/share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/Species_specific_folders/DEROT/Bruker_raw"
TEMP_DIR="/share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/Species_specific_folders/DEROT/DIA-NN_output/quant_Files/search1/correct"
LIB_OUT="/share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/Species_specific_folders/HUMAN/DIA-NN/libs/HUMAN_lib_final.parquet"


# Load required modules (if applicable)
module load singularity/3.6.3

srun singularity exec --bind /share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/:/share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/ /share/proteomics/Data/lab/service/off_campus/NIST/bat_sparrow_project_2024_2025/dia-nn/diann-2.0.1.sif /diann-2.0.1/diann-linux \
--f "$DATA_DIR/NIST_S3-C4_1_8385.d" \
--f "$DATA_DIR/NIST-4_S3-E12_1_8082.d" \
--f "$DATA_DIR/NIST_S3-C4_1_8512.d" \
--f "$DATA_DIR/NIST_S4-C4_1_8703.d" \
--f "$DATA_DIR/NIST_S6-G12_1_9596.d" \
--f "$DATA_DIR/NIST_S6-E8_1_9550.d" \
--f "$DATA_DIR/NIST_S4-E8_1_8737.d" \
--f "$DATA_DIR/NIST_S3-E9_1_8427.d" \
--f "$DATA_DIR/NIST-2_S3-C5_1_8024.d" \
--f "$DATA_DIR/NIST_S4-A1_1_9229.d" \
--f "$DATA_DIR/NIST_S4-A1_1_8677.d" \
--f "$DATA_DIR/NIST_S3-E8_1_8546.d" \
--f "$DATA_DIR/NIST_S6-A1_1_9469.d" \
--f "$DATA_DIR/NIST_S5-C5_1_8814.d" \
--f "$DATA_DIR/NIST_S6-C4_1_9739.d" \
--f "$DATA_DIR/NIST_S6-C4_1_9504.d" \
--f "$DATA_DIR/NIST-3_S6-E8_1_10913.d" \
--f "$DATA_DIR/NIST_S4-E8_1_9303.d" \
--f "$DATA_DIR/NIST_S6-G12_1_9824.d" \
--f "$DATA_DIR/NIST-4_S6-G12_1_10947.d" \
--f "$DATA_DIR/NIST_S6-G11_1_9149.d" \
--f "$DATA_DIR/NIST_S6-E8_1_9782.d" \
--f "$DATA_DIR/NIST_S3-G10_1_8437.d" \
--f "$DATA_DIR/NIST-1_S6-A1_1_9693.d" \
--f "$DATA_DIR/NIST_S3-A1_1_8359.d" \
--f "$DATA_DIR/NIST_S4-G10_1_9321.d" \
--f "$DATA_DIR/NIST_S6-A1_1_9048.d" \
--f "$DATA_DIR/NIST_S5-A8_1_8836.d" \
--f "$DATA_DIR/NIST_S3-E8_1_8419.d" \
--f "$DATA_DIR/NIST_S6-C4_1_9737.d" \
--f "$DATA_DIR/NIST_S5-A1_1_8780.d" \
--f "$DATA_DIR/NIST_S4-C4_1_9261.d" \
--f "$DATA_DIR/NIST-3_S3-F8_1_8051.d" \
--f "$DATA_DIR/NIST_S6-A8_1_9113.d" \
--f "$DATA_DIR/NIST-1_S6-A1_1_10853.d" \
--f "$DATA_DIR/NIST_S3-A1_1_8486.d" \
--f "$DATA_DIR/NIST-1_S3-A1_1_7990.d" \
--f "$DATA_DIR/NIST_S5-G11_1_8866.d" \
--f "$DATA_DIR/NIST_S4-G12_1_8771.d" \
--f "$DATA_DIR/NIST_S6-C5_1_9088.d" \
--f "$DATA_DIR/NIST_S3-G12_1_8580.d" \
--f "$DATA_DIR/NIST-2_S6-C4_1_10879.d" \
--f "$DATA_DIR/NIST-1_20ul_S3-A1_1_8086.d" \
--lib \"$LIB_PATH\" --threads 40 --verbose 1 --qvalue 0.01 --matrices --met-excision --cut K*,R* --missed-cleavages 1 --unimod4 --var-mods 1 --mass-acc 15 --mass-acc-ms1 15 --rt-profiling --pg-level 1 --out-lib \"$LIB_OUT\" --gen-spec-lib --use-quant --quant-ori-names 