#!/usr/bin/env python
# -*- coding: utf-8 -*-
# for BU-353s4 GPS Sensor

import sys
import lcm
import time
import serial
import utm
from my_types import gps_packet_t


class Gps(object):
    def __init__(self, port_name):
        self.port = serial.Serial(port_name, 4800, timeout=1.)  # 4800-N-8-1
        self.lcm = lcm.LCM("udpm://?ttl=12")
        self.packet = gps_packet_t()
        print 'Gps: Initialization'
        line = self.port.readline()
        try:
            vals = [float(x) for x in line.split(' ')]
        except:
            vals = 0

    def readloop(self):
        while True:
            line = self.port.readline()
            try:
                vals = [x for x in line.split(',')]
                if vals[0] == "$GPGGA":
                    print "Received Message..." + line
                    self.packet_from_response(vals)
                    self.print_packet(self.packet)
                    self.lcm.publish("GPS Location", self.packet.encode())
            except Exception as e:
                print 'Gps ERROR (' + line + ')'
                print e 
                print
    
    def packet_from_response(self, vals):
        """
        Creates a gps_packet_t from a serial line response. 
        """
        def _extract_float(value):
            if value == "":
                return 0.0
            else:
                return float(value)
        
        self.packet.timestamp = _extract_float(vals[1])
        self.packet.lat = _extract_float(vals[2])
        self.packet.lon = _extract_float(vals[4])
        self.packet.alt = _extract_float(vals[9])
        
        if vals[3] == 'S':
            self.packet.lat = -self.packet.lat;
        if vals[5] == 'W':
            self.packet.lon = -self.packet.lon;

        try:
            utm_repr = utm.from_latlon(
                    _coord_to_decimal(self.packet.lat), 
                    _coord_to_decimal(self.packet.lon))
            self.packet.utm_x = utm_repr[0]
            self.packet.utm_y = utm_repr[1]
        except Exception as e: 
            print "Error trying to convert to utm: " + str(e)
            print "Lat: " + str(self.packet.lat)
            print "Lon: " + str(self.packet.lon)
        
    def print_packet(self, packet):
        print "GPS Packet:"
        print "***************"
        print "timestamp: " + str(packet.timestamp)
        print "lat: " + str(packet.lat)
        print "lon: " + str(packet.lon)
        print "alt: " + str(packet.alt)
        print "utm_x: " + str(packet.utm_x)
        print "utm_y: " + str(packet.utm_y)
        print "***************"
        print ""

def _coord_to_decimal(coord):
    degrees = coord//100
    decimal = (coord % 100)/60
    return degrees + decimal

if __name__ == "__main__":
    if len(sys.argv) == 1:
        myGps = Gps("/dev/ttyUSB0")
    elif len(sys.argv) != 2:
        print "Usage: %s <serial_port>\n" % sys.argv[0]
        sys.exit(0)
    else:
        myGps = Gps(sys.argv[1])
    
    myGps.readloop()
