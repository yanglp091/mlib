classdef Lattice < handle
    %LATTICE Summary of this class goes here
    %   Detailed explanation goes here

    %% Class Properties
    properties
        basis
        num_basis
        
        cell_shift
        cell_atoms
        num_shift
        
        lattice_const
        
        idx_range
        index_space
        num_site
    end
    
    %% Class Methods
    methods        
        % constructor
        function obj = Lattice(latt, idx_range)
            obj.lattice_const=latt.const;
            
            obj.basis=latt.bas;
            obj.cell_shift=latt.shift;
            obj.cell_atoms=latt.atoms;
            obj.num_shift=latt.num_shift;
            obj.num_basis=latt.num_basis;
            
            if nargin == 2
                obj.set_range(idx_range);
            end
        end
        
        % set index range
        function set_range(obj,idx_range)
            obj.idx_range=idx_range;
            range_min=idx_range(:,1);
            range_max=idx_range(:,2);
            dim_list= [range_max'-range_min'+1, obj.num_shift];
            obj.index_space=math.ProductLinearSpace(dim_list);
            obj.num_site=obj.index_space.dim;
        end
        
        % index2coordinates
        function coord = index2coordinates(obj, idx)
            r=idx(end)+1;
            idx1=obj.idx_range(:,1)+idx(1:end-1)'; 
            
            coord=idx1'*obj.basis*diag(obj.lattice_const)+obj.cell_shift(r,:);
        end
        
        % coordinate from single index
        function [atom, coord] = single_index2coordinates(obj, sgl_idx)
            idx=obj.index_space.idx2basis(sgl_idx);
            atom=obj.cell_atoms{idx(end)+1};
            coord=obj.index2coordinates(idx);
        end
    end
    
end

