export LCM_DEFAULT_URL=udpm://239.255.76.67:7667?ttl=1
sudo ifconfig wlp3s0 multicast
sudo route add -net 224.0.0.0 netmask 240.0.0.0 dev wlp3s0
