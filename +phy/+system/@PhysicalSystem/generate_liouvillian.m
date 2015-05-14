function generate_liouvillian( obj )
%GENERATE_LIOUVILLIAN Summary of this function goes here
%   Detailed explanation goes here
    if ~isa(obj.LiouvilleSpace, 'math.LinearSpace')
        obj.create_LiouvilleSpace('local');
    end
    dim=obj.HilbertSpace.dim;
    hami=obj.HilbertSpace.operators.Hamiltonian;
    lv1=kron(hami, speye(dim)) - kron(speye(dim), hami).';
%     switch mode.method
%         case 'PureDephasing'
%             hami1=obj.HilbertSpace.operators.hami1;
%             hami2=obj.HilbertSpace.operators.hami2;
%             lv1=kron(hami1, speye(dim)) - kron(speye(dim), hami2).';
%         case 'CentralSpin'
%             hami=obj.HilbertSpace.operators.Hamiltonian;
%             lv1=kron(hami, speye(dim)) - kron(speye(dim), hami).';
%     end
    ts=obj.LiouvilleSpace.transfer_matrix;% the transfer matrix constituted by reshaped density matrices of cluster states
    if ~isempty(ts)
        lv=ts'*lv1*ts;
        zero_thr=1e-6;
        liouvillian=lv.*(abs(lv)>zero_thr);        
    else
        liouvillian=lv1;
    end
       
    obj.LiouvilleSpace.operators.Liouvillian=sparse(liouvillian);
end

