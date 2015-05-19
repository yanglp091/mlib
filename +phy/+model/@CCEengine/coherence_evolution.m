function cohmat = coherence_evolution( obj,para )
%COHERENCE_EVOLUTION Summary of this function goes here
%   Detailed explanation goes here
    approx=obj.spin_bath.approx;
    obj.npulse=para.npulse;
    ntime=para.ntime;
    tstep=para.tmax/(ntime-1);
    obj.timelist=0:tstep:para.tmax;
    para.time_seq=time_ratio_seq(para.npulse);
    para.central_spin=obj.central_spin;
    
    nclusters=obj.spin_bath.cluster_info.nclusters;
    cohmat=zeros(nclusters,ntime);

    %calculate cluster coherence parallelly
%             h = waitbar(0,'Calculating cluster coherence...');  %display the progress bar
    clusters=obj.spin_bath.cluster_info.clusters;
    parfor m=1:nclusters
%                 waitbar(m/obj.spin_bath.cluster_info.nclusters); %display the progress bar
        cluster=clusters{m}; 
        cohmat(m,:)=cluster_coherence(cluster,para,approx);
    end
%             close(h); %display the progress bar 
end

function coh = cluster_coherence(cluster,para,approx)
%CLUSTER_EVOLUTION e
    lf_para.central_spin=para.central_spin;%local field parameters
    %calculate the conditional cluster Hamiltonian
    lf_para.state=para.state1;
    cluster.set_bath_local_field('parameters',lf_para,'approx',approx);
    hami1=cluster.generate_hamiltonian();
%     cluster.HilbertSpace.operators.hami1=hami1;

    lf_para.state=para.state2;
    cluster.set_bath_local_field('parameters',lf_para,'approx',approx);
    hami2=cluster.generate_hamiltonian();
%     cluster.HilbertSpace.operators.hami2=hami2;
    
    tstep=para.tmax/(para.ntime-1);
    npulse=para.npulse;
    time_seq=para.time_seq;
    len_time_seq=length(time_seq);
    p_list=(1:len_time_seq)+npulse;
    parity_list=rem(p_list,2);
    
   coh_mat_list=cell(1,len_time_seq);   
    for m=1:len_time_seq %initial the core matrice
         parity=parity_list(m); 
         switch parity
                case 0
                    hami=hami1;
                case 1
                    hami=hami2;
                otherwise
                    error('wrong parity of the index of the hamiltonian sequence.');
         end
         core=expm(1i*tstep*hami*time_seq(m));
         coh_mat_list{m}=math.linear_sequence_expm(core,para.ntime-1,1);
     end
  
    
   dim=size(hami1,1);
   coh=ones(1,para.ntime);
   for n=1:para.ntime
       coh_mat=1;
       for m=1:len_time_seq
           coh_mat=coh_mat*coh_mat_list{m}{n};
       end
       coh(n)=trace(coh_mat)/dim;
   end
%    cluster.HilbertSpace.scalars.coherence=coh;    
end

function [ time_seq ] = time_ratio_seq(npulse)
%TIME_RATIO_SEQ 
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

