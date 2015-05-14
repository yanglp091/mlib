function res = molecule_evolve(fileID)

condition=phy.condition.LabCondition();
condition.magnetic_field.polar_vector=[3e-1,pi/4,pi/4];


spins=phy.stuff.SpinCollection(fileID);
sys=phy.system.DipolarSpinSystem(spins.spin_list);
sys.set_lab_conditions(condition);
sys.approx='None';
sys.generate_hamiltonian();
sys.generate_liouvillian();

dimL=sys.LiouvilleSpace.dim;
state=zeros(dimL,1);
state(4)=1;
sys.LiouvilleSpace.vectors.init=state;

res=sys;