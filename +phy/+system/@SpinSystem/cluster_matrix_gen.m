function nc=cluster_matrix_gen(obj,order_cut)
%CLUSTER_MATRIX_GEN Summary of this function goes here
%   Detailed explanation goes here
disp('cluster_matrix_gen: building the clusters...');
obj.maxorder=order_cut;
mode=obj.clustering_method;
cluster_list=eye(obj.nEntries);
for n=1:(obj.maxorder-1)
    fprintf('generating clusters of order n=%d ...\n', n+1);
    neighbor_matrix=logical(cluster_list*obj.conmatrix); neighbor_matrix(logical(cluster_list))=0;
    new_cluster_list_size=nnz(neighbor_matrix)+nnz(sum(neighbor_matrix,2)==0);
    new_cluster_list=zeros(new_cluster_list_size,obj.nEntries);%,new_cluster_list_size*(n+1)
    pos=1;
    for k=1:size(cluster_list,1)
%         fprintf('calculating n=%d, k=%d/%d ...\n', n, k, size(cluster_list,1));
        spins_to_add=find(neighbor_matrix(k,:));
        if isempty(spins_to_add)
            new_cluster_list(pos,:)=cluster_list(k,:);
            pos=pos+1;
        else
            for m=spins_to_add
                new_cluster_list(pos,:)=cluster_list(k,:);
                new_cluster_list(pos,m)=1;
                pos=pos+1;
            end
        end
    end
    
   switch mode
       case 'CCE'
           cluster_list=unique([cluster_list;new_cluster_list],'rows');
       case 'RSS'
           cluster_list=unique(new_cluster_list,'rows');
   end
end

% if strcmp(mode,'SpecialCentralSpin')
%     cluster_list(:,1)=1;
% end

%% sort the states according to the none zero numbers of the clusters
[nrow,ncol]=size(cluster_list);
nz_list=zeros(nrow,1);%none zero list of state list
for n=1:nrow
    nz_list(n,1)=nnz(cluster_list(n,:));
end

A=[cluster_list,nz_list];
cols=fliplr(1:(ncol+1));
A=sortrows(A,cols);
cluster_list=A(:,1:ncol);
obj.cluster_matrix=sparse(logical(cluster_list));
nc=nrow;
%% output
   switch mode
       case 'CCE'
           nclu=cell(order_cut+1,2);
           nclu{order_cut+1,1}='CCE_cluster_endposition';
           for n=1:order_cut
               ncluster=length(find(nz_list==n));
               nclu{n,1}=['CCE-' num2str(n)];
               nclu{n,2}=ncluster;
               if n==1
                   nclu{order_cut+1,2}(1,n)=ncluster;
               elseif n>1
                   nclu{order_cut+1,2}(1,n)=nclu{order_cut+1,2}(1,n-1)+ncluster;
               end
               disp(['The number of ' num2str(n) '-spin clusters is: ' num2str(ncluster) '.']);               
           end
          obj.cluster_info.nclusters=nrow;
          obj.cluster_info.cluster_number_list=nclu;
      case 'Spinach'
          obj.cluster_info.nclusters=nrow;
          disp(['cluster_gen: ' num2str(obj.cluster_info.nclusters) ' clusters generated.']);
   end
end

