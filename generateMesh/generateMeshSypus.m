function [p] = generateMeshSypus(gmshpath, geoFile,contFile)
    % generate an interface mesh using contours from Sypus & Wang, 2024
    
%%%%% --------------------------- INPUTS --------------------------- %%%%%
    % gmshpath: path to Gmsh application in system
    % geoFile: file name for the new *.geo and *.msh files to be written
    % contFile: file name for the contours (must be space/tab delimited txt)
    
%%%%% --------------------------- OUTPUTS --------------------------- %%%%%
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

%%%%% ---------------------------- CODE ---------------------------- %%%%%
% gmshpath = '/Applications/Gmsh.app/Contents/MacOS/';
% geoFile = 'sypus_geom_contours';

% geoFile = 'sypus_adjB_contours';
% og_cont = readmatrix('Adj_B_contours.txt','Delimiter',[" ","\t"]);

% load contours
og_cont = readmatrix(contFile,'Delimiter',[" ","\t"]);

% make dep negative
og_cont(:,3) = -og_cont(:,3);

% find any lines containing NaN
for i = 1:size(og_cont,1) 
    if max(isnan(og_cont(i,:)))<1 
        keep(i) = 1; 
    else 
        keep(i) = 0; 
    end
end

% remove any NaN lines
og_cont = og_cont(logical(keep),:);

% remove contours below 40 km
og_cont = og_cont(og_cont(:,3)>-40.1,:);

% down sample to get median latitude difference between points ~0.05
cont = og_cont(1:20:end,:);

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




