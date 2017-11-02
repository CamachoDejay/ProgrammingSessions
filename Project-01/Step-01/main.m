% main for the first step of project-01 of the Programming Sessions. It
% first generates a list of real and imaginary indices used for the
% calculation of the mandelbrot set. Then calculates the set using a
% function called mandelbrot and finally displays the output to the user
% via a color plot.

clear
close all
clc

% USER INPUT: see this week's asignment
% max number of pixels
max_n_pix = 300;
% calculation depth
depth =100;
% limits in the complex plane
%   x axis - horzontal in the plot
xmin = -2;
xmax = 1;
%   y axis - vertical in the plot
ymin = -1.6;
ymax = 1.6;
% END OF USER INPUT



% generation of the finite grid used for numerical calculation
%   1) get the size of each axis based on user input
xwidth = xmax - xmin;
ywidth = ymax - ymin;
%   2) Calculate the longest axis and fix the resolution, in such a way
%   that we optain the desider pixel resolution
if xwidth > ywidth
    x = linspace(xmin,xmax,max_n_pix);
    res = x(2)-x(1);
    y = ymin:res:ymax;
else
    y = linspace(ymin,ymax,max_n_pix);
    res = y(2)-y(1);
    x = xmin:res:xmax;
end

% Now we calculate if the points in the complex plane defined by the
% indices x: real and y: imaginary belong to the set or not. The output
% f_depth tells you for which iteration depth the point left the set by
% having an absolute trajectory value >= 2.


% as I have hiden the way my function works from you I tell you now how the
% input must look like:
% x: must be the index of the real axis to calculate. it must be a vector
% and all numbers must be real.
% y: must be the index of the imaginary axis to calculate. it must be a 
% vector and all numbers must be real.
% depth is the maximum iteration depth to use and it must be a positive
% integer. Thus:
depth = uint16(depth);

[f_depth] = mandelbrot(x,y,depth);

% now we plot
%   1) I want control over the axis ticks, their value and their label
%   string. imaginary goes in Y and real part goes in X
%   Imaginary part
i_val  = linspace(ymin,ymax,10);
i_idx  = linspace(1,length(y),10);
i_val = num2cell(round(i_val,4));
i_str = cellfun(@(x) num2str(x,'%0.1f'),i_val,'UniformOutput',false);
%   Real part
r_val  = linspace(xmin,xmax,10);
r_idx  = linspace(1,length(x),10);
r_val = num2cell(r_val);
r_str = cellfun(@(x) num2str(x,'%0.1f'),r_val,'UniformOutput',false);
%   now we create the figure
figure(1)
subplot(1,2,1)
imagesc (f_depth) 
set(gca,'YTick',i_idx, 'YTickLabel',i_str,'XTick',r_idx, 'XTickLabel',r_str)
axis image
colormap(flipud(jet(double(depth)+1)))
title('Normal scale')
xlabel('Real')
ylabel('Imaginary')

subplot(1,2,2)
imagesc (log10(f_depth)) 
set(gca,'YTick',i_idx, 'YTickLabel',i_str,'XTick',r_idx, 'XTickLabel',r_str)
axis image
colormap(flipud(jet(double(depth)+1)))
title('Log scale')
xlabel('Real')
ylabel('Imaginary')

return
%% Weeks asignment
% 1) Change the code using what you have learned so far to ask the user for
% input when the program starts. See session-02 material

% 2) Try to understand the code! If you see any function which you do
% not recognize go to MATLAB?s documentation and see what it does.

% 3) As you can see I have hidden from you the way I calculate the depth
% values for the Mandelbrot set. Currently, this is done by the function
% mandelbrot.p. Your last task is to come up with your own way of
% calculating the mandelbrot depth value (your own implementation). For
% this last part feel free to make groups among you (max 4 students).



