function angular_velocity=joint_velocity(theta_max,time_flex,t)
    angular_velocity = (((30*theta_max/time_flex^3))*t.^2 - ((60*theta_max/time_flex^4))*t.^3 + ((30*theta_max/time_flex^5))*t.^4)*60;
    subplot(2,2,2),plot(t,angular_velocity);
    subplot(2,2,2),ylabel('angular velocity flex(radian/sec)');
    subplot(2,2,2),xlabel('time(sec)');

end