clear;
clc;
tic;
%% set conditions
fprintf('setting conditions...\n');

conditions=phy.condition.LabCondition();
conditions.magnetic_field.vector=[0 0 1e-2]';
conditions.reference_frequency=2.87e9;

%% center spin
disp('creating a center spin...');
cspin=phy.stuff.Spin('E', [0 0 0]);

%% lattice parameters
disp('generating bath spins ...');

nmax=10;
latt_para.name='diamond';
latt_para.idx_range=[-nmax, nmax; -nmax, nmax; -nmax, nmax];
latt_para.abundance=0.011;
latt_para.seed=1;
latt_para.take=1:50;
bath_spins=phy.stuff.SpinCollection(latt_para);
bath_spins.take_sub_collection(latt_para.take);
%% Central Spin Model
disp('Creating central spin pure dephasing model...');
pr=phy.model.PureDephasing(cspin, bath_spins, conditions);
%% generate clusters
disp('generating clusters of spin-system...');
cutoff=[8,40];maxorder=20;
mode.connection='NoCentralSpin';%mode.connection='SpecialCentralSpin';
mode.cluster='Spinach';%mode.cluster='CCE'
mode.liouville.method='PureDephasing';%mode.liouville.method='CentralSpin'
mode.liouville.scope='local';
approx='SzSz';%'ESR'

% [nCluster, nState, stateList]=pr.spin_bath.clustering(cutoff, maxorder,mode,approx);
pr.spin_bath.conmatrix_gen(cutoff,mode.connection);
pr.spin_bath.cluster_matrix_gen(maxorder,mode.cluster);
nc=pr.spin_bath.cluster_info.nclusters;
clusterSpinNumberList=zeros(1,nc);
for n=1:nc
    clusterSpinNumberList(1,n)=length(find(pr.spin_bath.cluster_matrix(n,:)));    
end



if 0
lv_para.dim=nState; 
lv_para.basis=stateList;
%% generate system Liouvillian
hami_para1.central_spin=cspin;
hami_para1.state=0;
hami_para2.central_spin=cspin;
hami_para2.state=1;
for m=1:pr.spin_bath.cluster_info.nclusters
    fprintf('Building local cluters Liouvillian: calculating %d-th spin cluster\n', m);
    pr.spin_bath.cluster_info.clusters{m}.set_bath_local_field(hami_para1,approx);
    hami1=pr.spin_bath.cluster_info.clusters{m}.generate_hamiltonian();
    pr.spin_bath.cluster_info.clusters{m}.HilbertSpace.operators.hami1=hami1;
    pr.spin_bath.cluster_info.clusters{m}.set_bath_local_field(hami_para2,approx);
    hami2=pr.spin_bath.cluster_info.clusters{m}.generate_hamiltonian();
    pr.spin_bath.cluster_info.clusters{m}.HilbertSpace.operators.hami2=hami2;
    pr.spin_bath.cluster_info.clusters{m}.generate_liouvillian(mode.liouville, lv_para);
end
%% Global Liouvillian
fprintf('Building global  Liouvillian... \n');
mode.liouville.scope='global';
pr.spin_bath.generate_liouvillian(mode.liouville, lv_para);
pr.spin_bath.resort_liouvillian();
stateList=pr.spin_bath.LiouvilleSpace.full_basis;
fprintf('Global  Liouvillian generated.\n');
%% global initial_state and observable
fprintf('Building global intial state and observable....\n');

st_para.cluster=zeros(1,pr.bath_spins.nspin);%[1,1]
initial_st=pr.spin_bath.generate_global_vector(st_para);

observable=[1,zeros(1,nState-1)];
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
timelist=1*10^(-7)*(0:100);
ntime=length(timelist);
L=-1i*pr.spin_bath.LiouvilleSpace.operators.Liouvillian;
final_states=sparse(nState,ntime);
final_states(:,1)=initial_st;
for n=2:ntime
   fprintf('Time evolution: calculating %d-th time point\n', n); 
   t=timelist(n);
   [final_states(:,n),err]=expv(t,L,initial_st);
   fprintf('The error upper limit for this final states is %d\n', err);
end
%spy(final_states);
fid=observable*final_states;
figure();
plot(timelist,real(fid))
%  %% save output
% pr.solution=pr.ss.cluster_matrix;
% %cspin_decoherence_problem.save_solution('./decoherence.mat');
end
toc;