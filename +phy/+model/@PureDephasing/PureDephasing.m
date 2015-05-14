classdef PureDephasing < phy.model.AbstractModel
    %PUREDEPHASING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
      central_spin  
      bath_spins
      spin_bath % physical system
     
    end
    
    methods
        function obj=PureDephasing(cspin, bath_spins, conditions)%
            obj=obj@phy.model.AbstractModel(conditions);
            
            obj.central_spin=cspin;
            obj.bath_spins=bath_spins;

            try
                sub_idx=latt_para.take;
                obj.bath_spins.take_sub_collection(sub_idx)
            catch
                disp('all spins are included.');
            end
            obj.spin_bath=phy.system.DipolarSpinSystem(obj.bath_spins.spin_list);
            obj.spin_bath.set_lab_conditions(conditions);
        end   
        
    end
    
end

