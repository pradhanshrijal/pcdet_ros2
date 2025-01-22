# Declare VARIABLES
ARG IMAGE_NAME=nvidia/cuda
ARG IMAGE_VERSION=11.7.1-devel-ubuntu22.04
ARG DEBIAN_FRONTEND=noninteractive

FROM ${IMAGE_NAME}:${IMAGE_VERSION} as base
FROM base as base-amd64

ARG IN_USERNAME=pha
ARG IN_CUDA_VERSION_NUMBER=11.7
ARG IN_UBUNTU_VERSION=2204
ARG IN_CUDNN_VERSION=8.5.0.96
ARG IN_CUDNN_PACKAGE_NAME=libcudnn8
ARG IN_TRT=8.6.1
ARG UID=${UID_VAR}
ARG GID=${GID_VAR}

ARG PROJECT_NAME=pcdet_ros2

ARG APT_GET_REQUIREMENTS_FILE=apt-get_requirements.txt
ARG PYTHON_REQUIREMENTS_FILE=python_requirements.txt
ARG SCRIPT_REQUIREMENTS_FILE=script_requirements.sh

ARG USER_REQUIREMENTS_PATH=envs/${PROJECT_NAME}/requirements
ARG IN_ROS_WS=mm_ws

ARG IN_ROS_VERSION=humble
#

# Declare Time Zone
ARG TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#

# Update and install sudo
RUN apt-get update && apt-get upgrade -y
RUN apt-get install sudo -y

# Create new user and home directory
RUN groupadd --gid $GID $IN_USERNAME \
    && useradd --uid ${UID} --gid ${GID} --create-home ${IN_USERNAME} \
    && echo ${IN_USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${IN_USERNAME} \
    && chmod 0440 /etc/sudoers.d/${IN_USERNAME} \
    && mkdir -p /home/${IN_USERNAME} \
    && chown -R ${UID}:${GID} /home/${IN_USERNAME}

USER ${IN_USERNAME}
WORKDIR "/home/${IN_USERNAME}"

## Copy Softwares
RUN mkdir -p /home/${IN_USERNAME}/${IN_ROS_WS}/src/pcdet_ros2
COPY . /home/${IN_USERNAME}/${IN_ROS_WS}/src/pcdet_ros2
RUN ["/bin/bash", "-c", "sudo chown -R ${IN_USERNAME}:${IN_USERNAME} /home/${IN_USERNAME}/${IN_ROS_WS}/src/pcdet_ros2"]
##

# End - New User

# Setup Programmes

## Setup apt-get
RUN sudo apt-get update
RUN sudo apt-get install --no-install-recommends -y checkinstall
RUN xargs sudo apt-get install --no-install-recommends -y < /home/${IN_USERNAME}/${IN_ROS_WS}/src/pcdet_ros2/${USER_REQUIREMENTS_PATH}/${APT_GET_REQUIREMENTS_FILE}
##

## Setup Python
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r /home/${IN_USERNAME}/${IN_ROS_WS}/src/pcdet_ros2/${USER_REQUIREMENTS_PATH}/${PYTHON_REQUIREMENTS_FILE}
##

# End - Setup Programmes

# Install based on scripts
RUN ["/bin/bash", "-c", "source /home/${IN_USERNAME}/.bashrc"]
RUN ["/bin/bash", "-c", "source /home/${IN_USERNAME}/${IN_ROS_WS}/src/pcdet_ros2/${USER_REQUIREMENTS_PATH}/${SCRIPT_REQUIREMENTS_FILE} ${IN_USERNAME} ${IN_ROS_WS} ${IN_ROS_VERSION} ${IN_CUDA_VERSION_NUMBER}"]
# End - Install based on scripts

# Remove Cache
RUN ["/bin/bash", "-c", "rm -rf /home/${IN_USERNAME}/.cache/*"]
#