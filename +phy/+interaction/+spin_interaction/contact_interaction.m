function [contact, mat] = contact_interaction( spin1, spin2, para )
%CONTACT_INTERACTION Summary of this function goes here
%   Detailed explanation goes here
contact=para;
s1_dot_s2 = kron(spin1.sx,spin2.sx)...
          + kron(spin1.sy,spin2.sy)...
          + kron(spin1.sz,spin2.sz);
mat= contact * s1_dot_s2;

end

