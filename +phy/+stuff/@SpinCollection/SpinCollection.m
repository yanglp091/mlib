classdef SpinCollection < phy.stuff.PhysicalObject
    %SPINCLUSTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_list        
    end
    
    properties (Dependent)
        nspin
%         dim_list

    end
    
    methods
        %constructor
        function obj=SpinCollection(para)
            if isa(para,'struct')
                disp('generating bath spins ...');
                obj.spin_on_lattice(para.name, para.idx_range,para.abundance, para.seed);
                obj.sort_according_distance();
            elseif strcmp(para,'subclass')
                return;
            elseif isa(para,'char')&&(strcmp(para,'subclass')==0)
                disp('import bath spins ...');
                obj.import_spin_collection(para);
            else
                error('error.');
            end
            obj.dim=prod(cellfun(@(s) s.dim, obj.spin_list));

        end
        
        %spin on lattice
        function spin_on_lattice(obj, latt_name, idx_range, abundance, seed)
            latt_struct=data.LatticeStructure().get_lattice_structure(latt_name);
            latt=phy.stuff.Lattice(latt_struct, idx_range);

            rng(seed); x=rand(1,latt.num_site);
            selected_index=find(x<abundance);
            
            nSel=length(selected_index);
            
            obj.spin_list=cell(1, nSel);
            for n=1:nSel
                [atom, coord]=latt.single_index2coordinates(selected_index(n));
                obj.spin_list{n}=phy.stuff.Spin(atom, coord);
            end
         end
                
        %sort_according_distance
        function dist=sort_according_distance(obj)
            dist_array=cellfun(@(s) norm(s.coordinate), obj.spin_list);
            [dist, i]=sort(dist_array);
            obj.spin_list=obj.spin_list(i);
        end
        
        function nspin=get.nspin(obj)
            nspin=length(obj.spin_list);
        end
        

        function insert_spin(obj, spin, pos)
            if pos==1
                obj.spin_list=[{spin}, obj.spin_list];
            elseif 1<pos<obj.nspin
                obj.spin_list=[obj.spin_list(1:pos-1),{spin},obj.spin_list(pos:obj.nspin)];
            elseif pos==obj.nspin
                obj.spin_list=[obj.spin_list,{spin}];
            else
                error('The position exceeds the length of the spin list')
            end
            obj.dim=prod(cellfun(@(s) s.dim, obj.spin_list));
        end
        
        %take_sub_collection
        function take_sub_collection(obj, idx)
            obj.spin_list=obj.spin_list(idx);
            obj.dim=prod(cellfun(@(s) s.dim, obj.spin_list));
        end

        function export_spin_collection(obj,filename)
            fileID=fopen(filename,'w');      
            fprintf(fileID,'%g',obj.nspin);
            fprintf(fileID,'\n#Comment');
            
            for n=1:obj.nspin
                name=obj.spin_list{n}.name;
                coord=obj.spin_list{n}.coordinate;
                fprintf(fileID,'\n%s %f %f %f',name,coord(1),coord(2),coord(3));
            end
            fclose(fileID);
        end
        
        function import_spin_collection(obj,filename)
            fileID=fopen(filename,'r');
            data=textscan(fileID,'%s %f %f %f','headerlines',2);
            fclose(fileID);
            nspin=size(data{1},1);
            obj.spin_list=cell(1,nspin);
            for n=1:nspin
                name=data{1,1}{n};
                coord=[data{1,2}(n),data{1,3}(n),data{1,4}(n)];
               obj.spin_list{n}=phy.stuff.Spin(name,coord);
            end         
        end
        
    end
     
end

