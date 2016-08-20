loadlibrary('dynamixel', 'dynamixel.h');% to load library from the set path

libfunctions('dynamixel'); % display functions in the dynamixel library

% MAX value definition.....from RX - 10 control table
%ADDRESS VALUES TO BE GIVEN INPUT TO FUNCTIONS AS PARAMETERS..

global ID
ID = 1;% id of dynamixel
global RETURN_DELAY_TIME
RETURN_DELAY_TIME = 5;% Time taken b/w transmission packet and status packet
global CW_ANGLE_LIMIT_L
CW_ANGLE_LIMIT_L = 6; % allowed range for RX -10 is 0 --> 1023
global CW_ANGLE_LIMIT_H
CW_ANGLE_LIMIT_H = 7; % ......DO ....
global CCW_ANGLE_LIMIT_L
CCW_ANGLE_LIMIT_L = 8; % ....do ...
global CCW_ANGLE_LIMIT_H
CCW_ANGLE_LIMIT_H = 9; %...do....
global HIGHEST_LIMIT_TEMPERATURE
HIGHEST_LIMIT_TEMPERATURE = 11; % 10 --> 99,default - 80;
global HIGHEST_LIMIT_VOLTAGE
HIGHEST_LIMIT_VOLTAGE = 13; % range 50 --> 250 (data value 10 times actual value)
global MAX_TORQUE_L
MAX_TORQUE_L = 14;  % range 0 --> 1023
global MAX_TORQUE_H
MAX_TORQUE_H = 15; % ...do ....
global STATUS_RETURN_LEVEL
STATUS_RETURN_LEVEL = 16;%
global ALARM_LED
ALARM_LED = 17; % flickers when eror bit is set for 2 sec...
global ALARM_SHUTDOWN
ALARM_SHUTDOWN = 18;% sets torque zero when error occurs,
%to get out of shut down - reset value into the torque limit
global TORQUE_ENABLE
TORQUE_ENABLE = 24;%default value is zero, set '1' then torque is generated.
global LED
LED = 25;% set 1 on ..
global CW_COMPLIANCE_MARGIN
CW_COMPLIANCE_MARGIN = 26;%for smooth motion,shock absorption, range 0-->254,
% B VALUE
global CCW_COMPLIANCE_MARGIN
CCW_COMPLIANCE_MARGIN = 27;% C VALUE
global CW_COMPLIANCE_SLOPE
CW_COMPLIANCE_SLOPE = 28;% RAnge 1 --> 254(A VALUE)
global CCW_COMPLIANCE_SLOPE
CCW_COMPLIANCE_SLOPE = 29; % D VALUE (RX -10 MANUAL)
global GOAL_POSITION_L
GOAL_POSITION_L = 30; % ADDRESS OF GOAL POSITION LOW BYTE 0 -->1023
global GOAL_POSITION_H
GOAL_POSITION_H = 31; % ADDRESS OF GOAL POSITION HIGH BYTE
global MOVING_SPEED_L
MOVING_SPEED_L = 32;  % 0-->1023(CAN BE SET FOR THE SPEED )for 12 volt(0-->760)
global MOVING_SPEED_H
MOVING_SPEED_H = 33;  
% max speed that can be given depends on hte voltage so at 12 volt  it is 84 RPM, to convert hex value to RPM multiply by .111When Moving Speed is set as 1 (0X001), movement is made at the minimum speed
%When Moving Speed is set as 0 (0x000), movement is made at the maximum speed
%which can be reached under the applied voltage.
global TORQUE_LIMIT_L
TORQUE_LIMIT_L = 34;% 0 --> 1023( it also depends on volt applied)
global TORQUE_LIMIT_H
TORQUE_LIMIT_H = 35;
global PRESENT_POSITION_L
PRESENT_POSITION_L = 36;
global PRESENT_POSITION_H
PRESENT_POSITION_H = 37;
global PRESENT_SPEED_L
PRESENT_SPEED_L = 38;
global PRESENT_SPEED_H
PRESENT_SPEED_H = 39;
global PRESENT_LOAD_L
PRESENT_LOAD_L = 40;% 1023 value implie the holding state because it is hte max torque
global PRESENT_LOAD_H
PRESENT_LOAD_H = 41;
global PRESENT_VOLTAGE
PRESENT_VOLTAGE = 42;% value 10 times actual voltage
global PRESENT_TEMPERATURE
PRESENT_TEMPERATURE = 43;% data value = temp in celcius
global REGISTERED_INSTRUCTION
REGISTERED_INSTRUCTION = 44;% MEANS IF inst is regeistered
global MOVING
MOVING = 46;% set as '1' when moving,set as '0' when goal reached
global PUNCH_L
PUNCH_L = 48;% E value of compliance.(0 --> 1023)
global PUNCH_H
PUNCH_H = 49;
COMM_RXSUCCESS =0;

