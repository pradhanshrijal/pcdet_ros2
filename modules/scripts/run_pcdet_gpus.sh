#!/bin/bash

${PHA_HOME}/docker_scripts/run-compose.sh \
    -b ${PCDET_PHA}/modules/envs/pcdet-compose-gpus.yaml \
    -e ${PCDET_PHA}/modules/envs/pcdet-gpus.env