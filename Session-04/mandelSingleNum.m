function [counter] = mandelSingleNum(compNum, depth)
% calculates the interation depth at which a number leaves the mandelbrot
% set, if it does not leave after the max interation depth (depth) then it
% returns 0
%   Detailed explanation goes here

% compNum:  imaginary number to calculate:
% depth:    maximun iteration depth

% initial trajectory value
tVal = 0;
% counter for the while loop
counter = 0;

% while loop with the condition that the trajectory value is smaller than 2
% and that we have not reached the max iteration depth
while and(abs(tVal)<=2,counter<depth)
    counter = counter+1;
    tVal = tVal^2 + compNum;
end

if abs(tVal)<=2
    counter = 0;
end
end

