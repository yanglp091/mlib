function new_state = state_evolution(obj, mode, t, para)
%STATE_EVOLUTION Summary of this function goes here
%   Detailed explanation goes here
if nargin==4
    m=para.m;
    tol=para.tol;
else
    m=50;
    tol=1e-7;
end

switch mode
    case 'HilbertSpace'
        try 
            init_state=obj.HilbertSpace.vectors.init;
        catch
            error('cannot find *init* state');
        end
        
        try 
            mat=obj.HilbertSpace.operators.Hamiltonian;
        catch
            error('cannot find *Hamiltonian* ');
        end
    
    case 'LiouvilleSpace'
        try 
            init_state=obj.LiouvilleSpace.vectors.init;
        catch
            error('cannot find *init* state');
        end
        
        try 
            mat=obj.LiouvilleSpace.operators.Liouvillian;
        catch
            error('cannot find *Liouvillian* ');
        end
        
    otherwise
        error('unknown mode');
end

new_state=expv(t, -1.j*mat, init_state, tol, m);
        
end

