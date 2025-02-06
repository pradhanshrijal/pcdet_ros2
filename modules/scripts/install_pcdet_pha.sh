#!/bin/bash

IN_USERNAME=$1
IN_SSI_PATH=$2
IN_ROS_VERSION=$3
IN_USERNAME="${IN_USERNAME:=pha}"
IN_SSI_PATH="${IN_SSI_PATH:=/home/${IN_USERNAME}/docker_share}"
IN_ROS_VERSION="${IN_ROS_VERSION:=humble}"

source /home/${IN_USERNAME}/.bashrc

# Install pcdet_ros2
cd ${IN_SSI_PATH}/git_pkgs/ros_pkgs/mm_ws
rosdep install -y --from-paths src --ignore-src --rosdistro ${IN_ROS_VERSION} # $ROS_DISTRO
colcon build --symlink-install --packages-select ros2_numpy pcdet_ros2

# Activate Venv
source /home/${IN_USERNAME}/ros2_ws/venv/bin/activate
echo "source /home/${IN_USERNAME}/ros2_ws/venv/bin/activate" >> /home/${IN_USERNAME}/.bashrc

# Install OpenPCDet
python3 -m pip install -r ${IN_SSI_PATH}/git_pkgs/ros_pkgs/mm_ws/src/pcdet_ros2/modules/requirements/python_venv_requirements.txt
cd ${IN_SSI_PATH}/git_pkgs/ros_pkgs/mm_ws/src/pcdet_ros2/modules/submodules/OpenPCDet
python3 setup.py develop

source /home/${IN_USERNAME}/.bashrc
#