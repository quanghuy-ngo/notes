#!/bin/sh
#SBATCH -p batch
#SBATCH -n 2          # number of cores (here 2 cores requested)
#SBATCH --ntasks=11
#SBATCH -c 2
#SBATCH -N 1
#SBATCH --time=12:00:00 # time allocation, which has the format (D-HH:MM), here set to 1 hou
#SBATCH --mem-per-cpu=32GB # specify memory required per node (here set to 16 GB)
#SBATCH --cpus-per-task=2

# Notification configuration
#SBATCH --mail-type=END           # Send a notification email when the job is done (=END)
#SBATCH --mail-type=FAIL          # Send a notification email when the job fails (=FAIL)
#SBATCH --mail-user=a1798528@adelaide.edu.au

# Output file location
#SBATCH --output="_logs/log_mts_par_%j.out"
#SBATCH --job-name="mts_par"

echo ":: Running script";
module load arch/haswell
module load Anaconda3/2020.07

source activate honey_env

# Strange workaround - not sure why it works. Reference:
# https://stackoverflow.com/questions/36733179/
# Without it, the wrong python version is used (default instead of conda)
# You can try to remove and see if it still works
source deactivate honey_env

source activate honey_env
echo ":: Python loaded";
echo "environment loaded"
echo "run train"
#python3 builddygraph.py $a $b $c
srun --ntasks 1 --exclusive -c 1 python3 monte_carlo_simulation_par.py $a 0 1000 0 &
srun --ntasks 1 --exclusive -c 1 python3 monte_carlo_simulation_par.py $a 1000 1000 0 &
srun --ntasks 1 --exclusive -c 1 python3 monte_carlo_simulation_par.py $a 2000 1000 0 &
srun --ntasks 1 --exclusive -c 1 python3 monte_carlo_simulation_par.py $a 3000 1000 0 &
srun --ntasks 1 --exclusive -c 1 python3 monte_carlo_simulation_par.py $a 4000 1000 0 &
srun --ntasks 1 --exclusive -c 1 python3 monte_carlo_simulation_par.py $a 5000 1000 0 &
srun --ntasks 1 --exclusive -c 1 python3 monte_carlo_simulation_par.py $a 6000 1000 0 &
srun --ntasks 1 --exclusive -c 1 python3 monte_carlo_simulation_par.py $a 7000 1000 0 &
srun --ntasks 1 --exclusive -c 1 python3 monte_carlo_simulation_par.py $a 8000 1000 0 &
srun --ntasks 1 --exclusive -c 1 python3 monte_carlo_simulation_par.py $a 9000 1000 0 &
wait
python3 combine_mts_par.py $a 10 1000
