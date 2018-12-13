
sudo echo "KERNEL==\"ttyUSB[0-9]*\", ACTION==\"add\", ATTRS{idVendor}==\"1d6b\"," >> /etc/udev/rules.d/50-VN-100.rules
sudo echo "ATTRS{idProduct}==\"0002\", MODE=\"0666\", GROUP=\"dialout\"" >> /etc/udev/rules.d/50-VN-100.rules

sudo echo "ACTION==\"add\", SUBSYSTEM==\"usb-serial\", DRIVER==\"ftdi_sio\"," >> /etc/udev/rules.d/49-USB-LATENCY.rules
sudo echo "ATTR{latency_timer}=\"1\"" >> /etc/udev/rules.d/49-USB-LATENCY.rules

sudo udevadm control --reload-rules && sudo service udev restart && sudo udevadm trigger

