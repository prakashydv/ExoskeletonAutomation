loadlibrary('dynamixel', 'dynamixel.h');% to load library from the set path

libfunctions('dynamixel'); % display functions in the dynamixel library

% MAX value definition.....from RX - 10 control table

    
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
global GOAL_POSITION
GOAL_POSITION = 30; % ADDRESS OF GOAL POSITION LOW BYTE 0 -->1023
global GOAL_POSITION_H
GOAL_POSITION_H = 31; % ADDRESS OF GOAL POSITION HIGH BYTE
global MOVING_SPEED
MOVING_SPEED = 32;  % 0-->1023(CAN BE SET FOR THE SPEED )for 12 volt(0-->760)
global MOVING_SPEED_H
MOVING_SPEED_H = 33;  
% max speed that can be given depends on hte voltage so at 12 volt  it is 84 RPM, to convert hex value to RPM multiply by .111When Moving Speed is set as 1 (0X001), movement is made at the minimum speed
%When Moving Speed is set as 0 (0x000), movement is made at the maximum speed
%which can be reached under the applied voltage.
global TORQUE_LIMIT
TORQUE_LIMIT = 34;% 0 --> 1023( it also depends on volt applied)
global TORQUE_LIMIT_H
TORQUE_LIMIT_H = 35;
global PRESENT_POSITION
PRESENT_POSITION = 36;
global PRESENT_POSITION_H
PRESENT_POSITION_H = 37;
global PRESENT_SPEED
PRESENT_SPEED = 38;
global PRESENT_SPEED_H
PRESENT_SPEED_H = 39;
global PRESENT_LOAD
PRESENT_LOAD = 40;% 1023 value implie the holding state because it is hte max torque
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
global COMM_RXSUCCESS
COMM_RXSUCCESS =0;

global DEFAULT_PORTNUM
DEFAULT_PORTNUM = 3;  %COM88 of my comp.nikhil notebook

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
Position=0;counter=1;
calllib('dynamixel','dxl_write_word',ID,GOAL_POSITION,Position); 
calllib('dynamixel','dxl_set_txpacket_id',ID);
calllib('dynamixel','dxl_set_txpacket_length',counter+2);
calllib('dynamixel','dxl_set_txpacket_instruction', GOAL_POSITION);


calllib('dynamixel','dxl_write_byte',ID,CW_COMPLIANCE_MARGIN,0);
calllib('dynamixel','dxl_set_txpacket_id',ID);
calllib('dynamixel','dxl_set_txpacket_length',counter+2);
calllib('dynamixel','dxl_set_txpacket_instruction', CW_COMPLIANCE_MARGIN);

calllib('dynamixel','dxl_write_byte',ID,CCW_COMPLIANCE_MARGIN,0);
calllib('dynamixel','dxl_set_txpacket_id',ID);
calllib('dynamixel','dxl_set_txpacket_length',counter+2);
calllib('dynamixel','dxl_set_txpacket_instruction', CCW_COMPLIANCE_MARGIN);

calllib('dynamixel','dxl_write_byte',ID,PUNCH_L,0);
calllib('dynamixel','dxl_set_txpacket_id',ID);
calllib('dynamixel','dxl_set_txpacket_length',counter+2);
calllib('dynamixel','dxl_set_txpacket_instruction', PUNCH_L);

%      sts='wait 2'     
pause(2);
%      sts='wait over'

int32 theta_max ;int32 time_flex ;int32 limb ;int32  exoskeleton ;
theta_max = 2*pi/3; % in radian
time_flex = 1;% in sec
limb = [1,0.15];%[1] in kg %[2] in metre
exoskeleton =[ .3,0.4];
MovingSpeed = 1000;
resolution=2;
TMAX = 1;

RT_BRACHIORAD=2;
 RT_BICEPS=1;
 RT_LAT_TRICEPS=3;
 RT_MED_TRICEPS=4;

int32 jointangle; int32 Position ;
t=1:resolution:TMAX;
x=1:resolution:TMAX;
y=sigmf(10*x,[2 4]);
xlabel('gbellmf, P=[2 4 6]')
position =1000*y;
%  t=x;
%    gravity_acceleration = 9.8;%in metreper sec square
% %    theta_ext = 120+ 180/pi*((10*theta_max/time_flex^3)*-t.^3 - ((15*theta_max/time_flex^4))*-t.^4 + ((6*theta_max/time_flex^5))*-t.^5);
%     theta_flex = 180/pi*((10*theta_max/time_flex^3)*t.^3 - ((15*theta_max/time_flex^4))*t.^4 + ((6*theta_max/time_flex^5))*t.^5);%theta trajectory for flexure motion
%     angular_acceleration = (((60*theta_max/time_flex^3))*t.^1 - ((180*theta_max/time_flex^4))*t.^2 +((120*theta_max/time_flex^5))*t.^3)*60;
%     Torque_EMG = (limb(1)*limb(2)^2*(angular_acceleration))/10;%torque in kgf.m
%     Torque_exoskeleton = ((exoskeleton(1)*exoskeleton(2)^2*angular_acceleration)/3 + ((exoskeleton(1)*gravity_acceleration*exoskeleton(2)*cos(theta_flex*(pi/180)))/2))/10;%Torque in kgf.m
%     torque = (Torque_EMG + Torque_exoskeleton);% torque in kgf.m
%     angular_velocity = (((30*theta_max/time_flex^3))*t.^2 - ((60*theta_max/time_flex^4))*t.^3 + ((30*theta_max/time_flex^5))*t.^4)*60;
% 
    x = 0:resolution:TMAX;
    z =300+200*(sin(x*2*pi).^2);
