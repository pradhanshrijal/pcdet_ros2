IN_USERNAME=$1
IN_SSI_PATH=$2
IN_ROS_VERSION=$3
IN_CUDA_VERSION_NUMBER=$4
IN_USERNAME="${IN_USERNAME:=pha}"
IN_SSI_PATH="${IN_SSI_PATH:=/home/${IN_USERNAME}/docker_share}"
IN_ROS_VERSION="${IN_ROS_VERSION:=humble}"
IN_CUDA_VERSION_NUMBER="${IN_CUDA_VERSION_NUMBER:=11.7}"

IN_CUDA_VERSION=cuda-${IN_CUDA_VERSION_NUMBER}

# Setup Display
echo -e "\n# Setup" >> /home/${IN_USERNAME}/.bashrc
echo "export USER=${IN_USERNAME}" >> /home/${IN_USERNAME}/.bashrc
echo "source ${IN_SSI_PATH}/scripts/setup/term_disp.sh" >> /home/${IN_USERNAME}/.bashrc

# Setup Source Paths
echo "source ${IN_SSI_PATH}/scripts/setup/export_docker_paths.sh" >> /home/${IN_USERNAME}/.bashrc

# CUDA Paths
echo "source ${IN_SSI_PATH}/scripts/setup/cuda_paths.sh ${IN_CUDA_VERSION}" >> /home/${IN_USERNAME}/.bashrc 

# Setup PCDet Paths
echo "source ${IN_SSI_PATH}/git_pkgs/ros_pkgs/mm_ws/src/pcdet_ros2/modules/scripts/export_docker_pcdet.sh" >> /home/${IN_USERNAME}/.bashrc

# Install ROS
source ${IN_SSI_PATH}/scripts/install/install_ros.sh ${IN_USERNAME} ${IN_ROS_VERSION}

source ${IN_SSI_PATH}/git_pkgs/ros_pkgs/mm_ws/src/pcdet_ros2/modules/scripts/install_pcdet_pha.sh ${IN_USERNAME} ${IN_SSI_PATH} ${IN_ROS_VERSION}

# Source pcdet_ros2
echo "source ${IN_SSI_PATH}/git_pkgs/ros_pkgs/mm_ws/install/setup.bash" >> /home/${IN_USERNAME}/.bashrc