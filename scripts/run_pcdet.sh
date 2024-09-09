#!/bin/bash

${PHA_HOME}/docker_scripts/run-compose.sh \
    -b ${PCDET_PHA}/envs/pcdet-compose.yaml \
    -e ${PCDET_PHA}/envs/pcdet.env