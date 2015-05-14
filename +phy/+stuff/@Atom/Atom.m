classdef Atom < phy.stuff.PhysicalObject
    %ATOM is used to describe atoms like alkali metal atoms. Atom class uses the database of atomic structure.
    %
    %   .. note::
    %      Atom class does not involve quantum mechanical properties.
    %
    %   .. seealso::
    %      :ref:`Alkali` for quantum mechanical system.


    
    properties
        parameters  % atomic structure parameters
        vilocity    % atom velocity

    end
    
    methods
        function obj = Atom(name)
            % Constructor, create an atom with given name.
            %
            % :parameters: 
            %    * name - atom name
            % 
            % :Example:
            %
            %    >>> phy.stuff.Atom('87Rb')
            

            obj.name=name;
            obj.parameters=data.AtomicStructure.get_parameters(name);
            obj.dim=obj.parameters.dim;
        end
    end
    
end

