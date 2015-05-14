classdef Alkali < phy.system.PhysicalSystem
    % ALKALI describes the quantum mechanical behavior of an alkali atom
    %
    %     .. seealso:: :ref:`Atom` for creating an atom.
    %
    
    properties
        atom       % an instance of :ref:`Atom` class
        
        sys        % sub-systems (:ref:`AtomicHyperFineSpinSystem`) of ground states (sys.gs), D1 exicted states (sys.es1), and D2 excited states (sys.es2)
        
        spins      % spin objects, 'E' (spins.espin_gs), 'J1/2' (spins.espin_es1), 'J3/2' (spins.espin_es2), and nuclear spin (spins.nspin).

    end
    
    methods
        function obj=Alkali(name, condition)
            % Constructor, create an alkali system.
            %
            % :parameters: 
            %    * name - atom name
            %    * condition - physical conditions, e.g., magnetic fields
            % 
            % :Example:
            %
            %    >>> condition=phy.condition.LabCondition();
            %    >>> Rb87=phy.system.Alkali('87Rb', condition)
            
            alkali_atom=phy.stuff.Atom(name);
            obj=obj@phy.system.PhysicalSystem({alkali_atom});
            obj.lab_conditions=condition;
            
            obj.atom=alkali_atom;
            obj.spins.espin_gs=phy.stuff.Spin('E');
            obj.spins.espin_es1=phy.stuff.Spin('J1/2');
            obj.spins.espin_es2=phy.stuff.Spin('J3/2');
            obj.spins.nspin=phy.stuff.Spin(name);
            
            obj.generate_uncoupled_Hamiltonian(condition);
            obj.generate_coupled_Hamiltonian();
        end
        

        function generate_uncoupled_Hamiltonian(obj, condition)
            gs_spins={obj.spins.espin_gs, obj.spins.nspin};
            es1_spins={obj.spins.espin_es1, obj.spins.nspin};
            es2_spins={obj.spins.espin_es2, obj.spins.nspin};

            para.A=obj.atom.parameters.hf_gs;  para.B=0;
            obj.sys.gs =phy.system.AtomicHyperFineSpinSystem(gs_spins, para, condition);
            obj.sys.gs.generate_hamiltonian();
            obj.sys.gs.representation.uncoupled_states=states_uncoupled(0.5, obj.spins.nspin.S);

            para.A=obj.atom.parameters.hf_es1;  para.B=0;
            obj.sys.es1=phy.system.AtomicHyperFineSpinSystem(es1_spins, para, condition);
            obj.sys.es1.generate_hamiltonian();
            obj.sys.es1.representation.uncoupled_states=states_uncoupled(0.5, obj.spins.nspin.S);

            para.A=obj.atom.parameters.hf_es2A;
            para.B=obj.atom.parameters.hf_es2B;
            obj.sys.es2=phy.system.AtomicHyperFineSpinSystem(es2_spins, para, condition);
            obj.sys.es2.generate_hamiltonian();
            obj.sys.es2.representation.uncoupled_states=states_uncoupled(1.5, obj.spins.nspin.S);
        end
        
        function generate_coupled_Hamiltonian(obj)
            nucI=obj.spins.nspin.S;
            C1=cgTable(0.5, nucI);
            C2=cgTable(1.5, nucI);
            hami_gs=obj.sys.gs.HilbertSpace.operators.Hamiltonian;
            hami_es1=obj.sys.es1.HilbertSpace.operators.Hamiltonian;
            hami_es2=obj.sys.es2.HilbertSpace.operators.Hamiltonian;
            
            obj.sys.gs.HilbertSpace.operators.coupled_Hamiltonian=C1*hami_gs*C1';            
            obj.sys.es1.HilbertSpace.operators.coupled_Hamiltonian=C1*hami_es1*C1';
            obj.sys.es2.HilbertSpace.operators.coupled_Hamiltonian=C2*hami_es2*C2';
            
            obj.sys.gs.representation.coupled_states=states_coupled(0.5, obj.spins.nspin.S);
            obj.sys.es1.representation.coupled_states=states_coupled(0.5, obj.spins.nspin.S);
            obj.sys.es2.representation.coupled_states=states_coupled(1.5, obj.spins.nspin.S);
        end
        
        function hami=coupled_hamiltonian(obj, state)
            switch state
                case 'gs'
                    hami=obj.sys.gs.HilbertSpace.operators.coupled_Hamiltonian;
                case 'es1'
                    hami=obj.sys.es1.HilbertSpace.operators.coupled_Hamiltonian;
                case 'es2'
                    hami=obj.sys.es2.HilbertSpace.operators.coupled_Hamiltonian;
            end
        end
        
        function amp=transition_amplitude(obj, Je, Fg, Mg, Fe, Me, pol)
            S=0.5; II=obj.spins.nspin.S; 
            Lg=0; Le=1.0; 
            Jg=0.5; 
            
            gJg=2*Jg+1; gJe=2*Je+1;
            gFg=2*Fg+1; gFe=2*Fe+1;

            amp = (-1)^(1+Le+S+Jg+Je+II-Me) * sqrt(gJg*gJe*gFg*gFe) ...
                * w6j(Le, Je, S, Jg, Lg, 1) * w6j(Je, Fe, II, Fg, Jg, 1) ...
                * w3j(Fg, 1, Fe, Mg, pol, -Me);
        end
        
        function mat=dipole_transition_matrix(obj, trans, pol)
            gs=obj.sys.gs.representation.coupled_states;
            switch trans
                case 'D1'
                    Je=0.5;
                    es=obj.sys.es1.representation.coupled_states;
                case 'D2'
                    Je=1.5;
                    es=obj.sys.es2.representation.coupled_states;
            end
            
            dim_gs =length(gs); dim_es =length(es);
            
            mat=zeros(dim_gs, dim_es);
            for row_idx=1:dim_gs
                for col_idx=1:dim_es
                    state_i = gs{row_idx};
                    state_j = es{col_idx};
                    Fg=state_i(1); Mg=state_i(2);
                    Fe=state_j(1); Me=state_j(2);
                    mat(row_idx, col_idx) = obj.transition_amplitude(Je, Fg, Mg, Fe, Me, pol);
                end
            end
        end
    end
    
end

