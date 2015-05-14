function resort_liouvillian( obj )
%RESORT_LIOUVILLIAN Summary of this function goes here
%   Detailed explanation goes here

%%  sort the states according to the none zero numbers of the states
state_list=obj.ss.state_info.state_list;
[nr,nc]=size(state_list);
nz_list=zeros(nr,1);%none zero list of state list
for n=1:nr
    nz_list(n,1)=nnz(state_list(n,:));
end

A=[state_list,nz_list];
col_index=fliplr(1:(nc+1));
[A,cols]=sortrows(A,col_index);
rows=transpose(1:nr);
vals=ones(nr,1);
trans_mat=sparse(rows,cols,vals,nr,nr);
obj.ss.LiouvilleSpace.full_basis=A(:,1:nc);
obj.ss.LiouvilleSpace.transfer_matrix=trans_mat;
obj.ss.LiouvilleSpace.operators.Liouvillian=trans_mat*obj.ss.LiouvilleSpace.operators.Liouvillian*trans_mat';


end

