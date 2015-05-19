function xmm_gen(obj)
    %XMM_GEN Summary of this function goes here
    %   Detailed explanation goes here
%%  Building the cluster-cluster cross-membership matrix
        disp('building cluster-cluster cross-membership matrix...');
        nclusters=obj.spin_bath.cluster_info.nclusters;
        num_list=obj.spin_bath.cluster_info.cluster_number_list{end,2};%the end point of every order
        maxorder=obj.spin_bath.maxorder;
        if maxorder==1
            return;
        end
             
%         xmm=spalloc(nclusters,nclusters,nclusters*obj.spin_bath.maxorder);
        row=ones((maxorder-1)*nclusters,1);
        col=ones((maxorder-1)*nclusters,1);
        val=zeros((maxorder-1)*nclusters,1);
        cluster_signatures=sum(obj.spin_bath.cluster_matrix,2);
        pos=0;
        for cceorder=2:maxorder
            pos1=num_list(cceorder-1);%the index of the last cluster of the last order
            pos2=num_list(cceorder);%the index of the last cluster of the current order         
            for n=(pos1+1):pos2
                one_col=ones(pos1,1);
                cluster_pattern=kron(obj.spin_bath.cluster_matrix(n,:),one_col);
                cluster_credentials=sum(obj.spin_bath.cluster_matrix(1:pos1,:).*cluster_pattern,2);
                cluster_sign=cluster_signatures(1:pos1,1);               
                cols2add=find(cluster_credentials==cluster_sign);% the column index of the subclusters
                n_sub_clu=length(cols2add);
                rows2add=n*ones(n_sub_clu,1);
                vals2add=ones(n_sub_clu,1);
                row(pos+1:(pos+n_sub_clu),1)=rows2add;
                col(pos+1:(pos+n_sub_clu),1)=cols2add;
                val(pos+1:(pos+n_sub_clu),1)=vals2add;
                pos=pos+n_sub_clu;
            end
            
        end
        obj.spin_bath.xmm=sparse(row,col,val,nclusters,nclusters);
        disp('cluster-cluster cross-membership matrix generated');

end

