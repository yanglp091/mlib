classdef AtomicHyperFineSpinSystem < phy.system.SpinSystem
    % AtomicHyperFineSpinSystem describes the quantum mechanical system of
    % atom with hyperfine spin interaction.
    
    properties
        parameters  % hyperfine interaction parameters.
        representation
    end
    
    methods
        function obj=AtomicHyperFineSpinSystem(spinlist, parameters, condition)
            % Constructor, create an AtomicHyperFineSpinSystem system.
            %
            % :parameters: 
            %    * spinlist - spins
            %    * parameters - hyperfine interaction parameters
            %    * condition - physical conditions, e.g., magnetic fields
            % 
            % :Example:
            %
            %    .. code-block:: matlab
            %
            %         >>> import phy.stuff.Atom phy.stuff.Spin phy.condition.LabCondition
            %         >>> condition=LabCondition();
            %         >>> Rb=Atom('87Rb');
            %         >>> espin=Spin('E'); nspin=Spin('87Rb'); 
            %         >>> para.A=Rb.parameters.hf_gs;  para.B=0;
            %         >>> gs=phy.system.AtomicHyperFineSpinSystem({espin, nspin}, para, condition);
            


            obj=obj@phy.system.SpinSystem(spinlist);
            obj.parameters=parameters;
            obj.lab_conditions=condition;
        end
        
        function mat=subspace_interaction(obj)
            % construction interaction within given spins,
            %
            % including 
            %    * :ref:`zeeman_interaction`, 
            %    * :ref:`contact_interaction`, and
            %    * :ref:`quadrupole_interaction`.
            
            sub_idx=obj.HilbertSpace.sub_idx;
            switch length(sub_idx)
                case 1
                    spin=obj.entries{sub_idx};
                    B0=obj.lab_conditions.magnetic_field.vector;
                    B=B0+spin.local_field;
                    [~, mat]=phy.interaction.spin_interaction.zeeman_interaction(spin, B);                                        
                    
                case 2
                    [spin1, spin2]=obj.entries{sub_idx};
                    [~, matA]=phy.interaction.spin_interaction.contact_interaction(spin1, spin2, obj.parameters.A);
                    [~, matB]=phy.interaction.spin_interaction.quadrupole_interaction(spin1, spin2, obj.parameters.B);
                    mat=matA+matB;
            end
        end
    end
    
end

