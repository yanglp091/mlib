function generate_global_liouvillian( obj, para )
%GENERATE_LIOUVILLIAN Summary of this function goes here
%   Detailed explanation goes here
    if ~isa(obj.ss.LiouvilleSpace, 'math.LinearSpace')
        obj.ss.create_LiouvilleSpace('global', para);
    end
    
    fprintf('Building global  Liouvillian... \n');    
    dim=obj.ss.state_info.nstates;
    rows=zeros(1,1);
    cols=zeros(1,1);
    vals=zeros(1,1);
    pos=1;
    for n=1:obj.ss.cluster_info.nclusters        
         L_local=obj.ss.cluster_info.clusters{n}.LiouvilleSpace.operators.Liouvillian;
         gobal_index=(obj.ss.cluster_info.clusters{n}.state_info.global_index_of_cluster_state)';
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
    liouvillian=sparse(row,col,val,dim,dim);
    obj.ss.LiouvilleSpace.operators.Liouvillian=sparse(liouvillian);
    fprintf('Global  Liouvillian generated.\n');   
end

