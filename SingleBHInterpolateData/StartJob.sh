#!/bin/bash
. bin/this_machine.env || echo 'Not using env file.'
bin/DoMultipleRuns -L -c 'bash ./Submit.sh'
