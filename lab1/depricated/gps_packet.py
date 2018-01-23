
import datetime

class gps_packet(object):

    def __init__(self, time, lat, lon, altitude):
        """
        Initializes a gps_packet
        """
        self.time = datetime.datetime.fromtimestamp(time)
        self.lat = lat
        self.lon = lon
        self.alt = altitude
    
    def __repr__(self):
        """
        Returns the string representation of the gps_packet
        """
        this_string = str(self.time) + " Latitude: %d, Longitude %d, Altitude %d " \
            % (self.lat, self.lon, self.alt)
        return this_string
        
    @classmethod
    def from_gps_response(cls, parsed_response): 
        """
        Creates a gps_packet from a parsed data packet from the gps module
        """
        time = parsed_response[1]
        lat = parsed_response[2]
        lat_dir = parsed_response[3]
        lon = parsed_response[4]
        lon_dir = parsed_response[5]
        alt = parsed_response[9]

        return cls(time, lat, lon, alt)
