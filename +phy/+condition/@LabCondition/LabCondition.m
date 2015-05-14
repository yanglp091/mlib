classdef LabCondition
    %LABCONDITION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        temperature
        reference_frequency
        reference_direction
        magnetic_field
    end
    
    methods
        function obj=LabCondition()
            obj.magnetic_field=phy.condition.Field();
        end
    end
    
end

