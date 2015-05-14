classdef LatticeStructure
    %LATTICESTRUCTURE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods (Static)
        function latt = get_lattice_structure(name)
            switch char(name)
                case 'diamond'
                    cubic_length=3.57;%angstrom
                    latt.num_basis=3;
                    latt.const=cubic_length*ones(1,3);
                    latt.bas=eye(3);
                    
                    latt.num_shift=8;
                    latt.atoms={'13C', '13C', '13C', '13C'...
                                '13C', '13C', '13C', '13C'};
                    latt.shift=cubic_length*...
                        [0,     0,     0;   ...
                         1./4   1./4,  1./4;...
                         2./4,  2./4,  0;   ...
                         3./4,  3./4,  1./4;...
                         2./4,  0,     2./4;...
                         0,     2./4,  2./4;...
                         3./4,  1./4,  3./4;...
                         1./4,  3./4,  3./4];
                    
                case '4H-SiC'
                    
                    
                    
                case 'BN' %single layer
                    latt.iner_layer_shift=1.45;%angstrom
                    latt.inter_layer_shift=3.34;
                    parallelogram_length=sqrt(3)*1.45;
                    latt.num_basis=3;
                    latt.const=2*[parallelogram_length, parallelogram_length, latt.inter_layer_shift];
                    latt.bas=[1,0,0;0.5,0.5*sqrt(3),0;0,0,1];
                    latt.num_shift=16;
                    latt.atoms={'11B', '11B', '11B','11B',...
                        '14N', '14N', '14N', '14N',...
                        '11B', '11B', '11B', '11B',...
                        '14N', '14N', '14N', '14N'};
                    shift1=parallelogram_length*[0,0,0; 1,0,0;  0.5,0.5*sqrt(3),0; 1.5,0.5*sqrt(3),0;];
                    shift2=latt.iner_layer_shift*[0,1,0; 0,1,0; 0,1,0; 0,1,0]+shift1;
                    shift3=latt.inter_layer_shift*[0,0,1;0,0,1;0,0,1; 0,0,1]+shift2;
                    shift4=latt.inter_layer_shift*[0,0,1;0,0,1;0,0,1; 0,0,1]+shift1;
                    latt.shift=[shift1;shift2;shift3;shift4];                    
                 %
                otherwise
                    error('lattice structure does not implemented.');
            end
        end
    end
    
end

