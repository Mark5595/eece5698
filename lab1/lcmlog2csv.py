import sys
import lcm
import csv
import gps_driver
import utm

from my_types import gps_packet_t

def translate(reader_conversion):
    if len(sys.argv) < 2:
        sys.stderr.write("usage: read-log <logfile>\n")
        sys.exit(1)
    
    log = lcm.EventLog(sys.argv[1], "r")
    
    with open(sys.argv[1] + ".csv", "w+") as csvfile:
    
        for event in log:
            if event.channel == "GPS Location":
                msg = gps_packet_t.decode(event.data)

                if reader_conversion:
                    write_packet_w_utm_conversion(csvfile, msg)
                else:
                    write_packet(csvfile, msg)

                print_packet(msg)

def write_packet(file_name, msg):
    writer = csv.writer(file_name, delimiter=',', quoting=csv.QUOTE_MINIMAL)
    writer.writerow([msg.timestamp, msg.lat, msg.lon, msg.alt, msg.utm_x, msg.utm_y])

def write_packet_w_utm_conversion(file_name, msg):
    print "writing w/ conversion"
    utm_repr = coord_to_utm(msg.lat, -msg.lon)
    
    msg.utm_x = utm_repr[0];
    msg.utm_y = utm_repr[1];

    writer = csv.writer(file_name, delimiter=',', quoting=csv.QUOTE_MINIMAL)
    writer.writerow([msg.timestamp, msg.lat, msg.lon, msg.alt, utm_repr[0], utm_repr[1]])

def coord_to_utm(lat, lon):
    utm_repr = utm.from_latlon(
        gps_driver._coord_to_decimal(lat),
        gps_driver._coord_to_decimal(lon))
            
    return utm_repr[0], utm_repr[1]

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
    #translate(1)
    translate(0)
