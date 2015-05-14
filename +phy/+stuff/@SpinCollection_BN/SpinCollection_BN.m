classdef SpinCollection_BN < phy.stuff.SpinCollection
    %SpinCollection_BN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        function obj=SpinCollection_BN(para)
            obj=obj@phy.stuff.SpinCollection('subclass');
            disp('generating bath spins ...');
            obj.spin_on_lattice(para.name, para.idx_range,para.abundance, para.seed,para.layers); 
            obj.sort_according_distance();            
            obj.dim=prod(cellfun(@(s) s.dim, obj.spin_list));
        end
        
        %set the spin isotope configuration
        function spin_on_lattice(obj, latt_name, idx_range, abundance, seed,layers)
            latt_struct=data.LatticeStructure().get_lattice_structure(latt_name);
            inter_layer_shift=latt_struct.inter_layer_shift;
            latt=phy.stuff.Lattice(latt_struct, idx_range);
            abundance_B10=abundance(1,1);abundance_N15=abundance(1,2);
            seed_B10=seed(1,1); seed_N15=seed(1,2);
            nspin=latt.num_site;
            
            rng(seed_B10); x=rand(1,nspin/2);
            selectedB10_index=find(x<abundance_B10);
            nB10=length(selectedB10_index);
            
            rng(seed_N15); x=rand(1,nspin/2);
            selectedN15_index=find(x<abundance_N15);            
            nN15=length(selectedN15_index);            

            nB=0;nN=0;%recod the number of atom N or B
            pB=1;pN=1;% two positions for selected_indexs           
            obj.spin_list=cell(1, nspin);
            
            for n=1:nspin
                [atom, coord]=latt.single_index2coordinates(n); 

                switch atom
                    case '11B'
                        nB=nB+1;
                        if pB<(nB10+1)&&nB==selectedB10_index(pB)
                           atom='10B'; 
                           pB=pB+1;
                        end
                    case '14N'
                        nN=nN+1;
                        if pN<(nN15+1)&&nN==selectedN15_index(pN)
                           atom='15N';
                           pN=pN+1;
                        end
              
                 end
                
                obj.spin_list{n}=phy.stuff.Spin(atom, coord);
            end
            obj.spin_list=obj.pick_spin_layer(layers,inter_layer_shift);
            
         end

        %pick spin in the specifie layer 
        function spin_list=pick_spin_layer(obj,layers,inter_layer_shift)
            nlayer=length(layers);
            zmin=inter_layer_shift*layers-0.5*inter_layer_shift;
            zmax=inter_layer_shift*layers+0.5*inter_layer_shift;
            
            m=0;
            idx=zeros(1,1);
            for n=1:obj.nspin
                coordz=obj.spin_list{n}.coordinate(1,3);
                coordz_list=coordz*ones(1,nlayer);
                diff1=coordz_list-zmin;
                diff2=coordz_list-zmax;
                diff_list=diff1.*diff2;
                if isempty(find(diff_list<0, 1))==0
                    m=m+1;
                    idx(1,m)=n;
                end
            end
            
            spin_list=obj.spin_list(idx);          
        end
        
        
    end
    
end

