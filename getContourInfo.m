function [int_lon,int_strike,int_dip] = getContourInfo(c,p,xq,tol)
    % grab the average strike, dip and longitude at each vertex on a given contour depth
    % INPUTS
    % c: the depth at which to draw a contour
    % p: the patch structure containing fields c, v, dip and strike
    % xq: the latitudes to query strike dip and longitude at
    % tol: the depth tolerance (km) with which to include element vertices for the specified depth (c)
    % OUTPUTS
    % int_lon: average longitude at each latitude specified in xq
    % int_strike: average strike at each latitude specified in xq
    % int_ dip: average dip at each latitude specified in xq

% grab the vertices at a specific contour depth
vrts = find(p.c(:,3) >c-tol &p.c(:,3) <c+tol);

% interpolate longitude for contour
int_lon = interp1(p.c(vrts,2),wrapTo360(p.c(vrts,1)),xq);

% grab elements the include each vertex
for i = 1:size(vrts,1)
    els = (ismember(p.v(:,1),vrts(i))+ismember(p.v(:,2),vrts(i))+ismember(p.v(:,3),vrts(i))) > 0;  
    % calculate the average strike of all selected elements
    avg_strike(i) = mean(wrapTo180(p.strike(els)));
    % calculate the average dip of all selected elements
    avg_dip(i) = mean(wrapTo180(p.dip(els)));
end

% remove any NaN values from the results and interpolate
vrts = vrts(~isnan(avg_strike));
avg_strike = avg_strike(~isnan(avg_strike));
int_strike = interp1(p.c(vrts,2),avg_strike,xq);
avg_dip = avg_dip(~isnan(avg_dip));
int_dip = interp1(p.c(vrts,2),avg_dip,xq);