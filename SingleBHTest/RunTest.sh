#!/bin/bash
# Run this in, e.g., the SpEC docker container (as user specuser)
# Note: add $SPEC_HOME/Support/bin to specuser path before trying this
# Note: first do
#    ln -s $SPEC_HOME/Evolution/Executables/EvolveHyperbolicSystem SpEC
# Before running this script

DoMultipleRuns -e SpEC -c "bash Submit.sh &> spec.out &"
