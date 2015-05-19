function [ coh_tilde ] = cluster_coherence_tilde(obj,cluster_index,para,approx )
%CLUSTER_COHERENCE_TILDE 
%   Calculate the tilde coherence of a given cluster
    cluster=obj.get_cluster(cluster_index); 
    subclusters=cluster.cluster_info.subclusters;
    len_subclus=size(subclusters,2);
    coh=obj.cluster_coherence(cluster_index,para,approx);
    if  len_subclus==0
        coh_tilde=coh;
    elseif len_subclus>0 
         coh_tilde=coh;
         for m=1:len_subclus
            sub_cluster_idx=subclusters(m);
            cluster=obj.get_cluster(sub_cluster_idx);
            coh_tilde_sub=obj.cluster_coherence_tilde(cluster,para,approx);
            coh_tilde=coh_tilde./coh_tilde_sub;
        end
    end
end

