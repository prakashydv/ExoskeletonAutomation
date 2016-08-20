function [VV,ZigZag,Z] = predict(split_vector,y)
    [m,]=size(split_vector);
    ZigZag=zeros(m,3);
    VV=zeros(m,4);
    a=1;
    b=1;
    k=1;
    stat=-1;
    
    for i=1:m-1
        a=uint16(split_vector(i,3));
        b=uint16(split_vector(i+1,3));
        if(a==0 || b==0)
            break
        end
        if(y(a,1)>y(b,1))
            if(stat==0|| stat==-1)
                ZigZag(k,:)=split_vector(i,:);
                k=k+1;
            end
            display('Extension');
            stat=1;
%             E=1 F=0 init=-1
            
        else
            if(stat==1|| stat==-1)
                ZigZag(k,:)=split_vector(i,:);
                k=k+1;
            end
            display('Flexion');
            stat=0;
        end
    end
    Z=k-1;
    
    k=1;
    for i=1:Z
       
           VV(i,1)=ZigZag(i,1);
           VV(i,2)=ZigZag(i,2);
           VV(i,3)=ZigZag(i+1,1);
           VV(i,4)=ZigZag(i+1,2);
           
           
       
    
    end
    
end