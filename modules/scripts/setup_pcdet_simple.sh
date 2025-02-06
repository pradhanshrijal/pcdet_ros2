#!/bin/bash

# Setup PCDET with PHA but simpler
# Sample: source setup_pcdet.sh /home/pha/schreibtisch github.com mm_ws

# Variables
PHA_PARENT=$1
PHA_PARENT="${PHA_PARENT:=/home/${USER}/schreibtisch}"
PHA_DB=$2
PHA_DB="${PHA_DB:=github.com}"
PCDET_PARENT=$3
PCDET_PARENT="${PCDET_PARENT:=mm_ws}"
#

# Install Requirements
sudo apt install python3 python3-pip -y
python3 -m pip install gdown==4.6.1
#

# Parent Folder
if [ ! -d "$PHA_PARENT" ]; then
    mkdir -p $PHA_PARENT
    echo "Setup PHA Parent Path: ${PHA_PARENT}"
else
    echo "PHA Parent Path already set: ${PHA_PARENT}"
fi
#

# PHA Folder
cd $PHA_PARENT

if [ ! -d pha_docker_files ]; then
    git clone https://${PHA_DB}/pradhanshrijal/pha_docker_files --recursive
    echo "Setup PHA Docker Files."
else
    echo "PHA Docker Files already set."
fi

cd pha_docker_files

if [[ -z "${PHA_HOME}" ]]; then
    echo -e "\n# PHA" >> /home/${USER}/.bashrc
    echo "source ${PHA_PARENT}/pha_docker_files/docker_share/scripts/setup/export_pha.sh" >> /home/${USER}/.bashrc
    echo 'export PATH="${HOME}/.local/bin:$PATH"' >> /home/${USER}/.bashrc
    source /home/${USER}/.bashrc
    echo "Setup PHA Home Path: ${PHA_HOME}"
else
    echo "PHA Home already set: ${PHA_HOME}"
fi
#

# PHA pcdet_ros2 Main Folder
cd ${SSI_PATH}/git_pkgs/ros_pkgs/

if [ ! -d ${PCDET_PARENT} ]; then
    mkdir -p ${PCDET_PARENT}/src
    echo "Setup PHA ${PCDET_PARENT}."
else
    echo "PHA ${PCDET_PARENT} already set."
fi

cd ${PCDET_PARENT}/src

if [ ! -d pcdet_ros2 ]; then
    git clone https://${PHA_DB}/pradhanshrijal/pcdet_ros2 --recursive
    echo "Setup PHA pcdet_ros2."
else
    echo "PHA pcdet_ros2 already set."
fi

if [[ -z "${PCDET_PHA}" ]]; then
    echo -e "\n# PCDET" >> /home/${USER}/.bashrc
    echo "source ${SSI_PATH}/git_pkgs/ros_pkgs/${PCDET_PARENT}/src/pcdet_ros2/modules/scripts/export_pcdet.sh" >> /home/${USER}/.bashrc
    source /home/${USER}/.bashrc
    echo "Setup PCDET PHA Path: ${PCDET_PHA}"
else
    echo "PCDET PHA Path already set: ${PCDET_PHA}"
fi
#

# pcdet_ros2 weights
cd ${PCDET_PHA}/checkpoints

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

#

# Dependencies

## OpenPCDet
cd ${SSI_PATH}/git_pkgs/ros_pkgs/${PCDET_PARENT}/src/pcdet_ros2/modules/submodules
if [ ! -d OpenPCDet ]; then
    git clone https://github.com/open-mmlab/OpenPCDet
    echo "Setup OpenPCDet"
else
    echo "OpenPCDet already set"
fi

##

## ROS 2 Numpy
if [ ! -d ros2_numpy ]; then
    git clone https://github.com/Box-Robotics/ros2_numpy -b humble
    echo "Setup ros2_numpy"
else
    echo "ros2_numpy already set"
fi
##

#

echo "Fin."

cd ${PHA_HOME}