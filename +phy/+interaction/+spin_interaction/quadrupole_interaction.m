function [quadrupole, mat] = quadrupole_interaction( spin1, spin2, para )
%QUADRUPOLE_INTERACTION Summary of this function goes here
%   Detailed explanation goes here
quadrupole=para;
dim=spin1.dim*spin2.dim;
if spin1.S>0.5 && spin2.S > 0.5
    denominator=2*spin1.S*spin2.S*(2*spin1.S-1)*(2*spin2.S-1);

    s1_dot_s2 = kron(spin1.sx,spin2.sx)...
              + kron(spin1.sy,spin2.sy)...
              + kron(spin1.sz,spin2.sz);

    mat1=3.0 *s1_dot_s2*s1_dot_s2;
    mat2=1.5 *s1_dot_s2;
    mat3=spin1.S2*spin2.S2*eye(dim);
    mat= quadrupole*(mat1+mat2-mat3)/denominator;
else
    mat= zeros(dim, dim);
end

