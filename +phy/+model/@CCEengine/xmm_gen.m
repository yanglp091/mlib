function xmm_gen(obj)
    %XMM_GEN Summary of this function goes here
    %   Detailed explanation goes here
%%  Building the cluster-cluster cross-membership matrix
        disp('building cluster-cluster cross-membership matrix...');
        nclusters=obj.spin_bath.cluster_info.nclusters;
%         obj.spin_bath.xmm=zeros(nclusters,nclusters);
        obj.spin_bath.xmm=sparse(nclusters,nclusters);

        one_col=ones(nclusters,1);
        for n=1:obj.spin_bath.cluster_info.nclusters
            cluster_pattern=kron(obj.spin_bath.cluster_matrix(n,:),one_col);
            cluster_credentials=sum(obj.spin_bath.cluster_matrix.*cluster_pattern,2);
            cluster_signatures=sum(obj.spin_bath.cluster_matrix,2);
            obj.spin_bath.xmm(:,n)=(cluster_credentials==cluster_signatures);
            obj.spin_bath.xmm(n,n)=0;
        end
        disp('cluster-cluster cross-membership matrix generated');

end

