function [dip, mat] = dipolar_interaction( spin1, spin2, varargin)
%DIPOLAR_INTERACTOIN Summary of this function goes here
%   Detailed explanation goes here
    approx = 'None';
    transfer_matrix=[1,0,0;0,1,0;0,0,1];
    if nargin>2
        for m=1:2:nargin-3
            
            input=varargin{m};
            switch input
                case 'approx'
                  approx =varargin{m+1};
                case 'transfer_matrix'
                  transfer_matrix=varargin{m+1};
                 otherwise
                      error('no such input argument.');
            end
            
        end
   end
     

    coord1=spin1.coordinate; gamma1=spin1.gamma;name1=spin1.name;
    coord2=spin2.coordinate; gamma2=spin2.gamma;name2=spin2.name;

    vect=coord2-coord1;
    distance=norm(vect);
    ort=vect/distance;

    % dipolar interaction strength
    A=hbar*mu0*gamma1*gamma2...
        /(4*pi*(distance*1e-10)^3);

    % the dipolar coupling matrix
    dip=A*...
        [1-3*ort(1)*ort(1)   -3*ort(1)*ort(2)   -3*ort(1)*ort(3);
        -3*ort(2)*ort(1)  1-3*ort(2)*ort(2)   -3*ort(2)*ort(3);
        -3*ort(3)*ort(1)   -3*ort(3)*ort(2)  1-3*ort(3)*ort(3)];
    dip=transfer_matrix*dip*transfer_matrix';

    switch approx
        case 'ESR'
            if strcmp(name1,'E')||strcmp(name2,'E')
                mat= dip(3,1)*kron(spin1.sz,spin2.sx)...
                    +dip(3,2)*kron(spin1.sz,spin2.sy)...
                    +dip(3,3)*kron(spin1.sz,spin2.sz);
            else
                mat= dip(1,1)*kron(spin1.sx,spin2.sx)...
                +dip(1,2)*kron(spin1.sx,spin2.sy)...
                +dip(1,3)*kron(spin1.sx,spin2.sz)...
                +dip(2,1)*kron(spin1.sy,spin2.sx)...
                +dip(2,2)*kron(spin1.sy,spin2.sy)...
                +dip(2,3)*kron(spin1.sy,spin2.sz)...
                +dip(3,1)*kron(spin1.sz,spin2.sx)...
                +dip(3,2)*kron(spin1.sz,spin2.sy)...
                +dip(3,3)*kron(spin1.sz,spin2.sz);
            end
        case 'SzSz'
            if strcmp(name1,'E')||strcmp(name2,'E')
                mat= dip(3,3)*kron(spin1.sz,spin2.sz);
            else
                mat=sparse(spin1.dim*spin2.dim,spin1.dim*spin2.dim);
            end
        otherwise
            mat= dip(1,1)*kron(spin1.sx,spin2.sx)...
                +dip(1,2)*kron(spin1.sx,spin2.sy)...
                +dip(1,3)*kron(spin1.sx,spin2.sz)...
                +dip(2,1)*kron(spin1.sy,spin2.sx)...
                +dip(2,2)*kron(spin1.sy,spin2.sy)...
                +dip(2,3)*kron(spin1.sy,spin2.sz)...
                +dip(3,1)*kron(spin1.sz,spin2.sx)...
                +dip(3,2)*kron(spin1.sz,spin2.sy)...
                +dip(3,3)*kron(spin1.sz,spin2.sz);
    end

end

