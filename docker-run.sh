#!/bin/bash
docker run -t --rm \
  --device=/dev/sensors/imu \
  imu_ros2:latest \
  ros2 run imu imu_node --ros-args --param port_name:=/dev/sensors/imu
