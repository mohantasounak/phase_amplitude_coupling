function [pp2] = plot_tort(confi, pp1, MI,  AAA)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
yylimit = confi.ylimit;
Pf1     = confi.pf1
Pf2     = confi.pf2
Af1     = confi.af1
Af2     = confi.af2

f = figure;
f.Position = [100 100 250 400];
pp2 = bar(10:20:720,  smoothdata(nanmean(pp1, 1)),'k')
xlim([0 720])
ylim(yylimit)
set(gca,'xtick',0:360:720)
xlabel('Phase (Deg)')
ylabel('Amplitude')
title({[sprintf('%s: phase of %d-%dHz to amp of %d-%dHz' , AAA, Pf1, Pf2, Af1, Af2)], ...
    ['MI = ' num2str(nanmean(MI))]});

end

