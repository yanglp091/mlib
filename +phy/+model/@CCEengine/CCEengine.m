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
        
        
        function coherence_evolution(obj,para)  
            obj.npulse=para.npulse;
            coh_total=ones(1,para.ntime);
            tstep=para.tmax/(para.ntime-1);
            obj.timelist=0:tstep:para.tmax;
            ntime=length(obj.timelist);
            nclusters=obj.spin_bath.cluster_info.nclusters;
            cohmat=zeros(nclusters,ntime);
            
            %calculate cluster coherence parallelly
%             h = waitbar(0,'Calculating cluster coherence...');  %display the progress bar
            parfor m=1:nclusters
%                 waitbar(m/obj.spin_bath.cluster_info.nclusters); %display the progress bar
                cluster=obj.get_cluster(m); 
                approx=cluster.approx;
                cohmat(m,:)=obj.cluster_coherence(m,para,approx);
            end
%             close(h); %display the progress bar 
 
              %calculate cluster tilde coherence and totoal coherence          
            obj.coherence=struct();
            cceorder=1;
            startpoints=obj.spin_bath.cluster_info.cluster_number_list{obj.spin_bath.maxorder+1,2}(1,:);
            for m=1:nclusters
                cluster=obj.get_cluster(m); 
                subcluster=cluster.cluster_info.subclusters;
                nsubcluster=length(subcluster);
                cluster.HilbertSpace.scalars.coherence=cohmat(m,:);
                coh_tilde=cohmat(m,:);
                if nsubcluster==0
                    cluster.HilbertSpace.scalars.coherence_tilde= coh_tilde;
                elseif nsubcluster>0
                    for n=1:nsubcluster;
                        coh_tilde_sub=obj.spin_bath.cluster_info.clusters{subcluster(n)}.HilbertSpace.scalars.coherence_tilde;
                        coh_tilde=coh_tilde./coh_tilde_sub;
                    end
                    cluster.HilbertSpace.scalars.coherence_tilde=coh_tilde;
                end

                coh_total=coh_total.*coh_tilde;
                if m==startpoints(1,cceorder)
%                     disp(['calculation for CCE-' num2str(cceorder) ' fished.']);
                    field_name=strcat('coherence_cce_',num2str(cceorder));
                    obj.coherence.(field_name)=coh_total;
                    cceorder=cceorder+1;
                end
                
            end
            
            obj.coherence.('coherence')= coh_total;     
        end        
        
        %get the cluster
        function cluster=get_cluster(obj,m)
            cluster=obj.spin_bath.cluster_info.clusters{m};
        end
       
    end
    
end

