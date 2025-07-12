function [p] = generateMeshMcCrory(gmshpath, geoFile,contFile,supContFile)
    % generate an interface mesh from the point clouds given by McCrory et al., 2012
    % LINK TO THE SI OR REPO WHERE DATA WAS RETRIEVED
    % INPUTS
    % gmshpath: path to Gmsh application in system
    % geoFile: file name for the new *.geo and *.msh files that will be written
    % contFile: file name for the handrawn contours (must be space/tab delimited txt)
    % supContFile: file name for the smoothed contours (must be space/tab delimited txt)
    % OUTPUTS
    % geoFile.geo: Gmsh geo file 
    % geoFile.msh: Gmsh mesh file
    % p: patch structure containing fields
	% c	: all vertex coordinates; nc-by-3
	% v	: element vertex indices; nEl-by-3
	% nEl	: number of elements in each patch file
	% nc	: number of coordinates in each patch file
	% lon1  : longitude of all first vertices
	% lat1  : latitude of all first vertices
	% x1    : Geocentric x coordinate of all first vertices
	% y1    : Geocentric y coordinate of all first vertices
	% z1    : depth of all first vertices
	% z1z   : Geocentric depth of all first vertices
	% lon2  : longitude of all second vertices
	% lat2  : latitude of all second vertices
	% x2    : Geocentric x coordinate of all second vertices
	% y2    : Geocentric y coordinate of all second vertices
	% z2    : depth of all second vertices
	% z2z   : Geocentric depth of all second vertices
	% lon3  : longitude of all third vertices
	% lat3  : latitude of all third vertices
	% x3    : Geocentric x coordinate of all third vertices
	% y3    : Geocentric y coordinate of all third vertices
	% z3    : depth of all third vertices
	% z3z   : Geocentric depth of all third vertices
	% lonc  : longitude of element centroid
	% latc  : latitude of element centroid
	% zc    : depth of element centroid
	% xc    : Geocentric x coordinate of element centroid
	% yc    : Geocentric y coordinate of element centroid
	% zcz   : Geocentric depth of element centroid
	% area  : area of element in square km
	% nv    : normal vector components of each triangle
	% strike: strike of each element
	% dip   : dip of each element

% gmshpath = '/Applications/Gmsh.app/Contents/MacOS/';
% geoFile = 'mccrory_contours';

% load contours
og_cont = readmatrix(contFile);
sup_cont = readmatrix(supContFile);

% remove contours below 40 km
og_cont = og_cont(og_cont(:,3)>-40.1,:);

% we need to supplement the 5 km contour using the smoothed geometry
sup_cont = sup_cont(sup_cont(:,3)>-5.1,:);

% find where the smooth 5 km contour exists north of the handdrawn contour
loc = sup_cont(:,2)>max(og_cont(og_cont(:,3)==-5,2))+0.1 & ...
    sup_cont(:,2)<49.8;

% supplement the handdrawn with the smoothed 
cont = [flipud(sup_cont(loc,:));og_cont];

% now need to do an approximation for the 10 km contour; we'll plot the
% contour as the middle of the 5 and 15 
tmp = cont(cont(:,3)==-5,:);
loc = tmp(:,2)>max(og_cont(og_cont(:,3)==-5,2))+0.1;
tmp2 = cont(cont(:,3)==-15,:);
loc2 = tmp2(:,2)>max(og_cont(og_cont(:,3)==-5,2))+0.1;
vq = interp1(tmp(:,2),tmp(:,1),49.1:0.05:49.75);
vq2 = interp1(tmp2(:,2),tmp2(:,1),49.1:0.05:49.75);
tmp_cont = [((vq+vq2)/2)' [49.1:0.05:49.75]' ones(length(vq),1)*-10];

% supplement the handdrawn with the new 10 km extension
cont = [cont(1:find(cont(:,3) == -10,1,'last'),:);tmp_cont;
    cont(find(cont(:,3) == -10,1,'last')+1:end,:)];


% generate a Gmsh countour file
contour2geo(cont(:,1), cont(:,2), cont(:,3), 20, geoFile, 4.12)

% generate the mesh
system(sprintf('%s/gmsh -2 %s.geo -o %s.msh -v 0 > junk', gmshpath,...
    geoFile, geoFile));

% load the mesh coordinates
p = ReadPatches([geoFile '.msh']);

% find only the vertices used for elements
uvert = unique(p.v(:));

% get rid of any unused vertices
k = 1; p_old = p;
for i = 1:p_old.nc
    if ismember(i,uvert)
        loc = p_old.v == i;
        p.v(loc) = k;
        k = k+1;
    end
end
p.c = p.c(uvert,:);
p.nc = size(p.c,1);

% convert from xyz to lat lon dep
[long, lat] = xyz_to_long_lat(p.c(:,1), p.c(:,2), p.c(:,3));
dep = sqrt(p.c(:,1).^2+p.c(:,2).^2+p.c(:,3).^2)-6371;
p.c = [rad2deg(long) rad2deg(lat) round(dep,1)];




