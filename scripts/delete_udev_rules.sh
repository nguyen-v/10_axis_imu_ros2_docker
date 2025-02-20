#!/bin/bash

echo "delete remap the device serial port(ttyUSBX) to  imu"
echo "sudo rm   /etc/udev/rules.d/imu.rules"
sudo rm   /etc/udev/rules.d/imu.rules
echo " "
echo "Restarting udev"
echo ""
sudo service udev reload
sudo service udev restart
echo "finish  delete"
