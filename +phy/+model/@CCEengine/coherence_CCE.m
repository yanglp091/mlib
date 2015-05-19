function coherence_CCE(obj,cohmat)           

      %calculate cluster tilde coherence and totoal coherence          
    obj.coherence=struct();
    nclusters=obj.spin_bath.cluster_info.nclusters;
    ntime=length(obj.timelist);
    coh_total=ones(1,ntime);
    cceorder=1;
    startpoints=obj.spin_bath.cluster_info.cluster_number_list{obj.spin_bath.maxorder+1,2}(1,:);
    for m=1:nclusters
        cluster=obj.get_cluster(m); 
        subcluster=cluster.cluster_info.subclusters;
        nsubcluster=length(subcluster);
        cluster.HilbertSpace.scalars.coherence=cohmat(m,:);
        coh_tilde=cohmat(m,:);
        if nsubcluster==0
            cluster.HilbertSpace.scalars.coherence_tilde= coh_tilde;
        elseif nsubcluster>0
            for n=1:nsubcluster;
                coh_tilde_sub=obj.spin_bath.cluster_info.clusters{subcluster(n)}.HilbertSpace.scalars.coherence_tilde;
                coh_tilde=coh_tilde./coh_tilde_sub;
            end
            cluster.HilbertSpace.scalars.coherence_tilde=coh_tilde;
        end

        coh_total=coh_total.*coh_tilde;
        if m==startpoints(1,cceorder)
            field_name=strcat('coherence_cce_',num2str(cceorder));
            obj.coherence.(field_name)=coh_total;
            cceorder=cceorder+1;
        end

    end

    obj.coherence.('coherence')= coh_total;     
end 

