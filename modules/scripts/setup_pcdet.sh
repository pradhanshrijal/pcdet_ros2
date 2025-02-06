#!/bin/bash

# Setup PCDET with PHA but simpler
# Sample: source setup_pcdet.sh /home/pha/schreibtisch github.com mm_ws

# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR=${SCRIPT_DIR}/../..

PCDET_PARENT=$1
PCDET_PARENT="${PCDET_PARENT:=mm_ws}"
#

# Install Requirements
sudo apt install python3 python3-pip -y
python3 -m pip install gdown==4.6.1
#

# pcdet_ros2 weights
cd ${SOURCE_DIR}/checkpoints

## PV-RCNN
if [ ! -f pv_rcnn_8369.pth ]; then
    gdown 1lIOq4Hxr0W3qsX83ilQv0nk1Cls6KAr-
fi

##

## Part-A2-Free
if [ ! -f PartA2_free_7872.pth ]; then
    gdown 1lcUUxF8mJgZ_e-tZhP1XNQtTBuC-R0zr
fi
##

## CBGS SECOND-MultiHead
if [ ! -f cbgs_second_multihead_nds6229_updated.pth ]; then
    gdown 1bNzcOnE3u9iooBFMk2xK7HqhdeQ_nwTq
fi
##

## PointPillar-MultiHead
if [ ! -f pp_multihead_nds5823_updated.pth ]; then
    gdown 1p-501mTWsq0G9RzroTWSXreIMyTUUpBM
fi
##

echo "Fin."

cd ${PHA_HOME}