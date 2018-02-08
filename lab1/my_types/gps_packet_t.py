"""LCM type definitions
This file automatically generated by lcm.
DO NOT MODIFY BY HAND!!!!
"""

try:
    import cStringIO.StringIO as BytesIO
except ImportError:
    from io import BytesIO
import struct

class gps_packet_t(object):
    __slots__ = ["timestamp", "lat", "lon", "alt", "utm_x", "utm_y"]

    def __init__(self):
        self.timestamp = 0.0
        self.lat = 0.0
        self.lon = 0.0
        self.alt = 0.0
        self.utm_x = 0.0
        self.utm_y = 0.0

    def encode(self):
        buf = BytesIO()
        buf.write(gps_packet_t._get_packed_fingerprint())
        self._encode_one(buf)
        return buf.getvalue()

    def _encode_one(self, buf):
        buf.write(struct.pack(">ffffff", self.timestamp, self.lat, self.lon, self.alt, self.utm_x, self.utm_y))

    def decode(data):
        if hasattr(data, 'read'):
            buf = data
        else:
            buf = BytesIO(data)
        if buf.read(8) != gps_packet_t._get_packed_fingerprint():
            raise ValueError("Decode error")
        return gps_packet_t._decode_one(buf)
    decode = staticmethod(decode)

    def _decode_one(buf):
        self = gps_packet_t()
        self.timestamp, self.lat, self.lon, self.alt, self.utm_x, self.utm_y = struct.unpack(">ffffff", buf.read(24))
        return self
    _decode_one = staticmethod(_decode_one)

    _hash = None
    def _get_hash_recursive(parents):
        if gps_packet_t in parents: return 0
        tmphash = (0xa30f84a9c2cb5440) & 0xffffffffffffffff
        tmphash  = (((tmphash<<1)&0xffffffffffffffff)  + (tmphash>>63)) & 0xffffffffffffffff
        return tmphash
    _get_hash_recursive = staticmethod(_get_hash_recursive)
    _packed_fingerprint = None

    def _get_packed_fingerprint():
        if gps_packet_t._packed_fingerprint is None:
            gps_packet_t._packed_fingerprint = struct.pack(">Q", gps_packet_t._get_hash_recursive([]))
        return gps_packet_t._packed_fingerprint
    _get_packed_fingerprint = staticmethod(_get_packed_fingerprint)
