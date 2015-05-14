 function  hami=generate_hamiltonian( obj, max_nbody )
%GENERATE_HAMILTONIAN Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2
        max_nbody = min(2, obj.nEntries);
    end

    if ~isa(obj.HilbertSpace, 'math.ProductLinearSpace')
        obj.create_HilbertSpace();
    end

    space=obj.HilbertSpace;
    hamiltonian = sparse(space.dim, space.dim);

    for n=1:max_nbody
        [row, col, val] = obj.compute_nbody_matrix(n);
        nbody_hami = sparse(row, col, val);
        hamiltonian = hamiltonian + nbody_hami;
    end

    hami=sparse(hamiltonian);
%     obj.HilbertSpace.operators.Hamiltonian=hami;

end

