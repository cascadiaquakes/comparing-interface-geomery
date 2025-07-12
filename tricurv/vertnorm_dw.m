%%
function nv=vertnorm_dw(tri,p)
% Function to compute normal vector of vertices comprising a triangular
% mesh. Based on trinormal and computeNormalVectorTriangulation.m by David
% Gringas
% Input:    tri mx3 <triangular index matrix>
%           p nx3 array of vertices
% Output:   nvec <nx3> array of normal vectors
% JOK230709
% Version: 1

% I/O check
% to be completed

% Construct vectors 
v = [p(tri(:,3),1)-p(tri(:,1),1), p(tri(:,3),2)-p(tri(:,1),2), p(tri(:,3),3)-p(tri(:,1),3)];
w = [p(tri(:,2),1)-p(tri(:,1),1), p(tri(:,2),2)-p(tri(:,1),2), p(tri(:,2),3)-p(tri(:,1),3)];
% Calculate cross product
normvec = [v(:,2).*w(:,3)-v(:,3).*w(:,2), ...
    -(v(:,1).*w(:,3)-v(:,3).*w(:,1)), ...
    v(:,1).*w(:,2)-v(:,2).*w(:,1)];
% Normalize
lnvec = sqrt(sum(normvec.*normvec,2));
nvec = normvec./repmat(lnvec,1,3);

% Average at vertices
itri=buildInverseTriangulation(tri);
nvecx=zeros(length(p),1);
nvecy=zeros(length(p),1);
nvecz=zeros(length(p),1);
for j=1:length(p)
    % Find centroids and weight based on distance:
    ind01=removeD0(itri(j,:));
    cen=tricentroid(p,tri(ind01,:));
    nc=size(cen);
    distcen = cen-repmat(p(j,:),nc(1),1);
    w = 1./sqrt(sum(distcen.*distcen,2));
    nvecx=mean(w.*nvec(ind01,1));
    nvecy=mean(w.*nvec(ind01,2));
    nvecz=mean(w.*nvec(ind01,3));
    % Nomalize
    lnv = sqrt(nvecx^2+nvecy^2+nvecz^2);
    nv(j,:) = [nvecx/lnv,nvecy/lnv,nvecz/lnv]; 
end

end % End vertnorm