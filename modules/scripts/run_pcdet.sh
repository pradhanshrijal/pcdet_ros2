#!/bin/bash

${PHA_HOME}/docker_scripts/run-compose.sh \
    -b ${PCDET_PHA}/modules/envs/pcdet-compose.yaml \
    -e ${PCDET_PHA}/modules/envs/pcdet.env