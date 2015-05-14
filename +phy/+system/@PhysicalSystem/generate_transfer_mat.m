function [tmat] = generate_transfer_mat(obj)
%ST2DEN_MAT Summary of this function goes here
%  %generate density matices for all the states of a given spin system or
%  cluster and then reshape these density matrices to a transfer matrix
    if ~isa(obj.LiouvilleSpace, 'math.LinearSpace')
        obj.create_LiouvilleSpace('local');
    end
    clu_st=obj.LiouvilleSpace.full_basis;
    ns=length(clu_st);% the number of the states of the cluster
    tmat=sparse(ns,ns);
    for m=1:ns
        state=clu_st(m,:);
        dm=speye(1); %densitymatrix
        for n=1:obj.nEntries
            st_clu=obj.entries{n}.IST(state(n));
%             dm=kron(dm,st_clu/sqrt(trace(st_clu*st_clu')));     
                dm=kron(dm,st_clu);
        end
%         dm=(1/sqrt(trace(dm*dm')))*dm;
        tmat(:,m)=reshape(dm.',ns,1);
    end

end


