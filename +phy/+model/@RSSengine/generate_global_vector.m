function [global_vector]=generate_global_vector(obj, para)

    dim=obj.ss.LiouvilleSpace.dim;
    if isstruct(para)
            %para.cluster is a vector like a row in cluster_matrix
            %para.den_mat is the density matrix of the spins in para.cluster
            dim_list=obj.ss.dim_list;
            nstates=prod(dim_list(logical(para.cluster)))^2;%dimension of the central spin
            basis=spalloc(nstates,obj.ss.nEntries,nstates*nnz(para.cluster));
            spins_involved=find(para.cluster);
            cluster_size=length(spins_involved);
            if cluster_size==0
                     operator_vec=zeros(dim,1);
                     operator_vec(1,1)=1;
            elseif cluster_size>0
                    for k=1:cluster_size

                        if k==1
                            A=1;
                        else
                            A=ones(prod(dim_list(spins_involved(1:(k-1))))^2,1);
                        end

                        if k==cluster_size
                            B=1;
                        else
                            B=ones(prod(dim_list(spins_involved((k+1):end)))^2,1);
                        end

                        basis(:,spins_involved(k))=kron(kron(A,(0:(dim_list(spins_involved(k))^2-1))'),B);
                    end

                    operator_vec=zeros(dim,1);

                    for n=1:nstates
                        posi=ismember(obj.ss.LiouvilleSpace.full_basis,basis(n,:),'rows');%find the global indexes of states in basis
                        posi=find(posi);

                        %calculate the expansion coefficient of the initial state on the nth basis
                        if length(posi)==1
                            state=basis(n,:);
                            dm=speye(1);
                            for m=spins_involved
                                st_clu=obj.ss.entries{m}.IST(state(m));
                                dm=kron(dm,st_clu);
                            end
                            expand_coeff=trace(dm'*para.Matrix);
                            operator_vec(posi,1)=expand_coeff;
                        end
                    end
             end
            
            global_vector=operator_vec;
            
    
    elseif iscolumn(para)&&length(para)==dim
        global_vector=para;
    end


























