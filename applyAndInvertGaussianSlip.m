function [out, g, velg] = applyAndInvertGaussianSlip(p_in,u_in,p,u,xyz,A,beta,noise)
    % apply a Gaussian slip distribution (purely dip slip) to one mesh, 
      % calculate displacements and invert those displacements onto a 
      % second mesh
    % INPUTS 
    % p_in: the mesh structure that the slip distribution is applied to
    % u_in: the partials relating slip on p_in to surface displacements
    % p: the mesh structure that the displacements calculated using the
      % applied slip will be inverted onto
    % u: the partials relating slip on p to surface displacements
    % xyz: a 1-by-3 array containing the longitude, latitude, and z
      % coordinates for the centroid of the slip distribution
    % A: the maximum slip magnitude; at xyz, slip = A
    % beta: the smoothing weighting value
    % noise: a matrix of random noise to be added to the displacements
      % that are inverted; 3*number of disp. locations by number of desired 
      % iterations to run
    % OUTPUT 
    % out: a matrix containing the output slip distribution; 2*p.nEl by
      % number of iterations; (1:2:end,i)=strike slip; (2:2:end,i)=dip slip
    % g: an array containing the input dip-slip distribution applied to
      % p_in
    % velg: an array containing the displacements calculated using u_in; 
      % 3*number of disp. locations; 1:2:end=strike slip; 2:2:end=dip slip
      
% remove the tensile slip component if exists in u
if size(u,2)/p.nEl == 3
    clear('keep')
    for i = 1:p.nEl
        keep(i*2-1) = i*3-2;
        keep(i*2) = i*3-1;
    end
    u = u(:,keep);
end

% remove the tensile slip component if exists in u_in
if size(u_in,2)/p_in.nEl == 3
    clear('keep')
    for i = 1:p_in.nEl
        keep(i*2-1) = i*3-2;
        keep(i*2) = i*3-1;
    end
    u_in = u_in(:,keep);
end

% apply Gaussian slip 
% calculate gaussian slip distribution on p_in mesh
x = wrapTo360(p_in.lonc)-wrapTo360(xyz(1));
y = p_in.latc-xyz(2);
z = p_in.zc+xyz(3);
g = A * exp(-((x.^2/10)+(y.^2/10)+(z.^2/100)));

% put the slip distribution into array [strike-slip dip-slip]
sg = zeros(length(x)*2,1);
for i = 1:p_in.nEl
   sg(i*2) = g(i);
end

% calculate the surface displacements
velg = u_in*sg;

% apply a weight to the surface displacements for the inversion
wgt = ones(size(noise(:,1)))*0.1;

% find element neighbors
share = SideShare(p.v);

% make the smoothing matrix
sm = MakeTriSmoothAlt(share);
clear('keep')
for i = 1:p.nEl
   keep(i*2-1) = i*3-2;
   keep(i*2) = i*3-1;
end
sm = sm(keep,keep);

% weighting matrix
wd                                  = 1./wgt.^2;
wc                                  = [wd; beta.*ones(size(sm, 1), 1)]; 
Wc                                  = diag(wc); % assemble into a matrix

% Jacobian
G                                   = [u; sm];

for i = 1:size(noise,2)
    
%     dc = [(velg+(velg.*noise(:,i))); zeros(size(sm, 1), 1)];
    dc = [(velg+noise(:,i)); zeros(size(sm, 1), 1)];
    
    % Laplacian smoothing inversion
    out(:,i)                             = (G'*Wc*G)\(G'*Wc*dc);
end


