import sys
import lcm
import csv
import gps_driver
import imu_driver

from my_types import gps_packet_t
from my_types import imu_packet_t

def translate():
    if len(sys.argv) < 2:
        sys.stderr.write("usage: read-log <logfile>\n")
        sys.exit(1)
    
    log = lcm.EventLog(sys.argv[1], "r")
    
    for event in log:
        if event.channel == "GPS Location":
            with open("log/gps_location.csv", "a+") as csvfile:
                msg = gps_packet_t.decode(event.data)
                write_gps_packet(csvfile, msg)
                print_gps_packet(msg)
        
        elif event.channel == "Imu Reading":
            with open("log/imu_reading.csv", "a+") as csvfile:
                msg = imu_packet_t.decode(event.data)
                write_imu_packet(csvfile, msg)
                print_imu_packet(msg)

def write_imu_packet(file_name, msg):
    writer = csv.writer(file_name, delimiter=',', quoting=csv.QUOTE_MINIMAL)
    writer.writerow(
            [msg.timestamp, 
             msg.yaw, 
             msg.pitch, 
             msg.roll, 
             msg.mag_x, 
             msg.mag_y,
             msg.mag_z,
             msg.accel_x, 
             msg.accel_y,
             msg.accel_z,
             msg.gyro_x, 
             msg.gyro_y,
             msg.gyro_z])

def write_gps_packet(file_name, msg):
    writer = csv.writer(file_name, delimiter=',', quoting=csv.QUOTE_MINIMAL)
    writer.writerow([msg.timestamp, msg.lat, msg.lon, msg.alt, msg.utm_x, msg.utm_y])


def print_imu_packet(msg):
    print("IMU Packet:")
    print("   timestamp     = %s" % str(msg.timestamp))
    print("   yaw           = %s" % str(msg.yaw))
    print("   pitch         = %s" % str(msg.pitch))
    print("   roll          = %s" % str(msg.roll))
    print("   mag_x         = %s" % str(msg.mag_x))
    print("   mag_y         = %s" % str(msg.mag_y))
    print("   mag_z         = %s" % str(msg.mag_z))
    print("   accel_x       = %s" % str(msg.accel_x))
    print("   accel_y       = %s" % str(msg.accel_y))
    print("   accel_z       = %s" % str(msg.accel_z))
    print("   gyro_x        = %s" % str(msg.gyro_x))
    print("   gyro_y        = %s" % str(msg.gyro_y))
    print("   gyro_z        = %s" % str(msg.gyro_z))
    print("")

def print_gps_packet(msg):
    print("GPS Packet:")
    print("   timestamp   = %s" % str(msg.timestamp))
    print("   lat         = %s" % str(msg.lat))
    print("   lon         = %s" % str(msg.lon))
    print("   alt         = %s" % str(msg.alt))
    print("   utm_x       = %s" % str(msg.utm_x))
    print("   utm_y       = %s" % str(msg.utm_y))
    print("")

if __name__ == "__main__":
    translate()
