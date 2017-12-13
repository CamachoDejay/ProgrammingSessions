% During this session, we will concentrate on how to make calculations in
% MATLAB more efficient and easy to read by avoiding loops and vectorizing
% the code:

clear
close all
clc

% lets start by creating a vector of 10000 numbers, linearly spaced between
% -5 and 5. We can do this by:
x = linspace(-5,5,10000);
% now what if we want to calculate the parabola y = a x^2 with a = 2. One
% way of doing this is to use a for loop to operate over each element of
% our vector x and then store these results in a vector y
a = 2;
% initialize the y vector where we will store the calculation results
y = zeros(size(x));
% I want to keep track of the time MATLAB takes to run over my statements
% so I use tic() to start the clock.
tic;
% iterate over each ellement of the vector x
for idx = 1:length(x)
    % indexing over x to get the ellement I want
    tmp = x(idx);
    % doing the calculation
    tmp = a*tmp^2;
    % storing the value
    y(idx) = tmp;
end
% stop the clock and store its value
tFoorLoop = toc;

% Now we plot the results
figure(1)
plot(x,y)
% I print in the title also the time it sook to make the calculation in ms
title({'Parabola: Y = 2 X^2',...
        sprintf('It took %0.2f [ms]', tFoorLoop*1000)})
%%    
% While the code above is correct MATLAB has many built in functionalities
% to handle this kind of operations (same operation over every element on
% an array). This is referred to as Vectorization of the code. Lets see the
% vectorized version of the code above:
x = linspace(-5,5,10000);
a = 2;
% start the time
tic;
% square each element of x
y = x.^2; % notice the . notation before the ^ operation
% multiply each element of y by "a"
y = y.*a; % notice the . notation before the * operation
tVec = toc;
% I have separated both operations so it is easier to read however we can
% do all in one line: y = (x.^2).*a;

% Now we plot the results
figure(2)
plot(x,y)
% I print in the title also the time it sook to make the calculation in ms
title({'Parabola: Y = 2 X^2',...
        sprintf('It took %0.2f [ms]', tVec*1000)})
% as you can see there is a substantial difference not only in speed but in
% how complicated the code looks and thus how easy it is to read/understand
% it.

%%
% now let us go back to the Mandelbrot project:
% lets calculate if a single number belongs to the set

% imaginary number to calculate:
z0 = complex(0,0.9);
% maximun iteration depth
depth = 100;
% initial trajectory value
tVal = 0;
% counter for the while loop
counter = 0;

% now the while loop with the condition that the trajectory value is
% smaller than 2 and that we have not reached the max iteration depth
while and(abs(tVal)<=2,counter<depth) 
    % we increase counter
    counter = counter+1;
    % calculate the value of the trajectory
    tVal = tVal^2 + z0;   
end

if abs(tVal)<=2
    fprintf('The value did not leave the set for max iteration: %i \n', counter)
else
    fprintf('The value leaves the set at iteration: %i \n', counter)   
end

%%
% lets package this into a function and calculate how much it would take us
% too iterate over a matrix of 300x300 numbers.

nPix = 300;
% maximun iteration depth
depth = 100;
        
realIdx = linspace(-2,1,nPix);
imagIdx = linspace(-1.6,1.6,nPix);

imOut = zeros(nPix,nPix);
tic
for i = 1:length(realIdx)
    realPart = realIdx(i);
    for j = 1:length(imagIdx)
        imagPart = imagIdx(j);
        % imaginary number to calculate:
        z0 = complex(realPart,imagPart);
        
        % calculation for a single number
        [counter] = mandelSingleNum(z0, depth);
        imOut(i,j) = counter;
    end
    
end
tLoop = toc;
figure(3)
imagesc(imOut')
cMap = jet(double(depth)+1);
cMap(1,:) = [0 0 0];
title(sprintf('Calculation time: %0.1f [ms]', tLoop*1000))
colormap(cMap)

%%
% now lets try to vectorize that code
nPix = 300;
% maximun iteration depth
depth = 100;
        
realIdx = linspace(-2,1,nPix);
imagIdx = linspace(-1.6,1.6,nPix);

tic
% generation of the grid
[a, b] = meshgrid(realIdx,imagIdx);
% change the grid into complex numbers
z0 = complex(a,b)';

% now we calculate the set
%   1) Init of parameters
%       function values to 0
f_val = zeros(size(z0));
%       we are doing a numerical aproximation of the set. That means that I
%       do not calculate the set to infinity. To make the figure more
%       interesting I can keep track of at which iteration depth the number
%       went out of the set.
imOutVec = uint16(ones(size(z0)));
%   2) we start the iteration
for n = 1:depth
    % calculate the function value for the particular iteration depth
    f_val = f_val.^2+z0;
    % check if at this depth the complex number is in or out of the set
    tmp_idx = abs(f_val)<2;
    imOutVec(tmp_idx) = n+1; 
end
imOutVec(tmp_idx) = 0;
tVec = toc;

figure(4)
imagesc(imOutVec')
cMap = jet(double(depth)+1);
cMap(1,:) = [0 0 0];
title(sprintf('Calculation time: %0.1f [ms]', tLoop*1000))
colormap(cMap)

% as you can see, this time, we did not gain much in terms of speed. This
% is because we keep calculating over the whole array without throwing away
% the indices that quickly leave the set. Moreover, the code is much easier
% to read (we avoided nested loops), and even without packaging it into a
% function it became very short.