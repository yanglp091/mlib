function magnetic_field_frame(obj)
%MAGNETIC_FIELD_FRAME 
%calculate the basis of the magnetic field frame basis and transformation matrix
%%  it could be proofed that:  transfer_matrix=basis
    theta=obj.conditions.magnetic_field.polar_vector(2);
    phi=obj.conditions.magnetic_field.polar_vector(3);
    if theta==0
        obj.coord_frame_info.mf_frame.coordinate_basis=[1,0,0;0,1,0;0,0,1];

    else
        zdir=sin(theta)*cos(phi)*[1,0,0]+sin(theta)*sin(phi)*[0,1,0]+cos(theta)*[0,0,1];
        xdir=-cross([0,0,1],zdir);xdir=xdir/norm(xdir);
        ydir=-cross(xdir,zdir);ydir=ydir/norm(ydir);
        obj.coord_frame_info.mf_frame.coordinate_basis=[xdir;ydir;zdir];%three column vectors gives the transfer matrix from nature frame to the magnetic-field frame

    end
end

