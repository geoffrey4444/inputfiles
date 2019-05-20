#!/bin/bash -
#SBATCH -J Lev5                   # Job Name
#SBATCH -o SpEC.stdout                # Output file name
#SBATCH -e SpEC.stderr                # Error file name
#SBATCH -n 12                  # Number of cores
#SBATCH --ntasks-per-node 12        # number of MPI ranks per node
#SBATCH -p orca-0                  # Queue name
#SBATCH -t 12:0:00   # Run time

# DO NOT MANUALLY EDIT THIS FILE! See `MakeSubmit.py update -h`.
# This is for submitting a batch job on 'ocean'.
umask 0022
. bin/this_machine.env || echo 'Not using env file.'
set -x
export PATH=$(pwd -P)/bin:$PATH

EvolutionWrapper -v -a="__EmailAddresses__" -f="__TerminationInfoFile__"
