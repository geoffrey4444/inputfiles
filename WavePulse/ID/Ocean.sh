#!/bin/bash -
#SBATCH -o spells.stdout
#SBATCH -e spells.stderr
#SBATCH --ntasks-per-node 12
#SBATCH -J BHWaveSpells
#SBATCH --nodes 1
#SBATCH -p orca-0
#SBATCH -t 24:00:00
#SBATCH -D .

# Distributed under the MIT License.
# See LICENSE.txt for details.

# To submit the script to the queue run:
#   sbatch Ocean.sh

export SPEC_BUILD_DIR=/home/geoffrey/Codes/spec/spec-orca0c/
source ${SPEC_BUILD_DIR}/MakefileRules/this_machine.env
module list
############################################################################
# Set desired permissions for files created with this script
umask 0022

${SPEC_BUILD_DIR}/Support/bin/DoMultipleRuns -e Spells -c "./SpEC &> spells.out"
