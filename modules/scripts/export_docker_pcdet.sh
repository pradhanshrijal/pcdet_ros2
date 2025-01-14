#!/bin/bash

export PCDET_WS=${DOCKER_SSI}/git_pkgs/ros_pkgs/mm_ws
export PCDET_ROOT=${DOCKER_SSI}/git_pkgs/Softwares/py_sw/OpenPCDet

export PYTHONPATH=$PYTHONPATH:${PCDET_ROOT}:${PCDET_ROOT}/venv/lib/python3.10/site-packages/