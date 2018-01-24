% add the lcm.jar file to the matlabpath - need to only do this once
javaaddpath /usr/local/share/java/lcm.jar


% Let’s assume the logging file is lcm-l.02 in the dir below
% open log file for reading

log_file = lcm.logging.Log('/home/clay/Desktop/lcm-l.02', 'r'); 

% now read the file 
% here we are assuming that the channel we are interested in is RDI. Your channel 
% name will be different - something to do with GPS
% also RDI has fields altitude and ranges - GPS will probably have lat, lon, utmx,
% utmy etc

while true
 try
   ev = log_file.readNext();
   
   % channel name is in ev.channel
   % there may be multiple channels but in this case you are only interested in RDI channel
   if strcmp(ev.channel, 'RDI')
 
     % build rdi object from data in this record
      rdi = seabed_lcm.rdi_t(ev.data);

      % now you can do things like depending upon the rdi_t struct that was defined
      alt = rdi.altitude;
      rng = rdi.ranges;
      timestamp = rdi.utime;  % (timestamp in microseconds since the epoch)
    end
  catch err   % exception will be thrown when you hit end of file
     break;
  end
end
