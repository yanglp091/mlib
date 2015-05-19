% clc;
% clear;
% tic;
% if 0
%% set path
clear;
addpath(genpath('/home/csrc/code_svn/mlib/'));
addpath(genpath('/home/csrc/projects/BN_layer'));
cd /home/csrc/code_svn/mlib/;
%% set conditions
fprintf('setting conditions...\n');

conditions=phy.condition.LabCondition();
conditions.magnetic_field.polar_vector=[0.806,0,0];%[B,theta,phi]e.g. [3e-1,0.955317,pi/4] for NV
conditions.reference_frequency=2*pi*2.87e9;%2.87e9
conditions.reference_direction.theta=0;%the polarization of the central spin 0.955317 for NV
conditions.reference_direction.phi=0;% pi/4 for NV
%% center spin
disp('creating a center spin...');
cspin=phy.stuff.Spin('NV',[0,0,30]);%'NV', [0 0 0]

%% lattice parameters 
tic;
nmax=10;seed=1;
latt_para.name='BN';nspin=400;
latt_para.idx_range=[-nmax, nmax; -nmax, nmax; -0, 0];
latt_para.abundance=[0.0, 0.004];%[abundance_B11, abundance_N15] =[0.199, 0.004]
latt_para.seed=[seed,seed+1];%[seed_B11, seed_N15]  these two seed must be set as different integers
latt_para.layers=0;
latt_para.take=1:nspin;
bath_spins=phy.stuff.SpinCollection_BN(latt_para);
bath_spins.take_sub_collection(latt_para.take);
% bath_spins.export_spin_collection(['./input_output/bath_spin_nspin' num2str(nspin) '_seed' num2str(seed) '.xyz']);
% file_name='./input_output/bath_spin_nspin200_seed3.xyz';
% bath_spins=phy.stuff.SpinCollection(file_name);
% if 0
toc
%% Central Spin Model
tic
disp('Creating central spin pure dephasing model...');
pr=phy.model.CCEengine(cspin,conditions,'SpinCollection',bath_spins);
%% generate clusters
disp('generating clusters of spin-system...');
cutoff=2.6;maxorder=4;
approx='ESR';%'SzSz'
pr.spin_bath.clustering(cutoff, maxorder,approx);
toc
tic
pr.set_clusters();
pr.set_cluster_lab_condition(conditions);
toc
%if 0
%% cluster evolution


tic
disp('calculating cluster and total coherence...');
coh_para.state1=3;
coh_para.state2=1;
coh_para.tmax=5*10^(-3);
coh_para.ntime=101;
coh_para.npulse=1;
coh_mat=pr.coherence_evolution(coh_para);%the matrix of the coherence of all cluster
toc

tic
pr.coherence_CCE(coh_mat);
toc
disp('calculation of coherence finished.');
% if 0
%% %%%%%parameter for analyze panel%%%%%%%%%%%%%
para_data.conditions=conditions;
para_data.cspin=cspin;
para_data.cutoff=cutoff;
para_data.maxorder=maxorder;
para_data.approx=approx;
para_data.coh_para=coh_para;
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd /home/csrc/projects/BN_layer;
filename1='./output/DataTotal_test3.mat';
filename2='./output/DataCoh_test3.mat';
save('-v7.3',filename1,'pr','para_data');
coh=pr.coherence;
coh.timelist=pr.timelist;
save(filename2,'coh')
restoredefaultpath

%end
%%
if 0
figure();
plot(pr.timelist,real(pr.coherence.coherence_cce_1),'r-o',pr.timelist,real(pr.coherence.coherence_cce_2),'b-*');%...
%    ,pr.timelist,real(pr.coherence.coherence_cce_3),'c-d',pr.timelist,real(pr.coherence.coherence_cce_3),'k-+' );%
ylim([0,10]);
end

%% pair resonance
% b=1469;
% % coh=struct();
% conditions.magnetic_field.polar_vector=[b*1e-4,0,0];clu.set_lab_conditions(conditions);
% coh_name=strcat('coh',num2str(b));
% coh.(coh_name)=pr.cluster_coherence_tilde(2001,coh_para,approx);




if 0
figure()
axes('position',[0.15,0.15,0.8,0.7]);
line(time,abs(coh.coh1469),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',4,'Color',[0 0 1]);
line(time,abs(coh.coh1469),'LineStyle','-','LineWidth',2,'Marker','o','MarkerSize',4,'Color',[1 0 0]);
line(time,abs(coh.coh1470),'LineStyle','-','LineWidth',2,'Marker','d','MarkerSize',4,'Color',[0.5 0.5 1]);
line(time,abs(coh.coh1471),'LineStyle','-','LineWidth',2,'Marker','+','MarkerSize',4,'Color',[0 0 0]);
line(time,abs(coh.coh1472),'LineStyle','-','LineWidth',2,'Marker','>','MarkerSize',4,'Color',[1 0.5 0]);%,'LineStyle','-','LineWidth',2
line(time,abs(coh.coh1473),'LineStyle','-','LineWidth',2,'Marker','s','MarkerSize',4,'Color',[0 0.5 0]);%,'LineStyle','-','LineWidth',2
% ylim([0,1]);
% % xlim([0,2e-4]);
xlabel('Time (s)','FontSize',24, 'interpreter','latex');%,'position',[180,-80,1]
ylabel('Hahn Echo','FontSize',24, 'interpreter','latex');
% % % set(gca,'xtick',0:100:tf,'ytick',0:0.2:1,'FontSize',22);
box on;
% title('B=1272G','FontSize',24);
h=legend('B=1468G','B=1469G','B=1470G','B=1471G','B=1472G','B=1473G');
set(h,'position',[0.4,0.16,0.22,0.4]);
set(h,'FontSize',20, 'interpreter','latex')
set(h,'Box','off');
end





