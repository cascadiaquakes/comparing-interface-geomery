function invTRI=buildInverseTriangulation(TRI)
% Building the inverse triangulation, i.e. a link from node indexes to
% triangle indexes.
nbTri=length(TRI);
nbNode=max(reshape(TRI,[],1));
comp=zeros(nbNode,1);
invTRI=zeros(nbNode,8);

for i=1:nbTri
   for j=1:3
       index=TRI(i,j);
       comp(index)=comp(index)+1;
       invTRI(index,comp(index))=i;
   end
end
end % End buildInverseTriangulation