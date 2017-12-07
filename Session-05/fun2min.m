function [RMSD, fitVal] = fun2min(params,rawData,doPlot)
% Function to minimize for the session-05 example, sine wave fitting.
%   Detailed explanation goes here

angRad = rawData.angles;
inVal  = rawData.values;
nVal   = length(inVal);

phaseRad = params(1);
ampl     = params(2);
freq     = params(3);

fitVal   = ampl.*sin(angRad.*freq +phaseRad);;

dev    = fitVal-inVal;
devSqr = (dev).^2;

RMSD = sqrt(sum(devSqr)/nVal);
if doPlot
    figure(69)
    plot(inVal,'k')
    hold on
    plot(fitVal,'b')
    plot(dev,'r')
    hold off
    title(['RMSD: ' num2str(RMSD)])
    shg
    drawnow
    pause(0.1)
end
end

