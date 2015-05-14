classdef Field
    %FIELD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        vector=[0 0 0]';
        polar_vector
    end
    
    methods
        function magnitude=strength(obj)
            magnitude=norm(obj.vector);
        end
        
        function dir=direction(obj)
            if obj.strength > eps
                dir=obj.vector/obj.strength;
            else
                dir=[0 0 1];
            end
        end
        function vector=get.vector(obj)
            B=obj.polar_vector(1);
            theta=obj.polar_vector(2);
            phi=obj.polar_vector(3);
            Bx=B*sin(theta)*cos(phi);
            By=B*sin(theta)*sin(phi);
            Bz=B*cos(theta);
            vector=[Bx,By,Bz]';
        end
    end
    
end

