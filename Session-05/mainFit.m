% This session will be centred around fitting. In particular, we will
% introduce the standard minimization algorithm of MATLAB, fminsearch. I
% will present an example of its use to fit a sine wave. We will then see
% the ?problem? of minimization algorithms, namely, local minimums where
% the algorithm gets stuck and cannot get out, thus, never reaching the
% global minima. After looking at the example we will work together so you
% fit a Gaussian to a dummy data set. Basically, we will generate a group
% of normally distributed random numbers, calculate the distribution of
% these (histogram), and fit a Gaussian to it.

% lets generate a sine wave

% first the user inputs. To define a sine wave we need: phase, amplitude
% and frequency.
%   phase in degrees
phaseDeg = 60;
%  Peak amplitude
ampl     = 3;
%   Frequency
freq     = 1.5;

% now I want to generate the sine wave to fit, i.e. our dummy experimental
% data
%   angular resolution in degrees
angResDeg= 0.1;
%   angles in degrees
angDeg   = 0:angResDeg:360;
%   angles in radians
angRad   = angDeg .* (pi/180);
%   phase in radians
phaseRad = phaseDeg * (pi/180);
%   sine wave
sinWave   = ampl.*sin(angRad.*freq +phaseRad);

% now we plot the data2fit
figure(1)
plot(angDeg,sinWave)
title('Data to fit','fontsize',14)
%% finding the function to minimize
% to fit we will use fminsearch, which finds the minimum of an
% unconstrained multivariable function. The function to minimize (fun) must
% be specified as a function handle or function name. 'fun' is a function
% that accepts a vector or array 'x' and returns a real scalar 'f'

% now lets try to come up with a function to minimize

% example of an initial guess
phaseGuess_deg = 15;
ampGuess = 10;
freqGuess = 2.2;

% storing the initial guess in an array x0
x0(1) = phaseGuess_deg*pi/180;
x0(2) = ampGuess;
x0(3) = freqGuess;

% storing the experimental input into a structure for better control
ExpInput.angles = angRad;
ExpInput.values = sinWave;

% prototipe of a function to minimize:
fitVal   = x0(2).*sin(ExpInput.angles.*x0(3) +x0(1));

dev    = fitVal-ExpInput.values;
nVal   = length(dev);
devSqr = (dev).^2;
RMSD = sqrt(sum(devSqr)/nVal);

figure(2)
plot(ExpInput.values,'k')
hold on
plot(fitVal,'b')
plot(dev,'r')
hold off
title(['RMSD: ' num2str(RMSD)])
legend({'Experimental','Fit','Deviation'})
shg

% now having this prototipe I create a function called fun2min and save it

%% Doing the fit
% example of an initial guess
phaseGuess_deg = 15;
ampGuess = 10;
freqGuess = 2; %3

% do I want visual aid
doFig = false;

% storing the initial guess in an array x0
x0(1) = phaseGuess_deg*pi/180;
x0(2) = ampGuess;
x0(3) = freqGuess;

% storing the experimental input into a structure for better control
ExpInput.angles = angRad;
ExpInput.values = sinWave;

% as you can see my function to minimize (fun2min) depends on more than
% just x. The extra parameters are not variables to optimize, they are
% fixed values during the optimization. To work this out we must create an
% anonymous function out of fun2min which only depends on x and includes
% the workspace value of the parameter.
fun = @(x) fun2min(x,ExpInput,doFig);

% then we can do:
[out, RMSD] = fminsearch(fun,x0);


[~, sinFit] = fun2min(out,ExpInput,false);

figure(1)
plot(ExpInput.angles,ExpInput.values,'k','linewidth',2)
hold on
plot(ExpInput.angles,sinFit,'--r','linewidth',2)
hold off
title(sprintf('Solution, RMSD: %0.4g',RMSD),'fontsize',14)
legend({'Experimental','Fit'},'fontsize',12)
shg

% show both examples with freqGuess = 2.2 and 3.0. So what happens with
% 3.0? local minima!!!
%% now lets add some noise
noise = randn(size(sinWave))*3;
ExpInput.angles = angRad;
ExpInput.values = sinWave+noise;
doFig = false;

fun = @(x) fun2min(x,ExpInput,doFig);
[out, RMSD] = fminsearch(fun,x0);
[~, sinFit] = fun2min(out,ExpInput,false);

figure(3)
plot(ExpInput.angles,ExpInput.values,'k')
hold on
% plot(ExpInput.angles,ExpInput.values,'--g')
plot(ExpInput.angles,sinFit,'r')
hold off
title(sprintf('Solution, RMSD: %0.4g',RMSD),'fontsize',14)
legend({'Experimental','Fit'},'fontsize',12)
shg

%% Assignment:
% The task for this session is to :

% 1) generate a list of uniformly distributed random numbers (randn), lets
% say 1000.

% 2) generate a distribution out of the list (histcounts) and store it for
% fitting.

% 3) fit the distribution using a gaussian function and fminsearch.