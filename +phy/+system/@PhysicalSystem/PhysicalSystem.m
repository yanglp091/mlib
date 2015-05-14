classdef PhysicalSystem < handle
    %PHYSICALSYSTEM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        entries    %e.g. a spinlist
        nEntries   % number of entries
        dim_list   % dim_list of the enties
        tot_dimension
        
        principal_axes
        
        HilbertSpace
        LiouvilleSpace
        lab_conditions
    end
    
   
    methods
        %constructor
        function obj=PhysicalSystem(entries)
            obj.entries=entries;
            obj.nEntries=length(obj.entries);
            
            obj.dim_list=cellfun(@(s) s.dim, entries);
            obj.tot_dimension=prod(obj.dim_list);
            if obj.tot_dimension < 1000
                obj.create_HilbertSpace();
            end
            
            obj.principal_axes=eye(3);
        end

        
        %set lab_conditions
        function set_lab_conditions(obj, conditions)
            obj.lab_conditions=conditions;
        end
        
        %interaction matrix between entries{i} and entries{j}: 
        %magic matrix is returned
        function mat=subspace_interaction(obj)
            sub_space_dim=obj.HilbertSpace.subspace.dim;
            mat=magic(sub_space_dim);
        end
        %create a Hilbert Space
        function create_HilbertSpace(obj)
            dim_lst=cellfun(@(s) s.dim, obj.entries);
            obj.HilbertSpace=math.ProductLinearSpace(dim_lst);
        end
        %create a Liouville Space
        function create_LiouvilleSpace(obj, mode, para)
            if nargin < 3
                para = 0;
            end
            switch mode
                case 'local'
                    dim_lst=cellfun(@(s) s.dim, obj.entries);
                    obj.LiouvilleSpace=math.ProductLinearSpace(dim_lst.^2);
                
                case 'global'
                    dim=para.dim;
                    full_basis=para.basis;
                    obj.LiouvilleSpace=math.LinearSpace(dim, full_basis);
                    
                otherwise
                    error('unknown mode in creating LiouvilleSpace.');
            end
        end
    end
end