%     y =gbellmf(10*x,[2 4 5]);
    y = 200+200*sin(x*pi);
    torque = z;
%     torque=500+zeros(1,TMAX/resolution);
    speed = y;
%     position=(400/120)*theta_flex;
 k=1;
 
  ppf=zeros(1,TMAX/resolution);
  PresentSpeed=zeros(1,TMAX/resolution);
 PresentLoad=zeros(1,TMAX/resolution);
 counter=1;
 
 position=FianlmodifiedEMG();
%  RT_BICEPS);
 [TMAX,]=size(position);
 t=1:8:TMAX;
 resolution=1;
 position=position.*400;
 k=1;
%  display_current_pos=position;
%  h = plot(time_,display_current_pos,'YDataSource','display_current_pos');
display('initiate');
 for i =1:TMAX;
            Position=position(k,1)
            timee=position(k,2)
%             Torque=torque(k);
            Torque=700;
            C_Slope_CW=254;
            C_Slope_CCW=254;
%             Speed = speed(k);
            Speed=500;
            
%             display_current_pos=position.*i;
%             refreshdata(plot(display_current_pos,time_),'caller') % Evaluate y in the function workspace
%             drawnow;pause(.1)
            
            calllib('dynamixel','dxl_write_word',ID,TORQUE_LIMIT,Torque);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', TORQUE_LIMIT);
%             
            calllib('dynamixel','dxl_write_word',ID,MOVING_SPEED,Speed);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', MOVING_SPEED);
                        
            calllib('dynamixel','dxl_write_word',ID,GOAL_POSITION,Position);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter + 2);
            calllib('dynamixel','dxl_set_txpacket_instruction', GOAL_POSITION);
            
            calllib('dynamixel','dxl_write_byte',ID,CW_COMPLIANCE_SLOPE,C_Slope_CW);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter+2);
            calllib('dynamixel','dxl_set_txpacket_instruction',CW_COMPLIANCE_SLOPE);


            calllib('dynamixel','dxl_write_byte',ID,CCW_COMPLIANCE_SLOPE,C_Slope_CCW);
            calllib('dynamixel','dxl_set_txpacket_id',ID);
            calllib('dynamixel','dxl_set_txpacket_length',counter+2);
            calllib('dynamixel','dxl_set_txpacket_instruction',CCW_COMPLIANCE_SLOPE);
   %to get present position at every step to check the behaviour of the
   %trajectory traversed by the motor
            PresentPos = int32(calllib('dynamixel','dxl_read_word',ID,PRESENT_POSITION));
            ppf(k)=PresentPos;
            PresSpeed = int32(calllib('dynamixel','dxl_read_word',ID,PRESENT_SPEED));
            PresentSpeed(k)=PresSpeed;
            PresLoad = int32(calllib('dynamixel','dxl_read_word',ID,PRESENT_LOAD));
            PresentLoad(k)=PresLoad;
            k=k+8;
%             stats=(Position-PresentPos)
%             pause(0.05);
 end
stats='end motion  ... begin plotting'
[tm,tn]=size(t)
[sm,sn]=size(position)
  subplot(3,2,1),plot(t,position);
 subplot(3,2,2),plot(t,ppf);
 subplot(3,2,1),ylabel('Given Position (Flex.)');
subplot(3,2,1),xlabel('time(sec)');
subplot(3,2,2),ylabel('Feedback Position (Flex.)');
subplot(3,2,2),xlabel('time(sec)');
subplot(3,2,3),plot(t,speed);
subplot(3,2,4),plot(t,PresentSpeed);
subplot(3,2,3),ylabel('Given Speed (Flex.)');
subplot(3,2,3),xlabel('time(sec)');
subplot(3,2,4),ylabel('Feedback Speed (Flex.)');
subplot(3,2,4),xlabel('time(sec)');
subplot(3,2,5),plot(t,torque);
subplot(3,2,6),plot(t,PresentLoad);
subplot(3,2,5),ylabel('Given Torque (Flex.)');
subplot(3,2,5),xlabel('time(sec)');
subplot(3,2,6),ylabel('Feedback Torque (Flex.)');
subplot(3,2,6),xlabel('time(sec)');
% jointangle=theta_ext;


Moving = 1;
            while Moving == 1
                %Read Present position
                
                CommStatus = int32(calllib('dynamixel','dxl_get_result'));
                if CommStatus == COMM_RXSUCCESS
                    PrintErrorCode();
                else
%                     PrintCommStatus(CommStatus);
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
