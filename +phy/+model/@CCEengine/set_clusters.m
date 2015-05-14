function set_clusters(obj)
%SET_CLUSTERS 
%   set_subclusters
    fprintf('Setting subclusters... \n');
    obj.xmm_gen();
    nc=obj.spin_bath.cluster_info.nclusters;
    for m=1:nc
       obj.spin_bath.cluster_info.clusters{m}.cluster_info.subclusters=find(obj.spin_bath.xmm(:,m))';
       
       obj.spin_bath.cluster_info.clusters{m}.set_lab_conditions(obj.spin_bath.lab_conditions);
       obj.spin_bath.cluster_info.clusters{m}.coord_frame_info=obj.spin_bath.coord_frame_info;
       obj.spin_bath.cluster_info.clusters{m}.principal_axes=obj.spin_bath.principal_axes;
    end
    obj.spin_bath.conmatrix=0;
    obj.spin_bath.cluster_matrix=0;
    obj.spin_bath.xmm=0;
    fprintf('Clusters setting finished. \n');

end

