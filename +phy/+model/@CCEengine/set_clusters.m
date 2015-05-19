function set_clusters(obj)
%SET_CLUSTERS 
%   set_subclusters
    fprintf('Setting subclusters... \n');
    obj.xmm_gen();
    nc=obj.spin_bath.cluster_info.nclusters;
    for m=1:nc
       cluster=obj.get_cluster(m);
       cluster.cluster_info.subclusters=find(obj.spin_bath.xmm(m,:));
       cluster.cluster_info.members=find(obj.spin_bath.cluster_matrix(m,:));
    end
    obj.spin_bath.conmatrix=0;
    obj.spin_bath.cluster_matrix=0;
    obj.spin_bath.xmm=0;
    fprintf('Clusters setting finished. \n');

end

