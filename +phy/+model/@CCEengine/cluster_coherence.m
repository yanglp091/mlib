function coh = cluster_coherence(obj,cluster_index,para,approx)
%CLUSTER_EVOLUTION e
     cluster=obj.get_cluster(cluster_index); 
     lf_para.central_spin=obj.central_spin;%local field parameters
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
    time_seq=obj.time_ratio_seq(npulse);
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

