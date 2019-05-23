#!/bin/bash -
export NSLOTS="4"   # Number of cores
export JOB_NAME="Lev1"  # Job Name
exec 1>>`pwd`/SpEC.stdout    # Output file name
exec 2>>`pwd`/SpEC.stderr    # Error file name

# DO NOT MANUALLY EDIT THIS FILE! See `MakeSubmit.py update -h`.
# This is for submitting a batch job on 'local'.
umask 0022
. bin/this_machine.env || echo 'Not using env file.'
set -x
export PATH=$(pwd -P)/bin:$PATH

EvolutionWrapper -v -a="__EmailAddresses__" -f="__TerminationInfoFile__"
