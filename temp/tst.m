if 0
import phy.stuff.Spin
import phy.condition.LabCondition

tic;
nspin=12;seed=1;rng(seed);

%%
conditions=LabCondition();
conditions.magnetic_field.vector=[0 0 0];

%%
coords=rand(nspin,3);
slist=cell(1,nspin);
for i=1:nspin
    slist{i}=Spin('13C', coords(i,:));
end

%%
sys=phy.system.DipolarSpinSystem(slist);
sys.set_lab_conditions(conditions);

disp('calculating Hamiltonian');
sys.generate_hamiltonian();
%sys.generate_liouvillian('Hamiltonian');
%stateVect=zeros(16,1);
%stateVect(1,1)=0.5;stateVect(4,1)=0.5;

toc;    

% end
%%
% if 0
%  obj=pr.ss.cluster_info.clusters{1};
%  st1=obj.entries{3};
%  
%  pr.ss.cluster_matrix(3,:)=[1,1,1];
% [nState, stateList]=pr.ss.statelist_gen();
% pr.ss.xmm_gen();pr.ss.set_clusters();
%  
% L1=pr.ss.LiouvilleSpace.operators.Liouvillian;
% L2=pr.ss.cluster_info.clusters{3}.LiouvilleSpace.operators.Liouvillian;
% L1-L2
% timelist=1*10^(-6)*(0:30);
% ntime=length(timelist);

% rho0=kron(kron(kron(kron([0.5,0.5;0.5,0.5],[0.5,0;0,0.5]),[0.5,0;0,0.5]),[0.5,0;0,0.5]),[0.5,0;0,0.5]);
cluster_size=length(find(st_para.cluster));
rho0=st_para.Matrix;
for k=(cluster_size+1):pr.ss.nEntries
    rho0=kron(rho0,[0.5,0;0,0.5]);
end

% sp1=kron(kron(kron(kron([0,1;0,0],[1,0;0,1]),[1,0;0,1]),[1,0;0,1]),[1,0;0,1]);
cluster_size=length(find(obs_para.cluster));
sp=obs_para.Matrix;
for k=(cluster_size+1):pr.ss.nEntries
    sp=kron(sp,[1,0;0,1]);
end

hami=pr.ss.cluster_info.clusters{1}.HilbertSpace.operators.Hamiltonian;
liou=pr.ss.LiouvilleSpace.operators.Liouvillian;

rhot=cell(ntime);
rhot{1}=rho0;

sp_val=zeros(1,ntime);
sp_val(1)=0.5;

% dim=pr.ss.LiouvilleSpace.dim;
% vec_rho=zeros(dim,ntime);
% vec_rho(:,1)=initial_st;
for n=2:ntime
 fprintf('Time evolution: calculating %d-th time point\n', n);   
    rhot{n}=expm(-1i*hami*timelist(n))*rho0*expm(1i*hami*timelist(n));
    sp_val(n)=trace(rhot{n}*sp);
%     vec_rho(:,n)=expm(-1i*liou*timelist(n))*initial_st;
end
sp_val1=observable'*vec_rho;

coord1=[1,0.2,9];coord2=[0.2,0.8,2.1];
pr.spin_bath.central_spin_frame(0.2,0.1);
tm=pr.spin_bath.cs_frame.basis;
coord3=tm*coord1';coord4=tm*coord2';
spin1=phy.stuff.Spin('13C', coord1);
spin2=phy.stuff.Spin('13C', coord2);
spin3=phy.stuff.Spin('13C', coord3);
spin4=phy.stuff.Spin('13C', coord4);
[dip1,~]=phy.interaction.spin_interaction.dipolar_interaction(spin1,spin2);
dip2=tm*dip1*tm';
[dip3,~]=phy.interaction.spin_interaction.dipolar_interaction(spin3,spin4);
diff=dip2-dip3;

end
%%
nmax=2;
latt_para.name='BN';
latt_para.idx_range=[-nmax, nmax; -nmax, nmax; -0, 0];
latt_para.abundance=0.011;
latt_para.seed=10;
latt_para.take=1:800;
% bath_spins=phy.stuff.SpinCollection(latt_para);
% bath_spins.take_sub_collection(latt_para.take);

latt_struct=data.LatticeStructure.get_lattice_structure(latt_para.name);
latt=phy.stuff.Lattice(latt_struct, latt_para.idx_range);
nspin=latt.num_site;
spin_list=cell(1, nspin);
full_basis=latt.index_space.full_basis;
for n=1:nspin
    [atom, coord]=latt.single_index2coordinates(n);
    spin_list{n}=phy.stuff.Spin(atom, coord');
end





















