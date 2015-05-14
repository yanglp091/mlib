 classdef SpinSystem < phy.system.PhysicalSystem
    %SpinSystem does these jobs:
    %
    % * clustering :math:`N` spins 
    %
    % * set basis state of each clusters
    %
    
    properties
        clustering_method               %set the 
        
        cutoff=[0, 0]                  %cutoff for what ?? the first number is the distance (A) threshold for spin pairs, the second number (integer) is spins coupled to the central spin   
        
        maxorder=2                      %max order when clustering, indicating the largest spin number within a cluster
        
        conmatrix                       %connection matrix, a :math:`N\times N` bool matrix indicating whether two spins are connected.
        
        cluster_matrix                  %cluster matrix, a :math:`N_c \times N` ncluster-by-nspin
        
        cluster_info                     %cluster_info
                                         %  .nclusters:    cluster number
                                         %  .clusters{i}: the i-th cluster

        
        xmm                              %crsoss-membership matrix: nstate-by-ncluster  or ncluster-by-ncluster
        

        state_info                       %state_info
                                         %  .nstates:      state number
                                         %  .state_list:  list of states
                                         %  .state_belongs_to: cluster index which the state belongs to
       
        coord_frame_info% the transfer matrix between different coordinate frame
        approx   %the approximation for Hamiltonian
    end

    methods
        function obj=SpinSystem(spinlist)
            % constructor, create an SpinSystem with given spins.
            %
            % :parameters: spinlist - a :math:`1\times N` cell that contains N spins.
            %
            
            obj=obj@phy.system.PhysicalSystem(spinlist);
        end
       %generating clusters and set this subsystem properties
        function clustering(obj, cutoff, maxOrder,approx,connection_mode)
            if nargin < 5
                connection_mode = 'NoCenterSpin';
                cutoff=[cutoff,0];
            end
            obj.approx=approx;
            obj.conmatrix_gen(cutoff,connection_mode);
            nc=obj.cluster_matrix_gen(maxOrder);%number of clusters 
            
            switch class(obj)
                case 'phy.system.DipolarSpinSystem'
                    cluster_CLASS=@phy.system.DipolarSpinSystem;
                otherwise
                    error('class of spin_system is nor supported.');
            end
            obj.cluster_info.nclusters=nc;
            obj.cluster_info.clusters=cell(1, nc);
            for m=1:nc
                spin_list=obj.entries(obj.cluster_matrix(m,:));
                obj.cluster_info.clusters{m}=cluster_CLASS(spin_list);
                obj.cluster_info.clusters{m}.approx=obj.approx;
                obj.cluster_info.clusters{m}.set_lab_conditions(obj.lab_conditions);
                obj.cluster_info.clusters{m}.coord_frame_info=obj.coord_frame_info;
                obj.cluster_info.clusters{m}.principal_axes=obj.principal_axes;
            end
        end
       
        %seting local field
        function set_bath_local_field(obj,varargin)
            if nargin<3
                  for k=1:obj.nEntries
                     bs=obj.entries{k};
                    bs.local_field=varargin{1};
                  end
            else
                %set the inputs
                    approxi = 'None';
                    for m=1:2:nargin-1
                        input=varargin{m};
                        switch input
                            case 'parameters'
                                para=varargin{m+1};
                            case 'approx'
                                approxi=varargin{m+1};
                            otherwise
                                error('no such input argument.');
                        end
                    end
                  
                    % calculate the hyperfine field
                    cs=para.central_spin;
                    cspin_state=para.state;
                    for k=1:obj.nEntries
                        nf2rf_tm=obj.coord_frame_info.reference_frame.coordinate_basis;%nature frame to reference frame transfer matrix                        
                        lvs_rf=obj.coord_frame_info.reference_frame.left_vectors(cspin_state,:);%the left vectors in the the reference frame
                        bs=obj.entries{k};
                        [dip, ~]=phy.interaction.spin_interaction.dipolar_interaction(cs, bs);%,'transfer_matrix',nf2csf_tm dipolar matrix in the nature frame
                        lvs_nf=lvs_rf*nf2rf_tm;
                        dipfield=lvs_nf*dip;% hyperfine field in the nature frame

                        switch approxi
                            case 'ESR'
                                bs.local_field=((-1/bs.gamma)*dipfield)';
                            case 'SzSz'
                                dipfield=[0,0,dipfield(3)]';
                                bs.local_field=(-1/bs.gamma)*dipfield;
                        end
                    end
            end
        end

    end
    
end

