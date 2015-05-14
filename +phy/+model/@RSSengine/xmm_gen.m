function xmm_gen(obj)
    %XMM_GEN Summary of this function goes here
    %   Detailed explanation goes here

%% Building the state-cluster cross-membership matrix nstate-by-ncluster
    disp('building state-cluster cross-membership matrix...');
    obj.ss.xmm=zeros(obj.ss.state_info.nstates,obj.ss.cluster_info.nclusters);

    one_col=ones(obj.ss.state_info.nstates,1);
    for n=1:obj.ss.cluster_info.nclusters
        cluster_pattern=kron(obj.ss.cluster_matrix(n,:),one_col);
        state_credentials=sum(obj.ss.state_info.state_list.*cluster_pattern,2);
        state_signatures=sum(obj.ss.state_info.state_list,2);
        obj.ss.xmm(:,n)=(state_credentials==state_signatures);
    end

    obj.ss.state_info.state_belongs_to=cell(1, obj.ss.cluster_info.nclusters);
    for n=1:obj.ss.state_info.nstates
        obj.ss.state_info.state_belongs_to{n}=find(obj.ss.xmm(n,:));
    end
    disp('state-cluster cross-membership matrix generated');


