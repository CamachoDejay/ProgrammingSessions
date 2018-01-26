function [f_depth] = mandelbrot(real_idx,im_idx,depth)
%mandelbrot: numerical solution to the mandelbrot fractal. calculates the
%iteration depth at which a number leaves the set, if it does not leave
%after the max interation depth (depth) then it returns 0
%   Detailed explanation goes here

assert(isvector(real_idx),'problem with real part');
assert(isvector(im_idx),'problem with imaginary part');
assert(isinteger(depth),'depth must be a positive integer')
assert(depth<65535,'depth can not be larger than 65535')
assert(isreal(real_idx),'numbers in real indices must be real numbers')
assert(isreal(im_idx),'numbers in imaginary indices must be real numbers')

% generation of the grid
[a, b] = meshgrid(real_idx,im_idx);
% change the grid into complex numbers
z0 = complex(a,b);

% now we calculate the set
%   1) Init of parameters
%       function values to 0
f_val = zeros(size(z0));
%       we are doing a numerical aproximation of the set. That means that I
%       do not calculate the set to infinity. To make the figure more
%       interesting I can keep track of at which iteration depth the number
%       went out of the set.
f_depth = uint16(ones(size(z0)));
%   2) we start the iteration
for n = 1:depth
    % calculate the function value for the particular iteration depth
    f_val = f_val.^2+z0;
    % check if at this depth the complex number is in or out of the set
    tmp_idx = abs(f_val)<2;
    % numbers in tmp_idx are in the set for a calculation depth of n thus I
    % increase their value
    f_depth(tmp_idx) = n+1;
    % numbers that are not in tmp_idx have left the set at iteration n (or
    % lower)     
end
% moreover, if the number never left the set then this is a special case
f_depth(tmp_idx) = 0;
end

