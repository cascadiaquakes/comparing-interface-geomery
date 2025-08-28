function lonWrapped = wrapTo360(angles)
% wrapTo360 wraps any angle to between 0 and 360 degrees; written for
    % Octave use
%%% INPUTS %%%
% angles: a vector of angles 
%%% OUTPUTS %%%
% lonWrapped: the angles between 0 and 360 degrees
leftover = rem(angles,360);
lonWrapped = leftover;
lonWrapped(leftover<0) = leftover(leftover<0)+360;
lonWrapped(leftover>360) = leftover(leftover>360)-360;



