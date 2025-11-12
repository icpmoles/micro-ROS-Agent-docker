. "/opt/ros/$ROS_DISTRO/setup.sh"
. "/uros_ws/install/local_setup.sh"

# if variable is not set, uses built in
if [ -z ${FASTRTPS_DEFAULT_PROFILES_FILE+x} ]; then
    if [ "$MICROROS_DISABLE_SHM" = "1" ] ; then
        if [ "$ROS_LOCALHOST_ONLY" = "1" ] ; then
            export FASTRTPS_DEFAULT_PROFILES_FILE=$COLCON_WS_PATH/dds_config/disable_fastdds_shm_localhost_only.xml
        else
            export FASTRTPS_DEFAULT_PROFILES_FILE=$COLCON_WS_PATH/dds_config/disable_fastdds_shm.xml
        fi
    fi
fi
    

echo $(env)
echo "$@"
ls -alt /dev | grep "tty"

exec ros2 run micro_ros_agent micro_ros_agent "$@"
