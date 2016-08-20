function Torque_net = joint_torque(theta_max,time_flex,limb,exoskeleton,t)

    %limb/exoskeleton tuple [mass, length ]
    gravity_acceleration = 9.8;%in metreper sec square
    theta_flex = 180/pi*((10*theta_max/time_flex^3)*t.^3 - ((15*theta_max/time_flex^4))*t.^4 + ((6*theta_max/time_flex^5))*t.^5);%theta trajectory for flexure motion
    angular_acceleration = (((60*theta_max/time_flex^3))*t.^1 - ((180*theta_max/time_flex^4))*t.^2 +((120*theta_max/time_flex^5))*t.^3)*60;
    Torque_EMG = (limb(1)*limb(2)^2*(angular_acceleration))/10;%torque in kgf.m
    Torque_exoskeleton = ((exoskeleton(1)*exoskeleton(2)^2*angular_acceleration)/3 + ((exoskeleton(1)*gravity_acceleration*exoskeleton(2)*cos(theta_flex*(pi/180)))/2))/10;%Torque in kgf.m

    Torque_net = (Torque_EMG + Torque_exoskeleton);% torque in kgf.m

    subplot(2,2,4),plot(t,Torque_net);
    subplot(2,2,3),plot(t,Torque_EMG);
    
    subplot(2,2,3),ylabel('Torque EMG flex(//kgf.m)');
    subplot(2,2,3),xlabel('time//(sec)');
end