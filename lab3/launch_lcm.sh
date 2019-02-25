#!/usr/bin/env bash
#sudo chmod 666 /dev/ttyUSB0
export CLASSPATH=$PWD/my_types.jar
#lcm-logger --auto-split-hours=1 -s ./data/lcm-log-%F-%T & 
lcm-logger -s ./log/lcm-log-%F-%T &
lcm-spy &

# GPS Driver
./gps_driver.py /dev/ttyACM0 &

# IMU Driver
./imu_driver.py /dev/ttyUSB0 115200

#./send-message.py 
kill %1 %2 %3 #%4%5%6%7%8%9