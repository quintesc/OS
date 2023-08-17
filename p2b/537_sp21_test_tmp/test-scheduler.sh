#!/bin/bash

if ! [[ -d p2b ]]; then
    echo "The p2b/ dir does not exist."
    echo "Your xv6 code should be in the p2b/ directory"
    echo "to enable the automatic tester to work."
    exit 1
fi

../tester/run-tests.sh $*
