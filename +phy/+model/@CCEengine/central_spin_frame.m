function  central_spin_frame(obj,theta,phi )
%CENTRAL_SPIN_FRAME 
%the central spin zero-field polarization frame coordinate basis and transformation matrix ...
%%  it could be proofed that:  transfer_mat=basis
     if theta==0
        obj.coord_frame_info.reference_frame.coordinate_basis=[1,0,0;0,1,0;0,0,1];
     else
        zdir=sin(theta)*cos(phi)*[1,0,0]+sin(theta)*sin(phi)*[0,1,0]+cos(theta)*[0,0,1];
        xdir=-cross([0,0,1],zdir);xdir=xdir/norm(xdir);
        ydir=-cross(xdir,zdir);ydir=ydir/norm(ydir);
        obj.coord_frame_info.reference_frame.coordinate_basis=[xdir;ydir;zdir]; %three column vectors gives the transfer matrix from nature frame to the central-spin frame
     end
    [eigen_val,eigen_vector]=eigen_central_spin(obj);
     obj.coord_frame_info.reference_frame.eigen_vals=eigen_val;%central spin eigen values
     obj.coord_frame_info.reference_frame.eigen_vectors=eigen_vector;%each row is a eigen vector of the central spin
     obj.coord_frame_info.reference_frame.left_vectors=spin_val_vectors(obj,eigen_vector);

end

function hami=central_spin_hami(obj)
        transfer_mat=obj.coord_frame_info.reference_frame.coordinate_basis;
        B=obj.conditions.magnetic_field.vector;
        B_cs=transfer_mat*B;
        gamma=obj.central_spin.gamma;
        spinx=obj.central_spin.sx;
        spiny=obj.central_spin.sy;
        spinz=obj.central_spin.sz;
        ZFS=obj.conditions.reference_frequency;
        hami=ZFS*spinz*spinz-gamma*(B_cs(1,1)*spinx+B_cs(2,1)*spiny+B_cs(3,1)*spinz);
end

function [eigen_val,eigen_vector]=eigen_central_spin(obj)
    hami=central_spin_hami(obj);
    [V,D]=eig(hami);
    eigen_val=diag(D);
    eigen_vector=V'; %each row is a eigen vector
end

function svectors=spin_val_vectors(obj,V)
    spinx=obj.central_spin.sx;
    spiny=obj.central_spin.sy;
    spinz=obj.central_spin.sz;
    svectors=[diag(V*spinx*V'),diag(V*spiny*V'),diag(V*spinz*V')];
end
