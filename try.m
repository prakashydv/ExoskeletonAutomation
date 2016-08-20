loadlibrary('dynamixel', 'dynamixel.h');

libfunctions('dynamixel');

DEFAULT_PORTNUM = 3;  //COM3

DEFAULT_BAUDNUM = 1;  //1Mbps

 

calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);

 
lm;
unloadlibrary('dynamixel');
