function set_clusters(obj)
%SET_CLUSTERS 
%   set_subclusters
    fprintf('Setting clusters... \n');
    obj.statelist_gen();%
    obj.xmm_gen();
    nc=obj.ss.cluster_info.nclusters;
    for m=1:nc
       obj.ss.cluster_info.clusters{m}.state_info.global_index_of_cluster_state=find(obj.ss.xmm(:,m))';
          %generate the transfer matrix for a given matrix
       obj.ss.cluster_info.clusters{m}.LiouvilleSpace.transfer_matrix=obj.ss.cluster_info.clusters{m}.generate_transfer_mat();
       
    end
    fprintf('Clusters setting finished. \n');

end

