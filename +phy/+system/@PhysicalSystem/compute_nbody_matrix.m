function [ row, col, val ] = compute_nbody_matrix( obj, n )
%COMPUTE_NBODY_MATRIX Summary of this function goes here
%   Detailed explanation goes here
assert(n<=obj.nEntries,'not enough physical objects. n=%d > nEntries=%d',...
    n, obj.nEntries);

obj_list=combnk(1:obj.nEntries, n);
[n_combine,~]=size(obj_list);

row=[]; col=[]; val=[];
for m=1:n_combine
    selected_objs=obj_list(m,:);
    obj.HilbertSpace.create_subspace(selected_objs);

    dimSub=obj.HilbertSpace.subspace.dim;
    dimQuot=obj.HilbertSpace.quotspace.dim;
    
    sub_in_full_table=zeros(dimSub,dimQuot);
    
    for j=1:dimSub
        sub_in_full_table(j,:)=obj.HilbertSpace.locate_sub_basis(j);
    end

    mat=obj.subspace_interaction();
    
    for j=1:dimSub
        for k=1:dimSub
            row=[row sub_in_full_table(j,:)]; %#ok<*AGROW>
            col=[col sub_in_full_table(k,:)];
            val=[val mat(j,k)*ones(1,dimQuot)];
        end
    end
    
end


end

