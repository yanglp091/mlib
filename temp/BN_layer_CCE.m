%if 0
%% set path
addpath(genpath('./'));

%% set conditions
fprintf('setting conditions...\n');
b=806;
filename1=['./input_output/BN_20150514_' num2str(b) 'G.mat'];
filename2=['./input_output/coh_20150514_' num2str(b) 'G.mat'];
conditions=phy.condition.LabCondition();
conditions.magnetic_field.polar_vector=[b*1e-4,0,0];%[B,theta,phi]e.g. [3e-1,0.955317,pi/4] for NV
conditions.reference_frequency=2*pi*2.87e9;%2.87e9
conditions.reference_direction.theta=0;%the polarization of the central spin 0.955317 for NV
conditions.reference_direction.phi=0;% pi/4 for NV
%% center spin
disp('creating a center spin...');
cspin=phy.stuff.Spin('NV',[0,0,40]);%'NV', [0 0 0]

%% lattice parameters 
tic;
nmax=5;seed=1;
latt_para.name='BN';nspin=400;
latt_para.idx_range=[-nmax, nmax; -nmax, nmax; -nmax, 0];
latt_para.abundance=[0.199, 0.004];%[abundance_B11, abundance_N15]
latt_para.seed=[seed,seed+1];%[seed_B11, seed_N15]  these two seed must be set as different integers
latt_para.layers=[-1,0];
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
cutoff=2.6;maxorder=3;
approx='ESR';%'SzSz'
pr.spin_bath.clustering(cutoff, maxorder,approx);
pr.set_clusters();
pr.set_cluster_lab_condition(conditions);
pack;
toc
%% cluster evolution
tic;
disp('calculating cluster and total coherence...');
coh_para.state1=1;
coh_para.state2=3;
coh_para.tmax=5*10^(-4);
coh_para.ntime=101;
coh_para.npulse=1;
pr.coherence_evolution(coh_para);
disp('calculation of coherence finished.');
%% %%%%%parameter for analyze panel%%%%%%%%%%%%%
para_data.conditions=conditions;
para_data.cspin=cspin;
para_data.cutoff=cutoff;
para_data.maxorder=maxorder;
para_data.approx=approx;
para_data.coh_para=coh_para;
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('-v7.3',filename1,'pr','para_data');
coh=pr.coherence;
coh.timelist=pr.timelist;
save(filename2,'coh')

end
%%
if 0
figure();
plot(pr.timelist,real(pr.coherence.coherence_cce_1),'r-o',pr.timelist,real(pr.coherence.coherence_cce_2),'b-*'...
   ,pr.timelist,real(pr.coherence.coherence_cce_3));%,'c-d',pr.timelist,real(pr.coherence.coherence_cce_4),'k-+'
ylim([0,1]);
%end




%% plot coherence
if 0
figure();
plot(coh.timelist,real(coh.coherence_cce_1),'r-o',coh.timelist,real(coh.coherence_cce_2),'b-*'...
   ,coh.timelist,real(coh.coherence_cce_3),'c-d');%,pr.timelist,real(pr.coherence.coherence_cce_4),'k-+'
ylim([0,1]);
xlim([0,5e-4]);
xlabel('Time (s)','FontSize',24);%,'position',[180,-80,1]
ylabel('Hahn Echo','FontSize',24);
box on;
title('B=1472G d=4nm','FontSize',24);
h=legend('CCE-1','CCE-2','CCE-3');
set(h,'position',[0.6,0.5,0.22,0.2]);
set(h,'FontSize',20, 'interpreter','latex')
set(h,'Box','off');
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





