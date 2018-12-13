#!/usr/bin/env python
# -*- coding: utf-8 -*-
# for BU-353s4 GPS Sensor

import sys
import time
import serial

# Logging Stuff
import mylogger
import logging

import lcm
from my_types import imu_packet_t 


class Imu(object):
    """
    Represents an IMU connected over a serial port
    """
    def __init__(self, port_name, baud):
        """
        Creates an IMU object. 
        Takes the port and baud rate of the serial port. 
        """

        self.port = serial.Serial(port_name, baud, timeout=1.)
        self.lcm = lcm.LCM("udpm://?ttl=12")
        self.packet = imu_packet_t()
        
        logging.info('Imu: Initialization on port {} at {} baud'.format(
            port_name, baud))
        
        line = self.port.readline()
        
        # Nuke the first line? 
        try:
            vals = [float(x) for x in line.split(' ')]
        except:
            vals = 0

    def readloop(self):
        """
        Loops infinitely, reading from the serial connection. Creates and publishes
        the packets to an imu channel. 
        """
        while True:
            line = self.port.readline()
            try:
                vals = [x for x in line.split(',')]
                if vals[0] == "$VNYMR":
                    print "Received Message..." + line
                    self.packet_from_response(vals)
                    self.print_packet(self.packet)
                    self.lcm.publish("Imu Reading", self.packet.encode())
            except Exception as e:
                logging.error('IMU ERROR (' + line + ') \n' + str(e))
    
    def packet_from_response(self, vals):
        """
        Creates a imu_packet_t from a serial line response. 
        """
        def _extract_float(value):
            if value == "":
                return 0.0
            if "*" in value:
                return float(value.split("*")[0])
            else:
                return float(value)
        
        self.packet.yaw         = _extract_float(vals[1])
        self.packet.pitch       = _extract_float(vals[2])
        self.packet.roll        = _extract_float(vals[3])
        self.packet.mag_x       = _extract_float(vals[4])
        self.packet.mag_y       = _extract_float(vals[5])
        self.packet.mag_z       = _extract_float(vals[6])
        self.packet.accel_x     = _extract_float(vals[7])
        self.packet.accel_y     = _extract_float(vals[8])
        self.packet.accel_z     = _extract_float(vals[9])
        self.packet.gyro_x      = _extract_float(vals[10])
        self.packet.gyro_y      = _extract_float(vals[11])
        self.packet.gyro_z      = _extract_float(vals[12])
        
        
    def print_packet(self, packet):
        print "IMU Packet:"
        print "***************"
        print "timestamp: " + str(packet.timestamp)
        print "yaw: " + str(packet.yaw)
        print "pitch: " + str(packet.pitch)
        print "roll: " + str(packet.roll)
        print "mag_x: " + str(packet.mag_x)
        print "mag_y: " + str(packet.mag_y)
        print "mag_z: " + str(packet.mag_z)
        print "accel_x: " + str(packet.accel_x)
        print "accel_y: " + str(packet.accel_y)
        print "accel_z: " + str(packet.accel_z)
        print "gyro_x: " + str(packet.gyro_x)
        print "gyro_y: " + str(packet.gyro_y)
        print "gyro_z: " + str(packet.gyro_z)
        print "***************"
        print ""

if __name__ == "__main__":
    if len(sys.argv) == 1:
        myImu = Imu("/dev/ttyUSB0", 115200)
    elif len(sys.argv) == 2:
        myImu = Imu(sys.argv[0], 115200)
    elif len(sys.argv) == 3:
        myImu = Imu(sys.argv[1], sys.argv[2])
    else:
        print "Usage: %s <serial_port>\n" % sys.argv[0]
        sys.exit(0)
    
    myImu.readloop()
