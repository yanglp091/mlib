%%
import phy.stuff.Spin
import phy.condition.LabCondition

nspin=8;
spin_list=cell(1, nspin+1);

spin_list{1}=Spin('13C', [0 0 0]);
for i=1:nspin
    spin_list{i+1}=Spin('13C', position(:,i)'*10^10);
end

%%
conditions=LabCondition();
conditions.magnetic_field.vector=[0 0 0];
%%
sys=phy.system.DipolarSpinSystem(spin_list);
sys.set_lab_conditions(conditions);
sys.generate_hamiltonian();

myHamiltonian=sys.HilbertSpace.operators('Hamiltonian');
myHamiltonian=myHamiltonian(1:2^nspin, 1:2^nspin);
