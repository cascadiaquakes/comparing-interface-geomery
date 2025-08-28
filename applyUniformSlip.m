function [Gu p vel] = applyUniformSlip(p,stats,slipIn)
    % apply uniform slip to a mesh and calculate the resulting surface
      % displacements
%%%%% --------------------------- INPUTS --------------------------- %%%%%
    % p: the mesh structure 
    % stats: a structure containing stats.lat (latitude) and stats.lon
      % (longitude) for all locations to calculate displacements at
    % slipIn: a 1-by-3 array containing the strike slip, dip slip, and
      % tensile slip to be applied to ever element of the mesh
      
%%%%% --------------------------- OUTPUTS --------------------------- %%%%%
    % Gu: a matrix containing the partials relating slip on p to surface 
      % displacements; 3*number of disp. location by 3*p.nEl
    % p: the mesh structure
    % vel: the surface velocities resulting from the applied uniform slip;
      % 3*number of disp. location by 1
      
%%%%% ---------------------------- CODE ---------------------------- %%%%%
% get the partials
[Gu e p stats] = GetTriCombinedPartials(p,stats,[1 0]);

% expand the slip into a matrix 
slip = stack3(repmat(slipIn,p.nEl,1));

% calculate the displacements at station locations
vel = Gu*slip;



