function [p] = generateMeshBloch(gmshpath, geoFile,ptFile,trenchFile)
    % generate a mesh from the point clouds given by Bloch et al., 2023
    
%%%%% --------------------------- INPUTS --------------------------- %%%%%
    % gmshpath: path to Gmsh application in system
    % geoFile: file name for the new *.geo and *.msh files t0 be written
    % ptFile: file name for the point cloud (must be *.nc)
    % trenchFile: file name for trench trace coordinates, an m-by-2 matrix
      % with long in column 1 and latitude in column 2 (must be ordered
      % north to south)

%%%%% --------------------------- OUTPUTS --------------------------- %%%%%
    % geoFile.geo: Gmsh geo file 
    % geoFile.msh: Gmsh mesh file
    % p: patch structure containing fields
        % c     : all vertex coordinates; nc-by-3
        % v     : element vertex indices; nEl-by-3
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

%%%%% ---------------------------- CODE ---------------------------- %%%%%
% gmshpath = '/Applications/Gmsh.app/Contents/MacOS/';
% geoFile = 'blochc_contours';
% geoFile = 'blocht_contours';

% load variables
og_dep = ncread(ptFile,'z');
og_lon = ncread(ptFile,'lon');
og_lat = ncread(ptFile,'lat');
trench = load(trenchFile);

% depth needs to be negative
og_dep = -og_dep;

% create lat-lon grid
[glat,glon] = meshgrid(og_lat,og_lon);

% getContours
contSpc = [-10:-5:-35];

% contour data
depC = contour3(glon,glat,og_dep,contSpc);

% parse contour matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% add contourdata script
s = contourdata(depC);

cont = [];
for i = 1:length(s)
    % need to regularize the spacing by only keeping one point per 0.04°
    % lat
    loc = ismember(s(i).ydata,glat);
    %compile all contours into one matrix
    cont = [cont; s(i).xdata(loc), s(i).ydata(loc), s(i).level*ones(length(s(i).xdata(loc)),1)];
end

% add the trench contour
trench = [trench(:,1), trench(:,2), ones(size(trench,1),1)*-3.5];
trench(end,1) = 235;
trench(end-1,1) = 235;
cont = [cont;flipud(trench)];

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
p.c = [wrapTo360(rad2deg(long)) rad2deg(lat) round(dep,1)];
p = PatchCoords(p);

