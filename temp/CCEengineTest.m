clc;
clear;
tic;
%% set conditions
fprintf('setting conditions...\n');

conditions=phy.condition.LabCondition();
conditions.magnetic_field.polar_vector=[1e-1,0.955317,pi/4];%[B,theta,phi]e.g. [3e-1,0.955317,pi/4] for NV
conditions.reference_frequency=2*pi*2.87e9;%2.87e9
conditions.reference_direction.theta=0.955317;%the polarization of the central spin 0.955317 for NV
conditions.reference_direction.phi=pi/4;% pi/4 for NV
%% center spin
disp('creating a center spin...');
cspin=phy.stuff.Spin('NV',[0,0,0]);%'NV', [0 0 0]

%% lattice parameters 
% nmax=2;
% latt_para.name='diamond';
% latt_para.idx_range=[-nmax, nmax; -nmax, nmax; -nmax, nmax];
% latt_para.abundance=0.011;
% latt_para.seed=10;
% latt_para.take=1:3;
% bath_spins=phy.stuff.SpinCollection(latt_para);
% bath_spins.take_sub_collection(latt_para.take);
% bath_spins.export_spin_collection('./input_output/bath_spin.xyz');
file_name='./input_output/RoyCoord.xyz';
bath_spins=phy.stuff.SpinCollection(file_name);

%% Central Spin Model
disp('Creating central spin pure dephasing model...');
pr=phy.model.CCEengine(cspin, conditions,'SpinCollection', bath_spins);
toc;
%% generate clusters
tic;
disp('generating clusters of spin-system...');
cutoff=8;maxorder=3;
approx='ESR';%'SzSz'
pr.spin_bath.clustering(cutoff, maxorder,approx);
pr.set_clusters();
toc;

%% cluster evolution
tic;
disp('calculating clusters and total coherence...');
coh_para.state1=1;
coh_para.state2=2;
coh_para.tmax=3*10^(-3);
coh_para.ntime=401;
coh_para.npulse=1;
pr.coherence_evolution(coh_para);
disp('calculation of coherence finished.');
toc;
%%%%%parameter for analyze panel%%%%%%%%%%%%%
para_data.conditions=conditions;
para_data.cspin=cspin;
para_data.cutoff=cutoff;
para_data.maxorder=maxorder;
para_data.approx=approx;
para_data.coh_para=coh_para;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('./input_output/RoyCord.mat','pr','para_data');
figure();
plot(pr.timelist,abs(pr.coherence.coherence_cce_1),'r-o',...
    pr.timelist,abs(pr.coherence.coherence_cce_2),'g-+',...
    pr.timelist,abs(pr.coherence.coherence_cce_3),'b-*');
%% check the tilde cohenrence function 
if 0
clu_index=10;
coh=pr.cluster_coherence(clu_index,coh_para,approx);
coh1=pr.spin_bath.cluster_info.clusters{clu_index}.HilbertSpace.scalars.coherence;
coh_tilde=pr.cluster_coherence_tilde(clu_index,coh_para,approx);
coh_tilde1=pr.spin_bath.cluster_info.clusters{clu_index}.HilbertSpace.scalars.coherence_tilde;
figure();
plot(pr.timelist,real(coh),'c-d',pr.timelist,real(coh1),'b-*');

figure();
plot(pr.timelist,real(coh),'c-d',pr.timelist,real(coh_tilde),'b-*');

figure();
plot(pr.timelist,real(coh_tilde),'b-*',pr.timelist,real(coh_tilde1),'r-o');
end
%% check the 1- or 2-spin cluster coherence
% if 0
% m=1700;
% coh1=pr.cluster_coherence_check(coh_para,m,approx);
% coh2=pr.spin_bath.cluster_info.clusters{m}.HilbertSpace.scalars;
% figure();
% plot(pr.timelist,real(coh1),'b-*',pr.timelist,real(coh2.coherence),'r-o');
% 
% 
% figure();
% plot(pr.timelist,real(coh2.coherence),'r-o',pr.timelist,real(coh2.coherence_tilde),'c-d');%
% end

