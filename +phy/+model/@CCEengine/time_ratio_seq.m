function [ time_seq ] = time_ratio_seq(obj,npulse)
%TIME_RATIO_SEQ 
    obj.npulse=npulse;
    if npulse==0
        time_seq=[1,-1];
    elseif npulse>0
        nsegment=npulse+1;
        step=1/npulse/2;
        seq=zeros(1,nsegment);
        for n=1:nsegment
            if n==1
                seq(1,n)=step;
            elseif n==nsegment
                seq(1,n)=step;
            else
                seq(1,n)=2*step;
            end
        end
        time_seq=[seq,-1*seq];
    end     
end

