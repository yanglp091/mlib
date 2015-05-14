classdef RSSengine < phy.model.AbstractModel
    %CENTRALSPIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_collection
        ss %spin_system
       
        


    end
    properties (Dependent)
        central_spin
        bath_spin
    end
    
    methods
        function obj=RSSengine(cspin, bath_spins, conditions)
            %asdf
            obj=obj@phy.model.AbstractModel(conditions);

            obj.spin_collection=bath_spins;
            obj.spin_collection.insert_spin(cspin, 1);

            obj.ss=phy.system.DipolarSpinSystem(obj.spin_collection.spin_list);
            obj.ss.clustering_method='RSS';
            obj.ss.set_lab_conditions(conditions);

        end
        
        function central_spin=get.central_spin(obj)
            central_spin=obj.spin_collection.spin_list{1};
        end
        
        function bath_spin=get.bath_spin(obj)
            bath_spin=obj.spin_collection.spin_list(2:end);
        end
        
        
        
        
        
        
    end
    
end

