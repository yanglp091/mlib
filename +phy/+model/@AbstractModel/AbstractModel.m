classdef AbstractModel < handle
    %ABSTRACTMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        solution
        conditions
        summary
    end
    
    methods
        function obj=AbstractModel(conditions)
            obj.conditions=conditions;
            obj.solution=[];
        end
        
        function save_solution(obj, filename)
            saved_solution=obj.solution;
            save(filename, 'saved_solution');
        end
    end
    
end

