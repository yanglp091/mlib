classdef AtomicStructure
    %ATOMICSTRUCTURE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        atom_species_num
    end
    
    methods (Static)
        function parameters=get_parameters(name)
            switch char(name)
                case '87Rb'
                    parameters.dim=8+8+16;
                    % fine-structure parameters
                    parameters.config='[Kr]5s';     %electron configuation
                    parameters.IP=4.1771;           %ionization potential in eV
                    parameters.lambda_D1=794.978;   %wave length of D1 transition in nm
                    parameters.lambda_D2=780.241;   %wave length of D2 transition in nm
                    parameters.delta_FS=237.60;     %Fine-structure splitting in cm^(-1)
                    parameters.tau_1=27.75;         %lifetime of P_1/2 states
                    parameters.tau_2=26.25;         %lifetime of P_3/2 states
                    parameters.osc_1=0.341;         %oscillator strength of P_1/2 stats
                    parameters.osc_2=0.695;         %oscillator strength of P_3/2 stats
                    
                    % hyperfine-structure parameters
                    parameters.abundance=0.2783;    %natural abundance
                    parameters.spin_I=3./2.;        %nuclear spin number
                    parameters.mu_I=2.75182;        %nuclear magnetic moment in [mu_N]
                    parameters.hf_gs=6834.682610;   % hf coeff of ground state S_1/2 in MHz
                    parameters.hf_es1=406.12;       %hf coeff of excited state P_1/2 in MHz
                    parameters.hf_es2A=84.72;       %hf coeff_A of excited state P_3/2 state in MHz
                    parameters.hf_es2B=12.50;       %hf coeff_B of excited state P_3/2 state in MHz
                otherwise
                        error('no atomic data.');
            end
        end
    end
    
end

