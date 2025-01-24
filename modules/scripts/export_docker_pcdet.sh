#!/bin/bash

export PCDET_WS=${DOCKER_SSI}/git_pkgs/ros_pkgs/mm_ws
export PCDET_ROOT=${PCDET_WS}/src/pcdet_ros2/modules/submodules/OpenPCDet

export PYTHONPATH=$PYTHONPATH:${PCDET_ROOT}:${PCDET_ROOT}/venv/lib/python3.10/site-packages/