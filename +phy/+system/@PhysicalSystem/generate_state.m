function generate_state( obj, mode, state )
%GENERATE_STATE Summary of this function goes here
%   Detailed explanation goes here
switch mode
    case 'thermal'
        obj.LiouvilleSpace.vectors(state.name)=state.vector;
    case 'pure'
        obj.HilbertSpace.vectors(state.name)=state.vector;
end

end

