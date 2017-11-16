% After the first two session we start to have a feeling as to how we can
% get a program to take some user input, do some calculations based on that
% input to generate output and finally communicate that output back to the
% user. On the third session we will concentrate a bit more into the basics
% of computation. We will learn how to generate more complicated
% expressions, how to make our program to choose among different
% alternatives (selection), and how to repeat a computation many times
% (iteration). Finally we will learn how to keep code clean, reusable and
% maintainable by separating a particular sub-computation into a function.

%% if statements - Careful with elseif
a = 1;

if a < 5
    disp('Smaller than 5!')
elseif a < 2
    disp('Smaller than 2!')
else
    disp('Larger than 5!')
end

% Notice that MATLAB includes the syntax "elseif" this basically means
% that we can evaluate a if a second selection rule (condition) is valid or
% not. However, be aware! it is your responsibility to ensure no overlap
% between the different conditions. This is important because once the
% program enters into one of the if cases and evaluates the associated
% statements it will go out of the if block.

%% switch statemtns - a numeric case
% this is a simple example that checks if the user wins or not a price.

n = input('Enter a integer between 0-9: ');
n = uint16(n);
switch n
  case {2, 3}
    disp('You almost won! Good luck next time!')
  case 4
    disp('You won! AWESOME!')
  case {5,6}
    disp('You almost won! Good luck next time!')
  otherwise
    disp('Not even close! Good luck next time')
end
%% while loop
% we will use a while loop to consecutively square a number untill it
% overflows the capacity of the computer

n = input('Enter a number: ');
val = n;
go = isfinite(val);
counter = 0;
while go
    counter = counter + 1;
    val = val^2;
    go = isfinite(val);
end
fprintf('We had to consecutively square the value %4.2f %d times to overflow the computer \n', n, counter)

% Now, one of the most important things with while loops is to make sure
% that we do not generate an infinite loop. See my code above, is it safe
% to use? what if the user inputs 1, 0, or 0.5?
%% for loop
% A classical example that iterates over a vector and does some calculation
% (in this case squares) is as follows:
x = -10:1:10;
y = zeros(size(x));
for idx = 1:length(x)
    i_val = x(idx);
    y(idx) = i_val^2;
end
figure(1)
plot(x,y)
xlabel('x values')
ylabel('y values')
title('y = square(x)')

%% another alternative
x = -10:1:10;
y = zeros(size(x));
idx = 1;
for i_val = x
    y(idx) = i_val^2;
    idx = idx + 1;
end
figure(1)
plot(x,y)
xlabel('x values')
ylabel('y values')
title('y = square(x)')

%% my_mean() function

a = rand(100,1);

my_val = my_mean(a);

MATLAB_val = mean(a);

assert(my_val == MATLAB_val, 'houston we have a problem')

%% Assignment:
% The task for this session is to go back to Project01,
% Step01(camachodejay.com/Project01-Step01) and:

% 1) come up with a while and for loop implementation that calculates the
% Mandelbrot set. Basically we will solve together the last assignment of
% the first step of the project.

% 2) save both implementations into a function file. Use a switch statement
% to let the user choose which implementation he wants to use, the for or
% while loop.

% 3) as an extra bonus look into the tic/toc functions of MATLAB, what do
% they do? use them to see which implementation is the fastest.