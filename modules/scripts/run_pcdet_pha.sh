#!/bin/bash

${PHA_HOME}/docker_scripts/run-compose.sh \
    -b ${PCDET_PHA}/modules/envs/pcdet-compose-pha.yaml \
    -e ${PCDET_PHA}/modules/envs/pcdet-pha.env