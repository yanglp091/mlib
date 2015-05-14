classdef DipolarSpinSystem < phy.system.SpinSystem
    %DIPOLARSPINSYSTEM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        function obj=DipolarSpinSystem(spinlist)
            obj=obj@phy.system.SpinSystem(spinlist);
        end
                
        %interaction matrix between entries{i} and entries{j}:
        %magic matrix is returned
        function mat=subspace_interaction(obj)
            sub_idx=obj.HilbertSpace.sub_idx;
            approx=obj.approx;
            switch length(sub_idx)
                case 1
                    spin=obj.entries{sub_idx};
                    if strcmp(spin.name,'E')
                        if strcmp(approx,'ESR')||strcmp(approx,'SzSz')
                            B0=[0,0,0]';
                        else
                            B0=obj.lab_conditions.magnetic_field.vector;    
                        end
                    else
                        B0=obj.lab_conditions.magnetic_field.vector;
                    end
                    B=B0+spin.local_field;%obj.principal_axes*B0
                    [~, mat1]=phy.interaction.spin_interaction.zeeman_interaction(spin, B,'transfer_matrix',obj.principal_axes);
                    if spin.S>0.5
                        mat2=phy.interaction.spin_interaction.electric_quadrupole_interaction(spin,'transfer_matrix',obj.principal_axes);
                    else
                        mat2=zeros(spin.dim);                        
                    end
                    mat=mat1+mat2;
                    
                case 2
                    [spin1, spin2]=obj.entries{sub_idx};
                    [~, mat]=phy.interaction.spin_interaction.dipolar_interaction(spin1, spin2,'approx',approx,'transfer_matrix',obj.principal_axes);                    
            end
        end

    end

    
end

