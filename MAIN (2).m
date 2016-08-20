muscle=2;
% FILE *ftr;
vars=5;
maxRows=50000;
window_size=100;
%weightage to different muscles
w1=1;w2=1;w3=1;w4=1;

fid=fopen('data/normal_45.dat','r');
A=zeros(maxRows,vars);
i=0;j=0;

display('[1]reading data');
A=fscanf(fid,'%f',[vars maxRows]);
A=A';

% display('Low pass filtering');
% FilteredSeries = FilterObj.filter(A);

[m,]=size(A);
maxRows=m;
fclose(fid);
 display('[2]rectification');   
 A=abs(A);

 
 %downsampling
%  sampling_n=100;
%  sampling_phase=1;
 
% C=zeros(ceil(maxRows/sampling_n),vars);
%   C(:,1)=downsample(A(:,1),sampling_n,sampling_phase);
%   C(:,2)=downsample(A(:,2),sampling_n,sampling_phase);
%   C(:,3)=downsample(A(:,3),sampling_n,sampling_phase);
%   C(:,4)=downsample(A(:,4),sampling_n,sampling_phase);
%   C(:,5)=downsample(A(:,5),sampling_n,sampling_phase);

[m,n]=size(A);
C=zeros(floor(m/window_size),vars);
 C(:,1)=downsample_emg(A(:,1),window_size);
 C(:,2)=downsample_emg(A(:,2),window_size);
 C(:,3)=downsample_emg(A(:,3),window_size);
 C(:,4)=downsample_emg(A(:,4),window_size);
 C(:,5)=downsample_emg(A(:,5),window_size);

 
 display('[3]normalize');

 C(:,2)=C(:,2)./max(C(:,2));
 C(:,3)=C(:,3)./max(C(:,3))
 C(:,4)=C(:,4)./max(C(:,4));
 C(:,5)=C(:,5)./max(C(:,5));
 
%  display('extract');
%  Extracted_EMG=extractEMG(C);

split_vector= split_peaks(C(:,1),C(:,muscle+1))
 predict(split_vector,C(:,muscle+1));
 plot(split_vector(:,2),split_vector(:,1));
 

 
 display('[4]plot graphs');
% subplot(3,2,1),plot(C(:,1),C(:,2),'r')
% subplot(3,2,1),ylabel('RT BICEPS BR.,uV');
% subplot(3,2,1),xlabel('time');
% subplot(3,2,2),plot(C(:,1),C(:,3),'b')
% subplot(3,2,2),ylabel('RT BRACHIORAD.,uV');
% subplot(3,2,2),xlabel('time');
% subplot(3,2,3),plot(C(:,1),C(:,4),'g')
% subplot(3,2,3),ylabel('RT LAT. TRICEPS,uV');
% subplot(3,2,3),xlabel('time');
% subplot(3,2,4),plot(C(:,1),C(:,5),'cyan')
% subplot(3,2,4),ylabel('RT MED. TRICEPS,uV');
% subplot(3,2,4),xlabel('time');
% subplot(3,2,5),plot(C(:,1),C(:,2),'r',C(:,1),C(:,3),'b',C(:,1),C(:,4),'g',C(:,1),C(:,5),'cyan')
% subplot(3,2,5),xlabel('time');
% subplot(3,2,5),ylabel('Combined EMG (uV)');
% 
% subplot(3,2,6),plot(C(:,1),(w4*C(:,5)+w3*C(:,4)+w2*C(:,3)+w1*C(:,2))/(w1+w2+w3+w4),'black')
% subplot(3,2,6),ylabel('weighted mean (uV)');
% subplot(3,2,6),xlabel('time');
[m,n]=size(C(:,1));
% size(C(1:m-1,1))
% 
% C_diff=diff((w4*C(:,5)+w3*C(:,4)+w2*C(:,3)+w1*C(:,2))/(w1+w2+w3+w4))./diff(C(:,1));
% subplot(3,2,6),plot(C(1:m-1,1),C_diff,'black',C(:,1),(w4*C(:,5)+w3*C(:,4)+w2*C(:,3)+w1*C(:,2))/(w1+w2+w3+w4),'r');
% subplot(3,2,6),ylabel('weighted mean (red),Diff (black)');
% subplot(3,2,6),xlabel('time');

subplot(3,2,1),plot(C(1:10,1),C(1:10,muscle),'r')
subplot(3,2,1),ylabel('RT BICEPS BR.,uV');
subplot(3,2,1),xlabel('time');
subplot(3,2,2),plot(C(10:20,1),C(10:20,muscle),'b')
subplot(3,2,2),ylabel('RT BRACHIORAD.,uV');
subplot(3,2,2),xlabel('time');
subplot(3,2,3),plot(C(20:30,1),C(20:30,muscle),'g')
subplot(3,2,3),ylabel('RT LAT. TRICEPS,uV');
subplot(3,2,3),xlabel('time');
subplot(3,2,4),plot(C(30:40,1),C(30:40,muscle),'cyan')
subplot(3,2,4),ylabel('RT MED. TRICEPS,uV');
subplot(3,2,4),xlabel('time');
subplot(3,2,5),plot(C(40:50,1),C(40:50,muscle),'cyan')
subplot(3,2,5),xlabel('time');
subplot(3,2,5),ylabel('Combined EMG (uV)');



subplot(3,2,6),plot(C(50:60,1),C(50:60,muscle));
subplot(3,2,6),ylabel('weighted mean (red),Diff (black)');
subplot(3,2,6),xlabel('time');

