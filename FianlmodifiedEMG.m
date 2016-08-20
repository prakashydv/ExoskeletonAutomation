function smooth=FianlmodifiedEMG()
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
 C(:,3)=C(:,3)./max(C(:,3));
 C(:,4)=C(:,4)./max(C(:,4));
 C(:,5)=C(:,5)./max(C(:,5));
 
%  display('extract');
%  Extracted_EMG=extractEMG(C);

split_vector= split_peaks(C(:,1),C(:,muscle+1));
[VV,ZigZag,Z]=predict(split_vector,C(:,muscle+1));
%  VV[t1 x1 t2 x2]
VV
plot(ZigZag(1:Z,1),ZigZag(1:Z,2));
hold on
% [m,] = size(VV)
% m(1)
% l =1;
smooth=zeros(Z,2);
k=1;
t_last=0;
for i = 1:2:Z
 row = i;
% i=1;j=1;
 amp = VV(row,4) - VV(row,2);
  init_t = VV(row,1);
  mid_t = VV(row,3) ;
  fin_t = VV(row+1,3);
t=0:0.01:fin_t;
%  index_o = l;
%  l = size(t)+1;
  y=1+amp*pimf(t,[init_t mid_t mid_t fin_t]);
  [m,n]=size(y)
  init_t
  fin_t
  t=init_t:(fin_t-init_t)/n:fin_t
 
  for j= 1:2:n
      smooth(k,1)=y(1,j);
     smooth(k,2)=t(1,j);
      k=k+1;
  end
   t_last=fin_t;
  
%   plot(t,y);

% xlabel('smf, P=[init_t fin_t]');
%  for j = 1:1:m(1)+1;
%  y(j,:) = y;
%  t(j,:) = t;
end

size(C(:,1))
[m,n]=size(smooth)
plot(smooth(:,2),smooth(:,1))
end




