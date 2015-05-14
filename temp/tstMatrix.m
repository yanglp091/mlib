clear

s1=phy.stuff.Spin('13C', [0 0 0]);
s2=phy.stuff.Spin('13C', [0.9 0.9 0.9]);
s3=phy.stuff.Spin('13C', [3 5 8]);

sys12=phy.system.DipolarSpinSystem({s1, s2, s0});
sys12.generate_hamiltonian();
mat12=full(sys12.HilbertSpace.operators('Hamiltonian'));

sys23=phy.system.DipolarSpinSystem({s0, s2, s3});
sys23.generate_hamiltonian();
mat23=full(sys23.HilbertSpace.operators('Hamiltonian'));

sys13=phy.system.DipolarSpinSystem({s1, s0, s3});
sys13.generate_hamiltonian();
mat13=full(sys13.HilbertSpace.operators('Hamiltonian'));

sys123=phy.system.DipolarSpinSystem({s1, s2, s3});
sys123.generate_hamiltonian();
mat123=full(sys123.HilbertSpace.operators('Hamiltonian'));

delta=mat123-mat12-mat23-mat13;
disp(norm(delta));