global DEFAULT_PORTNUM
DEFAULT_PORTNUM = 88;  %COM88 of my comp.nikhil notebook

global DEFAULT_BAUDNUM
DEFAULT_BAUDNUM = 1;%1Mbps

global COMM_RXSUCCESS
COMM_RXSUCCESS     = 1;

global SET
SET = 1;



res = calllib('dynamixel','dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);


if res == 1
    disp('Succeed to open USB2Dynamixel!');
    while (1)
        reply = input('Do you want to start your exoskeleton? Y/N [Y]: ', 's');
        if isempty(reply)%isempty(A) returns logical 1 (true) if A is an empty array and logical 0 (false) otherwise
            continue;%passes control to the next iteration of the for or while loop
        elseif (reply =='Y' || reply == 'y')
%Write goal position / input from the myogram signals in form
%of MVC
PresentPos = int32(calllib('dynamixel','dxl_read_word',ID,PRESENT_POSITION_L));
% initial_position = PresentPos;    %at time = 0sec.
% initial_speed = 0;

calllib('dynamixel','dxl_write_byte',1,MOVING_SPEED_L,250);




counter=1;
int32 theta_max ;int32 time_flex ;int32 limb ;int32  exoskeleton ;
theta_max = 2*pi/3; % in radian
time_flex = 1;% in sec
limb = [1,0.15];%[1] in kg %[2] in metre
exoskeleton =[ .3,0.4];
MovingSpeed = 1000;
%%%%%%Bell shaped curve positioning with variable torque%%%%%%%%55
%  t = 0 : 0.1 : 1;
 int32 jointangle; int32 Position ;
 
 t =0:0.01:1;
% y= 700*gbellmf(i,[6 3 12]);
% plot(i,y);
 

theta_flex =(10/3)*180/pi*((10*theta_max/time_flex^3)*t.^3 - ((15*theta_max/time_flex^4))*t.^4 + ((6*theta_max/time_flex^5))*t.^5);%theta trajectory for flexure motion
theta_ext =400+ (10/3)*(180)/pi*((10*theta_max/time_flex^3)*-t.^3 - ((15*theta_max/time_flex^4))*-t.^4 + ((6*theta_max/time_flex^5))*-t.^5);

jointangle=theta_flex;
y=jointangle;
position = y;
  subplot(3,2,1),plot(t,y);
   gravity_acceleration = 9.8;%in metreper sec square
  angular_acceleration = (((60*theta_max/time_flex^3))*t.^1 - ((180*theta_max/time_flex^4))*t.^2 +((120*theta_max/time_flex^5))*t.^3)*60;
    Torque_EMG = (limb(1)*limb(2)^2*(angular_acceleration))/10;%torque in kgf.m
    Torque_exoskeleton = ((exoskeleton(1)*exoskeleton(2)^2*angular_acceleration)/3 + ((exoskeleton(1)*gravity_acceleration*exoskeleton(2)*cos(theta_flex*(pi/180)))/2))/10;%Torque in kgf.m
    torque = (Torque_EMG + Torque_exoskeleton);% torque in kgf.m
    torque=(torque+3)*100;
 k=1;
 ppf=y;
 for i =0:0.01:1;
            Position=position(k);
            Torque=torque(k);
            calllib('dynamixel','dxl_write_byte',ID,TORQUE_ENABLE,SET);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', TORQUE_ENABLE);
        
            calllib('dynamixel','dxl_write_word',ID,TORQUE_LIMIT_L,Torque);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', TORQUE_LIMIT_L);
            
            calllib('dynamixel','dxl_write_word',ID,MOVING_SPEED_L,MovingSpeed);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', MOVING_SPEED_L);
            

            
            calllib('dynamixel','dxl_write_word',ID,GOAL_POSITION_L,Position);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', GOAL_POSITION_L);
            
            calllib('dynamixel','dxl_write_byte',ID,GOAL_POSITION_H,Position);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', GOAL_POSITION_H);
   %to get present position at every step to check the behaviour of the
   %trajectory traversed by the motor
            PPlowbyte = int32(calllib('dynamixel','dxl_read_byte',ID,PRESENT_POSITION_L));
            PPhighbyte = int32(calllib('dynamixel','dxl_read_byte',ID,PRESENT_POSITION_H));
            PresentPos = int32(calllib('dynamixel', 'dxl_makeword',PPlowbyte,PPhighbyte));
            ppf(k)=PresentPos;
            k=k+1;
 end
 torque
 position
 ppf
  subplot(3,2,3),plot(t,position);
 subplot(3,2,4),plot(t,ppf);
jointangle=theta_ext;
y=jointangle;
position = y;
 subplot(3,2,2),plot(t,y)
% [m,n]=size(y);
k=1;
pause(1);
ppe=y;
 for i =0:0.01:1;
            Position=position(k);
            Torque=torque(k);
            calllib('dynamixel','dxl_write_byte',ID,TORQUE_ENABLE,SET);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', TORQUE_ENABLE);
        
            calllib('dynamixel','dxl_write_word',ID,TORQUE_LIMIT_L,Torque);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', TORQUE_LIMIT_L);
            

            
            calllib('dynamixel','dxl_write_word',ID,GOAL_POSITION_L,Position);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', GOAL_POSITION_L);
            
            calllib('dynamixel','dxl_write_byte',ID,GOAL_POSITION_H,Position);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', GOAL_POSITION_H);
   %to get present position at every step to check the behaviour of the
   %trajectory traversed by the motor
            PPlowbyte = int32(calllib('dynamixel','dxl_read_byte',ID,PRESENT_POSITION_L));
            PPhighbyte = int32(calllib('dynamixel','dxl_read_byte',ID,PRESENT_POSITION_H));
            PresentPos = int32(calllib('dynamixel', 'dxl_makeword',PPlowbyte,PPhighbyte));
            ppe(k)=PresentPos;
            k=k+1;
            
 end
 torque
position
 ppe
 subplot(3,2,5),plot(t,position);
 subplot(3,2,6),plot(t,ppe);
  Moving = 1;
            while Moving == 1
                %Read Present position
                
                CommStatus = int32(calllib('dynamixel','dxl_get_result'));
                if CommStatus == COMM_RXSUCCESS
                    Position ;
%                     disp(Position);
                    PrintErrorCode();
                else
                    PrintCommStatus(CommStatus);
                    break;
                end
                
                %Check moving done
                Moving = int32(calllib('dynamixel','dxl_read_byte',ID,MOVING));
                CommStatus = int32(calllib('dynamixel','dxl_get_result'));
%                 disp('hi');
                if CommStatus == COMM_RXSUCCESS
                    PrintErrorCode();
                else
                    PrintCommStatus(CommStatus);
                    break;
                    
                end
            end

            
        elseif(reply =='n' || reply=='N')
            break;
        end
    end
else
    disp('Failed to open USB2Dynamixel!');
end

%Close Device
calllib('dynamixel','dxl_terminate');
unloadlibrary('dynamixel');
