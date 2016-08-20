function jointangle=joint_angle(theta_max,time_flex,t)
    theta_flex = 180/pi*((10*theta_max/time_flex^3)*t.^3 - ((15*theta_max/time_flex^4))*t.^4 + ((6*theta_max/time_flex^5))*t.^5);%theta trajectory for flexure motion
    theta_ext = (120-((10*theta_max)/time_flex^3)*(t).^3 + ((15*theta_max/time_flex^4))*(t).^4 - ((6*theta_max/time_flex^5))*(t).^5);%theta trajectory for extension motion
    jointangle=theta_flex+theta_ext;
    
    subplot(2,2,1),plot(t,theta_flex);
    subplot(2,2,1),ylabel('thetaflexure(degree)');
    subplot(2,2,1),xlabel('time(sec)');
end