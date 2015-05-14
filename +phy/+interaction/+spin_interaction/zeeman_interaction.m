function [zeeman, mat] = zeeman_interaction( spin, Bvect, varargin)
%ZEEMAN_INTERACTION Summary of this function goes here
%   Detailed explanation goes here
    transfer_matrix=[1,0,0;0,1,0;0,0,1];
    if nargin>2
        for m=1:2:nargin-3

            input=varargin{m};
            switch input
                case 'transfer_matrix'
                  transfer_matrix=varargin{m+1};
                 otherwise
                      error('no such input argument.');
            end

        end
    end
   gamma=spin.gamma;
   zeeman=-gamma*transfer_matrix*Bvect;

   mat= zeeman(1)*spin.sx...
        +zeeman(2)*spin.sy...
        +zeeman(3)*spin.sz;

end

