IN_USERNAME=$1
IN_ROS_WS=$2
IN_ROS_VERSION=$3
IN_CUDA_VERSION_NUMBER=$4
IN_USERNAME="${IN_USERNAME:=pcdet}"
IN_ROS_WS="${IN_ROS_WS:=mm_ws}"
IN_ROS_VERSION="${IN_ROS_VERSION:=humble}"
IN_CUDA_VERSION_NUMBER="${IN_CUDA_VERSION_NUMBER:=11.7}"

IN_CUDA_VERSION=cuda-${IN_CUDA_VERSION_NUMBER}

# Setup Display
echo -e "\n# Setup" >> /home/${IN_USERNAME}/.bashrc
echo "export USER=${IN_USERNAME}" >> /home/${IN_USERNAME}/.bashrc
source /home/${IN_USERNAME}/.bashrc

# CUDA Paths
echo "source /home/${IN_USERNAME}/${IN_ROS_WS}/src/pcdet_ros2/modules/scripts/secondary/cuda_paths.sh ${IN_CUDA_VERSION}" >> /home/${IN_USERNAME}/.bashrc 

# Setup PCDet Paths
PCDET_ROOT=/home/${IN_USERNAME}/${IN_ROS_WS}/src/pcdet_ros2/modules/submodules/OpenPCDet
echo "export PCDET_ROOT=${PCDET_ROOT}" >> /home/${IN_USERNAME}/.bashrc
echo "export PYTHONPATH=$PYTHONPATH:${PCDET_ROOT}:${PCDET_ROOT}/venv/lib/python3.10/site-packages/" >> /home/${IN_USERNAME}/.bashrc

# Install ROS
sudo apt-get install software-properties-common -y
sudo add-apt-repository universe -y

sudo apt-get update && sudo apt-get install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt-get update
sudo apt-get upgrade -y

if [ "${IN_ROS_VERSION}" == "foxy" ]; then
    sudo apt-get install ros-$IN_ROS_VERSION-ros-base ros-$IN_ROS_VERSION-rviz ros-$IN_ROS_VERSION-rqt -y
else
    sudo apt-get install ros-$IN_ROS_VERSION-desktop -y
fi

sudo apt-get install ros-dev-tools ros-humble-ament-cmake-nose -y

sudo apt-get install python3-colcon-common-extensions -y

echo -e "\n# ROS 2" >> /home/${IN_USERNAME}/.bashrc
echo "source /opt/ros/$IN_ROS_VERSION/setup.bash" >> /home/${IN_USERNAME}/.bashrc
source /opt/ros/$IN_ROS_VERSION/setup.bash

cd /home/${IN_USERNAME}/${IN_ROS_WS}

python3 -m virtualenv -p python3 ./venv
touch ./venv/COLCON_IGNORE

sudo rosdep init
rosdep update

rosdep install -y --from-paths src --ignore-src --rosdistro $IN_ROS_VERSION # $ROS_DISTRO
colcon build --symlink-install
echo "source /home/${IN_USERNAME}/${IN_ROS_WS}/install/setup.bash" >> /home/${IN_USERNAME}/.bashrc

echo -e "\n# Colon" >> /home/${IN_USERNAME}/.bashrc
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> /home/${IN_USERNAME}/.bashrc
echo "export _colcon_cd_root=/opt/ros/$IN_ROS_VERSION/" >> /home/${IN_USERNAME}/.bashrc
echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> /home/${IN_USERNAME}/.bashrc

echo -e "\n# Venv" >> /home/${IN_USERNAME}/.bashrc
echo "source /home/${IN_USERNAME}/${IN_ROS_WS}/venv/bin/activate" >> /home/${IN_USERNAME}/.bashrc
source /home/${IN_USERNAME}/.bashrc
source /home/${IN_USERNAME}/${IN_ROS_WS}/venv/bin/activate

# Install OpenPCDet
python3 -m pip install -r /home/${IN_USERNAME}/${IN_ROS_WS}/src/pcdet_ros2/modules/requirements/python_venv_requirements.txt
cd /home/${IN_USERNAME}/${IN_ROS_WS}/src/pcdet_ros2/modules/submodules/OpenPCDet
python3 setup.py develop

cd /home/${IN_USERNAME}