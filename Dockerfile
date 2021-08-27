FROM nvidia/cudagl:10.0-devel-ubuntu16.04
MAINTAINER minchang <tjdalsckd@gmail.com>
RUN apt-get update &&  apt-get install -y -qq --no-install-recommends \
    libgl1 \
    libxext6 \ 
    libx11-6 \
   && rm -rf /var/lib/apt/lists/*

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute


RUN echo 'export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}' >> ~/.bashrc
RUN echo 'export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
RUN echo 'export PATH=/usr/local/cuda/bin:/$PATH' >> ~/.bashrc
RUN echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt-get install -y wget
RUN apt-get install -y sudo curl
RUN su root
RUN apt-get install -y python
RUN apt-get update && apt-get install -y lsb-release && apt-get clean all
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -
RUN apt-get update 
RUN sudo apt-get install -y ros-kinetic-desktop-full
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash"

RUN sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
RUN sudo rosdep init
RUN rosdep update

RUN /bin/bash -c 'source /opt/ros/kinetic/setup.bash; mkdir -p ~/catkin_ws/src; cd ~/catkin_ws; catkin_make'
RUN mkdir -p ~/libraries;
RUN apt-get install -y libssl-dev ; 
RUN cd /root/libraries;git clone https://github.com/casadi/casadi.git;cd casadi; mkdir build; cd build; cmake .. ;make -j16;make install
RUN mkdir -p /root/workspace; cd /root/workspace; git clone https://github.com/tjdalsckd/casadi_cpp.git;
RUN echo 'cd /root/workspace' > /root/.bashrc
