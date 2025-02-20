#!/bin/bash
# Resolve the actual device that /dev/imu points to
DEVICE=$(readlink -f /dev/imu)

if [ -z "$DEVICE" ]; then
  echo "Error: /dev/imu not found. Please ensure your udev rule is working."
  exit 1
fi

echo "10-axis ROS IMU detected device: $DEVICE"

docker run -it --rm \
  --privileged \
  --device=$DEVICE \
  imu_ros2:latest \
  ros2 run imu imu_node --ros-args --param port_name:=$DEVICE
