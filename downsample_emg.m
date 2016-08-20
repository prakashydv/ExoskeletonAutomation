function [EMG_down]= downsample_emg(EMG_component,window_size)
[m,n]=size(EMG_component);
length_emg=m;
index=floor(length_emg/window_size);
EMG_down=zeros(index,n);
for i=0:index-1
start_index=(i*window_size)+1;
end_index=(i+1)*window_size;
EMG_extract=EMG_component(start_index:end_index,:);
EMG_down(i+1,:)=mean(EMG_extract);
end