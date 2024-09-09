#!/bin/bash

${PHA_HOME}/docker_scripts/run-compose.sh \
    -b ${PCDET_PHA}/envs/pcdet-compose-gpus.yaml \
    -e ${PCDET_PHA}/envs/pcdet-gpus.env