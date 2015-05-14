function  coh=cluster_coherence_check( obj,para,cluster_index,approx )
%coherence_check is used to check the single-spin cluster coherence for 0 or 1 pulse case
     tstep=para.tmax/(para.ntime-1);
     timelist=0:tstep:para.tmax;
     cluster=obj.get_cluster(cluster_index);
     nEntries=cluster.nEntries;
     switch nEntries
         case 1
             B0=cluster.lab_conditions.magnetic_field.vector;
             B0=obj.spin_bath.principal_axes*B0;
             gamma=cluster.entries{1}.gamma;
             S=cluster.entries{1}.S;
             

             lf_para.central_spin=obj.central_spin;%local field parameter           
             lf_para.state=para.state1;   
             cluster.set_bath_local_field('parameters',lf_para,'approx',approx);
             mf1=-S*gamma*(cluster.entries{1}.local_field+B0);
             b1=norm(mf1);
             n1=mf1/b1;

             lf_para.state=para.state2;   
             cluster.set_bath_local_field('parameters',lf_para,'approx',approx);
             mf2=-S*gamma*(cluster.entries{1}.local_field+B0);
             b2=norm(mf2);
             n2=mf2/b2;
             
     
         case 2
             
             hami1=cluster.HilbertSpace.operators.hami1;
             hami2=cluster.HilbertSpace.operators.hami2;
             gamma1=cluster.entries{1}.gamma;
             gamma2=cluster.entries{2}.gamma;
             gammap=gamma1*gamma2;
             if gammap>0 
                 b1z=0.5*norm(hami1(2,2)-hami1(3,3));
                 b2z=0.5*norm(hami2(2,2)-hami2(3,3));
                 b1x=real(hami1(2,3));
                 b2x=real(hami2(2,3));
                 b1y=imag(hami1(2,3));
                 b2y=imag(hami2(2,3));
             else
                 b1z=0.5*norm(hami1(1,1)-hami1(4,4));
                 b2z=0.5*norm(hami2(1,1)-hami2(4,4));
                 b1x=real(hami1(1,4));
                 b2x=real(hami2(1,4));
                 b1y=imag(hami1(1,4));
                 b2y=imag(hami2(1,4));
             end
             n1=[b1x;b1y;b1z];b1=norm(n1);n1=n1/b1;
             n2=[b2x;b2y;b2z];b2=norm(n2);n2=n2/b2;
     end
     
    switch para.npulse
         case 0
             coh=cos(b1*timelist).*cos(b2*timelist)+n1'*n2*sin(b1*timelist).*sin(b2*timelist);
         case 1
             coh=1-2*(norm(cross(n1',n2')))^2*((sin(b1*timelist/2)).^2).*((sin(b2*timelist/2)).^2);
         otherwise
             error('This function is used to check the single-spin cluster FID when npluse <=1.');
     end
end

