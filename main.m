initialisation();

counter = 1;
int32 i,y,Position,PresentPos,Moving,CommStatus,index = 1,GoalPos = [0 1023];
% PresentPos[100];

%open device
res = calllib('dynamixel','dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);

% res = dxl_initialize( DEFAULT_PORTNUM,DEFAULT_BAUDNUM );
if res == 1
    disp('Succeed to open USB2Dynamixel!');
    while (1)
        reply = input('Do you want to start your exoskeleton? Y/N [Y]: ', 's')
        if isempty(reply)%isempty(A) returns logical 1 (true) if A is an empty array and logical 0 (false) otherwise
            continue;%passes control to the next iteration of the for or while loop
        elseif (reply =='Y' || reply == 'y')
%Write goal position / input from the myogram signals in form
%of MVC
PresentPos = int32(calllib('dynamixel','dxl_read_word',ID,PRESENT_POSITION_L))
% initial_position = PresentPos;    %at time = 0sec.
% initial_speed = 0;

calllib('dynamixel','dxl_write_byte',1,MOVING_SPEED_L,250);