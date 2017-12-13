% In this session, we will concentrate on solving a system of linear
% equations, A*x = b, using the function mldivide. We will use it to do
% some very basic spectral unmixing. Basically, we will decompose a mixed
% fluorescence spectra (containing 2 known species) into its constituent
% spectra, and find the relative ratio between the species.

clear
close all
clc

% loading fluorescence spectra of EGFP which is at EGFP.csv
% By first having a quick look at the files in a text editor I know I have
% to skip the first row as it only contains the name of the variables:
% wavelength, excitation, and emission spectra.
filename = 'EGFP.csv';
tmp = csvread(filename,1);
EGFP.wavelength = tmp(:,1);
EGFP.ex = tmp(:,2);
EGFP.em = tmp(:,3);

% loading fluorescence spectra of Rhodamine 6G
filename = 'Rhodamine 6G.csv';
tmp = csvread(filename,1);
r6g.wavelength = tmp(:,1);
r6g.ex = tmp(:,2);
r6g.em = tmp(:,3);

% loading fluorescence spectra of YOYO-1
filename = 'YOYO-1.csv';
tmp = csvread(filename,1);
yoyo.wavelength = tmp(:,1);
yoyo.ex = tmp(:,2);
yoyo.em = tmp(:,3);

% removing some temp variables from workspace
clear tmp filename
% This example will be quite easy because all spectra are synchronized,
% i.e. they have the same wavelength axis
assert(all(EGFP.wavelength == yoyo.wavelength))
assert(all(EGFP.wavelength == r6g.wavelength))

% plotting all together
figure(1)
plot(EGFP.wavelength,EGFP.em,'r','linewidth',2)
hold on
plot(r6g.wavelength,r6g.em,'b','linewidth',2)
plot(yoyo.wavelength,yoyo.em,'g','linewidth',2)
hold off
xlim([450 700])
legend({'EGFP','Rhodamine 6G','yoyo-1'})
% as you can see from the figure a mixture of EGFP/Rhodamine or
% YOYO/Rhodamine should be very easy to handle. Howeer, a mixture of
% EGFP/YOYO will be more difficult to unmix.

%% simulating a Rhodamine yoyo mixture
% simulated ratio
simYRrat = 3;
% waelength axis
waveLe = r6g.wavelength;
% perfect mix, no noise
emSpec = r6g.em + simYRrat .* yoyo.em;
% nomalized spec
emSpec = emSpec./max(emSpec);
% Add some constant background
emSpec = emSpec + 0.3;
% Scale to get some counts
emSpec = emSpec .* 1000;
% Add some poisson noise
emSpec = imnoise(uint16(emSpec),'poisson');
% cast back into double for our calculations
emSpec = double(emSpec);

% show how our simulated data looks like
figure(2)
plot(waveLe,emSpec)
title('YOYO Rhodamine mixture')
xlim([400 700])

%% Solve a system of linear equations, A*x = b. 
% where A are the separate spectrum and b is what what we measured
meas   = emSpec;
% shapes = [r6g.em, yoyo.em];
shapes = [r6g.em, yoyo.em, ones(length(meas),1)];
% find the coefficients that solve the system of equations
eps = mldivide(shapes,meas);
fit = shapes*eps;

% plot the result
figure(2)
plot(waveLe, meas,'color',[.3 .3 .3],'linewidth',2)
hold on
plot(waveLe, fit,'r','linewidth',1)
hold off
xlim([400 700])
title('YOYO Rhodamine mixture and Fit')

% write what we found and compare to simulated values
ratYR = eps(2)/eps(1);
fprintf('There is %.4f YOYO for each Rhodamine 6G \n', ratYR)
fprintf('Simulated ratio was: %.4f \n', simYRrat)

%% simulating a EGFP yoyo mixture
% for details on how we simulate look above
simYErat = 3;
waveLe = EGFP.wavelength;
emSpec = EGFP.em + simYErat .* yoyo.em;
emSpec = emSpec./max(emSpec);
emSpec = emSpec + 0.3;
emSpec = emSpec .* 1000;
emSpec = imnoise(uint16(emSpec),'poisson');
emSpec = double(emSpec);

% Solve a system of linear equations, A*x = b. where A are the spectra and
% b what we measured
meas   = emSpec;
shapes = [EGFP.em, yoyo.em, ones(length(meas),1)];
eps = mldivide(shapes,meas);
fit = shapes*eps;

% plot the results
figure(2)
plot(waveLe, meas,'color',[.3 .3 .3],'linewidth',2)
hold on
plot(waveLe, fit,'r','linewidth',1)
hold off
xlim([400 700])
title('YOYO EGFP mixture and Fit')

% write what we found and compare to simulated values
ratYE = eps(2)/eps(1);
fprintf('There is %.4f YOYO for each EGFP \n', ratYE)
fprintf('Simulated ratio was: %.4f \n', simYErat)

