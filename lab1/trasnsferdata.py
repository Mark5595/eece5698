import sys
import lcm
import csv

from my_types import gps_packet_t

def translate():
    if len(sys.argv) < 2:
        sys.stderr.write("usage: read-log <logfile>\n")
        sys.exit(1)
    
    log = lcm.EventLog(sys.argv[1], "r")
    
    with open(sys.argv[1] + ".csv", "w+") as csvfile:
    
        for event in log:
            if event.channel == "GPS Location":
                msg = gps_packet_t.decode(event.data)
                write_packet(csvfile, msg)
                print_packet(msg)

def write_packet(file_name, msg):
    writer = csv.writer(file_name, delimiter=',', quoting=csv.QUOTE_MINIMAL)
    writer.writerow([msg.timestamp, msg.lat, msg.lon, msg.alt, msg.utm_x, msg.utm_y])

def print_packet(msg):
    print("Message:")
    print("   timestamp   = %s" % str(msg.timestamp))
    print("   lat         = %s" % str(msg.lat))
    print("   lon         = %s" % str(msg.lon))
    print("   alt         = %s" % str(msg.alt))
    print("   utm_x       = %s" % str(msg.utm_x))
    print("   utm_y       = %s" % str(msg.utm_y))
    print("")

if __name__ == "__main__":
    translate()
