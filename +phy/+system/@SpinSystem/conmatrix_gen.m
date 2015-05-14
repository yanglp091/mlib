function conmatrix_gen(obj,cutoff,mode)
%CONMATRIX_GEN Summary of this function goes here
%   Detailed explanation goes here
    disp('conmatrix_gen: building the connection matrix...');
    spin_list=obj.entries;
    
    obj.cutoff=cutoff;
    con_matrix=zeros(obj.nEntries,obj.nEntries);
    for m=1:obj.nEntries
       for n=1:m-1
           coord1=spin_list{m}.coordinate;
           coord2=spin_list{n}.coordinate;
          dist=norm(coord1-coord2);
          if dist<cutoff(1)
           con_matrix(m,n)=1;
          end
           
       end
    end
    if strcmp(mode,'SpecialCentralSpin')
    con_matrix(2:cutoff(2),1)=1; %the central spin is coupled to all bath spins
    end
   
    con_matrix=con_matrix+con_matrix';
    obj.conmatrix=sparse(logical(con_matrix));
    disp('cluster_gen: connection matrix generated.');
end

