function out = tricentroid(v,tri)
% Function to output the centroid of triangluar elements.
% Note that the output will be of length(tri)x3
% Input:    <v>     nx2 or 3: vertices referenced in tri
%           <tri>   mx3: triangle indices
% Version:      1
% JOK 300509

% I/O check
[nv,mv]=size(v);
[nt,mt]=size(tri);
if mv==2
    v(:,3) = zeros(nv,1);
elseif mt~=3
   tri=tri';
end

out(:,1) = 1/3*(v(tri(:,1),1)+v(tri(:,2),1)+v(tri(:,3),1));
out(:,2) = 1/3*(v(tri(:,1),2)+v(tri(:,2),2)+v(tri(:,3),2));
out(:,3) = 1/3*(v(tri(:,1),3)+v(tri(:,2),3)+v(tri(:,3),3));
end%tricentroid