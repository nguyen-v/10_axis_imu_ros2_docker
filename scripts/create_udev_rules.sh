#!/bin/bash

echo "remap the device serial port(ttyUSBX) to imu"
echo "imu usb connection as /dev/imu, check it using the command : ls -l /dev|grep ttyUSB"
echo "start copy imu.rules to  /etc/udev/rules.d/"
sudo cp scripts/imu.rules  /etc/udev/rules.d
echo " "
echo "Restarting udev"
echo ""
sudo service udev reload
sudo service udev restart
echo "finish "