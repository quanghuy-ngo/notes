#!/bin/sh
#SBATCH -p test
#SBATCH -n 2          # number of cores (here 2 cores requested)
#SBATCH -c 2
#SBATCH -N 1
#SBATCH --time=00:10:00 # time allocation, which has the format (D-HH:MM), here set to 1 hou
#SBATCH --mem=16GB # specify memory required per node (here set to 16 GB)

# Notification configuration
#SBATCH --mail-type=END           # Send a notification email when the job is done (=END)
#SBATCH --mail-type=FAIL          # Send a notification email when the job fails (=FAIL)
#SBATCH --mail-user=a1798528@student.adelaide.edu.au

# Output file location
#SBATCH --output="_logs/test_%j.out"
#SBATCH --job-name="test"

echo ":: Running script";
module load arch/haswell
module load Anaconda3/2020.07
module load CUDA/10.2.89
module load cuDNN/CUDA-10.2/7.6.5.32
source activate eee13352

# Strange workaround - not sure why it works. Reference:
# https://stackoverflow.com/questions/36733179/
# Without it, the wrong python version is used (default instead of conda)
# You can try to remove and see if it still works
source deactivate eee13352

source activate eee13352
echo ":: Python loaded";
echo "environment loaded"
echo "run train"
python3 /hpcfs/users/a1798528/eee21s1-13352-gnn_HPC/eee13352_HPC/DARPA_opTC/hgt/train_DARPA.py
