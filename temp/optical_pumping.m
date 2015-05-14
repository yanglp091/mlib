%% OPTICAL PUMPING
% In this script, we performe optical pumping calculations

%% STATIC HAMILTONIAN
% First of all, we create an instance of _Alkali_ class, i.e., a *Rubidium* atom.
condition=phy.condition.LabCondition();
rb=phy.system.Alkali('87Rb', condition);

%%
% The _rb_ atom has three subsystems
%
% # ground states, i.e., $^{2}S_{1/2}$
% # exicted state 1, i.e., $^{2}P_{1/2}$
% # exicted state 2, i.e., $^{2}P_{3/2}$
% 

gs=rb.sys.gs;
es1=rb.sys.es1;
es2=rb.sys.es2;

%% 
% The Hamiltonian of each subsystem is generated automatically.

gs_hami=full(gs.HilbertSpace.operators.Hamiltonian);
es1_hami=full(es1.HilbertSpace.operators.Hamiltonian);
es2_hami=full(es2.HilbertSpace.operators.Hamiltonian);

disp(gs_hami);

%% 
% Above Hamiltonians are calculated in the *uncoupled representation* with
% basis $\vert J m_J; I m_I\rangle$. Using Clebschgordan coefficients, the
% Hamiltonian can be transformed to *coupled representation* with basis
% $\vert F, m_F\rangle$. In the absence of external magnetic field, the
% Hamiltonian of alkali atom in the coupled represnetation is diagonalized.
%
%     j1=0.5; j2=1.5;
%     C=cgTable(j1, j2);
%     gs_hami_coupled=C*gs_hami*C';
% 
% The coupled Hamiltonians are automatically generated when creating the
% _rb_ instance, and can be directly accessed by

gs_coupled_hami=rb.coupled_hamiltonian('gs');
es1_coupled_hami=rb.coupled_hamiltonian('es1');
es2_coupled_hami=rb.coupled_hamiltonian('es2');
disp(gs_coupled_hami);

%%
% Electric dipole transition matrix can be calculated for both D1 and D2
% transitions. Taking D2 transition for example, the normalizaed transition probability matrix is 
row_label='';
gs_states=rb.sys.gs.representation.coupled_states;
for col_j=1:length(gs_states)
    Fg=gs_states{col_j}(1); Mg=gs_states{col_j}(2);
    row_label=[row_label, '[',mat2str(Fg),',',mat2str(Mg),'] '];
end

col_label='';
es_states=rb.sys.es2.representation.coupled_states;
for col_j=1:length(es_states)
    Fe=es_states{col_j}(1); Me=es_states{col_j}(2);
    col_label=[col_label, '[',mat2str(Fe),',',mat2str(Me),'] '];
end

mat=rb.dipole_transition_matrix('D2', 1);
mat2=mat.*mat;mat2=mat2/min(nonzeros(mat2));
printmat(mat2, 'D2', row_label, col_label);