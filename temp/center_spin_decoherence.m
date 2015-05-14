clc;%clear;
tic;
%% set conditions
disp('setting conditions...');

conditions=phy.condition.LabCondition();
conditions.magnetic_field.vector=[0 0 0.2000]';
conditions.reference_frequency=2.87e9;

%% center spin
disp('creating a center spin...');
cspin=phy.stuff.Spin('E', [0 0 0]);

%% lattice parameters
disp('generating bath spins ...');

% nmax=10;
% latt_para.name='diamond';
% latt_para.idx_range=[-nmax, nmax; -nmax, nmax; -nmax, nmax];
% latt_para.abundance=0.011;
% latt_para.seed=2;
% latt_para.take=1:5;
bath_spins=phy.stuff.SpinCollection(latt_para);
bath_spins.take_sub_collection(latt_para.take);

%% Central Spin Model
disp('Creating central spin pure dephasing model...');
pr=phy.model.CentralSpin(cspin, bath_spins, conditions);

%% generate clusters
disp('generating clusters of spin-system...');
cutoff=[6,5];maxorder=5;
mode.connection='NoCentralSpin';%mode.connection='SpecialCentralSpin';
mode.cluster='Spinach';%mode.cluster='CCE'
mode.liouville.method='CentralSpin';%mode.liouville.method='PureDephasing'
mode.liouville.scope='local';
approx='ESR';

[nCluster, nState, stateList]=pr.ss.clustering(cutoff, maxorder,mode,approx);

lv_para.dim=nState; 
lv_para.basis=stateList;

%% generate system Liouvillian
fprintf('Bath dynamics assumming cspin in state 1\n');

for m=1:pr.ss.cluster_info.nclusters
    fprintf('Building local cluters Liouvillian: calculating %d-th spin cluster\n', m);
    pr.ss.cluster_info.clusters{m}.generate_hamiltonian();
    pr.ss.cluster_info.clusters{m}.generate_liouvillian(mode.liouville, lv_para);
end


fprintf('Building global  Liouvillian... \n');
mode.liouville.scope='global';
pr.ss.generate_liouvillian(mode.liouville, lv_para);
pr.ss.resort_liouvillian();
stateList=pr.ss.LiouvilleSpace.full_basis;
fprintf('Global  Liouvillian generated.\n');
%% global initial_state and observable
fprintf('Building global intial state and observable....\n');

st_para.cluster=[1,zeros(1,pr.spin_collection.nspin-1)];%[1,1]
st_para.Matrix=[0.5,0.0;0.0,0.5];%kron([1,0;0,0],[0,0;0,1]),[1,0;0,0]
initial_st=pr.ss.generate_global_vector(st_para);

obs_para.cluster=[1,zeros(1,pr.spin_collection.nspin-1)];%[1,1]
obs_para.Matrix=[0,1;0,0];%kron([1,0;0,0],[0,0;0,1])
observable=pr.ss.generate_global_vector(obs_para);
fprintf('Global intial state and observable generated.\n');
 %% pulse setting
% fprintf('Building global pulse operator...\n');
% 
% pulse_para.cluster=[1,zeros(1,pr.spin_collection.nspin-1)];
% pulse_para.operator=cell(1,pr.spin_collection.nspin);
% pulse_para.operator{1}=Sy(pr.ss.entries{1}.dim);
% pulse_para.type=pi;
% pr.ss.generate_pulse_operator(pulse_para);
% %  L_pulse=pr.ss.LiouvilleSpace.operators.pulse_operator;
% % pulse_st=expv(pi,-1i*L_pulse,pr.ss.LiouvilleSpace.vectors.initial_state);
% fprintf('The global pulse operator generated.\n');
%% time evolution 
% if 0
timelist=2*10^(-7)*(0:40);
ntime=length(timelist);
L=-1i*pr.ss.LiouvilleSpace.operators.Liouvillian;
final_states=sparse(nState,ntime);
final_states(:,1)=initial_st;
for n=2:ntime
   fprintf('Time evolution: calculating %d-th time point\n', n); 
   t=timelist(n);
   [final_states(:,n),err]=expv(t,L,initial_st);
   fprintf('The error upper limit for this final states is %d\n', err);
end
%spy(final_states);
fid=observable'*final_states;
figure();
plot(timelist,real(fid))
%  %% save output
% pr.solution=pr.ss.cluster_matrix;
% %cspin_decoherence_problem.save_solution('./decoherence.mat');
% end
toc;