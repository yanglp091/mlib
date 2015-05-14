function statelist_gen(obj)
% Generates state list. For each state generates cluster membership list.
%% Building state lists 
disp('statelist_gen: building state lists...');
%nspins=size(obj.dim_list,2);
nspins=obj.ss.nEntries;
cluster_state_list=cell(1, obj.ss.cluster_info.nclusters);
%% generate the states cluster by cluster
for n=1:obj.ss.cluster_info.nclusters
    nstates=prod(obj.ss.dim_list(obj.ss.cluster_matrix(n,:)))^2;
    %obj.cluster(n).state_list=spalloc(nstates,nspins,nstates*nnz(obj.cluster_matrix(n,:)));
    cluster_state_list{n}=spalloc(nstates,nspins,nstates*nnz(obj.ss.cluster_matrix(n,:)));
    spins_involved=find(obj.ss.cluster_matrix(n,:));
    cluster_size=length(spins_involved);
    for k=1:cluster_size
 
        if k==1
            A=1;
        else
            A=ones(prod(obj.ss.dim_list(spins_involved(1:(k-1))))^2,1);
        end

        if k==cluster_size
            B=1;
        else
            B=ones(prod(obj.ss.dim_list(spins_involved((k+1):end)))^2,1);
        end
        
        %obj.cluster(n).state_list(:,spins_involved(k))=kron(kron(A,(0:(obj.dim_list(spins_involved(k))^2-1))'),B);
        cluster_state_list{n}(:,spins_involved(k))=kron(kron(A,(0:(obj.ss.dim_list(spins_involved(k))^2-1))'),B);
        
    end
end

state_list=unique(vertcat(cluster_state_list{1:end}),'rows');%remove the same states
obj.ss.state_info.state_list=sortrows(state_list);
%%
obj.ss.state_info.nstates=size(state_list,1);
disp(['statelist_gen: ' num2str(obj.ss.state_info.nstates) ' states generated.']);
end

