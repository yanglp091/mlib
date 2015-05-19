classdef CCEengine< phy.model.AbstractModel
    %CCEENGINE 
  properties
      central_spin  
      bath_spins
      spin_bath % physical system    
      
      coord_frame_info% the transfer matrix between different coordinate frame
      
      npulse
      timelist
      timelist_check
      coherence
      
     
    end
    
    methods
        function obj=CCEengine(cspin,conditions,varargin)%
            obj=obj@phy.model.AbstractModel(conditions);           
            obj.central_spin=cspin;
            if nargin<4
               disp('wrong input nargin!'); 
            end
            
            for m=1:2:nargin-3
                input=varargin{m};
                switch input
                    case 'SpinCollection'
                        bspins=varargin{m+1};%input bath spins
                        if isa(bspins,'phy.stuff.SpinCollection')
                            obj.bath_spins=bspins;
                        elseif isa(bspins,'char')
                            obj.bath_spins=import_spin_collection(bspins);
                        end
                        
                        try
                            sub_idx=latt_para.take;
                            obj.bath_spins.take_sub_collection(sub_idx)
                        catch
                            disp('all spins are included.');
                        end

                        obj.spin_bath=phy.system.DipolarSpinSystem(obj.bath_spins.spin_list);                      
                        obj.spin_bath.clustering_method='CCE';
                    case 'SpinSystem'
                        sbath=varargin{m+1};
                        obj.spin_bath=sbath;%input spins bath not bath spin
%                         obj.bath_spins.spin_list=sbath.entries;
%                         obj.bath_spins.nspin=sbath.nEntries;
                end
            end

        end
        
      % get the coordinate frame information  
        function coord_info=get_coord_frame_info(obj)
            theta=obj.conditions.reference_direction.theta;
            phi=obj.conditions.reference_direction.phi;
            obj.magnetic_field_frame();
            obj.central_spin_frame(theta,phi);
            coord_info=obj.coord_frame_info;            
        end
        
        
        
        
        %get the cluster
        function cluster=get_cluster(obj,m)
            cluster=obj.spin_bath.cluster_info.clusters{m};
        end
       
    end
    
end

