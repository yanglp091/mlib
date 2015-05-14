function [ mat ] = electric_quadrupole_interaction( spin, varargin )
%ELECTRIC_QUADRUPOLE_INTERACTION Summary of this function goes here
%   Detailed explanation goes here
    transfer_matrix=[1,0,0;0,1,0;0,0,1];
    if nargin>1
        for m=1:2:nargin-2

            input=varargin{m};
            switch input
                case 'transfer_matrix'
                  transfer_matrix=varargin{m+1};
                 otherwise
                      error('no such input argument.');
            end

        end
    end
    
    denominator=4*spin.S*(2*spin.S-1);

    sx = transfer_matrix(1,1)*spin.sx+transfer_matrix(2,1)*spin.sy+transfer_matrix(3,1)*spin.sz;
    sy = transfer_matrix(1,2)*spin.sx+transfer_matrix(2,2)*spin.sy+transfer_matrix(3,2)*spin.sz;
    sz = transfer_matrix(1,3)*spin.sx+transfer_matrix(2,3)*spin.sy+transfer_matrix(3,3)*spin.sz;
    
    mat= spin.chizz*(3*sz*sz+spin.eta*(sx*sx-sy*sy))/denominator;

end