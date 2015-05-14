function set_cluster_lab_condition(obj,conditions)
    obj.conditions=conditions;
    obj.spin_bath.set_lab_conditions(conditions);             
    obj.spin_bath.coord_frame_info=get_coord_frame_info(obj);
    obj.spin_bath.principal_axes=obj.spin_bath.coord_frame_info.mf_frame.coordinate_basis;
    nc=obj.spin_bath.cluster_info.nclusters;
    for m=1:nc       
       obj.spin_bath.cluster_info.clusters{m}.set_lab_conditions(obj.spin_bath.lab_conditions);
       obj.spin_bath.cluster_info.clusters{m}.coord_frame_info=obj.spin_bath.coord_frame_info;
       obj.spin_bath.cluster_info.clusters{m}.principal_axes=obj.spin_bath.principal_axes;
    end
end