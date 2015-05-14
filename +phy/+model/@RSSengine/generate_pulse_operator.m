function  generate_pulse_operator( obj,para )
%generate local or global pulse operators

    dim=obj.state_info.nstates;
    rows=zeros(1,1);
    cols=zeros(1,1);
    vals=zeros(1,1);
    pos=1;
    for n=1:obj.cluster_info.nclusters
%           fprintf('Building pulse operator: calculating %d-th spin cluster\n', n);
          cluster=para.cluster(obj.cluster_matrix(n,:));
          spin_posi=find(obj.cluster_matrix(n,:));
          dim_list=obj.cluster_info.clusters{n}.dim_list;
          rotation_operator=speye(1);
        for m=1:length(cluster)
            operator=speye(dim_list(m));
            if cluster(m)>0
                operator=para.operator{spin_posi(m)};
            end
           rotation_operator=kron(rotation_operator,operator);
        end
        dim_rotator=length(rotation_operator);
        pulse_operator=kron(rotation_operator, speye(dim_rotator)) - kron(speye(dim_rotator), rotation_operator).';
        ts=obj.cluster_info.clusters{n}.LiouvilleSpace.transfer_matrix;
        L_local=ts'*pulse_operator*ts;
        obj.cluster_info.clusters{n}.LiouvilleSpace.operators.pulse_operator=L_local;
        
        gobal_index=(obj.cluster_info.clusters{n}.global_index_of_cluster_state)';
        [row_local, col_local, val_local]=find(L_local);
        nonzeros=length(row_local);

         if nonzeros>0
            rows(pos:(pos+nonzeros-1),1)=gobal_index(row_local);
            cols(pos:(pos+nonzeros-1),1)=gobal_index(col_local);
            vals(pos:(pos+nonzeros-1),1)=val_local;
            pos=pos+nonzeros;
        end
    end
    
    element_list=[rows,cols];
    [element_list,position_list,~]=unique(element_list,'rows');

    row=element_list(:,1);
    col=element_list(:,2);
    val=vals(position_list);
    pulse_operator=sparse(row,col,val,dim,dim);
    pulse_operator=obj.LiouvilleSpace.transfer_matrix*pulse_operator*obj.LiouvilleSpace.transfer_matrix';
    obj.LiouvilleSpace.operators.pulse_operator=pulse_operator;

end

