FROM ros:jazzy AS micro-ros-agent-builder

ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /uros_ws
RUN . /opt/ros/$ROS_DISTRO/setup.sh \
&&  git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_msgs src/micro_ros_msgs \
&&  git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro-ROS-Agent src/micro-ROS-Agent \
&&  colcon build \
&&  rm -rf log/ build/ src/

FROM ros:jazzy-ros-core

ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=ros2 
ENV COLCON_WS_PATH=/home/$USERNAME/tesi/mostro

COPY --from=micro-ros-agent-builder /uros_ws /uros_ws

WORKDIR /uros_ws

# Disable shared memory
COPY ./dds_config $COLCON_WS_PATH/dds_config

ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
#ENV MICROROS_DISABLE_SHM=1
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-ros2trace \
    ros-${ROS_DISTRO}-tracetools-launch \
    ros-${ROS_DISTRO}-performance-test && \
    rm -rf /var/lib/apt/lists/*


RUN echo ". /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo ". /uros_ws/install/setup.bash" >> ~/.bashrc

WORKDIR $COLCON_WS_PATH
# setup entrypoint
COPY ./scripts_ws $COLCON_WS_PATH/scripts_ws

ENTRYPOINT ["/bin/sh","./scripts_ws/micro-ros_entrypoint.sh"]
CMD ["--help"]