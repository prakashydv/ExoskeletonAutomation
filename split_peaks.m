function split_vector= split_peaks(x,y)
	MAXPEAKS=20;
    THRESHHOLD=2;
	[n,m]=size(x);
	split_vector=zeros(MAXPEAKS,3);
	up=1;
	store_vector=1;
    thrshld_up=0;
    thrshld_down=0;
    
	if(y(1,1)>y(2,1))
		up=0;
	end
	for i=1:n-1
		if store_vector >= MAXPEAKS
			break
		end
		if(y(i,1)>y(i+1,1) && up==1 && thrshld_up>THRESHHOLD)
			%peak reached
			up=0;thrshld_up=0;
			split_vector(store_vector,1)=x(i,1);
            split_vector(store_vector,2)=y(i,1);
            split_vector(store_vector,3)=i;
			store_vector=store_vector+1;
            thrshld_down=0;
		end
		if(y(i,1)<y(i+1,1) && up==0 &&thrshld_down>THRESHHOLD)
			%trough reached
			up=1;thrshld_down=0;
			split_vector(store_vector,1)=x(i,1);
    		split_vector(store_vector,2)=y(i,1);
            split_vector(store_vector,3)=i;
			store_vector=store_vector+1;
        end
        if up==0
            thrshld_down=thrshld_down+1;
        else
            thrshld_up=thrshld_up+1;
        end
			
	end

end
